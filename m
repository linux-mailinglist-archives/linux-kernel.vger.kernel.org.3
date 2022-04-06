Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D5F4F5628
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444853AbiDFFyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455683AbiDFFHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 01:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563E340891;
        Tue,  5 Apr 2022 17:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85B8E6174A;
        Wed,  6 Apr 2022 00:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A13C385A6;
        Wed,  6 Apr 2022 00:51:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hIYaCWog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649206280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uouxkXGt9ycAh2w6r1rTvJWeUR8k4JberlBMTjKHJDU=;
        b=hIYaCWog3ufYJF8fi+Nqrc/DStqXujrKuPnBerdcQRO+fmFdXQ2WISfN62Wfz4+Nl+CQI1
        2gQAsgz3a+onmtIL1apt2OygDKTHH+mrbuEkt4OZ5VgTluoZgjCYiEOmQMuFc6Obcc66Ua
        1KM/qFhTZYs0b59EKnMN4G5wE4q+Rc4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4753b291 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 6 Apr 2022 00:51:20 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: check for signals every PAGE_SIZE chunk of /dev/[u]random
Date:   Wed,  6 Apr 2022 02:51:01 +0200
Message-Id: <20220406005101.200148-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a651a7ba294c ("random: check for signal_pending() outside of
need_resched() check"), Jann pointed out that we previously were only
checking the TIF_NOTIFY_SIGNAL and TIF_SIGPENDING flags if the process
had TIF_NEED_RESCHED set, which meant in practice, super long reads to
/dev/[u]random would delay signal handling by a long time. I tried this,
and indeed I wasn't able to interrupt a /dev/urandom read until after
several megabytes had been read. The bug he fixed has always been there,
and so code that reads from /dev/urandom without checking the return
value of read() has mostly worked for a long time, for most sizes, not
just for <= 256.

Maybe it makes sense to keep that code working. The reason it was so
small prior, ignoring the fact that it didn't work anyway, was likely
because /dev/random used to block, and that could happen for pretty
large lengths of time while entropy was gathered. But now, it's just a
chacha20 call, which is extremely fast and is just operating on pure
data, without having to wait for some external event. In that sense,
/dev/[u]random is a lot more like /dev/zero.

Taking a page out of /dev/zero's read_zero() function, it always returns
at least one chunk, and then checks for signals after each chunk. Chunk
sizes there are of length PAGE_SIZE. Let's just copy the same thing for
/dev/[u]random, and check for signals and cond_resched() for every
PAGE_SIZE amount of data. This makes the behavior more consistent with
expectations, and should mitigate the impact of Jann's fix for the
age-old signal check bug.

Cc: Jann Horn <jannh@google.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7f0253455d4e..e8a578af619a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -523,7 +523,6 @@ EXPORT_SYMBOL(get_random_bytes);
 
 static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 {
-	bool large_request = nbytes > 256;
 	ssize_t ret = 0;
 	size_t len;
 	u32 chacha_state[CHACHA_STATE_WORDS];
@@ -540,15 +539,6 @@ static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 	crng_make_state(chacha_state, (u8 *)&chacha_state[4], CHACHA_KEY_SIZE);
 
 	do {
-		if (large_request) {
-			if (signal_pending(current)) {
-				if (!ret)
-					ret = -ERESTARTSYS;
-				break;
-			}
-			cond_resched();
-		}
-
 		chacha20_block(chacha_state, output);
 		if (unlikely(chacha_state[12] == 0))
 			++chacha_state[13];
@@ -562,6 +552,13 @@ static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 		nbytes -= len;
 		buf += len;
 		ret += len;
+
+		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
+		if (!(ret % PAGE_SIZE) && nbytes) {
+			if (signal_pending(current))
+				break;
+			cond_resched();
+		}
 	} while (nbytes);
 
 	memzero_explicit(chacha_state, sizeof(chacha_state));
-- 
2.35.1

