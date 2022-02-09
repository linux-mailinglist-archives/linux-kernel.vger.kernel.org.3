Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3154AF8A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbiBIRpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiBIRpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:45:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B48C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:45:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C6F61AFB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2472C340E7;
        Wed,  9 Feb 2022 17:45:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F7r6o867"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644428711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pRmKQrpG8Tp34SkPHizbt62a5hV7IZXO+3FlLtGN16M=;
        b=F7r6o867kDHVv7QPQow5ur+Cp3gWjCoHhRuq94k4Cp1eRXB/Uw9BvTwzuYH5xyS2ccEcKW
        V3bWhLmY1H0ty5D9zKus0+H7LUmkvTo51k36fAWgcnxozwXpqWFmsELPf+QqIMHqOveVoV
        7BKP1e9991Jpr07l48BZCX/RA/rN3Ns=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1cee3b28 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 17:45:10 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: [PATCH] random: zero buffer after reading secret entropy from userspace
Date:   Wed,  9 Feb 2022 18:44:56 +0100
Message-Id: <20220209174456.644232-1-Jason@zx2c4.com>
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

This buffer may contain entropic data that shouldn't stick around longer
than needed, zero it out our temporary buffer at the end of
write_pool().

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 81cfbbf5f462..9c7a0297a7d4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1357,19 +1357,24 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 static int write_pool(const char __user *ubuf, size_t count)
 {
 	size_t len;
+	int ret = 0;
 	u8 block[BLAKE2S_BLOCK_SIZE];
 
 	while (count) {
 		len = min(count, sizeof(block));
-		if (copy_from_user(block, ubuf, len))
-			return -EFAULT;
+		if (copy_from_user(block, ubuf, len)) {
+			ret = -EFAULT;
+			goto out;
+		}
 		count -= len;
 		ubuf += len;
 		mix_pool_bytes(block, len);
 		cond_resched();
 	}
 
-	return 0;
+out:
+	memzero_explicit(block, sizeof(block));
+	return ret;
 }
 
 static ssize_t random_write(struct file *file, const char __user *buffer,
-- 
2.35.0

