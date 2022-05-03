Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CBE518D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiECTza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiECTz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:55:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9183F30B;
        Tue,  3 May 2022 12:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC735B81EAD;
        Tue,  3 May 2022 19:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA4DC385A4;
        Tue,  3 May 2022 19:51:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qGnTUWTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651607509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BxpYESRIKwi1auTgh5eHR9+TmwXL9lpEEEIwRD9mk/4=;
        b=qGnTUWTZg5FvW5bMKcItP4+AtWV8VClks/DbJqpTfqqUrCZDZiQjdQwjs42ZJxmjt/2qL1
        BDhfuLlxprWjB2WWFdpR7BnI6+QbA4/gXEWu9gbm4XABLr5dG1ICyICAql/ZBathdG9Kmi
        655ZkBgTWX+5Q96U4ReGa1tf34mk+9A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 394072c4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 3 May 2022 19:51:49 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: mix hwgenerator randomness before sleeping
Date:   Tue,  3 May 2022 21:51:41 +0200
Message-Id: <20220503195141.683217-1-Jason@zx2c4.com>
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

The add_hwgenerator_randomness() function is called in a loop from a
kthread by the hwgenerator core. It's supposed to sleep when there's
nothing to do, and wake up periodically for more entropy. Right now it
receives entropy, sleeps, and then mixes it in. This commit reverses the
order, so that it always mixes in entropy sooner and sleeps after. This
way the entropy is more fresh.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 845f610b6611..d4eae4b167b4 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1154,6 +1154,9 @@ void rand_initialize_disk(struct gendisk *disk)
 void add_hwgenerator_randomness(const void *buffer, size_t count,
 				size_t entropy)
 {
+	mix_pool_bytes(buffer, count);
+	credit_entropy_bits(entropy);
+
 	/*
 	 * Throttle writing if we're above the trickle threshold.
 	 * We'll be woken up again once below POOL_MIN_BITS, when
@@ -1164,8 +1167,6 @@ void add_hwgenerator_randomness(const void *buffer, size_t count,
 			!system_wq || kthread_should_stop() ||
 			input_pool.entropy_count < POOL_MIN_BITS,
 			CRNG_RESEED_INTERVAL);
-	mix_pool_bytes(buffer, count);
-	credit_entropy_bits(entropy);
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 
-- 
2.35.1

