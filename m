Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3465B46AA98
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352216AbhLFVoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352173AbhLFVoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638826847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=veukaapGBdz2yq7cvoWrlyqpvVVcueT7D3xH6m4YqRY=;
        b=AB84DB2/q9qehiFa3kPpC5KS/yGJvr43SXjC+uXy11wG7JPipSosVayNy2ag0fI5kyuJjZ
        78QsFJM83knLfKabxvhm8y94q9mMYg2WAhtZjHYQvRzmI8kUKH2qyGVDHlFzeh+si6drRA
        /as63jd9QC6G5kuaLEXUST7b3uMFT6U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-HziiXBEnM9qRmCEzIKAc0w-1; Mon, 06 Dec 2021 16:40:44 -0500
X-MC-Unique: HziiXBEnM9qRmCEzIKAc0w-1
Received: by mail-ed1-f69.google.com with SMTP id w5-20020a05640234c500b003f1b9ab06d2so9517431edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=veukaapGBdz2yq7cvoWrlyqpvVVcueT7D3xH6m4YqRY=;
        b=wwyAEZy7E9n8SeLLkj++Yve+G9UiQ+uOmapzfrWBdA9eHcRC0r9yHvwqsvMhGMDg8M
         8W5sWNJ83Xd5oVQziKrT+aBr/xeyBJ78cr3iHJfuZck6eb46ZcYzyTaT+JExe4hNmG/K
         FduIsXVgrAH1xawGffU45PECp9fuBmTcdBd9ETwHnLyoh6skr0vGWTqby2BzWb3Vd/63
         9VB25d8/zfUeN9WSmbneTZaoJgRMJfaJYm/zOuRWNW+JcNV7SKGggjt6Fd/Zypw6AYMg
         PzqDnhV3lcKqB79vxqyKxEEx8vTrG4U2sMW+r7uJqBmV6fUAJxLd0IEXBpMx0Oc+3iR5
         kwTg==
X-Gm-Message-State: AOAM5321DqqrwXV3Zjz8GFJZ8dk8i/uDSTvrjA8ETh4AOAoNgLtRNXNr
        a/FMf9wVTTnLGqdgG3tJf/XW4Q+3RwpMykHo4BUdTgzu5sXfBlHLReDvkoglRs27oaObXaolJuR
        avr/ys60Rx/2lcpgeTd8aF5/I
X-Received: by 2002:a05:6402:348b:: with SMTP id v11mr2597936edc.276.1638826842508;
        Mon, 06 Dec 2021 13:40:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKc5sLVaRUlJAvnik7YO6sicX6i5fywo2lsr7E1JoY3p6ePADfa2FkOmTTHz54PEMiMunTqg==
X-Received: by 2002:a05:6402:348b:: with SMTP id v11mr2597904edc.276.1638826842297;
        Mon, 06 Dec 2021 13:40:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id qk40sm7232823ejc.2.2021.12.06.13.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 13:40:41 -0800 (PST)
Message-ID: <e0c42dca-9500-d4c8-ab93-c958a3b23348@redhat.com>
Date:   Mon, 6 Dec 2021 22:40:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [EXTERNAL] Re: [PATCH 2/5] platform: surface: Propagate ACPI
 Dependency
Content-Language: en-US
To:     Jarrett Schultz <jaschultz@microsoft.com>,
        Jarrett Schultz <jaschultzms@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
References: <20211202191630.12450-1-jaschultz@microsoft.com>
 <20211202191630.12450-3-jaschultz@microsoft.com>
 <639583df-a54a-eb9b-91ad-a60612a930b0@redhat.com>
 <BL0PR2101MB1316DFA13C3AB1A6620A6CA3A56A9@BL0PR2101MB1316.namprd21.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <BL0PR2101MB1316DFA13C3AB1A6620A6CA3A56A9@BL0PR2101MB1316.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/3/21 18:34, Jarrett Schultz wrote:
> 
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Friday, December 3, 2021 1:59 AM
>> To: Jarrett Schultz <jaschultzms@gmail.com>; Rob Herring
>> <robh+dt@kernel.org>; Andy Gross <agross@kernel.org>; Bjorn Andersson
>> <bjorn.andersson@linaro.org>; Mark Gross <markgross@kernel.org>;
>> Maximilian Luz <luzmaximilian@gmail.com>
>> Cc: linux-arm-msm@vger.kernel.org; platform-driver-x86@vger.kernel.org;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Felipe Balbi
>> <balbi@kernel.org>; Jarrett Schultz <jaschultz@microsoft.com>
>> Subject: [EXTERNAL] Re: [PATCH 2/5] platform: surface: Propagate ACPI
>> Dependency
>>
>> Hi Jarett,
>>
>> On 12/2/21 20:16, Jarrett Schultz wrote:
>>> Since the Surface XBL Driver does not depend on ACPI, the
>>> platform/surface directory as a whole no longer depends on ACPI. With
>>> respect to this, the ACPI dependency is moved into each config that
>>> depends on ACPI individually.
>>>
>>> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
>>
>> I think I will already merge this patch into the pdx86 tree:
>>
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.k
>> ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpdx86%2Fplatform-
>> drivers-
>> x86.git%2F&amp;data=04%7C01%7Cjaschultz%40microsoft.com%7C0ab6fcc6
>> 4a5c4fd8657308d9b64391dd%7C72f988bf86f141af91ab2d7cd011db47%7C0
>> %7C0%7C637741223627024908%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
>> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
>> amp;sdata=fEszuAgBLL3g2Z9Lh3DPQ%2BlzrWZR3o6aUst6fDmLOrE%3D&amp
>> ;reserved=0
>>
>> While we are waiting for the rest of the series to get hashed out.
>>
>> But as already pointed out by Trilok Soni your From: and Signed-off-by email
>> addresses don't match.
>>
>> I can fix up the From to match the Signed-off-by while I apply this, but before
>> I do that I wanted to check with you that setting both to "Jarrett Schultz
>> <jaschultz@microsoft.com>" is the right thing to do ?
>>
>> Regards,
>>
>> Hans
>>
>>
> 
> Hans,
> 
> Yes, that is the correct email. Still trying to get all the kinks worked out, I appreciate your patience.

Ok, I've merged this patch now, so you can drop it from the next version of
the series.


Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans





>>> ---
>>>
>>> Changes in v3:
>>>  - Further propagated ACPI dependecy to SURFACE_AGGREGATOR
>>>
>>> ---
>>>
>>> Changes in v2:
>>>  - Created to propagate ACPI dependency
>>> ---
>>>  drivers/platform/surface/Kconfig            | 7 ++++++-
>>>  drivers/platform/surface/aggregator/Kconfig | 1 +
>>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/surface/Kconfig
>>> b/drivers/platform/surface/Kconfig
>>> index 3105f651614f..5f0578e25f71 100644
>>> --- a/drivers/platform/surface/Kconfig
>>> +++ b/drivers/platform/surface/Kconfig
>>> @@ -5,7 +5,6 @@
>>>
>>>  menuconfig SURFACE_PLATFORMS
>>>  	bool "Microsoft Surface Platform-Specific Device Drivers"
>>> -	depends on ACPI
>>>  	default y
>>>  	help
>>>  	  Say Y here to get to see options for platform-specific device
>>> drivers @@ -30,12 +29,14 @@ config SURFACE3_WMI
>>>
>>>  config SURFACE_3_BUTTON
>>>  	tristate "Power/home/volume buttons driver for Microsoft Surface 3
>> tablet"
>>> +	depends on ACPI
>>>  	depends on KEYBOARD_GPIO && I2C
>>>  	help
>>>  	  This driver handles the power/home/volume buttons on the
>> Microsoft Surface 3 tablet.
>>>
>>>  config SURFACE_3_POWER_OPREGION
>>>  	tristate "Surface 3 battery platform operation region support"
>>> +	depends on ACPI
>>>  	depends on I2C
>>>  	help
>>>  	  This driver provides support for ACPI operation @@ -126,6 +127,7
>>> @@ config SURFACE_DTX
>>>
>>>  config SURFACE_GPE
>>>  	tristate "Surface GPE/Lid Support Driver"
>>> +	depends on ACPI
>>>  	depends on DMI
>>>  	help
>>>  	  This driver marks the GPEs related to the ACPI lid device found on
>>> @@ -135,6 +137,7 @@ config SURFACE_GPE
>>>
>>>  config SURFACE_HOTPLUG
>>>  	tristate "Surface Hot-Plug Driver"
>>> +	depends on ACPI
>>>  	depends on GPIOLIB
>>>  	help
>>>  	  Driver for out-of-band hot-plug event signaling on Microsoft
>>> Surface @@ -154,6 +157,7 @@ config SURFACE_HOTPLUG
>>>
>>>  config SURFACE_PLATFORM_PROFILE
>>>  	tristate "Surface Platform Profile Driver"
>>> +	depends on ACPI
>>>  	depends on SURFACE_AGGREGATOR_REGISTRY
>>>  	select ACPI_PLATFORM_PROFILE
>>>  	help
>>> @@ -176,6 +180,7 @@ config SURFACE_PLATFORM_PROFILE
>>>
>>>  config SURFACE_PRO3_BUTTON
>>>  	tristate "Power/home/volume buttons driver for Microsoft Surface
>> Pro 3/4 tablet"
>>> +	depends on ACPI
>>>  	depends on INPUT
>>>  	help
>>>  	  This driver handles the power/home/volume buttons on the
>> Microsoft Surface Pro 3/4 tablet.
>>> diff --git a/drivers/platform/surface/aggregator/Kconfig
>>> b/drivers/platform/surface/aggregator/Kconfig
>>> index fd6dc452f3e8..cab020324256 100644
>>> --- a/drivers/platform/surface/aggregator/Kconfig
>>> +++ b/drivers/platform/surface/aggregator/Kconfig
>>> @@ -4,6 +4,7 @@
>>>  menuconfig SURFACE_AGGREGATOR
>>>  	tristate "Microsoft Surface System Aggregator Module Subsystem
>> and Drivers"
>>>  	depends on SERIAL_DEV_BUS
>>> +	depends on ACPI
>>>  	select CRC_CCITT
>>>  	help
>>>  	  The Surface System Aggregator Module (Surface SAM or SSAM) is an
>>>
> 

