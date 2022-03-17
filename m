Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CEF4DC2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiCQJ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCQJ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:28:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438451D4C0B;
        Thu, 17 Mar 2022 02:27:25 -0700 (PDT)
X-UUID: d1ba9e9be6124dc793fbad94c5fc3cae-20220317
X-UUID: d1ba9e9be6124dc793fbad94c5fc3cae-20220317
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1914048782; Thu, 17 Mar 2022 17:27:23 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 17 Mar 2022 17:27:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Mar
 2022 17:27:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 17:27:20 +0800
Message-ID: <602f93f020967789eff49e2fd821d1b03f5b009f.camel@mediatek.com>
Subject: Re: [PATCH V4 4/6] spi: mediatek: add spi memory support for ipm
 design
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Thu, 17 Mar 2022 17:27:20 +0800
In-Reply-To: <b237c1fe-9ddd-0a2e-ecf2-05bfb984c5dd@collabora.com>
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
         <20220315032411.2826-5-leilk.liu@mediatek.com>
         <b237c1fe-9ddd-0a2e-ecf2-05bfb984c5dd@collabora.com>
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

On Tue, 2022-03-15 at 10:31 +0100, AngeloGioacchino Del Regno wrote:
> Il 15/03/22 04:24, Leilk Liu ha scritto:
> > this patch add the support of spi-mem for ipm design.
> > 
> > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > ---
> >   drivers/spi/spi-mt65xx.c | 349
> > ++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 348 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> > index 1a0b3208dfca..8958c3fa4fea 100644
> > --- a/drivers/spi/spi-mt65xx.c
> > +++ b/drivers/spi/spi-mt65xx.c
> 
> ...snip...
> 
> > +
> > +static void of_mtk_spi_parse_dt(struct spi_master *master, struct
> > device_node *nc)
> > +{
> > +	struct mtk_spi *mdata = spi_master_get_devdata(master);
> > +	u32 value;
> > +
> > +	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
> 
> Hello Leilk,
> 
> thanks for considering my advice about "spi-{tx,rx}-bus-width", but
> there's
> something that you have misunderstood about it.
> 
> Simply, you don't need this function at all. Whatever you are doing
> here is
> already being performed in the Linux SPI framework: at the end of the
> probe
> function, this driver is calling the (legacy)
> devm_spi_register_master(),
> which calls devm_spi_register_controller().
> 
> In drivers/spi/spi.c, function spi_register_controller(), will in
> turn call
> of_register_spi_devices(ctlr) -> of_register_spi_device(ctlr, nc)...
> that
> will end up finally calling function of_spi_parse_dt(ctlr, spi, nc).
> 
> The last mentioned function already contains the logic and setup to
> check
> devicetree properties "spi-tx-bus-width" and "spi-rx-bus-width" (and
> some
> others, as well).
> 
> This means that spi-mt65xx.c already probed these even before your
> IPM
> implementation, hence ***function of_mtk_spi_parse_dt() is not
> needed***.
> 
> Simply drop it and don't check for these properties: that's already
> done.
> 
> 
> Regards,
> Angelo
> 
Hi Angelo,

Thanks for your advice.

There are two spi controllor on MT7986. One supports single/dual mode,
the other supports quad mode. Both of them can support spi memory
framework(one's tx/rx bus width is 1/2, the other one's tx/rx bus width
is 1/2/4). 

Can I use of_mtk_spi_parse_dt() to parse the information? What's your
suggestion?

Thanks!


> > +		switch (value) {
> > +		case 1:
> > +			break;
> > +		case 2:
> > +			master->mode_bits |= SPI_TX_DUAL;
> > +			break;
> > +		case 4:
> > +			master->mode_bits |= SPI_TX_QUAD;
> > +			break;
> > +		default:
> > +			dev_warn(mdata->dev,
> > +				 "spi-tx-bus-width %d not supported\n",
> > +				value);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
> > +		switch (value) {
> > +		case 1:
> > +			break;
> > +		case 2:
> > +			master->mode_bits |= SPI_RX_DUAL;
> > +			break;
> > +		case 4:
> > +			master->mode_bits |= SPI_RX_QUAD;
> > +			break;
> > +		case 8:
> > +			master->mode_bits |= SPI_RX_OCTAL;
> > +			break;
> > +		default:
> > +			dev_warn(mdata->dev,
> > +				 "spi-rx-bus-width %d not supported\n",
> > +				value);
> > +			break;
> > +		}
> > +	}
> > +}
> > +
> >   static int mtk_spi_probe(struct platform_device *pdev)
> >   {
> >   	struct spi_master *master;
> > @@ -830,6 +1170,13 @@ static int mtk_spi_probe(struct
> > platform_device *pdev)
> >   	if (mdata->dev_comp->ipm_design)
> >   		master->mode_bits |= SPI_LOOP;
> >   
> > +	if (mdata->dev_comp->ipm_design) {
> > +		mdata->dev = &pdev->dev;
> > +		master->mem_ops = &mtk_spi_mem_ops;
> > +		of_mtk_spi_parse_dt(master, pdev->dev.of_node);
> > +		init_completion(&mdata->spimem_done);
> > +	}
> > +
> >   	if (mdata->dev_comp->need_pad_sel) {
> >   		mdata->pad_num = of_property_count_u32_elems(
> >   			pdev->dev.of_node,

