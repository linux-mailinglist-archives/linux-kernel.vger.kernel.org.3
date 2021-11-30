Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682F4463581
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbhK3NgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:36:19 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:43970 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhK3NgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:36:18 -0500
Received: by mail-oo1-f54.google.com with SMTP id w5-20020a4a2745000000b002c2649b8d5fso6696024oow.10;
        Tue, 30 Nov 2021 05:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvp94v0vIhe+inYzF2P6jtmQ6owRJVQi+9jnPYRrKZc=;
        b=YSrtvN51zAmf8S7RAD/EsjfALsgtp91i0ttz5IfBB4ZcyVEbLY6ZT+/Imhnz6Z8fLW
         5ukq9+7xt+Esg7phldqqDfd5fkQAfTq70WlxCvMTEVw/ka4POBExd3vLFbTNP5HdHz6L
         gFhV6/0Uo5wQ/oBQLsuIPngYb1i85d7jBZ07yGFS3PiCmTZnxXgwUrdXUBn3jHukAE3f
         njk9vexSGHX6ZTOZ0Ni1mJYLsDYS8y83zjfwpMijJqsUFmbrRNjPwSKnVgdSwxioSJTH
         KuZ2IxZ0bqfguCp1Ay32zVVFPF3m1h1qHx0CgVrWhC0YRMVH3iJweuFTvOV8zYx/UrmY
         SlMw==
X-Gm-Message-State: AOAM531lU4JaGZ3I7bpkYKU14sxD9PIJPM7NvCRPJdZW0HTBEb0qUUP7
        +kbl2i9d9gyXVJSWc2MA7+Ss0PydRHSQ1E0KcVU=
X-Google-Smtp-Source: ABdhPJzkb4vCKXSDAAMNocRw1+ADbn4KnhnQ1m7tCucnFiBm5axEl/0R7ZICxHFfRH9dE5gVDFzNEq2Dcl9HZLx/YbA=
X-Received: by 2002:a05:6820:388:: with SMTP id r8mr35608148ooj.0.1638279179124;
 Tue, 30 Nov 2021 05:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-5-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0gemmV1Lz3+9iKz1eiXtkyDc3+4+po4Eidchzk+J2=ceA@mail.gmail.com> <20211130132137.GA25524@ranerica-svr.sc.intel.com>
In-Reply-To: <20211130132137.GA25524@ranerica-svr.sc.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Nov 2021 14:32:42 +0100
Message-ID: <CAJZ5v0iXBn1o9ZFzNaYU4ft=JcRfNv7AJ8Sq-9HbBJbp60LpWQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] thermal: intel: hfi: Handle CPU hotplug events
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 2:22 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Wed, Nov 24, 2021 at 03:48:49PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Nov 6, 2021 at 2:34 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:

[cut]

> > > +/**
> > > + * intel_hfi_offline() - Disable HFI on @cpu
> > > + * @cpu:       CPU in which the HFI will be disabled
> > > + *
> > > + * Remove @cpu from those covered by its HFI instance.
> > > + *
> > > + * On some processors, hardware remembers previous programming settings even
> > > + * after being reprogrammed. Thus, keep HFI enabled even if all CPUs in the
> > > + * die/package of @cpu are offline. See note in intel_hfi_online().
> > > + */
> > > +void intel_hfi_offline(unsigned int cpu)
> > > +{
> > > +       struct cpumask *die_cpumask = topology_core_cpumask(cpu);
> > > +       struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
> > > +       struct hfi_instance *hfi_instance;
> > > +
> > > +       if (!boot_cpu_has(X86_FEATURE_INTEL_HFI))
> > > +               return;
> > > +
> > > +       hfi_instance = info->hfi_instance;
> > > +       if (!hfi_instance)
> > > +               return;
> > > +
> > > +       if (!hfi_instance->initialized)
> > > +               return;
> > > +
> > > +       mutex_lock(&hfi_lock);
> > > +
> > > +       /*
> > > +        * We were using the core cpumask of @cpu to track CPUs in the same
> > > +        * die/package. Now it is going offline and we need to find another
> > > +        * CPU we can use.
> > > +        */
> > > +       if (die_cpumask == hfi_instance->cpus) {
> > > +               int new_cpu;
> > > +
> > > +               new_cpu = cpumask_any_but(hfi_instance->cpus, cpu);
> > > +               if (new_cpu >= nr_cpu_ids)
> > > +                       /* All other CPUs in the package are offline. */
> > > +                       hfi_instance->cpus = NULL;
> > > +               else
> > > +                       hfi_instance->cpus = topology_core_cpumask(new_cpu);
> >
> > Hmmm.  Is topology_core_cpumask() updated when CPUs go offline and online?
>
> Yes. A CPU going offline is cleared from its siblings' cpumask [1] and its own [2]
> in remove_siblinginfo() via cpu_disable_common(). A CPU going online is set
> in its siblings' cpumask and its own in set_cpu_sibling_map() [3].

OK, so it is necessary to ensure that intel_hfi_offline() will always
run after remove_siblinginfo() so it sees the updated mask.  How do we
ensure that?

> [1]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/smpboot.c?h=v5.16-rc3#n1592
> [2]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/smpboot.c?h=v5.16-rc3#n1617
> [3]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/smpboot.c?h=v5.16-rc3#n657
