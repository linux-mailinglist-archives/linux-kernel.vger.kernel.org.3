Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE404E654C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347643AbiCXOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351233AbiCXOfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51CCF9F3BA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648132390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uz406a5kGDv/VDVK5JX7oOinepQMkPu5YbTVYOJzd5o=;
        b=H31eiXa1vNmv9MuiJybfRYsxe1QlMTF6kDx4ijgWBf2T00WI7TE1ptGmVw9n6dOExPdDyI
        A2+IlQrHDiAH5a6YIVJ4krdkfRPWjKZIV8yTBti+v1S6G70bJNkk3e77lCecAHGJlFe+/a
        fHvrHuHBnlSuv6N64b27CyhuPDSlVNQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-fwzimZlrNg-y3odw3Q2how-1; Thu, 24 Mar 2022 10:33:06 -0400
X-MC-Unique: fwzimZlrNg-y3odw3Q2how-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E87118E52C0;
        Thu, 24 Mar 2022 14:33:05 +0000 (UTC)
Received: from localhost (ovpn-13-106.pek2.redhat.com [10.72.13.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEDE940D296B;
        Thu, 24 Mar 2022 14:33:03 +0000 (UTC)
Date:   Thu, 24 Mar 2022 22:33:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v5 4/8] crash: generic crash hotplug support
 infrastructure
Message-ID: <20220324143300.GD354864@MiWiFi-R3L-srv>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
 <20220324133856.GC354864@MiWiFi-R3L-srv>
 <20220324134911.GA354791@MiWiFi-R3L-srv>
 <d12cd750-4f7e-46e8-8f31-66e29edbede9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d12cd750-4f7e-46e8-8f31-66e29edbede9@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24/22 at 08:53am, Eric DeVolder wrote:
> Baoquan,
> Thanks, I've offered a minor correction below.
> eric
> 
> On 3/24/22 08:49, Baoquan He wrote:
> > On 03/24/22 at 09:38pm, Baoquan He wrote:
> > > On 03/03/22 at 11:27am, Eric DeVolder wrote:
> > > > This patch introduces a generic crash hot plug/unplug infrastructure
> > > > for CPU and memory changes. Upon CPU and memory changes, a generic
> > > > crash_hotplug_handler() obtains the appropriate lock, does some
> > > > important house keeping and then dispatches the hot plug/unplug event
> > > > to the architecture specific arch_crash_hotplug_handler(), and when
> > > > that handler returns, the lock is released.
> > > > 
> > > > This patch modifies crash_core.c to implement a subsys_initcall()
> > > > function that installs handlers for hot plug/unplug events. If CPU
> > > > hotplug is enabled, then cpuhp_setup_state() is invoked to register a
> > > > handler for CPU changes. Similarly, if memory hotplug is enabled, then
> > > > register_memory_notifier() is invoked to install a handler for memory
> > > > changes. These handlers in turn invoke the common generic handler
> > > > crash_hotplug_handler().
> > > > 
> > > > On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
> > > > CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
> > > > the CPU still shows up in foreach_present_cpu() during the regeneration
> > > > of the new CPU list, thus the need to explicitly check and exclude the
> > > > soon-to-be offlined CPU in crash_prepare_elf64_headers().
> > > > 
> > > > On the memory side, each un/plugged memory block passes through the
> > > > handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
> > > > memory events, one for each 128MiB memblock.
> > > 
> > > I rewrite the log as below with my understanding. Hope it's simpler to
> > > help people get what's going on here. Please consider to take if it's
> > > OK to you or adjust based on this. The code looks good to me.
> > > 
> > Made some tuning:
> > 
> > crash: add generic infrastructure for crash hotplug support
> > 
> > Upon CPU and memory changes, a generic crash_hotplug_handler() is added
> > to dispatch the hot plug/unplug event to the architecture specific
> > arch_crash_hotplug_handler(). During the process, kexec_mutex need be
> > held.
> > 
> > To support cpu hotplug, one callback pair are registered to capture
> > KEXEC_CRASH_HP_ADD_CPU and KEXEC_CRASH_HP_REMOVE_CPU events via
> > cpuhp_setup_state_nocalls().
> s/KEXEC_CRASH_HP_ADD}REMOVE_CPU/CPUHP_AP_ONLINE_DYN/ as the KEXEC_CRASH are the
> names I've introduced with this patch?

Right.

While checking it, I notice hp_action which you don't use actually.
Can you reconsider that part of design, the hp_action, the a, b
parameter passed to handler?

> 
> > 
> > To support memory hotplug, a notifier crash_memhp_nb is registered to
> > memory_chain to watch MEM_ONLINE and MEM_OFFLINE events.
> > 
> > These callbacks and notifier will call crash_hotplug_handler() to handle
> > captured event when invoked.
> > 
> > > 
> > > > 
> > > > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> > > > ---
> > > >   include/linux/kexec.h |  16 +++++++
> > > >   kernel/crash_core.c   | 108 ++++++++++++++++++++++++++++++++++++++++++
> > > >   2 files changed, 124 insertions(+)
> > > > 
> > > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > > index d7b59248441b..b11d75a6b2bc 100644
> > > > --- a/include/linux/kexec.h
> > > > +++ b/include/linux/kexec.h
> > > > @@ -300,6 +300,13 @@ struct kimage {
> > > >   	/* Information for loading purgatory */
> > > >   	struct purgatory_info purgatory_info;
> > > > +
> > > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > > +	bool hotplug_event;
> > > > +	int offlinecpu;
> > > > +	bool elf_index_valid;
> > > > +	int elf_index;
> > > > +#endif
> > > >   #endif
> > > >   #ifdef CONFIG_IMA_KEXEC
> > > > @@ -316,6 +323,15 @@ struct kimage {
> > > >   	unsigned long elf_load_addr;
> > > >   };
> > > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > > +void arch_crash_hotplug_handler(struct kimage *image,
> > > > +	unsigned int hp_action, unsigned long a, unsigned long b);
> > > > +#define KEXEC_CRASH_HP_REMOVE_CPU   0
> > > > +#define KEXEC_CRASH_HP_ADD_CPU      1
> > > > +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
> > > > +#define KEXEC_CRASH_HP_ADD_MEMORY   3
> > > > +#endif /* CONFIG_CRASH_HOTPLUG */
> > > > +
> > > >   /* kexec interface functions */
> > > >   extern void machine_kexec(struct kimage *image);
> > > >   extern int machine_kexec_prepare(struct kimage *image);
> > > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > > index 256cf6db573c..76959d440f71 100644
> > > > --- a/kernel/crash_core.c
> > > > +++ b/kernel/crash_core.c
> > > > @@ -9,12 +9,17 @@
> > > >   #include <linux/init.h>
> > > >   #include <linux/utsname.h>
> > > >   #include <linux/vmalloc.h>
> > > > +#include <linux/highmem.h>
> > > > +#include <linux/memory.h>
> > > > +#include <linux/cpuhotplug.h>
> > > >   #include <asm/page.h>
> > > >   #include <asm/sections.h>
> > > >   #include <crypto/sha1.h>
> > > > +#include "kexec_internal.h"
> > > > +
> > > >   /* vmcoreinfo stuff */
> > > >   unsigned char *vmcoreinfo_data;
> > > >   size_t vmcoreinfo_size;
> > > > @@ -491,3 +496,106 @@ static int __init crash_save_vmcoreinfo_init(void)
> > > >   }
> > > >   subsys_initcall(crash_save_vmcoreinfo_init);
> > > > +
> > > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > > +void __weak arch_crash_hotplug_handler(struct kimage *image,
> > > > +	unsigned int hp_action, unsigned long a, unsigned long b)
> > > > +{
> > > > +	pr_warn("crash hp: %s not implemented", __func__);
> > > > +}
> > > > +
> > > > +static void crash_hotplug_handler(unsigned int hp_action,
> > > > +	unsigned long a, unsigned long b)
> > > > +{
> > > > +	/* Obtain lock while changing crash information */
> > > > +	if (!mutex_trylock(&kexec_mutex))
> > > > +		return;
> > > > +
> > > > +	/* Check kdump is loaded */
> > > > +	if (kexec_crash_image) {
> > > > +		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
> > > > +			a, b);
> > > > +
> > > > +		/* Needed in order for the segments to be updated */
> > > > +		arch_kexec_unprotect_crashkres();
> > > > +
> > > > +		/* Flag to differentiate between normal load and hotplug */
> > > > +		kexec_crash_image->hotplug_event = true;
> > > > +
> > > > +		/* Now invoke arch-specific update handler */
> > > > +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
> > > > +
> > > > +		/* No longer handling a hotplug event */
> > > > +		kexec_crash_image->hotplug_event = false;
> > > > +
> > > > +		/* Change back to read-only */
> > > > +		arch_kexec_protect_crashkres();
> > > > +	}
> > > > +
> > > > +	/* Release lock now that update complete */
> > > > +	mutex_unlock(&kexec_mutex);
> > > > +}
> > > > +
> > > > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > > > +static int crash_memhp_notifier(struct notifier_block *nb,
> > > > +	unsigned long val, void *v)
> > > > +{
> > > > +	struct memory_notify *mhp = v;
> > > > +	unsigned long start, end;
> > > > +
> > > > +	start = mhp->start_pfn << PAGE_SHIFT;
> > > > +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
> > > > +
> > > > +	switch (val) {
> > > > +	case MEM_ONLINE:
> > > > +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
> > > > +			start, end-start);
> > > > +		break;
> > > > +
> > > > +	case MEM_OFFLINE:
> > > > +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
> > > > +			start, end-start);
> > > > +		break;
> > > > +	}
> > > > +	return NOTIFY_OK;
> > > > +}
> > > > +
> > > > +static struct notifier_block crash_memhp_nb = {
> > > > +	.notifier_call = crash_memhp_notifier,
> > > > +	.priority = 0
> > > > +};
> > > > +#endif
> > > > +
> > > > +#if defined(CONFIG_HOTPLUG_CPU)
> > > > +static int crash_cpuhp_online(unsigned int cpu)
> > > > +{
> > > > +	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int crash_cpuhp_offline(unsigned int cpu)
> > > > +{
> > > > +	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
> > > > +	return 0;
> > > > +}
> > > > +#endif
> > > > +
> > > > +static int __init crash_hotplug_init(void)
> > > > +{
> > > > +	int result = 0;
> > > > +
> > > > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > > > +	register_memory_notifier(&crash_memhp_nb);
> > > > +#endif
> > > > +
> > > > +#if defined(CONFIG_HOTPLUG_CPU)
> > > > +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> > > > +				"crash/cpuhp",
> > > > +				crash_cpuhp_online, crash_cpuhp_offline);
> > > > +#endif
> > > > +
> > > > +	return result;
> > > > +}
> > > > +
> > > > +subsys_initcall(crash_hotplug_init);
> > > > +#endif /* CONFIG_CRASH_HOTPLUG */
> > > > -- 
> > > > 2.27.0
> > > > 
> > > 
> > 
> 

