Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB65855A9FF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiFYMiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiFYMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:38:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3594015FC6;
        Sat, 25 Jun 2022 05:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB37861203;
        Sat, 25 Jun 2022 12:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EBAC3411C;
        Sat, 25 Jun 2022 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656160687;
        bh=BI0iF/XEbEx3iB4dR5ueuZ7PpNJ4Qxsj8axGKnWS2hc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g9IZZU8/xwty1eYersDGG7MGq15JwH1SfVqgKH7oU3EFQI6lY1rPlwoHR7x7KVCMU
         Yhw64blJw1YsDflzBs4sV8NeiklZVizhxTZoehyauK3+VUJWtKvPlYcNBDMQ42jMdD
         7OZ0p2u+s13m+6o4F/BXcbNgootSg73RkG9aUpPhUgu1yrCtLheF+7cVZaygL9KTmU
         /PX5zTpuMVRly5UZ0/TFZa1jF8H7aMR75+5bnw03LDgTBIb4mrqKQLDxhv1VUrxqwr
         6vakD1hmZI4/i2KlKUInsHldtHiDT/nGk+lb7YFySONGGZtAN4S+Vy69/DY5HPzzPS
         uXmpJrV5NqgiA==
Date:   Sat, 25 Jun 2022 13:47:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] iio: adc: mcp3911: add support for phase
Message-ID: <20220625134735.6726544a@jic23-huawei>
In-Reply-To: <20220625103853.2470346-8-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
        <20220625103853.2470346-8-marcus.folkesson@gmail.com>
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

On Sat, 25 Jun 2022 12:38:51 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The MCP3911 incorporates a phase delay generator,
> which ensures that the two ADCs are converting the
> inputs with a fixed delay between them.
> Expose it to userspace.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Until now I think we've only had the phase modifier for output channels.
So at minimum need to add documentation for it in
Documentation/ABI/testing/sysfs-bus-iio

However, the snag is that it's defined in terms of radians.
The usecase here assumes that the sensor is measuring some sort of
wave form, but unfortunately we don't know what that is - hence
the setting is in terms of clock delay.

As such, though the datasheet calls if phase, I think that is
stretching the meaning too far in the IIO ABI. We probably need
something new.  

Years ago, for devices that are actually a single ADC and a MUX
where we pretend in IIO that the channels are sampled synchronously
we talked about provided the timing delay information to userspace.
Nothing ever came of it, but that is effectively the same concept
as you have here.

So, it's a time measurement so units will need to be seconds -
userspace has no idea of the clk speed of a device. For two channels
the relationship is straight forward, but I wonder for 3 channel devices
how we would handle it.  The two different sources of this delay might
lead to different controls being optimal.

Naming wise, perhaps samplingdelay?

If you have actual ADCs that operate independently then relationship to
a base reference point will be independent. 
So for a 3 channel device you'd have

in_voltage0_samplingdelay  0
in_voltage1_samplingdelay  Phase register 1 code / DMCLK
in_voltage2_samplingdelay  Phase register 2 code / DMCLK

But for a device that is a mux in front of one actual ADC
then the timing is likely to be relative to previous channel
Hence if all turned on...

in_voltage0_samplingdelay  0
in_voltage1_samplingdelay  Phase register 1 code / DMCLK
in_voltage2_samplingdelay  Phase register 2 code + Phase register 1 code / DMCLK

If only 0 and 2 enabled.

in_voltage0_samplingdelay  0
in_voltage2_samplingdelay  Phase register X code

However we can probably just make that problem for the driver. Sometimes
we'll have to reject or approximate particular combinations of enabled channels
and requested delays. 
One corner case that is nasty will be if there is just one controllable delay.
In that case it would seem natural to have just one attribute, but the delay
would be cumulative across multiple enabled channels.  For that I think
we'd just need different ABI.

in_voltage_intersampledelay  maybe?  With two channels the various options
would all work but we should think ahead...

There is another complexity. These values apply to the buffered data, not
otherwise. Moving them into bufferX/ would nicely associate them with the
enabled channels and make it more obvious that there is a coupling there

However, it is more complex to add attributes to the buffers..
If we think that is the right way to go for ABI it wouldn't be too hard to
add to the core - but will need a new callback.

So my gut feeling is that this should be

bufferX/in_voltage0_samplingdelay 0
bufferX/in_voltage1_samplingdelay Phase register 1 code / DMCLK seconds
but it is a rather nasty layering violation.

That will require us adding a new callback read_scan_el_raw() and appropriate
enum etc.

Things will get more complex for 3 channel deviceson multibuffer devices or when there are in
kernel consumers (as those may effect the enabled channels but aren't visible in
bufferX).  However, I don't see it being that likely we'll get that combination
of features any time soon (famous last words!)

Gut feeling is that adding this feature (and discussion of ABI) will
take a while, but it shouldn't block picking up the rest of the series
in the meantime.

Jonathan


> ---
> 
> Notes:
>     v2:
>         - Fix formatting (Andy Schevchenko)
> 
>  drivers/iio/adc/mcp3911.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index ede1ad97ed4d..a0609d7663e1 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -155,6 +155,17 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = IIO_VAL_INT;
>  		break;
> +
> +	case IIO_CHAN_INFO_PHASE:
> +		ret = mcp3911_read(adc,
> +				   MCP3911_REG_PHASE, val, 2);
> +		if (ret)
> +			goto out;
> +
> +		*val = sign_extend32(*val, 12);
> +		ret = IIO_VAL_INT;
> +		break;
> +
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		ret = mcp3911_read(adc,
>  				MCP3911_REG_CONFIG, val, 2);
> @@ -225,6 +236,15 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  				MCP3911_STATUSCOM_EN_OFFCAL, 2);
>  		break;
>  
> +	case IIO_CHAN_INFO_PHASE:
> +		if (val2 != 0 || val > 0xfff) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		/* Write phase */
> +		ret = mcp3911_write(adc, MCP3911_REG_PHASE, val, 2);
> +		break;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		for (int i = 0; i < sizeof(mcp3911_osr_table); i++) {
>  			if (val == mcp3911_osr_table[i]) {
> @@ -248,7 +268,9 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  		.channel = idx,					\
>  		.scan_index = idx,				\
>  		.scan_index = idx,				\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +		.info_mask_shared_by_type =			\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)|	\
> +			BIT(IIO_CHAN_INFO_PHASE),		\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>  			BIT(IIO_CHAN_INFO_OFFSET) |		\
>  			BIT(IIO_CHAN_INFO_SCALE),		\

