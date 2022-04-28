Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63840513B71
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350967AbiD1SYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbiD1SYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:24:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8E957B2D;
        Thu, 28 Apr 2022 11:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF1676168B;
        Thu, 28 Apr 2022 18:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6274C385A0;
        Thu, 28 Apr 2022 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651170075;
        bh=imln+1c9r+M+Glr7eY5+sQk5QxndtJrCqKyuS/l1fuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KDAYk5EmhoVnbsS3jMX2rNM7AyRKVcnu9ulsSNfmEMWvtfPMEVp14rLd/ExcOVqiR
         KnV8E+kV6zf9zqv2dYN8ApKOqi0BRpCagn1RwHMeAkoKn4pxsTGtE/Zd3fq1popJ0p
         ahdK+eJsLrPCV87AM7WjzaiqhslHFLo5Tp/PWwnj4wfPZJ4TTl/fxePSBgcMZnbmK9
         x4oewtcCmODfvflQ6mNci+sf9LITyZvKKsuqcNGxFHMBH/1OUw1uZvyTR1MYY1A+z0
         64BMddQUID1gYioKj0EO4D43+joa2m8pnmZP1Ln9wPMNRn6wPKZEE2bzhBW4X+cb5S
         cX4YkXOKFXi8A==
Date:   Thu, 28 Apr 2022 19:29:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: proximity: mb1232: Switch to use
 fwnode_irq_get()
Message-ID: <20220428192927.660e728c@jic23-huawei>
In-Reply-To: <Yl6N2rnZsdJ9WJ6q@arbad>
References: <20220413183123.20292-1-andriy.shevchenko@linux.intel.com>
        <20220416120726.0ba78960@jic23-huawei>
        <Yl6N2rnZsdJ9WJ6q@arbad>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 12:24:26 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Jonathan Cameron <jic23@kernel.org> schrieb am Sa, 16. Apr 12:07:
> > On Wed, 13 Apr 2022 21:31:23 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > We have OF-centric variant of fwnode_irq_get() in the driver.
> > > Replace it with a call to an agnostic implementation.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Whilst I 'think' this ends up being functionally identical
> > I'd like to leave it a little longer to see if Andreas has
> > time to take a look and verify this change is fine.
> > 
> > There seem to be subtle differences in the irq setup as the
> > new code does a sanity check on the domain being available
> > and defers if not which I don't think happens with the
> > existing code.  
> 
> Anyway interrupts are optional and the driver will work without i don't see any
> issue here.
> 
> Acked-by: Andreas Klinger <ak@it-klinger.de>

Applied to the togreg branch of iio.git and pushed out as testing to
see if 0-day can find anything we missed.

Thanks,

Jonathan

> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> > > ---
> > >  drivers/iio/proximity/mb1232.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> > > index ad4b1fb2607a..0bca5f74de68 100644
> > > --- a/drivers/iio/proximity/mb1232.c
> > > +++ b/drivers/iio/proximity/mb1232.c
> > > @@ -10,12 +10,14 @@
> > >   * https://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
> > >   */
> > >  
> > > +#include <linux/bitops.h>
> > >  #include <linux/err.h>
> > >  #include <linux/i2c.h>
> > > -#include <linux/of_irq.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/mod_devicetable.h>
> > >  #include <linux/module.h>
> > > -#include <linux/bitops.h>
> > > +#include <linux/property.h>
> > > +
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/sysfs.h>
> > >  #include <linux/iio/buffer.h>
> > > @@ -209,7 +211,7 @@ static int mb1232_probe(struct i2c_client *client,
> > >  
> > >  	init_completion(&data->ranging);
> > >  
> > > -	data->irqnr = irq_of_parse_and_map(dev->of_node, 0);
> > > +	data->irqnr = fwnode_irq_get(dev_fwnode(&client->dev), 0);
> > >  	if (data->irqnr <= 0) {
> > >  		/* usage of interrupt is optional */
> > >  		data->irqnr = -1;  
> >   
> 

