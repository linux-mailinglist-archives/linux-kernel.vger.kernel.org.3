Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355215064A0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiDSGkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiDSGkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:40:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029662E9E1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:37:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq30so27674937lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5XKHbxSoKgLV4l6KLfHSllkOSuhO/yQcH7URIe/RXvI=;
        b=BYPkS0mpRwyVL9+QysC/keXryrD+pxuYOK+l6BJJIivxNikhJ0VtOVqV0+B0uiYhaL
         DjZ23GRUAgibnxdNIYb+7rrBrziMLsMzetdRhrLEVUeEoQQrNLNYHbscuspqA1h/nqmj
         6M48Lcp3KfrE1wn39oOaq5AA0prsFcogF73dVS8jB3fLuFfhoI040zgnqPgm3giiysBx
         1yVaxxA5Dic0aV4U5zVVFA/g2Sx6Me5dYB4w5CpojlKhQwWaF2nLmKspLwI7WeV3yXms
         kHxkI4gz+mi4riP69GlEkJdFijXXH8B+xc8x3GERO8+4CKKcLBqxOHAbnZeJriADnkHn
         Sn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5XKHbxSoKgLV4l6KLfHSllkOSuhO/yQcH7URIe/RXvI=;
        b=j2dNRpriv167/AifMV/krzNoHAUwjzL/tadbWWEylHH1KJs5CtXkCRfwhRsh3sHwmp
         vtftPoeSfrL2VPH7LN0RIv2mppZya9ujTwucmX4HtF9Zba0xf3+OrYFhRGVRO2OV6yAx
         XTkP3LW3EY4H/cfo+f99kbLUhM29bphzt6zTW/VBLnmF01MqSOvpLBcOqXasLDmDK0DI
         1Oi3Q6oH3h1gs9T7ik3EwQfKMsN48M+/fhx6KVt5fRuuNw7OoPf7HM0LC+SzKcBdnwHH
         clNV+qrZ3VFJHrigEI+IIczOEu/HGqeK8XF/aMJ4FUcfrOwqYP5h/BoJURoNZ5WI8dqP
         asHA==
X-Gm-Message-State: AOAM5306x1yFk8MM2u1ipZX8rJoDqIw1TGcAzFrEWT9XSURuZACePX1i
        BxwJW1N3k8SCyTy5i53Nwiw=
X-Google-Smtp-Source: ABdhPJx0KZwoC2ACm+X1wAjeDTfX3UjujeGdQe8hMMbvoAvvFDS4CUtPuCSHarytJl83njjUXCAAng==
X-Received: by 2002:a05:6512:23a8:b0:470:77ac:64b1 with SMTP id c40-20020a05651223a800b0047077ac64b1mr9346732lfv.322.1650350253959;
        Mon, 18 Apr 2022 23:37:33 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id b15-20020ac2562f000000b004437f2667bfsm1418167lff.308.2022.04.18.23.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 23:37:33 -0700 (PDT)
Subject: Re: [RFC PATCH 2/6] virtio: add option to restrict memory access
 under Xen
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-3-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151235440.915916@ubuntu-linux-20-04-desktop>
 <8a66ad42-a3e7-c29d-7d4e-35766dcccd15@gmail.com>
 <alpine.DEB.2.22.394.2204181151030.915916@ubuntu-linux-20-04-desktop>
 <ef637f17-0e9c-2f86-218b-918297cb9930@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <5b6f8f1c-1ffd-9582-89b4-54f73ec4f5c4@gmail.com>
Date:   Tue, 19 Apr 2022 09:37:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ef637f17-0e9c-2f86-218b-918297cb9930@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Stefano, Juergen


On 19.04.22 09:21, Juergen Gross wrote:
> On 18.04.22 21:11, Stefano Stabellini wrote:
>> On Sun, 17 Apr 2022, Oleksandr wrote:
>>> On 16.04.22 01:01, Stefano Stabellini wrote:
>>>> On Thu, 14 Apr 2022, Oleksandr Tyshchenko wrote:
>>>>> From: Juergen Gross <jgross@suse.com>
>>>>>
>>>>> In order to support virtio in Xen guests add a config option enabling
>>>>> the user to specify whether in all Xen guests virtio should be 
>>>>> able to
>>>>> access memory via Xen grant mappings only on the host side.
>>>>>
>>>>> This applies to fully virtualized guests only, as for paravirtualized
>>>>> guests this is mandatory.
>>>>>
>>>>> This requires to switch arch_has_restricted_virtio_memory_access()
>>>>> from a pure stub to a real function on x86 systems (Arm systems are
>>>>> not covered by now).
>>>>>
>>>>> Add the needed functionality by providing a special set of DMA ops
>>>>> handling the needed grant operations for the I/O pages.
>>>>>
>>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>>> ---
>>>>>    arch/x86/mm/init.c        |  15 ++++
>>>>>    arch/x86/mm/mem_encrypt.c |   5 --
>>>>>    arch/x86/xen/Kconfig      |   9 +++
>>>>>    drivers/xen/Kconfig       |  20 ++++++
>>>>>    drivers/xen/Makefile      |   1 +
>>>>>    drivers/xen/xen-virtio.c  | 177
>>>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>>>    include/xen/xen-ops.h     |   8 +++
>>>>>    7 files changed, 230 insertions(+), 5 deletions(-)
>>>>>    create mode 100644 drivers/xen/xen-virtio.c
>>>>>
>>>>> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
>>>>> index d8cfce2..526a3b2 100644
>>>>> --- a/arch/x86/mm/init.c
>>>>> +++ b/arch/x86/mm/init.c
>>>>> @@ -8,6 +8,8 @@
>>>>>    #include <linux/kmemleak.h>
>>>>>    #include <linux/sched/task.h>
>>>>>    +#include <xen/xen.h>
>>>>> +
>>>>>    #include <asm/set_memory.h>
>>>>>    #include <asm/e820/api.h>
>>>>>    #include <asm/init.h>
>>>>> @@ -1065,3 +1067,16 @@ unsigned long max_swapfile_size(void)
>>>>>        return pages;
>>>>>    }
>>>>>    #endif
>>>>> +
>>>>> +#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>>>>> +int arch_has_restricted_virtio_memory_access(void)
>>>>> +{
>>>>> +    if (IS_ENABLED(CONFIG_XEN_PV_VIRTIO) && xen_pv_domain())
>>>>> +        return 1;
>>>>> +    if (IS_ENABLED(CONFIG_XEN_HVM_VIRTIO_GRANT) && xen_hvm_domain())
>>>>> +        return 1;
>>>> I think these two checks could be moved to a separate function in a 
>>>> Xen
>>>> header, e.g. xen_restricted_virtio_memory_access, and here you could
>>>> just
>>>>
>>>> if (xen_restricted_virtio_memory_access())
>>>>       return 1;
>>>
>>> Agree, will do
>>>
>>>
>>>>
>>>>
>>>>
>>>>> +    return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
>>>>> +#endif
>>>>> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
>>>>> index 50d2099..dda020f 100644
>>>>> --- a/arch/x86/mm/mem_encrypt.c
>>>>> +++ b/arch/x86/mm/mem_encrypt.c
>>>>> @@ -77,8 +77,3 @@ void __init mem_encrypt_init(void)
>>>>>        print_mem_encrypt_feature_info();
>>>>>    }
>>>>>    -int arch_has_restricted_virtio_memory_access(void)
>>>>> -{
>>>>> -    return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
>>>>> -}
>>>>> -EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
>>>>> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
>>>>> index 85246dd..dffdffd 100644
>>>>> --- a/arch/x86/xen/Kconfig
>>>>> +++ b/arch/x86/xen/Kconfig
>>>>> @@ -92,3 +92,12 @@ config XEN_DOM0
>>>>>        select X86_X2APIC if XEN_PVH && X86_64
>>>>>        help
>>>>>          Support running as a Xen Dom0 guest.
>>>>> +
>>>>> +config XEN_PV_VIRTIO
>>>>> +    bool "Xen virtio support for PV guests"
>>>>> +    depends on XEN_VIRTIO && XEN_PV
>>>>> +    default y
>>>>> +    help
>>>>> +      Support virtio for running as a paravirtualized guest. This 
>>>>> will
>>>>> +      need support on the backend side (qemu or kernel, depending 
>>>>> on the
>>>>> +      virtio device types used).
>>>>> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
>>>>> index 120d32f..fc61f7a 100644
>>>>> --- a/drivers/xen/Kconfig
>>>>> +++ b/drivers/xen/Kconfig
>>>>> @@ -335,4 +335,24 @@ config XEN_UNPOPULATED_ALLOC
>>>>>          having to balloon out RAM regions in order to obtain 
>>>>> physical memory
>>>>>          space to create such mappings.
>>>>>    +config XEN_VIRTIO
>>>>> +    bool "Xen virtio support"
>>>>> +    default n
>>>>> +    depends on VIRTIO && DMA_OPS
>>>>> +    select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>>>>> +    help
>>>>> +      Enable virtio support for running as Xen guest. Depending 
>>>>> on the
>>>>> +      guest type this will require special support on the backend 
>>>>> side
>>>>> +      (qemu or kernel, depending on the virtio device types used).
>>>>> +
>>>>> +config XEN_HVM_VIRTIO_GRANT
>>>>> +    bool "Require virtio for fully virtualized guests to use grant
>>>>> mappings"
>>>>> +    depends on XEN_VIRTIO && X86_64
>>>>> +    default y
>>>>> +    help
>>>>> +      Require virtio for fully virtualized guests to use grant 
>>>>> mappings.
>>>>> +      This will avoid the need to give the backend the right to 
>>>>> map all
>>>>> +      of the guest memory. This will need support on the backend 
>>>>> side
>>>>> +      (qemu or kernel, depending on the virtio device types used).
>>>> I don't think we need 3 visible kconfig options for this.
>>>>
>>>> In fact, I would only add one: XEN_VIRTIO. We can have any X86 (or 
>>>> ARM)
>>>> specific dependencies in the "depends" line under XEN_VIRTIO. And I
>>>> don't think we need XEN_HVM_VIRTIO_GRANT as a kconfig option
>>>> necessarely. It doesn't seem like some we want as build time 
>>>> option. At
>>>> most, it could be a runtime option (like a command line) or a debug
>>>> option (like an #define at the top of the source file.)
>>>
>>>
>>> I don't know what was the initial idea of having and extra 
>>> XEN_HVM_VIRTIO and
>>> XEN_PV_VIRTIO options, but taking into the account that
>>> they are only used in arch_has_restricted_virtio_memory_access() 
>>> currently, I
>>> share your opinion regarding a single XEN_VIRTIO option.
>>>
>>> Looking ahead (including changes in the commit #4), we can imagine the
>>> resulting option:
>>>
>>> config XEN_VIRTIO
>>>      bool "Xen virtio support"
>>>      default n
>>>      depends on VIRTIO && DMA_OPS
>>>      depends on (X86_64 || ARM || ARM64)
>>>      select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>>>      help
>>>        Enable virtio support for running as Xen guest. Depending on the
>>>        guest type this will require special support on the backend side
>>>        (qemu or kernel, depending on the virtio device types used).
>>>
>>>
>>> and then arch_has_restricted_virtio_memory_access() per arch:
>>>
>>>
>>> 1. x86:
>>>
>>> int arch_has_restricted_virtio_memory_access(void)
>>> {
>>>      return (xen_has_restricted_virtio_memory_access() ||
>>>              cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
>>> }
>>>
>>>
>>> 2. Arm:
>>>
>>> int arch_has_restricted_virtio_memory_access(void)
>>> {
>>>      return xen_has_restricted_virtio_memory_access();
>>> }
>>>
>>>
>>> 3. xen.h:
>>>
>>> static inline int xen_has_restricted_virtio_memory_access(void)
>>> {
>>>      if (IS_ENABLED(CONFIG_XEN_VIRTIO) && (xen_pv_domain() ||
>>> xen_hvm_domain()))
>>>          return 1;
>>>
>>>      return 0;
>>> }
>>>
>>>
>>> Actually, as domain type on Arm is always XEN_HVM_DOMAIN, we could 
>>> probably
>>> have the following on Arm:
>>>
>>> int arch_has_restricted_virtio_memory_access(void)
>>> {
>>>      return IS_ENABLED(CONFIG_XEN_VIRTIO);
>>> }
>>>
>>> but I would prefer not to diverge and use common
>>> xen_has_restricted_virtio_memory_access().
>>>
>>> Any thoughts?
>>
>> Yes, I would also prefer not to diverge between the x86 and arm versions
>> of xen_has_restricted_virtio_memory_access. But what case are we trying
>> to catch with (xen_pv_domain() || xen_hvm_domain()) ? Even on x86, it is
>> not going to leave much out. Is it really meant only to exclude pvh
>> domains?

Good question. By leaving (xen_pv_domain() || xen_hvm_domain()) here I 
tried to retain what the *initial* version of 
arch_has_restricted_virtio_memory_access() covered.


>
> It wouldn't exclude pvh domains.


ok


>
>>
>> I have the feeling that we could turn this check into:
>>
>> static inline int xen_has_restricted_virtio_memory_access(void)
>> {
>>      return IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain();
>> }
>>
>> even on x86, but one of the xen/x86 maintainers should confirm.
>
> I do confirm this is better and functionally equivalent.


Perfect, thank you for confirming. Will use that check.


>
>
> Juergen

-- 
Regards,

Oleksandr Tyshchenko

