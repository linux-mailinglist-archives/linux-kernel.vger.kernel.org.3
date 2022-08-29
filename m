Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA25A51F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiH2QiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiH2Qh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:37:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0329972FE0;
        Mon, 29 Aug 2022 09:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B32E3B81163;
        Mon, 29 Aug 2022 16:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53127C433D6;
        Mon, 29 Aug 2022 16:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661791074;
        bh=eibLJ3CUrG9hNqELWlk54EEgp0CwfpUXbipAy8OJ/Rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hjTi3NWRZRKarMRukkPrPlrfbczzHlJrlbZ0wlwbgd4zthARraC2jsoROA+OQCSkZ
         539PvLT0rdKRHveV6Cr3+/OaCGsWNeois6d/TPW26i3sSXQdmPNS7L1dMR/fVYng5R
         x0W/aPsZSr1pzRX8WIzZYDgHBVopO9Y+TQri4btlOf5zK2lDMqnJswu1AeOZ6ZL00w
         24xdvflP/FnBKkkSzzmcAy2z/P3UXqw12Egr08Y/WsW12429mu1fx99T+7XmV0nbWH
         YRClY1cF40LvtNtc5VJGWpy6VcqFdwzhmsJAmw+0IHlu3sAmGdexg6lIusy9oWrjGN
         wlj6nVOk5+GKw==
Date:   Mon, 29 Aug 2022 17:03:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Regus, Ciprian" <Ciprian.Regus@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] drivers: iio: adc: Rename the LTC249x iio device
Message-ID: <20220829170334.70dbebdc@jic23-huawei>
In-Reply-To: <c76a746e0a6448b2a39a4ce7e5baa285@analog.com>
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
        <20220822125106.1106798-4-ciprian.regus@analog.com>
        <0f778952-1909-1038-8f9a-3a7d7f12d6e1@metafoo.de>
        <c76a746e0a6448b2a39a4ce7e5baa285@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 29 Aug 2022 06:13:52 +0000
"Regus, Ciprian" <Ciprian.Regus@analog.com> wrote:

> Hi Lars,
> 
> Thanks for the review. I have one question before going further
> with this patch.
> 
> > On 8/22/22 14:51, Ciprian Regus wrote:  
> > > Set the iio device's name based on the chip used.  
> > 
> > While the change is correct it breaks the ABI. This needs a bit of a
> > better explanation what is being done, why, what are the potential
> > problems, why do we want to do it anyway.  
> 
> The reason for this change is to make it easier to identify the device
> (by having a generic name) when using an IIO client. The current name is
> based on the i2c_client's kobj name, which has the format
> "i2c_instance -i2c_address " (e.g. 1-0076). So, the renaming would allow
> for interacting with the device without knowing which bus it's connected
> to.
> 
> Also, as far as I can see, the IIO ABI states that the device's name is
> "Typically a part number".
> 
> For the reason given, would this change be considered an
> improvement, or is the ABI breaking too much of a drawback?
> (in which case I'll just drop this patch)

Hi Ciprian

There are a set of drivers that do it similarly to this (amongst other
things because I wasn't paying attention a few years back).

Generally we've considered them unfixable unfortunately because it's
common to use name to find the device - so userspace breakage is
very likely.

If we are introducing new device support thought here can't be a platform
already relying on the old naming.  So weird though it seems, can you fix
this just for the newly supported models and leave the old ones 'broken'?
(with a big note on why!)  Perhaps do that by leaving .name = NULL for the
older parts and doing a check on that to select behaviour.

Thanks,

Jonathan

> 
> Thanks,
> Ciprian
> >   
> > >
> > > Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> > > ---
> > >   drivers/iio/adc/ltc2496.c      | 1 +
> > >   drivers/iio/adc/ltc2497-core.c | 2 +-
> > >   drivers/iio/adc/ltc2497.c      | 2 ++
> > >   drivers/iio/adc/ltc2497.h      | 1 +
> > >   4 files changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
> > > index 98338104c24a..86470f49e8ca 100644
> > > --- a/drivers/iio/adc/ltc2496.c
> > > +++ b/drivers/iio/adc/ltc2496.c
> > > @@ -89,6 +89,7 @@ static void ltc2496_remove(struct spi_device *spi)
> > >
> > >   static struct chip_info ltc2496_info = {
> > >   	.resolution = 16,
> > > +	.name = "ltc2496"
> > >   };
> > >
> > >   static const struct of_device_id ltc2496_of_match[] = {
> > > diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> > > index b2752399402c..6dd9ab601904 100644
> > > --- a/drivers/iio/adc/ltc2497-core.c
> > > +++ b/drivers/iio/adc/ltc2497-core.c
> > > @@ -169,7 +169,7 @@ int ltc2497core_probe(struct device *dev, struct  
> > iio_dev *indio_dev)  
> > >   	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
> > >   	int ret;
> > >
> > > -	indio_dev->name = dev_name(dev);
> > > +	indio_dev->name = ddata->chip_info->name;
> > >   	indio_dev->info = &ltc2497core_info;
> > >   	indio_dev->modes = INDIO_DIRECT_MODE;
> > >   	indio_dev->channels = ltc2497core_channel;
> > > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > > index bb5e0d4301e2..a0aad71c8130 100644
> > > --- a/drivers/iio/adc/ltc2497.c
> > > +++ b/drivers/iio/adc/ltc2497.c
> > > @@ -99,9 +99,11 @@ static int ltc2497_remove(struct i2c_client *client)
> > >   static struct chip_info ltc2497_info[] = {
> > >   	[TYPE_LTC2497] = {
> > >   		.resolution = 16,
> > > +		.name = "ltc2497"
> > >   	},
> > >   	[TYPE_LTC2499] = {
> > >   		.resolution = 24,
> > > +		.name = "ltc2499"
> > >   	}
> > >   };
> > >
> > > diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> > > index f4d939cfd48b..0e86e38248ee 100644
> > > --- a/drivers/iio/adc/ltc2497.h
> > > +++ b/drivers/iio/adc/ltc2497.h
> > > @@ -12,6 +12,7 @@ enum chip_type {
> > >
> > >   struct chip_info {
> > >   	u32 resolution;
> > > +	char *name;
> > >   };
> > >
> > >   struct ltc2497core_driverdata {  
> >   
> 

