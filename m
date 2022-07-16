Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34284576FF3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiGPPle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:41:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9231DA51;
        Sat, 16 Jul 2022 08:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D9D6B80AB9;
        Sat, 16 Jul 2022 15:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F38EC34114;
        Sat, 16 Jul 2022 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657986090;
        bh=u/RKJ6oT43C5tacik6enadpoU+M83shrDq4oCRky09Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Td3MKs+VV2MR0gd+gXcPIwTeIHB+pa9ZYRGy0sYlof7buXRVWABwtCbAfQF2v9RwL
         0jOXbaYKd1XyUrG4vHEepNK24IkHP6Zq83Z+ceJ6Xi6EcDCIEwVg59IWoqCDKo2TlW
         /T8+Omm/AWv+6Eetf/uJ0JTF2ou95MASsH8BG4b7eZnK6GuEOCNcv4JTP0ObO0Y4IS
         2MPfAu7qvbg7tlsl0lXyuarA2X3WRrecxGNyZll/MktylOs4d+KNu44X4HQoK+Jyet
         PHpIQDk07rPw9cIuM/eJDlZAHNu8LvYtpErDx+FL089S6DzlyLBBsCFfzJ2X+dfdcZ
         nCuqWM9DdK6jg==
Date:   Sat, 16 Jul 2022 16:51:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220716165121.3f0120df@jic23-huawei>
In-Reply-To: <20220701134734.nfc6xa4q7rhfi3r7@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
        <20220616104211.9257-3-ddrokosov@sberdevices.ru>
        <20220619132703.5cf3b090@jic23-huawei>
        <20220701134734.nfc6xa4q7rhfi3r7@CAB-WSD-L081021.sigma.sbrf.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 1 Jul 2022 13:49:10 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> Hello Jonathan,
> 
> Sorry for the delayed response.
> 
> On Sun, Jun 19, 2022 at 01:27:03PM +0100, Jonathan Cameron wrote:
> > On Thu, 16 Jun 2022 10:42:14 +0000
> > Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> >   
> > > MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> > > sensitivity consumer applications. It has dynamical user selectable full
> > > scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> > > with output data rates from 1Hz to 1000Hz.
> > > 
> > > Datasheet can be found at following URL:
> > > https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> > > 
> > > This driver supports following MSA311 features:
> > >     - IIO interface
> > >     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
> > >     - ODR (Output Data Rate) selection
> > >     - Scale and samp_freq selection
> > >     - IIO triggered buffer, IIO reg access
> > >     - NEW_DATA interrupt + trigger
> > > 
> > > Below features to be done:
> > >     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> > >     - Low Power mode
> > > 
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>  
> > Hi Dmitry,
> > 
> > A few things I missed before + I'm still not happy with the runtime
> > pm handling.  One case that isn't covered well is !CONFIG_RUNTIME_PM
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> ...
> 
> > > +static irqreturn_t msa311_buffer_thread(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> > > +	struct device *dev = &msa311->i2c->dev;
> > > +	const struct iio_chan_spec *chan;
> > > +	__le16 axis;
> > > +	int bit = 0, err, i = 0;
> > > +
> > > +	/* Ensure correct alignment of time stamp when present */
> > > +	struct {
> > > +		__le16 channels[MSA311_SI_Z + 1];
> > > +		s64 ts __aligned(8);
> > > +	} buf;
> > > +
> > > +	memset(&buf, 0, sizeof(buf));
> > > +
> > > +	mutex_lock(&msa311->lock);
> > > +
> > > +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> > > +			 indio_dev->masklength) {
> > > +		chan = &msa311_channels[bit];  
> > 
> > Nothing to do with your driver, but feels like it's worth
> > exploring a
> > 	for_each_chan_in_iio_scan(struct iio_chan_spec, struct iio_dev) macro.
> > 
> > I'll add that to my todo list.
> >   
> 
> If you don't mind, I can prepare such a patch.

I had a look at this whilst travelling and it's a lot more complex than I
thought it would be because of gaps in the scan_index in some drivers (not
all channels have scan indexes and not all scan indexes are used)

If we write such a thing we need to resolve that in the core and I suspect
it will require creation of an indirection structure that lets us
do scan_index based look up of channels.  Whilst that works in many drivers
because there is a nice 1 to 1 mapping, there are exceptions.
Hence I think we would be looking at:

1) Check at registration time on whether scan_index == location in
iio_dev->channels, if so set another pointer say iio_dev->channels_linear =
iio_dev->channels.
2) If not, create a lookup table and make iio_dev->channels_linear
point to that.
3) Finally introduce a macro that uses channels_linear.

What fun ;)

Jonathan
 


