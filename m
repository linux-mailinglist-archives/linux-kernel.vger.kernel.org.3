Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B4251E883
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351128AbiEGQbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbiEGQbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64EC31222;
        Sat,  7 May 2022 09:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F88961277;
        Sat,  7 May 2022 16:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3E2C385A6;
        Sat,  7 May 2022 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651940843;
        bh=3rr8bPT1a3oSQb1SQ5wfvUm81Gi7wyQPTmJOEcdlh2A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dqm5PdfERD+8qcwDSg/e8RFozVMjEnfGErAOdc6LJrU22OqtG3qYIdJig/qdNMkxM
         6KTnVBi7SyqV0XbQR8/qWp1OxotQ4YxBXyCFKUSVsdArXze2M6P5deYbpEyawuaIKq
         /IL9tGVPxpQzRsgJq1sZUni/mXUoMcZZZQpQTl0YjD+SkUc3w41LeEn0YroQmGo31U
         3ztBgNuHz7CsIUeg9iDRIyJLdPMOZjrgUT21T4XE57FepY/Tj/cNMGfWSvDgvi98wQ
         zW453DBNKHr7+/iQl/V7RPAv8WxZ0YOshOMsEDoX4Nz9hhCJLN/GgIUBQ0vZTUkKux
         q6Pd7LVcjG+gQ==
Date:   Sat, 7 May 2022 17:35:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v3 2/2] iio: adc: ad4130: add AD4130 driver
Message-ID: <20220507173551.1bc45a82@jic23-huawei>
In-Reply-To: <5d932a4a-790e-ca95-c5de-c2267e1f365c@gmail.com>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
        <20220419150828.191933-3-cosmin.tanislav@analog.com>
        <20220501170807.1e728524@jic23-huawei>
        <5d932a4a-790e-ca95-c5de-c2267e1f365c@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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


> >   
> >> +static int ad4130_set_fifo_watermark(struct iio_dev *indio_dev, unsigned int val)
> >> +{
> >> +	struct ad4130_state *st = iio_priv(indio_dev);
> >> +	unsigned int eff;
> >> +	int ret;
> >> +
> >> +	if (val > AD4130_FIFO_SIZE)
> >> +		return -EINVAL;
> >> +
> >> +	/*
> >> +	 * Always set watermark to a multiple of the number of enabled channels
> >> +	 * to avoid making the FIFO unaligned.
> >> +	 */
> >> +	eff = rounddown(val, st->num_enabled_channels);
> >> +
> >> +	mutex_lock(&st->lock);
> >> +
> >> +	ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
> >> +				 AD4130_WATERMARK_MASK,
> >> +				 FIELD_PREP(AD4130_WATERMARK_MASK,
> >> +					    ad4130_watermark_reg_val(eff)));
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	st->effective_watermark = eff;
> >> +	st->watermark = val;  
> > 
> > Hmm this is a potential inconsistency in the IIO ABI.
> > ABI docs describes watermark as being number of 'scan elements' which is
> > not the clearest text we could have gone with...
> > 
> > Now I may well have made a mistake in the following as it's rather a long time
> > since I last looked at the core handling for this...
> > 
> > The core treats it as number datum (which is same as a scan) when using
> > it for the main watermark attribute and also when using watermarks with the
> > kfifo (the IIO fifo is made up of objects each of which is a scan. So kfifo_len()
> > returns the number of scans.
> >   
> > Looking very quickly at a few other drivers
> > adxl367 seems to use number of samples.
> > adxl372 is using number of scans.
> > bmc150 hardware seems to work on basis of frame count which I 'think' is probably scans.
> > fxls8962 uses 'samples count' which is not clearly defined in the datasheet but there
> > is an example showing that it's scans (I think)...
> > lsm6dsx - some of the fifos used with this are based on tagged data so the connection to
> > what hits the front end buffers is non obvious.
> > 
> > So, not great for consistency :(
> > 
> > Going forwards i think we should standardize the hardware fifo watermark on what is being
> > used for the software watermark which I believe is number of scans.
> > Not necessary much we can do about old drivers though due to risk of breaking ABI...
> > We should make the documentation clearer though.
> >   
> 
> I was confused too, but this seemed more logical to me at the time, and
> since you didn't say anything regarding it on ADXL367, I did it the same
> way here. I guess we can't go back and change it now on ADXL367, I'm
> sorry for this. I'll fix it.

I missed it.  Review is never perfect (mine definitely aren't!)

Thinking more on the adxl367. We still have a window to  fix that as
the driver isn't yet in a release kernel.  Would you mind spinning a
patch to fix that one?  Even if we miss the rc cycle (it's a bit tight
timing wise) we can sneak it in as an early fix in stable without
significant risk of breaking anyone's userspace.

There might be other drivers that have that interpretation we can't
fix but if we can reduce the scope of the problem by changing the adxl367
that would be great.

We should also definitely improve the docs and perhaps add a note to say
that due to need to maintain ABI, a few drivers use scans * number of channels
rather than scans.

> 
> >> +
> >> +out:
> >> +	mutex_unlock(&st->lock);
> >> +
> >> +	return ret;
> >> +}
> >> +  
> > 
> > 
> > ...
> >   
> >> +
> >> +static int ad4130_parse_fw_channel(struct iio_dev *indio_dev,
> >> +				   struct fwnode_handle *child)
> >> +{
> >> +	struct ad4130_state *st = iio_priv(indio_dev);
> >> +	unsigned int index = indio_dev->num_channels++;
> >> +	struct device *dev = &st->spi->dev;
> >> +	struct ad4130_chan_info *chan_info;
> >> +	struct iio_chan_spec *chan;
> >> +	u32 pins[2];
> >> +	int ret;
> >> +
> >> +	if (index >= AD4130_MAX_CHANNELS)
> >> +		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
> >> +
> >> +	chan = &st->chans[index];
> >> +	chan_info = &st->chans_info[index];
> >> +
> >> +	*chan = ad4130_channel_template;
> >> +	chan->scan_type.realbits = st->chip_info->resolution;
> >> +	chan->scan_type.storagebits = st->chip_info->resolution;
> >> +	chan->scan_index = index;
> >> +
> >> +	chan_info->slot = AD4130_INVALID_SLOT;
> >> +	chan_info->setup.fs = AD4130_FS_MIN;
> >> +	chan_info->initialized = true;
> >> +
> >> +	ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
> >> +					     ARRAY_SIZE(pins));
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = ad4130_validate_diff_channels(st, pins, ARRAY_SIZE(pins));
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	chan->channel = pins[0];
> >> +	chan->channel2 = pins[1];
> >> +
> >> +	ret = ad4130_parse_fw_setup(st, child, &chan_info->setup);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	fwnode_property_read_u32(child, "adi,excitation-pin-0",
> >> +				 &chan_info->iout0);
> >> +	if (chan_info->setup.iout0_val != AD4130_IOUT_OFF) {  
> > 
> > It would be slightly better to set an explicit default value here as the fact it
> > is 0 is hidden by the enum. e.g.
> > 	chan_info->iout0 = AD4130_IOUT_OFF;
> > 	fwnode_property_read_u32(child, "adi,excitation-pin-0",
> > 			 	 &chan_info->iout0);
> > 	if (chan_info->....
> > That would save reviewers wondering what the default is and having to go
> > check the enum (and I'm lazy :)  
> 
> I understand the idea, but the default value for iout0 is not
> AD4130_IOUT_OFF. iout0 is the pin that iout0_val current is
> applied to, and AD4130_IOUT_OFF is a value for iout0_val.
> Look at ad4130_parse_fw_setup.
> 
> For iout0, I guess I could do
> #define AD4130_AIN0	0x0
> ...
> chan_info->iout0 = AD4130_AIN0;

Oops.  I got confused.  Code is fine as it is.  Adding the define isn't going to make
it much clearer.
 
> 
> >> +		}
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +

