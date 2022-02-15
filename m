Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C1F4B63AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiBOGiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:38:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiBOGiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:38:12 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC0BAF1F6;
        Mon, 14 Feb 2022 22:38:02 -0800 (PST)
X-UUID: 4e5b4825907f44da96eb9337f211895d-20220215
X-UUID: 4e5b4825907f44da96eb9337f211895d-20220215
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 207309602; Tue, 15 Feb 2022 14:37:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 14:37:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:37:56 +0800
Message-ID: <42d78659a50a98845e9bce47abcfe4bc3dff2c8c.camel@mediatek.com>
Subject: Re: [PATCH v3 19/31] clk: mediatek: Add mtk_clk_simple_remove()
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
Date:   Tue, 15 Feb 2022 14:37:56 +0800
In-Reply-To: <20220208124034.414635-20-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-20-wenst@chromium.org>
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
> In commit c58cd0e40ffa ("clk: mediatek: Add mtk_clk_simple_probe() to
> simplify clock providers"), a generic probe function was added to
> simplify clk drivers that only needed to support clk gates. However
> due
> to the lack of unregister APIs, a corresponding remove function was
> not
> added.
> 
> Now that the unregister APIs have been implemented, add
> aforementioned
> remove function to make it complete.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c
> b/drivers/clk/mediatek/clk-mtk.c
> index 869e6ae55c82..f108786caeda 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -374,6 +374,8 @@ int mtk_clk_simple_probe(struct platform_device
> *pdev)
>  	if (r)
>  		goto free_data;
>  
> +	platform_set_drvdata(pdev, clk_data);
> +
>  	return r;
>  
>  free_data:
> @@ -381,4 +383,17 @@ int mtk_clk_simple_probe(struct platform_device
> *pdev)
>  	return r;
>  }
>  
> +int mtk_clk_simple_remove(struct platform_device *pdev)
> +{
> +	const struct mtk_clk_desc *mcd =
> of_device_get_match_data(&pdev->dev);
> +	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
> +	struct device_node *node = pdev->dev.of_node;
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mtk.h
> b/drivers/clk/mediatek/clk-mtk.h
> index 3c3a934f53cd..4fa658f5d934 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -202,5 +202,6 @@ struct mtk_clk_desc {
>  };
>  
>  int mtk_clk_simple_probe(struct platform_device *pdev);
> +int mtk_clk_simple_remove(struct platform_device *pdev);
>  
>  #endif /* __DRV_CLK_MTK_H */

