Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1455D503644
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiDPLP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 07:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiDPLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 07:15:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2B2E5413;
        Sat, 16 Apr 2022 04:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADAD1B80687;
        Sat, 16 Apr 2022 11:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F59C385A5;
        Sat, 16 Apr 2022 11:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650107572;
        bh=bRGdM51RRpea4PxpnQqVJdFGDcc0UH0JobnMgITXHO8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nSU3sdDdx3h/gZSdiEylXPuQRyQwHU/LiiVV7H2/mBRc8npIkZWRHUSWgXBPeu/DO
         nQ3yGNn9TgbSbF+rCbx+2Sq2405UvarvQ6PE8GR3P3QxL8H8nRdPtbd83KJ6x532q9
         TIO3vc4uHIHeVTQfENn+BjOrseJByvupo6eD9MBcLCAoikx2llMVeGDlvSeNjDHbpR
         tjDpZd1NjMCweLd1a0TON4p0MPGKp/4JhM7YrJJPZZ12pamNFlG1hBMdg9F/mmhzAz
         W2xG+xnht5w987U1ynGIJPKAwmmr6obMM/92KZ9iniFpW2zGhUGasFVk5+Eb4Eb738
         JjTogovP4J2Ew==
Date:   Sat, 16 Apr 2022 12:20:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rui Miguel Silva <rmfrfs@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: gyro: fxas21002c: Make use of device
 properties
Message-ID: <20220416122050.72c88536@jic23-huawei>
In-Reply-To: <20220413162623.azoqoehu23kggk4x@arch-thunder>
References: <20220413131513.59258-1-andriy.shevchenko@linux.intel.com>
        <20220413162623.azoqoehu23kggk4x@arch-thunder>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 17:26:23 +0100
Rui Miguel Silva <rmfrfs@gmail.com> wrote:

> Hi Andy,
> Thanks for the patch.
> 
> On Wed, Apr 13, 2022 at 04:15:13PM +0300, Andy Shevchenko wrote:
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> This LGTM.
> 
> Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>
> 
Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to poke at it and see what we missed.

Thanks,

Jonathan

> Cheers,
>      Rui
> 
> > ---
> >  drivers/iio/gyro/fxas21002c_core.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> > index 410e5e9f2672..0923fd793492 100644
> > --- a/drivers/iio/gyro/fxas21002c_core.c
> > +++ b/drivers/iio/gyro/fxas21002c_core.c
> > @@ -7,9 +7,9 @@
> >  
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> > -#include <linux/of_irq.h>
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  
> > @@ -822,7 +822,6 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
> >  {
> >  	struct device *dev = regmap_get_device(data->regmap);
> >  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > -	struct device_node *np = indio_dev->dev.of_node;
> >  	unsigned long irq_trig;
> >  	bool irq_open_drain;
> >  	int irq1;
> > @@ -831,8 +830,7 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
> >  	if (!data->irq)
> >  		return 0;
> >  
> > -	irq1 = of_irq_get_byname(np, "INT1");
> > -
> > +	irq1 = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> >  	if (irq1 == data->irq) {
> >  		dev_info(dev, "using interrupt line INT1\n");
> >  		ret = regmap_field_write(data->regmap_fields[F_INT_CFG_DRDY],
> > @@ -843,7 +841,7 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
> >  
> >  	dev_info(dev, "using interrupt line INT2\n");
> >  
> > -	irq_open_drain = of_property_read_bool(np, "drive-open-drain");
> > +	irq_open_drain = device_property_read_bool(dev, "drive-open-drain");
> >  
> >  	data->dready_trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> >  						   indio_dev->name,
> > -- 
> > 2.35.1
> >   

