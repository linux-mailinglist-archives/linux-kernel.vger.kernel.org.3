Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552D459B086
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiHTUsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 16:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiHTUsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:48:01 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F20A25C78;
        Sat, 20 Aug 2022 13:48:00 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id k2so7574634vsk.8;
        Sat, 20 Aug 2022 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Wz1oeeUArHlim5LpcdQItAXe+EqMZtpBrl59xupd7zY=;
        b=Q5o7uMpWNiJiS0NmuHgXnU3vWnWlXROKmTDVmYTt/IsERN1xApVIU0xaAEJqm41Mgw
         QlC3Ksf12rYH5owT3T+GNzP7pD1MVcWtd6uY6iguexgEX3n4SwVhlhJ6A4S5xN0oDlo2
         YTSNM+cQIB5V8P+P50aOkE8I5gzOF0q5EM9e0DIOr8QXj/Qt4hHdmTBEcw3S2cib8407
         i/GFvzYC95o5qEqUOXoQ7EWToPm5Owk6eDo0oXSAI9kWokdthlXz/GFV+gayq3cF1t10
         lenph6US6ebTHeXIfFsglKB3xgq+9wVKMmh4MBKHFlIaL8iyFAIyex2PPgH8kqjUbz2y
         6xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Wz1oeeUArHlim5LpcdQItAXe+EqMZtpBrl59xupd7zY=;
        b=DnAC8PnsAjkNEU/AUT4rpi4I6TIG5RUSRBldAED81j3w2c0qcY8zJZkglx2HmvJcKu
         S2VKy6pHp/sOIT9QFAKAdhEPygj1aYhBeib+CfI5yhpjUqCHc5W+3dn66r9ZoJyCsQUa
         2e2kqN4Ke88y91VQ4wa9syqQIFy/DXhOqbCv3ci9+ZCFdXGOxrSI2c9FLQjsbf8RsWuO
         o9ykMBhUoqkIuTYW2GVH26K0tcmBSCfsiwL2M89SDhW/78mt90OTLrcRmM8wn5DSwZwH
         lSOb74PQislMy7S7erpiu3dJqJlZvnHNEr9oqWmRCoXHcu0ied8bCiDRKzzrM/GRcf2I
         +hBw==
X-Gm-Message-State: ACgBeo0eqqDSVyxDEioWev/6q6FT3vXEwDzLszyE2BMZZ6bzqV0k3XiK
        Y3qFOIj4joShorY+/4iXROQ=
X-Google-Smtp-Source: AA6agR75i+jLJNpMb551MJ64DCSPgX0eoBTW6F+NVzpxg/Sf65HlDa0utnppcvh6KxrcDXjCtmovOA==
X-Received: by 2002:a67:e243:0:b0:387:3666:4e67 with SMTP id w3-20020a67e243000000b0038736664e67mr4793452vse.47.1661028479134;
        Sat, 20 Aug 2022 13:47:59 -0700 (PDT)
Received: from localhost ([2804:30c:1679:2000:dcdb:74d9:edea:13a6])
        by smtp.gmail.com with ESMTPSA id g194-20020a1fb6cb000000b0037d0bb0a3c8sm5590947vkf.15.2022.08.20.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 13:47:58 -0700 (PDT)
Date:   Sat, 20 Aug 2022 17:47:56 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ad7292: Prevent regulator double disable
Message-ID: <YwFIfKvuuDYiJywk@marsc.168.1.7>
References: <Yv9O+9sxU7gAv3vM@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv9O+9sxU7gAv3vM@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti, thank you for this patch.

On 08/19, Matti Vaittinen wrote:
> The ad7292 tries to add an devm_action for disabling a regulator at
> device detach using devm_add_action_or_reset(). The
> devm_add_action_or_reset() does call the release function should adding
> action fail. The driver inspects the value returned by
> devm_add_action_or_reset() and manually calls regulator_disable() if
> adding the action has failed. This leads to double disable and messes
> the enable count for regulator.
> 
That's correct. The regulator device even issued a message saying so
fixed-supply: Underflow of regulator enable count

Verified driver behavior on a raspberry pi with eval board.

Thanks again for this fix.

> Do not manually call disable if devm_add_action_or_reset() fails.
> 
> Fixes: 506d2e317a0a ("iio: adc: Add driver support for AD7292")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Jonathan, can we still add more tags to this patch? If so, please add mine

Tested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> 
> ---
> 
> The bug was found during browsing the code. I don't have the hardware to
> test this so reviewing and testing is highly appreciated.
> ---
>  drivers/iio/adc/ad7292.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> index 92c68d467c50..a2f9fda25ff3 100644
> --- a/drivers/iio/adc/ad7292.c
> +++ b/drivers/iio/adc/ad7292.c
> @@ -287,10 +287,8 @@ static int ad7292_probe(struct spi_device *spi)
>  
>  		ret = devm_add_action_or_reset(&spi->dev,
>  					       ad7292_regulator_disable, st);
> -		if (ret) {
> -			regulator_disable(st->reg);
> +		if (ret)
>  			return ret;
> -		}
>  
>  		ret = regulator_get_voltage(st->reg);
>  		if (ret < 0)
> -- 
> 2.37.1
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 


