Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53364C0AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 05:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiBWEAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 23:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiBWEAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 23:00:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71A285D19B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 20:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645588809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cZg/zOsjS1zgxZzshOQCrxDaITSJ0qnWWjX9sbQEFec=;
        b=WeG2UwzBNxErOE2AOqookx2RWR6QQ4WiN/UFUeP0x0mZlswR7jua6GwFbNcvaZ1OQcWUc4
        WAo0ZBkMh0vHdPUY+tINl6dYbyh6LC/eMK/24Z30VzJxCVhwUf/s2fPZ5FWgqPHGVoohbL
        y4moIPYScLb1wKjsekDrlltbPGxGaJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-GclCn2EeO2q5o9pGQDTEZA-1; Tue, 22 Feb 2022 23:00:02 -0500
X-MC-Unique: GclCn2EeO2q5o9pGQDTEZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C46101006AA6;
        Wed, 23 Feb 2022 04:00:00 +0000 (UTC)
Received: from localhost (ovpn-14-1.pek2.redhat.com [10.72.14.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E6FF4D702;
        Wed, 23 Feb 2022 03:59:56 +0000 (UTC)
Date:   Wed, 23 Feb 2022 11:59:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 06/10] crash hp: generic crash hotplug support
 infrastructure
Message-ID: <YhWxOoB3n2O2vLHB@MiWiFi-R3L-srv>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-7-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209195706.51522-7-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/22 at 02:57pm, Eric DeVolder wrote:
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

This looks good to me. As I commented in patch 3, these both may need be
merged.

> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  kernel/crash_core.c | 104 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 0ff06d0698ad..524470e18883 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -10,12 +10,16 @@
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
>  #include <linux/highmem.h>
> +#include <linux/memory.h>
> +#include <linux/cpuhotplug.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
>  
>  #include <crypto/sha1.h>
>  
> +#include "kexec_internal.h"
> +
>  /* vmcoreinfo stuff */
>  unsigned char *vmcoreinfo_data;
>  size_t vmcoreinfo_size;
> @@ -521,5 +525,105 @@ void unmap_crash_pages(void **ptr)
>  		*ptr = NULL;
>  	}
>  }
> +
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
>  #endif
>  
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
> -- 
> 2.27.0
> 

