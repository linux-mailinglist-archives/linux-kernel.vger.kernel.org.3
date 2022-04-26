Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654A950EF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbiDZEKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiDZEKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:10:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EBA167C1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:07:47 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q2l3xL002390;
        Tue, 26 Apr 2022 04:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pqkWyecMge/6I1fcugoqtiWAmpA2pe5e8BJe8Y8A7MU=;
 b=Qd1blKFLRkaXk40q/h84T7y48l8/JaN1J6BXnwa8NnA2oFQLZ2pTYbhr7l30tYsx/SnW
 9be4t7dVHRFjSEIG06vC9gwGAMghT3zIxJuKoT8mvbCVIw6KUMK1hT8hV78vTYwb1kYS
 lCR7sBLiIqd6eyEWNdNdLOw7e8ZATIjYQBUzGCk85b2rb3qceGFk0hpFrUvIhy+sY+G9
 NVnv3sjuSXKCZWtqgPkrmT6b3szfVbzS0idY3ONzxdBj95C1AmpKjh+prz5nT8xiYboV
 SRuUjL+3vmtOH6Iz23dmEN+mzzID8pyvVJef1g35rnCk2mjONdaT2zxnpEvhF6h53R0P IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp88s12rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 04:07:11 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q3cvlq008103;
        Tue, 26 Apr 2022 04:07:11 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp88s12r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 04:07:11 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q42OIU026813;
        Tue, 26 Apr 2022 04:07:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938ubt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 04:07:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q476WE42139904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 04:07:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A386611C04C;
        Tue, 26 Apr 2022 04:07:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 528F011C050;
        Tue, 26 Apr 2022 04:07:01 +0000 (GMT)
Received: from [9.43.122.72] (unknown [9.43.122.72])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 04:07:01 +0000 (GMT)
Message-ID: <6f3a6cbb-0ac4-f178-fc17-18f9594da319@linux.ibm.com>
Date:   Tue, 26 Apr 2022 09:36:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 4/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
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
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <4eea2373-32f3-9960-cbec-21dc1a428807@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yQPamVVC4RE6RrNwhM9qjkASlwn2XiBg
X-Proofpoint-ORIG-GUID: Y0Wwda48UVdsG6dwkcfMdbHX9WI698L6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_01,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260024
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/04/22 03:59, Eric DeVolder wrote:
> Hi Baoquan,
> Inline comments below.
> Thanks!
> eric
>
> On 4/13/22 21:45, Baoquan He wrote:
>> On 04/13/22 at 12:42pm, Eric DeVolder wrote:
>>> Upon CPU and memory changes, a generic crash_hotplug_handler()
>>> dispatches the hot plug/unplug event to the architecture specific
>>> arch_crash_hotplug_handler(). During the process, the kexec_mutex
>>> is held.
>>>
>>> To support cpu hotplug, a callback is registered to capture the
>>> CPUHP_AP_ONLINE_DYN online and ofline events via
>>> cpuhp_setup_state_nocalls().
>>>
>>> To support memory hotplug, a notifier is registered to capture the
>>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>>
>>> The cpu callback and memory notifier then call crash_hotplug_handler()
>>> to handle the hot plug/unplug event.
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> ---
>>>   include/linux/kexec.h |  16 +++++++
>>>   kernel/crash_core.c   | 101 
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 117 insertions(+)
>>>
>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>> index f93f2591fc1e..02daff1f47dd 100644
>>> --- a/include/linux/kexec.h
>>> +++ b/include/linux/kexec.h
>>> @@ -306,6 +306,13 @@ struct kimage {
>>>         /* Information for loading purgatory */
>>>       struct purgatory_info purgatory_info;
>>> +
>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>> +    bool hotplug_event;
>>> +    unsigned int offlinecpu;
>>> +    bool elfcorehdr_index_valid;
>>> +    int elfcorehdr_index;
>>> +#endif
>>>   #endif
>>>     #ifdef CONFIG_IMA_KEXEC
>>> @@ -322,6 +329,15 @@ struct kimage {
>>>       unsigned long elf_load_addr;
>>>   };
>>>   +#ifdef CONFIG_CRASH_HOTPLUG
>>> +void arch_crash_hotplug_handler(struct kimage *image,
>>> +    unsigned int hp_action, unsigned int cpu);
>>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>>> +#endif /* CONFIG_CRASH_HOTPLUG */
>>> +
>>>   /* kexec interface functions */
>>>   extern void machine_kexec(struct kimage *image);
>>>   extern int machine_kexec_prepare(struct kimage *image);
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index 256cf6db573c..ecf746243ab2 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -9,12 +9,17 @@
>>>   #include <linux/init.h>
>>>   #include <linux/utsname.h>
>>>   #include <linux/vmalloc.h>
>>> +#include <linux/highmem.h>
>>> +#include <linux/memory.h>
>>> +#include <linux/cpuhotplug.h>
>>>     #include <asm/page.h>
>>>   #include <asm/sections.h>
>>>     #include <crypto/sha1.h>
>>>   +#include "kexec_internal.h"
>>> +
>>>   /* vmcoreinfo stuff */
>>>   unsigned char *vmcoreinfo_data;
>>>   size_t vmcoreinfo_size;
>>> @@ -491,3 +496,99 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>   }
>>>     subsys_initcall(crash_save_vmcoreinfo_init);
>>> +
>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>> +void __weak arch_crash_hotplug_handler(struct kimage *image,
>>> +    unsigned int hp_action, unsigned int cpu)
>>> +{
>>> +    pr_warn("crash hp: %s not implemented", __func__);
>>> +}
>>> +
>>> +static void crash_hotplug_handler(unsigned int hp_action,
>>> +    unsigned int cpu)
>>> +{
>>> +    /* Obtain lock while changing crash information */
>>> +    if (!mutex_trylock(&kexec_mutex))
>>> +        return;
>>> +
>>> +    /* Check kdump is loaded */
>>> +    if (kexec_crash_image) {
>>> +        pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
>>> +
>>> +        /* Needed in order for the segments to be updated */
>>> +        arch_kexec_unprotect_crashkres();
>>> +
>>> +        /* Flag to differentiate between normal load and hotplug */
>>> +        kexec_crash_image->hotplug_event = true;
>>> +
>>> +        /* Now invoke arch-specific update handler */
>>> +        arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
>>> +
>>> +        /* No longer handling a hotplug event */
>>> +        kexec_crash_image->hotplug_event = false;
>>> +
>>> +        /* Change back to read-only */
>>> +        arch_kexec_protect_crashkres();
>>> +    }
>>> +
>>> +    /* Release lock now that update complete */
>>> +    mutex_unlock(&kexec_mutex);
>>> +}
>>> +
>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>> +static int crash_memhp_notifier(struct notifier_block *nb,
>>> +    unsigned long val, void *v)
>>> +{
>>> +    struct memory_notify *mhp = v;
>>> +
>>> +    switch (val) {
>>> +    case MEM_ONLINE:
>>> +        crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
>> We don't differentiate the memory add/remove, cpu add, except of cpu
>> remove. Means the hp_action only differentiate cpu remove from the other
>> action. Maybe only making two types?
>>
>> #define KEXEC_CRASH_HP_REMOVE_CPU   0
>> #define KEXEC_CRASH_HP_UPDATE_OTHER      1
>>
> Sourabh Jain's work with PPC uses REMOVE_CPU, REMOVE_MEMORY, and 
> ADD_MEMORY.
> Do you still want to consolidate these?

On PowerPC different actions are needed for CPU add and memory add/remove.
For CPU add case only FDT is updated whereas for the memory hotplug we 
will be
updating FDT and elfcorehdr.

Ideally, I would prefer the crash hotplug handler to report all four 
actions separately.

Thanks,
Sourabh Jain

