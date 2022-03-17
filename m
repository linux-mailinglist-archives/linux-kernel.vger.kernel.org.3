Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1402D4DC326
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiCQJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiCQJpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:45:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BD197AF3;
        Thu, 17 Mar 2022 02:44:13 -0700 (PDT)
X-UUID: 67d16cc1e9444f90b9cc772c0ef77b8d-20220317
X-UUID: 67d16cc1e9444f90b9cc772c0ef77b8d-20220317
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 303202656; Thu, 17 Mar 2022 17:44:08 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Mar 2022 17:44:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Mar
 2022 17:44:06 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 17:44:04 +0800
Message-ID: <85717fa0b71f26431e4ca5de794e79c32c503552.camel@mediatek.com>
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
Date:   Thu, 17 Mar 2022 17:44:04 +0800
In-Reply-To: <b6394c1a-28ee-f4bb-434f-afd311893fb8@collabora.com>
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
         <20220315032411.2826-5-leilk.liu@mediatek.com>
         <b237c1fe-9ddd-0a2e-ecf2-05bfb984c5dd@collabora.com>
         <602f93f020967789eff49e2fd821d1b03f5b009f.camel@mediatek.com>
         <b6394c1a-28ee-f4bb-434f-afd311893fb8@collabora.com>
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

On Thu, 2022-03-17 at 10:33 +0100, AngeloGioacchino Del Regno wrote:
> Il 17/03/22 10:27, Leilk Liu ha scritto:
> > On Tue, 2022-03-15 at 10:31 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Il 15/03/22 04:24, Leilk Liu ha scritto:
> > > > this patch add the support of spi-mem for ipm design.
> > > > 
> > > > Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> > > > ---
> > > >    drivers/spi/spi-mt65xx.c | 349
> > > > ++++++++++++++++++++++++++++++++++++++-
> > > >    1 file changed, 348 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-
> > > > mt65xx.c
> > > > index 1a0b3208dfca..8958c3fa4fea 100644
> > > > --- a/drivers/spi/spi-mt65xx.c
> > > > +++ b/drivers/spi/spi-mt65xx.c
> > > 
> > > ...snip...
> > > 
> > > > +
> > > > +static void of_mtk_spi_parse_dt(struct spi_master *master,
> > > > struct
> > > > device_node *nc)
> > > > +{
> > > > +	struct mtk_spi *mdata = spi_master_get_devdata(master);
> > > > +	u32 value;
> > > > +
> > > > +	if (!of_property_read_u32(nc, "spi-tx-bus-width",
> > > > &value)) {
> > > 
> > > Hello Leilk,
> > > 
> > > thanks for considering my advice about "spi-{tx,rx}-bus-width",
> > > but
> > > there's
> > > something that you have misunderstood about it.
> > > 
> > > Simply, you don't need this function at all. Whatever you are
> > > doing
> > > here is
> > > already being performed in the Linux SPI framework: at the end of
> > > the
> > > probe
> > > function, this driver is calling the (legacy)
> > > devm_spi_register_master(),
> > > which calls devm_spi_register_controller().
> > > 
> > > In drivers/spi/spi.c, function spi_register_controller(), will in
> > > turn call
> > > of_register_spi_devices(ctlr) -> of_register_spi_device(ctlr,
> > > nc)...
> > > that
> > > will end up finally calling function of_spi_parse_dt(ctlr, spi,
> > > nc).
> > > 
> > > The last mentioned function already contains the logic and setup
> > > to
> > > check
> > > devicetree properties "spi-tx-bus-width" and "spi-rx-bus-width"
> > > (and
> > > some
> > > others, as well).
> > > 
> > > This means that spi-mt65xx.c already probed these even before
> > > your
> > > IPM
> > > implementation, hence ***function of_mtk_spi_parse_dt() is not
> > > needed***.
> > > 
> > > Simply drop it and don't check for these properties: that's
> > > already
> > > done.
> > > 
> > > 
> > > Regards,
> > > Angelo
> > > 
> > 
> > Hi Angelo,
> > 
> > Thanks for your advice.
> > 
> > There are two spi controllor on MT7986. One supports single/dual
> > mode,
> > the other supports quad mode. Both of them can support spi memory
> > framework(one's tx/rx bus width is 1/2, the other one's tx/rx bus
> > width
> > is 1/2/4).
> > 
> > Can I use of_mtk_spi_parse_dt() to parse the information? What's
> > your
> > suggestion?
> > 
> > Thanks!
> > 
> 
> As I've already said, this does NOT require any devicetree handling
> in
> spi-mt65xx.c, as setting the right mode_bits is already handled in
> drivers/spi/spi.c - please follow the explaination that I have given
> before to fully understand the situation.
> 
> Regards,
> Angelo
> 
OK, I'll fix it, thanks.

> 
> > 
> > > > +		switch (value) {
> > > > +		case 1:
> > > > +			break;
> > > > +		case 2:
> > > > +			master->mode_bits |= SPI_TX_DUAL;
> > > > +			break;
> > > > +		case 4:
> > > > +			master->mode_bits |= SPI_TX_QUAD;
> > > > +			break;
> > > > +		default:
> > > > +			dev_warn(mdata->dev,
> > > > +				 "spi-tx-bus-width %d not
> > > > supported\n",
> > > > +				value);
> > > > +			break;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (!of_property_read_u32(nc, "spi-rx-bus-width",
> > > > &value)) {
> > > > +		switch (value) {
> > > > +		case 1:

