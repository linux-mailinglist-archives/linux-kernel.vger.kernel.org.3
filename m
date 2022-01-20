Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FDA495270
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377046AbiATQee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:34:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346977AbiATQed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642696473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1sc4JZ0+7MrtJWFMrOPG0iw0Wa1Lhn4BX5CbDefiMM=;
        b=i3JsigAM1RinhaHV+8XTxdUNTghWVD5GAD0E0m168M2QO1HkSZBRGDeFO3HAKMy5j8dTgW
        lKOJTlzRoeJqy8EA++Z6lUuSHvibae5Mdw3K+yF9zT+ZBVjXUf+GY3UZl4hu3m93t87LUr
        JHqiu6J8Zit9SfxRxlyTS5oejLaM4F0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-zgH5KjuiNpS98m0VuLozdg-1; Thu, 20 Jan 2022 11:34:31 -0500
X-MC-Unique: zgH5KjuiNpS98m0VuLozdg-1
Received: by mail-ed1-f70.google.com with SMTP id ee53-20020a056402293500b004022f34edcbso6406404edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+1sc4JZ0+7MrtJWFMrOPG0iw0Wa1Lhn4BX5CbDefiMM=;
        b=LOWSijkrLlVB6BryW9ia2Kl4GIwuIeVH0N52cVc4O7xNwSpKPSpl7sOSx4d2yJcf1A
         WxVpdAuj83W7RB8SD2d78pqwKzVd9XVQff9wA75L/A8ehoAyxl2t5k3FLPsFdx3bmqVs
         O/t6Q0RBscvjujhfmmNhN6/ryPs39iZ4g7xJiK06UUgTkMrdJsL6JkoT6TlijNl8VO9s
         zXQjwCDqqzRezYMVZjDsUIi7qbH1z+NbqYe3I0DRqVShD7kBjEQ7sndasYO+reE7MKTR
         x/mrsd/tslFxU8ol74L2Ohj3jrlgh0swq5bzsY1Qhy5sDGXa47C16aJ1jbn1lLcgVviD
         ENAg==
X-Gm-Message-State: AOAM5331gwwgMNc6OxXGRAqQb+eXZfjWHyMocjqLrQyhe6ak7A0Elx/m
        3Ew5vZ03z0n5KvcDC7EaTk6JvknzhPjfdNmTWOy115YbwPEcD7yE3tLb0lXhCsM732EfS4s9r8n
        asBglf8MJsBm2gQHS8xlWRxJ3
X-Received: by 2002:a17:907:6e0b:: with SMTP id sd11mr30574240ejc.132.1642696470217;
        Thu, 20 Jan 2022 08:34:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF9+NmsBb9KPVuUgSXvv1RUm6gGRw3HsBpgMAdYinUYF2Y/bfZO+s9YZARtMUaHR9LPOCCTg==
X-Received: by 2002:a17:907:6e0b:: with SMTP id sd11mr30574226ejc.132.1642696470043;
        Thu, 20 Jan 2022 08:34:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id dt15sm1157616ejb.190.2022.01.20.08.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 08:34:29 -0800 (PST)
Message-ID: <d6958153-7747-bc4b-2de0-57aa3226d984@redhat.com>
Date:   Thu, 20 Jan 2022 17:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 0/9] Support Spi in i2c-multi-instantiate driver
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220120134326.5295-1-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 1/20/22 14:43, Stefan Binding wrote:
> Add support for SPI bus in the i2c-multi-instantiate driver as
> upcoming laptops will need to multi instantiate SPI devices from
> a single device node, which has multiple SpiSerialBus entries at
> the ACPI table.
> 
> With the new SPI support, i2c-multi-instantiate becomes
> bus-multi-instantiate and is moved to the ACPI folder.
> 
> The intention is to support the SPI bus by re-using the current
> I2C multi instantiate, instead of creating a new SPI multi
> instantiate, to make it possible for peripherals that can be
> controlled by I2C or SPI to have the same HID at the ACPI table.
> 
> The new driver (Bus multi instantiate, bmi) checks for the
> hard-coded bus type and returns -ENODEV in case of zero devices
> found for that bus. In the case of automatic bus detection, 
> the driver will give preference to I2C.
> 
> The expectation is for a device node in the ACPI table to have
> multiple I2cSerialBus only or multiple SpiSerialBus only, not
> a mix of both; and for the case where there are both entries in
> one device node, only the I2C ones would be probed.
> 
> This new bus multi instantiate will be used in CS35L41 HDA new
> driver.

Mark, since most of my review remarks are small(ish) I expect
the next version of this (except patch 8/9) to be ready for
merging.

I can either merge all patches on top of 5.17-rc1 once released;
and provide an immutable-branch for you to merge for the SPI
bits; or you can merge patches 1-4 (the SPI patches) and then
send me a pull-req for an immutable-branch with those 4,
so that I can merge that and then the rest on top.

Mark, please let me know how you want to proceed with merging this.

Regards,

Hans




> 
> Changes since V2:
>  - Moved bus-multi-instantiate back into platform/x86
> 
> Lucas Tanure (4):
>   platform/x86: i2c-multi-instantiate: Rename it for a generic bus
>     driver name
>   platform/x86: bus-multi-instantiate: Reorganize I2C functions
>   ALSA: hda/realtek: Add support for HP Laptops
>   ACPI / scan: Create platform device for CS35L41
> 
> Stefan Binding (5):
>   spi: Make spi_alloc_device and spi_add_device public again
>   spi: Create helper API to lookup ACPI info for spi device
>   spi: Support selection of the index of the ACPI Spi Resource before
>     alloc
>   spi: Add API to count spi acpi resources
>   platform/x86: bus-multi-instantiate: Add SPI support
> 
>  MAINTAINERS                                  |   4 +-
>  drivers/acpi/scan.c                          |  16 +-
>  drivers/platform/x86/Kconfig                 |  14 +-
>  drivers/platform/x86/Makefile                |   2 +-
>  drivers/platform/x86/bus-multi-instantiate.c | 369 +++++++++++++++++++
>  drivers/platform/x86/i2c-multi-instantiate.c | 174 ---------
>  drivers/spi/spi.c                            | 142 ++++++-
>  include/linux/spi/spi.h                      |  32 ++
>  sound/pci/hda/patch_realtek.c                |  43 ++-
>  9 files changed, 588 insertions(+), 208 deletions(-)
>  create mode 100644 drivers/platform/x86/bus-multi-instantiate.c
>  delete mode 100644 drivers/platform/x86/i2c-multi-instantiate.c
> 

