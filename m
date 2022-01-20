Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3249506D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbiATOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:40:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357193AbiATOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642689584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6QJQxwpqs/8UeUwXAKCD+lQ9KYdKmTM83V8hAlwFAc=;
        b=emCV/fq3F3C+2/mKLG9Jy4XSGBwXSRDfDCZP3kocVVMaF9ahCpvcV/A9WEeBIfy/+BCYdH
        deAika20N06VhSVXGBjPmWyT9dCscHFkgI8hGIUzjPj420CnEoO4G01L1C3AYUFuuwO/Io
        y8R1jG8870EM5Ta84mxwK+iQkci17R0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-2F4pAoZyPbi6k-uNnrkqrA-1; Thu, 20 Jan 2022 09:39:42 -0500
X-MC-Unique: 2F4pAoZyPbi6k-uNnrkqrA-1
Received: by mail-ed1-f72.google.com with SMTP id j10-20020a05640211ca00b003ff0e234fdfso6142311edw.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U6QJQxwpqs/8UeUwXAKCD+lQ9KYdKmTM83V8hAlwFAc=;
        b=fd5tIlmC20C4XPxAAP25MKxqp/9JySSFWwogPmx9Kcbr0WNyGtGUU5QdHuSLdGW6iz
         Y/RKIx3jvoZC5rcj+jBNW/yge+Fz76vvTyNaHoMcraGZtTlKCq0ypZXsV1Kr3pjwO6Ar
         whNQ9z/+bc+LDt1XKCUoQZ1gP45AuyblZhGTtFLXZbfkpxEhGaPyO+8PWuFKu8OHIIRZ
         gYLuTyz/1jAc4g3tAr2yEkUNiNruPwypt/YQs7avHyBxtiAaro5vz0xAztOeVxHRqOL5
         a/N0ByWTCMj2bOJ+XVK1emKm3s9vq4gPmC2QsxloS0GFIhd2ggX6e+SOEOBH9/YI7uoQ
         fEPg==
X-Gm-Message-State: AOAM531P+rbUTc9DWywhph8j7Ip8Umbj9NAHTKk/efrKN0mJ3sZ2V7WA
        8JY5hHp5tg8UvRLYUjJPmxsaSd+fPwV4PvHg6atk6TjuI5bSA5LOHqkeA6KR6zUxnVDfUsn93LX
        FPD/5N73ml3cJaGz7IxQissy3
X-Received: by 2002:a05:6402:2d4:: with SMTP id b20mr8449555edx.98.1642689581193;
        Thu, 20 Jan 2022 06:39:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7QsHN5sY6fK7Vbj+K5/OavxogCBIliNExc9shQzj9qCMxf2il3s8jvjaw8aZ+7DIdD8rq1w==
X-Received: by 2002:a05:6402:2d4:: with SMTP id b20mr8449533edx.98.1642689581020;
        Thu, 20 Jan 2022 06:39:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id cr8sm1386979edb.47.2022.01.20.06.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 06:39:40 -0800 (PST)
Message-ID: <1ff8954c-9894-b0cd-a261-afc30ff02e6b@redhat.com>
Date:   Thu, 20 Jan 2022 15:39:39 +0100
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

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


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
> 

