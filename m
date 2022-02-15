Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815574B6365
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiBOG0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:26:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiBOG0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:26:10 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FBF11E3D5;
        Mon, 14 Feb 2022 22:26:00 -0800 (PST)
X-UUID: 06a8af8cb159448fa9be1998a8924329-20220215
X-UUID: 06a8af8cb159448fa9be1998a8924329-20220215
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 743118422; Tue, 15 Feb 2022 14:25:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 14:25:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:25:55 +0800
Message-ID: <89214251d40f78f5a11499c88a71cc7bf58e98de.camel@mediatek.com>
Subject: Re: [PATCH v3 07/31] clk: mediatek: cpumux: Internalize struct
 mtk_clk_cpumux
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
Date:   Tue, 15 Feb 2022 14:25:55 +0800
In-Reply-To: <20220208124034.414635-8-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-8-wenst@chromium.org>
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
> struct mtk_clk_cpumux is an implementation detail of the cpumux clk
> type, and is not used outside of the implementation.
> 
> Internalize the definition to minimize leakage of details and shrink
> the header file.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-cpumux.c | 8 ++++++++
>  drivers/clk/mediatek/clk-cpumux.h | 8 --------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-cpumux.c
> b/drivers/clk/mediatek/clk-cpumux.c
> index 99a819e3673f..344c6399b22f 100644
> --- a/drivers/clk/mediatek/clk-cpumux.c
> +++ b/drivers/clk/mediatek/clk-cpumux.c
> @@ -12,6 +12,14 @@
>  #include "clk-mtk.h"
>  #include "clk-cpumux.h"
>  
> +struct mtk_clk_cpumux {
> +	struct clk_hw	hw;
> +	struct regmap	*regmap;
> +	u32		reg;
> +	u32		mask;
> +	u8		shift;
> +};
> +
>  static inline struct mtk_clk_cpumux *to_mtk_clk_cpumux(struct clk_hw
> *_hw)
>  {
>  	return container_of(_hw, struct mtk_clk_cpumux, hw);
> diff --git a/drivers/clk/mediatek/clk-cpumux.h
> b/drivers/clk/mediatek/clk-cpumux.h
> index fda7770fd803..a538f2bbef0d 100644
> --- a/drivers/clk/mediatek/clk-cpumux.h
> +++ b/drivers/clk/mediatek/clk-cpumux.h
> @@ -7,14 +7,6 @@
>  #ifndef __DRV_CLK_CPUMUX_H
>  #define __DRV_CLK_CPUMUX_H
>  
> -struct mtk_clk_cpumux {
> -	struct clk_hw	hw;
> -	struct regmap	*regmap;
> -	u32		reg;
> -	u32		mask;
> -	u8		shift;
> -};
> -
>  int mtk_clk_register_cpumuxes(struct device_node *node,
>  			      const struct mtk_composite *clks, int
> num,
>  			      struct clk_onecell_data *clk_data);

