Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6B59A470
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350279AbiHSR6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350816AbiHSR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:57:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30F631358;
        Fri, 19 Aug 2022 10:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 28E3CCE26B5;
        Fri, 19 Aug 2022 17:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDCBC433D6;
        Fri, 19 Aug 2022 17:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660930983;
        bh=CtN0bU1lCxBA2fo8mhjV2ip2dwYJ1d1FUVmor9iMIE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eNPvGdQ/HZ3TrSyM9+mcrX5Ixzh7JeBIY71kH3qCq3XhdcIh+cj7SNkuW2qWOqSlm
         KMU8VkmtknY5zH4Jt/Bwl/i2Fqd3XP9HvUzfpLJsfCOdOcnP5lBM6xZvHPwpepqC32
         l7QvgFgsdBLLh6FdQHJ5JDWINV5YUWb2DmWq+ZeLi0b7Jq+bF3//cebXvNa5TetDIz
         Yw9AkJyB9ohxI2FSWDmPmpVIj0gjvlmB2pcn3T08N+juDfmP01fHSL//PveRBViwy2
         fKZEg2pFqi7Tx7+BtiRZ94tYGR8jqd4/D897mmTN2jDH3yqZfE0pDypYbtO0cng8s/
         37N3gk1KRxa7g==
Date:   Fri, 19 Aug 2022 18:53:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 4/4] input: joystick: Fix buffer data parsing
Message-ID: <20220819185339.7f488ad8@jic23-huawei>
In-Reply-To: <20220817105643.95710-5-contact@artur-rojek.eu>
References: <20220817105643.95710-1-contact@artur-rojek.eu>
        <20220817105643.95710-5-contact@artur-rojek.eu>
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

On Wed, 17 Aug 2022 12:56:43 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> Don't try to access buffer data of a channel by its scan index. Instead,
> use the newly introduced `iio_find_channel_offset_in_buffer` to get the
> correct data offset.
> 
> The scan index of a channel does not represent its position in a buffer,
> as the buffer will contain data for enabled channels only, affecting
> data offsets and alignment.
> 
> Fixes: 2c2b364fddd5 ("Input: joystick - add ADC attached joystick driver.")
> Reported-by: Chris Morgan <macromorgan@hotmail.com>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  drivers/input/joystick/adc-joystick.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
> index c0deff5d4282..aed853ebe1d1 100644
> --- a/drivers/input/joystick/adc-joystick.c
> +++ b/drivers/input/joystick/adc-joystick.c
> @@ -6,6 +6,7 @@
>  #include <linux/ctype.h>
>  #include <linux/input.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -46,36 +47,43 @@ static void adc_joystick_poll(struct input_dev *input)
>  static int adc_joystick_handle(const void *data, void *private)
>  {
>  	struct adc_joystick *joy = private;
> +	struct iio_buffer *buffer;
>  	enum iio_endian endianness;
> -	int bytes, msb, val, idx, i;
> -	const u16 *data_u16;
> +	int bytes, msb, val, off;
> +	const u8 *chan_data;
> +	unsigned int i;
>  	bool sign;
>  
>  	bytes = joy->chans[0].channel->scan_type.storagebits >> 3;
>  
>  	for (i = 0; i < joy->num_chans; ++i) {
> -		idx = joy->chans[i].channel->scan_index;
>  		endianness = joy->chans[i].channel->scan_type.endianness;
>  		msb = joy->chans[i].channel->scan_type.realbits - 1;
>  		sign = tolower(joy->chans[i].channel->scan_type.sign) == 's';
> +		buffer = iio_channel_cb_get_iio_buffer(joy->buffer);
> +		off = iio_find_channel_offset_in_buffer(joy->chans[i].indio_dev,
> +							joy->chans[i].channel,
> +							buffer);

With this call replaced with one that instead uses

		off = iio_find_channel_offset_in_buffer(joy->chans, i);

which I'm fairly sure is enough via the info in chans[x]->channel to establish this offset.

All is good, though you should probably cache it as doing that maths every
time seems excessive.


> +		if (off < 0)
> +			return off;
> +
> +		chan_data = (const u8 *)data + off;
>  
>  		switch (bytes) {
>  		case 1:
> -			val = ((const u8 *)data)[idx];
> +			val = *chan_data;
>  			break;
>  		case 2:
> -			data_u16 = (const u16 *)data + idx;
> -
>  			/*
>  			 * Data is aligned to the sample size by IIO core.
>  			 * Call `get_unaligned_xe16` to hide type casting.
>  			 */
>  			if (endianness == IIO_BE)
> -				val = get_unaligned_be16(data_u16);
> +				val = get_unaligned_be16(chan_data);

I obviously missed this previously but these are aligned so we don't need the
unaligned form.

>  			else if (endianness == IIO_LE)
> -				val = get_unaligned_le16(data_u16);
> +				val = get_unaligned_le16(chan_data);
>  			else /* IIO_CPU */
> -				val = *data_u16;
> +				val = *(const u16 *)chan_data;
>  			break;
>  		default:
>  			return -EINVAL;

