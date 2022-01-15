Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072D648F8AB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiAOSN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiAOSNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:13:25 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF30C061574;
        Sat, 15 Jan 2022 10:13:24 -0800 (PST)
Received: from [81.101.6.87] (port=47194 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n8nYH-0002Hi-35; Sat, 15 Jan 2022 18:13:21 +0000
Date:   Sat, 15 Jan 2022 18:19:22 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: tsc2046: add .read_raw support
Message-ID: <20220115181922.7d947226@jic23-huawei>
In-Reply-To: <20220111131848.GE3326@pengutronix.de>
References: <20220107093527.3046331-1-o.rempel@pengutronix.de>
        <20220109155956.003167f1@jic23-huawei>
        <20220111131848.GE3326@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 14:18:48 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Jonathan,
> 
> On Sun, Jan 09, 2022 at 04:00:09PM +0000, Jonathan Cameron wrote:
> > On Fri,  7 Jan 2022 10:35:27 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >   
> > > Add read_raw() support to make use of iio_hwmon and other iio clients.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>  
> > Hi Oleksij
> > 
> > Main questions in here are around settling time and the interface used for that.
> >   
> > > ---
> > >  drivers/iio/adc/ti-tsc2046.c | 114 ++++++++++++++++++++++++++++++++---
> > >  1 file changed, 106 insertions(+), 8 deletions(-)
> > > 
> > > @@ -252,16 +266,47 @@ static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
> > >  static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
> > >  				u32 *effective_speed_hz)
> > >  {
> > > +	struct tsc2046_adc_ch_cfg *ch = &priv->ch_cfg[ch_idx];
> > > +	struct tsc2046_adc_atom *rx_buf, *tx_buf;
> > > +	unsigned int val, val_normalized = 0;
> > > +	int ret, i, count_skip = 0, max_count;
> > >  	struct spi_transfer xfer;
> > >  	struct spi_message msg;
> > > -	int ret;
> > > +	u8 cmd;
> > > +
> > > +	if (!effective_speed_hz) {
> > > +		count_skip = tsc2046_adc_time_to_count(priv, ch->settling_time_us);
> > > +		max_count = count_skip + ch->oversampling_ratio;
> > > +	} else {
> > > +		max_count = 1;
> > > +	}
> > > +
> > > +	tx_buf = kcalloc(max_count, sizeof(*tx_buf), GFP_KERNEL);
> > > +	if (!tx_buf)
> > > +		return -ENOMEM;
> > > +
> > > +	rx_buf = kcalloc(max_count, sizeof(*rx_buf), GFP_KERNEL);
> > > +	if (!rx_buf) {
> > > +		ret = -ENOMEM;
> > > +		goto free_tx;
> > > +	}  
> > 
> > I guess these are fine to do everytime because you expect this to be used in
> > paths which aren't called at a particularly high frequency?  
> 
> Yes, this was my assumption as well. Instead of preallocating buffer of
> max size, I hope it is less ugly.
> 
> > These buffers could get rather large so maybe you need a cap on settling time?  
> 
> What do you mean by "cap on settling"?

In theory the buffer needed could get very large, so perhap set a maximum reasonable
size (1 page perhaps) and report an error if the settling time is too large to fit
in that space.

> 
> >   
> > > +
> > > +	/*
> > > +	 * Do not enable automatic power down on working samples. Otherwise the
> > > +	 * plates will never be completely charged.
> > > +	 */
> > > +	cmd = tsc2046_adc_get_cmd(priv, ch_idx, true);
> > > +
> > > +	for (i = 0; i < max_count - 1; i++)
> > > +		tx_buf[i].cmd = cmd;
> > > +
> > > +	/* automatically power down on last sample */
> > > +	tx_buf[i].cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
> > >  
> > >  	memset(&xfer, 0, sizeof(xfer));
> > > -	priv->tx_one->cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
> > > -	priv->tx_one->data = 0;
> > > -	xfer.tx_buf = priv->tx_one;
> > > -	xfer.rx_buf = priv->rx_one;  
> > 
> > Are these used for anything else?  If not probably need to drop them and
> > their allocation.  
> 
> done
> 
> > > -	xfer.len = sizeof(*priv->tx_one);
> > > +	xfer.tx_buf = tx_buf;
> > > +	xfer.rx_buf = rx_buf;
> > > +	xfer.len = sizeof(*tx_buf) * max_count;  
> > 
> > This could be very big and more than possible some spi controllers will fail
> > it (or does the SPI core handle splitting very large transfers?)  Maybe a loop
> > is needed with smaller fixed size transfers?  
> 
> I can't exclude possible issue with some of SPI drivers. But SPI level
> optimizations should be done on SPI driver or framework level.

As above, I think you want to set a reasonable limit otherwise it will fail
on an awful lot of hardware if someone sets a silly value...

> 
> > >  	spi_message_init_with_transfers(&msg, &xfer, 1);
> > >  
> > >  	/*
> > > @@ -272,13 +317,25 @@ static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
> > >  	if (ret) {
> > >  		dev_err_ratelimited(&priv->spi->dev, "SPI transfer failed %pe\n",
> > >  				    ERR_PTR(ret));
> > > +		*val2 = chan->scan_type.realbits;
> > > +		return IIO_VAL_FRACTIONAL_LOG2;
> > > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > > +		*val = priv->ch_cfg[chan->channel].oversampling_ratio;
> > > +		return IIO_VAL_INT;
> > > +	case IIO_CHAN_INFO_DEBOUNCE_COUNT:  
> > 
> > These are unusual. I think they've only been used for the more literal bounce suppression
> > of a human step counting algorithm.
> > 
> > I'd probably not expect to see the both even if we decide this is applicable.  
> 
> Ok, i do not need this information so far. I'll remove it
> 
> > > +		*val = tsc2046_adc_time_to_count(priv,
> > > +				priv->ch_cfg[chan->channel].settling_time_us);  
> > 
> > Setting time is often about external circuitry so it's a bit unusual to expose
> > it to userspace rather than making it a device tree property and just making
> > sure the driver doesn't provide a reading until appropriate debounce has passed.
> > Here is coming from DT anyway, so what benefit do these two read only channel
> > properties provide?  
> 
> No benefit. Will remove it.
> 
> Regards,
> Oleksij

