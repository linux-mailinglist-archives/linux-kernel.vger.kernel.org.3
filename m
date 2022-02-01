Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19DB4A5EC2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiBAO74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235655AbiBAO7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643727590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/45N/ol0SfVTFBtZrqlh6Sd2OhPFyzzao/S5wI8eYY=;
        b=fxThz9Jkzp1Sf00v2XWP2Mw337itZ6P9Xa+7RfG7tsACW0hV+Q/7Qaqatb/L1stJ19Djgz
        5bDRV9neb7leleCdMse9fabeTRwRmUFiYHE9vn7XC5jVsYSdJMjdekht0KcVBxhfAjFM+c
        hSahVky4h0o5ZbRjfLTxflIHlF86XNc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-t2f5DjiGPEqkXM-iUJFmGw-1; Tue, 01 Feb 2022 09:59:48 -0500
X-MC-Unique: t2f5DjiGPEqkXM-iUJFmGw-1
Received: by mail-ed1-f71.google.com with SMTP id w23-20020a50d797000000b00406d33c039dso8809859edi.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 06:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G/45N/ol0SfVTFBtZrqlh6Sd2OhPFyzzao/S5wI8eYY=;
        b=qxDKRpsm5k2dEYlRXmB/RFnJLDug8Vc8YU+7dE4qqMVemiNL+olMpZHwqfl/xJU8A9
         m51EuKAZEvNjvzaYx1FQRtFq1l98iKvqnOGov0ivuOXyDw3qj63sz9krll/0Qjz6llRz
         6bUSmysk6LJpFVfWCk5QLI2db7p6X0SNB+jPgqTClcuZ4nZUPiDzJpN7OMtDe28S7z0C
         fBEn6LH0iIySjFybPQyP7PdGxwYIH4yeCwJ75GEtd0qYR3nCf0EwcdYxO4BPoVzIgGuG
         gxYLrHePlEV93MUeDayr0Q8Hus4HqEN8cRD47QZFseALEtpBL4SacKz8hWd24zVQuNa6
         dhqQ==
X-Gm-Message-State: AOAM532cvoKHiuuPrpuixmFRC/mAIei6gf9tHjGsUMr1naZz0Uv22YIP
        4Rs/0+GELO631FWIe+zI+gF6fUSRlcbvmfctXtpuNgqbDsJ15O364XRPfP5WemVAHhyaQ4bdnvB
        rGkSUp72gGazpYdvw8kVN1cSb
X-Received: by 2002:a17:907:1c11:: with SMTP id nc17mr21027555ejc.675.1643727587057;
        Tue, 01 Feb 2022 06:59:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxm11kS1FcBeLRVEsc+gmmUlWUzejRWatUNvRgVSBtvcZQpTIe5DWfgcTcz52n45x7ocsEtQg==
X-Received: by 2002:a17:907:1c11:: with SMTP id nc17mr21027521ejc.675.1643727586784;
        Tue, 01 Feb 2022 06:59:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id bl12sm14644326ejb.75.2022.02.01.06.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:59:45 -0800 (PST)
Message-ID: <49b524f7-d714-606d-725e-ca69b3714e45@redhat.com>
Date:   Tue, 1 Feb 2022 15:59:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 6/9] platform/x86: serial-multi-instantiate: Reorganize
 I2C functions
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
 <20220121172431.6876-7-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220121172431.6876-7-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/21/22 18:24, Stefan Binding wrote:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> Reorganize I2C functions to accommodate SPI support
> Split the probe and factor out parts of the code
> that will be used in the SPI support
> Also switched from strlcpy() to strscpy()
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  .../platform/x86/serial-multi-instantiate.c   | 144 +++++++++++-------
>  1 file changed, 90 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index 33cbb0caed33..4cd6d72a0741 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -29,96 +29,132 @@ struct smi_instance {
>  
>  struct smi {
>  	int i2c_num;
> -	struct i2c_client *i2c_devs[];
> +	struct i2c_client **i2c_devs;
>  };
>  
> -static int smi_probe(struct platform_device *pdev)
> +static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
> +		       const struct smi_instance *inst)
> +{
> +	int ret;
> +
> +	switch (inst->flags & IRQ_RESOURCE_TYPE) {
> +	case IRQ_RESOURCE_GPIO:
> +		ret = acpi_dev_gpio_irq_get(adev, inst->irq_idx);
> +		break;
> +	case IRQ_RESOURCE_APIC:
> +		ret = platform_get_irq(pdev, inst->irq_idx);
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (ret < 0)
> +		dev_err_probe(&pdev->dev, ret, "Error requesting irq at index %d: %d\n",
> +			      inst->irq_idx, ret);
> +
> +	return ret;
> +}
> +
> +static void smi_devs_unregister(struct smi *smi)
> +{
> +	while (smi->i2c_num > 0)
> +		i2c_unregister_device(smi->i2c_devs[--smi->i2c_num]);
> +}
> +
> +/**
> + * smi_i2c_probe - Instantiate multiple I2C devices from inst array
> + * @pdev:	Platform device
> + * @adev:	ACPI device
> + * @smi:	Internal struct for Serial multi instantiate driver
> + * @inst_array:	Array of instances to probe
> + *
> + * Returns the number of I2C devices instantiate, Zero if none is found or a negative error code.
> + */
> +static int smi_i2c_probe(struct platform_device *pdev, struct acpi_device *adev, struct smi *smi,
> +			 const struct smi_instance *inst_array)
>  {
>  	struct i2c_board_info board_info = {};
> -	const struct smi_instance *inst;
>  	struct device *dev = &pdev->dev;
> -	struct acpi_device *adev;
> -	struct smi *smi;
>  	char name[32];
> -	int i, ret;
> +	int i, ret, count;
>  
> -	inst = device_get_match_data(dev);
> -	if (!inst) {
> -		dev_err(dev, "Error ACPI match data is missing\n");
> -		return -ENODEV;
> -	}
> -
> -	adev = ACPI_COMPANION(dev);
> -
> -	/* Count number of clients to instantiate */
>  	ret = i2c_acpi_client_count(adev);
>  	if (ret < 0)
>  		return ret;
> +	else if (!ret)
> +		return -ENODEV;
>  
> -	smi = devm_kmalloc(dev, struct_size(smi, i2c_devs, ret), GFP_KERNEL);
> -	if (!smi)
> -		return -ENOMEM;
> +	count = ret;
>  
> -	smi->i2c_num = ret;
> +	smi->i2c_devs = devm_kcalloc(dev, count, sizeof(*smi->i2c_devs), GFP_KERNEL);
> +	if (!smi->i2c_devs)
> +		return -ENOMEM;
>  
> -	for (i = 0; i < smi->i2c_num && inst[i].type; i++) {
> +	for (i = 0; i < count && inst_array[i].type; i++) {
>  		memset(&board_info, 0, sizeof(board_info));
> -		strlcpy(board_info.type, inst[i].type, I2C_NAME_SIZE);
> -		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst[i].type, i);
> +		strscpy(board_info.type, inst_array[i].type, I2C_NAME_SIZE);
> +		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst_array[i].type, i);
>  		board_info.dev_name = name;
> -		switch (inst[i].flags & IRQ_RESOURCE_TYPE) {
> -		case IRQ_RESOURCE_GPIO:
> -			ret = acpi_dev_gpio_irq_get(adev, inst[i].irq_idx);
> -			if (ret < 0) {
> -				dev_err(dev, "Error requesting irq at index %d: %d\n",
> -						inst[i].irq_idx, ret);
> -				goto error;
> -			}
> -			board_info.irq = ret;
> -			break;
> -		case IRQ_RESOURCE_APIC:
> -			ret = platform_get_irq(pdev, inst[i].irq_idx);
> -			if (ret < 0) {
> -				dev_dbg(dev, "Error requesting irq at index %d: %d\n",
> -					inst[i].irq_idx, ret);
> -				goto error;
> -			}
> -			board_info.irq = ret;
> -			break;
> -		default:
> -			board_info.irq = 0;
> -			break;
> -		}
> +
> +		ret = smi_get_irq(pdev, adev, &inst_array[i]);
> +		if (ret < 0)
> +			goto error;
> +		board_info.irq = ret;
> +
>  		smi->i2c_devs[i] = i2c_acpi_new_device(dev, i, &board_info);
>  		if (IS_ERR(smi->i2c_devs[i])) {
>  			ret = dev_err_probe(dev, PTR_ERR(smi->i2c_devs[i]),
>  					    "Error creating i2c-client, idx %d\n", i);
>  			goto error;
>  		}
> +		smi->i2c_num++;
>  	}
> -	if (i < smi->i2c_num) {
> -		dev_err(dev, "Error finding driver, idx %d\n", i);
> +	if (smi->i2c_num < count) {
> +		dev_dbg(dev, "Error finding driver, idx %d\n", i);
>  		ret = -ENODEV;
>  		goto error;
>  	}
>  
> -	platform_set_drvdata(pdev, smi);
> -	return 0;
> +	dev_info(dev, "Instantiated %d I2C devices.\n", smi->i2c_num);
>  
> +	return 0;
>  error:
> -	while (--i >= 0)
> -		i2c_unregister_device(smi->i2c_devs[i]);
> +	smi_devs_unregister(smi);
>  
>  	return ret;
>  }
>  
> +static int smi_probe(struct platform_device *pdev)
> +{
> +	const struct smi_instance *inst_array;
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev;
> +	struct smi *smi;
> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev)
> +		return -ENODEV;
> +
> +	inst_array = device_get_match_data(dev);
> +	if (!inst_array) {
> +		dev_dbg(dev, "Error ACPI match data is missing\n");
> +		return -ENODEV;
> +	}
> +
> +	smi = devm_kzalloc(dev, sizeof(*smi), GFP_KERNEL);
> +	if (!smi)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, smi);
> +
> +	return smi_i2c_probe(pdev, adev, smi, inst_array);
> +}
> +
>  static int smi_remove(struct platform_device *pdev)
>  {
>  	struct smi *smi = platform_get_drvdata(pdev);
> -	int i;
>  
> -	for (i = 0; i < smi->i2c_num; i++)
> -		i2c_unregister_device(smi->i2c_devs[i]);
> +	smi_devs_unregister(smi);
>  
>  	return 0;
>  }
> 

