Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80125A7470
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiHaD0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiHaD0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880BD85FC5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661916399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kELsNQInWQRbaN2n5gtMbiLypzFZyTW3G6NHOnHK/mc=;
        b=FaOy69Q9k8u6bmShnDE4mjauuj5PYiRnq79NoqACrRRNeAU0exjpOdYPitEUPXAI5KP+gA
        Jy1E0qJMV8QE8Vc98DfJmXYYLcCzZEoFUnlyJV/vz1dCJXHVlwzRafihVROfSBLMPi2vpw
        b9zJEHVtenGy2koOQ3wE6LPnuuoxDGQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-eorvqPp0NOKWNOAsWYuzAg-1; Tue, 30 Aug 2022 23:26:36 -0400
X-MC-Unique: eorvqPp0NOKWNOAsWYuzAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E62785A585;
        Wed, 31 Aug 2022 03:26:35 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F09B2166B2A;
        Wed, 31 Aug 2022 03:26:34 +0000 (UTC)
Date:   Wed, 31 Aug 2022 11:26:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v11 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Yw7U5jYKcwZ+cMpu@MiWiFi-R3L-srv>
References: <20220826173704.1895-1-eric.devolder@oracle.com>
 <20220826173704.1895-4-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826173704.1895-4-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/26/22 at 01:37pm, Eric DeVolder wrote:
> CPU and memory change notifications are received in order to
> regenerate the elfcorehdr.
> 
> To support cpu hotplug, a callback is registered to capture the
> CPUHP_AP_ONLINE_DYN online and offline events via
> cpuhp_setup_state_nocalls().
> 
> To support memory hotplug, a notifier is registered to capture the
> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
> 
> The cpu callback and memory notifiers call handle_hotplug_event()
> which performs needed tasks and then dispatches the event to the
> architecture specific arch_crash_handle_hotplug_event(). During the
> process, the kexec_mutex is held.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  include/linux/crash_core.h |   8 +++
>  include/linux/kexec.h      |  26 +++++++
>  kernel/crash_core.c        | 134 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 168 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..3b99e69b011f 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
>  
> +#define KEXEC_CRASH_HP_REMOVE_CPU		0
> +#define KEXEC_CRASH_HP_ADD_CPU			1
> +#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
                                        ~~
                                        Nitpick, These arenot aligned, 
> +#define KEXEC_CRASH_HP_ADD_MEMORY		3
> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
> +
> +struct kimage;
> +
>  #endif /* LINUX_CRASH_CORE_H */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 4eefa631e0ae..9597b41136ec 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -374,6 +374,13 @@ struct kimage {
>  	struct purgatory_info purgatory_info;
>  #endif
>  
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +	bool hotplug_event;
> +	unsigned int offlinecpu;
> +	bool elfcorehdr_index_valid;
> +	int elfcorehdr_index;
> +#endif
> +
>  #ifdef CONFIG_IMA_KEXEC
>  	/* Virtual address of IMA measurement buffer for kexec syscall */
>  	void *ima_buffer;
> @@ -503,6 +510,25 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>  static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>  #endif
>  
> +#ifndef arch_map_crash_pages
> +static inline void *arch_map_crash_pages(unsigned long paddr,
> +		unsigned long size)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +#ifndef arch_unmap_crash_pages
> +static inline void arch_unmap_crash_pages(void **ptr) { }
> +#endif
> +
> +#ifndef arch_crash_handle_hotplug_event
> +static inline void arch_crash_handle_hotplug_event(struct kimage *image,
> +		unsigned int hp_action)
> +{
> +}
> +#endif
> +
>  #else /* !CONFIG_KEXEC_CORE */
>  struct pt_regs;
>  struct task_struct;
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 0f8aa659cca4..455150205ded 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -11,6 +11,8 @@
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
>  #include <linux/kexec.h>
> +#include <linux/memory.h>
> +#include <linux/cpuhotplug.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -18,6 +20,7 @@
>  #include <crypto/sha1.h>
>  
>  #include "kallsyms_internal.h"
> +#include "kexec_internal.h"
>  
>  /* vmcoreinfo stuff */
>  unsigned char *vmcoreinfo_data;
> @@ -611,3 +614,134 @@ static int __init crash_save_vmcoreinfo_init(void)
>  }
>  
>  subsys_initcall(crash_save_vmcoreinfo_init);
> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +/*
> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
> + * is passed to the crash kernel via the elfcorehdr= parameter)
> + * must be updated with the new list of CPUs and memories.
> + *
> + * In order to make changes to elfcorehdr, two conditions are needed:
> + * First, the segment containing the elfcorehdr must be large enough
> + * to permit a growing number of resources. The elfcorehdr memory is
> + * typically based on CONFIG_NR_CPUS and CONFIG_CRASH_MAX_MEMORY_RANGES.
> + * Second, purgatory must explicitly exclude the elfcorehdr from the
> + * list of segments it checks (since the elfcorehdr changes and thus
> + * would require an update to purgatory itself to update the digest).
> + */
> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	mutex_lock(&kexec_mutex);
> +
> +	/* Check kdump is loaded */
> +	if (kexec_crash_image) {
> +		struct kimage *image = kexec_crash_image;
> +
> +		if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> +			hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +			pr_debug("crash hp: hp_action %u, cpu %u\n", hp_action, cpu);
> +		else
> +			pr_debug("crash hp: hp_action %u", hp_action);
                                                       ^~ "\n" missed
> +		/*
> +		 * When the struct kimage is alloced, it is wiped to zero, so
                                             ~~~~ alloced is confusing, s/alloced/allocated/
                                            We can accept alloc being used, alloced is a little weird.
> +		 * the elfcorehdr_index_valid defaults to false. Find the
> +		 * segment containing the elfcorehdr, if not already found.
> +		 * This works for both the kexec_load and kexec_file_load paths.
> +		 */
> +		if (!image->elfcorehdr_index_valid) {
> +			unsigned char *ptr;
> +			unsigned long mem, memsz;
> +			unsigned int n;
> +
> +			for (n = 0; n < image->nr_segments; n++) {
> +				mem = image->segment[n].mem;
> +				memsz = image->segment[n].memsz;
> +				ptr = arch_map_crash_pages(mem, memsz);
OK, I see. You want to avoid the over 80 chars line, so introducing
two local variables. We may be able to tolerate that in this case. No
strong opinion, let's see if other people have concern about it.

Other than these nitpicks, this patch looks good to me.
Acked-by: Baoquan He <bhe@redhat.com>

> +				if (ptr) {
> +					/* The segment containing elfcorehdr */
> +					if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> +						image->elfcorehdr_index = (int)n;
> +						image->elfcorehdr_index_valid = true;
> +					}
> +				}
> +				arch_unmap_crash_pages((void **)&ptr);
> +			}
> +		}
> +
> +		if (!image->elfcorehdr_index_valid) {
> +			pr_err("crash hp: unable to locate elfcorehdr segment");
> +			goto out;
> +		}
> +
> +		/* Needed in order for the segments to be updated */
> +		arch_kexec_unprotect_crashkres();
> +
> +		/* Flag to differentiate between normal load and hotplug */
> +		image->hotplug_event = true;
> +
> +		/* Now invoke arch-specific update handler */
> +		arch_crash_handle_hotplug_event(image, hp_action);
> +
> +		/* No longer handling a hotplug event */
> +		image->hotplug_event = false;
> +
> +		/* Change back to read-only */
> +		arch_kexec_protect_crashkres();
> +	}
> +
> +out:
> +	/* Release lock now that update complete */
> +	mutex_unlock(&kexec_mutex);
> +}
> +
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> +{
> +	switch (val) {
> +	case MEM_ONLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block crash_memhp_nb = {
> +	.notifier_call = crash_memhp_notifier,
> +	.priority = 0
> +};
> +
> +static int crash_cpuhp_online(unsigned int cpu)
> +{
> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	return 0;
> +}
> +
> +static int crash_cpuhp_offline(unsigned int cpu)
> +{
> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
> +	return 0;
> +}
> +
> +static int __init crash_hotplug_init(void)
> +{
> +	int result = 0;
> +
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		register_memory_notifier(&crash_memhp_nb);
> +
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +						   "crash/cpuhp",
> +						   crash_cpuhp_online,
> +						   crash_cpuhp_offline);
> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif
> -- 
> 2.31.1
> 

