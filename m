Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C344CBCD1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiCCLhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiCCLhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:37:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDEC365D3E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646307396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JTVhG5oRObMWI1uKkRQ78Mjaf9/IOE10OhIbgB+n/4=;
        b=Gm7xg4vGJ4XGQBSxdJ9mOv3/Zdts3/TwD3XuVu3Laq6Q01a9WOfWD1U55xRxflHzocKlwC
        lEBsgxvSOswHb2jx3booPKJbsqviq5mpvUuyc/s37QcFqMTCv8BEl13bTNPtuWQfrx30b8
        k/She+Xss5S9weTnmTsqXxyRD6e9oWA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-mA2XjecXPtiiFs8ST0It4A-1; Thu, 03 Mar 2022 06:36:35 -0500
X-MC-Unique: mA2XjecXPtiiFs8ST0It4A-1
Received: by mail-wr1-f69.google.com with SMTP id w2-20020adfbac2000000b001ea99ca4c50so1932675wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 03:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/JTVhG5oRObMWI1uKkRQ78Mjaf9/IOE10OhIbgB+n/4=;
        b=Z2p1EiVabcagIAr/zusoDhZ+/UnjGfB7phpv810CKfKbmR4A511887/HlMmvoIHzfn
         dXLVamLza+FYmCmZkBChZLZiD5hkHnY4osFHO0Qhln/0BIdPTlAPnITHQPrHpwv7Nikp
         Nbi+PQTpVvwSVcah1EFZCXXCBr352tMGOYuTN1shtTsn2+/TexVM/LdNhXr7ly5h7nKQ
         ax4/vaA0Jn2U8Z/ysdIe+y1C8nSez7uvcsF4hA/xMggG2JnvK8KLMETNK0TMxKy93vPR
         NVd+zdacsnMjnEkT7anrrdvW7L6jf1CrxcxjvYE0kPrL7WTsUCkCV73UUWO3d3TsBqQ+
         11Uw==
X-Gm-Message-State: AOAM530A9VvPasckbjGOM7fs4TYm0AI17PUrW1DGlICnis41Uoz3mguV
        7nCci8r+VXyyYNZxuONpZVr2ycRtdeZR50m/6L1FJBXxQXynQ/61GUIMWfL3oCpbVCDVxqBbvVB
        jv4IQd5gRtH1i530BJwyrhuQw
X-Received: by 2002:a05:600c:8a9:b0:380:da47:a911 with SMTP id l41-20020a05600c08a900b00380da47a911mr3486578wmp.102.1646307394068;
        Thu, 03 Mar 2022 03:36:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkY3wcB1FsTAbRKwZGCuD3BT8g671n6PuFj+8ohEeXAUUf1p9aViFyuknM0zgF+haLIUHGlA==
X-Received: by 2002:a05:600c:8a9:b0:380:da47:a911 with SMTP id l41-20020a05600c08a900b00380da47a911mr3486544wmp.102.1646307393777;
        Thu, 03 Mar 2022 03:36:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:3600:f39a:d830:baab:42f0? (p200300cbc7063600f39ad830baab42f0.dip0.t-ipconnect.de. [2003:cb:c706:3600:f39a:d830:baab:42f0])
        by smtp.gmail.com with ESMTPSA id s17-20020adfbc11000000b001f023d197b8sm1809424wrg.68.2022.03.03.03.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 03:36:33 -0800 (PST)
Message-ID: <5b0a9bac-cd00-35df-8e55-44624729015f@redhat.com>
Date:   Thu, 3 Mar 2022 12:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 02/10] crash hp: Introduce CRASH_HOTPLUG configuration
 options
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
 <f23efdc0-20c8-ccfd-f54d-69a9b4ee531f@redhat.com>
 <YiCW8gEb3n1CpI6x@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YiCW8gEb3n1CpI6x@MiWiFi-R3L-srv>
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

On 03.03.22 11:22, Baoquan He wrote:
> On 03/02/22 at 10:20am, David Hildenbrand wrote:
>> On 01.03.22 21:04, Eric DeVolder wrote:
>>>
>>>
>>> On 2/22/22 21:25, Baoquan He wrote:
>>>> On 02/09/22 at 02:56pm, Eric DeVolder wrote:
>>>>> Support for CPU and memory hotplug for crash is controlled by the
>>>>> CRASH_HOTPLUG configuration option, introduced by this patch.
>>>>>
>>>>> The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
>>>>> also introduced with this patch.
>>>>>
>>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>>>> ---
>>>>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>>>>>   1 file changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>>> index ebe8fc76949a..4e3374edab02 100644
>>>>> --- a/arch/x86/Kconfig
>>>>> +++ b/arch/x86/Kconfig
>>>>> @@ -2060,6 +2060,32 @@ config CRASH_DUMP
>>>>>   	  (CONFIG_RELOCATABLE=y).
>>>>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>>>>   
>>>>> +config CRASH_HOTPLUG
>>>>> +	bool "kernel updates of crash elfcorehdr"
>>>>> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
>>>>> +	help
>>>>> +	  Enable the kernel to update the crash elfcorehdr (which contains
>>>>> +	  the list of CPUs and memory regions) directly when hot plug/unplug
>>>>> +	  of CPUs or memory. Otherwise userspace must monitor these hot
>>>>> +	  plug/unplug change notifications via udev in order to
>>>>> +	  unload-then-reload the crash kernel so that the list of CPUs and
>>>>> +	  memory regions is kept up-to-date. Note that the udev CPU and
>>>>> +	  memory change notifications still occur (however, userspace is not
>>>>> +	  required to monitor for crash dump purposes).
>>>>> +
>>>>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>>>>> +	depends on CRASH_HOTPLUG
>>>>> +	int
>>>>> +	default 131072
>>>>> +	help
>>>>> +	  Specify the maximum size of the elfcorehdr buffer/segment.
>>>>> +	  The 128KiB default is sized so that it can accommodate 2048
>>>>> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
>>>>> +	  region of memory.
>>>>> +	  For example, this size can accommodate hotplugging a machine
>>>>> +	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
>>>>> +	  with 1024 1GiB memory DIMMs).
>>>>
>>>> This example of memory could be a little misleading. The memory regions
>>>> may not be related to memory DIMMs. System could split them into many
>>>> smaller regions during bootup.
>>>
>>> I changed "with 1024 1GiB memory DIMMs" to "with 1024 1GiB hotplug memories".
>>> eric
>>
>> It's still not quite precise. Essentially it's the individual "System
>> RAM" entries in /proc/iomem
>>
>> Boot memory (i.e., a single DIMM) might be represented by multiple
>> entries due to rearranged holes (by the BIOS).
>>
>> While hoplugged DIMMs (under virt!) are usually represented using a
>> single range, it can be different on physical machines. Last but not
>> least, dax/kmem and virtio-mem behave in a different way.
> 
> Right. How about only mentioning the 'System RAM' entries in /proc/iomem
> as below? It's just giving an example, talking about the details of
> memory regions from each type may not be necessry here. People
> interested can refer to code or document related to get it.
> 
> 
> + default 131072
> + help
> +   Specify the maximum size of the elfcorehdr buffer/segment.
> +   The 128KiB default is sized so that it can accommodate 2048
> +   Elf64_Phdr, where each Phdr represents either a CPU or a
> +   region of memory.
> +   For example, this size can accommodate hotplugging a machine
> +   with up to 1024 CPUs and up to 1024 memory regions which are
>     represented by 'System RAM' entries in /proc/iomem.

Maybe changing the last paragraph to:

"For example, this size can accommodate a machine with up to 1024 CPUs
and up to 1024 memory regions, for example, as represented by 'System
RAM' entries in /proc/iomem."


-- 
Thanks,

David / dhildenb

