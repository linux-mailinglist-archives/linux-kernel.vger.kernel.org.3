Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FA54A9A65
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359144AbiBDNyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359151AbiBDNyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:54:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD0AC06173E;
        Fri,  4 Feb 2022 05:54:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D29D61C7B;
        Fri,  4 Feb 2022 13:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195B3C004E1;
        Fri,  4 Feb 2022 13:54:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ho41945Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643982843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/MZ0szVCJI5WG41iXnMXaDPepbBJDhAp6vkKsxIFLE=;
        b=Ho41945YOfu9aR7VScAYHRaF2YGdzeGDmaElj3B8pgmfAREvG0C2zPLgkCbgsJS4us+2DN
        yjX9mfpLoh7Gij8thDP38uxHyTTHgLk8VPqIhGVqjdlawipw0d0TeKE8EvwmA/ON+cxg2V
        x9KO+LeoUKzCxyjKMKQtCkSmB5nURdc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4991711c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 4 Feb 2022 13:54:03 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH v2 4/4] random: make credit_entropy_bits() always safe
Date:   Fri,  4 Feb 2022 14:53:25 +0100
Message-Id: <20220204135325.8327-5-Jason@zx2c4.com>
In-Reply-To: <20220204135325.8327-1-Jason@zx2c4.com>
References: <20220204135325.8327-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is called from various hwgenerator drivers, so rather than having
one "safe" version for userspace and one "unsafe" version for the
kernel, just make everything safe; the checks are cheap and sensible to
have anyway.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b4798a3f7bf6..455615ac169a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -453,18 +453,15 @@ static void process_random_ready_list(void)
 	spin_unlock_irqrestore(&random_ready_list_lock, flags);
 }
 
-/*
- * Credit (or debit) the entropy store with n bits of entropy.
- * Use credit_entropy_bits_safe() if the value comes from userspace
- * or otherwise should be checked for extreme values.
- */
 static void credit_entropy_bits(int nbits)
 {
 	int entropy_count, orig;
 
-	if (!nbits)
+	if (nbits <= 0)
 		return;
 
+	nbits = min(nbits, POOL_BITS);
+
 	do {
 		entropy_count = orig = READ_ONCE(input_pool.entropy_count);
 		entropy_count = min(POOL_BITS, entropy_count + nbits);
@@ -476,18 +473,6 @@ static void credit_entropy_bits(int nbits)
 		crng_reseed(&primary_crng, true);
 }
 
-static int credit_entropy_bits_safe(int nbits)
-{
-	if (nbits < 0)
-		return -EINVAL;
-
-	/* Cap the value to avoid overflows */
-	nbits = min(nbits, POOL_BITS);
-
-	credit_entropy_bits(nbits);
-	return 0;
-}
-
 /*********************************************************************
  *
  * CRNG using CHACHA20
@@ -1534,7 +1519,10 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EPERM;
 		if (get_user(ent_count, p))
 			return -EFAULT;
-		return credit_entropy_bits_safe(ent_count);
+		if (ent_count < 0)
+			return -EINVAL;
+		credit_entropy_bits(ent_count);
+		return 0;
 	case RNDADDENTROPY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
@@ -1547,7 +1535,8 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		retval = write_pool((const char __user *)p, size);
 		if (retval < 0)
 			return retval;
-		return credit_entropy_bits_safe(ent_count);
+		credit_entropy_bits(ent_count);
+		return 0;
 	case RNDZAPENTCNT:
 	case RNDCLEARPOOL:
 		/*
-- 
2.35.0

