Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7C4EDCC9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiCaP3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiCaP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC8C21BC64;
        Thu, 31 Mar 2022 08:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 523D961ADE;
        Thu, 31 Mar 2022 15:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D921C340ED;
        Thu, 31 Mar 2022 15:28:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DwM2QVqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648740481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyym09nEXYz1vXWaGFoZImcv0N4xudomjsRouLwVCy4=;
        b=DwM2QVqbYVkY7XhqfgI0zmYswv37XQd0+mcVx/kkeM9pTOt69bIUto5IDT4l4FWZ8SjmJI
        bfXjvJ6tZ/GNLay1m6nO0KKiWHtPK+NEQFeJA4j0M4bAX+9StqYV88sRYEGJDSh2d/OTYf
        xPp4tyIxl8WNEF1jT1K+LUyi3ikv5vQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9011b3a2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 31 Mar 2022 15:28:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2] random: mix build-time latent entropy into pool at init
Date:   Thu, 31 Mar 2022 11:26:41 -0400
Message-Id: <20220331152641.169301-1-Jason@zx2c4.com>
In-Reply-To: <20220331150706.124075-1-Jason@zx2c4.com>
References: <20220331150706.124075-1-Jason@zx2c4.com>
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
accomplishes the same thing as before. We make this __initconst, so that
it doesn't take up space at runtime after init.

Fixes: 6e8ec2552c7d ("random: use computational hash for entropy extraction")
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Use __initconst.

 drivers/char/random.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 40107f8b9e9e..1d8242969751 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -975,6 +975,11 @@ int __init rand_initialize(void)
 	bool arch_init = true;
 	unsigned long rv;
 
+#if defined(LATENT_ENTROPY_PLUGIN)
+	static const u8 compiletime_seed[BLAKE2S_BLOCK_SIZE] __initconst __latent_entropy;
+	_mix_pool_bytes(compiletime_seed, sizeof(compiletime_seed));
+#endif
+
 	for (i = 0; i < BLAKE2S_BLOCK_SIZE; i += sizeof(rv)) {
 		if (!arch_get_random_seed_long_early(&rv) &&
 		    !arch_get_random_long_early(&rv)) {
-- 
2.35.1

