Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC547C294
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbhLUPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhLUPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:16:07 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FE4C061574;
        Tue, 21 Dec 2021 07:16:07 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso17086961otf.0;
        Tue, 21 Dec 2021 07:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vyF+JeZ30dIBu6bkviCSvWSze3WVHb6wEuVOhMhsAp0=;
        b=J6P0sdUW8YEE05uxC7RPYW3oNTmC8qCnoDUrONUqIjAsPSNN1z6JEbXK4jDVP4ql/G
         ha7Sgvr58qYxD7lvc8+mIo1+p6CXF0YrI//RW2jiSLSDxbfMSoCH+wFa4+g0IuTu75RV
         IUFGuEOG1yRs4J/kDfgQ7cqehCideoWPTkyZgLVivCDpI3NkDVAZfXiJuvjg7CyrhBRA
         9AIZv6JsZQkgsWn26jAI4sl2Ehu7H0v3DcjR6WGfjjgQuIQniKuBS3IIARmYuC7/QtsS
         UjMO2F1i3yclHAXA527N2v9goIzOk93iutmaQEFN3FrFeKvurVPE9hJyjsQAiSylL/fD
         VTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vyF+JeZ30dIBu6bkviCSvWSze3WVHb6wEuVOhMhsAp0=;
        b=pE/drWFATSq5LHAXv3ZMaw3Zi5S3BsBt4+ChKGxB79wS7rKAu9UoAibdl106T/uTS3
         5zG01MRubWueIQUU+IP+IjCCLGLo1DXZemd8Eu66OCv7YMzE/qRO9r6Ezk8E3K4q4QKe
         ea8y4OBl/3zNXZi3fPV+BU3NSS0IcoOUNu/mGI3LT3N/N4/40j2GWEYWgTpfjIzXIHzR
         D9K2c7Y4/HMNcus+6eQL/NMVH7dNHsS/GECuAn2w3xRkUKr+x+iI39m8jGoBCJnPZPKr
         eb5ZPrwWRvd5PJttmmZEJf7rtveNU3r8veIHewrMtBa9N8CpI49Dw8++Ea/AIaBDV6U+
         armQ==
X-Gm-Message-State: AOAM532f1HRMtidgptKfuf6ddFg3y60BHXZu7BLLd9I66EgGJiiuxTJL
        EpX0vLAkHKyT1CQDd5SKsOcE8sFfB1E=
X-Google-Smtp-Source: ABdhPJx4+qv5A3zLwg1MSnv5ejVvQM8Z5B//ylszIJdhXhoetM8T3xgzO63tK+sjVF9QeI4nO23q4Q==
X-Received: by 2002:a05:6830:1445:: with SMTP id w5mr2588589otp.112.1640099765765;
        Tue, 21 Dec 2021 07:16:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12sm3576489oom.44.2021.12.21.07.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:16:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1 04/10] hwmon: adt7x10: avoid storing hwinfo dev into
 private data
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221123944.2683245-1-demonsingur@gmail.com>
 <20211221123944.2683245-4-demonsingur@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <78b1a162-21fe-eeff-d915-c219729381bd@roeck-us.net>
Date:   Tue, 21 Dec 2021 07:16:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221123944.2683245-4-demonsingur@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 4:39 AM, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Store it later in the code to reduce the number of references
> to the private data structure, so it is easier to remove it
> altogether.
> 

This patch pretty pointless as it is only used in the remove function,
and that won't need it after the devm_ registration function is used.

Guenter

> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>   drivers/hwmon/adt7x10.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
> index 48adc0344e88..25c1ab199658 100644
> --- a/drivers/hwmon/adt7x10.c
> +++ b/drivers/hwmon/adt7x10.c
> @@ -351,6 +351,7 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>   		  const struct adt7x10_ops *ops)
>   {
>   	struct adt7x10_data *data;
> +	struct device *hdev;
>   	int ret;
>   
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> @@ -395,9 +396,9 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>   	if (ret)
>   		goto exit_restore;
>   
> -	data->hwmon_dev = hwmon_device_register(dev);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		ret = PTR_ERR(data->hwmon_dev);
> +	hdev = hwmon_device_register(dev);
> +	if (IS_ERR(hdev)) {
> +		ret = PTR_ERR(hdev);
>   		goto exit_remove;
>   	}
>   
> @@ -411,10 +412,12 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>   			goto exit_hwmon_device_unregister;
>   	}
>   
> +	data->hwmon_dev = hdev;
> +
>   	return 0;
>   
>   exit_hwmon_device_unregister:
> -	hwmon_device_unregister(data->hwmon_dev);
> +	hwmon_device_unregister(hdev);
>   exit_remove:
>   	sysfs_remove_group(&dev->kobj, &adt7x10_group);
>   exit_restore:
> 

