Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224264A5E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiBAOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232042AbiBAOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643726535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjzDEqkfJ2N8210XIx7ybjZjd9nnlt1goBZyP/z8PRo=;
        b=M9kfGpytJMsEyi2WstNS0uy+0n5ay7kLPLOHkC5zvPtt8jRpKmbLzavibsuA/Si6S1NndE
        qxHeq+m3P9TSxU4lu9ZWpWH9CM3O+b2FWSyHNqs5K9fyfQ1LLvtqbqjrtveSFqynOFQtUA
        QOzGTlTpzUXUO+it1QOH/NlO9ys57+o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-mKe3hDwaOh-ie9wmstWT-w-1; Tue, 01 Feb 2022 09:42:11 -0500
X-MC-Unique: mKe3hDwaOh-ie9wmstWT-w-1
Received: by mail-ej1-f72.google.com with SMTP id o4-20020a170906768400b006a981625756so6683563ejm.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 06:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NjzDEqkfJ2N8210XIx7ybjZjd9nnlt1goBZyP/z8PRo=;
        b=LkPxVtzHGGW6hRqfVnAS69cmMXnD0qjR2NkVnXMEKW4+pc1uwaFuYgnY1TWct82Dny
         J0Kn3SiL0oYIzb3ChDsjiOa85GqJisSjuPc97TTjFWhXwt4k3a0dte4PCsWBF7NygEE4
         nTD2aISqt2oBfn/cqB4UjJIgHKUZA24mXoISj+3L9h2YnqgWDvTjh86hT2kdlZABhBIb
         M1Gu4FS3BqcQYs/AjYG146F8Q40cJn3Z1+LkCdDAyNqEZpk1bbVXt8FEBAYI3jsDVyMt
         CdHHdgFWiHc/2cfOMo3k5KOrKUwKYahs9ZAdd1T4P8XCUQ/3q3wKL8Qa7sRxp/okmBP3
         m/yg==
X-Gm-Message-State: AOAM532DBPcAvanF1SFLbN7CaROlK4w4UdBVoRwanVPvDQfv2R4uiZX2
        tcS+kSG6qfA2LfR1nc31gRhufw3hBGB8ED1aaWORFoliQ5pErnthABYX+cfdEzkZShilAhR+bZ/
        A+2BnWdqgG54j8CsiU1yk9iMi
X-Received: by 2002:a17:906:974c:: with SMTP id o12mr12816424ejy.340.1643726530727;
        Tue, 01 Feb 2022 06:42:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNDyANDY0zMYuTljWq11CTgp0bQzqb3WikdoyniZiPHEGU+6ua6ezX3gvJIdSHcNSeP5gfIQ==
X-Received: by 2002:a17:906:974c:: with SMTP id o12mr12816408ejy.340.1643726530531;
        Tue, 01 Feb 2022 06:42:10 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id h16sm3616306ejj.56.2022.02.01.06.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:42:09 -0800 (PST)
Message-ID: <8cc4190e-f6ec-dc23-c487-4f0c4c7126e8@redhat.com>
Date:   Tue, 1 Feb 2022 15:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 4/9] spi: Add API to count spi acpi resources
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
 <20220121172431.6876-5-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220121172431.6876-5-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/21/22 18:24, Stefan Binding wrote:
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
>  include/linux/spi/spi.h |  1 +
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 06c0a308b38b..ec9f2ed579e3 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2324,6 +2324,46 @@ struct acpi_spi_lookup {
>  	int			index;
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
> index e5bbb9cbd3d7..394b4241d989 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -764,6 +764,7 @@ extern void spi_unregister_controller(struct spi_controller *ctlr);
>  extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>  						struct acpi_device *adev,
>  						int index);
> +int acpi_spi_count_resources(struct acpi_device *adev);
>  #endif
>  
>  /*
> 

