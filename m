Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF04749D0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbiAZRka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiAZRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:40:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879F0C06161C;
        Wed, 26 Jan 2022 09:40:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e2so377294wra.2;
        Wed, 26 Jan 2022 09:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tl4SIasnSRxHkt3WYvHnABfPkkQKhQcnDNKteJh15Ao=;
        b=caiVHLH9/PmiyKUBq68GYt0VH98DhsfO90VvOoCHXrO67R3OAv8RhgEkfCboaUpY73
         SteZU7vgnznVW3ExBCTDwLWHwoC8uAIkC5AOCCdPP5hRXqTkLXjFkSeN8Xxm/uIzead/
         v0QPKLCwtMOp0OJAPe0TUXoFepHLbw9XvDWAaMpWgm1JSXaME7TCJW2w3wa5kwzgea3k
         bBcU/SkXBIFVAgxUagLVQdNi2PF/QwxVIP8Izuw7H37rWBExRkwnftT5tbXNRaxos13e
         lwtk241sQdvWCq30sIXuophKtI5e33ZaDhyDqT5ovlr5YxbD+8lcEXpLx0fhfUheo01R
         uVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Tl4SIasnSRxHkt3WYvHnABfPkkQKhQcnDNKteJh15Ao=;
        b=XPqYjcgDdEe3kc9jNW42iKdl3rbpURT/hbyq9N30XJLPvSo7bGl5gOwo+X7xlaegke
         n099hWtb/IaSrsAV90rOyYhJsvhGYh6O9yP6/1Ylzi4203uKFsv7MUuZ9mdVt7lOI8Xr
         y/QMqvQnHVW8gmw5uywFmJnAe19y2Q5ifaRqjHhQ+HQYCYemFi4dQ+o9UPgQ0IYdD+M8
         kcGkDd1MIpV01wdZN5ZaeWMHfj6DMGCdj34xRkoaeK73MHpYaCI5bC14PJpt7JJBdgGB
         SCq6GxhGKcR4shaWxHmDODHiGaSp6ELS9fr1OGrGv4PRgtG9PXEdJd8DnZw3ZwF+960d
         L+pw==
X-Gm-Message-State: AOAM5317HlBL93qEYU/RBnr41UMciEA56uaxe+MS1I+ct8qosxc89ErP
        u/km5zCzWaBJHSY9Z4zZJN0PmspvT9A=
X-Google-Smtp-Source: ABdhPJwLYiHN/GLiTxXDr1bcSGqm0HCx4aQ/CpoO+X6pTfms3Y3DyacTdQxgaaULeVx2sQplFMLeKA==
X-Received: by 2002:a05:6000:186b:: with SMTP id d11mr10090022wri.3.1643218824136;
        Wed, 26 Jan 2022 09:40:24 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y2sm3498451wmj.13.2022.01.26.09.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:40:23 -0800 (PST)
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
Subject: [PATCH v1 2/7] clk: starfive: jh7100: Handle audio_div clock properly
Date:   Wed, 26 Jan 2022 18:39:48 +0100
Message-Id: <20220126173953.1016706-3-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126173953.1016706-1-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out the audio_div clock is a fractional divider where the
lowest byte of the ctrl register is the integer part of the divider and
the 2nd byte is the number of 100th added to the divider.

The children of this clock is used by the audio peripherals for their
sample rate clock, so round to the closest possible rate rather than
always rounding down like regular dividers.

Fixes: 4210be668a09 ("clk: starfive: Add JH7100 clock generator driver")
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/clk/starfive/clk-starfive-jh7100.c | 68 +++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index db6a4dc203af..4b59338b5d7d 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -32,6 +32,13 @@
 #define JH7100_CLK_MUX_MASK	GENMASK(27, 24)
 #define JH7100_CLK_MUX_SHIFT	24
 #define JH7100_CLK_DIV_MASK	GENMASK(23, 0)
+#define JH7100_CLK_FRAC_MASK	GENMASK(15, 8)
+#define JH7100_CLK_FRAC_SHIFT	8
+#define JH7100_CLK_INT_MASK	GENMASK(7, 0)
+
+/* fractional divider min/max */
+#define JH7100_CLK_FRAC_MIN	100UL
+#define JH7100_CLK_FRAC_MAX	25599UL
 
 /* clock data */
 #define JH7100_GATE(_idx, _name, _flags, _parent) [_idx] = {		\
@@ -55,6 +62,13 @@
 	.parents = { [0] = _parent },					\
 }
 
+#define JH7100_FDIV(_idx, _name, _parent) [_idx] = {			\
+	.name = _name,							\
+	.flags = 0,							\
+	.max = JH7100_CLK_FRAC_MAX,					\
+	.parents = { [0] = _parent },					\
+}
+
 #define JH7100__MUX(_idx, _name, _nparents, ...) [_idx] = {		\
 	.name = _name,							\
 	.flags = 0,							\
@@ -225,7 +239,7 @@ static const struct {
 	JH7100__MUX(JH7100_CLK_USBPHY_25M, "usbphy_25m", 2,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_USBPHY_PLLDIV25M),
-	JH7100__DIV(JH7100_CLK_AUDIO_DIV, "audio_div", 131072, JH7100_CLK_AUDIO_ROOT),
+	JH7100_FDIV(JH7100_CLK_AUDIO_DIV, "audio_div", JH7100_CLK_AUDIO_ROOT),
 	JH7100_GATE(JH7100_CLK_AUDIO_SRC, "audio_src", 0, JH7100_CLK_AUDIO_DIV),
 	JH7100_GATE(JH7100_CLK_AUDIO_12288, "audio_12288", 0, JH7100_CLK_OSC_AUD),
 	JH7100_GDIV(JH7100_CLK_VIN_SRC, "vin_src", 0, 4, JH7100_CLK_VIN_ROOT),
@@ -440,6 +454,49 @@ static int jh7100_clk_set_rate(struct clk_hw *hw,
 	return 0;
 }
 
+static unsigned long jh7100_clk_frac_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct jh7100_clk *clk = jh7100_clk_from(hw);
+	u32 reg = jh7100_clk_reg_get(clk);
+	unsigned long div100 = 100 * (reg & JH7100_CLK_INT_MASK) +
+			       ((reg & JH7100_CLK_FRAC_MASK) >> JH7100_CLK_FRAC_SHIFT);
+
+	return (div100 >= JH7100_CLK_FRAC_MIN) ? 100 * parent_rate / div100 : 0;
+}
+
+static int jh7100_clk_frac_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
+{
+	unsigned long parent100 = 100 * req->best_parent_rate;
+	unsigned long rate = clamp(req->rate, req->min_rate, req->max_rate);
+	unsigned long div100 = clamp(DIV_ROUND_CLOSEST(parent100, rate),
+				     JH7100_CLK_FRAC_MIN, JH7100_CLK_FRAC_MAX);
+	unsigned long result = parent100 / div100;
+
+	/* clamp the result as in jh7100_clk_determine_rate() above */
+	if (result > req->max_rate && div100 < JH7100_CLK_FRAC_MAX)
+		result = parent100 / (div100 + 1);
+	if (result < req->min_rate && div100 > JH7100_CLK_FRAC_MIN)
+		result = parent100 / (div100 - 1);
+
+	req->rate = result;
+	return 0;
+}
+
+static int jh7100_clk_frac_set_rate(struct clk_hw *hw,
+				    unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct jh7100_clk *clk = jh7100_clk_from(hw);
+	unsigned long div100 = clamp(DIV_ROUND_CLOSEST(100 * parent_rate, rate),
+				     JH7100_CLK_FRAC_MIN, JH7100_CLK_FRAC_MAX);
+	u32 value = ((div100 % 100) << JH7100_CLK_FRAC_SHIFT) | (div100 / 100);
+
+	jh7100_clk_reg_rmw(clk, JH7100_CLK_DIV_MASK, value);
+	return 0;
+}
+
 static u8 jh7100_clk_get_parent(struct clk_hw *hw)
 {
 	struct jh7100_clk *clk = jh7100_clk_from(hw);
@@ -526,6 +583,13 @@ static const struct clk_ops jh7100_clk_div_ops = {
 	.debug_init = jh7100_clk_debug_init,
 };
 
+static const struct clk_ops jh7100_clk_fdiv_ops = {
+	.recalc_rate = jh7100_clk_frac_recalc_rate,
+	.determine_rate = jh7100_clk_frac_determine_rate,
+	.set_rate = jh7100_clk_frac_set_rate,
+	.debug_init = jh7100_clk_debug_init,
+};
+
 static const struct clk_ops jh7100_clk_gdiv_ops = {
 	.enable = jh7100_clk_enable,
 	.disable = jh7100_clk_disable,
@@ -564,6 +628,8 @@ static const struct clk_ops *__init jh7100_clk_ops(u32 max)
 	if (max & JH7100_CLK_DIV_MASK) {
 		if (max & JH7100_CLK_ENABLE)
 			return &jh7100_clk_gdiv_ops;
+		if (max == JH7100_CLK_FRAC_MAX)
+			return &jh7100_clk_fdiv_ops;
 		return &jh7100_clk_div_ops;
 	}
 
-- 
2.34.1

