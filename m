Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66703495B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379121AbiAUHpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:45:21 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:14996 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348992AbiAUHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:45:15 -0500
Received: from droid11-sz.amlogic.com (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Fri, 21 Jan 2022
 15:45:14 +0800
From:   Liang Yang <liang.yang@amlogic.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-clk@vger.kernel.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v10 1/4] clk: meson: add one based divider support for sclk
Date:   Fri, 21 Jan 2022 15:45:05 +0800
Message-ID: <20220121074508.42168-2-liang.yang@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121074508.42168-1-liang.yang@amlogic.com>
References: <20220121074508.42168-1-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.21]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MESON_SCLK_ONE_BASED flag is set, the sclk divider will be:
one based divider (div = val), and zero value gates the clock

Signed-off-by: Liang Yang <liang.yang@amlogic.com>
---
 drivers/clk/meson/sclk-div.c | 59 ++++++++++++++++++++++--------------
 drivers/clk/meson/sclk-div.h |  3 ++
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
index 76d31c0a3342..4ddc1763a12d 100644
--- a/drivers/clk/meson/sclk-div.c
+++ b/drivers/clk/meson/sclk-div.c
@@ -4,16 +4,17 @@
  * Author: Jerome Brunet <jbrunet@baylibre.com>
  *
  * Sample clock generator divider:
- * This HW divider gates with value 0 but is otherwise a zero based divider:
+ * This HW divider gates with value 0:
  *
  * val >= 1
- * divider = val + 1
+ * divider = val + 1 if ONE_BASED is not set, otherwise divider = val.
  *
  * The duty cycle may also be set for the LR clock variant. The duty cycle
  * ratio is:
  *
  * hi = [0 - val]
- * duty_cycle = (1 + hi) / (1 + val)
+ * duty_cycle = (1 + hi) / (1 + val) if ONE_BASED is not set, otherwise:
+ * duty_cycle = hi / (1 + val)
  */
 
 #include <linux/clk-provider.h>
@@ -28,22 +29,37 @@ meson_sclk_div_data(struct clk_regmap *clk)
 	return (struct meson_sclk_div_data *)clk->data;
 }
 
-static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
+static inline int sclk_get_reg(int val, unsigned char flag)
 {
-	return (1 << sclk->div.width) - 1;
+	if ((flag & MESON_SCLK_ONE_BASED) || !val)
+		return val;
+	return val - 1;
+}
+
+static inline int sclk_get_divider(int reg, unsigned char flag)
+{
+	if (flag & MESON_SCLK_ONE_BASED)
+		return reg;
+	return reg + 1;
 }
 
 static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
 {
-	return sclk_div_maxval(sclk) + 1;
+	unsigned int reg = (1 << sclk->div.width) - 1;
+
+	return sclk_get_divider(reg, sclk->flags);
 }
 
 static int sclk_div_getdiv(struct clk_hw *hw, unsigned long rate,
-			   unsigned long prate, int maxdiv)
+			   unsigned long prate)
 {
 	int div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+	int mindiv = sclk_get_divider(1, sclk->flags);
+	int maxdiv = sclk_div_maxdiv(sclk);
 
-	return clamp(div, 2, maxdiv);
+	return clamp(div, mindiv, maxdiv);
 }
 
 static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
@@ -51,25 +67,25 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
 			    struct meson_sclk_div_data *sclk)
 {
 	struct clk_hw *parent = clk_hw_get_parent(hw);
-	int bestdiv = 0, i;
+	int bestdiv = 0, i, mindiv;
 	unsigned long maxdiv, now, parent_now;
 	unsigned long best = 0, best_parent = 0;
 
 	if (!rate)
 		rate = 1;
 
-	maxdiv = sclk_div_maxdiv(sclk);
-
 	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT))
-		return sclk_div_getdiv(hw, rate, *prate, maxdiv);
+		return sclk_div_getdiv(hw, rate, *prate);
 
 	/*
 	 * The maximum divider we can use without overflowing
 	 * unsigned long in rate * i below
 	 */
+	maxdiv = sclk_div_maxdiv(sclk);
 	maxdiv = min(ULONG_MAX / rate, maxdiv);
+	mindiv = sclk_get_divider(1, sclk->flags);
 
-	for (i = 2; i <= maxdiv; i++) {
+	for (i = mindiv; i <= maxdiv; i++) {
 		/*
 		 * It's the most ideal case if the requested rate can be
 		 * divided from parent clock without needing to change
@@ -115,10 +131,7 @@ static void sclk_apply_ratio(struct clk_regmap *clk,
 					    sclk->cached_duty.num,
 					    sclk->cached_duty.den);
 
-	if (hi)
-		hi -= 1;
-
-	meson_parm_write(clk->map, &sclk->hi, hi);
+	meson_parm_write(clk->map, &sclk->hi, sclk_get_reg(hi, sclk->flags));
 }
 
 static int sclk_div_set_duty_cycle(struct clk_hw *hw,
@@ -149,7 +162,7 @@ static int sclk_div_get_duty_cycle(struct clk_hw *hw,
 	}
 
 	hi = meson_parm_read(clk->map, &sclk->hi);
-	duty->num = hi + 1;
+	duty->num = sclk_get_divider(hi, sclk->flags);
 	duty->den = sclk->cached_div;
 	return 0;
 }
@@ -157,10 +170,13 @@ static int sclk_div_get_duty_cycle(struct clk_hw *hw,
 static void sclk_apply_divider(struct clk_regmap *clk,
 			       struct meson_sclk_div_data *sclk)
 {
+	unsigned int div;
+
 	if (MESON_PARM_APPLICABLE(&sclk->hi))
 		sclk_apply_ratio(clk, sclk);
 
-	meson_parm_write(clk->map, &sclk->div, sclk->cached_div - 1);
+	div = sclk_get_reg(sclk->cached_div, sclk->flags);
+	meson_parm_write(clk->map, &sclk->div, div);
 }
 
 static int sclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -168,9 +184,8 @@ static int sclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
-	unsigned long maxdiv = sclk_div_maxdiv(sclk);
 
-	sclk->cached_div = sclk_div_getdiv(hw, rate, prate, maxdiv);
+	sclk->cached_div = sclk_div_getdiv(hw, rate, prate);
 
 	if (clk_hw_is_enabled(hw))
 		sclk_apply_divider(clk, sclk);
@@ -228,7 +243,7 @@ static int sclk_div_init(struct clk_hw *hw)
 	if (!val)
 		sclk->cached_div = sclk_div_maxdiv(sclk);
 	else
-		sclk->cached_div = val + 1;
+		sclk->cached_div = sclk_get_divider(val, sclk->flags);
 
 	sclk_div_get_duty_cycle(hw, &sclk->cached_duty);
 
diff --git a/drivers/clk/meson/sclk-div.h b/drivers/clk/meson/sclk-div.h
index b64b2a32005f..944dab5ec0cf 100644
--- a/drivers/clk/meson/sclk-div.h
+++ b/drivers/clk/meson/sclk-div.h
@@ -10,11 +10,14 @@
 #include <linux/clk-provider.h>
 #include "parm.h"
 
+#define MESON_SCLK_ONE_BASED	BIT(0)
+
 struct meson_sclk_div_data {
 	struct parm div;
 	struct parm hi;
 	unsigned int cached_div;
 	struct clk_duty cached_duty;
+	u8 flags;
 };
 
 extern const struct clk_ops meson_sclk_div_ops;
-- 
2.34.1

