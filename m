Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99546524FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355208AbiELOTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355196AbiELOTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:19:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E7325B07C;
        Thu, 12 May 2022 07:18:58 -0700 (PDT)
X-UUID: 98a1d3fb0e0a4992a68513dab77f7ac4-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:8e345f8f-5250-4d53-bc91-30d1a7489872,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:8e345f8f-5250-4d53-bc91-30d1a7489872,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:cc0b14a7-eab7-4b74-a74d-5359964535a9,C
        OID:03e7dddcd84b,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: 98a1d3fb0e0a4992a68513dab77f7ac4-20220512
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 665620353; Thu, 12 May 2022 22:18:52 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 22:18:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 May 2022 22:18:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 May 2022 22:18:51 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <rex-bc.chen@mediatek.com>, <sboyd@kernel.org>
Subject: Re: [PATCH v2 04/11] clk: mediatek: Replace 'struct clk' with 'struct clk_hw'
Date:   Thu, 12 May 2022 22:18:51 +0800
Message-ID: <20220512141851.18252-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220510104804.544597-5-wenst@chromium.org>
References: <20220510104804.544597-5-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As part of the effort to improve the MediaTek clk drivers, the next step
> is to switch from the old 'struct clk' clk prodivder APIs to the new
> 'struct clk_hw' ones.
> 
> Instead of adding new APIs to the MediaTek clk driver library mirroring
> the existing ones, moving all drivers to the new APIs, and then removing
> the old ones, just migrate everything at the same time. This involves
> replacing 'struct clk' with 'struct clk_hw', and 'struct clk_onecell_data'
> with 'struct clk_hw_onecell_data', and fixing up all usages.
> 
> This is done with the following coccinelle script.
> 
> To avoid a really large patch, the changes have been split into multiple
> ones. This patch covers the common MediaTek clk library.
> 
>     // Replace type

...snip...

> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -21,7 +21,7 @@
>  struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
>  {
>  	int i;
> -	struct clk_onecell_data *clk_data;
> +	struct clk_hw_onecell_data *clk_data;


oh, clk_onecell_data is converted to clk_hw_onecell_data here

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 
>  
>  	clk_data = kzalloc(struct_size(clk_data, hws, clk_num), GFP_KERNEL);
>  	if (!clk_data)
> @@ -43,7 +43,7 @@ void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data)
>  EXPORT_SYMBOL_GPL(mtk_free_clk_data);
>  
>  int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> -				struct clk_onecell_data *clk_data)
> +				struct clk_hw_onecell_data *clk_data)
>  {
>  	int i;
>  	struct clk *clk;
> @@ -54,7 +54,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_fixed_clk *rc = &clks[i];
>  
> -		if (!IS_ERR_OR_NULL(clk_data->clks[rc->id])) {
> +		if (!IS_ERR_OR_NULL(clk_data->hws[rc->id])) {
>  			pr_warn("Trying to register duplicate clock ID: %d\n", rc->id);
>  			continue;
>  		}
> @@ -67,7 +67,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>  			goto err;
>  		}
>  
> -		clk_data->clks[rc->id] = clk;
> +		clk_data->hws[rc->id] = __clk_get_hw(clk);
>  	}
>  
>  	return 0;
> @@ -76,11 +76,11 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>  	while (--i >= 0) {
>  		const struct mtk_fixed_clk *rc = &clks[i];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[rc->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
>  			continue;
>  
> -		clk_unregister_fixed_rate(clk_data->clks[rc->id]);
> -		clk_data->clks[rc->id] = ERR_PTR(-ENOENT);
> +		clk_unregister_fixed_rate(clk_data->hws[rc->id]->clk);
> +		clk_data->hws[rc->id] = ERR_PTR(-ENOENT);
>  	}
>  
>  	return PTR_ERR(clk);
> @@ -88,7 +88,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>  EXPORT_SYMBOL_GPL(mtk_clk_register_fixed_clks);
>  
>  void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> -				   struct clk_onecell_data *clk_data)
> +				   struct clk_hw_onecell_data *clk_data)
>  {
>  	int i;
>  
> @@ -98,17 +98,17 @@ void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>  	for (i = num; i > 0; i--) {
>  		const struct mtk_fixed_clk *rc = &clks[i - 1];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[rc->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
>  			continue;
>  
> -		clk_unregister_fixed_rate(clk_data->clks[rc->id]);
> -		clk_data->clks[rc->id] = ERR_PTR(-ENOENT);
> +		clk_unregister_fixed_rate(clk_data->hws[rc->id]->clk);
> +		clk_data->hws[rc->id] = ERR_PTR(-ENOENT);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_unregister_fixed_clks);
>  
>  int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
> -			     struct clk_onecell_data *clk_data)
> +			     struct clk_hw_onecell_data *clk_data)
>  {
>  	int i;
>  	struct clk *clk;
> @@ -119,7 +119,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_fixed_factor *ff = &clks[i];
>  
> -		if (!IS_ERR_OR_NULL(clk_data->clks[ff->id])) {
> +		if (!IS_ERR_OR_NULL(clk_data->hws[ff->id])) {
>  			pr_warn("Trying to register duplicate clock ID: %d\n", ff->id);
>  			continue;
>  		}
> @@ -132,7 +132,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
>  			goto err;
>  		}
>  
> -		clk_data->clks[ff->id] = clk;
> +		clk_data->hws[ff->id] = __clk_get_hw(clk);
>  	}
>  
>  	return 0;
> @@ -141,11 +141,11 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
>  	while (--i >= 0) {
>  		const struct mtk_fixed_factor *ff = &clks[i];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[ff->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
>  			continue;
>  
> -		clk_unregister_fixed_factor(clk_data->clks[ff->id]);
> -		clk_data->clks[ff->id] = ERR_PTR(-ENOENT);
> +		clk_unregister_fixed_factor(clk_data->hws[ff->id]->clk);
> +		clk_data->hws[ff->id] = ERR_PTR(-ENOENT);
>  	}
>  
>  	return PTR_ERR(clk);
> @@ -153,7 +153,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
>  EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
>  
>  void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
> -				struct clk_onecell_data *clk_data)
> +				struct clk_hw_onecell_data *clk_data)
>  {
>  	int i;
>  
> @@ -163,11 +163,11 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
>  	for (i = num; i > 0; i--) {
>  		const struct mtk_fixed_factor *ff = &clks[i - 1];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[ff->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
>  			continue;
>  
> -		clk_unregister_fixed_factor(clk_data->clks[ff->id]);
> -		clk_data->clks[ff->id] = ERR_PTR(-ENOENT);
> +		clk_unregister_fixed_factor(clk_data->hws[ff->id]->clk);
> +		clk_data->hws[ff->id] = ERR_PTR(-ENOENT);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_unregister_factors);
> @@ -287,7 +287,7 @@ static void mtk_clk_unregister_composite(struct clk *clk)
>  
>  int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
>  				void __iomem *base, spinlock_t *lock,
> -				struct clk_onecell_data *clk_data)
> +				struct clk_hw_onecell_data *clk_data)
>  {
>  	struct clk *clk;
>  	int i;
> @@ -298,7 +298,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_composite *mc = &mcs[i];
>  
> -		if (!IS_ERR_OR_NULL(clk_data->clks[mc->id])) {
> +		if (!IS_ERR_OR_NULL(clk_data->hws[mc->id])) {
>  			pr_warn("Trying to register duplicate clock ID: %d\n",
>  				mc->id);
>  			continue;
> @@ -311,7 +311,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
>  			goto err;
>  		}
>  
> -		clk_data->clks[mc->id] = clk;
> +		clk_data->hws[mc->id] = __clk_get_hw(clk);
>  	}
>  
>  	return 0;
> @@ -320,11 +320,11 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
>  	while (--i >= 0) {
>  		const struct mtk_composite *mc = &mcs[i];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[mcs->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[mcs->id]))
>  			continue;
>  
> -		mtk_clk_unregister_composite(clk_data->clks[mc->id]);
> -		clk_data->clks[mc->id] = ERR_PTR(-ENOENT);
> +		mtk_clk_unregister_composite(clk_data->hws[mc->id]->clk);
> +		clk_data->hws[mc->id] = ERR_PTR(-ENOENT);
>  	}
>  
>  	return PTR_ERR(clk);
> @@ -332,7 +332,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
>  EXPORT_SYMBOL_GPL(mtk_clk_register_composites);
>  
>  void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
> -				   struct clk_onecell_data *clk_data)
> +				   struct clk_hw_onecell_data *clk_data)
>  {
>  	int i;
>  
> @@ -342,18 +342,18 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
>  	for (i = num; i > 0; i--) {
>  		const struct mtk_composite *mc = &mcs[i - 1];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[mc->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[mc->id]))
>  			continue;
>  
> -		mtk_clk_unregister_composite(clk_data->clks[mc->id]);
> -		clk_data->clks[mc->id] = ERR_PTR(-ENOENT);
> +		mtk_clk_unregister_composite(clk_data->hws[mc->id]->clk);
> +		clk_data->hws[mc->id] = ERR_PTR(-ENOENT);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_unregister_composites);
>  
>  int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
>  			      void __iomem *base, spinlock_t *lock,
> -			      struct clk_onecell_data *clk_data)
> +			      struct clk_hw_onecell_data *clk_data)
>  {
>  	struct clk *clk;
>  	int i;
> @@ -364,7 +364,7 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
>  	for (i = 0; i <  num; i++) {
>  		const struct mtk_clk_divider *mcd = &mcds[i];
>  
> -		if (!IS_ERR_OR_NULL(clk_data->clks[mcd->id])) {
> +		if (!IS_ERR_OR_NULL(clk_data->hws[mcd->id])) {
>  			pr_warn("Trying to register duplicate clock ID: %d\n",
>  				mcd->id);
>  			continue;
> @@ -379,7 +379,7 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
>  			goto err;
>  		}
>  
> -		clk_data->clks[mcd->id] = clk;
> +		clk_data->hws[mcd->id] = __clk_get_hw(clk);
>  	}
>  
>  	return 0;
> @@ -388,18 +388,18 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
>  	while (--i >= 0) {
>  		const struct mtk_clk_divider *mcd = &mcds[i];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
>  			continue;
>  
> -		mtk_clk_unregister_composite(clk_data->clks[mcd->id]);
> -		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
> +		mtk_clk_unregister_composite(clk_data->hws[mcd->id]->clk);
> +		clk_data->hws[mcd->id] = ERR_PTR(-ENOENT);
>  	}
>  
>  	return PTR_ERR(clk);
>  }
>  
>  void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
> -				 struct clk_onecell_data *clk_data)
> +				 struct clk_hw_onecell_data *clk_data)
>  {
>  	int i;
>  
> @@ -409,18 +409,18 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
>  	for (i = num; i > 0; i--) {
>  		const struct mtk_clk_divider *mcd = &mcds[i - 1];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
>  			continue;
>  
> -		clk_unregister_divider(clk_data->clks[mcd->id]);
> -		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
> +		clk_unregister_divider(clk_data->hws[mcd->id]->clk);
> +		clk_data->hws[mcd->id] = ERR_PTR(-ENOENT);
>  	}
>  }
>  
>  int mtk_clk_simple_probe(struct platform_device *pdev)
>  {
>  	const struct mtk_clk_desc *mcd;
> -	struct clk_onecell_data *clk_data;
> +	struct clk_hw_onecell_data *clk_data;
>  	struct device_node *node = pdev->dev.of_node;
>  	int r;
>  
> @@ -436,7 +436,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>  	if (r)
>  		goto free_data;
>  
> -	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>  	if (r)
>  		goto unregister_clks;
>  
> @@ -454,7 +454,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
>  int mtk_clk_simple_remove(struct platform_device *pdev)
>  {
>  	const struct mtk_clk_desc *mcd = of_device_get_match_data(&pdev->dev);
> -	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
>  	struct device_node *node = pdev->dev.of_node;
>  
>  	of_clk_del_provider(node);
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index 787fdeb1bd93..e736420170a2 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -35,9 +35,9 @@ struct mtk_fixed_clk {
>  	}
>  
>  int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> -				struct clk_onecell_data *clk_data);
> +				struct clk_hw_onecell_data *clk_data);
>  void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> -				   struct clk_onecell_data *clk_data);
> +				   struct clk_hw_onecell_data *clk_data);
>  
>  struct mtk_fixed_factor {
>  	int id;
> @@ -56,9 +56,9 @@ struct mtk_fixed_factor {
>  	}
>  
>  int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
> -			     struct clk_onecell_data *clk_data);
> +			     struct clk_hw_onecell_data *clk_data);
>  void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
> -				struct clk_onecell_data *clk_data);
> +				struct clk_hw_onecell_data *clk_data);
>  
>  struct mtk_composite {
>  	int id;
> @@ -149,9 +149,9 @@ struct mtk_composite {
>  
>  int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
>  				void __iomem *base, spinlock_t *lock,
> -				struct clk_onecell_data *clk_data);
> +				struct clk_hw_onecell_data *clk_data);
>  void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
> -				   struct clk_onecell_data *clk_data);
> +				   struct clk_hw_onecell_data *clk_data);
>  
>  struct mtk_clk_divider {
>  	int id;
> @@ -177,9 +177,9 @@ struct mtk_clk_divider {
>  
>  int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
>  			      void __iomem *base, spinlock_t *lock,
> -			      struct clk_onecell_data *clk_data);
> +			      struct clk_hw_onecell_data *clk_data);
>  void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
> -				 struct clk_onecell_data *clk_data);
> +				 struct clk_hw_onecell_data *clk_data);
>  
>  struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
>  void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data);
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> index 21ad5a4afd65..2f47e59cc528 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -193,7 +193,7 @@ static void mtk_clk_unregister_mux(struct clk *clk)
>  int mtk_clk_register_muxes(const struct mtk_mux *muxes,
>  			   int num, struct device_node *node,
>  			   spinlock_t *lock,
> -			   struct clk_onecell_data *clk_data)
> +			   struct clk_hw_onecell_data *clk_data)
>  {
>  	struct regmap *regmap;
>  	struct clk *clk;
> @@ -208,7 +208,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_mux *mux = &muxes[i];
>  
> -		if (!IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
> +		if (!IS_ERR_OR_NULL(clk_data->hws[mux->id])) {
>  			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
>  				node, mux->id);
>  			continue;
> @@ -221,7 +221,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
>  			goto err;
>  		}
>  
> -		clk_data->clks[mux->id] = clk;
> +		clk_data->hws[mux->id] = __clk_get_hw(clk);
>  	}
>  
>  	return 0;
> @@ -230,11 +230,11 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
>  	while (--i >= 0) {
>  		const struct mtk_mux *mux = &muxes[i];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
>  			continue;
>  
> -		mtk_clk_unregister_mux(clk_data->clks[mux->id]);
> -		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
> +		mtk_clk_unregister_mux(clk_data->hws[mux->id]->clk);
> +		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
>  	}
>  
>  	return PTR_ERR(clk);
> @@ -242,7 +242,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
>  EXPORT_SYMBOL_GPL(mtk_clk_register_muxes);
>  
>  void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
> -			      struct clk_onecell_data *clk_data)
> +			      struct clk_hw_onecell_data *clk_data)
>  {
>  	int i;
>  
> @@ -252,11 +252,11 @@ void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
>  	for (i = num; i > 0; i--) {
>  		const struct mtk_mux *mux = &muxes[i - 1];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
>  			continue;
>  
> -		mtk_clk_unregister_mux(clk_data->clks[mux->id]);
> -		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
> +		mtk_clk_unregister_mux(clk_data->hws[mux->id]->clk);
> +		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_unregister_muxes);
> diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> index 903a3c937959..6539c58f5d7d 100644
> --- a/drivers/clk/mediatek/clk-mux.h
> +++ b/drivers/clk/mediatek/clk-mux.h
> @@ -11,7 +11,7 @@
>  #include <linux/types.h>
>  
>  struct clk;
> -struct clk_onecell_data;
> +struct clk_hw_onecell_data;
>  struct clk_ops;
>  struct device_node;
>  
> @@ -84,9 +84,9 @@ extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
>  int mtk_clk_register_muxes(const struct mtk_mux *muxes,
>  			   int num, struct device_node *node,
>  			   spinlock_t *lock,
> -			   struct clk_onecell_data *clk_data);
> +			   struct clk_hw_onecell_data *clk_data);
>  
>  void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
> -			      struct clk_onecell_data *clk_data);
> +			      struct clk_hw_onecell_data *clk_data);
>  
>  #endif /* __DRV_CLK_MTK_MUX_H */
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index ccaa2085ab4d..89350a1a158c 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -379,7 +379,7 @@ static void mtk_clk_unregister_pll(struct clk *clk)
>  
>  int mtk_clk_register_plls(struct device_node *node,
>  			  const struct mtk_pll_data *plls, int num_plls,
> -			  struct clk_onecell_data *clk_data)
> +			  struct clk_hw_onecell_data *clk_data)
>  {
>  	void __iomem *base;
>  	int i;
> @@ -394,7 +394,7 @@ int mtk_clk_register_plls(struct device_node *node,
>  	for (i = 0; i < num_plls; i++) {
>  		const struct mtk_pll_data *pll = &plls[i];
>  
> -		if (!IS_ERR_OR_NULL(clk_data->clks[pll->id])) {
> +		if (!IS_ERR_OR_NULL(clk_data->hws[pll->id])) {
>  			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
>  				node, pll->id);
>  			continue;
> @@ -407,7 +407,7 @@ int mtk_clk_register_plls(struct device_node *node,
>  			goto err;
>  		}
>  
> -		clk_data->clks[pll->id] = clk;
> +		clk_data->hws[pll->id] = __clk_get_hw(clk);
>  	}
>  
>  	return 0;
> @@ -416,8 +416,8 @@ int mtk_clk_register_plls(struct device_node *node,
>  	while (--i >= 0) {
>  		const struct mtk_pll_data *pll = &plls[i];
>  
> -		mtk_clk_unregister_pll(clk_data->clks[pll->id]);
> -		clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
> +		mtk_clk_unregister_pll(clk_data->hws[pll->id]->clk);
> +		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
>  	}
>  
>  	iounmap(base);
> @@ -426,17 +426,16 @@ int mtk_clk_register_plls(struct device_node *node,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
>  
> -static __iomem void *mtk_clk_pll_get_base(struct clk *clk,
> +static __iomem void *mtk_clk_pll_get_base(struct clk_hw *hw,
>  					  const struct mtk_pll_data *data)
>  {
> -	struct clk_hw *hw = __clk_get_hw(clk);
>  	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
>  
>  	return pll->base_addr - data->reg;
>  }
>  
>  void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
> -			     struct clk_onecell_data *clk_data)
> +			     struct clk_hw_onecell_data *clk_data)
>  {
>  	__iomem void *base = NULL;
>  	int i;
> @@ -447,7 +446,7 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
>  	for (i = num_plls; i > 0; i--) {
>  		const struct mtk_pll_data *pll = &plls[i - 1];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[pll->id]))
> +		if (IS_ERR_OR_NULL(clk_data->hws[pll->id]))
>  			continue;
>  
>  		/*
> @@ -456,10 +455,10 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
>  		 * pointer to the I/O region base address. We have to fetch
>  		 * it from one of the registered clks.
>  		 */
> -		base = mtk_clk_pll_get_base(clk_data->clks[pll->id], pll);
> +		base = mtk_clk_pll_get_base(clk_data->hws[pll->id], pll);
>  
> -		mtk_clk_unregister_pll(clk_data->clks[pll->id]);
> -		clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
> +		mtk_clk_unregister_pll(clk_data->hws[pll->id]->clk);
> +		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
>  	}
>  
>  	iounmap(base);
> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
> index bf06e44caef9..fe3199715688 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -10,7 +10,7 @@
>  #include <linux/types.h>
>  
>  struct clk_ops;
> -struct clk_onecell_data;
> +struct clk_hw_onecell_data;
>  struct device_node;
>  
>  struct mtk_pll_div_table {
> @@ -50,8 +50,8 @@ struct mtk_pll_data {
>  
>  int mtk_clk_register_plls(struct device_node *node,
>  			  const struct mtk_pll_data *plls, int num_plls,
> -			  struct clk_onecell_data *clk_data);
> +			  struct clk_hw_onecell_data *clk_data);
>  void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
> -			     struct clk_onecell_data *clk_data);
> +			     struct clk_hw_onecell_data *clk_data);
>  
>  #endif /* __DRV_CLK_MTK_PLL_H */
> -- 
> 2.36.0.512.ge40c2bad7a-goog
> 
> 
