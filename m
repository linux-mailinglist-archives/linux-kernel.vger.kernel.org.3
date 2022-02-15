Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553114B6354
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiBOGUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:20:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBOGUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:20:19 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4382F11B32B;
        Mon, 14 Feb 2022 22:20:06 -0800 (PST)
X-UUID: 77a515df3bff4876be66cecc6c162a86-20220215
X-UUID: 77a515df3bff4876be66cecc6c162a86-20220215
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1244512323; Tue, 15 Feb 2022 14:20:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 14:20:01 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:20:01 +0800
Message-ID: <e4c71a67d682e4f8f6234651871afc5b36ebf1c6.camel@mediatek.com>
Subject: Re: [PATCH v3 02/31] clk: mediatek: gate: Consolidate gate type clk
 related code
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Feb 2022 14:20:01 +0800
In-Reply-To: <20220208124034.414635-3-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-3-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 20:40 +0800, Chen-Yu Tsai wrote:
> Right now some bits of the gate type clk code are in clk-gate.[ch],
> but
> other bits are in clk-mtk.[ch]. This is different from the cpumux and
> mux type clks, for which all of the code are found in the same files.
> 
> Move the functions that register multiple clks from a given list,
> mtk_clk_register_gates_with_dev() and mtk_clk_register_gates(), to
> clk-gate.[ch] to consolidate all the code for the gate type clks.
> 
> This commit only moves code with minor whitespace fixups to correct
> the code style. Further improvements, such as internalizing various
> functions and structures will be done in later commits.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> 

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-gate.c | 53
> ++++++++++++++++++++++++++++++++-
>  drivers/clk/mediatek/clk-gate.h | 25 ++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.c  | 51 -------------------------------
>  drivers/clk/mediatek/clk-mtk.h  | 25 ----------------
>  4 files changed, 77 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-gate.c
> b/drivers/clk/mediatek/clk-gate.c
> index 5d88b428565b..54921768bfba 100644
> --- a/drivers/clk/mediatek/clk-gate.c
> +++ b/drivers/clk/mediatek/clk-gate.c
> @@ -11,9 +11,9 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/clkdev.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  
> -#include "clk-mtk.h"
>  #include "clk-gate.h"
>  
>  static u32 mtk_get_clockgating(struct clk_hw *hw)
> @@ -182,4 +182,55 @@ struct clk *mtk_clk_register_gate(
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_gate);
>  
> +int mtk_clk_register_gates_with_dev(struct device_node *node,
> +				    const struct mtk_gate *clks, int
> num,
> +				    struct clk_onecell_data *clk_data,
> +				    struct device *dev)
> +{
> +	int i;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	regmap = device_node_to_regmap(node);
> +	if (IS_ERR(regmap)) {
> +		pr_err("Cannot find regmap for %pOF: %pe\n", node,
> regmap);
> +		return PTR_ERR(regmap);
> +	}
> +
> +	for (i = 0; i < num; i++) {
> +		const struct mtk_gate *gate = &clks[i];
> +
> +		if (!IS_ERR_OR_NULL(clk_data->clks[gate->id]))
> +			continue;
> +
> +		clk = mtk_clk_register_gate(gate->name, gate-
> >parent_name,
> +					    regmap,
> +					    gate->regs->set_ofs,
> +					    gate->regs->clr_ofs,
> +					    gate->regs->sta_ofs,
> +					    gate->shift, gate->ops,
> +					    gate->flags, dev);
> +
> +		if (IS_ERR(clk)) {
> +			pr_err("Failed to register clk %s: %pe\n",
> gate->name, clk);
> +			continue;
> +		}
> +
> +		clk_data->clks[gate->id] = clk;
> +	}
> +
> +	return 0;
> +}
> +
> +int mtk_clk_register_gates(struct device_node *node,
> +			   const struct mtk_gate *clks, int num,
> +			   struct clk_onecell_data *clk_data)
> +{
> +	return mtk_clk_register_gates_with_dev(node, clks, num,
> clk_data, NULL);
> +}
> +EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-gate.h
> b/drivers/clk/mediatek/clk-gate.h
> index 3c3329ec54b7..432b571d23b3 100644
> --- a/drivers/clk/mediatek/clk-gate.h
> +++ b/drivers/clk/mediatek/clk-gate.h
> @@ -43,6 +43,22 @@ struct clk *mtk_clk_register_gate(
>  		unsigned long flags,
>  		struct device *dev);
>  
> +struct mtk_gate_regs {
> +	u32 sta_ofs;
> +	u32 clr_ofs;
> +	u32 set_ofs;
> +};
> +
> +struct mtk_gate {
> +	int id;
> +	const char *name;
> +	const char *parent_name;
> +	const struct mtk_gate_regs *regs;
> +	int shift;
> +	const struct clk_ops *ops;
> +	unsigned long flags;
> +};
> +
>  #define GATE_MTK_FLAGS(_id, _name, _parent, _regs, _shift,	\
>  			_ops, _flags) {				\
>  		.id = _id,					\
> @@ -57,4 +73,13 @@ struct clk *mtk_clk_register_gate(
>  #define GATE_MTK(_id, _name, _parent, _regs, _shift, _ops)		
> \
>  	GATE_MTK_FLAGS(_id, _name, _parent, _regs, _shift, _ops, 0)
>  
> +int mtk_clk_register_gates(struct device_node *node,
> +			   const struct mtk_gate *clks, int num,
> +			   struct clk_onecell_data *clk_data);
> +
> +int mtk_clk_register_gates_with_dev(struct device_node *node,
> +				    const struct mtk_gate *clks, int
> num,
> +				    struct clk_onecell_data *clk_data,
> +				    struct device *dev);
> +
>  #endif /* __DRV_CLK_GATE_H */
> diff --git a/drivers/clk/mediatek/clk-mtk.c
> b/drivers/clk/mediatek/clk-mtk.c
> index 519a461cbb6f..0c5db3c71fdd 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -106,57 +106,6 @@ void mtk_clk_register_factors(const struct
> mtk_fixed_factor *clks,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
>  
> -int mtk_clk_register_gates_with_dev(struct device_node *node,
> -		const struct mtk_gate *clks,
> -		int num, struct clk_onecell_data *clk_data,
> -		struct device *dev)
> -{
> -	int i;
> -	struct clk *clk;
> -	struct regmap *regmap;
> -
> -	if (!clk_data)
> -		return -ENOMEM;
> -
> -	regmap = device_node_to_regmap(node);
> -	if (IS_ERR(regmap)) {
> -		pr_err("Cannot find regmap for %pOF: %pe\n", node,
> regmap);
> -		return PTR_ERR(regmap);
> -	}
> -
> -	for (i = 0; i < num; i++) {
> -		const struct mtk_gate *gate = &clks[i];
> -
> -		if (!IS_ERR_OR_NULL(clk_data->clks[gate->id]))
> -			continue;
> -
> -		clk = mtk_clk_register_gate(gate->name, gate-
> >parent_name,
> -				regmap,
> -				gate->regs->set_ofs,
> -				gate->regs->clr_ofs,
> -				gate->regs->sta_ofs,
> -				gate->shift, gate->ops, gate->flags,
> dev);
> -
> -		if (IS_ERR(clk)) {
> -			pr_err("Failed to register clk %s: %pe\n",
> gate->name, clk);
> -			continue;
> -		}
> -
> -		clk_data->clks[gate->id] = clk;
> -	}
> -
> -	return 0;
> -}
> -
> -int mtk_clk_register_gates(struct device_node *node,
> -		const struct mtk_gate *clks,
> -		int num, struct clk_onecell_data *clk_data)
> -{
> -	return mtk_clk_register_gates_with_dev(node,
> -		clks, num, clk_data, NULL);
> -}
> -EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
> -
>  struct clk *mtk_clk_register_composite(const struct mtk_composite
> *mc,
>  		void __iomem *base, spinlock_t *lock)
>  {
> diff --git a/drivers/clk/mediatek/clk-mtk.h
> b/drivers/clk/mediatek/clk-mtk.h
> index 0ff289d93452..bdec7dc5e07a 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -150,31 +150,6 @@ void mtk_clk_register_composites(const struct
> mtk_composite *mcs,
>  		int num, void __iomem *base, spinlock_t *lock,
>  		struct clk_onecell_data *clk_data);
>  
> -struct mtk_gate_regs {
> -	u32 sta_ofs;
> -	u32 clr_ofs;
> -	u32 set_ofs;
> -};
> -
> -struct mtk_gate {
> -	int id;
> -	const char *name;
> -	const char *parent_name;
> -	const struct mtk_gate_regs *regs;
> -	int shift;
> -	const struct clk_ops *ops;
> -	unsigned long flags;
> -};
> -
> -int mtk_clk_register_gates(struct device_node *node,
> -			const struct mtk_gate *clks, int num,
> -			struct clk_onecell_data *clk_data);
> -
> -int mtk_clk_register_gates_with_dev(struct device_node *node,
> -		const struct mtk_gate *clks,
> -		int num, struct clk_onecell_data *clk_data,
> -		struct device *dev);
> -
>  struct mtk_clk_divider {
>  	int id;
>  	const char *name;

