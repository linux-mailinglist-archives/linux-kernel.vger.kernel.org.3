Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6F4B637C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiBOGbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:31:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiBOGbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:31:33 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA20411EF05;
        Mon, 14 Feb 2022 22:31:22 -0800 (PST)
X-UUID: ab763ec251604587ab6d41b6bd758adc-20220215
X-UUID: ab763ec251604587ab6d41b6bd758adc-20220215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1535810795; Tue, 15 Feb 2022 14:31:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 14:31:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:31:18 +0800
Message-ID: <48eabb5f312bf787eb89996eaa6e7c79f89fb037.camel@mediatek.com>
Subject: Re: [PATCH v3 11/31] clk: mediatek: mux: Clean up included headers
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
Date:   Tue, 15 Feb 2022 14:31:18 +0800
In-Reply-To: <20220208124034.414635-12-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-12-wenst@chromium.org>
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
> Some included headers aren't actually used anywhere, while other
> headers
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
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mux.c | 11 +++++++----
>  drivers/clk/mediatek/clk-mux.h |  8 +++++++-
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mux.c
> b/drivers/clk/mediatek/clk-mux.c
> index 2d4d8dc0120a..01af6a52711a 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -4,13 +4,16 @@
>   * Author: Owen Chen <owen.chen@mediatek.com>
>   */
>  
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/slab.h>
> +#include <linux/clk-provider.h>
> +#include <linux/compiler_types.h>
> +#include <linux/container_of.h>
> +#include <linux/err.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spinlock.h>
> +#include <linux/slab.h>
>  
> -#include "clk-mtk.h"
>  #include "clk-mux.h"
>  
>  struct mtk_clk_mux {
> diff --git a/drivers/clk/mediatek/clk-mux.h
> b/drivers/clk/mediatek/clk-mux.h
> index 38a2b6014b08..903a3c937959 100644
> --- a/drivers/clk/mediatek/clk-mux.h
> +++ b/drivers/clk/mediatek/clk-mux.h
> @@ -7,7 +7,13 @@
>  #ifndef __DRV_CLK_MTK_MUX_H
>  #define __DRV_CLK_MTK_MUX_H
>  
> -#include <linux/clk-provider.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +struct clk;
> +struct clk_onecell_data;
> +struct clk_ops;
> +struct device_node;
>  
>  struct mtk_mux {
>  	int id;

