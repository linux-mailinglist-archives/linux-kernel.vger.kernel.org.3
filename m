Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F07577E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiGRJZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiGRJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:25:19 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC9F19025;
        Mon, 18 Jul 2022 02:25:16 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id 23266FF80B;
        Mon, 18 Jul 2022 09:25:12 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 18 Jul 2022 11:25:12 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: adc-joystick - fix ordering in
 adc_joystick_probe()
In-Reply-To: <YskFh4NHnlcryMkk@google.com>
References: <YskFh4NHnlcryMkk@google.com>
Message-ID: <c93f12598af6d708d702e0538b5c700e@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-09 06:35, Dmitry Torokhov wrote:
> We should register the IIO buffer before we register the input device,
> because as soon as the device is registered input handlers may attach 
> to
> it, resulting in a call to adc_joystick_open() which makes use of the 
> said
> buffer.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> Not tested on hardware...
Hi Dmitry,

nice catch, thanks! I will verify the operation on hardware some time 
over the weekend.
Small nitpick inline. With that changed:

Acked-by: Artur Rojek <contact@artur-rojek.eu>

> 
>  drivers/input/joystick/adc-joystick.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/joystick/adc-joystick.c
> b/drivers/input/joystick/adc-joystick.c
> index 78ebca7d400a..e0cfdc84763f 100644
> --- a/drivers/input/joystick/adc-joystick.c
> +++ b/drivers/input/joystick/adc-joystick.c
> @@ -222,13 +222,6 @@ static int adc_joystick_probe(struct 
> platform_device *pdev)
>  	if (error)
>  		return error;
> 
> -	input_set_drvdata(input, joy);
> -	error = input_register_device(input);
> -	if (error) {
> -		dev_err(dev, "Unable to register input device\n");
> -		return error;
> -	}
> -
>  	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
>  	if (IS_ERR(joy->buffer)) {
>  		dev_err(dev, "Unable to allocate callback buffer\n");
> @@ -241,6 +234,14 @@ static int adc_joystick_probe(struct 
> platform_device *pdev)
>  		return error;
>  	}
> 
> +	input_set_drvdata(input, joy);
> +
> +	error = input_register_device(input);
> +	if (error) {
> +		dev_err(dev, "Unable to register input device\n");
> +		return error;
> +	}
> +
>  	return 0;
Since this is now the last thing the function does, we can simplify the 
code a bit:
```
	error = input_register_device(input);
	if (error)
		dev_err(dev, "Unable to register input device\n");

	return error;
```

Cheers,
Artur
>  }
> 
> --
> 2.37.0.144.g8ac04bfd2-goog
