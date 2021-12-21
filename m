Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD8B47C861
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhLUUrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhLUUrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:47:20 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD38C061574;
        Tue, 21 Dec 2021 12:47:20 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so18106968oto.13;
        Tue, 21 Dec 2021 12:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cvOxguznUbHexkyxaKFJR7WlpPIGqcRKsIAcNubdzxg=;
        b=qsnh65m4RmON7ca0eSK+zmg2zTgGQKUyZ8NynD3xBPdC2KRcB8gjUkAurj4hE3VPtA
         pSru+Ru4ai62/7YJVeCkDR448wO/WWxwf4bQj2pWRFHXFGmCM4t+vtdaxpeAHI9bVGWs
         1X6XT+fm4iewIA0AX4UI4VhEvqua4J+MZIcHT2CPQ93A2qsyXLYf09GVqQWiM+IvjiCL
         mFqZscnnKAwW7zT9dCLKDjJgHSx0c/l/5BHVp99EW5CsjBE0G0Fbv82ThspEkvRWhk7o
         FLvQ3/tGDsOrIAdl9Z9U81lpTnzKUohO79C3/CJVaHOBq5U8Yqxn7GNv7gJRqmPcCQVm
         fSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cvOxguznUbHexkyxaKFJR7WlpPIGqcRKsIAcNubdzxg=;
        b=IRTLc6ZRd0/LNdwLz0SsMysF3kgwt1XI3xynw/YvaWhF7e04XJgHyMccft+Vi+GJXH
         8t03nTmklC8ncFEOExU7gd2uYWxEUPUX+snqEheU8Kbgnff54XNhVTzpBltTY0eOS/Jg
         p9tJ9MOHAvHWalX1Dm+eFVVKIbr5lt4IPEcLg41i3D5ER121p5pIn+khxVNubXulvb29
         sN3fYZz3s370T4w4MImu7tgsAYKahIIF6y3rehyOHOVoIVwCVEUfj6yepu9TQaOIqvRi
         rVsJRyXaJ+cpoi54oa3vn3qIsmtMj68xt1J+qgmD+FupFzrdbRHSyGwGlG97COtsRiT4
         KWRA==
X-Gm-Message-State: AOAM5308KBCJzHrMwACpsjrMgb+pqjsQDEp7LIAf/hkm2JEg+RhVvvz2
        txxgh/KG20vuTRXCKwf+PnoMPzTZWWs=
X-Google-Smtp-Source: ABdhPJywBzhOeIKY1vMLUn4LJmbaYOHYRHRV000GypvDuo4/W8m4rz65WZvpFAJlpy5LPXtP1gskRg==
X-Received: by 2002:a9d:63d8:: with SMTP id e24mr56748otl.345.1640119639264;
        Tue, 21 Dec 2021 12:47:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 66sm90665otu.55.2021.12.21.12.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 12:47:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 1/8] hwmon: (adt7410) Pass name to core driver
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221201113.752827-1-demonsingur@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c5effd54-df4d-c7aa-47a2-f7fdcee5354a@roeck-us.net>
Date:   Tue, 21 Dec 2021 12:47:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221201113.752827-1-demonsingur@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 12:11 PM, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> It will later be used to register hwmon device using
> hwmon_device_register_with_info.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>   drivers/hwmon/adt7410.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index 973db057427b..ef4b5af865e9 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -45,7 +45,7 @@ static int adt7410_i2c_probe(struct i2c_client *client)
>   			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
>   		return -ENODEV;
>   
> -	return adt7x10_probe(&client->dev, NULL, client->irq, &adt7410_i2c_ops);
> +	return adt7x10_probe(&client->dev, client->name, client->irq, &adt7410_i2c_ops);
>   }
>   
>   static int adt7410_i2c_remove(struct i2c_client *client)
> 

This series looks very similar to the previous series, yet there is
no change log, and it again claims to be v1 of a patch series. Either
explain why this series is so different to the similar looking patch
series starting with "hwmon: adt7x10: store bus_dev in private data",
that it doesn't deserve to be called v2, or provide change logs and
version your series.

If you expect me to figure out what changed, sorry, that is not how
it works. I won't even look at this series.

Guenter
