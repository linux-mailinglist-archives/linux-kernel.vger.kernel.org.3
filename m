Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A24659A6DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351593AbiHSUEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351558AbiHSUEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:04:06 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Aug 2022 13:04:03 PDT
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230B7C747;
        Fri, 19 Aug 2022 13:04:00 -0700 (PDT)
Message-ID: <f8eaa7ce-8f33-b561-a9e1-a007f704af14@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1660939127;
        bh=mRQlqUiR3YkPKtD18b6chQglsvkhSFJ5UFwvj2kApEI=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding:From:Subject:To:
         Date:Sender:Content-Type:Content-Transfer-Encoding:
         Content-Disposition:Mime-Version:Reply-To:In-Reply-To:References:
         Message-Id:Autocrypt;
        b=1fp7hkIpmhK1KOXcJv49p9XmUv83TCNwqfKyT94SLLlypMjol5NgvttGon/Xs9f0z
         QXXmihvQuQikRXoIjNmXS8ljRgOcV1uuAJRkAR8jCxXNGmTFzufIcqRhwm5oA028Sp
         2FcDh0jc8SK9tGXnQVlOpkeL758CE+VKnl6uLBUTaMC9cVWRZ5wfARvvtRD9pM/YuP
         MUhMFoSgY7OloxXWBiOUGEe0krcZmRzwVCykRiwgLwHbYau5jQkphLgROSKH9MzW6b
         BJh5brFnxgKxsYKfjSYTl4/hk27DpXvPcHWXtwKxPUcvxD/yI9FpVaiydHkzIKsLKv
         YJLPnwuOKPwew==
Date:   Fri, 19 Aug 2022 22:58:45 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v3 12/14] iio: max1241: simplify using
 devm_regulator_get_enable()
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <7c759bf6c06e72ae70bffeebc1939d9903427278.1660934107.git.mazziesaccount@gmail.com>
From:   Alexandru Lazar <alazar@startmail.com>
In-Reply-To: <7c759bf6c06e72ae70bffeebc1939d9903427278.1660934107.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heya,

I don't have the hardware at hand (long story, lots of smoke), so all I 
can do for this patch at the moment is:

Acked-by: Alexandru Lazar <alazar@startmail.com>

That being said, IIRC the MAX1241 has no special requirements in this 
regard, so if other SPI devices work, this one ought to work as well. If 
anyone's concerned, I can test it, but probably not sooner than a week 
or so :-(.

FWIW I really like this, the straightforward regulator boilerplate 
always felt a tad wrong.

All the best,
Alex

On 8/19/2022 10:20 PM, Matti Vaittinen wrote:
> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> add_action_or_reset(regulator_disable)' and use the
> devm_regulator_get_enable() and drop the pointer to the regulator.
> This simplifies code and makes it less tempting to add manual control
> for the regulator which is also controlled by devm.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> v2 => v3:
> New patch
> ---
>   drivers/iio/adc/max1241.c | 28 +++-------------------------
>   1 file changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
> index a815ad1f6913..500bb09ab19b 100644
> --- a/drivers/iio/adc/max1241.c
> +++ b/drivers/iio/adc/max1241.c
> @@ -22,7 +22,6 @@ enum max1241_id {
>   struct max1241 {
>   	struct spi_device *spi;
>   	struct mutex lock;
> -	struct regulator *vdd;
>   	struct regulator *vref;
>   	struct gpio_desc *shutdown;
>   
> @@ -110,17 +109,6 @@ static const struct iio_info max1241_info = {
>   	.read_raw = max1241_read_raw,
>   };
>   
> -static void max1241_disable_vdd_action(void *data)
> -{
> -	struct max1241 *adc = data;
> -	struct device *dev = &adc->spi->dev;
> -	int err;
> -
> -	err = regulator_disable(adc->vdd);
> -	if (err)
> -		dev_err(dev, "could not disable vdd regulator.\n");
> -}
> -
>   static void max1241_disable_vref_action(void *data)
>   {
>   	struct max1241 *adc = data;
> @@ -147,20 +135,10 @@ static int max1241_probe(struct spi_device *spi)
>   	adc->spi = spi;
>   	mutex_init(&adc->lock);
>   
> -	adc->vdd = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(adc->vdd))
> -		return dev_err_probe(dev, PTR_ERR(adc->vdd),
> -				     "failed to get vdd regulator\n");
> -
> -	ret = regulator_enable(adc->vdd);
> +	ret = devm_regulator_get_enable(dev, "vdd");
>   	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(dev, max1241_disable_vdd_action, adc);
> -	if (ret) {
> -		dev_err(dev, "could not set up vdd regulator cleanup action\n");
> -		return ret;
> -	}
> +		return dev_err_probe(dev, ret,
> +				     "failed to get/enable vdd regulator\n");
>   
>   	adc->vref = devm_regulator_get(dev, "vref");
>   	if (IS_ERR(adc->vref))
