Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63C54ADDAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382318AbiBHPyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380361AbiBHPyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:54:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5955C061576;
        Tue,  8 Feb 2022 07:54:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E781B81BC2;
        Tue,  8 Feb 2022 15:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F1AC004E1;
        Tue,  8 Feb 2022 15:54:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cms9AXVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644335649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3vijYymYJ1hV/XdaO0shzH+kc8Al+CbQUsKrgDFf33k=;
        b=cms9AXVgnXTyC/hzNu7Xf08Mip9NrgN5O0j4KPV4hytC8ddX3uTSkj1NQSif5s+ARh0sUj
        YX/FBwXU2++6jMG5wYCAn08kOQ5b1UIk4x8S6NS+7JE4khjvnUCWGEGLg09lHs5QNlFFt5
        lx9A2PjkEblsAtWploGkwYREIoMXK5U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0545e3c2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 8 Feb 2022 15:54:09 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v1 5/7] random: do not xor RDRAND when writing into /dev/random
Date:   Tue,  8 Feb 2022 16:53:33 +0100
Message-Id: <20220208155335.378318-6-Jason@zx2c4.com>
In-Reply-To: <20220208155335.378318-1-Jason@zx2c4.com>
References: <20220208155335.378318-1-Jason@zx2c4.com>
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

Continuing the reasoning of "random: ensure early RDSEED goes through
mixer on init", we don't want RDRAND interacting with anything without
going through the mixer function, as a backdoored CPU could presumably
cancel out data during an xor, which it'd have a harder time doing when
being forced through a cryptographic hash function. There's actually no
need at all to be calling RDRAND in write_pool(), because before we
extract from the pool, we always do so with 32 bytes of RDSEED hashed in
at that stage. Xoring at this stage is needless and introduces a minor
liability.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2bd19dce822d..ed7fcef1ba31 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1315,25 +1315,15 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 static int write_pool(const char __user *buffer, size_t count)
 {
 	size_t bytes;
-	u32 t, buf[16];
+	u8 buf[BLAKE2S_BLOCK_SIZE];
 	const char __user *p = buffer;
 
 	while (count > 0) {
-		int b, i = 0;
-
 		bytes = min(count, sizeof(buf));
-		if (copy_from_user(&buf, p, bytes))
+		if (copy_from_user(buf, p, bytes))
 			return -EFAULT;
-
-		for (b = bytes; b > 0; b -= sizeof(u32), i++) {
-			if (!arch_get_random_int(&t))
-				break;
-			buf[i] ^= t;
-		}
-
 		count -= bytes;
 		p += bytes;
-
 		mix_pool_bytes(buf, bytes);
 		cond_resched();
 	}
-- 
2.35.0

