Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2B94DC267
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiCQJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiCQJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:16:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C10F65D6;
        Thu, 17 Mar 2022 02:14:46 -0700 (PDT)
X-UUID: 6d811081027345b2a724fe939a06c0be-20220317
X-UUID: 6d811081027345b2a724fe939a06c0be-20220317
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 248666534; Thu, 17 Mar 2022 17:14:44 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 17 Mar 2022 17:14:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Mar
 2022 17:14:42 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 17:14:42 +0800
Message-ID: <42ab6ee6bdad6157a9d24197cd9d0311da0423e7.camel@mediatek.com>
Subject: Re: [PATCH V4 6/6] spi: mediatek: support hclk
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Thu, 17 Mar 2022 17:14:42 +0800
In-Reply-To: <e3facd86-9e93-bda7-b6dd-c18f1660466a@collabora.com>
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
         <20220315032411.2826-7-leilk.liu@mediatek.com>
         <e3facd86-9e93-bda7-b6dd-c18f1660466a@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-15 at 10:37 +0100, AngeloGioacchino Del Regno wrote:
> Il 15/03/22 04:24, Leilk Liu ha scritto:
> > this patch adds hclk support.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >   drivers/spi/spi-mt65xx.c | 85 ++++++++++++++++++++++++++++++++---
> > -----
> >   1 file changed, 69 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> > index 8958c3fa4fea..d4a602e78aa7 100644
> > --- a/drivers/spi/spi-mt65xx.c
> > +++ b/drivers/spi/spi-mt65xx.c
> > @@ -130,7 +130,7 @@ struct mtk_spi {
> >   	u32 state;
> >   	int pad_num;
> >   	u32 *pad_sel;
> > -	struct clk *parent_clk, *sel_clk, *spi_clk;
> > +	struct clk *parent_clk, *sel_clk, *spi_clk, *spi_hclk;
> >   	struct spi_transfer *cur_transfer;
> >   	u32 xfer_len;
> >   	u32 num_xfered;
> > @@ -1252,25 +1252,38 @@ static int mtk_spi_probe(struct
> > platform_device *pdev)
> >   		goto err_put_master;
> >   	}
> >   
> > +	mdata->spi_hclk = devm_clk_get(&pdev->dev, "hclk");
> > +	if (!IS_ERR(mdata->spi_hclk)) {
> 
> What you're doing here can be simplified by using
> devm_clk_get_optional() instead.
> Please use that.

Hi AngeloGioacchino, thanks for your suggestion, I'll fix it.

> 
> > +		ret = clk_prepare_enable(mdata->spi_hclk);
> > +		if (ret < 0) {
> > +			dev_err(&pdev->dev, "failed to enable hclk
> > (%d)\n", ret);
> > +			goto err_put_master;
> > +		}
> > +	}
> > +
> >   	ret = clk_prepare_enable(mdata->spi_clk);
> >   	if (ret < 0) {
> >   		dev_err(&pdev->dev, "failed to enable spi_clk (%d)\n",
> > ret);
> > -		goto err_put_master;
> > +		goto err_disable_spi_hclk;
> >   	}
> >   
> >   	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
> >   	if (ret < 0) {
> >   		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n",
> > ret);
> > -		clk_disable_unprepare(mdata->spi_clk);
> > -		goto err_put_master;
> > +		goto err_disable_spi_clk;
> >   	}
> >   
> >   	mdata->spi_clk_hz = clk_get_rate(mdata->spi_clk);
> >   
> > -	if (mdata->dev_comp->no_need_unprepare)
> > +	if (mdata->dev_comp->no_need_unprepare) {
> >   		clk_disable(mdata->spi_clk);
> > -	else
> > +		if (!IS_ERR(mdata->spi_hclk))
> > +			clk_disable(mdata->spi_hclk);
> > +	} else {
> >   		clk_disable_unprepare(mdata->spi_clk);
> > +		if (!IS_ERR(mdata->spi_hclk))
> > +			clk_disable_unprepare(mdata->spi_hclk);
> > +	}
> >   
> >   	pm_runtime_enable(&pdev->dev);
> >   
> > @@ -1310,6 +1323,11 @@ static int mtk_spi_probe(struct
> > platform_device *pdev)
> >   
> >   err_disable_runtime_pm:
> >   	pm_runtime_disable(&pdev->dev);
> > +err_disable_spi_clk:
> > +	clk_disable_unprepare(mdata->spi_clk);
> > +err_disable_spi_hclk:
> > +	if (!IS_ERR(mdata->spi_hclk))
> 
> When using devm_clk_get_optional(), you can simply omit this check,
> since it will
> be impossible to reach this point with an error pointer stored in
> spi_hclk.
OK, I'll fix it.

> 
> > +		clk_disable_unprepare(mdata->spi_hclk);
> >   err_put_master:
> >   	spi_master_put(master);
> >   
> > @@ -1325,8 +1343,11 @@ static int mtk_spi_remove(struct
> > platform_device *pdev)
> >   
> >   	mtk_spi_reset(mdata);
> >   
> > -	if (mdata->dev_comp->no_need_unprepare)
> > +	if (mdata->dev_comp->no_need_unprepare) {
> >   		clk_unprepare(mdata->spi_clk);
> > +		if (!IS_ERR(mdata->spi_hclk))
> > +			clk_unprepare(mdata->spi_hclk);
> > +	}
> >   
> >   	return 0;
> >   }
> > @@ -1342,8 +1363,11 @@ static int mtk_spi_suspend(struct device
> > *dev)
> >   	if (ret)
> >   		return ret;
> >   
> > -	if (!pm_runtime_suspended(dev))
> > +	if (!pm_runtime_suspended(dev)) {
> >   		clk_disable_unprepare(mdata->spi_clk);
> > +		if (!IS_ERR(mdata->spi_hclk))
> > +			clk_disable_unprepare(mdata->spi_hclk);
> > +	}
> >   
> >   	return ret;
> >   }
> > @@ -1360,11 +1384,23 @@ static int mtk_spi_resume(struct device
> > *dev)
> >   			dev_err(dev, "failed to enable spi_clk (%d)\n",
> > ret);
> >   			return ret;
> >   		}
> > +
> > +		if (!IS_ERR(mdata->spi_hclk)) {
> 
> Since you will be using devm_clk_get_optional(), you can also omit
> this check.
OK, I'll fix it.

> 
> > +			clk_prepare_enable(mdata->spi_hclk);
> 
> There's a typo. ret = clk_prepare_enable....
OK, I'll fix it.

> 
> > +			if (ret < 0) {
> > +				dev_err(dev, "failed to enable spi_hclk
> > (%d)\n", ret);
> > +				clk_disable_unprepare(mdata->spi_clk);
> > +				return ret;
> > +			}
> > +		}
> >   	}
> >   
> >   	ret = spi_master_resume(master);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> >   		clk_disable_unprepare(mdata->spi_clk);
> > +		if (!IS_ERR(mdata->spi_hclk))
> 
> Same here and everywhere else, no error check if you set this as
> optional clock.
OK, I'll fix it.

> 
> > +			clk_disable_unprepare(mdata->spi_hclk);
> > +	}
> >   
> >   	return ret;
> >   }
> > @@ -1376,10 +1412,15 @@ static int mtk_spi_runtime_suspend(struct
> > device *dev)
> >   	struct spi_master *master = dev_get_drvdata(dev);
> >   	struct mtk_spi *mdata = spi_master_get_devdata(master);
> >   
> > -	if (mdata->dev_comp->no_need_unprepare)
> > +	if (mdata->dev_comp->no_need_unprepare) {
> >   		clk_disable(mdata->spi_clk);
> > -	else
> > +		if (!IS_ERR(mdata->spi_hclk))
> > +			clk_disable(mdata->spi_hclk);
> > +	} else {
> >   		clk_disable_unprepare(mdata->spi_clk);
> > +		if (!IS_ERR(mdata->spi_hclk))
> > +			clk_disable_unprepare(mdata->spi_hclk);
> > +	}
> >   
> >   	return 0;
> >   }
> > @@ -1390,13 +1431,25 @@ static int mtk_spi_runtime_resume(struct
> > device *dev)
> >   	struct mtk_spi *mdata = spi_master_get_devdata(master);
> >   	int ret;
> >   
> > -	if (mdata->dev_comp->no_need_unprepare)
> > +	if (mdata->dev_comp->no_need_unprepare) {
> >   		ret = clk_enable(mdata->spi_clk);
> > -	else
> > +		if (!IS_ERR(mdata->spi_hclk))
> > +			clk_enable(mdata->spi_hclk);
> > +	} else {
> >   		ret = clk_prepare_enable(mdata->spi_clk);
> > -	if (ret < 0) {
> > -		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
> > -		return ret;
> > +		if (ret < 0) {
> > +			dev_err(dev, "failed to enable spi_clk (%d)\n",
> > ret);
> > +			return ret;
> > +		}
> > +
> > +		if (!IS_ERR(mdata->spi_hclk)) {
> > +			ret = clk_prepare_enable(mdata->spi_hclk);
> > +			if (ret < 0) {
> > +				dev_err(dev, "failed to enable spi_hclk
> > (%d)\n", ret);
> > +				clk_disable_unprepare(mdata->spi_clk);
> > +				return ret;
> > +			}
> > +		}
> >   	}
> >   
> >   	return 0;
> > 
> 
> 
> Regards,
> Angelo
> 
> 

