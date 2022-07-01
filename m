Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7FB5638C1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiGARxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiGARxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:53:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA843B021;
        Fri,  1 Jul 2022 10:53:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so7152288pjr.0;
        Fri, 01 Jul 2022 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CdjIksMvQ8vjEyyZl126eWwtU5AuyGkL65ydHpG8/4c=;
        b=lVHImcRkqZ6MMxqLfXp/uGCJumuRUfjTFVnw+mcZM88q8I7waVpN0xPs7IBM/RWhcp
         6OsD3zp8+vsD+Yew5VxXtbo9yKaRyoPyya4bfLUMxGpQydc3vDjumIu/Kl4V/IVobPs+
         /AK2G3zFrKLtBXqEor4t1nsAu/S0Au+U+NuBu6Bz2WD0MHIaMGlTBtmFS229D3jIm2MU
         AvfRIoVYXzesCogmd2TgNrr6RkklJ8rusa305mdsNlRQEpVh0yXQvF920ATAw9yrBpFP
         OV7sYQNyGRsjeSjcM162hqVt+Fo9GXmQX1oBa+gkWhNk47TLc/veMIwI6627f4854VEY
         m14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CdjIksMvQ8vjEyyZl126eWwtU5AuyGkL65ydHpG8/4c=;
        b=zxSxIoZI2+l2Jpuj1+s6xhVg2YMYPLTZLiLhrXhROCvO03QxLN7d+GWjFQkvmjk6W7
         LGPztKkxev4cMivcw9o9kJ93jpps/etGR6Ilov9f9Xxs912NxSHZ9rwHMtUdwosXjCA9
         OvM8zxBcBDITtGEfLxZRO9wsEVu02dmbrGCj40rDMasFzTXLcBYEjggGIEW5iSinva0k
         p5F79jSxFPR6+tp3zt73pyAas6cNhoGOFLHQc2xsLX7h1yoDEeIQOv0yZU1rzOOOHzuw
         ZTh5VKrcamRJJy7ym86QgvTGwD3QMu4ZAfcFLmKkx+IxlhGdp9xYrjqTAjMocUxwGpYX
         1qSQ==
X-Gm-Message-State: AJIora/q5RK7lPrFMx/8F975FL3HQT0JCVEMVCx9FB/BQ/qb8jnlxLJ9
        zQ/xgXuoXwMbSb3hBxBLtJI=
X-Google-Smtp-Source: AGRyM1tII1AI4PiDuWJWfp0phkZx9yM+kZzM2zzrG4vkbrQV2zXwG/K8Mn7qF7C/8gvqp66Ej70Kwg==
X-Received: by 2002:a17:903:249:b0:16b:9cf3:596e with SMTP id j9-20020a170903024900b0016b9cf3596emr15861929plh.60.1656697980031;
        Fri, 01 Jul 2022 10:53:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s24-20020a17090aa11800b001eca28b8581sm6985312pjp.7.2022.07.01.10.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 10:52:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8cc11dd5-f599-cdf0-da05-404bb5a6922a@roeck-us.net>
Date:   Fri, 1 Jul 2022 10:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] hwmon: (asus_wmi_sensors) Save a few bytes of memory
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ed Brindley <kernel@maidavale.org>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <3a494f7049f4f9a169477d872bab0c8a7c7ec48c.1656697596.git.christophe.jaillet@wanadoo.fr>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <3a494f7049f4f9a169477d872bab0c8a7c7ec48c.1656697596.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 10:47, Christophe JAILLET wrote:
> The first 'for' loop of asus_wmi_configure_sensor_setup() only computes
> the number and type of sensors that exist in the system.
> 
> Here, the 'temp_sensor' structure is only used to store the data collected
> by asus_wmi_sensor_info(). There is no point in using a devm_ variant for
> this first allocation and it can be freed just after this initial loop.
> 
> So use kzalloc()/kfree() to save a few bytes of memory that would be kept
> allocated for no good reason otherwise.

Then why isn't this just allocated on the stack ? The structure isn't _that_
large.

Guenter

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/hwmon/asus_wmi_sensors.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
> index 9e935e34c998..4873edad4996 100644
> --- a/drivers/hwmon/asus_wmi_sensors.c
> +++ b/drivers/hwmon/asus_wmi_sensors.c
> @@ -514,14 +514,16 @@ static int asus_wmi_configure_sensor_setup(struct device *dev,
>   	int i, idx;
>   	int err;
>   
> -	temp_sensor = devm_kcalloc(dev, 1, sizeof(*temp_sensor), GFP_KERNEL);
> +	temp_sensor = kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
>   	if (!temp_sensor)
>   		return -ENOMEM;
>   
>   	for (i = 0; i < sensor_data->wmi.sensor_count; i++) {
>   		err = asus_wmi_sensor_info(i, temp_sensor);
> -		if (err)
> +		if (err) {
> +			kfree(temp_sensor);
>   			return err;
> +		}
>   
>   		switch (temp_sensor->data_type) {
>   		case TEMPERATURE_C:
> @@ -536,6 +538,7 @@ static int asus_wmi_configure_sensor_setup(struct device *dev,
>   			break;
>   		}
>   	}
> +	kfree(temp_sensor);
>   
>   	if (nr_count[hwmon_temp])
>   		nr_count[hwmon_chip]++, nr_types++;

