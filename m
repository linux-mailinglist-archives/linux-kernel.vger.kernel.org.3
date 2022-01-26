Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB04549C3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiAZGgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:36:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35392 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229699AbiAZGgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:36:48 -0500
X-UUID: c09dbdafa0f443a1aecfc4067207f8fe-20220126
X-UUID: c09dbdafa0f443a1aecfc4067207f8fe-20220126
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 352971035; Wed, 26 Jan 2022 14:36:44 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 26 Jan 2022 14:36:43 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 14:36:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 14:36:43 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 14/31] clk: mediatek: pll: Clean up included headers
Date:   Wed, 26 Jan 2022 14:36:43 +0800
Message-ID: <20220126063643.11544-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-15-wenst@chromium.org>
References: <20220122091731.283592-15-wenst@chromium.org>
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
> Also, expand the MHZ macro with spelled-out "1000 * 1000" to be able
> to not include clk-mtk.h. The existing ternary operator is rewritten
> in a shortened form to accommodate the expanded macro.

I think MHZ is more human readable than 1000*1000, 
like SZ_4K in linux/sizes.h.

MHZ is also use by other clk-mtxxxx.c (by including clk-mtk.h)
, so maybe we should keep clk-mtk.h?

Miles
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/clk/mediatek/clk-pll.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 081e0df8203e..9698d1c97cd6 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -4,15 +4,15 @@
>   * Author: James Liao <jamesjj.liao@mediatek.com>
>   */
>  
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/clk-provider.h>
> +#include <linux/container_of.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of_address.h>
>  #include <linux/slab.h>
> -#include <linux/clkdev.h>
> -#include <linux/delay.h>
>  
> -#include "clk-mtk.h"
>  #include "clk-pll.h"
>  
>  #define REG_CON0		0
> @@ -162,7 +162,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>  		u32 freq, u32 fin)
>  {
> -	unsigned long fmin = pll->data->fmin ? pll->data->fmin : (1000 * MHZ);
> +	unsigned long fmin = pll->data->fmin ?: (1000 * 1000 * 1000);
>  	const struct mtk_pll_div_table *div_table = pll->data->div_table;
>  	u64 _pcw;
>  	int ibits;
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


