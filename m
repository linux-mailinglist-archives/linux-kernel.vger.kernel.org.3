Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5445272D9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiENQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 12:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiENQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 12:15:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB02520F75;
        Sat, 14 May 2022 09:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C605B8013C;
        Sat, 14 May 2022 16:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24978C340EE;
        Sat, 14 May 2022 16:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652544945;
        bh=tIOIi3S7q1xQWDWlo/7pDn06fcYaia7XTmE4LbwYXfM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PkfLwA+Ut+Yo+fMNYP5kfCnox4plWzXcoxAAdw3peKn6c7PC10GKcq2fYruBtvpLI
         T2FRZd2Sb2Umwm1FVLPn5uu5hXgbI40iO59IO7zFJ8cz9DRluvaWETrsixecfym3hH
         uTAkPqSmdLUPtcZLaaAP/itdsVZfc+2dUhzkkkGF2F71pe5DCfFFdjRHBHNgRoaYyz
         MT0w8f8CezdOq2SZ244VwplNlEdxa+WL2R2v6Y5wX0s9RD8pQUGNi3kfZ9jQwGPYF8
         8U/Qtq2xj/kNqidCgepqEfsiUkPZImHq+MC0mc1QobybQsYNg8oSotcv9xMpGPs+g9
         d9fLKJGTUrGww==
Date:   Sat, 14 May 2022 17:24:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v3 2/2] iio: adc: ad4130: add AD4130 driver
Message-ID: <20220514172420.2d4d54b6@jic23-huawei>
In-Reply-To: <f5af3894-c76e-04b6-830a-2687427991b6@gmail.com>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
        <20220419150828.191933-3-cosmin.tanislav@analog.com>
        <20220501170807.1e728524@jic23-huawei>
        <5d932a4a-790e-ca95-c5de-c2267e1f365c@gmail.com>
        <20220507173551.1bc45a82@jic23-huawei>
        <39cb9ade-14af-c53b-bd42-06a9b965b57f@gmail.com>
        <20220507180210.4c48a85f@jic23-huawei>
        <f5af3894-c76e-04b6-830a-2687427991b6@gmail.com>
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

On Sat, 14 May 2022 16:32:25 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> On 5/7/22 20:04, Jonathan Cameron wrote:
> > On Sat, 7 May 2022 19:49:17 +0300
> > Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >   
> >> On 5/7/22 19:35, Jonathan Cameron wrote:  
> >>>      
> >>>>>         
> >>>>>> +static int ad4130_set_fifo_watermark(struct iio_dev *indio_dev, unsigned int val)
> >>>>>> +{
> >>>>>> +	struct ad4130_state *st = iio_priv(indio_dev);
> >>>>>> +	unsigned int eff;
> >>>>>> +	int ret;
> >>>>>> +
> >>>>>> +	if (val > AD4130_FIFO_SIZE)
> >>>>>> +		return -EINVAL;
> >>>>>> +
> >>>>>> +	/*
> >>>>>> +	 * Always set watermark to a multiple of the number of enabled channels
> >>>>>> +	 * to avoid making the FIFO unaligned.
> >>>>>> +	 */
> >>>>>> +	eff = rounddown(val, st->num_enabled_channels);
> >>>>>> +
> >>>>>> +	mutex_lock(&st->lock);
> >>>>>> +
> >>>>>> +	ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
> >>>>>> +				 AD4130_WATERMARK_MASK,
> >>>>>> +				 FIELD_PREP(AD4130_WATERMARK_MASK,
> >>>>>> +					    ad4130_watermark_reg_val(eff)));
> >>>>>> +	if (ret)
> >>>>>> +		goto out;
> >>>>>> +
> >>>>>> +	st->effective_watermark = eff;
> >>>>>> +	st->watermark = val;  
> >>>>>
> >>>>> Hmm this is a potential inconsistency in the IIO ABI.
> >>>>> ABI docs describes watermark as being number of 'scan elements' which is
> >>>>> not the clearest text we could have gone with...
> >>>>>
> >>>>> Now I may well have made a mistake in the following as it's rather a long time
> >>>>> since I last looked at the core handling for this...
> >>>>>
> >>>>> The core treats it as number datum (which is same as a scan) when using
> >>>>> it for the main watermark attribute and also when using watermarks with the
> >>>>> kfifo (the IIO fifo is made up of objects each of which is a scan. So kfifo_len()
> >>>>> returns the number of scans.
> >>>>>     
> >>>>> Looking very quickly at a few other drivers
> >>>>> adxl367 seems to use number of samples.
> >>>>> adxl372 is using number of scans.
> >>>>> bmc150 hardware seems to work on basis of frame count which I 'think' is probably scans.
> >>>>> fxls8962 uses 'samples count' which is not clearly defined in the datasheet but there
> >>>>> is an example showing that it's scans (I think)...
> >>>>> lsm6dsx - some of the fifos used with this are based on tagged data so the connection to
> >>>>> what hits the front end buffers is non obvious.
> >>>>>
> >>>>> So, not great for consistency :(
> >>>>>
> >>>>> Going forwards i think we should standardize the hardware fifo watermark on what is being
> >>>>> used for the software watermark which I believe is number of scans.
> >>>>> Not necessary much we can do about old drivers though due to risk of breaking ABI...
> >>>>> We should make the documentation clearer though.
> >>>>>         
> >>>>
> >>>> I was confused too, but this seemed more logical to me at the time, and
> >>>> since you didn't say anything regarding it on ADXL367, I did it the same
> >>>> way here. I guess we can't go back and change it now on ADXL367, I'm
> >>>> sorry for this. I'll fix it.  
> >>>
> >>> I missed it.  Review is never perfect (mine definitely aren't!)
> >>>
> >>> Thinking more on the adxl367. We still have a window to  fix that as
> >>> the driver isn't yet in a release kernel.  Would you mind spinning a
> >>> patch to fix that one?  Even if we miss the rc cycle (it's a bit tight
> >>> timing wise) we can sneak it in as an early fix in stable without
> >>> significant risk of breaking anyone's userspace.
> >>>      
> >>
> >> I hope Monday is not too late to do it?  
> > 
> > Any time next week should be fine.  If it ends up later that's fine as well.
> > We have at least a few weeks until the 5.18 release and then if we were to land
> > this during the first few weeks of the next cycle that would be fine as well.
> > No one should be insane enough to not pick up at least the first few stable
> > releases of a new kernel!
> >   
> >> I can also try to do the changes tomorrow but I don't have the hardware
> >> anymore so I won't be able to test until I get it back, which is only
> >> next week.
> >>  
> >>> There might be other drivers that have that interpretation we can't
> >>> fix but if we can reduce the scope of the problem by changing the adxl367
> >>> that would be great.
> >>>
> >>> We should also definitely improve the docs and perhaps add a note to say
> >>> that due to need to maintain ABI, a few drivers use scans * number of channels
> >>> rather than scans.  
> >>
> >> I guess I could also do that at the same time.  
> > 
> > Perfect :)
> > 
> > Thanks for sorting this out.
> > 
> > Jonathan
> > 
> >   
> 
> I've just had another good look at ADXL367. It seems that I'm quick at
> forgetting stuff about the code I write.
> 
> In adxl367_set_fifo_samples(), fifo_watermark is multiplied by
> fifo_set_size, then, if it is larger than the maximum watermark,
> it is capped at the maximum watermark, and then, it is divided
> by fifo_set_size again.
> 
> In the end, fifo_watermark actually seems to mean number of scans
> in that driver too.
> 
> So this was a huge confusion. The different thing about AD4130 is that
> the register actually means number of samples, and not number of scans,
> so that's where that confussion stemmed from.
> 
> Sorry for wasting your time on this.

No problem and thanks for looking into this in more depth!

Jonathan


