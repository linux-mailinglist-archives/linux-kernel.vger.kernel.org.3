Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6F4885B0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 20:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiAHTsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 14:48:24 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:45233 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiAHTsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 14:48:23 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 18E122800B3D2;
        Sat,  8 Jan 2022 20:48:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 090432F5D0F; Sat,  8 Jan 2022 20:48:19 +0100 (CET)
Date:   Sat, 8 Jan 2022 20:48:19 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     patrice.chotard@foss.st.com
Cc:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: spi: stm32-qspi: Update spi registering
Message-ID: <20220108194819.GA5467@wunner.de>
References: <20220106132052.7227-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106132052.7227-1-patrice.chotard@foss.st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 02:20:52PM +0100, patrice.chotard@foss.st.com wrote:
> --- a/drivers/spi/spi-stm32-qspi.c
> +++ b/drivers/spi/spi-stm32-qspi.c
> @@ -784,7 +784,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_noresume(dev);
>  
> -	ret = devm_spi_register_master(dev, ctrl);
> +	ret = spi_register_master(ctrl);
>  	if (ret)
>  		goto err_pm_runtime_free;
>  
> @@ -817,6 +817,7 @@ static int stm32_qspi_remove(struct platform_device *pdev)
>  	struct stm32_qspi *qspi = platform_get_drvdata(pdev);
>  
>  	pm_runtime_get_sync(qspi->dev);
> +	spi_unregister_master(qspi->ctrl);
>  	/* disable qspi */
>  	writel_relaxed(0, qspi->io_base + QSPI_CR);
>  	stm32_qspi_dma_free(qspi);

NAK, this introduces a use-after-free because the "qspi" allocation
is freed by spi_unregister_master(), yet is subsequently accessed.

You need to convert the driver to devm_spi_alloc_master() to avoid that.
Do it in the same patch to ease backporting.

Please add a stable designation and a Fixes: tag.  Chances are the patch
needs to be backported all the way back to the release when the driver
was first introduced.

Thanks,

Lukas
