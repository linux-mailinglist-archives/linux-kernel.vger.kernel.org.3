Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC384B3883
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiBLXKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:10:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiBLXKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:10:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F2241995
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 15:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD28A60DEB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 23:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C29C340E7;
        Sat, 12 Feb 2022 23:10:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GvohszMn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644707439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0PYWzf/LonqCWyCOmLD/U3fj8lGO2iLic0hegNQyL0Y=;
        b=GvohszMnj9+masX2X1hmMdGe1Aa1dvuZtqCms3/b5ea/zA9U/Mqz4U15gIQMMhkB7pKdyh
        iH+njQWM2lGMaBVFv25KKRKDc3560t8qm5uBFgJCAfjfMKE8PgaysCQinDzXfle0bxsRvp
        NeRx6tHA70C7WnOVNhHKb1zJ5XVJVak=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5e48dabc (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 23:10:38 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/3] random: check for crng_init == 0, not crng_ready() in add_device_randomness()
Date:   Sun, 13 Feb 2022 00:10:21 +0100
Message-Id: <20220212231022.679926-3-Jason@zx2c4.com>
In-Reply-To: <20220212231022.679926-1-Jason@zx2c4.com>
References: <20220212231022.679926-1-Jason@zx2c4.com>
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

This has no real functional change, as crng_pre_init_inject() (and
before that, crng_slow_init()) always checks for == 0, not >= 2. So
correct the outer unlocked change to reflect that.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a128bb947bd4..9a8e1bb9845d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1007,7 +1007,7 @@ void add_device_randomness(const void *buf, size_t size)
 	unsigned long time = random_get_entropy() ^ jiffies;
 	unsigned long flags;
 
-	if (!crng_ready() && size)
+	if (crng_init == 0 && size)
 		crng_pre_init_inject(buf, size, false, false);
 
 	spin_lock_irqsave(&input_pool.lock, flags);
-- 
2.35.0

