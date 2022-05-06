Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEAD51D207
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389433AbiEFHRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiEFHQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:16:59 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E6EB66C9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651821197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wF7V0cy+5NmHtlR+AevB2EM+3Bo1396k7w5TO77QWRY=;
        b=HYU4gGoOlVW7WvBiTbGkOcNOMSZYfy4zqnabjKUKXBER4tEWsPhNq/r9kiJqkPG3tKQz7T
        Q17Ub9Od2AsWeDPjzQO0RtFzc/+ObnyQaKgaGTG5ZsetbAN1R+bXzrtLJtkUL5I4WKSOYm
        KeJjkfs+DZ0KzE+20M5EOw4gsxDvbIc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-5poZo9rePxGItojSckpQ4A-1; Fri, 06 May 2022 03:13:11 -0400
X-MC-Unique: 5poZo9rePxGItojSckpQ4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 355EB2999B44;
        Fri,  6 May 2022 07:13:10 +0000 (UTC)
Received: from localhost (ovpn-13-105.pek2.redhat.com [10.72.13.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9DCC111E3FD;
        Fri,  6 May 2022 07:12:53 +0000 (UTC)
Date:   Fri, 6 May 2022 15:12:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <YnTKcvkCoRBxqGSW@MiWiFi-R3L-srv>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505184603.1548-4-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/22 at 02:45pm, Eric DeVolder wrote:
......
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573c..f197af50def6 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -9,12 +9,17 @@
>  #include <linux/init.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/highmem.h>

Wondering where highmem.h is needed. Just curious.

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
> @@ -491,3 +496,90 @@ static int __init crash_save_vmcoreinfo_init(void)
>  }
>  
>  subsys_initcall(crash_save_vmcoreinfo_init);
> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
> +							unsigned int hp_action, unsigned int cpu)
> +{
> +	WARN(1, "crash hotplug handler not implemented");
> +}
> +
> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	if (!mutex_trylock(&kexec_mutex))
> +		return;
> +
> +	/* Check kdump is loaded */
> +	if (kexec_crash_image) {
> +		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
> +
> +		/* Needed in order for the segments to be updated */
> +		arch_kexec_unprotect_crashkres();
> +
> +		/* Flag to differentiate between normal load and hotplug */
> +		kexec_crash_image->hotplug_event = true;
> +
> +		/* Now invoke arch-specific update handler */
> +		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
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
> +									"crash/cpuhp",
> +									crash_cpuhp_online,
> +									crash_cpuhp_offline);
> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif
> -- 
> 2.27.0
> 

