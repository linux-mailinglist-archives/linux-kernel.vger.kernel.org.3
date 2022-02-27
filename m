Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC34C5DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiB0RCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiB0RCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:02:30 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E375AA71
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:01:52 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id OMvbnV3p641cbOMvbnynb3; Sun, 27 Feb 2022 18:01:50 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 27 Feb 2022 18:01:50 +0100
X-ME-IP: 90.126.236.122
Message-ID: <5477fb05-d72f-ccc0-1c07-8f2f40d9dde0@wanadoo.fr>
Date:   Sun, 27 Feb 2022 18:01:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iio: adc: mt6360: strengthen return check of
 mt6360_adc_read_channel
Content-Language: en-US
To:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linus.walleij@linaro.org, ardeleanalex@gmail.com,
        Tom Rix <trix@redhat.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
References: <20220227164357.84742-1-trix@redhat.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220227164357.84742-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/02/2022 à 17:43, trix-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org a 
écrit :
> From: Tom Rix <trix-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Clang static analysis reports this issue
> mt6360-adc.c:277:20: warning: Assigned value is
>    garbage or undefined
>    data.values[i++] = val;
>                     ^ ~~~
> 
> val is set by a successful call to m6360_adc_read_channel().
> A negative return is checked but within m6360_adc_read_channel,
> a non zero check is done.
> Strengthen the check to non zero.

Hi, my understanding of m6360_adc_read_channel() is that on success, it 
returns IIO_VAL_INT (i.e. 1).

So, I think that with your patch, we will now always fail because 'ret' 
is never 0 at this point.

CJ

> 
> Signed-off-by: Tom Rix <trix-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iio/adc/mt6360-adc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> index 07c0e67683910..9fb6dc305a392 100644
> --- a/drivers/iio/adc/mt6360-adc.c
> +++ b/drivers/iio/adc/mt6360-adc.c
> @@ -269,7 +269,7 @@ static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
>   	memset(&data, 0, sizeof(data));
>   	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
>   		ret = mt6360_adc_read_channel(mad, bit, &val);
> -		if (ret < 0) {
> +		if (ret) {
>   			dev_warn(&indio_dev->dev, "Failed to get channel %d conversion val\n", bit);
>   			goto out;
>   		}

