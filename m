Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5B524E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354485AbiELNis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354497AbiELNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:38:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13A25471B;
        Thu, 12 May 2022 06:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF8C0B8262A;
        Thu, 12 May 2022 13:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363E4C385B8;
        Thu, 12 May 2022 13:38:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HshUXI8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652362719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UhB7tj2ErehCBMfKm8jUsi+ZyObxONkIjZvlx/ugygg=;
        b=HshUXI8r0zQCZOf+Mn8g5cx0ceHDf8af6wjWM0Nl6jktJ3P4DKwK6N2xkKjuxaDjRygETx
        Wajbpx2fbJTi348m23LCimUnMZPDGJUJFGjjaEiIg7BgbvJZ2vJsXfBxxC2pgZqm3LE9tN
        v2dC2l7y7de2cTEZxANWaydiGQAfKKM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a6ef1a12 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 12 May 2022 13:38:38 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: credit architectural init the exact amount
Date:   Thu, 12 May 2022 15:38:35 +0200
Message-Id: <20220512133835.102028-1-Jason@zx2c4.com>
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

RDRAND and RDSEED can fail sometimes, which is fine. We currently
initialize the RNG with 512 bits of RDRAND/RDSEED. We only need 256 bits
of those to succeed in order to initialize the RNG. Instead of the
current "all or nothing" approach, actually credit these contributions
the amount that is actually contributed.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bd80d74a7f8c..9ffa41c5e092 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -934,9 +934,8 @@ static struct notifier_block pm_notifier = { .notifier_call = random_pm_notifica
  */
 int __init random_init(const char *command_line)
 {
-	size_t i;
 	ktime_t now = ktime_get_real();
-	bool arch_init = true;
+	unsigned int i, arch_init;
 	unsigned long rv;
 
 #if defined(LATENT_ENTROPY_PLUGIN)
@@ -944,11 +943,12 @@ int __init random_init(const char *command_line)
 	_mix_pool_bytes(compiletime_seed, sizeof(compiletime_seed));
 #endif
 
-	for (i = 0; i < BLAKE2S_BLOCK_SIZE; i += sizeof(rv)) {
+	for (i = 0, arch_init = BLAKE2S_BLOCK_SIZE;
+	     i < BLAKE2S_BLOCK_SIZE; i += sizeof(rv)) {
 		if (!arch_get_random_seed_long_early(&rv) &&
 		    !arch_get_random_long_early(&rv)) {
 			rv = random_get_entropy();
-			arch_init = false;
+			arch_init -= sizeof(rv);
 		}
 		_mix_pool_bytes(&rv, sizeof(rv));
 	}
@@ -968,8 +968,8 @@ int __init random_init(const char *command_line)
 
 		/* Immediately use the above architectural contributions. */
 		crng_reseed();
-	} else if (arch_init && trust_cpu)
-		credit_init_bits(BLAKE2S_BLOCK_SIZE * 8);
+	} else if (trust_cpu)
+		credit_init_bits(arch_init * 8);
 
 	WARN_ON(register_pm_notifier(&pm_notifier));
 
-- 
2.35.1

