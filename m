Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356225ACD30
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiIEHzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiIEHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:55:09 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B413D2F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1662364501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yfMaNqlgCb+u1UzyilypPxYrn4cC/u5zPJoTN1YRGgc=;
        b=YUymfqsbIw880L92pmnWP8lz+FokY+Mt00AdE90s7HwlLy8DGajEswHROazP3SpnMFMqaw
        rziReETF3ATO2HhRRIF2RbH6P/SyHPeBYLxkZLbZ5UdM4OEX0YH0oeNmU6n++tj1NBimIr
        tuMuWHkHcx6AEz31SGNmwDeoT7QKK25SYVdyuEDRmYjIx/pLvVn6mEUyd/CtanCJWpeUyx
        XEXedaOM1AWz2yTi6CSZhXzcrNgbw44zaB7EK2Pd7lTUPuOfizxQMg+rPQKKY3KpXxOS5P
        FSJTSTLQ2OFqVRey8MfyyF9ejjEblu3ik4x5hZ0YsNWQgBa0qoCqalxAIjeviw==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-292-vspEF-c2PFW8EEfyPL0Edg-2; Mon, 05 Sep 2022 03:44:00 -0400
X-MC-Unique: vspEF-c2PFW8EEfyPL0Edg-2
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Mon, 5 Sep 2022 00:43:57 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH v2 2/5] clk: mxl: Remove unnecessary spinlocks
Date:   Mon, 5 Sep 2022 15:43:45 +0800
Message-ID: <2602fd05fff85bd35925c1103fc07d128cffb5b1.1662363020.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1662363020.git.rtanwar@maxlinear.com>
References: <cover.1662363020.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is now switched from direct readl/writel based register
access to regmap based register acceess. Regmap already has its own
lock to serialize the register accesses across multiple cores.

Hence, there is no need for additional spinlocks in the driver.
Remove all spinlocks which are no longer required.

Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 drivers/clk/x86/clk-cgu-pll.c | 13 ------
 drivers/clk/x86/clk-cgu.c     | 80 ++++-------------------------------
 drivers/clk/x86/clk-cgu.h     |  6 ---
 drivers/clk/x86/clk-lgm.c     |  1 -
 4 files changed, 9 insertions(+), 91 deletions(-)

diff --git a/drivers/clk/x86/clk-cgu-pll.c b/drivers/clk/x86/clk-cgu-pll.c
index c83083affe88..409dbf55f4ca 100644
--- a/drivers/clk/x86/clk-cgu-pll.c
+++ b/drivers/clk/x86/clk-cgu-pll.c
@@ -41,13 +41,10 @@ static unsigned long lgm_pll_recalc_rate(struct clk_hw =
*hw, unsigned long prate)
 {
 =09struct lgm_clk_pll *pll =3D to_lgm_clk_pll(hw);
 =09unsigned int div, mult, frac;
-=09unsigned long flags;
=20
-=09spin_lock_irqsave(&pll->lock, flags);
 =09mult =3D lgm_get_clk_val(pll->membase, PLL_REF_DIV(pll->reg), 0, 12);
 =09div =3D lgm_get_clk_val(pll->membase, PLL_REF_DIV(pll->reg), 18, 6);
 =09frac =3D lgm_get_clk_val(pll->membase, pll->reg, 2, 24);
-=09spin_unlock_irqrestore(&pll->lock, flags);
=20
 =09if (pll->type =3D=3D TYPE_LJPLL)
 =09=09div *=3D 4;
@@ -58,12 +55,9 @@ static unsigned long lgm_pll_recalc_rate(struct clk_hw *=
hw, unsigned long prate)
 static int lgm_pll_is_enabled(struct clk_hw *hw)
 {
 =09struct lgm_clk_pll *pll =3D to_lgm_clk_pll(hw);
-=09unsigned long flags;
 =09unsigned int ret;
=20
-=09spin_lock_irqsave(&pll->lock, flags);
 =09ret =3D lgm_get_clk_val(pll->membase, pll->reg, 0, 1);
-=09spin_unlock_irqrestore(&pll->lock, flags);
=20
 =09return ret;
 }
@@ -71,16 +65,13 @@ static int lgm_pll_is_enabled(struct clk_hw *hw)
 static int lgm_pll_enable(struct clk_hw *hw)
 {
 =09struct lgm_clk_pll *pll =3D to_lgm_clk_pll(hw);
-=09unsigned long flags;
 =09u32 val;
 =09int ret;
=20
-=09spin_lock_irqsave(&pll->lock, flags);
 =09lgm_set_clk_val(pll->membase, pll->reg, 0, 1, 1);
 =09ret =3D regmap_read_poll_timeout_atomic(pll->membase, pll->reg,
 =09=09=09=09=09      val, (val & 0x1), 1, 100);
=20
-=09spin_unlock_irqrestore(&pll->lock, flags);
=20
 =09return ret;
 }
@@ -88,11 +79,8 @@ static int lgm_pll_enable(struct clk_hw *hw)
 static void lgm_pll_disable(struct clk_hw *hw)
 {
 =09struct lgm_clk_pll *pll =3D to_lgm_clk_pll(hw);
-=09unsigned long flags;
=20
-=09spin_lock_irqsave(&pll->lock, flags);
 =09lgm_set_clk_val(pll->membase, pll->reg, 0, 1, 0);
-=09spin_unlock_irqrestore(&pll->lock, flags);
 }
=20
 static const struct clk_ops lgm_pll_ops =3D {
@@ -123,7 +111,6 @@ lgm_clk_register_pll(struct lgm_clk_provider *ctx,
 =09=09return ERR_PTR(-ENOMEM);
=20
 =09pll->membase =3D ctx->membase;
-=09pll->lock =3D ctx->lock;
 =09pll->reg =3D list->reg;
 =09pll->flags =3D list->flags;
 =09pll->type =3D list->type;
diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index f5f30a18f486..1f7e93de67bc 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -25,14 +25,10 @@
 static struct clk_hw *lgm_clk_register_fixed(struct lgm_clk_provider *ctx,
 =09=09=09=09=09     const struct lgm_clk_branch *list)
 {
-=09unsigned long flags;
=20
-=09if (list->div_flags & CLOCK_FLAG_VAL_INIT) {
-=09=09spin_lock_irqsave(&ctx->lock, flags);
+=09if (list->div_flags & CLOCK_FLAG_VAL_INIT)
 =09=09lgm_set_clk_val(ctx->membase, list->div_off, list->div_shift,
 =09=09=09=09list->div_width, list->div_val);
-=09=09spin_unlock_irqrestore(&ctx->lock, flags);
-=09}
=20
 =09return clk_hw_register_fixed_rate(NULL, list->name,
 =09=09=09=09=09  list->parent_data[0].name,
@@ -42,33 +38,27 @@ static struct clk_hw *lgm_clk_register_fixed(struct lgm=
_clk_provider *ctx,
 static u8 lgm_clk_mux_get_parent(struct clk_hw *hw)
 {
 =09struct lgm_clk_mux *mux =3D to_lgm_clk_mux(hw);
-=09unsigned long flags;
 =09u32 val;
=20
-=09spin_lock_irqsave(&mux->lock, flags);
 =09if (mux->flags & MUX_CLK_SW)
 =09=09val =3D mux->reg;
 =09else
 =09=09val =3D lgm_get_clk_val(mux->membase, mux->reg, mux->shift,
 =09=09=09=09      mux->width);
-=09spin_unlock_irqrestore(&mux->lock, flags);
 =09return clk_mux_val_to_index(hw, NULL, mux->flags, val);
 }
=20
 static int lgm_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 =09struct lgm_clk_mux *mux =3D to_lgm_clk_mux(hw);
-=09unsigned long flags;
 =09u32 val;
=20
 =09val =3D clk_mux_index_to_val(NULL, mux->flags, index);
-=09spin_lock_irqsave(&mux->lock, flags);
 =09if (mux->flags & MUX_CLK_SW)
 =09=09mux->reg =3D val;
 =09else
 =09=09lgm_set_clk_val(mux->membase, mux->reg, mux->shift,
 =09=09=09=09mux->width, val);
-=09spin_unlock_irqrestore(&mux->lock, flags);
=20
 =09return 0;
 }
@@ -91,7 +81,7 @@ static struct clk_hw *
 lgm_clk_register_mux(struct lgm_clk_provider *ctx,
 =09=09     const struct lgm_clk_branch *list)
 {
-=09unsigned long flags, cflags =3D list->mux_flags;
+=09unsigned long cflags =3D list->mux_flags;
 =09struct device *dev =3D ctx->dev;
 =09u8 shift =3D list->mux_shift;
 =09u8 width =3D list->mux_width;
@@ -112,7 +102,6 @@ lgm_clk_register_mux(struct lgm_clk_provider *ctx,
 =09init.num_parents =3D list->num_parents;
=20
 =09mux->membase =3D ctx->membase;
-=09mux->lock =3D ctx->lock;
 =09mux->reg =3D reg;
 =09mux->shift =3D shift;
 =09mux->width =3D width;
@@ -124,11 +113,8 @@ lgm_clk_register_mux(struct lgm_clk_provider *ctx,
 =09if (ret)
 =09=09return ERR_PTR(ret);
=20
-=09if (cflags & CLOCK_FLAG_VAL_INIT) {
-=09=09spin_lock_irqsave(&mux->lock, flags);
+=09if (cflags & CLOCK_FLAG_VAL_INIT)
 =09=09lgm_set_clk_val(mux->membase, reg, shift, width, list->mux_val);
-=09=09spin_unlock_irqrestore(&mux->lock, flags);
-=09}
=20
 =09return hw;
 }
@@ -137,13 +123,10 @@ static unsigned long
 lgm_clk_divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 {
 =09struct lgm_clk_divider *divider =3D to_lgm_clk_divider(hw);
-=09unsigned long flags;
 =09unsigned int val;
=20
-=09spin_lock_irqsave(&divider->lock, flags);
 =09val =3D lgm_get_clk_val(divider->membase, divider->reg,
 =09=09=09      divider->shift, divider->width);
-=09spin_unlock_irqrestore(&divider->lock, flags);
=20
 =09return divider_recalc_rate(hw, parent_rate, val, divider->table,
 =09=09=09=09   divider->flags, divider->width);
@@ -164,7 +147,6 @@ lgm_clk_divider_set_rate(struct clk_hw *hw, unsigned lo=
ng rate,
 =09=09=09 unsigned long prate)
 {
 =09struct lgm_clk_divider *divider =3D to_lgm_clk_divider(hw);
-=09unsigned long flags;
 =09int value;
=20
 =09value =3D divider_get_val(rate, prate, divider->table,
@@ -172,10 +154,8 @@ lgm_clk_divider_set_rate(struct clk_hw *hw, unsigned l=
ong rate,
 =09if (value < 0)
 =09=09return value;
=20
-=09spin_lock_irqsave(&divider->lock, flags);
 =09lgm_set_clk_val(divider->membase, divider->reg,
 =09=09=09divider->shift, divider->width, value);
-=09spin_unlock_irqrestore(&divider->lock, flags);
=20
 =09return 0;
 }
@@ -183,12 +163,9 @@ lgm_clk_divider_set_rate(struct clk_hw *hw, unsigned l=
ong rate,
 static int lgm_clk_divider_enable_disable(struct clk_hw *hw, int enable)
 {
 =09struct lgm_clk_divider *div =3D to_lgm_clk_divider(hw);
-=09unsigned long flags;
=20
-=09spin_lock_irqsave(&div->lock, flags);
 =09lgm_set_clk_val(div->membase, div->reg, div->shift_gate,
 =09=09=09div->width_gate, enable);
-=09spin_unlock_irqrestore(&div->lock, flags);
 =09return 0;
 }
=20
@@ -214,7 +191,7 @@ static struct clk_hw *
 lgm_clk_register_divider(struct lgm_clk_provider *ctx,
 =09=09=09 const struct lgm_clk_branch *list)
 {
-=09unsigned long flags, cflags =3D list->div_flags;
+=09unsigned long cflags =3D list->div_flags;
 =09struct device *dev =3D ctx->dev;
 =09struct lgm_clk_divider *div;
 =09struct clk_init_data init =3D {};
@@ -237,7 +214,6 @@ lgm_clk_register_divider(struct lgm_clk_provider *ctx,
 =09init.num_parents =3D 1;
=20
 =09div->membase =3D ctx->membase;
-=09div->lock =3D ctx->lock;
 =09div->reg =3D reg;
 =09div->shift =3D shift;
 =09div->width =3D width;
@@ -252,11 +228,8 @@ lgm_clk_register_divider(struct lgm_clk_provider *ctx,
 =09if (ret)
 =09=09return ERR_PTR(ret);
=20
-=09if (cflags & CLOCK_FLAG_VAL_INIT) {
-=09=09spin_lock_irqsave(&div->lock, flags);
+=09if (cflags & CLOCK_FLAG_VAL_INIT)
 =09=09lgm_set_clk_val(div->membase, reg, shift, width, list->div_val);
-=09=09spin_unlock_irqrestore(&div->lock, flags);
-=09}
=20
 =09return hw;
 }
@@ -265,7 +238,6 @@ static struct clk_hw *
 lgm_clk_register_fixed_factor(struct lgm_clk_provider *ctx,
 =09=09=09      const struct lgm_clk_branch *list)
 {
-=09unsigned long flags;
 =09struct clk_hw *hw;
=20
 =09hw =3D clk_hw_register_fixed_factor(ctx->dev, list->name,
@@ -274,12 +246,9 @@ lgm_clk_register_fixed_factor(struct lgm_clk_provider =
*ctx,
 =09if (IS_ERR(hw))
 =09=09return ERR_CAST(hw);
=20
-=09if (list->div_flags & CLOCK_FLAG_VAL_INIT) {
-=09=09spin_lock_irqsave(&ctx->lock, flags);
+=09if (list->div_flags & CLOCK_FLAG_VAL_INIT)
 =09=09lgm_set_clk_val(ctx->membase, list->div_off, list->div_shift,
 =09=09=09=09list->div_width, list->div_val);
-=09=09spin_unlock_irqrestore(&ctx->lock, flags);
-=09}
=20
 =09return hw;
 }
@@ -287,13 +256,10 @@ lgm_clk_register_fixed_factor(struct lgm_clk_provider=
 *ctx,
 static int lgm_clk_gate_enable(struct clk_hw *hw)
 {
 =09struct lgm_clk_gate *gate =3D to_lgm_clk_gate(hw);
-=09unsigned long flags;
 =09unsigned int reg;
=20
-=09spin_lock_irqsave(&gate->lock, flags);
 =09reg =3D GATE_HW_REG_EN(gate->reg);
 =09lgm_set_clk_val(gate->membase, reg, gate->shift, 1, 1);
-=09spin_unlock_irqrestore(&gate->lock, flags);
=20
 =09return 0;
 }
@@ -301,25 +267,19 @@ static int lgm_clk_gate_enable(struct clk_hw *hw)
 static void lgm_clk_gate_disable(struct clk_hw *hw)
 {
 =09struct lgm_clk_gate *gate =3D to_lgm_clk_gate(hw);
-=09unsigned long flags;
 =09unsigned int reg;
=20
-=09spin_lock_irqsave(&gate->lock, flags);
 =09reg =3D GATE_HW_REG_DIS(gate->reg);
 =09lgm_set_clk_val(gate->membase, reg, gate->shift, 1, 1);
-=09spin_unlock_irqrestore(&gate->lock, flags);
 }
=20
 static int lgm_clk_gate_is_enabled(struct clk_hw *hw)
 {
 =09struct lgm_clk_gate *gate =3D to_lgm_clk_gate(hw);
 =09unsigned int reg, ret;
-=09unsigned long flags;
=20
-=09spin_lock_irqsave(&gate->lock, flags);
 =09reg =3D GATE_HW_REG_STAT(gate->reg);
 =09ret =3D lgm_get_clk_val(gate->membase, reg, gate->shift, 1);
-=09spin_unlock_irqrestore(&gate->lock, flags);
=20
 =09return ret;
 }
@@ -334,7 +294,7 @@ static struct clk_hw *
 lgm_clk_register_gate(struct lgm_clk_provider *ctx,
 =09=09      const struct lgm_clk_branch *list)
 {
-=09unsigned long flags, cflags =3D list->gate_flags;
+=09unsigned long cflags =3D list->gate_flags;
 =09const char *pname =3D list->parent_data[0].name;
 =09struct device *dev =3D ctx->dev;
 =09u8 shift =3D list->gate_shift;
@@ -355,7 +315,6 @@ lgm_clk_register_gate(struct lgm_clk_provider *ctx,
 =09init.num_parents =3D pname ? 1 : 0;
=20
 =09gate->membase =3D ctx->membase;
-=09gate->lock =3D ctx->lock;
 =09gate->reg =3D reg;
 =09gate->shift =3D shift;
 =09gate->flags =3D cflags;
@@ -367,9 +326,7 @@ lgm_clk_register_gate(struct lgm_clk_provider *ctx,
 =09=09return ERR_PTR(ret);
=20
 =09if (cflags & CLOCK_FLAG_VAL_INIT) {
-=09=09spin_lock_irqsave(&gate->lock, flags);
 =09=09lgm_set_clk_val(gate->membase, reg, shift, 1, list->gate_val);
-=09=09spin_unlock_irqrestore(&gate->lock, flags);
 =09}
=20
 =09return hw;
@@ -444,24 +401,18 @@ lgm_clk_ddiv_recalc_rate(struct clk_hw *hw, unsigned =
long parent_rate)
 static int lgm_clk_ddiv_enable(struct clk_hw *hw)
 {
 =09struct lgm_clk_ddiv *ddiv =3D to_lgm_clk_ddiv(hw);
-=09unsigned long flags;
=20
-=09spin_lock_irqsave(&ddiv->lock, flags);
 =09lgm_set_clk_val(ddiv->membase, ddiv->reg, ddiv->shift_gate,
 =09=09=09ddiv->width_gate, 1);
-=09spin_unlock_irqrestore(&ddiv->lock, flags);
 =09return 0;
 }
=20
 static void lgm_clk_ddiv_disable(struct clk_hw *hw)
 {
 =09struct lgm_clk_ddiv *ddiv =3D to_lgm_clk_ddiv(hw);
-=09unsigned long flags;
=20
-=09spin_lock_irqsave(&ddiv->lock, flags);
 =09lgm_set_clk_val(ddiv->membase, ddiv->reg, ddiv->shift_gate,
 =09=09=09ddiv->width_gate, 0);
-=09spin_unlock_irqrestore(&ddiv->lock, flags);
 }
=20
 static int
@@ -498,32 +449,25 @@ lgm_clk_ddiv_set_rate(struct clk_hw *hw, unsigned lon=
g rate,
 {
 =09struct lgm_clk_ddiv *ddiv =3D to_lgm_clk_ddiv(hw);
 =09u32 div, ddiv1, ddiv2;
-=09unsigned long flags;
=20
 =09div =3D DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
=20
-=09spin_lock_irqsave(&ddiv->lock, flags);
 =09if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
 =09=09div =3D DIV_ROUND_CLOSEST_ULL((u64)div, 5);
 =09=09div =3D div * 2;
 =09}
=20
-=09if (div <=3D 0) {
-=09=09spin_unlock_irqrestore(&ddiv->lock, flags);
+=09if (div <=3D 0)
 =09=09return -EINVAL;
-=09}
=20
-=09if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2)) {
-=09=09spin_unlock_irqrestore(&ddiv->lock, flags);
+=09if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2))
 =09=09return -EINVAL;
-=09}
=20
 =09lgm_set_clk_val(ddiv->membase, ddiv->reg, ddiv->shift0, ddiv->width0,
 =09=09=09ddiv1 - 1);
=20
 =09lgm_set_clk_val(ddiv->membase, ddiv->reg,  ddiv->shift1, ddiv->width1,
 =09=09=09ddiv2 - 1);
-=09spin_unlock_irqrestore(&ddiv->lock, flags);
=20
 =09return 0;
 }
@@ -534,18 +478,15 @@ lgm_clk_ddiv_round_rate(struct clk_hw *hw, unsigned l=
ong rate,
 {
 =09struct lgm_clk_ddiv *ddiv =3D to_lgm_clk_ddiv(hw);
 =09u32 div, ddiv1, ddiv2;
-=09unsigned long flags;
 =09u64 rate64;
=20
 =09div =3D DIV_ROUND_CLOSEST_ULL((u64)*prate, rate);
=20
 =09/* if predivide bit is enabled, modify div by factor of 2.5 */
-=09spin_lock_irqsave(&ddiv->lock, flags);
 =09if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
 =09=09div =3D div * 2;
 =09=09div =3D DIV_ROUND_CLOSEST_ULL((u64)div, 5);
 =09}
-=09spin_unlock_irqrestore(&ddiv->lock, flags);
=20
 =09if (div <=3D 0)
 =09=09return *prate;
@@ -559,12 +500,10 @@ lgm_clk_ddiv_round_rate(struct clk_hw *hw, unsigned l=
ong rate,
 =09do_div(rate64, ddiv2);
=20
 =09/* if predivide bit is enabled, modify rounded rate by factor of 2.5 */
-=09spin_lock_irqsave(&ddiv->lock, flags);
 =09if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
 =09=09rate64 =3D rate64 * 2;
 =09=09rate64 =3D DIV_ROUND_CLOSEST_ULL(rate64, 5);
 =09}
-=09spin_unlock_irqrestore(&ddiv->lock, flags);
=20
 =09return rate64;
 }
@@ -601,7 +540,6 @@ int lgm_clk_register_ddiv(struct lgm_clk_provider *ctx,
 =09=09init.num_parents =3D 1;
=20
 =09=09ddiv->membase =3D ctx->membase;
-=09=09ddiv->lock =3D ctx->lock;
 =09=09ddiv->reg =3D list->reg;
 =09=09ddiv->shift0 =3D list->shift0;
 =09=09ddiv->width0 =3D list->width0;
diff --git a/drivers/clk/x86/clk-cgu.h b/drivers/clk/x86/clk-cgu.h
index dbcb66468797..0aa0f35d63a0 100644
--- a/drivers/clk/x86/clk-cgu.h
+++ b/drivers/clk/x86/clk-cgu.h
@@ -18,7 +18,6 @@ struct lgm_clk_mux {
 =09u8 shift;
 =09u8 width;
 =09unsigned long flags;
-=09spinlock_t lock;
 };
=20
 struct lgm_clk_divider {
@@ -31,7 +30,6 @@ struct lgm_clk_divider {
 =09u8 width_gate;
 =09unsigned long flags;
 =09const struct clk_div_table *table;
-=09spinlock_t lock;
 };
=20
 struct lgm_clk_ddiv {
@@ -49,7 +47,6 @@ struct lgm_clk_ddiv {
 =09unsigned int mult;
 =09unsigned int div;
 =09unsigned long flags;
-=09spinlock_t lock;
 };
=20
 struct lgm_clk_gate {
@@ -58,7 +55,6 @@ struct lgm_clk_gate {
 =09unsigned int reg;
 =09u8 shift;
 =09unsigned long flags;
-=09spinlock_t lock;
 };
=20
 enum lgm_clk_type {
@@ -82,7 +78,6 @@ struct lgm_clk_provider {
 =09struct device_node *np;
 =09struct device *dev;
 =09struct clk_hw_onecell_data clk_data;
-=09spinlock_t lock;
 };
=20
 enum pll_type {
@@ -97,7 +92,6 @@ struct lgm_clk_pll {
 =09unsigned int reg;
 =09unsigned long flags;
 =09enum pll_type type;
-=09spinlock_t lock;
 };
=20
 /**
diff --git a/drivers/clk/x86/clk-lgm.c b/drivers/clk/x86/clk-lgm.c
index 4fa2bcaf71c8..e312af42e97a 100644
--- a/drivers/clk/x86/clk-lgm.c
+++ b/drivers/clk/x86/clk-lgm.c
@@ -444,7 +444,6 @@ static int lgm_cgu_probe(struct platform_device *pdev)
=20
 =09ctx->np =3D np;
 =09ctx->dev =3D dev;
-=09spin_lock_init(&ctx->lock);
=20
 =09ret =3D lgm_clk_register_plls(ctx, lgm_pll_clks,
 =09=09=09=09    ARRAY_SIZE(lgm_pll_clks));
--=20
2.17.1

