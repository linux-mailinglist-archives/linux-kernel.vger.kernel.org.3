Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3E4826D5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiAAHZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:25:52 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:47365 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiAAHZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:25:51 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C725E300002A0;
        Sat,  1 Jan 2022 08:25:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B966A30123; Sat,  1 Jan 2022 08:25:48 +0100 (CET)
Date:   Sat, 1 Jan 2022 08:25:48 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: apple: Add driver for Apple SPI controller
Message-ID: <20220101072548.GA28593@wunner.de>
References: <20211212034726.26306-1-marcan@marcan.st>
 <20211212034726.26306-4-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212034726.26306-4-marcan@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 12:47:26PM +0900, Hector Martin wrote:
> +	ret = devm_spi_register_controller(&pdev->dev, ctlr);
[...]
> +static int apple_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +	struct apple_spi *spi = spi_controller_get_devdata(ctlr);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	/* Disable all the interrupts just in case */
> +	reg_write(spi, APPLE_SPI_IE_FIFO, 0);
> +	reg_write(spi, APPLE_SPI_IE_XFER, 0);
> +
> +	clk_disable_unprepare(spi->clk);

You need to use spi_register_controller() in apple_spi_probe()
(*not* the devm variant) and invoke spi_unregister_controller()
first thing in apple_spi_remove().

Otherwise you've got an ordering issue on driver unbind:
__device_release_driver() first calls the ->remove hook and only
then devres_release_all().  You're disabling the clock and interrupts
in the ->remove hook, rendering the controller unusable.  Yet the
expectation is that until spi_unregister_controller() returns,
the controller works and its slaves are accessible.

This is especially important if there are slaves attached to the
controller which perform SPI transfers in their ->remove hooks,
e.g. to quiesce interrupts on the slaves.  Those transfers won't
work the way you've structured the code now.

spi-sifive.c, from which you've derived this, is broken.  As are
a couple dozen other drivers.  I've fixed some of them,
but haven't gotten around to fixing them all.  Just trying to
prevent more brokenness from entering the codebase.

Thanks,

Lukas
