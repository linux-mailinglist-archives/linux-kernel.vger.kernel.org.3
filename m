Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EDE54AFC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356113AbiFNMB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355700AbiFNMBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D24755C;
        Tue, 14 Jun 2022 05:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E090B61447;
        Tue, 14 Jun 2022 12:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09DBC3411B;
        Tue, 14 Jun 2022 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655208104;
        bh=LKqyWyQmcJaA3SvTrNYjoW6lWIWdeCZLpK4/rEHviu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k897SLDR4H+mpyaaoFacmDnazvJsOLlfx2oSQ4Fr9kje3NYw405CAQ4KwlY365j14
         n1vI66VJB0F3nVokUCC8xtJlrYKx5LVrMYM69ySDcS4bqR1jW4NZkqUSU9tsVPtquz
         OhsNMVjRrMrP3X9wCM5YyoOj0HWTNVdTWIVuwueZZJ/GIv9CR5OKGeFmaiQFZ7qGbx
         9uySlW84COMvlsTi8BYQ3gDKCuaN2L7MR60TNy66IoPDqCeRnVQVYU3tawa3rDZKH+
         WOdtHWQGfQZK0LL2Y6tq8sEdcIIdoNTa8oN2vsSMji5wEi5Q3lPig7cbfZRkd31Kxf
         WmPOkT6VtfKnA==
Date:   Tue, 14 Jun 2022 13:10:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Claudiu.Beznea@microchip.com>
Cc:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/16] iio: adc: at91-sama5d2_adc: add support for
 temperature sensor
Message-ID: <20220614131053.35acf820@jic23-huawei>
In-Reply-To: <6da7ad4f-a746-de46-c3df-b2f6a2078b3d@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
        <20220609083213.1795019-14-claudiu.beznea@microchip.com>
        <20220611191503.63387587@jic23-huawei>
        <6da7ad4f-a746-de46-c3df-b2f6a2078b3d@microchip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 10:13:17 +0000
<Claudiu.Beznea@microchip.com> wrote:

> On 11.06.2022 21:15, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, 9 Jun 2022 11:32:10 +0300
> > Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> >   
> >> SAMA7G5 has a temperature sensor embedded that is connected to channel 31
> >> of ADC. Temperature sensor provides 2 outputs: VTEMP and VBG. VTEMP is
> >> proportional to the absolute temperature voltage, VBG is quasi-temperature
> >> independent voltage. The calibration data for temperature sensor are
> >> retrieved from OTP memory specific to SAMA7G5. The formula to calculate
> >> the junction temperature is as follows:
> >>
> >> P1 + (Vref * (Vtemp - P6 - P4 * Vbg)) / (Vbg * VTEMP_DT)
> >>
> >> where Pi are calibration data retrieved from OTP memory.
> >>
> >> For better resolution before reading the temperature certain settings
> >> for oversampling ratio, sample frequency, EMR.TRACKX, MR.TRACKTIM are
> >> applied. The initial settings are reapplied at the end of temperature
> >> reading. Current support is not integrated with trigger buffers.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>  
> > 
> > This is a complex driver, so I got a bit lost figuring out what happens
> > about buffered capture of this channel.  What ends up in the buffer?  
> 
> With this implementation nothing should end up in the buffer as the patch
> skips channel enable/disable if its about an IIO_TEMP channel (see
> functions functions at91_adc_buffer_prepare(),
> at91_adc_buffer_postdisable()). More details above.
> 
> According to datasheet the temperature channel behaves the same as the
> other channels. On temperature channel are multiplexed both VBG and VTEMP.
> 
>           `
>           | \      +-----+
> VBG   --->|  |ch31 |     |
> Vtemp --->|  |---->| ADC |
>           |  /     +-----+
>           | /
>           .
> 
> And both are needed to be measured in order to determine the correct in SoC
> temperature.
> 
> At a moment of time only one of these could be measured, the selection
> being done with bit SRCLCH bit of ACR register.
> 
> According to datasheet there is no special treatment for channel 31 of ADC
> in case triggers are enabled. So, in case of a buffer capture the buffer
> for channel 31 will contain either the converted value for VBG or VTEMP
> (depending on the value of bit SRCLCH bit of ACR register), if channel 31
> is enabled for that. But on this implementation we skip the enable/disable
> of IIO_TEMP channels (functions at91_adc_buffer_prepare(),
> at91_adc_buffer_postdisable()).

Great explanation. Perhaps we can capture some of it either as comments,
or patch description etc.

> 
> Hardware implements a special mechanism for reading the temperature when
> triggers are enabled as follows: the hardware provides a RTC trigger wich
> fires every 1 second and starts a conversion on channel 31. This could
> permit to have a temperature value once every 2 seconds (in the 1st RTC
> trigger VBG could be read, in the 2nd RTC trigger Vtemp could be read, or
> the other way arround). For this, configuration needs to be done propertly
> in the RTC memory spaces and on Linux side something should be implemented
> for the interaction b/w RTC and IIO subsystems. But this is for future
> development.
> 
> > Most processed channels are not useable with that mode (and hence have
> > a scanindex == -1 which ensures they aren't exposed as an option for
> > userspace to enable).  
> 
> OK, I haven't been aware of that. I only did some basic research on how
> this could be achieved. As we are using the thermal support on SAMA7G5 with
> driver at drivers/thermal/thermal-generic-adc.c which reads processed value
> at periodic intervals one idea was to take advantage of the RTC trigger
> mechanism for channel 31 and have the converted values of VBG and VTEMP
> kept only inside the at91-sama5d2_adc.c thus when receiving requests from
> themal-generic-adc.c and buffers are enabled to use those cached values in
> computation formula.
Sure, that might work ok. It's a bit of a hack, but would let you keep the
more interesting stuff hidden way in one place.

>

...


> >> +#define AT91_SAMA5D2_CHAN_TEMP(num, name, addr)                              \
> >> +     {                                                               \
> >> +             .type = IIO_TEMP,                                       \
> >> +             .channel = num,                                         \
> >> +             .address =  addr,                                       \
> >> +             .scan_index = num,                                      \
> >> +             .scan_type = {                                          \
> >> +                     .sign = 'u',                                    \
> >> +                     .realbits = 16,                                 \
> >> +                     .storagebits = 16,                              \  
> > 
> > So this is unusual.  Normally a processed channel isn't suitable for buffered
> > capture because they tend not to fit in nice compact storage.  In this case
> > what actually goes in the buffer?  Perhaps a comment would be useful here.  
> 
> At the moment we don't allow the enabling of channel 31 when enabling the
> buffers (we skip IIO_TEMP channels in at91_adc_buffer_prepare(),
> at91_adc_buffer_postdisable()). At the moment when buffers are enabled the
> IIO_TEMP consumer (drivers/thermal/thermal-generic-adc.c) will fail on
> readings due to iio_buffer_enabled() in at91_adc_read_temp() or
> iio_device_claim_direct_mode() in at91_adc_read_info_raw().

I suspected as much. If so, a bunch of this makes not sense. Channels that
can't be in that buffer have magic scan_index = -1 and .scan_type is
probably not used (occasionally it is helpful for non buffered paths, though
rarely all the info in there).

> 

> >> +static int at91_adc_read_temp(struct iio_dev *indio_dev,
> >> +                           struct iio_chan_spec const *chan, int *val)
> >> +{
> >> +     struct at91_adc_state *st = iio_priv(indio_dev);
> >> +     struct at91_adc_temp_sensor_clb *clb = &st->soc_info.temp_sensor_clb;
> >> +     u64 div1, div2;
> >> +     u32 tmp;
> >> +     int ret, vbg, vtemp;
> >> +
> >> +     if (!st->soc_info.platform->temp_sensor || !st->temp_st.init)
> >> +             return -EPERM;  
> > 
> > You shouldn't register the channel if it's not readable.  Hence this
> > should never happen.  
> 
> I kept this as an indicator for temperature consumer that something wrong
> happend on probing path of temperature sensor. In function
> at91_adc_temp_sensor_init() the following could fail:
> - devm_nvmem_cell_get()
> - nvmem_cell_read()
> - invalid length for NVMEM cell
> Thus to keep the ADC probe going on in case temperature sensor probing init
> failed I've added this st->temp_st.init. On the field there might be
> devices that don't have proper information in NVMEM memory for temperature
> sensor.

If those fail, don't register the channel.  It should just be invisible
to userspace / in kernel consumers.  That may require reorganizing how
you register channels to know if these worked or not before the
point of registering channels.


Thanks,

Jonathan
