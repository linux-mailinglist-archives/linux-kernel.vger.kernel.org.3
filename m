Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A1D49C376
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiAZGG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:06:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40626 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229484AbiAZGG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:06:27 -0500
X-UUID: 31dc0f218e4e4853bbd7d060185972bd-20220126
X-UUID: 31dc0f218e4e4853bbd7d060185972bd-20220126
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 869002916; Wed, 26 Jan 2022 14:06:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 14:06:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 14:06:20 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 12/31] clk: mediatek: pll: Split definitions into separate header file
Date:   Wed, 26 Jan 2022 14:06:20 +0800
Message-ID: <20220126060620.25823-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-13-wenst@chromium.org>
References: <20220122091731.283592-13-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When the PLL type clk was implemented in the MediaTek clk driver
> library, the data structure definitions and function declaration
> were put in the common header file.
> 
> Since it is its own type of clk, and not all platform clk drivers
> utilize it, having the definitions in the common header results
> in wasted cycles during compilation.
> 
> Split out the related definitions and declarations into its own
> header file, and include that only in the platform clk drivers that
> need it.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt2701.c            |  5 +-
>  drivers/clk/mediatek/clk-mt2712.c            |  3 +-
>  drivers/clk/mediatek/clk-mt6765.c            |  3 +-
>  drivers/clk/mediatek/clk-mt6779.c            |  3 +-
>  drivers/clk/mediatek/clk-mt6797.c            |  3 +-
>  drivers/clk/mediatek/clk-mt7622.c            |  5 +-
>  drivers/clk/mediatek/clk-mt7629.c            |  5 +-
>  drivers/clk/mediatek/clk-mt7986-apmixed.c    |  4 +-
>  drivers/clk/mediatek/clk-mt8135.c            |  3 +-
>  drivers/clk/mediatek/clk-mt8167.c            |  3 +-
>  drivers/clk/mediatek/clk-mt8173.c            |  5 +-
>  drivers/clk/mediatek/clk-mt8183.c            |  3 +-
>  drivers/clk/mediatek/clk-mt8192.c            |  3 +-
>  drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  1 +
>  drivers/clk/mediatek/clk-mt8195-apusys_pll.c |  1 +
>  drivers/clk/mediatek/clk-mt8516.c            |  3 +-
>  drivers/clk/mediatek/clk-mtk.h               | 39 --------------
>  drivers/clk/mediatek/clk-pll.c               |  1 +
>  drivers/clk/mediatek/clk-pll.h               | 55 ++++++++++++++++++++
>  19 files changed, 91 insertions(+), 57 deletions(-)
>  create mode 100644 drivers/clk/mediatek/clk-pll.h
> 
> diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
> index 695be0f77427..1eb3e4563c3f 100644
> --- a/drivers/clk/mediatek/clk-mt2701.c
> +++ b/drivers/clk/mediatek/clk-mt2701.c
> @@ -10,9 +10,10 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
> -#include "clk-mtk.h"
> -#include "clk-gate.h"
>  #include "clk-cpumux.h"
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt2701-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
> index a3bd9a107209..ff72b9ab945b 100644
> --- a/drivers/clk/mediatek/clk-mt2712.c
> +++ b/drivers/clk/mediatek/clk-mt2712.c
> @@ -13,8 +13,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> -#include "clk-mtk.h"
>  #include "clk-gate.h"
> +#include "clk-pll.h"
> +#include "clk-mtk.h"
>  
>  #include <dt-bindings/clock/mt2712-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
> index d77ea5aff292..24829ca3bd1f 100644
> --- a/drivers/clk/mediatek/clk-mt6765.c
> +++ b/drivers/clk/mediatek/clk-mt6765.c
> @@ -12,9 +12,10 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
> -#include "clk-mtk.h"
>  #include "clk-gate.h"
> +#include "clk-mtk.h"
>  #include "clk-mux.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt6765-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
> index 9825385c9f94..7b61664da18f 100644
> --- a/drivers/clk/mediatek/clk-mt6779.c
> +++ b/drivers/clk/mediatek/clk-mt6779.c
> @@ -10,9 +10,10 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
> +#include "clk-gate.h"
>  #include "clk-mtk.h"
>  #include "clk-mux.h"
> -#include "clk-gate.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt6779-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
> index 428eb24ffec5..02259e81625a 100644
> --- a/drivers/clk/mediatek/clk-mt6797.c
> +++ b/drivers/clk/mediatek/clk-mt6797.c
> @@ -9,8 +9,9 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
> -#include "clk-mtk.h"
>  #include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt6797-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
> index ef5947e15c75..0e1fb30a1e98 100644
> --- a/drivers/clk/mediatek/clk-mt7622.c
> +++ b/drivers/clk/mediatek/clk-mt7622.c
> @@ -11,9 +11,10 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
> -#include "clk-mtk.h"
> -#include "clk-gate.h"
>  #include "clk-cpumux.h"
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt7622-clk.h>
>  #include <linux/clk.h> /* for consumer */
> diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
> index a0ee079670c7..c0e023bf31eb 100644
> --- a/drivers/clk/mediatek/clk-mt7629.c
> +++ b/drivers/clk/mediatek/clk-mt7629.c
> @@ -12,9 +12,10 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
> -#include "clk-mtk.h"
> -#include "clk-gate.h"
>  #include "clk-cpumux.h"
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt7629-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
> index 98ec3887585f..21d4c82e782a 100644
> --- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
> +++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
> @@ -10,9 +10,11 @@
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> -#include "clk-mtk.h"
> +
>  #include "clk-gate.h"
> +#include "clk-mtk.h"
>  #include "clk-mux.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt7986-clk.h>
>  #include <linux/clk.h>
> diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
> index 9b4b645aea99..09ad272d51f1 100644
> --- a/drivers/clk/mediatek/clk-mt8135.c
> +++ b/drivers/clk/mediatek/clk-mt8135.c
> @@ -11,8 +11,9 @@
>  #include <linux/mfd/syscon.h>
>  #include <dt-bindings/clock/mt8135-clk.h>
>  
> -#include "clk-mtk.h"
>  #include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  static DEFINE_SPINLOCK(mt8135_clk_lock);
>  
> diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
> index e5ea10e31799..812b33a57530 100644
> --- a/drivers/clk/mediatek/clk-mt8167.c
> +++ b/drivers/clk/mediatek/clk-mt8167.c
> @@ -12,8 +12,9 @@
>  #include <linux/slab.h>
>  #include <linux/mfd/syscon.h>
>  
> -#include "clk-mtk.h"
>  #include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt8167-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> index 8f898ac476c0..46b7655feeaa 100644
> --- a/drivers/clk/mediatek/clk-mt8173.c
> +++ b/drivers/clk/mediatek/clk-mt8173.c
> @@ -8,9 +8,10 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  
> -#include "clk-mtk.h"
> -#include "clk-gate.h"
>  #include "clk-cpumux.h"
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt8173-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> index 5046852eb0fd..68496554dd3d 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -11,9 +11,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> +#include "clk-gate.h"
>  #include "clk-mtk.h"
>  #include "clk-mux.h"
> -#include "clk-gate.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt8183-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
> index cbc7c6dbe0f4..5f998aab3bfd 100644
> --- a/drivers/clk/mediatek/clk-mt8192.c
> +++ b/drivers/clk/mediatek/clk-mt8192.c
> @@ -12,9 +12,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> +#include "clk-gate.h"
>  #include "clk-mtk.h"
>  #include "clk-mux.h"
> -#include "clk-gate.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt8192-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> index 6156ceeed71e..5b1b7dc447eb 100644
> --- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> @@ -5,6 +5,7 @@
>  
>  #include "clk-gate.h"
>  #include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt8195-clk.h>
>  #include <linux/of_device.h>
> diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> index f1c84186346e..db449ff877d7 100644
> --- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> +++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> @@ -4,6 +4,7 @@
>  // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
>  
>  #include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt8195-clk.h>
>  #include <linux/clk-provider.h>
> diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
> index 9d4261ecc760..a37143f920ce 100644
> --- a/drivers/clk/mediatek/clk-mt8516.c
> +++ b/drivers/clk/mediatek/clk-mt8516.c
> @@ -11,8 +11,9 @@
>  #include <linux/slab.h>
>  #include <linux/mfd/syscon.h>
>  
> -#include "clk-mtk.h"
>  #include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  #include <dt-bindings/clock/mt8516-clk.h>
>  
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index bdec7dc5e07a..168220f85489 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -179,45 +179,6 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
>  struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
>  void mtk_free_clk_data(struct clk_onecell_data *clk_data);
>  
> -#define HAVE_RST_BAR	BIT(0)
> -#define PLL_AO		BIT(1)
> -
> -struct mtk_pll_div_table {
> -	u32 div;
> -	unsigned long freq;
> -};
> -
> -struct mtk_pll_data {
> -	int id;
> -	const char *name;
> -	u32 reg;
> -	u32 pwr_reg;
> -	u32 en_mask;
> -	u32 pd_reg;
> -	u32 tuner_reg;
> -	u32 tuner_en_reg;
> -	u8 tuner_en_bit;
> -	int pd_shift;
> -	unsigned int flags;
> -	const struct clk_ops *ops;
> -	u32 rst_bar_mask;
> -	unsigned long fmin;
> -	unsigned long fmax;
> -	int pcwbits;
> -	int pcwibits;
> -	u32 pcw_reg;
> -	int pcw_shift;
> -	u32 pcw_chg_reg;
> -	const struct mtk_pll_div_table *div_table;
> -	const char *parent_name;
> -	u32 en_reg;
> -	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
> -};
> -
> -void mtk_clk_register_plls(struct device_node *node,
> -		const struct mtk_pll_data *plls, int num_plls,
> -		struct clk_onecell_data *clk_data);
> -
>  struct clk *mtk_clk_register_ref2usb_tx(const char *name,
>  			const char *parent_name, void __iomem *reg);
>  
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index f04f724e12e5..64f59554bc9b 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  
>  #include "clk-mtk.h"
> +#include "clk-pll.h"
>  
>  #define REG_CON0		0
>  #define REG_CON1		4
> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
> new file mode 100644
> index 000000000000..d01b0c38311d
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: James Liao <jamesjj.liao@mediatek.com>
> + */
> +
> +#ifndef __DRV_CLK_MTK_PLL_H
> +#define __DRV_CLK_MTK_PLL_H
> +
> +#include <linux/types.h>
> +
> +struct clk_ops;
> +struct clk_onecell_data;
> +struct device_node;
> +
> +struct mtk_pll_div_table {
> +	u32 div;
> +	unsigned long freq;
> +};
> +
> +#define HAVE_RST_BAR	BIT(0)
> +#define PLL_AO		BIT(1)
> +
> +struct mtk_pll_data {
> +	int id;
> +	const char *name;
> +	u32 reg;
> +	u32 pwr_reg;
> +	u32 en_mask;
> +	u32 pd_reg;
> +	u32 tuner_reg;
> +	u32 tuner_en_reg;
> +	u8 tuner_en_bit;
> +	int pd_shift;
> +	unsigned int flags;
> +	const struct clk_ops *ops;
> +	u32 rst_bar_mask;
> +	unsigned long fmin;
> +	unsigned long fmax;
> +	int pcwbits;
> +	int pcwibits;
> +	u32 pcw_reg;
> +	int pcw_shift;
> +	u32 pcw_chg_reg;
> +	const struct mtk_pll_div_table *div_table;
> +	const char *parent_name;
> +	u32 en_reg;
> +	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
> +};
> +
> +void mtk_clk_register_plls(struct device_node *node,
> +			   const struct mtk_pll_data *plls, int num_plls,
> +			   struct clk_onecell_data *clk_data);
> +
> +#endif /* __DRV_CLK_MTK_PLL_H */
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 
> 
