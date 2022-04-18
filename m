Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF683504B43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiDRDUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiDRDUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 323BC18352
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 20:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650251889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGhAlcxii7QqMRje2u/QDFqEFvc6pyhs2TfDi3CMnFk=;
        b=F97xLbZ/t9Y0BEPQW2lRCPjrNJ5pqvL3CCzfKbqOGrHg8GJp8yG1dYbQXQPQ/Ds+iCAVgQ
        5bVdaTNoBWRmlza1T71zBmp2bDmSvSYlps4b1nvIsXeL6agWec5V0vf8Wgqa37bYiDjNkD
        /1G2iMaJIOgn2vjNlG+AfLz+5Mdu41E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-qYoevzl6N2eV151CuYM9IA-1; Sun, 17 Apr 2022 23:18:04 -0400
X-MC-Unique: qYoevzl6N2eV151CuYM9IA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FC2C85A5A8;
        Mon, 18 Apr 2022 03:18:03 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55887416361;
        Mon, 18 Apr 2022 03:18:02 +0000 (UTC)
Date:   Mon, 18 Apr 2022 11:17:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>, sourabhjain@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v7 4/8] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <YlzYZ7WI1LH9Zy7d@MiWiFi-R3L-srv>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-5-eric.devolder@oracle.com>
 <YleK3J/4HNuFioIh@MiWiFi-R3L-srv>
 <4eea2373-32f3-9960-cbec-21dc1a428807@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eea2373-32f3-9960-cbec-21dc1a428807@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/22 at 05:29pm, Eric DeVolder wrote:
> Hi Baoquan,
> Inline comments below.
> Thanks!
> eric
> 
> On 4/13/22 21:45, Baoquan He wrote:
> > On 04/13/22 at 12:42pm, Eric DeVolder wrote:
> > > Upon CPU and memory changes, a generic crash_hotplug_handler()
> > > dispatches the hot plug/unplug event to the architecture specific
> > > arch_crash_hotplug_handler(). During the process, the kexec_mutex
> > > is held.
> > > 
> > > To support cpu hotplug, a callback is registered to capture the
> > > CPUHP_AP_ONLINE_DYN online and ofline events via
> > > cpuhp_setup_state_nocalls().
> > > 
> > > To support memory hotplug, a notifier is registered to capture the
> > > MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
> > > 
> > > The cpu callback and memory notifier then call crash_hotplug_handler()
> > > to handle the hot plug/unplug event.
> > > 
> > > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> > > ---
> > >   include/linux/kexec.h |  16 +++++++
> > >   kernel/crash_core.c   | 101 ++++++++++++++++++++++++++++++++++++++++++
> > >   2 files changed, 117 insertions(+)
> > > 
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index f93f2591fc1e..02daff1f47dd 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -306,6 +306,13 @@ struct kimage {
> > >   	/* Information for loading purgatory */
> > >   	struct purgatory_info purgatory_info;
> > > +
> > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > +	bool hotplug_event;
> > > +	unsigned int offlinecpu;
> > > +	bool elfcorehdr_index_valid;
> > > +	int elfcorehdr_index;
> > > +#endif
> > >   #endif
> > >   #ifdef CONFIG_IMA_KEXEC
> > > @@ -322,6 +329,15 @@ struct kimage {
> > >   	unsigned long elf_load_addr;
> > >   };
> > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > +void arch_crash_hotplug_handler(struct kimage *image,
> > > +	unsigned int hp_action, unsigned int cpu);
> > > +#define KEXEC_CRASH_HP_REMOVE_CPU   0
> > > +#define KEXEC_CRASH_HP_ADD_CPU      1
> > > +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
> > > +#define KEXEC_CRASH_HP_ADD_MEMORY   3
> > > +#endif /* CONFIG_CRASH_HOTPLUG */
> > > +
> > >   /* kexec interface functions */
> > >   extern void machine_kexec(struct kimage *image);
> > >   extern int machine_kexec_prepare(struct kimage *image);
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index 256cf6db573c..ecf746243ab2 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -9,12 +9,17 @@
> > >   #include <linux/init.h>
> > >   #include <linux/utsname.h>
> > >   #include <linux/vmalloc.h>
> > > +#include <linux/highmem.h>
> > > +#include <linux/memory.h>
> > > +#include <linux/cpuhotplug.h>
> > >   #include <asm/page.h>
> > >   #include <asm/sections.h>
> > >   #include <crypto/sha1.h>
> > > +#include "kexec_internal.h"
> > > +
> > >   /* vmcoreinfo stuff */
> > >   unsigned char *vmcoreinfo_data;
> > >   size_t vmcoreinfo_size;
> > > @@ -491,3 +496,99 @@ static int __init crash_save_vmcoreinfo_init(void)
> > >   }
> > >   subsys_initcall(crash_save_vmcoreinfo_init);
> > > +
> > > +#ifdef CONFIG_CRASH_HOTPLUG
> > > +void __weak arch_crash_hotplug_handler(struct kimage *image,
> > > +	unsigned int hp_action, unsigned int cpu)
> > > +{
> > > +	pr_warn("crash hp: %s not implemented", __func__);
> > > +}
> > > +
> > > +static void crash_hotplug_handler(unsigned int hp_action,
> > > +	unsigned int cpu)
> > > +{
> > > +	/* Obtain lock while changing crash information */
> > > +	if (!mutex_trylock(&kexec_mutex))
> > > +		return;
> > > +
> > > +	/* Check kdump is loaded */
> > > +	if (kexec_crash_image) {
> > > +		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
> > > +
> > > +		/* Needed in order for the segments to be updated */
> > > +		arch_kexec_unprotect_crashkres();
> > > +
> > > +		/* Flag to differentiate between normal load and hotplug */
> > > +		kexec_crash_image->hotplug_event = true;
> > > +
> > > +		/* Now invoke arch-specific update handler */
> > > +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, cpu);
> > > +
> > > +		/* No longer handling a hotplug event */
> > > +		kexec_crash_image->hotplug_event = false;
> > > +
> > > +		/* Change back to read-only */
> > > +		arch_kexec_protect_crashkres();
> > > +	}
> > > +
> > > +	/* Release lock now that update complete */
> > > +	mutex_unlock(&kexec_mutex);
> > > +}
> > > +
> > > +#if defined(CONFIG_MEMORY_HOTPLUG)
> > > +static int crash_memhp_notifier(struct notifier_block *nb,
> > > +	unsigned long val, void *v)
> > > +{
> > > +	struct memory_notify *mhp = v;
> > > +
> > > +	switch (val) {
> > > +	case MEM_ONLINE:
> > > +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY, -1U);
> > We don't differentiate the memory add/remove, cpu add, except of cpu
> > remove. Means the hp_action only differentiate cpu remove from the other
> > action. Maybe only making two types?
> > 
> > #define KEXEC_CRASH_HP_REMOVE_CPU   0
> > #define KEXEC_CRASH_HP_UPDATE_OTHER      1
> > 
> Sourabh Jain's work with PPC uses REMOVE_CPU, REMOVE_MEMORY, and ADD_MEMORY.
> Do you still want to consolidate these?

I checked Sourabh's ppc patches, am wondering why memory hotplug is not
handled. Is it going to be that CONFIG_MEMORY_HOTPLUG is enabled on ppc,
while Sourabh is not willing to handle it for now?

Only passing KEXEC_CRASH_HP_ADD_MEMORY/KEXEC_CRASH_HP_REMOVE_MEMORY to
indicate that they are not supported sounds weird to me, honestly.

