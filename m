Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE687546E78
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347956AbiFJUbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbiFJUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:31:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8356E1706E;
        Fri, 10 Jun 2022 13:31:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c2so307543lfk.0;
        Fri, 10 Jun 2022 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VDa6xeiBd+juK+0o7bpIdbAFOSoJH/U9Q6ssDyTVnQI=;
        b=XwYAaPhU/2TwjzheGRHIW8nPF4Vz9Jj9n0h1XNtBGe7KQPvPl/6OfyzJrT3sKrDAsr
         Q84FdNKY7n27WrZl8aRBP9eJZEu/epHWJV4YCMblZT3Y6dFI2ujyCJobip7DYKC8nYno
         sGgi1EpzOaw9HrMiZgciVAa0o2a2mwk48wZ9hBK9nrt5Tr+PKbU0GKhHUwOQUOT9mMWt
         gOvK/yPypPv92gryQNY3ux6uhwQqT9qtg3CP2WCrnaiUY4MpkD7IlkktvPoDdGa627iq
         te7bHQmqOtgAkGaysc0Tj90nbkKHxQsz5Q44fTCY0hqyvIAd347xEnRPJEI/e3EmnQui
         l3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VDa6xeiBd+juK+0o7bpIdbAFOSoJH/U9Q6ssDyTVnQI=;
        b=K1ag+TFb2hTunXuV3pCBQ+5dCZVksUMTu0TI56OALOvUqHcNzQq40CSk4REA3CMQhm
         n2YaRK4u3ZyMZpBCpnMrdq9RKcXrhiu9LNTK9r4C2JpxWl5xQN42WaK5mYuIHvcQ5cS+
         XdtkQ9WkdTAEhv5TTuxBg2QAffaaqDd4vn0tYKi6xSECsa117Wymktrjh9f8TF71crxR
         1V/lYNp+f0LfFpg0xIRgGd3ZEDBTFzZD4OdL4BGUq4sWkKIHL4kJDiyYrZczVsaqMrNz
         VIcwC5lWDFsCiQvsQ6pGz6VpkdOBe/OV+vcY7MNSg6DL+SjpmWa9god7BSXr+WnwPfcA
         EXWg==
X-Gm-Message-State: AOAM531vIYzRsRJf0kdtXcjXxROWxxBqoOiy8TrMkatsoanBW0ZnfJ5d
        UdBT1UhqdCv1OkS1O0LQ0o4=
X-Google-Smtp-Source: ABdhPJwCJYwP93/wkv9xaFmo3YDYryqP+934epYw5Gv6BKiFGClY9rY4zQ86KQCtzj/gcwEczSNJIg==
X-Received: by 2002:a19:770a:0:b0:478:f20d:aac with SMTP id s10-20020a19770a000000b00478f20d0aacmr34643846lfc.277.1654893073675;
        Fri, 10 Jun 2022 13:31:13 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id o26-20020a056512053a00b00478dba63f2asm4836577lfc.226.2022.06.10.13.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 13:31:13 -0700 (PDT)
Date:   Fri, 10 Jun 2022 23:31:11 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Add deferred DMA-channels setup support
Message-ID: <20220610203111.qoywhp2fepe66lxt@mobilestation>
References: <20220610075006.10025-1-Sergey.Semin@baikalelectronics.ru>
 <YqMpdEitU/84oUWV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqMpdEitU/84oUWV@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 02:22:28PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 10, 2022 at 10:50:06AM +0300, Serge Semin wrote:
> > Currently if the source DMA device isn't ready to provide the channels
> > capable of the SPI DMA transfers, the DW SSI controller will be registered
> > with no DMA support. It isn't right since all what the driver needs to do
> > is to postpone the probe procedure until the DMA device is ready. Let's
> > fix that in the framework of the DWC SSI generic DMA implementation. First
> > we need to use the dma_request_chan() method instead of the
> > dma_request_slave_channel() function, because the later one is deprecated
> > and most importantly doesn't return the failure cause but the
> > NULL-pointer. Second we need to stop the DW SSI controller probe procedure
> > if the -EPROBE_DEFER error is returned on the DMA initialization. The
> > procedure will resume later when the channels are ready to be requested.
> 

> One nit-pick below
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks.

> 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/spi/spi-dw-core.c |  5 ++++-
> >  drivers/spi/spi-dw-dma.c  | 25 ++++++++++++++++++-------
> >  2 files changed, 22 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index ecea471ff42c..911ea9bddbee 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -942,7 +942,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
> >  
> >  	if (dws->dma_ops && dws->dma_ops->dma_init) {
> >  		ret = dws->dma_ops->dma_init(dev, dws);
> > -		if (ret) {
> > +		if (ret == -EPROBE_DEFER) {
> > +			goto err_free_irq;
> > +		} else if (ret) {
> >  			dev_warn(dev, "DMA init failed\n");
> >  		} else {
> >  			master->can_dma = dws->dma_ops->can_dma;
> > @@ -963,6 +965,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
> >  	if (dws->dma_ops && dws->dma_ops->dma_exit)
> >  		dws->dma_ops->dma_exit(dws);
> >  	dw_spi_enable_chip(dws, 0);
> > +err_free_irq:
> >  	free_irq(dws->irq, master);
> >  err_free_master:
> >  	spi_controller_put(master);
> > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > index 63e5260100ec..1322b8cce5b7 100644
> > --- a/drivers/spi/spi-dw-dma.c
> > +++ b/drivers/spi/spi-dw-dma.c
> > @@ -139,15 +139,20 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> >  
> >  static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
> >  {
> > -	dws->rxchan = dma_request_slave_channel(dev, "rx");
> > -	if (!dws->rxchan)
> > -		return -ENODEV;
> > +	int ret;
> >  
> > -	dws->txchan = dma_request_slave_channel(dev, "tx");
> > -	if (!dws->txchan) {
> > -		dma_release_channel(dws->rxchan);
> > +	dws->rxchan = dma_request_chan(dev, "rx");
> > +	if (IS_ERR(dws->rxchan)) {
> > +		ret = PTR_ERR(dws->rxchan);
> >  		dws->rxchan = NULL;
> 
> > -		return -ENODEV;
> > +		goto err_exit;
> 

> This change doesn't bring anything...

Right, but it makes this method looking alike dw_spi_dma_init_mfld().
I even used the same label names. It makes the code a little bit easier
to read.

> 
> > +	}
> > +
> > +	dws->txchan = dma_request_chan(dev, "tx");
> > +	if (IS_ERR(dws->txchan)) {
> > +		ret = PTR_ERR(dws->txchan);
> > +		dws->txchan = NULL;
> > +		goto free_rxchan;
> >  	}
> >  
> >  	dws->master->dma_rx = dws->rxchan;
> > @@ -160,6 +165,12 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
> >  	dw_spi_dma_sg_burst_init(dws);
> >  
> >  	return 0;
> > +
> > +free_rxchan:
> > +	dma_release_channel(dws->rxchan);
> > +	dws->rxchan = NULL;
> 
> > +err_exit:
> 

> ...and this too.

ditto

-Sergey

> 
> > +	return ret;
> >  }
> >  
> >  static void dw_spi_dma_exit(struct dw_spi *dws)
> > -- 
> > 2.35.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
