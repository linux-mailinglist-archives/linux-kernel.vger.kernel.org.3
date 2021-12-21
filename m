Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66047C2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbhLUPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbhLUPep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:34:45 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B30CC061574;
        Tue, 21 Dec 2021 07:34:45 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso17047056ots.6;
        Tue, 21 Dec 2021 07:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3MV0ltKVU5aGiovL6mP/hE02wLbeXe6GiccWT7VEyLM=;
        b=CygjRde86CXvQdW/9kK6zkk6ia8MJY0Uy+XAczhvIetNN5d+y2Mu1L66EtGC/82E87
         eUXp6JnZIHr6v51hdP6Lq8HI054AAXYkma1buvIFvH2Y04E8YhGs/TxSGt3EuW3PxOUm
         X96pnV2jQ0FKBD0UllB7s/CuYO7nhx1TksGrmRnnvJx3CEZ6HaM/rXkSU8DfUSsDwpFR
         5Kgh6lFxbi8Y1SJ4gBrU1VvI7x/SZBLKNhUPX6h1YsE3EDSEcATUic5OPgaF3Y05kKF5
         a6arYLSLZ00XLt4f42oOrQThdR2wePg5jKS/AyWLQKk538Ml+IIow4TqXUVUsE87E4/h
         7RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3MV0ltKVU5aGiovL6mP/hE02wLbeXe6GiccWT7VEyLM=;
        b=RvZIIVNqO/iIc6VH6TgsN0eWuzQR+wy1PezsYvnv3CoE+Pu0nOnUu6bRWlU3qC5kXR
         xsEEA+XKbWNijEE9zMf3O80votqiCmLBsnWCZaSJAIzCci2c2ReUvzYhqyN+v2nX9Y06
         b2Bu2mhT7Z9pF9rjrbijf61mZzXDrpmd60GvxzQxkj94APpFs1I54NA3nxBLDv6lDvO7
         kknw+WuHOVMd9p0y9FYij8ysHzT/+vy/KRHGx9eZv3RDjciejt8cr6+5K8NBl8Toa18T
         owM5ZBPCFYqBqoGL0wS3hw2ujtv/afPUR547WeivGfCd4ZfnIpnwSMK9cyie9jOQlZnq
         IX4A==
X-Gm-Message-State: AOAM530B1d4Wui38nuzXJKi3bJrcxfAdjcWrrC6KxTcsVvCbSKjELCtc
        gBBJFq+j+0TR1t3HreEbW2KmfMhyoFY=
X-Google-Smtp-Source: ABdhPJxl9DTMybpYm1Ogu0bm4PEwfZNvP96siDes7hTrMy3PHVURoscfqPeplPOYgenMXh1LDNVr5g==
X-Received: by 2002:a9d:6190:: with SMTP id g16mr2605685otk.54.1640100884458;
        Tue, 21 Dec 2021 07:34:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5sm114441oiv.2.2021.12.21.07.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:34:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221123944.2683245-1-demonsingur@gmail.com>
 <20211221123944.2683245-9-demonsingur@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 09/10] hwmon: adt7x10: use
 devm_hwmon_device_register_with_info
Message-ID: <3532ca31-55e9-b000-ec18-910197f13c4f@roeck-us.net>
Date:   Tue, 21 Dec 2021 07:34:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221123944.2683245-9-demonsingur@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 4:39 AM, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> To simplify core driver remove function.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>   drivers/hwmon/adt7x10.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
> index dd4901299590..c03805c72906 100644
> --- a/drivers/hwmon/adt7x10.c
> +++ b/drivers/hwmon/adt7x10.c
> @@ -54,7 +54,6 @@
>   /* Each client has this additional data */
>   struct adt7x10_data {
>   	const struct adt7x10_ops *ops;
> -	struct device		*hwmon_dev;
>   	struct device		*bus_dev;
>   	struct mutex		update_lock;
>   	u8			config;
> @@ -430,8 +429,8 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>   	if (ret)
>   		goto exit_restore;
>   
> -	hdev = hwmon_device_register_with_info(dev, name, data,
> -					       &adt7x10_chip_info, NULL);
> +	hdev = devm_hwmon_device_register_with_info(dev, name, data,
> +						    &adt7x10_chip_info, NULL);
>   
>   	if (IS_ERR(hdev)) {
>   		ret = PTR_ERR(hdev);
> @@ -445,15 +444,11 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>   						IRQF_ONESHOT,
>   						dev_name(dev), hdev);
>   		if (ret)
> -			goto exit_hwmon_device_unregister;
> +			goto exit_restore;
>   	}
>   
> -	data->hwmon_dev = hdev;
> -
>   	return 0;
>   
> -exit_hwmon_device_unregister:
> -	hwmon_device_unregister(hdev);
>   exit_restore:
>   	adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
>   	return ret;
> @@ -464,7 +459,6 @@ void adt7x10_remove(struct device *dev, int irq)
>   {
>   	struct adt7x10_data *data = dev_get_drvdata(dev);
>   
> -	hwmon_device_unregister(data->hwmon_dev);
>   	if (data->oldconfig != data->config)
>   		adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);

This doesn't work as-is because the hwmon device still exists at this point
and at least in theory userspace could still write into the device
after the old configuration was restored.

To fix this, you'll need a preceding patch to introduce adt7x10_restore_config()
or similar, and call it through devm_add_action_or_reset() after updating the
chip configuration. You can then drop the restore code from here and from
the exist_restore code in the probe function.
After that, you can use devm_hwmon_device_register_with_info() and drop the
remove function entirely.

Guenter
