Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BF04AE71A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbiBICmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242717AbiBIBUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:20:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289B5C061576;
        Tue,  8 Feb 2022 17:20:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1A6761763;
        Wed,  9 Feb 2022 01:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DEBC340EB;
        Wed,  9 Feb 2022 01:20:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LbVQ1yQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644369607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXavouTsQZ5PSiUPlPfFOTYKfyF5MOClkib1Muwy8ho=;
        b=LbVQ1yQaX0XnR9YA1TWG+hQ5BfXyK622xfHx3opb2x6tgbGo/jBw8JCMZIiyZIH0IxqsAz
        74ZIBN00RM21n2u3BktGY7PZusz0n8F35HH6Y3mj2VdNrO2JExH1plKxrhO6Oz6djsqIlJ
        LP0WUMCXroLlRqFUNCFoWJoGU6JMmpE=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 67f28a20 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 01:20:06 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, linux@dominikbrodowski.net, ebiggers@kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2 6/9] random: absorb fast pool into input pool after fast load
Date:   Wed,  9 Feb 2022 02:19:16 +0100
Message-Id: <20220209011919.493762-7-Jason@zx2c4.com>
In-Reply-To: <20220209011919.493762-1-Jason@zx2c4.com>
References: <20220209011919.493762-1-Jason@zx2c4.com>
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

During crng_init == 0, we never credit entropy in add_interrupt_
randomness(), but instead dump it directly into the base_crng. That's
fine, except for the fact that we then wind up throwing away that
entropy later when we switch to extracting from the input pool and
overwriting the base_crng key. The two other early init sites --
add_hwgenerator_randomness()'s use crng_fast_load() and add_device_
randomness()'s use of crng_slow_load() -- always additionally give their
inputs to the input pool. But not add_interrupt_randomness().

This commit fixes that shortcoming by calling mix_pool_bytes() after
crng_fast_load() in add_interrupt_randomness(). That's partially
verboten on PREEMPT_RT, where it implies taking spinlock_t from an IRQ
handler. But this also only happens during early boot and then never
again after that. Should this turn into a larger problem later for some
esoteric reason, we can always use `if (IS_ENABLED(PREEMPT_RT))` or
something similar to that. But for now, this should do.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Suggested-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 785a4545c9d7..20374bce9a07 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -864,6 +864,13 @@ void add_interrupt_randomness(int irq)
 		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
 			fast_pool->count = 0;
 			fast_pool->last = now;
+
+			/* Technically this call means that we're using a spinlock_t
+			 * in the IRQ handler, which isn't terrific for PREEMPT_RT.
+			 * However, this only happens during very early boot, and then
+			 * never again, so we live with it.
+			 */
+			mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
 		}
 		return;
 	}
-- 
2.35.0

