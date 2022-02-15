Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F194B6367
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiBOG0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:26:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiBOG0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:26:38 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC82DE91;
        Mon, 14 Feb 2022 22:26:27 -0800 (PST)
X-UUID: d29e7747ab784e26815e4689f12baa0c-20220215
X-UUID: d29e7747ab784e26815e4689f12baa0c-20220215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 903098370; Tue, 15 Feb 2022 14:26:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Feb 2022 14:26:23 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:26:23 +0800
Message-ID: <d40d0c2ddf7d59c53d12cb57a94608425d4d2de1.camel@mediatek.com>
Subject: Re: [PATCH v3 08/31] clk: mediatek: cpumux: Clean up included
 headers
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
Date:   Tue, 15 Feb 2022 14:26:23 +0800
In-Reply-To: <20220208124034.414635-9-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-9-wenst@chromium.org>
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
> Some headers with the declaration of functions and structures aren't
> directly included. Explicitly include them so that future changes to
> other headers would not result in an unexpected build break.
> 
> On the header side, add forward declarations for any data structures
> whose pointers are used in function signatures. No headers are
> required.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-cpumux.c | 3 +++
>  drivers/clk/mediatek/clk-cpumux.h | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-cpumux.c
> b/drivers/clk/mediatek/clk-cpumux.c
> index 344c6399b22f..658aee789f44 100644
> --- a/drivers/clk/mediatek/clk-cpumux.c
> +++ b/drivers/clk/mediatek/clk-cpumux.c
> @@ -5,8 +5,11 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/container_of.h>
> +#include <linux/err.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  
>  #include "clk-mtk.h"
> diff --git a/drivers/clk/mediatek/clk-cpumux.h
> b/drivers/clk/mediatek/clk-cpumux.h
> index a538f2bbef0d..b07e89f7c283 100644
> --- a/drivers/clk/mediatek/clk-cpumux.h
> +++ b/drivers/clk/mediatek/clk-cpumux.h
> @@ -7,6 +7,10 @@
>  #ifndef __DRV_CLK_CPUMUX_H
>  #define __DRV_CLK_CPUMUX_H
>  
> +struct clk_onecell_data;
> +struct device_node;
> +struct mtk_composite;
> +
>  int mtk_clk_register_cpumuxes(struct device_node *node,
>  			      const struct mtk_composite *clks, int
> num,
>  			      struct clk_onecell_data *clk_data);

