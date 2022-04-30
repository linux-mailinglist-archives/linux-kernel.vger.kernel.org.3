Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DB551602E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244841AbiD3T74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 15:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiD3T7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:59:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948F360073
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 12:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 213026103E
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 19:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28209C385AA;
        Sat, 30 Apr 2022 19:56:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BzpsG3RV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651348588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b6Af4OOpFK/Su24y2p3YflxadfuAyDKNHUFJvEvTYDI=;
        b=BzpsG3RV8EPqSp7JPSka6uGkgTaqjHvGINn4UJZsRc6TkOjg5QDTY6ariGVbkIESjRYtwh
        X1JdmHWXuppo6RNhDxwev/GjksSmIPZ5JybDHZSbLWYydpWvCm9URm+jCJxA37U8BVrhmz
        zp1aDSY7tdlz0Mmzo0/0hvUOYxP3ogg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7a0393fe (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 30 Apr 2022 19:56:28 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: do not check for system_wq initialization in wait event
Date:   Sat, 30 Apr 2022 21:56:20 +0200
Message-Id: <20220430195620.2772485-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We previously checked for !system_wq, because when this was called at
boot time, it could wind up hitting credit_entropy_bits()->crng_reseed(),
which in turn would fire up numa pool initialization in a workqueue.
However, we've now gotten rid of those numa pools, and hence do not make
use of these workqueues during early init. So we can get rid of the
check.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Fixes: a9412d510ab9 ("random: get rid of secondary crngs")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 02e880a2c51e..77cee120974d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1162,9 +1162,8 @@ void add_hwgenerator_randomness(const void *buffer, size_t count,
 	 * CRNG_RESEED_INTERVAL has elapsed.
 	 */
 	wait_event_interruptible_timeout(random_write_wait,
-			!system_wq || kthread_should_stop() ||
-			input_pool.entropy_count < POOL_MIN_BITS,
-			CRNG_RESEED_INTERVAL);
+		kthread_should_stop() || input_pool.entropy_count < POOL_MIN_BITS,
+		CRNG_RESEED_INTERVAL);
 	mix_pool_bytes(buffer, count);
 	credit_entropy_bits(entropy);
 }
-- 
2.35.1

