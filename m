Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55C5524C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbiFTTms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245505AbiFTTmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:42:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ACE1CB15;
        Mon, 20 Jun 2022 12:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6E32B81636;
        Mon, 20 Jun 2022 19:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C7BC3411B;
        Mon, 20 Jun 2022 19:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655754152;
        bh=QUatO8LljWRFWGqX+mKGIdqVItZiPZbPTMtwsPK3ejg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P7M1cz9itYGT0Le204mddGf50LgAqGQGNLHKf6zrrQjK63f3g+n+qlzYHm2n/1wqH
         QHa4rWTpe8CltOZpz4jIzQTS/ndinb9UdJMMWtoIUBiGKZAZXG5LQRxPYz5cjAMK5O
         DWRsta3SQzZ8bI8cEG8FdxsbRfPuanXC5Ur1TaEMe6C9CusUY1nPqtxCzSXOJTk011
         IfrtMncfVckj3zH15Sa6EUJvgdFrBO9zoqPxpTsOw42EzzE/Kgv8UxvHAZcvgpkVyX
         KEDbgyL4b2twcUfB3+cKEZlQtMWU+KD59LwrxlPfKg7W9qZk4/aCZ3fo7MvC6RW0J+
         4ZdlivkKFSQ8Q==
Date:   Mon, 20 Jun 2022 20:42:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
Message-ID: <20220620204225.34d40a3f@jic23-huawei>
In-Reply-To: <20220603181006.2c5cc6c4@jic23-huawei>
References: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
        <20220603181006.2c5cc6c4@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jun 2022 18:10:06 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 30 May 2022 20:33:24 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > First of all, the additional conversion from vIRQ, and this is exactly
> > what is returned by platform_get_irq_byname(), to vIRQ is not needed.  
> Confusing sentence form.  Perhaps:
> 
> First, the additional conversion from vIRQ (returned by platform_get_irq_byname())
> to vIRQ is not needed.
> 
> > Hence, drop no-op call to irq_of_parse_and_map().
> > 
> > Second, assign the firmware node instead of of_node.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> Hi,
> 
> Seems sensible to me, but I'd like a sanity check from someone more
> familiar with this driver.

This one has been outstanding for a few weeks. I'd still like
an Ack or similar form someone who knows this device well.

If no one has looked at it in a week or so I'll just go with
my judgement and pick it up.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/mxs-lradc-adc.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> > index bca79a93cbe4..25292bb8a13f 100644
> > --- a/drivers/iio/adc/mxs-lradc-adc.c
> > +++ b/drivers/iio/adc/mxs-lradc-adc.c
> > @@ -17,7 +17,6 @@
> >  #include <linux/mfd/core.h>
> >  #include <linux/mfd/mxs-lradc.h>
> >  #include <linux/module.h>
> > -#include <linux/of_irq.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/sysfs.h>
> >  
> > @@ -692,7 +691,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
> >  	struct mxs_lradc_adc *adc;
> >  	struct iio_dev *iio;
> >  	struct resource *iores;
> > -	int ret, irq, virq, i, s, n;
> > +	int ret, irq, i, s, n;
> >  	u64 scale_uv;
> >  	const char **irq_name;
> >  
> > @@ -721,7 +720,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
> >  	platform_set_drvdata(pdev, iio);
> >  
> >  	iio->name = pdev->name;
> > -	iio->dev.of_node = dev->parent->of_node;
> > +	device_set_node(&iio->dev, dev_fwnode(dev->parent));
> >  	iio->info = &mxs_lradc_adc_iio_info;
> >  	iio->modes = INDIO_DIRECT_MODE;
> >  	iio->masklength = LRADC_MAX_TOTAL_CHANS;
> > @@ -747,9 +746,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
> >  		if (irq < 0)
> >  			return irq;
> >  
> > -		virq = irq_of_parse_and_map(dev->parent->of_node, irq);
> > -
> > -		ret = devm_request_irq(dev, virq, mxs_lradc_adc_handle_irq,
> > +		ret = devm_request_irq(dev, irq, mxs_lradc_adc_handle_irq,
> >  				       0, irq_name[i], iio);
> >  		if (ret)
> >  			return ret;  
> 

