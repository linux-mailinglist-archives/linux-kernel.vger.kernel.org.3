Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC82F54657A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbiFJLYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiFJLYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:24:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81CB19299;
        Fri, 10 Jun 2022 04:24:44 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="260717744"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="260717744"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:24:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="649791280"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:24:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nzcii-000Yiq-Fy;
        Fri, 10 Jun 2022 14:22:28 +0300
Date:   Fri, 10 Jun 2022 14:22:28 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Add deferred DMA-channels setup support
Message-ID: <YqMpdEitU/84oUWV@smile.fi.intel.com>
References: <20220610075006.10025-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610075006.10025-1-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:50:06AM +0300, Serge Semin wrote:
> Currently if the source DMA device isn't ready to provide the channels
> capable of the SPI DMA transfers, the DW SSI controller will be registered
> with no DMA support. It isn't right since all what the driver needs to do
> is to postpone the probe procedure until the DMA device is ready. Let's
> fix that in the framework of the DWC SSI generic DMA implementation. First
> we need to use the dma_request_chan() method instead of the
> dma_request_slave_channel() function, because the later one is deprecated
> and most importantly doesn't return the failure cause but the
> NULL-pointer. Second we need to stop the DW SSI controller probe procedure
> if the -EPROBE_DEFER error is returned on the DMA initialization. The
> procedure will resume later when the channels are ready to be requested.

One nit-pick below
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/spi/spi-dw-core.c |  5 ++++-
>  drivers/spi/spi-dw-dma.c  | 25 ++++++++++++++++++-------
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index ecea471ff42c..911ea9bddbee 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -942,7 +942,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  
>  	if (dws->dma_ops && dws->dma_ops->dma_init) {
>  		ret = dws->dma_ops->dma_init(dev, dws);
> -		if (ret) {
> +		if (ret == -EPROBE_DEFER) {
> +			goto err_free_irq;
> +		} else if (ret) {
>  			dev_warn(dev, "DMA init failed\n");
>  		} else {
>  			master->can_dma = dws->dma_ops->can_dma;
> @@ -963,6 +965,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>  	if (dws->dma_ops && dws->dma_ops->dma_exit)
>  		dws->dma_ops->dma_exit(dws);
>  	dw_spi_enable_chip(dws, 0);
> +err_free_irq:
>  	free_irq(dws->irq, master);
>  err_free_master:
>  	spi_controller_put(master);
> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> index 63e5260100ec..1322b8cce5b7 100644
> --- a/drivers/spi/spi-dw-dma.c
> +++ b/drivers/spi/spi-dw-dma.c
> @@ -139,15 +139,20 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  
>  static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
>  {
> -	dws->rxchan = dma_request_slave_channel(dev, "rx");
> -	if (!dws->rxchan)
> -		return -ENODEV;
> +	int ret;
>  
> -	dws->txchan = dma_request_slave_channel(dev, "tx");
> -	if (!dws->txchan) {
> -		dma_release_channel(dws->rxchan);
> +	dws->rxchan = dma_request_chan(dev, "rx");
> +	if (IS_ERR(dws->rxchan)) {
> +		ret = PTR_ERR(dws->rxchan);
>  		dws->rxchan = NULL;

> -		return -ENODEV;
> +		goto err_exit;

This change doesn't bring anything...

> +	}
> +
> +	dws->txchan = dma_request_chan(dev, "tx");
> +	if (IS_ERR(dws->txchan)) {
> +		ret = PTR_ERR(dws->txchan);
> +		dws->txchan = NULL;
> +		goto free_rxchan;
>  	}
>  
>  	dws->master->dma_rx = dws->rxchan;
> @@ -160,6 +165,12 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
>  	dw_spi_dma_sg_burst_init(dws);
>  
>  	return 0;
> +
> +free_rxchan:
> +	dma_release_channel(dws->rxchan);
> +	dws->rxchan = NULL;

> +err_exit:

...and this too.

> +	return ret;
>  }
>  
>  static void dw_spi_dma_exit(struct dw_spi *dws)
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


