Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4285F54021C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343857AbiFGPHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245029AbiFGPHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:07:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746B31C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C9C2B81FD1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8933EC385A5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:07:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pgo/j+bD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654614433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vWufqBDrGEH9oinZg1h9f5R17E0LqWydN8JYgx2Xdps=;
        b=pgo/j+bDyXeqb0gNlutNsyNm4qrjzM5ZFYa0lUgtfN8x83mIODWIrWrdlrPuqkNcvhuE0B
        7X91zGZ9afnWq4w+S5P7eFTHgZxB90YNMBbwTXTPqmchy7oc9s1WKDwQsSTwmBwEWuije9
        Ntox4FGjC7tDo5fNAJvTv2vHFaIgldY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fa5a6a1a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 15:07:12 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: account for arch randomness in bits
Date:   Tue,  7 Jun 2022 17:07:03 +0200
Message-Id: <20220607150703.880856-1-Jason@zx2c4.com>
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

Rather than accounting in bytes and multiplying (shifting), we can just
account in bits and avoid the shift. The main motivation for this is
there are other patches in flux that expand this code a bit, and
avoiding the duplication of "* 8" everywhere makes things a bit clearer.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0d6fb3eaf609..60d701a2516b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -776,7 +776,7 @@ static struct notifier_block pm_notifier = { .notifier_call = random_pm_notifica
 int __init random_init(const char *command_line)
 {
 	ktime_t now = ktime_get_real();
-	unsigned int i, arch_bytes;
+	unsigned int i, arch_bits;
 	unsigned long entropy;
 
 #if defined(LATENT_ENTROPY_PLUGIN)
@@ -784,12 +784,12 @@ int __init random_init(const char *command_line)
 	_mix_pool_bytes(compiletime_seed, sizeof(compiletime_seed));
 #endif
 
-	for (i = 0, arch_bytes = BLAKE2S_BLOCK_SIZE;
+	for (i = 0, arch_bits = BLAKE2S_BLOCK_SIZE * 8;
 	     i < BLAKE2S_BLOCK_SIZE; i += sizeof(entropy)) {
 		if (!arch_get_random_seed_long_early(&entropy) &&
 		    !arch_get_random_long_early(&entropy)) {
 			entropy = random_get_entropy();
-			arch_bytes -= sizeof(entropy);
+			arch_bits -= sizeof(entropy) * 8;
 		}
 		_mix_pool_bytes(&entropy, sizeof(entropy));
 	}
@@ -801,8 +801,8 @@ int __init random_init(const char *command_line)
 	if (crng_ready())
 		crng_reseed();
 	else if (trust_cpu)
-		_credit_init_bits(arch_bytes * 8);
-	used_arch_random = arch_bytes * 8 >= POOL_READY_BITS;
+		_credit_init_bits(arch_bits);
+	used_arch_random = arch_bits >= POOL_READY_BITS;
 
 	WARN_ON(register_pm_notifier(&pm_notifier));
 
-- 
2.35.1

