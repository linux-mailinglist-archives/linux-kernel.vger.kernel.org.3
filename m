Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CF749D0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbiAZRk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242787AbiAZRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:40:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F7C06173B;
        Wed, 26 Jan 2022 09:40:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r126so207709wma.0;
        Wed, 26 Jan 2022 09:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5oRlbCcuicawzmgkV2o23hXqFPfzRu0vAZKHNtEWHR4=;
        b=Um3pXARJ4BeIUASj5MVYQFWIDYheSA0/iyk2kg6Ald8PuvizCvYXjWH9ueH8Lr3wAp
         bJQVHuA50D4XcAH5yCPoLIIi+DfaGC6PNrfjvOPPunfrQE1XInz/cTfB1840hs6MIOy/
         /IcLzE+vfKbKQewLcT9U63WfFujfd+XPkJ5w1R0BKSJx+QI1a3dBc47TSpvc1a2shg7X
         L2gqR2E2KY8WRizNQiOvhdkm8zjL9KDfNuIvnwvyw/YFDn9tT6djVJdgWQjUdwgGlAIo
         m7z9RFFBnnJwFKx+T5xvEUlRq1HskkDrYzQscHC9/YUNNYY2GR24e3jkAWhtUtrfcswO
         23kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5oRlbCcuicawzmgkV2o23hXqFPfzRu0vAZKHNtEWHR4=;
        b=ODs+NrmmY18EMnWc71YzD4Y6nPem8koXrCUHCp9UOciMk3UwORhtljjE4tfEtNMACI
         22dG1eapDfExHScbYSqEVH3SI4lIDOI2q0PiSaXBd5S7JIxOjE9jZreMfFbBHL380lm9
         H4MyGAscaVg3S43KMeoIHTcg0i0OaABGbmKCj72tVB3TRruH4bBo/ZQyBXpH0pD+X7fH
         snYJKTbH7RyX6gyhzEvQLEgxA6SHxCQLm6ktQBr2OdZbZvLyYJsFHwJlzdnMK8GyjxAU
         Oz7YXi1cuaTVB1xf5yhiNxaeD5ty0VqQo63YM8kJEnx1CJ2H3X2m4SefSOE9hE+IdyKC
         HtbA==
X-Gm-Message-State: AOAM532n7KKGr/lgCHksYRS64T+8XF6KK9rXysE472hiaNx273tPTVvG
        6eoBELSjTqIivEupJSkFMUyMe3m3pF8=
X-Google-Smtp-Source: ABdhPJxG3a1trYRqQTea9U6xrUaHjElX/WeUanUrRG26TBzTxOSpOMv1rNIeYdZS5FOCJid/XpXsAA==
X-Received: by 2002:a05:600c:5107:: with SMTP id o7mr8463573wms.161.1643218823040;
        Wed, 26 Jan 2022 09:40:23 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y2sm3498451wmj.13.2022.01.26.09.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:40:22 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] clk: starfive: jh7100: Don't round divisor up twice
Date:   Wed, 26 Jan 2022 18:39:47 +0100
Message-Id: <20220126173953.1016706-2-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126173953.1016706-1-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is best illustrated by an example. Suppose a consumer wants
a 4MHz clock rate from a divider with a 10MHz parent. It would then
call

  clk_round_rate(clk, 4000000)

which would call into our determine_rate() callback that correctly
rounds up and finds that a divisor of 3 gives the highest possible
frequency below the requested 4MHz and returns 10000000 / 3 = 3333333Hz.

However the consumer would then call

  clk_set_rate(clk, 3333333)

but since 3333333 doesn't divide 10000000 evenly our set_rate() callback
would again round the divisor up and set it to 4 which results in an
unnecessarily low rate of 2.5MHz.

Fix it by using DIV_ROUND_CLOSEST in the set_rate() callback.

Fixes: 4210be668a09 ("clk: starfive: Add JH7100 clock generator driver")
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/clk/starfive/clk-starfive-jh7100.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 25d31afa0f87..db6a4dc203af 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -399,22 +399,13 @@ static unsigned long jh7100_clk_recalc_rate(struct clk_hw *hw,
 	return div ? parent_rate / div : 0;
 }
 
-static unsigned long jh7100_clk_bestdiv(struct jh7100_clk *clk,
-					unsigned long rate, unsigned long parent)
-{
-	unsigned long max = clk->max_div;
-	unsigned long div = DIV_ROUND_UP(parent, rate);
-
-	return min(div, max);
-}
-
 static int jh7100_clk_determine_rate(struct clk_hw *hw,
 				     struct clk_rate_request *req)
 {
 	struct jh7100_clk *clk = jh7100_clk_from(hw);
 	unsigned long parent = req->best_parent_rate;
 	unsigned long rate = clamp(req->rate, req->min_rate, req->max_rate);
-	unsigned long div = jh7100_clk_bestdiv(clk, rate, parent);
+	unsigned long div = min_t(unsigned long, DIV_ROUND_UP(parent, rate), clk->max_div);
 	unsigned long result = parent / div;
 
 	/*
@@ -442,7 +433,8 @@ static int jh7100_clk_set_rate(struct clk_hw *hw,
 			       unsigned long parent_rate)
 {
 	struct jh7100_clk *clk = jh7100_clk_from(hw);
-	unsigned long div = jh7100_clk_bestdiv(clk, rate, parent_rate);
+	unsigned long div = clamp(DIV_ROUND_CLOSEST(parent_rate, rate),
+				  1UL, (unsigned long)clk->max_div);
 
 	jh7100_clk_reg_rmw(clk, JH7100_CLK_DIV_MASK, div);
 	return 0;
-- 
2.34.1

