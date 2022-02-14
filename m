Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF624B4315
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiBNHo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:44:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241474AbiBNHow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:44:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E645A594;
        Sun, 13 Feb 2022 23:44:40 -0800 (PST)
X-UUID: 060ca1a90ef44e91b63732669f0fe9aa-20220214
X-UUID: 060ca1a90ef44e91b63732669f0fe9aa-20220214
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1472425227; Mon, 14 Feb 2022 15:44:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 14 Feb 2022 15:44:34 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 15:44:33 +0800
Message-ID: <1e016441cdbae4fc6300dd6b70e9e29def81a960.camel@mediatek.com>
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
Date:   Mon, 14 Feb 2022 15:44:30 +0800
In-Reply-To: <02d0dba2-ffc8-1bf1-d8a7-f7fa19f2c7ed@collabora.com>
References: <20220118133348.111860-1-angelogioacchino.delregno@collabora.com>
         <91bb8078e2d0824c325eb3819e59cdcb65b68a4e.camel@mediatek.com>
         <02d0dba2-ffc8-1bf1-d8a7-f7fa19f2c7ed@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 11:00 +0100, AngeloGioacchino Del Regno wrote:
> Il 20/01/22 07:50, Chunfeng Yun ha scritto:
> > On Tue, 2022-01-18 at 14:33 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Remove the custom functions xhci_mtk_ldos_{enable,disable}() by
> > > switching to using regulator_bulk to perform the very same thing,
> > > as the regulators are always either both enabled or both
> > > disabled.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > ---
> > >   drivers/usb/host/xhci-mtk.c | 56 ++++++++++++----------------
> > > -------
> > > --
> > >   drivers/usb/host/xhci-mtk.h |  4 +--
> > >   2 files changed, 20 insertions(+), 40 deletions(-)
> > > 
> > > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-
> > > mtk.c
> > > index 62c835d446be..3b81931e5b77 100644
> > > --- a/drivers/usb/host/xhci-mtk.c
> > > +++ b/drivers/usb/host/xhci-mtk.c
> > > @@ -395,31 +395,6 @@ static int xhci_mtk_clks_get(struct
> > > xhci_hcd_mtk
> > > *mtk)
> > >   	return devm_clk_bulk_get_optional(mtk->dev,
> > > BULK_CLKS_NUM,
> > > clks);
> > >   }
> > >   
> > > -static int xhci_mtk_ldos_enable(struct xhci_hcd_mtk *mtk)
> > > -{
> > > -	int ret;
> > > -
> > > -	ret = regulator_enable(mtk->vbus);
> > > -	if (ret) {
> > > -		dev_err(mtk->dev, "failed to enable vbus\n");
> > > -		return ret;
> > > -	}
> > > -
> > > -	ret = regulator_enable(mtk->vusb33);
> > > -	if (ret) {
> > > -		dev_err(mtk->dev, "failed to enable vusb33\n");
> > > -		regulator_disable(mtk->vbus);
> > > -		return ret;
> > > -	}
> > > -	return 0;
> > > -}
> > > -
> > > -static void xhci_mtk_ldos_disable(struct xhci_hcd_mtk *mtk)
> > > -{
> > > -	regulator_disable(mtk->vbus);
> > > -	regulator_disable(mtk->vusb33);
> > > -}
> > > -
> > >   static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd
> > > *xhci)
> > >   {
> > >   	struct usb_hcd *hcd = xhci_to_hcd(xhci);
> > > @@ -475,6 +450,10 @@ static int xhci_mtk_setup(struct usb_hcd
> > > *hcd)
> > >   	return ret;
> > >   }
> > >   
> > > +static const char * const xhci_mtk_supply_names[] = {
> > > +	"vusb33", "vbus",
> > > +};
> > > +
> > >   static const struct xhci_driver_overrides xhci_mtk_overrides
> > > __initconst = {
> > >   	.reset = xhci_mtk_setup,
> > >   	.add_endpoint = xhci_mtk_add_ep,
> > > @@ -507,17 +486,18 @@ static int xhci_mtk_probe(struct
> > > platform_device *pdev)
> > >   		return -ENOMEM;
> > >   
> > >   	mtk->dev = dev;
> > > -	mtk->vbus = devm_regulator_get(dev, "vbus");
> > > -	if (IS_ERR(mtk->vbus)) {
> > > -		dev_err(dev, "fail to get vbus\n");
> > > -		return PTR_ERR(mtk->vbus);
> > > -	}
> > > +	mtk->num_supplies = ARRAY_SIZE(xhci_mtk_supply_names);
> > > +	mtk->supplies = devm_kcalloc(dev, mtk->num_supplies,
> > > +				     sizeof(*mtk->supplies),
> > > GFP_KERNEL);
> > > +	if (!mtk->supplies)
> > > +		return -ENOMEM;
> > >   
> > > -	mtk->vusb33 = devm_regulator_get(dev, "vusb33");
> > > -	if (IS_ERR(mtk->vusb33)) {
> > > -		dev_err(dev, "fail to get vusb33\n");
> > > -		return PTR_ERR(mtk->vusb33);
> > > -	}
> > > +	regulator_bulk_set_supply_names(mtk->supplies,
> > > xhci_mtk_supply_names,
> > > +					mtk->num_supplies);
> > > +
> > > +	ret = devm_regulator_bulk_get(dev, mtk->num_supplies, mtk-
> > > > supplies);
> > > 
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to get
> > > regulators\n");
> > >   
> > >   	ret = xhci_mtk_clks_get(mtk);
> > >   	if (ret)
> > > @@ -558,7 +538,7 @@ static int xhci_mtk_probe(struct
> > > platform_device
> > > *pdev)
> > >   	pm_runtime_enable(dev);
> > >   	pm_runtime_get_sync(dev);
> > >   
> > > -	ret = xhci_mtk_ldos_enable(mtk);
> > > +	ret = regulator_bulk_enable(mtk->num_supplies, mtk->supplies);
> > >   	if (ret)
> > >   		goto disable_pm;
> > >   
> > > @@ -667,7 +647,7 @@ static int xhci_mtk_probe(struct
> > > platform_device
> > > *pdev)
> > >   	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
> > >   
> > >   disable_ldos:
> > > -	xhci_mtk_ldos_disable(mtk);
> > > +	regulator_bulk_disable(mtk->num_supplies, mtk->supplies);
> > >   
> > >   disable_pm:
> > >   	pm_runtime_put_noidle(dev);
> > > @@ -695,7 +675,7 @@ static int xhci_mtk_remove(struct
> > > platform_device
> > > *pdev)
> > >   	usb_put_hcd(hcd);
> > >   	xhci_mtk_sch_exit(mtk);
> > >   	clk_bulk_disable_unprepare(BULK_CLKS_NUM, mtk->clks);
> > > -	xhci_mtk_ldos_disable(mtk);
> > > +	regulator_bulk_disable(mtk->num_supplies, mtk->supplies);
> > >   
> > >   	pm_runtime_disable(dev);
> > >   	pm_runtime_put_noidle(dev);
> > > diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-
> > > mtk.h
> > > index 4b1ea89f959a..9b78cd2ba0ac 100644
> > > --- a/drivers/usb/host/xhci-mtk.h
> > > +++ b/drivers/usb/host/xhci-mtk.h
> > > @@ -150,9 +150,9 @@ struct xhci_hcd_mtk {
> > >   	int num_u3_ports;
> > >   	int u2p_dis_msk;
> > >   	int u3p_dis_msk;
> > > -	struct regulator *vusb33;
> > > -	struct regulator *vbus;
> > >   	struct clk_bulk_data clks[BULK_CLKS_NUM];
> > > +	struct regulator_bulk_data *supplies;
> > > +	u8 num_supplies;
> > 
> > Could you please help to change it like as clock bulk?
> > 
> > 1. #define BULK_REGULATORS_NUM 2; then define @supplies array,
> > 
> >          struct regulator_bulk_data supplies[BULK_REGULATORS_NUM];
> > 
> > 2. also add a helper to get regulator bulk; e.g.
> > 
> > static int xhci_mtk_regulators_get(struct xhci_hcd_mtk *mtk)
> > {
> >      struct regulator_bulk_data *supplies = mtk->supplies;
> > 
> >      supplies[0].supply = "vusb33";
> >      supplies[1].supply = "vbus";
> > 
> >      return devm_regulator_bulk_get(mtk->dev, BUL
> > K_REGULATORS_NUM, supplies);
> > }
> 
> Hello Chunfeng,
> I chose to go for this way to enhance the implementation flexibility:
> like that,
> any future SoC that needs different regulators (more vregs, less,
> different names)
> will simply need a new array of vreg names, like:
> 
> static const char * const xhci_mtk_mtxxxx_supply_names[] = {
> 	"vusb33", "vbus", "another-supply", "and-another-one",
> };
> 
> Other than enhancing flexibility, this will also make sure that we
> don't allocate
> more regulator_bulk_data entries than needed, enhancing memory usage.
> 
> Your proposal, though, is valid if you are sure that future SoCs will
> have only
> and always these two power supplies and nothing else...
As I know, vbus is usually always on (fixed regulator) and is used to
provide 5v for the connected device, vusb33 is rarely used now (it's
used to provide v3.3 for the controller). I think no need pay more
attention to flexibility here.

Thanks a lot


> 
> Regards,
> Angelo
> 
> > 
> > Thanks a lot
> > 
> > 
> > >   	unsigned int has_ippc:1;
> > >   	unsigned int lpm_support:1;
> > >   	unsigned int u2_lpm_disable:1;

