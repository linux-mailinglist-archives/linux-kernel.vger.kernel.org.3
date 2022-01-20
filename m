Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0849479A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiATGvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:51:06 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39946 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233357AbiATGvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:51:04 -0500
X-UUID: b058b605a7ac474ba5a1dbe2e68e3817-20220120
X-UUID: b058b605a7ac474ba5a1dbe2e68e3817-20220120
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 170113334; Thu, 20 Jan 2022 14:50:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Jan 2022 14:50:58 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Jan 2022 14:50:57 +0800
Message-ID: <91bb8078e2d0824c325eb3819e59cdcb65b68a4e.camel@mediatek.com>
Subject: Re: [PATCH] usb: host: xhci-mtk: Simplify supplies handling with
 regulator_bulk
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <matthias.bgg@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Jan 2022 14:50:57 +0800
In-Reply-To: <20220118133348.111860-1-angelogioacchino.delregno@collabora.com>
References: <20220118133348.111860-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 14:33 +0100, AngeloGioacchino Del Regno wrote:
> Remove the custom functions xhci_mtk_ldos_{enable,disable}() by
> switching to using regulator_bulk to perform the very same thing,
> as the regulators are always either both enabled or both disabled.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/usb/host/xhci-mtk.c | 56 ++++++++++++-----------------------
> --
>  drivers/usb/host/xhci-mtk.h |  4 +--
>  2 files changed, 20 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-
> mtk.c
> index 62c835d446be..3b81931e5b77 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -395,31 +395,6 @@ static int xhci_mtk_clks_get(struct xhci_hcd_mtk
> *mtk)
>  	return devm_clk_bulk_get_optional(mtk->dev, BULK_CLKS_NUM,
> clks);
>  }
>  
> -static int xhci_mtk_ldos_enable(struct xhci_hcd_mtk *mtk)
> -{
> -	int ret;
> -
> -	ret = regulator_enable(mtk->vbus);
> -	if (ret) {
> -		dev_err(mtk->dev, "failed to enable vbus\n");
> -		return ret;
> -	}
> -
> -	ret = regulator_enable(mtk->vusb33);
> -	if (ret) {
> -		dev_err(mtk->dev, "failed to enable vusb33\n");
> -		regulator_disable(mtk->vbus);
> -		return ret;
> -	}
> -	return 0;
> -}
> -
> -static void xhci_mtk_ldos_disable(struct xhci_hcd_mtk *mtk)
> -{
> -	regulator_disable(mtk->vbus);
> -	regulator_disable(mtk->vusb33);
> -}
> -
>  static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd
> *xhci)
>  {
>  	struct usb_hcd *hcd = xhci_to_hcd(xhci);
> @@ -475,6 +450,10 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
>  	return ret;
>  }
>  
> +static const char * const xhci_mtk_supply_names[] = {
> +	"vusb33", "vbus",
> +};
> +
>  static const struct xhci_driver_overrides xhci_mtk_overrides
> __initconst = {
>  	.reset = xhci_mtk_setup,
>  	.add_endpoint = xhci_mtk_add_ep,
> @@ -507,17 +486,18 @@ static int xhci_mtk_probe(struct
> platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mtk->dev = dev;
> -	mtk->vbus = devm_regulator_get(dev, "vbus");
> -	if (IS_ERR(mtk->vbus)) {
> -		dev_err(dev, "fail to get vbus\n");
> -		return PTR_ERR(mtk->vbus);
> -	}
> +	mtk->num_supplies = ARRAY_SIZE(xhci_mtk_supply_names);
> +	mtk->supplies = devm_kcalloc(dev, mtk->num_supplies,
> +				     sizeof(*mtk->supplies),
> GFP_KERNEL);
> +	if (!mtk->supplies)
> +		return -ENOMEM;
>  
> -	mtk->vusb33 = devm_regulator_get(dev, "vusb33");
> -	if (IS_ERR(mtk->vusb33)) {
> -		dev_err(dev, "fail to get vusb33\n");
> -		return PTR_ERR(mtk->vusb33);
> -	}
> +	regulator_bulk_set_supply_names(mtk->supplies,
> xhci_mtk_supply_names,
> +					mtk->num_supplies);
> +
> +	ret = devm_regulator_bulk_get(dev, mtk->num_supplies, mtk-
> >supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get
> regulators\n");
>  
>  	ret = xhci_mtk_clks_get(mtk);
>  	if (ret)
> @@ -558,7 +538,7 @@ static int xhci_mtk_probe(struct platform_device
> *pdev)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> -	ret = xhci_mtk_ldos_enable(mtk);
> +	ret = regulator_bulk_enable(mtk->num_supplies, mtk->supplies);
>  	if (ret)
>  		goto disable_pm;
>  
> @@ -667,7 +647,7 @@ static int xhci_mtk_probe(struct platform_device
> *pdev)
>  	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
>  
>  disable_ldos:
> -	xhci_mtk_ldos_disable(mtk);
> +	regulator_bulk_disable(mtk->num_supplies, mtk->supplies);
>  
>  disable_pm:
>  	pm_runtime_put_noidle(dev);
> @@ -695,7 +675,7 @@ static int xhci_mtk_remove(struct platform_device
> *pdev)
>  	usb_put_hcd(hcd);
>  	xhci_mtk_sch_exit(mtk);
>  	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
> -	xhci_mtk_ldos_disable(mtk);
> +	regulator_bulk_disable(mtk->num_supplies, mtk->supplies);
>  
>  	pm_runtime_disable(dev);
>  	pm_runtime_put_noidle(dev);
> diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-
> mtk.h
> index 4b1ea89f959a..9b78cd2ba0ac 100644
> --- a/drivers/usb/host/xhci-mtk.h
> +++ b/drivers/usb/host/xhci-mtk.h
> @@ -150,9 +150,9 @@ struct xhci_hcd_mtk {
>  	int num_u3_ports;
>  	int u2p_dis_msk;
>  	int u3p_dis_msk;
> -	struct regulator *vusb33;
> -	struct regulator *vbus;
>  	struct clk_bulk_data clks[BULK_CLKS_NUM];
> +	struct regulator_bulk_data *supplies;
> +	u8 num_supplies;
Could you please help to change it like as clock bulk?

1. #define BULK_REGULATORS_NUM 2; then define @supplies array,

        struct regulator_bulk_data supplies[BULK_REGULATORS_NUM];

2. also add a helper to get regulator bulk; e.g.

static int xhci_mtk_regulators_get(struct xhci_hcd_mtk *mtk)
{
    struct regulator_bulk_data *supplies = mtk->supplies;

    supplies[0].supply = "vusb33";
    supplies[1].supply = "vbus";

    return devm_regulator_bulk_get(mtk->dev, BUL
K_REGULATORS_NUM, supplies);
}

Thanks a lot


>  	unsigned int has_ippc:1;
>  	unsigned int lpm_support:1;
>  	unsigned int u2_lpm_disable:1;

