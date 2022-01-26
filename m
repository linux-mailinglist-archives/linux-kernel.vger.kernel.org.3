Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7861B49C5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbiAZI7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:59:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41962 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238653AbiAZI7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:59:53 -0500
X-UUID: 49444759154247c9bd22bfdb75bf04ad-20220126
X-UUID: 49444759154247c9bd22bfdb75bf04ad-20220126
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 649423601; Wed, 26 Jan 2022 16:59:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 16:59:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 16:59:47 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 31/31] clk: mediatek: Warn if clk IDs are duplicated
Date:   Wed, 26 Jan 2022 16:59:47 +0800
Message-ID: <20220126085947.31507-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-32-wenst@chromium.org>
References: <20220122091731.283592-32-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>The Mediatek clk driver library handles duplicate clock IDs in two
>different ways: either ignoring the duplicate entry, or overwriting
>the old clk. Either way may cause unexpected behavior, and the latter
>also causes an orphan clk that cannot be cleaned up.
>
>Align the behavior so that later duplicate entries are ignored, and
>a warning printed. The warning will also aid in making the issue
>noticeable.
>
>Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>---
> drivers/clk/mediatek/clk-cpumux.c |  6 ++++++
> drivers/clk/mediatek/clk-gate.c   |  5 ++++-
> drivers/clk/mediatek/clk-mtk.c    | 18 ++++++++++++++----
> drivers/clk/mediatek/clk-mux.c    |  5 ++++-
> drivers/clk/mediatek/clk-pll.c    |  6 ++++++
> 5 files changed, 34 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
>index 499c60432280..c11b3fae622e 100644
>--- a/drivers/clk/mediatek/clk-cpumux.c
>+++ b/drivers/clk/mediatek/clk-cpumux.c
>@@ -120,6 +120,12 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
> 	for (i = 0; i < num; i++) {
> 		const struct mtk_composite *mux = &clks[i];
> 
>+		if (!IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
>+			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
>+				node, mux->id);
>+			continue;

%pOF is an useful information when this happens.

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

>+		}
>+
> 		clk = mtk_clk_register_cpumux(mux, regmap);
> 		if (IS_ERR(clk)) {
> 			pr_err("Failed to register clk %s: %pe\n", mux->name, clk);
>diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
>index 631ff170b7b9..da52023f8455 100644
>--- a/drivers/clk/mediatek/clk-gate.c
>+++ b/drivers/clk/mediatek/clk-gate.c
>@@ -224,8 +224,11 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
> 	for (i = 0; i < num; i++) {
> 		const struct mtk_gate *gate = &clks[i];
> 
>-		if (!IS_ERR_OR_NULL(clk_data->clks[gate->id]))
>+		if (!IS_ERR_OR_NULL(clk_data->clks[gate->id])) {
>+			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
>+				node, gate->id);
> 			continue;
>+		}
> 
> 		clk = mtk_clk_register_gate(gate->name, gate->parent_name,
> 					    regmap,
>diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
>index 6d0b8842971b..b2a3568922b2 100644
>--- a/drivers/clk/mediatek/clk-mtk.c
>+++ b/drivers/clk/mediatek/clk-mtk.c
>@@ -65,8 +65,10 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> 	for (i = 0; i < num; i++) {
> 		const struct mtk_fixed_clk *rc = &clks[i];
> 
>-		if (!IS_ERR_OR_NULL(clk_data->clks[rc->id]))
>+		if (!IS_ERR_OR_NULL(clk_data->clks[rc->id])) {
>+			pr_warn("Trying to register duplicate clock ID: %d\n", rc->id);
> 			continue;
>+		}
> 
> 		clk = clk_register_fixed_rate(NULL, rc->name, rc->parent, 0,
> 					      rc->rate);
>@@ -128,8 +130,10 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
> 	for (i = 0; i < num; i++) {
> 		const struct mtk_fixed_factor *ff = &clks[i];
> 
>-		if (!IS_ERR_OR_NULL(clk_data->clks[ff->id]))
>+		if (!IS_ERR_OR_NULL(clk_data->clks[ff->id])) {
>+			pr_warn("Trying to register duplicate clock ID: %d\n", ff->id);
> 			continue;
>+		}
> 
> 		clk = clk_register_fixed_factor(NULL, ff->name, ff->parent_name,
> 				CLK_SET_RATE_PARENT, ff->mult, ff->div);
>@@ -300,8 +304,11 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
> 	for (i = 0; i < num; i++) {
> 		const struct mtk_composite *mc = &mcs[i];
> 
>-		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[mc->id]))
>+		if (!IS_ERR_OR_NULL(clk_data->clks[mc->id])) {
>+			pr_warn("Trying to register duplicate clock ID: %d\n",
>+				mc->id);
> 			continue;
>+		}
> 
> 		clk = mtk_clk_register_composite(mc, base, lock);
> 
>@@ -363,8 +370,11 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
> 	for (i = 0; i <  num; i++) {
> 		const struct mtk_clk_divider *mcd = &mcds[i];
> 
>-		if (!IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
>+		if (!IS_ERR_OR_NULL(clk_data->clks[mcd->id])) {
>+			pr_warn("Trying to register duplicate clock ID: %d\n",
>+				mcd->id);
> 			continue;
>+		}
> 
> 		clk = clk_register_divider(NULL, mcd->name, mcd->parent_name,
> 			mcd->flags, base +  mcd->div_reg, mcd->div_shift,
>diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
>index f51e67650f03..21ad5a4afd65 100644
>--- a/drivers/clk/mediatek/clk-mux.c
>+++ b/drivers/clk/mediatek/clk-mux.c
>@@ -208,8 +208,11 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
> 	for (i = 0; i < num; i++) {
> 		const struct mtk_mux *mux = &muxes[i];
> 
>-		if (!IS_ERR_OR_NULL(clk_data->clks[mux->id]))
>+		if (!IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
>+			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
>+				node, mux->id);
> 			continue;
>+		}
> 
> 		clk = mtk_clk_register_mux(mux, regmap, lock);
> 
>diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
>index 1dd15f560659..e5e9c188be99 100644
>--- a/drivers/clk/mediatek/clk-pll.c
>+++ b/drivers/clk/mediatek/clk-pll.c
>@@ -386,6 +386,12 @@ int mtk_clk_register_plls(struct device_node *node,
> 	for (i = 0; i < num_plls; i++) {
> 		const struct mtk_pll_data *pll = &plls[i];
> 
>+		if (!IS_ERR_OR_NULL(clk_data->clks[pll->id])) {
>+			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
>+				node, pll->id);
>+			continue;
>+		}
>+
> 		clk = mtk_clk_register_pll(pll, base);
> 
> 		if (IS_ERR(clk)) {
>-- 
>2.35.0.rc0.227.g00780c9af4-goog
>
>
