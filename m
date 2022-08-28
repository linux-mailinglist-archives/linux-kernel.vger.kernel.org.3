Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A26E5A3EFE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiH1R6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1R6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B191C10D;
        Sun, 28 Aug 2022 10:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C078660DCC;
        Sun, 28 Aug 2022 17:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA53FC433C1;
        Sun, 28 Aug 2022 17:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661709531;
        bh=9H9TbFkmdLwyyGdSzbjytNfr4f2l2OIo10bnB3M+lS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pVemWdkKGzZ6rTNdGL33BAoqa09a6Z4nAhZs0BZzPFiF5Z8DO0UzobF+QU63rUJMj
         /0u3OhZaEs/2894GXbELDh3k+MeaVsYvxPbUVCfKbHHG3ZXkExCEp/LXxyAGHL2JAI
         3+fkra5BEwZdGJHj86XvC2nJdE4wx64h20+yX89aLa11G4HHyhtSeNVmHZaBSLWBJ1
         1rizMiRCtkLx540pSpA7KcnA/7k1taeFD/5qqphsDLTGH4ycSEUwQFbPvgrJYjk0iw
         Amt30d0/f3HlX/T+iw3s7elEftesb4uhjZkA5QoBHHjbQUL/d92I4kL1I0IKarzrpy
         Ai9kVl5wvhIIQ==
Date:   Sun, 28 Aug 2022 18:24:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     <kernel@axis.com>, <lars@metafoo.de>, <axel.jonsson@axis.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: mcp320x: add triggered buffer support
Message-ID: <20220828182430.533bf8e0@jic23-huawei>
In-Reply-To: <20220824104002.2749075-3-vincent.whitchurch@axis.com>
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
        <20220824104002.2749075-3-vincent.whitchurch@axis.com>
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

On Wed, 24 Aug 2022 12:40:02 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> From: Axel Jonsson <axel.jonsson@axis.com>
> 
> Add support for triggered buffers.  Just read the channels in a loop to
> keep things simple.

Just curious, but what other options are there?  A quick datasheet scroll
through didn't seem to suggest you can overlap setup of next read with
reading out the previous (common on SPI ADCs).

A few minor additional comments inline.

Thanks,

Jonathan


> 
> Signed-off-by: Axel Jonsson <axel.jonsson@axis.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/iio/adc/Kconfig   |   2 +
>  drivers/iio/adc/mcp320x.c | 130 ++++++++++++++++++++++++++++----------
>  2 files changed, 99 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 48ace7412874..9f2628120885 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -696,6 +696,8 @@ config MAX9611
>  config MCP320X
>  	tristate "Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Microchip Technology's
>  	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204,
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 28398f34628a..9782cbd37728 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -43,6 +43,10 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  #include <linux/regulator/consumer.h>
>  
>  enum {
> @@ -231,37 +235,51 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -#define MCP320X_VOLTAGE_CHANNEL(num)				\
> -	{							\
> -		.type = IIO_VOLTAGE,				\
> -		.indexed = 1,					\
> -		.channel = (num),				\
> -		.address = (num),				\
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
> +#define MCP320X_VOLTAGE_CHANNEL(num)					\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = (num),					\
> +		.address = (num),					\
> +		.scan_index = (num),					\
> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = 32,					\
> +			.storagebits = 32,				\
> +			.endianness = IIO_CPU,				\
> +		},							\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
>  	}
>  
> -#define MCP320X_VOLTAGE_CHANNEL_DIFF(chan1, chan2)		\
> -	{							\
> -		.type = IIO_VOLTAGE,				\
> -		.indexed = 1,					\
> -		.channel = (chan1),				\
> -		.channel2 = (chan2),				\
> -		.address = (chan1),				\
> -		.differential = 1,				\
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
> +#define MCP320X_VOLTAGE_CHANNEL_DIFF(chan1, chan2, diffoff)		\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = (chan1),					\
> +		.channel2 = (chan2),					\
> +		.address = (chan1),					\
> +		.scan_index = (chan1 + diffoff),			\

I wonder if it's just more readable to use scan_index as one of the parameters
of this macro. If it's the first one, then you'll
see 
	*VOLTAGE_CHANNEL(0),
	*VOLTAGE_CHANNEL(1),
	*VOLTAGE_CHANNEL_DIFF(2, 0, 1),
	*VOLTAGE_CHANNEL_DIFF(3, 1, 0),
etc

If we can avoid reformatting this in the same patch that adds the new
stuff it will make it easier to see the changes.

If you want to reformat, add another patch to do that as a no-op change.


> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = 32,					\
> +			.storagebits = 32,				\
> +			.endianness = IIO_CPU,				\
> +		},							\
> +		.differential = 1,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE)	\
>  	}
>  
>  static const struct iio_chan_spec mcp3201_channels[] = {
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1, 1),
>  };
>  
>  static const struct iio_chan_spec mcp3202_channels[] = {
>  	MCP320X_VOLTAGE_CHANNEL(0),
>  	MCP320X_VOLTAGE_CHANNEL(1),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1, 2),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0, 2),
>  };
>  
>  static const struct iio_chan_spec mcp3204_channels[] = {
> @@ -269,10 +287,10 @@ static const struct iio_chan_spec mcp3204_channels[] = {
>  	MCP320X_VOLTAGE_CHANNEL(1),
>  	MCP320X_VOLTAGE_CHANNEL(2),
>  	MCP320X_VOLTAGE_CHANNEL(3),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 3),
> -	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 2),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0, 1, 4),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(1, 0, 4),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(2, 3, 4),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(3, 2, 4),
>  };


