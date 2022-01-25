Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2983649BA3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381624AbiAYRT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:19:59 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:57506 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1356093AbiAYROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:14:15 -0500
X-UUID: 52745c4973ec4f9a8683bfd2748ab433-20220126
X-UUID: 52745c4973ec4f9a8683bfd2748ab433-20220126
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1341138552; Wed, 26 Jan 2022 01:14:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 01:14:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 01:14:07 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 07/31] clk: mediatek: cpumux: Internalize struct mtk_clk_cpumux
Date:   Wed, 26 Jan 2022 01:14:07 +0800
Message-ID: <20220125171407.32525-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-8-wenst@chromium.org>
References: <20220122091731.283592-8-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> struct mtk_clk_cpumux is an implementation detail of the cpumux clk
> type, and is not used outside of the implementation.
> 
> Internalize the definition to minimize leakage of details and shrink
> the header file.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-cpumux.c | 8 ++++++++
>  drivers/clk/mediatek/clk-cpumux.h | 8 --------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
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
>  static inline struct mtk_clk_cpumux *to_mtk_clk_cpumux(struct clk_hw *_hw)
>  {
>  	return container_of(_hw, struct mtk_clk_cpumux, hw);
> diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
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
>  			      const struct mtk_composite *clks, int num,
>  			      struct clk_onecell_data *clk_data);
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


