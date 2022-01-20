Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5224950DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346221AbiATPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:04:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39128 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346172AbiATPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642691041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XV9vXTR8rHUpOxnAQ5Xc1luOAt9DLySsRNgp0on3KmI=;
        b=b83tdwSP/6o7/dNucUz0f8rwJ1a4r0adVXT0VTiAKR0m0kB/Mm9dfrCZIx2x0o0erDW6Eh
        0Eh/tx64POD4Ef+xXxUOtuAtMoOYUcmm+q9FUfvzvhXjH8NTQPZcDpvJ9zTFCZOl9+5mzB
        mz3jVOTmJfNwGfJ4KXXw47xnZh7hOEQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-z54RCyaCNz-tw2R6LROoTg-1; Thu, 20 Jan 2022 10:04:00 -0500
X-MC-Unique: z54RCyaCNz-tw2R6LROoTg-1
Received: by mail-ed1-f69.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so6119891edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XV9vXTR8rHUpOxnAQ5Xc1luOAt9DLySsRNgp0on3KmI=;
        b=wGxfcOwjivgwOrWRK7FGPI/SIphtxrl6xYVRIyFgJFqKk8rXJExxqgbZw/FKG0zJYR
         kQaVanPqGXjIif3QqfPS2qi2ZW16Ljt9KInXtbFyvaXKOM2ysFYszQV7AuNaBoYhpzfq
         p28I+27qaaKj304neN/XGQNgRc/pRGcFlfBJswU9AO8kDXpA4NKXOZUDqN8G75KYKigG
         IOt1MqRx/ZOYJ180BeBM/wN63QHhHlak9K5tV6IsOyrSaOKMnLZxTJON+5R8puoXB+6l
         N4VNyGhovzlwaK8QJ1UJSaNAeN7HvAlcGpoPGPZFsFvWuy/2I54tDWrmgvxZFdL747LQ
         Krow==
X-Gm-Message-State: AOAM53041VXhonNv+I3nT04g/I5wFpj5gbQWgYDM0GiEYzC6uf3DHdmi
        VSKTlhRN9PQvk960U2gJNWzcNFcZJHfzOeCMem2evTEf0PBE9wWQg9XfPkO5zgNQ7O78nLjSgah
        moSz1N5BQfNgh/BOyEDr+Ihbc
X-Received: by 2002:a05:6402:50c9:: with SMTP id h9mr18098077edb.210.1642691038744;
        Thu, 20 Jan 2022 07:03:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwi/6rqFNxM9rnEHki02qPDGfKXeWhIbd/04xooCgBAG2VkDALdGcq1NOBPUedDbJufuz128Q==
X-Received: by 2002:a05:6402:50c9:: with SMTP id h9mr18098033edb.210.1642691038391;
        Thu, 20 Jan 2022 07:03:58 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id i6sm1127721eja.132.2022.01.20.07.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 07:03:57 -0800 (PST)
Message-ID: <8beb2de0-8b5a-ea58-595d-2fcb38d5ee8b@redhat.com>
Date:   Thu, 20 Jan 2022 16:03:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 3/9] spi: Support selection of the index of the ACPI
 Spi Resource before alloc
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
 <20220120134326.5295-4-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220120134326.5295-4-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 1/20/22 14:43, Stefan Binding wrote:
> If a node contains more than one Spi Resources, it may be necessary to
> use an index to select which one you want to allocate a spi device for.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  drivers/spi/spi.c       | 56 +++++++++++++++++++++++++++++++++++------
>  include/linux/spi/spi.h |  6 +++--
>  2 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 13f4701f0694..898cc9931490 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2320,6 +2320,9 @@ struct acpi_spi_lookup {
>  	int			irq;
>  	u8			bits_per_word;
>  	u8			chip_select;
> +	int			n;
> +	int			index;
> +	int			irq_index;
>  };
>  
>  static void acpi_spi_parse_apple_properties(struct acpi_device *dev,
> @@ -2351,6 +2354,8 @@ static void acpi_spi_parse_apple_properties(struct acpi_device *dev,
>  		lookup->mode |= SPI_CPHA;
>  }
>  
> +static struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev);
> +
>  static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
>  {
>  	struct acpi_spi_lookup *lookup = data;
> @@ -2364,14 +2369,35 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
>  		sb = &ares->data.spi_serial_bus;
>  		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_SPI) {
>  
> +			if (lookup->index != -1 && lookup->n++ != lookup->index)
> +				return 1;
> +
> +			if (lookup->index == -1 && !ctlr)
> +				return -ENODEV;
> +
>  			status = acpi_get_handle(NULL,
>  						 sb->resource_source.string_ptr,
>  						 &parent_handle);
>  
> -			if (ACPI_FAILURE(status) ||
> -			    ACPI_HANDLE(ctlr->dev.parent) != parent_handle)
> +			if (ACPI_FAILURE(status))
>  				return -ENODEV;
>  
> +			if (ctlr) {
> +				if (ACPI_HANDLE(ctlr->dev.parent) != parent_handle)
> +					return -ENODEV;
> +			} else {
> +				struct acpi_device *adev;
> +
> +				if (acpi_bus_get_device(parent_handle, &adev))
> +					return -ENODEV;
> +
> +				ctlr = acpi_spi_find_controller_by_adev(adev);
> +				if (!ctlr)
> +					return -ENODEV;
> +
> +				lookup->ctlr = ctlr;
> +			}
> +
>  			/*
>  			 * ACPI DeviceSelection numbering is handled by the
>  			 * host controller driver in Windows and can vary

All of the above looks good to me.

> @@ -2402,7 +2428,7 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
>  	} else if (lookup->irq < 0) {
>  		struct resource r;
>  
> -		if (acpi_dev_resource_interrupt(ares, 0, &r))
> +		if (acpi_dev_resource_interrupt(ares, lookup->irq_index, &r))
>  			lookup->irq = r.start;
>  	}
>  

I think that this does not do what you want it to do. Quoting drivers/acpi/resource.c:

bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
                                 struct resource *res)
{
        struct acpi_resource_irq *irq;
        struct acpi_resource_extended_irq *ext_irq;

        switch (ares->type) {
        case ACPI_RESOURCE_TYPE_IRQ:
                /*
                 * Per spec, only one interrupt per descriptor is allowed in
                 * _CRS, but some firmware violates this, so parse them all.
                 */
                irq = &ares->data.irq;
                if (index >= irq->interrupt_count) {
                        irqresource_disabled(res, 0);
                        return false;
                }

So now you are actually adding an index into a single:

                    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000008,
                    }

ACPI Resource, which typically (as shown here) only has 1 interrupt, I guess
what you want is the nth resource of type ACPI_RESOURCE_TYPE_IRQ or
ACPI_RESOURCE_TYPE_EXTENDED_IRQ.

So to make this work you should combine this with a separate irq_n
for irq_index, increment that on acpi_dev_resource_interrupt() success
and then only set lookup->irq = r.start; when irq_n == irq_index.

But since the bus-multi-inst code already has its own irq getting code
this is not really necessary, I would just drop the new irq_index field;
and then also drop the "if (spi_dev->irq < 0)" condition for calling
bmi_get_irq() in "[PATCH v4 7/9] platform/x86: bus-multi-instantiate:
Add SPI support"

Note that for the CS35L41 that if is always true already since
that is using a GpioInt resource and acpi_dev_resource_interrupt()
does not support those.

TL;DR: please drop the new irq_index fiels and just leave the
related bits as is.


> @@ -2414,14 +2440,22 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
>   * acpi_spi_device_alloc - Allocate a spi device, and fill it in with ACPI information
>   * @ctlr: controller to which the spi device belongs
>   * @adev: ACPI Device for the spi device
> + * @index: Index of the spi resource inside the ACPI Node
> + * @irq_index: Index of the GPIO resource for the IRQ inside the ACPI Node
>   *
>   * This should be used to allocate a new spi device from and ACPI Node.
>   * The caller is responsible for calling spi_add_device to register the spi device.
>   *
> + * If ctlr is set to NULL, the Controller for the spi device will be looked up
> + * using the resource.
> + * If index is set to -1, index is not used.
> + * Note: If index is -1, ctlr must be set.
> + *
>   * Return: a pointer to the new device, or ERR_PTR on error.
>   */
>  struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
> -					 struct acpi_device *adev)
> +					 struct acpi_device *adev,
> +					 int index, int irq_index)
>  {
>  	acpi_handle parent_handle = NULL;
>  	struct list_head resource_list;
> @@ -2429,8 +2463,14 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>  	struct spi_device *spi;
>  	int ret;
>  
> +	if (!ctlr && index == -1)
> +		return ERR_PTR(-EINVAL);
> +
>  	lookup.ctlr		= ctlr;
>  	lookup.irq		= -1;
> +	lookup.index		= index;
> +	lookup.n		= 0;
> +	lookup.irq_index	= irq_index;
>  
>  	INIT_LIST_HEAD(&resource_list);
>  	ret = acpi_dev_get_resources(adev, &resource_list,
> @@ -2443,7 +2483,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>  
>  	if (!lookup.max_speed_hz &&
>  	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle)) &&
> -	    ACPI_HANDLE(ctlr->dev.parent) == parent_handle) {
> +	    ACPI_HANDLE(lookup.ctlr->dev.parent) == parent_handle) {
>  		/* Apple does not use _CRS but nested devices for SPI slaves */
>  		acpi_spi_parse_apple_properties(adev, &lookup);
>  	}
> @@ -2451,9 +2491,9 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>  	if (!lookup.max_speed_hz)
>  		return ERR_PTR(-ENODEV);
>  
> -	spi = spi_alloc_device(ctlr);
> +	spi = spi_alloc_device(lookup.ctlr);
>  	if (!spi) {
> -		dev_err(&ctlr->dev, "failed to allocate SPI device for %s\n",
> +		dev_err(&lookup.ctlr->dev, "failed to allocate SPI device for %s\n",
>  			dev_name(&adev->dev));
>  		return ERR_PTR(-ENOMEM);
>  	}
> @@ -2478,7 +2518,7 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>  	    acpi_device_enumerated(adev))
>  		return AE_OK;
>  
> -	spi = acpi_spi_device_alloc(ctlr, adev);
> +	spi = acpi_spi_device_alloc(ctlr, adev, -1, 0);
>  	if (IS_ERR(spi)) {
>  		if (PTR_ERR(spi) == -ENOMEM)
>  			return AE_NO_MEMORY;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 200725692b93..1a34fd0f6ca2 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -762,10 +762,12 @@ extern void spi_unregister_controller(struct spi_controller *ctlr);
>  
>  #if IS_ENABLED(CONFIG_ACPI)
>  extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
> -						struct acpi_device *adev);
> +						struct acpi_device *adev,
> +						int index, int irq_index);
>  #else
>  static inline struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
> -						       struct acpi_device *adev);
> +						       struct acpi_device *adev,
> +						       int index, int irq_index);
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
> 


Like with my review of patch 2/9, I don't think we need stubs here.

Regards,

Hans

