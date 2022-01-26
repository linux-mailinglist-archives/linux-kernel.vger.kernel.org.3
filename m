Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1124649C4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiAZHms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:42:48 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52184 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238104AbiAZHmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:42:46 -0500
X-UUID: 03a15b6a7ae742919c2bd10d56a0946d-20220126
X-UUID: 03a15b6a7ae742919c2bd10d56a0946d-20220126
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 586552892; Wed, 26 Jan 2022 15:42:43 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 15:42:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 15:42:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 15:42:42 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 22/31] clk: mediatek: gate: Implement error handling in register API
Date:   Wed, 26 Jan 2022 15:42:42 +0800
Message-ID: <20220126074242.18291-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-23-wenst@chromium.org>
References: <20220122091731.283592-23-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The gate clk type registration function does not stop or return errors
> if any clk failed to be registered, nor does it implement an error
> handling path. This may result in a partially working device if any
> step failed.
> 
> Make the register function return proper error codes, and bail out if
> errors occur. Proper cleanup, i.e. unregister any clks that were
> successfully registered, is done in the new error path.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-gate.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
> index e8881ae1489a..631ff170b7b9 100644
> --- a/drivers/clk/mediatek/clk-gate.c
> +++ b/drivers/clk/mediatek/clk-gate.c
> @@ -237,13 +237,26 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", gate->name, clk);
> -			continue;
> +			goto err;
>  		}
>  
>  		clk_data->clks[gate->id] = clk;
>  	}
>  
>  	return 0;
> +
> +err:
> +	while (--i >= 0) {
> +		const struct mtk_gate *gate = &clks[i];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[gate->id]))
> +			continue;
> +
> +		mtk_clk_unregister_gate(clk_data->clks[gate->id]);
> +		clk_data->clks[gate->id] = ERR_PTR(-ENOENT);
> +	}
> +
> +	return PTR_ERR(clk);
>  }
>  
>  int mtk_clk_register_gates(struct device_node *node,
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


