Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B464F8B1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiDGXih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiDGXib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:38:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806114B873
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:36:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 389ACB829AE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C49C385A0;
        Thu,  7 Apr 2022 23:36:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oPAyUYdx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649374582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/oJ/z2jjF9yKf+0yz98/oEb//RMsOp8WmTEy4bbiSGc=;
        b=oPAyUYdxkI6FJnYItYHUWQAXW6HSgNTYQfMmcgp27ZkPxdxQ9GSj0H9X8zmTKwRtsjFceJ
        1oIXhytwD2CHyEt5q//ZXkhZ3WNVAkssJ02sbu6ZmPfZCY3lXQetOnk1oBj/qZ5ltaYcez
        pUHodnXYFkbMQ7H5DXNV0StJQcrd/vI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4d99eea8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 7 Apr 2022 23:36:22 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Cc:     tytso@mit.edu, sultan@kerneltoast.com,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v2] random: allow partial reads if later user copies fail
Date:   Fri,  8 Apr 2022 01:35:58 +0200
Message-Id: <20220407233558.3369-1-Jason@zx2c4.com>
In-Reply-To: <20220407193433.523299-1-Jason@zx2c4.com>
References: <20220407193433.523299-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than failing entirely if a copy_to_user() fails at some point,
instead we should return a partial read for the amount that succeeded
prior, unless none succeeded at all, in which case we return -EFAULT as
before.

This makes it consistent with other reader interfaces. For example, the
following snippet for /dev/zero outputs "4" followed by "1":

  int fd;
  void *x = mmap(NULL, 4096, PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
  assert(x != MAP_FAILED);
  fd = open("/dev/zero", O_RDONLY);
  assert(fd >= 0);
  printf("%zd\n", read(fd, x, 4));
  printf("%zd\n", read(fd, x + 4095, 4));
  close(fd);

This brings that same standard behavior to the various RNG reader
interfaces.

While we're at it, we can streamline the loop logic a little bit.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Do partial copies within individual blocks, not just per-block, also
  following how /dev/zero and ordinary filesystem files work.

 drivers/char/random.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e15063d61460..df43c5060f00 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -523,8 +523,7 @@ EXPORT_SYMBOL(get_random_bytes);
 
 static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 {
-	ssize_t ret = 0;
-	size_t len;
+	size_t len, left, ret = 0;
 	u32 chacha_state[CHACHA_STATE_WORDS];
 	u8 output[CHACHA_BLOCK_SIZE];
 
@@ -543,37 +542,40 @@ static ssize_t get_random_bytes_user(void __user *buf, size_t nbytes)
 	 * the user directly.
 	 */
 	if (nbytes <= CHACHA_KEY_SIZE) {
-		ret = copy_to_user(buf, &chacha_state[4], nbytes) ? -EFAULT : nbytes;
+		ret = nbytes - copy_to_user(buf, &chacha_state[4], nbytes);
 		goto out_zero_chacha;
 	}
 
-	do {
+	for (;;) {
 		chacha20_block(chacha_state, output);
 		if (unlikely(chacha_state[12] == 0))
 			++chacha_state[13];
 
 		len = min_t(size_t, nbytes, CHACHA_BLOCK_SIZE);
-		if (copy_to_user(buf, output, len)) {
-			ret = -EFAULT;
+		left = copy_to_user(buf, output, len);
+		if (left) {
+			ret += len - left;
 			break;
 		}
 
-		nbytes -= len;
 		buf += len;
 		ret += len;
+		nbytes -= len;
+		if (!nbytes)
+			break;
 
 		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
-		if (!(ret % PAGE_SIZE) && nbytes) {
+		if (ret % PAGE_SIZE == 0) {
 			if (signal_pending(current))
 				break;
 			cond_resched();
 		}
-	} while (nbytes);
+	}
 
 	memzero_explicit(output, sizeof(output));
 out_zero_chacha:
 	memzero_explicit(chacha_state, sizeof(chacha_state));
-	return ret;
+	return ret ? ret : -EFAULT;
 }
 
 /*
-- 
2.35.1

