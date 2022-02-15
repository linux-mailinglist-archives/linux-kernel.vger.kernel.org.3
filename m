Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B134B6398
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiBOGej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:34:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiBOGeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:34:37 -0500
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 22:34:28 PST
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF752AFF4D;
        Mon, 14 Feb 2022 22:34:28 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 35C4530000E20;
        Tue, 15 Feb 2022 07:27:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 282A6314429; Tue, 15 Feb 2022 07:27:43 +0100 (CET)
Date:   Tue, 15 Feb 2022 07:27:43 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] spi: spi-mem: Add driver for Aspeed SMC controllers
Message-ID: <20220215062743.GA12431@wunner.de>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214094231.3753686-4-clg@kaod.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:42:24AM +0100, Cédric Le Goater wrote:
> +static int aspeed_spi_probe(struct platform_device *pdev)
> +{
[...]
> +	ctlr = spi_alloc_master(dev, sizeof(*aspi));
> +	if (!ctlr)
> +		return -ENOMEM;

Use devm_spi_alloc_master() and remove the "put_controller" error path
for simplicity.


> +	ret = devm_spi_register_controller(dev, ctlr);
[...]
> +static int aspeed_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +	struct aspeed_spi *aspi = spi_controller_get_devdata(ctlr);
> +
> +	aspeed_spi_enable(aspi, false);
> +	spi_unregister_controller(ctlr);
> +	clk_disable_unprepare(aspi->clk);
> +	return 0;
> +}

You need to move the call to spi_unregister_controller() *before*
the call to aspeed_spi_enable().  The controller must be fully
operational until spi_unregister_controller() returns.

You also need to replace the call to devm_spi_register_controller()
in aspeed_spi_probe() with spi_register_controller().
Otherwise you'll unregister the controller twice because you're
calling spi_unregister_controller() in aspeed_spi_remove().

Thanks,

Lukas
