Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21A747C62C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbhLUSQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241118AbhLUSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640110593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZeVhFboZslEu9Zvr6cMkBDRbTmY4fOX3foXx2jkBng=;
        b=gzsCeKfSCiZmY09+yVGsd/+YdFzyXkfcJ39Sb64fBGj/R/ob4rXchk30ZReTkPbxFN90UI
        nbezQ9n9l9cMyb/TKlhLEV9V3EJ9xhR4XfbZOBCxsweZ2D9RidLvIjNvxdR/4n3F9iTmPr
        TdwJzCBCNC4wf2p7fEjYUV1um5dTftE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-Pyjx2veEO3q4JRTJqLyFhg-1; Tue, 21 Dec 2021 13:16:32 -0500
X-MC-Unique: Pyjx2veEO3q4JRTJqLyFhg-1
Received: by mail-ed1-f70.google.com with SMTP id l11-20020a056402254b00b003f6a9bd7e81so10982338edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oZeVhFboZslEu9Zvr6cMkBDRbTmY4fOX3foXx2jkBng=;
        b=0Lw5I/70U9YUaQt6KO8e2xcOjmyDFzKPoh1ramPA0fMDESVzLxeyAns5MAOUSJNdZp
         xs0sS+3zx/MJU2DOIZGQDk23RjfbTK78IdK6wbAlxm1in2sylqwV2eQFi5jqUIr5k96f
         HFvTGEVHMAyDJFSipPkxnZp/EOhjZ4NUCH6kI9e7GrHGWY6RrtuWxJGbr/SRHZZQphQR
         9r5CjpnMbvKzMFqchi49oKNK8OwFJzkI7XRUBXSZvI9wJNp2IqjFAZhmNJTVi5TwPP3D
         Ba1G3Mb8JzPANR9doXac/a5JjB5XtwOk3b4cwmeoTqGjCqyvr6a1zz+FRvKqe4eK/L/+
         GBKA==
X-Gm-Message-State: AOAM533wigh5uGi4qKfmZQjAptVL9FsJGf59uZwcVRmy60HKmvBQ0bjL
        hzwgwocTbVQwedlr9rAPhMVwNB4WoPOAPS3nF6pLw9oyJjRq7koOV4okyy/qeZ7URM1q2z/lDcy
        6N3dLbaGQ2q6aTl7VBRu4DgIQ
X-Received: by 2002:a05:6402:2891:: with SMTP id eg17mr4529291edb.33.1640110590003;
        Tue, 21 Dec 2021 10:16:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1A8/D2KSPClN8mkwmxMpBeMDz35yUrtABXglLtrO/tH+rl/3zBn9FK8lB8DeMNNQQA0SHdg==
X-Received: by 2002:a05:6402:2891:: with SMTP id eg17mr4529270edb.33.1640110589822;
        Tue, 21 Dec 2021 10:16:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id hd36sm778579ejc.96.2021.12.21.10.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 10:16:29 -0800 (PST)
Message-ID: <e387ed3f-8f8c-1fa9-e576-92bd3ab08671@redhat.com>
Date:   Tue, 21 Dec 2021 19:16:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/6] Support Spi in i2c-multi-instantiate driver
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211210154050.3713-1-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 12/10/21 16:40, Stefan Binding wrote:
> Add support for SPI bus in the ic2-multi-instantiate driver as
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
> driver, being upstreamed:
> https://lkml.org/lkml/2021/11/23/723

Patches 1-5 look good to me and are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Rafael, you may also consider this as my ack for merging this
series through the ACPI subsys branches.

But I do have some remarks on patch 6 which should be
addressed first.

Regards,

Hans



> 
> Changes since V1:
>  - Added Cover Letter
>  - Split SPI patch into move, rename, reorganize and add
>    SPI support
>  - Hard coded BUS type for better decison making at bmi_probe
>  - Driver moved to acpi folder
>  - Change to use acpi_spi_find_controller_by_adev
>  - New shared function bmi_get_irq for I2C and SPI
> 
> 
> Lucas Tanure (3):
>   platform/x86: i2c-multi-instantiate: Move it to drivers/acpi folder
>   ACPI: i2c-multi-instantiate: Rename it for a generic bus driver name
>   ACPI: bus-multi-instantiate: Reorganize I2C functions
> 
> Stefan Binding (3):
>   spi: Export acpi_spi_find_controller_by_adev to be used externally
>   spi: Make spi_alloc_device and spi_add_device public again
>   ACPI: bus-multi-instantiate: Add SPI support
> 
>  MAINTAINERS                                  |   4 +-
>  drivers/acpi/Kconfig                         |  11 +
>  drivers/acpi/Makefile                        |   1 +
>  drivers/acpi/bus-multi-instantiate.c         | 500 +++++++++++++++++++
>  drivers/acpi/scan.c                          |  19 +-
>  drivers/platform/x86/Kconfig                 |  11 -
>  drivers/platform/x86/Makefile                |   1 -
>  drivers/platform/x86/i2c-multi-instantiate.c | 174 -------
>  drivers/spi/spi.c                            |   9 +-
>  include/linux/spi/spi.h                      |  22 +
>  10 files changed, 552 insertions(+), 200 deletions(-)
>  create mode 100644 drivers/acpi/bus-multi-instantiate.c
>  delete mode 100644 drivers/platform/x86/i2c-multi-instantiate.c
> 

