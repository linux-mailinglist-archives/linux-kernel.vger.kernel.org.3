Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E524CA07E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbiCBJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiCBJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:21:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9B9290255
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646212847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxB2x0uiAeyPL9eq9ZxTwdnfKzDaq+YhP6yujTlzUgs=;
        b=Z1rVzG6N3784fp1P618LjKr1Tbh+7A2BdGTODkSNOZt0gb6H/MaOAViNBdjskTl+XFm046
        PJTDLlu0dKXtDU2xEo0r5Lkz74+3gvGPnrOl31BygMIcv8stfO7iAcUQXRI6l1ZpagdtYW
        at3R7yJMKd3tQyJuyJZ+k6NC2VUEvlI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-VU66LWH_MyOyyGBHayhA3A-1; Wed, 02 Mar 2022 04:20:46 -0500
X-MC-Unique: VU66LWH_MyOyyGBHayhA3A-1
Received: by mail-wm1-f72.google.com with SMTP id az36-20020a05600c602400b003811b328ed5so325691wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 01:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=rxB2x0uiAeyPL9eq9ZxTwdnfKzDaq+YhP6yujTlzUgs=;
        b=6xflfk6Zykp+CAxO4hqxBCCeO5O+B9X3eLqpy49fiF3kPsb0BLJSgSEVWrhunP4PTo
         Rt3/V5KnbAgbLuRK16MfcxwIQLpdcOMHoqUBo4gttih3LaFX9w2LIpJM3jnx9KdNSR5z
         h/szjG99UXuFwjYZYfB0PmLD9Cg0LruKuBfrAP8uqgd5r5x2jHYkmYJhuJGnyQQGnILN
         a1xEmVF71QZC4CPlz3bgtq2JkFlSeOZakXgtqAvdpnJv5yvgqoO/zZqwVf9C0L7kZJ/A
         ZfW+wq4XQTYZTNW2lImiDPBZjOkB2fJRZxb03X6fX8qv1RI5HSxv3FrODFPpcwu65HYA
         n8Yg==
X-Gm-Message-State: AOAM533AQ4W3Q+xd9kQRVMra8AGCUreGRsEyCBCWi4KiODAW08+HOrrX
        ZQA2GMHEYC/5FcoiVB3LJzLuTB/4AoztqTcGlAOiK9J6bveRzcv9NLxXbuc3lydtWRnYeR+lfwO
        uryOuYJGiha89ulIMH3lPyUcL
X-Received: by 2002:a5d:6f08:0:b0:1ef:d822:e3 with SMTP id ay8-20020a5d6f08000000b001efd82200e3mr8909681wrb.561.1646212845622;
        Wed, 02 Mar 2022 01:20:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxpkd4KJX8HmTSD2coAy2EZqBLGkWlF73R0dzv5U5go1/xrQCDgcTvsGvY7pAmRBFBMoZf9g==
X-Received: by 2002:a5d:6f08:0:b0:1ef:d822:e3 with SMTP id ay8-20020a5d6f08000000b001efd82200e3mr8909667wrb.561.1646212845358;
        Wed, 02 Mar 2022 01:20:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:be00:9509:b3b1:97e2:ef4c? (p200300cbc709be009509b3b197e2ef4c.dip0.t-ipconnect.de. [2003:cb:c709:be00:9509:b3b1:97e2:ef4c])
        by smtp.gmail.com with ESMTPSA id f21-20020a5d58f5000000b001ea99c3397dsm16738834wrd.21.2022.03.02.01.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:20:42 -0800 (PST)
Message-ID: <f23efdc0-20c8-ccfd-f54d-69a9b4ee531f@redhat.com>
Date:   Wed, 2 Mar 2022 10:20:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 02/10] crash hp: Introduce CRASH_HOTPLUG configuration
 options
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-3-eric.devolder@oracle.com>
 <YhWpF/Cj/V+Cx6+d@MiWiFi-R3L-srv>
 <10d67f14-c5fe-0a17-e8b5-97702823cc1c@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <10d67f14-c5fe-0a17-e8b5-97702823cc1c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.03.22 21:04, Eric DeVolder wrote:
> 
> 
> On 2/22/22 21:25, Baoquan He wrote:
>> On 02/09/22 at 02:56pm, Eric DeVolder wrote:
>>> Support for CPU and memory hotplug for crash is controlled by the
>>> CRASH_HOTPLUG configuration option, introduced by this patch.
>>>
>>> The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
>>> also introduced with this patch.
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> ---
>>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index ebe8fc76949a..4e3374edab02 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -2060,6 +2060,32 @@ config CRASH_DUMP
>>>   	  (CONFIG_RELOCATABLE=y).
>>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>>   
>>> +config CRASH_HOTPLUG
>>> +	bool "kernel updates of crash elfcorehdr"
>>> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
>>> +	help
>>> +	  Enable the kernel to update the crash elfcorehdr (which contains
>>> +	  the list of CPUs and memory regions) directly when hot plug/unplug
>>> +	  of CPUs or memory. Otherwise userspace must monitor these hot
>>> +	  plug/unplug change notifications via udev in order to
>>> +	  unload-then-reload the crash kernel so that the list of CPUs and
>>> +	  memory regions is kept up-to-date. Note that the udev CPU and
>>> +	  memory change notifications still occur (however, userspace is not
>>> +	  required to monitor for crash dump purposes).
>>> +
>>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>>> +	depends on CRASH_HOTPLUG
>>> +	int
>>> +	default 131072
>>> +	help
>>> +	  Specify the maximum size of the elfcorehdr buffer/segment.
>>> +	  The 128KiB default is sized so that it can accommodate 2048
>>> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
>>> +	  region of memory.
>>> +	  For example, this size can accommodate hotplugging a machine
>>> +	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
>>> +	  with 1024 1GiB memory DIMMs).
>>
>> This example of memory could be a little misleading. The memory regions
>> may not be related to memory DIMMs. System could split them into many
>> smaller regions during bootup.
> 
> I changed "with 1024 1GiB memory DIMMs" to "with 1024 1GiB hotplug memories".
> eric

It's still not quite precise. Essentially it's the individual "System
RAM" entries in /proc/iomem

Boot memory (i.e., a single DIMM) might be represented by multiple
entries due to rearranged holes (by the BIOS).

While hoplugged DIMMs (under virt!) are usually represented using a
single range, it can be different on physical machines. Last but not
least, dax/kmem and virtio-mem behave in a different way.

-- 
Thanks,

David / dhildenb

