Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E02554EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359377AbiFVPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359235AbiFVPSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:18:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B4335273
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:18:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s21so17788718lfs.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=voDIPs5YJmfo9tUKj6tnw6GFbS+YdFDAG7O9BzN4gXY=;
        b=fqFDZlq0BDYXOWaOyOFapKJILq2Vf1WwkB4Fb03CkE6T9zWG3WBomecBldgCeZ6HI1
         zNnwcQEpXMo4ubP1U6S5habjLO/6siOT3JWFcjcjLzVK7Ejjt1DdwZxFBP9Ldl2rWKrs
         MU9IAbcqPU7aXR09xDaFFCykT1Ip8Hyw7XA2CYvzgdGJnwNvJIYh7nI3qidBLiYoYNYQ
         wAJmQDwD6eo7yXnjqfr6fIRypyDAmnjgXyv4q+26P2A5eMZ1n5I4pY8yjFNFYkDH6zkz
         2fIct55dW8X/TK3N9QP+2aKG+tesiSNkrw5jVPnqgquKXT7UirFZh4HsO7i8K4T+4zUJ
         A64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=voDIPs5YJmfo9tUKj6tnw6GFbS+YdFDAG7O9BzN4gXY=;
        b=T8JxDzc6eWZWFzD+CdDBYQC5pgdbV+ddNBlQoihPYEU5rsJ44LodWX1Ih+1+GQPtWi
         CivH257jF4MGK8ue3rs12IsC72sEam8FK3cgRKTD4XuD+oadn8m+FefZf2xoDBWdESCC
         asxWQVIj3tZl/HSTqIlT/cSCmYZUGmIKAGN6MhS98+sTTAluo/WKm22mcaASPFPVA96O
         68VN3oydcWr+OG+tFI9rmnNqfm9N0mMW2y84KeF/+4MROuSN6KKAkPvhR4cKKqfhthKR
         UVjy0gcmshecgq9enij0DfYUHQizps2uyMdI9W5rM4AN/vGltteBpThXDrot1o4nBQzG
         S52w==
X-Gm-Message-State: AJIora9ZMMa9Wchf4Fr3+qXivC3qGsdipxnKeshS7Uq9hmL7OTN1yas/
        mnAPo80EweiUF68ywXaUudnvybc3yZY=
X-Google-Smtp-Source: AGRyM1thyu2aqNX+9ul7EirdEpEty55FnPz/79PlYHYAIOgtoOYzPKH3v6m/DRInPDpfDYJrzQilCw==
X-Received: by 2002:a05:6512:b8d:b0:47f:74f0:729b with SMTP id b13-20020a0565120b8d00b0047f74f0729bmr2421974lfv.403.1655911109435;
        Wed, 22 Jun 2022 08:18:29 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b0047f78ad78b7sm924572lfr.219.2022.06.22.08.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 08:18:28 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] xen: don't require virtio with grants for non-PV
 guests
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <20220622063838.8854-1-jgross@suse.com>
 <20220622063838.8854-4-jgross@suse.com>
 <a8ce8ad3-aa3b-ea87-34cf-6532a272e9d8@gmail.com>
 <0f047970-d9ea-d2fd-3208-db843305e11c@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <c9b6f236-73cd-f677-98a8-26117fb17dee@gmail.com>
Date:   Wed, 22 Jun 2022 18:18:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0f047970-d9ea-d2fd-3208-db843305e11c@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22.06.22 17:35, Juergen Gross wrote:


Hello Juergen

> On 22.06.22 11:03, Oleksandr wrote:
>>
>> On 22.06.22 09:38, Juergen Gross wrote:
>>
>> Hello Juergen
>>
>>> Commit fa1f57421e0b ("xen/virtio: Enable restricted memory access using
>>> Xen grant mappings") introduced a new requirement for using virtio
>>> devices: the backend now needs to support the VIRTIO_F_ACCESS_PLATFORM
>>> feature.
>>>
>>> This is an undue requirement for non-PV guests, as those can be 
>>> operated
>>> with existing backends without any problem, as long as those backends
>>> are running in dom0.
>>>
>>> Per default allow virtio devices without grant support for non-PV
>>> guests.
>>>
>>> On Arm require VIRTIO_F_ACCESS_PLATFORM for devices having been listed
>>> in the device tree to use grants.
>>>
>>> Add a new config item to always force use of grants for virtio.
>>>
>>> Fixes: fa1f57421e0b ("xen/virtio: Enable restricted memory access 
>>> using Xen grant mappings")
>>> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>> V2:
>>> - remove command line parameter (Christoph Hellwig)
>>> V3:
>>> - rebase to callback method
>>
>>
>> Patch looks good, just one NIT ...
>>
>>
>>> ---
>>>   arch/arm/xen/enlighten.c     |  4 +++-
>>>   arch/x86/xen/enlighten_hvm.c |  4 +++-
>>>   arch/x86/xen/enlighten_pv.c  |  5 ++++-
>>>   drivers/xen/Kconfig          |  9 +++++++++
>>>   drivers/xen/grant-dma-ops.c  | 10 ++++++++++
>>>   include/xen/xen-ops.h        |  6 ++++++
>>>   include/xen/xen.h            |  8 --------
>>>   7 files changed, 35 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>>> index 1f9c3ba32833..93c8ccbf2982 100644
>>> --- a/arch/arm/xen/enlighten.c
>>> +++ b/arch/arm/xen/enlighten.c
>>> @@ -34,6 +34,7 @@
>>>   #include <linux/timekeeping.h>
>>>   #include <linux/timekeeper_internal.h>
>>>   #include <linux/acpi.h>
>>> +#include <linux/virtio_anchor.h>
>>>   #include <linux/mm.h>
>>> @@ -443,7 +444,8 @@ static int __init xen_guest_init(void)
>>>       if (!xen_domain())
>>>           return 0;
>>> -    xen_set_restricted_virtio_memory_access();
>>> +    if (IS_ENABLED(CONFIG_XEN_VIRTIO))
>>> +        virtio_set_mem_acc_cb(xen_virtio_mem_acc);
>>>       if (!acpi_disabled)
>>>           xen_acpi_guest_init();
>>> diff --git a/arch/x86/xen/enlighten_hvm.c 
>>> b/arch/x86/xen/enlighten_hvm.c
>>> index 8b71b1dd7639..28762f800596 100644
>>> --- a/arch/x86/xen/enlighten_hvm.c
>>> +++ b/arch/x86/xen/enlighten_hvm.c
>>> @@ -4,6 +4,7 @@
>>>   #include <linux/cpu.h>
>>>   #include <linux/kexec.h>
>>>   #include <linux/memblock.h>
>>> +#include <linux/virtio_anchor.h>
>>>   #include <xen/features.h>
>>>   #include <xen/events.h>
>>> @@ -195,7 +196,8 @@ static void __init xen_hvm_guest_init(void)
>>>       if (xen_pv_domain())
>>>           return;
>>> -    xen_set_restricted_virtio_memory_access();
>>> +    if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT))
>>> + virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>>>       init_hvm_pv_info();
>>> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
>>> index e3297b15701c..5aaae8a77f55 100644
>>> --- a/arch/x86/xen/enlighten_pv.c
>>> +++ b/arch/x86/xen/enlighten_pv.c
>>> @@ -31,6 +31,7 @@
>>>   #include <linux/gfp.h>
>>>   #include <linux/edd.h>
>>>   #include <linux/reboot.h>
>>> +#include <linux/virtio_anchor.h>
>>>   #include <xen/xen.h>
>>>   #include <xen/events.h>
>>> @@ -109,7 +110,9 @@ static DEFINE_PER_CPU(struct tls_descs, 
>>> shadow_tls_desc);
>>>   static void __init xen_pv_init_platform(void)
>>>   {
>>> -    xen_set_restricted_virtio_memory_access();
>>> +    /* PV guests can't operate virtio devices without grants. */
>>> +    if (IS_ENABLED(CONFIG_XEN_VIRTIO))
>>> + virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>>>       populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));
>>> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
>>> index bfd5f4f706bc..a65bd92121a5 100644
>>> --- a/drivers/xen/Kconfig
>>> +++ b/drivers/xen/Kconfig
>>> @@ -355,4 +355,13 @@ config XEN_VIRTIO
>>>         If in doubt, say n.
>>> +config XEN_VIRTIO_FORCE_GRANT
>>> +    bool "Require Xen virtio support to use grants"
>>> +    depends on XEN_VIRTIO
>>> +    help
>>> +      Require virtio for Xen guests to use grant mappings.
>>> +      This will avoid the need to give the backend the right to map 
>>> all
>>> +      of the guest memory. This will need support on the backend side
>>> +      (e.g. qemu or kernel, depending on the virtio device types 
>>> used).
>>> +
>>>   endmenu
>>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>>> index fc0142484001..8973fc1e9ccc 100644
>>> --- a/drivers/xen/grant-dma-ops.c
>>> +++ b/drivers/xen/grant-dma-ops.c
>>> @@ -12,6 +12,8 @@
>>>   #include <linux/of.h>
>>>   #include <linux/pfn.h>
>>>   #include <linux/xarray.h>
>>> +#include <linux/virtio_anchor.h>
>>> +#include <linux/virtio.h>
>>>   #include <xen/xen.h>
>>>   #include <xen/xen-ops.h>
>>>   #include <xen/grant_table.h>
>>> @@ -287,6 +289,14 @@ bool xen_is_grant_dma_device(struct device *dev)
>>>       return has_iommu;
>>>   }
>>> +bool xen_virtio_mem_acc(struct virtio_device *dev)
>>> +{
>>> +    if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT))
>>> +        return true;
>>> +
>>> +    return xen_is_grant_dma_device(dev->dev.parent);
>>> +}
>>
>>
>>     ... I am thinking would it be better to move this to 
>> xen/xen-ops.h as grant-dma-ops.c is generic (not only for virtio, 
>> although the virtio is the first use-case)
>
> I dislike using a function marked as inline in a function vector.
>
> We could add another module "xen-virtio" for this purpose, but this seems
> to be overkill.
>
> I think we should just leave it here and move it later in case more real
> virtio dependent stuff is being added.

I am happy with that explanation.

Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>


>
>
>
> Juergen

-- 
Regards,

Oleksandr Tyshchenko

