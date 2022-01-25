Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB249BA84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355343AbiAYRj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:39:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42414 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1355743AbiAYRiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:38:46 -0500
X-UUID: 7efdd4e424524ae382e652fcd3169434-20220126
X-UUID: 7efdd4e424524ae382e652fcd3169434-20220126
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1918787813; Wed, 26 Jan 2022 01:38:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 26 Jan 2022 01:38:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 01:38:36 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 11/31] clk: mediatek: mux: Clean up included headers
Date:   Wed, 26 Jan 2022 01:38:36 +0800
Message-ID: <20220125173836.14548-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-12-wenst@chromium.org>
References: <20220122091731.283592-12-wenst@chromium.org>
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

Is this inspired by [1]?
[1] https://lore.kernel.org/lkml/YdIfz+LMewetSaEB@gmail.com/ 

> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mux.c | 11 +++++++----
>  drivers/clk/mediatek/clk-mux.h |  8 +++++++-
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
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
> diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
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
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


