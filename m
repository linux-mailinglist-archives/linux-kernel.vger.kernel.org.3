Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582784B635B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbiBOGXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:23:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiBOGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:23:13 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF7E11E3C8;
        Mon, 14 Feb 2022 22:23:02 -0800 (PST)
X-UUID: 1d28d14eb0e14c62b4e87553d5c2a74a-20220215
X-UUID: 1d28d14eb0e14c62b4e87553d5c2a74a-20220215
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1188313047; Tue, 15 Feb 2022 14:22:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 14:22:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:22:56 +0800
Message-ID: <278b72f20ba57a72be325ec27f40c6d28cdabf9d.camel@mediatek.com>
Subject: Re: [PATCH v3 03/31] clk: mediatek: gate: Internalize clk
 implementation
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
Date:   Tue, 15 Feb 2022 14:22:57 +0800
In-Reply-To: <20220208124034.414635-4-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-4-wenst@chromium.org>
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
> struct mtk_clk_gate and mtk_clk_register_gate() are not used outside
> of
> the gate clk library. Only the API that handles a list of clks is
> used
> by the individual platform clk drivers.
> 
> Internalize the parts that aren't used outside of the implementation.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-gate.c | 35 ++++++++++++++++++++++---------
> --
>  drivers/clk/mediatek/clk-gate.h | 31 ++---------------------------
>  2 files changed, 25 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-gate.c
> b/drivers/clk/mediatek/clk-gate.c
> index 54921768bfba..e51cfd8c653c 100644
> --- a/drivers/clk/mediatek/clk-gate.c
> +++ b/drivers/clk/mediatek/clk-gate.c
> @@ -11,11 +11,28 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/container_of.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
>  
>  #include "clk-gate.h"
>  
> +struct mtk_clk_gate {
> +	struct clk_hw	hw;
> +	struct regmap	*regmap;
> +	int		set_ofs;
> +	int		clr_ofs;
> +	int		sta_ofs;
> +	u8		bit;
> +};
> +
> +static inline struct mtk_clk_gate *to_mtk_clk_gate(struct clk_hw
> *hw)
> +{
> +	return container_of(hw, struct mtk_clk_gate, hw);
> +}
> +
>  static u32 mtk_get_clockgating(struct clk_hw *hw)
>  {
>  	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
> @@ -140,17 +157,12 @@ const struct clk_ops
> mtk_clk_gate_ops_no_setclr_inv = {
>  };
>  EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
>  
> -struct clk *mtk_clk_register_gate(
> -		const char *name,
> -		const char *parent_name,
> -		struct regmap *regmap,
> -		int set_ofs,
> -		int clr_ofs,
> -		int sta_ofs,
> -		u8 bit,
> -		const struct clk_ops *ops,
> -		unsigned long flags,
> -		struct device *dev)
> +static struct clk *mtk_clk_register_gate(const char *name,
> +					 const char *parent_name,
> +					 struct regmap *regmap, int
> set_ofs,
> +					 int clr_ofs, int sta_ofs, u8
> bit,
> +					 const struct clk_ops *ops,
> +					 unsigned long flags, struct
> device *dev)
>  {
>  	struct mtk_clk_gate *cg;
>  	struct clk *clk;
> @@ -180,7 +192,6 @@ struct clk *mtk_clk_register_gate(
>  
>  	return clk;
>  }
> -EXPORT_SYMBOL_GPL(mtk_clk_register_gate);
>  
>  int mtk_clk_register_gates_with_dev(struct device_node *node,
>  				    const struct mtk_gate *clks, int
> num,
> diff --git a/drivers/clk/mediatek/clk-gate.h
> b/drivers/clk/mediatek/clk-gate.h
> index 432b571d23b3..3d75521ba20c 100644
> --- a/drivers/clk/mediatek/clk-gate.h
> +++ b/drivers/clk/mediatek/clk-gate.h
> @@ -7,42 +7,15 @@
>  #ifndef __DRV_CLK_GATE_H
>  #define __DRV_CLK_GATE_H
>  
> -#include <linux/regmap.h>
>  #include <linux/clk-provider.h>
> -
> -struct clk;
> -
> -struct mtk_clk_gate {
> -	struct clk_hw	hw;
> -	struct regmap	*regmap;
> -	int		set_ofs;
> -	int		clr_ofs;
> -	int		sta_ofs;
> -	u8		bit;
> -};
> -
> -static inline struct mtk_clk_gate *to_mtk_clk_gate(struct clk_hw
> *hw)
> -{
> -	return container_of(hw, struct mtk_clk_gate, hw);
> -}
> +#include <linux/device.h>
> +#include <linux/of.h>
>  
>  extern const struct clk_ops mtk_clk_gate_ops_setclr;
>  extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
>  extern const struct clk_ops mtk_clk_gate_ops_no_setclr;
>  extern const struct clk_ops mtk_clk_gate_ops_no_setclr_inv;
>  
> -struct clk *mtk_clk_register_gate(
> -		const char *name,
> -		const char *parent_name,
> -		struct regmap *regmap,
> -		int set_ofs,
> -		int clr_ofs,
> -		int sta_ofs,
> -		u8 bit,
> -		const struct clk_ops *ops,
> -		unsigned long flags,
> -		struct device *dev);
> -
>  struct mtk_gate_regs {
>  	u32 sta_ofs;
>  	u32 clr_ofs;

