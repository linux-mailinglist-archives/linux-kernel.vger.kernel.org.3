Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52104512ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbiD1FWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbiD1FWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:22:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566549CA4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:19:30 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S2DtW9028599;
        Thu, 28 Apr 2022 05:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BLwjNGa65MF+iAXscUucf285Y1YI1ZOt1gyoAWf2SDM=;
 b=Y6F9sfzvvDlq73Wmk9y99rTRzhNo8bVeBv7lvRdnABWWwYzsJztUAq3RzYRcpctJHUtr
 /fLfuzuemaxF5BUZjmCVZLHY7av7HXge+DdlrRQt6L4F047GSE22ahpvb8WjiUGCXG/m
 +DFbCPIYKaqGpwwNyS1lZoj6bB4ER9Dws+Qdx5jUXkg/ZaB6k/GI270pUeiG5WTLXKkS
 cS3aB21k3RqLO9gsHFwoPTDGk1K5jVkCNlCCZQ9TOW+tG8URGCIAJMl1KMBgVmSHxoj1
 fEOiaqWzjeJ5DrJAotT2xNHus3AiKVmdcFC7cblYhxyIOBaSYDTcgoBqaSgxXxls6A1O CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqhy2tqdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 05:19:03 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23S4vu37025160;
        Thu, 28 Apr 2022 05:19:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqhy2tqcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 05:19:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23S5Cuf5008651;
        Thu, 28 Apr 2022 05:19:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938xvys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 05:19:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23S5IvmG46137808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 05:18:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF1985204E;
        Thu, 28 Apr 2022 05:18:57 +0000 (GMT)
Received: from [9.43.12.144] (unknown [9.43.12.144])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 620B552052;
        Thu, 28 Apr 2022 05:18:51 +0000 (GMT)
Message-ID: <f2dbd4fe-6201-b5c4-2725-dec9c3dbf13e@linux.ibm.com>
Date:   Thu, 28 Apr 2022 10:48:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 4/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-5-eric.devolder@oracle.com>
 <YleK3J/4HNuFioIh@MiWiFi-R3L-srv>
 <4eea2373-32f3-9960-cbec-21dc1a428807@oracle.com>
 <6f3a6cbb-0ac4-f178-fc17-18f9594da319@linux.ibm.com>
 <YmeBjrChOHsIYG3e@MiWiFi-R3L-srv>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <YmeBjrChOHsIYG3e@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K9S0Cu_gs1reU2aIDMDwL-8zQBsKh0PP
X-Proofpoint-GUID: P6Y84sRNpSQ6v4vcUh7cMQR72Uucjzdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280031
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On 26/04/22 10:52, Baoquan He wrote:
> On 04/26/22 at 09:36am, Sourabh Jain wrote:
>> On 15/04/22 03:59, Eric DeVolder wrote:
>>> Hi Baoquan,
>>> Inline comments below.
>>> Thanks!
>>> eric
>>>
>>> On 4/13/22 21:45, Baoquan He wrote:
>>>> On 04/13/22 at 12:42pm, Eric DeVolder wrote:
>>>>> Upon CPU and memory changes, a generic crash_hotplug_handler()
>>>>> dispatches the hot plug/unplug event to the architecture specific
>>>>> arch_crash_hotplug_handler(). During the process, the kexec_mutex
>>>>> is held.
>>>>>
>>>>> To support cpu hotplug, a callback is registered to capture the
>>>>> CPUHP_AP_ONLINE_DYN online and ofline events via
>>>>> cpuhp_setup_state_nocalls().
>>>>>
>>>>> To support memory hotplug, a notifier is registered to capture the
>>>>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>>>>
>>>>> The cpu callback and memory notifier then call crash_hotplug_handler()
>>>>> to handle the hot plug/unplug event.
>>>>>
>>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>>>> ---
>>>>>    include/linux/kexec.h |  16 +++++++
>>>>>    kernel/crash_core.c   | 101
>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>    2 files changed, 117 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>>>> index f93f2591fc1e..02daff1f47dd 100644
>>>>> --- a/include/linux/kexec.h
>>>>> +++ b/include/linux/kexec.h
>>>>> @@ -306,6 +306,13 @@ struct kimage {
>>>>>          /* Information for loading purgatory */
>>>>>        struct purgatory_info purgatory_info;
>>>>> +
>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>> +    bool hotplug_event;
>>>>> +    unsigned int offlinecpu;
>>>>> +    bool elfcorehdr_index_valid;
>>>>> +    int elfcorehdr_index;
>>>>> +#endif
>>>>>    #endif
>>>>>      #ifdef CONFIG_IMA_KEXEC
>>>>> @@ -322,6 +329,15 @@ struct kimage {
>>>>>        unsigned long elf_load_addr;
>>>>>    };
>>>>>    +#ifdef CONFIG_CRASH_HOTPLUG
>>>>> +void arch_crash_hotplug_handler(struct kimage *image,
>>>>> +    unsigned int hp_action, unsigned int cpu);
>>>>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>>>>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>>>>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>>>>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>>>>> +#endif /* CONFIG_CRASH_HOTPLUG */
>>>>> +
>>>>>    /* kexec interface functions */
>>>>>    extern void machine_kexec(struct kimage *image);
>>>>>    extern int machine_kexec_prepare(struct kimage *image);
>>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>>> index 256cf6db573c..ecf746243ab2 100644
>>>>> --- a/kernel/crash_core.c
>>>>> +++ b/kernel/crash_core.c
>>>>> @@ -9,12 +9,17 @@
>>>>>    #include <linux/init.h>
>>>>>    #include <linux/utsname.h>
>>>>>    #include <linux/vmalloc.h>
>>>>> +#include <linux/highmem.h>
>>>>> +#include <linux/memory.h>
>>>>> +#include <linux/cpuhotplug.h>
>>>>>      #include <asm/page.h>
>>>>>    #include <asm/sections.h>
>>>>>      #include <crypto/sha1.h>
>>>>>    +#include "kexec_internal.h"
>>>>> +
>>>>>    /* vmcoreinfo stuff */
>>>>>    unsigned char *vmcoreinfo_data;
>>>>>    size_t vmcoreinfo_size;
>>>>> @@ -491,3 +496,99 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>>>    }
>>>>>      subsys_initcall(crash_save_vmcoreinfo_init);
>>>>> +
>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>> +void __weak arch_crash_hotplug_handler(struct kimage *image,
>>>>> +    unsigned int hp_action, unsigned int cpu)
>>>>> +{
>>>>> +    pr_warn("crash hp: %s not implemented", __func__);
>>>>> +}
>>>>> +
>>>>> +static void crash_hotplug_handler(unsigned int hp_action,
>>>>> +    unsigned int cpu)
>>>>> +{
>>>>> +    /* Obtain lock while changing crash information */
>>>>> +    if (!mutex_trylock(&kexec_mutex))
>>>>> +        return;
>>>>> +
>>>>> +    /* Check kdump is loaded */
>>>>> +    if (kexec_crash_image) {
>>>>> +        pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
>>>>> +
>>>>> +        /* Needed in order for the segments to be updated */
>>>>> +        arch_kexec_unprotect_crashkres();
>>>>> +
>>>>> +        /* Flag to differentiate between normal load and hotplug */
>>>>> +        kexec_crash_image->hotplug_event = true;
>>>>> +
>>>>> +        /* Now invoke arch-specific update handler */
>>>>> +        arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
>>>>> +
>>>>> +        /* No longer handling a hotplug event */
>>>>> +        kexec_crash_image->hotplug_event = false;
>>>>> +
>>>>> +        /* Change back to read-only */
>>>>> +        arch_kexec_protect_crashkres();
>>>>> +    }
>>>>> +
>>>>> +    /* Release lock now that update complete */
>>>>> +    mutex_unlock(&kexec_mutex);
>>>>> +}
>>>>> +
>>>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>>>> +static int crash_memhp_notifier(struct notifier_block *nb,
>>>>> +    unsigned long val, void *v)
>>>>> +{
>>>>> +    struct memory_notify *mhp = v;
>>>>> +
>>>>> +    switch (val) {
>>>>> +    case MEM_ONLINE:
>>>>> +        crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
>>>> We don't differentiate the memory add/remove, cpu add, except of cpu
>>>> remove. Means the hp_action only differentiate cpu remove from the other
>>>> action. Maybe only making two types?
>>>>
>>>> #define KEXEC_CRASH_HP_REMOVE_CPU   0
>>>> #define KEXEC_CRASH_HP_UPDATE_OTHER      1
>>>>
>>> Sourabh Jain's work with PPC uses REMOVE_CPU, REMOVE_MEMORY, and
>>> ADD_MEMORY.
>>> Do you still want to consolidate these?
>> On PowerPC different actions are needed for CPU add and memory add/remove.
>> For CPU add case only FDT is updated whereas for the memory hotplug we will
>> be
>> updating FDT and elfcorehdr.
> I don't understand. For elfcorehdr updating, we only need regenerate it.
> Do you update them different for memory add/remove?

We have different actions for cpu remove, CPU add and memory add/remove 
case.

CPU remove: no action
CPU add: update flattened device tree (FDT)
memory add/remove: update FDT and regenerate/update elfcorehdr

Since memory add/remove action is same we can have common hp_action for 
them.

>
> What I saw is the added action for memory hotplug is only for message
> printing. Is this really needed? And memory hotplug is even not
> supported. Please correct me if I missed anything.

I agree that currently memory hp_action is only used for printing 
warning message but
eventually we will be handling memory hotplug case as well.

> +       /* crash update on memory hotplug is not support yet */
> +       if (hp_action == KEXEC_CRASH_HP_REMOVE_MEMORY || hp_action == KEXEC_CRASH_HP_ADD_MEMORY) {
> +               pr_info_once("crash hp: crash update is not supported with memory hotplug\n");
> +               return;
> +       }

Thanks,
Sourabh Jain

