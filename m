Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BC84D6E3A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 11:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiCLKmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 05:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiCLKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:42:05 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC33B26E036
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:40:59 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id r13so24087578ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mFsSD1c4g3l2OYCc1c3FtLKI1mcqNVpSXz15ZyAFhMs=;
        b=sd41uWonzwPXHr7hQfXjjyyDI2TcQxu+PVm+ZVwddvrk1IoB1xZkwaOjOqtRPD1OyG
         /1EtE4ZBoVcIvfkKXFEeTJSggmfo8AE8zGVlkA+RM3szuw42ffIvCrDwNbFlQinMCNVM
         mi1FiP8y4jq1gYm0s2G4WFMfKsuXOTOqsTfetDxyI9JG/BaKkhXxh2T1/nsFOKlBRLAT
         s93Ug//M4Ho5M4SNIKmgFR0v7T+Isz6diZuUgZpEnux1cFUkQvYsJe6cN22vrWXPLDw7
         qE6lfkNaWQJyimmnpo5I3BxNxfOlPM7xQLPmmCk23uR4aST7dyi002as1cG9E5HP7pf6
         Tt/g==
X-Gm-Message-State: AOAM531QhknO86kuNM1W0mX0RsOnAO+PEOybncZ63Ap1leYEhgP7ZY0m
        4jQrFT8vXoirqL/pEdyaWWY=
X-Google-Smtp-Source: ABdhPJw2r+b07GDBmNizv28JrCenfc8xH5nTSLjewggU0Rjby4EVRC8RAW5bFSoCkM+7t8zT2bgsiw==
X-Received: by 2002:a17:906:b052:b0:6ce:88a5:e42a with SMTP id bj18-20020a170906b05200b006ce88a5e42amr11963926ejb.237.1647081658122;
        Sat, 12 Mar 2022 02:40:58 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm4167533ejz.199.2022.03.12.02.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 02:40:57 -0800 (PST)
Message-ID: <009acb4c-d59c-c1ad-60b0-cc85fe7ad73d@kernel.org>
Date:   Sat, 12 Mar 2022 11:40:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RESEND V2] ASoC: max98390: Add reset gpio control
Content-Language: en-US
To:     Steve Lee <steve.lee.analog@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
        rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, jack.yu@realtek.com,
        nuno.sa@analog.com, ryans.lee@maximintegrated.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20220312002429.16175-1-steve.lee.analog@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220312002429.16175-1-steve.lee.analog@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 01:24, Steve Lee wrote:
>  Add reset gpio control to support RESET PIN connected to gpio.
> 
> Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> ---
>  sound/soc/codecs/max98390.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
> index 40fd6f363f35..9a9299e5cc5a 100644
> --- a/sound/soc/codecs/max98390.c
> +++ b/sound/soc/codecs/max98390.c
> @@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
>  
>  	struct max98390_priv *max98390 = NULL;
>  	struct i2c_adapter *adapter = i2c->adapter;
> +	struct gpio_desc *reset_gpio;
>  
>  	ret = i2c_check_functionality(adapter,
>  		I2C_FUNC_SMBUS_BYTE
> @@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> +	reset_gpio = devm_gpiod_get_optional(&i2c->dev,
> +					     "maxim,reset-gpios", GPIOD_OUT_LOW);
> +

I don't know why did you CC me, but since I am looking at this - you
have to update bindings.

Do not add random properties to drivers without updating bindings.

Best regards,
Krzysztof
