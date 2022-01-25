Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD23549BA49
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381519AbiAYRZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:25:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54282 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1588141AbiAYRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:23:04 -0500
X-UUID: 4c06a835d9d14ecfb5cacbb2e45661db-20220126
X-UUID: 4c06a835d9d14ecfb5cacbb2e45661db-20220126
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 963116520; Wed, 26 Jan 2022 01:22:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 26 Jan 2022 01:22:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 01:22:58 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 10/31] clk: mediatek: mux: Internalize struct mtk_clk_mux
Date:   Wed, 26 Jan 2022 01:22:58 +0800
Message-ID: <20220125172258.5469-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-11-wenst@chromium.org>
References: <20220122091731.283592-11-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> struct mtk_clk_mux is an implementation detail of the mux clk type,
> and is not used outside of the implementation.
> 
> Internalize the definition to minimize leakage of details and shrink
> the header file.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mux.c | 8 ++++++++
>  drivers/clk/mediatek/clk-mux.h | 8 --------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> index 6f0c22a699c3..2d4d8dc0120a 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -13,6 +13,14 @@
>  #include "clk-mtk.h"
>  #include "clk-mux.h"
>  
> +struct mtk_clk_mux {
> +	struct clk_hw hw;
> +	struct regmap *regmap;
> +	const struct mtk_mux *data;
> +	spinlock_t *lock;
> +	bool reparent;
> +};
> +
>  static inline struct mtk_clk_mux *to_mtk_clk_mux(struct clk_hw *hw)
>  {
>  	return container_of(hw, struct mtk_clk_mux, hw);
> diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> index cb2ac4f04c58..38a2b6014b08 100644
> --- a/drivers/clk/mediatek/clk-mux.h
> +++ b/drivers/clk/mediatek/clk-mux.h
> @@ -9,14 +9,6 @@
>  
>  #include <linux/clk-provider.h>
>  
> -struct mtk_clk_mux {
> -	struct clk_hw hw;
> -	struct regmap *regmap;
> -	const struct mtk_mux *data;
> -	spinlock_t *lock;
> -	bool reparent;
> -};
> -
>  struct mtk_mux {
>  	int id;
>  	const char *name;
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


