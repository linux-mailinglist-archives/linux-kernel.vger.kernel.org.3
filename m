Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4708757C9EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiGULt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGULtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:49:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA7E823A6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:49:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oEUfx-0002Sl-Ls; Thu, 21 Jul 2022 13:49:05 +0200
Message-ID: <6cf47684e92d21a343dbb7861f5d4e5ad1949cdc.camel@pengutronix.de>
Subject: Re: [PATCH v5 3/3] soc: imx: gpcv2: fix suspend/resume by setting
 GENPD_FLAG_IRQ_ON
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, rafael@kernel.org,
        khilman@kernel.org, ulf.hansson@linaro.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        aford173@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 21 Jul 2022 13:49:03 +0200
In-Reply-To: <20220721043608.1527686-4-martin.kepplinger@puri.sm>
References: <20220721043608.1527686-1-martin.kepplinger@puri.sm>
         <20220721043608.1527686-4-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 21.07.2022 um 06:36 +0200 schrieb Martin Kepplinger:
> For boards that use power-domains' power-supplies that need interrupts
> to work (like regulator over i2c), set GENPD_FLAG_IRQ_ON.
> This will tell genpd to adjust accordingly. Currently it "only" sets the
> correct suspend/resume callbacks.
> 
> This fixes suspend/resume on imx8mq-librem5 boards (tested) and
> imx8mq-evk (by looking at dts) and possibly more.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/soc/imx/gpcv2.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 6383a4edc360..e058aed76602 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -1337,6 +1337,9 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
>  		regmap_update_bits(domain->regmap, domain->regs->map,
>  				   domain->bits.map, domain->bits.map);
>  
> +	if (of_parse_phandle(domain->dev->of_node, "power-supply", 0))

We don't actually need to parse the phandle. For a simple presence
check of_property_read_bool() is enough.

Regards,
Lucas

> +		domain->genpd.flags |= GENPD_FLAG_IRQ_ON;
> +
>  	ret = pm_genpd_init(&domain->genpd, NULL, true);
>  	if (ret) {
>  		dev_err(domain->dev, "Failed to init power domain\n");


