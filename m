Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B61449D106
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbiAZRkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243873AbiAZRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:40:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C229C06173B;
        Wed, 26 Jan 2022 09:40:29 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s18so327778wrv.7;
        Wed, 26 Jan 2022 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=utzJOlRKmUIVrtRjHx/h9EYRmqdAXYNb73fmWJzmJYo=;
        b=ShhfaR0CXVLZKeOjQWZhazb4zVjN1sk6cZewEKW3ITUMaUznUzpSkfWbkAywi2rTjc
         9D7Sxsh0c4Ctl9g8b5x/nrLKgWT7cmXq//RHuferZKv1urhyrKdUDopa+jfgJzuac1kk
         dreYYDH7phQ95hHTsoloBpKNvAupN5Wll/CJ1eUBvJEBUEZ4NxFgTwhNgFt8LCUk0Au9
         VHaH8xgXvSsRr9apj3ZEYVgZjtyUbu9vpY+un4ral4ucFFYkMQNCvfioMgjSCBeA4LH2
         AgqjSIOV9egPdvtWCfP8HGouQVxIjZ7TwiZaN46dP2i0ncOZ6kzsJ8yTISWGCm7JhESh
         pZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=utzJOlRKmUIVrtRjHx/h9EYRmqdAXYNb73fmWJzmJYo=;
        b=lwS2tb7C27tsVx8/HA0u7MaA2X8UnbdzSP6tUJuCVLPIto4MXte1Jp6JdPapGaUDnG
         mstVmuffpPjRcCHrXV2MI9cKljaErwMfvuWEavxJRn2q37zaLlDM8/gqgifh+pGqVjcn
         a/qaysnfbbUWj0QjI98mFnSrW9qLTSC0yG/ZZLMh2OzUbzIhOJirPF94q8ubfcb66GfC
         ZM8mSewK8ATr7vaIoG0vr/wMYsYjUnPiH6jzLG2BdGgNrWCJjXvGbNQ3A0z/J4djZIQ8
         jbuEON6tmjJweLClMZWZUSTFW/QENDPUeVQYc+uGekrY8TP2aueT0RrW0SZw5nHdU/d4
         q2zg==
X-Gm-Message-State: AOAM5300Xdivfw3FINcLCqg1OQb4ZpzD28quHJ//RyGP7lRqTl8SwR6r
        1kOI3DiGxUUXXbv33KCcwmXCy6beIX0=
X-Google-Smtp-Source: ABdhPJyKWB52VRbk+Yog7hvH/ukqMHlAba7DvFgxeWp49CSs92pfpSoS5IbJ3TKNxPLYazZXAUUEPQ==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr22871829wrx.274.1643218827754;
        Wed, 26 Jan 2022 09:40:27 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y2sm3498451wmj.13.2022.01.26.09.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:40:27 -0800 (PST)
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
Subject: [PATCH v1 5/7] clk: starfive: jh7100: Make hw clock implementation reusable
Date:   Wed, 26 Jan 2022 18:39:51 +0100
Message-Id: <20220126173953.1016706-6-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126173953.1016706-1-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JH7100 has additional audio and video clocks at different memory
ranges, but they use the same register layout. Add a header and export
the starfive_jh7100_clk_ops function so the clock implementation can be
reused by drivers handling these clocks.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/clk/starfive/clk-starfive-jh7100.c | 96 ++-------------------
 drivers/clk/starfive/clk-starfive-jh7100.h | 97 ++++++++++++++++++++++
 2 files changed, 104 insertions(+), 89 deletions(-)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7100.h

diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 4b59338b5d7d..a6708f9ebf4c 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -20,83 +20,15 @@
 
 #include <dt-bindings/clock/starfive-jh7100.h>
 
+#include "clk-starfive-jh7100.h"
+
 /* external clocks */
 #define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
 #define JH7100_CLK_OSC_AUD		(JH7100_CLK_END + 1)
 #define JH7100_CLK_GMAC_RMII_REF	(JH7100_CLK_END + 2)
 #define JH7100_CLK_GMAC_GR_MII_RX	(JH7100_CLK_END + 3)
 
-/* register fields */
-#define JH7100_CLK_ENABLE	BIT(31)
-#define JH7100_CLK_INVERT	BIT(30)
-#define JH7100_CLK_MUX_MASK	GENMASK(27, 24)
-#define JH7100_CLK_MUX_SHIFT	24
-#define JH7100_CLK_DIV_MASK	GENMASK(23, 0)
-#define JH7100_CLK_FRAC_MASK	GENMASK(15, 8)
-#define JH7100_CLK_FRAC_SHIFT	8
-#define JH7100_CLK_INT_MASK	GENMASK(7, 0)
-
-/* fractional divider min/max */
-#define JH7100_CLK_FRAC_MIN	100UL
-#define JH7100_CLK_FRAC_MAX	25599UL
-
-/* clock data */
-#define JH7100_GATE(_idx, _name, _flags, _parent) [_idx] = {		\
-	.name = _name,							\
-	.flags = CLK_SET_RATE_PARENT | (_flags),			\
-	.max = JH7100_CLK_ENABLE,					\
-	.parents = { [0] = _parent },					\
-}
-
-#define JH7100__DIV(_idx, _name, _max, _parent) [_idx] = {		\
-	.name = _name,							\
-	.flags = 0,							\
-	.max = _max,							\
-	.parents = { [0] = _parent },					\
-}
-
-#define JH7100_GDIV(_idx, _name, _flags, _max, _parent) [_idx] = {	\
-	.name = _name,							\
-	.flags = _flags,						\
-	.max = JH7100_CLK_ENABLE | (_max),				\
-	.parents = { [0] = _parent },					\
-}
-
-#define JH7100_FDIV(_idx, _name, _parent) [_idx] = {			\
-	.name = _name,							\
-	.flags = 0,							\
-	.max = JH7100_CLK_FRAC_MAX,					\
-	.parents = { [0] = _parent },					\
-}
-
-#define JH7100__MUX(_idx, _name, _nparents, ...) [_idx] = {		\
-	.name = _name,							\
-	.flags = 0,							\
-	.max = ((_nparents) - 1) << JH7100_CLK_MUX_SHIFT,		\
-	.parents = { __VA_ARGS__ },					\
-}
-
-#define JH7100_GMUX(_idx, _name, _flags, _nparents, ...) [_idx] = {	\
-	.name = _name,							\
-	.flags = _flags,						\
-	.max = JH7100_CLK_ENABLE |					\
-		(((_nparents) - 1) << JH7100_CLK_MUX_SHIFT),		\
-	.parents = { __VA_ARGS__ },					\
-}
-
-#define JH7100__INV(_idx, _name, _parent) [_idx] = {			\
-	.name = _name,							\
-	.flags = CLK_SET_RATE_PARENT,					\
-	.max = JH7100_CLK_INVERT,					\
-	.parents = { [0] = _parent },					\
-}
-
-static const struct {
-	const char *name;
-	unsigned long flags;
-	u32 max;
-	u8 parents[4];
-} jh7100_clk_data[] __initconst = {
+static const struct jh7100_clk_data jh7100_clk_data[] __initconst = {
 	JH7100__MUX(JH7100_CLK_CPUNDBUS_ROOT, "cpundbus_root", 4,
 		    JH7100_CLK_OSC_SYS,
 		    JH7100_CLK_PLL0_OUT,
@@ -337,21 +269,6 @@ static const struct {
 	JH7100_GATE(JH7100_CLK_SYSERR_APB, "syserr_apb", 0, JH7100_CLK_APB2_BUS),
 };
 
-struct jh7100_clk {
-	struct clk_hw hw;
-	unsigned int idx;
-	unsigned int max_div;
-};
-
-struct jh7100_clk_priv {
-	/* protect clk enable and set rate/parent from happening at the same time */
-	spinlock_t rmw_lock;
-	struct device *dev;
-	void __iomem *base;
-	struct clk_hw *pll[3];
-	struct jh7100_clk reg[JH7100_CLK_PLL0_OUT];
-};
-
 static struct jh7100_clk *jh7100_clk_from(struct clk_hw *hw)
 {
 	return container_of(hw, struct jh7100_clk, hw);
@@ -623,7 +540,7 @@ static const struct clk_ops jh7100_clk_inv_ops = {
 	.debug_init = jh7100_clk_debug_init,
 };
 
-static const struct clk_ops *__init jh7100_clk_ops(u32 max)
+const struct clk_ops *starfive_jh7100_clk_ops(u32 max)
 {
 	if (max & JH7100_CLK_DIV_MASK) {
 		if (max & JH7100_CLK_ENABLE)
@@ -644,6 +561,7 @@ static const struct clk_ops *__init jh7100_clk_ops(u32 max)
 
 	return &jh7100_clk_inv_ops;
 }
+EXPORT_SYMBOL_GPL(starfive_jh7100_clk_ops);
 
 static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data)
 {
@@ -665,7 +583,7 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 	unsigned int idx;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, reg, JH7100_CLK_PLL0_OUT), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -695,7 +613,7 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 		struct clk_parent_data parents[4] = {};
 		struct clk_init_data init = {
 			.name = jh7100_clk_data[idx].name,
-			.ops = jh7100_clk_ops(max),
+			.ops = starfive_jh7100_clk_ops(max),
 			.parent_data = parents,
 			.num_parents = ((max & JH7100_CLK_MUX_MASK) >> JH7100_CLK_MUX_SHIFT) + 1,
 			.flags = jh7100_clk_data[idx].flags,
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.h b/drivers/clk/starfive/clk-starfive-jh7100.h
new file mode 100644
index 000000000000..8eccd8c0a746
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7100.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CLK_STARFIVE_JH7100_H
+#define __CLK_STARFIVE_JH7100_H
+
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+
+/* register fields */
+#define JH7100_CLK_ENABLE	BIT(31)
+#define JH7100_CLK_INVERT	BIT(30)
+#define JH7100_CLK_MUX_MASK	GENMASK(27, 24)
+#define JH7100_CLK_MUX_SHIFT	24
+#define JH7100_CLK_DIV_MASK	GENMASK(23, 0)
+#define JH7100_CLK_FRAC_MASK	GENMASK(15, 8)
+#define JH7100_CLK_FRAC_SHIFT	8
+#define JH7100_CLK_INT_MASK	GENMASK(7, 0)
+
+/* fractional divider min/max */
+#define JH7100_CLK_FRAC_MIN	100UL
+#define JH7100_CLK_FRAC_MAX	25599UL
+
+/* clock data */
+struct jh7100_clk_data {
+	const char *name;
+	unsigned long flags;
+	u32 max;
+	u8 parents[4];
+};
+
+#define JH7100_GATE(_idx, _name, _flags, _parent) [_idx] = {			\
+	.name = _name,								\
+	.flags = CLK_SET_RATE_PARENT | (_flags),				\
+	.max = JH7100_CLK_ENABLE,						\
+	.parents = { [0] = _parent },						\
+}
+
+#define JH7100__DIV(_idx, _name, _max, _parent) [_idx] = {			\
+	.name = _name,								\
+	.flags = 0,								\
+	.max = _max,								\
+	.parents = { [0] = _parent },						\
+}
+
+#define JH7100_GDIV(_idx, _name, _flags, _max, _parent) [_idx] = {		\
+	.name = _name,								\
+	.flags = _flags,							\
+	.max = JH7100_CLK_ENABLE | (_max),					\
+	.parents = { [0] = _parent },						\
+}
+
+#define JH7100_FDIV(_idx, _name, _parent) [_idx] = {				\
+	.name = _name,								\
+	.flags = 0,								\
+	.max = JH7100_CLK_FRAC_MAX,						\
+	.parents = { [0] = _parent },						\
+}
+
+#define JH7100__MUX(_idx, _name, _nparents, ...) [_idx] = {			\
+	.name = _name,								\
+	.flags = 0,								\
+	.max = ((_nparents) - 1) << JH7100_CLK_MUX_SHIFT,			\
+	.parents = { __VA_ARGS__ },						\
+}
+
+#define JH7100_GMUX(_idx, _name, _flags, _nparents, ...) [_idx] = {		\
+	.name = _name,								\
+	.flags = _flags,							\
+	.max = JH7100_CLK_ENABLE |						\
+		(((_nparents) - 1) << JH7100_CLK_MUX_SHIFT),			\
+	.parents = { __VA_ARGS__ },						\
+}
+
+#define JH7100__INV(_idx, _name, _parent) [_idx] = {				\
+	.name = _name,								\
+	.flags = CLK_SET_RATE_PARENT,						\
+	.max = JH7100_CLK_INVERT,						\
+	.parents = { [0] = _parent },						\
+}
+
+struct jh7100_clk {
+	struct clk_hw hw;
+	unsigned int idx;
+	unsigned int max_div;
+};
+
+struct jh7100_clk_priv {
+	/* protect clk enable and set rate/parent from happening at the same time */
+	spinlock_t rmw_lock;
+	struct device *dev;
+	void __iomem *base;
+	struct clk_hw *pll[3];
+	struct jh7100_clk reg[];
+};
+
+const struct clk_ops *starfive_jh7100_clk_ops(u32 max);
+
+#endif
-- 
2.34.1

