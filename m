Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598984D9ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348149AbiCOMK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiCOMK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:10:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E993BBCE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:09:46 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FAKfTs010772;
        Tue, 15 Mar 2022 12:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=prVp28oCNxqVSREfWeVKcv7z+iedvcFZh+u5OAc+nGs=;
 b=osORYwzjGPrHTlYiCXme4TucBQkquAOqLGf+oEsr4+QsjLJku1tnAkXYUK9Zbew8SKih
 cD9wNWakXRFAl6y/qoSkMiRQz7Xpo3jx3LMR2IQFpwxzBCesI6JlHBMdeZsvotX0l866
 7mXnmcFN7jdoAqIoj+LZyom+ycsBuJcC11l/H66Oz4Lqr4yQKXfCeJQveyWL6oPgBxoL
 qB2UJoHoSTr0Fust19q4S92bCapIyNeRC/GmUmybLWNOdWj+sra+vVYJ2Al0J1DEr3BG
 I7kLQ+l1R9UH5VL8dx93iQJmWpEfKHwXU6LgQxCcmI2ncoTDtkTMQDHTdunxJFMlbnIy Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3etryc23py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 12:08:59 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22FBsj8I026340;
        Tue, 15 Mar 2022 12:08:59 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3etryc23ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 12:08:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FC8qSN017516;
        Tue, 15 Mar 2022 12:08:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3et95wsvg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 12:08:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22FC8rcA26149220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 12:08:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D1ACA405F;
        Tue, 15 Mar 2022 12:08:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A5EBA405B;
        Tue, 15 Mar 2022 12:08:47 +0000 (GMT)
Received: from [9.43.40.45] (unknown [9.43.40.45])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Mar 2022 12:08:46 +0000 (GMT)
Message-ID: <1b7405e4-e6a3-56ff-5068-d598ba2f2b5e@linux.ibm.com>
Date:   Tue, 15 Mar 2022 17:38:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 4/8] crash: generic crash hotplug support
 infrastructure
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20220303162725.49640-5-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IeVMryGTMrff56T19k44G7LN0GqvcBkW
X-Proofpoint-ORIG-GUID: 068Nbwh6G68tSfx_ILUsXu2OHoZIf9FP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_02,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 03/03/22 21:57, Eric DeVolder wrote:
> This patch introduces a generic crash hot plug/unplug infrastructure
> for CPU and memory changes. Upon CPU and memory changes, a generic
> crash_hotplug_handler() obtains the appropriate lock, does some
> important house keeping and then dispatches the hot plug/unplug event
> to the architecture specific arch_crash_hotplug_handler(), and when
> that handler returns, the lock is released.
>
> This patch modifies crash_core.c to implement a subsys_initcall()
> function that installs handlers for hot plug/unplug events. If CPU
> hotplug is enabled, then cpuhp_setup_state() is invoked to register a
> handler for CPU changes. Similarly, if memory hotplug is enabled, then
> register_memory_notifier() is invoked to install a handler for memory
> changes. These handlers in turn invoke the common generic handler
> crash_hotplug_handler().
>
> On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
> the CPU still shows up in foreach_present_cpu() during the regeneration
> of the new CPU list, thus the need to explicitly check and exclude the
> soon-to-be offlined CPU in crash_prepare_elf64_headers().
>
> On the memory side, each un/plugged memory block passes through the
> handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
> memory events, one for each 128MiB memblock.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   include/linux/kexec.h |  16 +++++++
>   kernel/crash_core.c   | 108 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 124 insertions(+)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index d7b59248441b..b11d75a6b2bc 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -300,6 +300,13 @@ struct kimage {
>   
>   	/* Information for loading purgatory */
>   	struct purgatory_info purgatory_info;
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	bool hotplug_event;
> +	int offlinecpu;
> +	bool elf_index_valid;
> +	int elf_index;

How about keeping an array to track all kexec segment index need to be 
updated in
crash hotplug handler.

struct hp_segment {
    name;
    index;
    is_valid;
  }

It will be helpful if architecture need to updated multiple kexec 
segments  for a hotplug event.

For example, on PowerPC, we might need to update FDT and elfcorehdr on 
memory hot plug/unplug.

Thanks,
Sourabh Jain


> +#endif
>   #endif
>   
>   #ifdef CONFIG_IMA_KEXEC
> @@ -316,6 +323,15 @@ struct kimage {
>   	unsigned long elf_load_addr;
>   };
>   
> +#ifdef CONFIG_CRASH_HOTPLUG
> +void arch_crash_hotplug_handler(struct kimage *image,
> +	unsigned int hp_action, unsigned long a, unsigned long b);
> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
> +#define KEXEC_CRASH_HP_ADD_CPU      1
> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
> +#endif /* CONFIG_CRASH_HOTPLUG */
> +
>   /* kexec interface functions */
>   extern void machine_kexec(struct kimage *image);
>   extern int machine_kexec_prepare(struct kimage *image);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573c..76959d440f71 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -9,12 +9,17 @@
>   #include <linux/init.h>
>   #include <linux/utsname.h>
>   #include <linux/vmalloc.h>
> +#include <linux/highmem.h>
> +#include <linux/memory.h>
> +#include <linux/cpuhotplug.h>
>   
>   #include <asm/page.h>
>   #include <asm/sections.h>
>   
>   #include <crypto/sha1.h>
>   
> +#include "kexec_internal.h"
> +
>   /* vmcoreinfo stuff */
>   unsigned char *vmcoreinfo_data;
>   size_t vmcoreinfo_size;
> @@ -491,3 +496,106 @@ static int __init crash_save_vmcoreinfo_init(void)
>   }
>   
>   subsys_initcall(crash_save_vmcoreinfo_init);
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +void __weak arch_crash_hotplug_handler(struct kimage *image,
> +	unsigned int hp_action, unsigned long a, unsigned long b)
> +{
> +	pr_warn("crash hp: %s not implemented", __func__);
> +}
> +
> +static void crash_hotplug_handler(unsigned int hp_action,
> +	unsigned long a, unsigned long b)
> +{
> +	/* Obtain lock while changing crash information */
> +	if (!mutex_trylock(&kexec_mutex))
> +		return;
> +
> +	/* Check kdump is loaded */
> +	if (kexec_crash_image) {
> +		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
> +			a, b);
> +
> +		/* Needed in order for the segments to be updated */
> +		arch_kexec_unprotect_crashkres();
> +
> +		/* Flag to differentiate between normal load and hotplug */
> +		kexec_crash_image->hotplug_event = true;
> +
> +		/* Now invoke arch-specific update handler */
> +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
> +
> +		/* No longer handling a hotplug event */
> +		kexec_crash_image->hotplug_event = false;
> +
> +		/* Change back to read-only */
> +		arch_kexec_protect_crashkres();
> +	}
> +
> +	/* Release lock now that update complete */
> +	mutex_unlock(&kexec_mutex);
> +}
> +
> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +static int crash_memhp_notifier(struct notifier_block *nb,
> +	unsigned long val, void *v)
> +{
> +	struct memory_notify *mhp = v;
> +	unsigned long start, end;
> +
> +	start = mhp->start_pfn << PAGE_SHIFT;
> +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
> +
> +	switch (val) {
> +	case MEM_ONLINE:
> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
> +			start, end-start);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
> +			start, end-start);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block crash_memhp_nb = {
> +	.notifier_call = crash_memhp_notifier,
> +	.priority = 0
> +};
> +#endif
> +
> +#if defined(CONFIG_HOTPLUG_CPU)
> +static int crash_cpuhp_online(unsigned int cpu)
> +{
> +	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
> +	return 0;
> +}
> +
> +static int crash_cpuhp_offline(unsigned int cpu)
> +{
> +	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
> +	return 0;
> +}
> +#endif
> +
> +static int __init crash_hotplug_init(void)
> +{
> +	int result = 0;
> +
> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +	register_memory_notifier(&crash_memhp_nb);
> +#endif
> +
> +#if defined(CONFIG_HOTPLUG_CPU)
> +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +				"crash/cpuhp",
> +				crash_cpuhp_online, crash_cpuhp_offline);
> +#endif
> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif /* CONFIG_CRASH_HOTPLUG */
