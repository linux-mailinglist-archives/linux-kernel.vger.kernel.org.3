Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB34950EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376407AbiATPEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376401AbiATPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642691073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=To2wpxuY27WAnz4SIl/hJ0+xCm0ywOKL7oN+T9JQDqU=;
        b=gPU8mNrovp/OB9nT+qQdrYDv4LQ4TFUejlaeojg2oBqwH6PDLs1rrUVC4Rf7OP4pU8uhh/
        Ypli+unm0XKL6NpA1DpyOuCPP/pBO7o/Uvru/0dfhOrEZIg9tO5lDrSSC5Yd6hGO7kav4G
        Vvxl+k7szARWJhuGHYRNq2itbwUD6A4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-n5LrcJB1OX-hBMr6-AxjPA-1; Thu, 20 Jan 2022 10:04:31 -0500
X-MC-Unique: n5LrcJB1OX-hBMr6-AxjPA-1
Received: by mail-ed1-f70.google.com with SMTP id i22-20020a50fd16000000b00405039f2c59so2091757eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=To2wpxuY27WAnz4SIl/hJ0+xCm0ywOKL7oN+T9JQDqU=;
        b=UbiWjX7+4aXV2WwrT753N6jcY/tdNg7EaRuUUfiShEu+SlMOvfY9FC2KmT5VChE4OW
         s108pOgr16ybg+nuzuw6HZ4c3AsYnVA+RJoaP3O4lU6OJlzjd48NvqFFYcgEO+vCdeVt
         8b6HGc5x7mxQDdNU1iKpVIERrCAg9MicRmt8vpRt6mq8LGy8eMmmxsW9mUYEXI5lY1Pa
         ZLILWg/fmspN9gabFvbQKQmWtrr24bVtCoXk6EaN6Kl28OnfZK7Yu1MwPy4P8pDy8dVk
         8Rh35zKclCL5ba+z/UV56Y48/iP2c648IxGg+NtLkQfg2ADKU7ZWPrR6AINg+irNDbuW
         WYug==
X-Gm-Message-State: AOAM531paiERyxCXACTI28v4lwGhpyQd70pPwexFyUZjalh4gpGRRJ03
        b+sNN33JRynWbVicvYQ6qqE96P5mNvxepwHAHMgB4MKGZ06Dw57VOpHN/hvhE+4ShfkmSVdt4Go
        RDqUs3spJiwK3H3wPVTVDXaZA
X-Received: by 2002:a17:907:6da4:: with SMTP id sb36mr28535597ejc.542.1642691070468;
        Thu, 20 Jan 2022 07:04:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyghiAn88f/FuP8ckekTfjsMklMLqYCh+mLdlTm7Wp0lVLOMWfL9/cqIYmnkwrbVIhfgzxPWA==
X-Received: by 2002:a17:907:6da4:: with SMTP id sb36mr28535566ejc.542.1642691070203;
        Thu, 20 Jan 2022 07:04:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id gh14sm1090985ejb.38.2022.01.20.07.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 07:04:29 -0800 (PST)
Message-ID: <78979080-1338-002c-ee16-5213415095da@redhat.com>
Date:   Thu, 20 Jan 2022 16:04:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 4/9] spi: Add API to count spi acpi resources
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
 <20220120134326.5295-5-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220120134326.5295-5-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/22 14:43, Stefan Binding wrote:
> Some ACPI nodes may have more than one Spi Resource.
> To be able to handle these case, its necessary to have
> a way of counting these resources.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  drivers/spi/spi.c       | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi.h |  6 ++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 898cc9931490..8c0c2e26609a 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2325,6 +2325,46 @@ struct acpi_spi_lookup {
>  	int			irq_index;
>  };
>  
> +static int acpi_spi_count(struct acpi_resource *ares, void *data)
> +{
> +	struct acpi_resource_spi_serialbus *sb;
> +	int *count = data;
> +
> +	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return 1;
> +
> +	sb = &ares->data.spi_serial_bus;
> +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_SPI)
> +		return 1;
> +
> +	*count = *count + 1;
> +
> +	return 1;
> +}
> +
> +/**
> + * acpi_spi_count_resources - Count the number of SpiSerialBus resources
> + * @adev:	ACPI device
> + *
> + * Returns the number of SpiSerialBus resources in the ACPI-device's
> + * resource-list; or a negative error code.
> + */
> +int acpi_spi_count_resources(struct acpi_device *adev)
> +{
> +	LIST_HEAD(r);
> +	int count = 0;
> +	int ret;
> +
> +	ret = acpi_dev_get_resources(adev, &r, acpi_spi_count, &count);
> +	if (ret < 0)
> +		return ret;
> +
> +	acpi_dev_free_resource_list(&r);
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(acpi_spi_count_resources);
> +
>  static void acpi_spi_parse_apple_properties(struct acpi_device *dev,
>  					    struct acpi_spi_lookup *lookup)
>  {
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 1a34fd0f6ca2..25a82729f8da 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -764,6 +764,7 @@ extern void spi_unregister_controller(struct spi_controller *ctlr);
>  extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>  						struct acpi_device *adev,
>  						int index, int irq_index);
> +int acpi_spi_count_resources(struct acpi_device *adev);
>  #else
>  static inline struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>  						       struct acpi_device *adev,
> @@ -771,6 +772,11 @@ static inline struct spi_device *acpi_spi_device_alloc(struct spi_controller *ct
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
> +
> +int acpi_spi_count_resources(struct acpi_device *adev)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  
>  /*

I just realized I miss this bit, like with my review of patch 2/9,
I don't think we need stubs here.

Regards,

Hans


