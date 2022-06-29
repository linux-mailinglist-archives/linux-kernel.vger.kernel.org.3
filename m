Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228D7560765
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiF2RdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiF2RdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:33:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1D93C73B;
        Wed, 29 Jun 2022 10:33:01 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 293FC3D7;
        Wed, 29 Jun 2022 19:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1656523979;
        bh=Bz+fn/nhW/HeNRPw/laOwYHfB9cQJCj7oVKsDW89m34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VERPl+T+Zv2xZi1ia04OnQXFfPB7Y0t/Z05jadMvstQPmFPB78HjazkKDztBN7bLT
         h5t5rVOIBjsgc09ajwsyg7atynSewIQlpW3SNMt/SDyLKru4dK0a0uG4b2Hi9lkp09
         z8B3wBAWCv0lFE9+b7LU1mi/DCgXGHrdTtkYKu2U=
Date:   Wed, 29 Jun 2022 20:32:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 7/9] interconnect: imx: set of_node for interconnect
 provider
Message-ID: <YryMt4CfQNkIHwiV@pendragon.ideasonboard.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
 <20220616073320.2203000-8-peng.fan@oss.nxp.com>
 <3c773637f626877832041d3065f387261ba70816.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c773637f626877832041d3065f387261ba70816.camel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 05:08:58PM +0200, Lucas Stach wrote:
> Am Donnerstag, dem 16.06.2022 um 15:33 +0800 schrieb Peng Fan (OSS):
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > The provider device is created using platform_device_register_data in
> > imx-bus driver, which not has of_node. With of_node set, it will be
> > easy to support QoS settings.
> > 
> That's a bit dangerous, as sharing a of_node between two devices can
> lead to some reference counting issues IIRC, but then I also don't see
> a good way to do this any differently.
> 
> Regards,
> Lucas
> 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/interconnect/imx/imx.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
> > index 1f16eedea21c..78557fe6da2c 100644
> > --- a/drivers/interconnect/imx/imx.c
> > +++ b/drivers/interconnect/imx/imx.c
> > @@ -264,6 +264,7 @@ int imx_icc_register(struct platform_device *pdev,
> >  	provider->xlate = of_icc_xlate_onecell;
> >  	provider->data = data;
> >  	provider->dev = dev->parent;
> > +	provider->dev->of_node = dev->parent->of_node;

Due to the previous line, provider->dev is equal to dev->parent, so
doesn't this essentially do

	dev->parent->of_node = dev->parent->of_node;

which is a no-op ?

> >  	platform_set_drvdata(pdev, imx_provider);
> >  
> >  	ret = icc_provider_add(provider);

-- 
Regards,

Laurent Pinchart
