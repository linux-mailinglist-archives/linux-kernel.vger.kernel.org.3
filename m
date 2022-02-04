Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2117A4A91C1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356302AbiBDAxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiBDAxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:53:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBFDC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 16:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A3DAB83625
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 00:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD2CC340E8;
        Fri,  4 Feb 2022 00:53:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T3/kD53Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643936020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uKFk+vFcUg3aqrCxmh17gVpNmWGCDQdqig8p98PcVKQ=;
        b=T3/kD53Q/cO+WsgDkaV3c+mjjX/g1wvbXRRC+3ICPtbX/JvRLjJVs3/vQ5ukfgeC16/e2F
        030RULvYvXwYnl/MWbvT4trcPyWG4l1PQDLFCwdoaz6AbYIfb/DW0sGxtIgra1SgZtb/mS
        AD9ZAI2bsicP1dX6mbZ6ni4iAxPOO2g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1986c36f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 4 Feb 2022 00:53:40 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH] random: make credit_entropy_bits always safe
Date:   Fri,  4 Feb 2022 01:53:31 +0100
Message-Id: <20220204005331.67034-1-Jason@zx2c4.com>
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
index a1c681a616a6..7576a8b53c57 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -525,18 +525,15 @@ static void process_random_ready_list(void)
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
@@ -548,18 +545,6 @@ static void credit_entropy_bits(int nbits)
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
@@ -1606,7 +1591,10 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
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
@@ -1619,7 +1607,8 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
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

