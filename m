Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40F64EDC64
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiCaPJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiCaPJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DAE141441
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C97461A81
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6306AC340ED;
        Thu, 31 Mar 2022 15:07:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P9iJ3V1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648739235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SsoQyYP1xerwzpSW3ljUgm2O/4n9TmsrH1NONnjOLEw=;
        b=P9iJ3V1/L6PilLNSjeiYoKTghb7J20eC8sgPcCGStLaYq91L4GrQi5j+45aN4T4SdnXGL6
        /YGnLdBnXVUagSB5716GpDMAzZMxHfbR1xr1bqAONXz7PKuG5WsUR7SS5q9YOr4WwtP5ws
        wc7nha6Oh/iL5QQSsy1lJBHLv2ESZAM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fa1ad91e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 31 Mar 2022 15:07:15 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: mix build-time latent entropy into pool at init
Date:   Thu, 31 Mar 2022 11:07:06 -0400
Message-Id: <20220331150706.124075-1-Jason@zx2c4.com>
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

Prior, the "input_pool_data" array needed no real initialization, and so
it was easy to mark it with __latent_entropy to populate it during
compile-time. In switching to using a hash function, this required us to
specifically initialize it to some specific state, which means we
dropped the __latent_entropy attribute. An unfortunate side effect was
this meant the pool was no longer seeded using compile-time random data.
In order to bring this back, we declare an array in rand_initialize()
with __latent_entropy and call mix_pool_bytes() on that at init, which
accomplishes the same thing as before.

Fixes: 6e8ec2552c7d ("random: use computational hash for entropy extraction")
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 40107f8b9e9e..3a245686809c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -975,6 +975,11 @@ int __init rand_initialize(void)
 	bool arch_init = true;
 	unsigned long rv;
 
+#if defined(LATENT_ENTROPY_PLUGIN)
+	static u8 init_latent_entropy[BLAKE2S_BLOCK_SIZE] __latent_entropy;
+	_mix_pool_bytes(init_latent_entropy, sizeof(init_latent_entropy));
+#endif
+
 	for (i = 0; i < BLAKE2S_BLOCK_SIZE; i += sizeof(rv)) {
 		if (!arch_get_random_seed_long_early(&rv) &&
 		    !arch_get_random_long_early(&rv)) {
-- 
2.35.1

