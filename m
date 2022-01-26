Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0C849C445
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiAZH0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:26:50 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59284 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229611AbiAZH0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:26:49 -0500
X-UUID: 574cc1b3af99408e9e28e990f9345e1a-20220126
X-UUID: 574cc1b3af99408e9e28e990f9345e1a-20220126
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1880652506; Wed, 26 Jan 2022 15:26:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 26 Jan 2022 15:26:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 15:26:47 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 20/31] clk: mediatek: mtk: Clean up included headers
Date:   Wed, 26 Jan 2022 15:26:47 +0800
Message-ID: <20220126072647.8794-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-21-wenst@chromium.org>
References: <20220122091731.283592-21-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Some included headers aren't actually used anywhere, while other headers
> with the declaration of functions and structures aren't directly
> included.
> 
> Get rid of the unused ones, and add the ones that should be included
> directly.
> 
> On the header side, replace headers that are included purely for data
> structure definitions with forward declarations. This decreases the
> amount of preprocessing and compilation effort required for each
> inclusion.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 13 ++++++-------
>  drivers/clk/mediatek/clk-mtk.h | 12 ++++++------
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index cd76e1d80242..d2c50186cceb 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -4,17 +4,16 @@
>   * Author: James Liao <jamesjj.liao@mediatek.com>
>   */
>  
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/bitops.h>
> +#include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> -#include <linux/slab.h>
> -#include <linux/delay.h>
> -#include <linux/clkdev.h>
> -#include <linux/module.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
>  
>  #include "clk-mtk.h"
>  #include "clk-gate.h"
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index 4fa658f5d934..7f902581a115 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -7,19 +7,19 @@
>  #ifndef __DRV_CLK_MTK_H
>  #define __DRV_CLK_MTK_H
>  
> -#include <linux/regmap.h>
> -#include <linux/bitops.h>
>  #include <linux/clk-provider.h>
> -#include <linux/platform_device.h>
> -
> -struct clk;
> -struct clk_onecell_data;
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
>  
>  #define MAX_MUX_GATE_BIT	31
>  #define INVALID_MUX_GATE_BIT	(MAX_MUX_GATE_BIT + 1)
>  
>  #define MHZ (1000 * 1000)
>  
> +struct platform_device;
> +
>  struct mtk_fixed_clk {
>  	int id;
>  	const char *name;
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


