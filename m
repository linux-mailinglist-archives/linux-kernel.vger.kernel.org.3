Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8865E52B7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiERKny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiERKnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:43:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 497B745799
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:43:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 150DA23A;
        Wed, 18 May 2022 03:43:48 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 054583F718;
        Wed, 18 May 2022 03:43:46 -0700 (PDT)
Date:   Wed, 18 May 2022 11:43:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qing Wang <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arch_topology: Use llc_id instead of package_id
Message-ID: <20220518104344.wh5thzaw2zg4f6jq@bogus>
References: <20220513083400.343706-1-dietmar.eggemann@arm.com>
 <20220513090330.z25fwthekn4rjkwq@bogus>
 <afafbb0c-5279-bee8-1ef4-434733e2a552@arm.com>
 <20220513110312.wy6g5avs7ngkmhfu@bogus>
 <634a4b8c-84d2-51a9-ef54-33b81683c849@arm.com>
 <20220516103524.35swlxp2367baxx6@bogus>
 <beda044e-0b91-4359-c6bf-5e34c285fc5c@arm.com>
 <20220517105718.tvpmj2xxb2qj3bev@bogus>
 <b0b63d75-b2f4-2298-a85a-668c3a3e5b6b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0b63d75-b2f4-2298-a85a-668c3a3e5b6b@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 12:23:35PM +0200, Dietmar Eggemann wrote:
> On 17/05/2022 12:57, Sudeep Holla wrote:
[...]

> > Ah OK, but if LLC sibling masks are updated, cpu_coregroup_mask() takes
> > care of it IIUC, right ?
>
> Yes. That's the:
>
> 691 if (cpu_topology[cpu].llc_id != -1) {
> 692  if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
> 693   core_mask = &cpu_topology[cpu].llc_sibling;
> 694 }
>
> condition in cpu_coregroup_mask().
>

Correct, I am referring that.

> >
> > Agreed. But we are not changing any topology masks as per sched domain
> > requirements as they get exposed to the userspace as is.
>
> I see. Your requirement is valid information under
> /sys/devices/system/cpu/cpuX/{topology, cache} for userspace.
>
> I'm not sure that we can get core_siblings_list and package_cpus_list
> correctly setup.
>
> With your patch we have now:
>
> root@juno:/sys/devices/system/cpu/cpu0/topology# cat core_siblings_list
> 0-5
> root@juno:/sys/devices/system/cpu/cpu0/topology# cat package_cpus_list
> 0-5
>
> Before we had [0,3-5] for both.
>

Correct and that was pure wrong for a single socket system. It must
cover all the CPUs. Tools like lscpu reports them as 2 socket system
which is wrong. There were reports for that but no one really chased it
up to get it fixed. So assumed it is not so important but still it is
wrong. ACPI platforms cared and wanted it fixed with ACPI PPTT since
the PPTT support. So check the difference without my patches on Juno
in DT and ACPI boot. We should get same output for both.

>
> I'm afraid we can have 2 different mask here because of:
>
> 72 define_siblings_read_func(core_siblings, core_cpumask);
>                                             ^^^^^^^^^^^^
> 88 define_siblings_read_func(package_cpus, core_cpumask);
>                                            ^^^^^^^^^^^^
>

Yes even I got confused and the Documentation revealed one is deprecated
or obsolete(Documentation/ABI/stable/sysfs-devices-system-cpu)

 74 What:           /sys/devices/system/cpu/cpuX/topology/package_cpus
 75 Description:    internal kernel map of the CPUs sharing the same physical_package_id.
 76                 (deprecated name: "core_siblings").
 77 Values:         hexadecimal bitmask.
 78
 79 What:           /sys/devices/system/cpu/cpuX/topology/package_cpus_list
 80 Description:    human-readable list of CPUs sharing the same physical_package_id.
 81                 The format is like 0-3, 8-11, 14,17.
 82                 (deprecated name: "core_siblings_list")
 83 Values:         decimal list.

> [...]
>
> > Understood and on Juno if we get llc_siblings right, the sched domains
> > must be sorted correctly ?
>
> Yes, then it should do exactly what ACPI is leading us to on this !NUMA
> Kunpeng920 example.
>

Cool.

> >> Coming back to the original request (the support of Armv9 L2 complexes
> >> in Android) from Qing on systems like QC SM8450:
> >>
> >>       .---------------.
> >> CPU   |0 1 2 3 4 5 6 7|
> >>       +---------------+
> >> uarch |l l l l m m m b| (so called tri-gear: little, medium, big)
> >>       +---------------+
> >>   L2  |   |   | | | | |
> >>       +---------------+
> >>   L3  |<--         -->|
> >>       +---------------+
> >>       |<-- cluster -->|
> >>       +---------------+
> >>       |<--   DSU   -->|
> >>       '---------------'
> >>
> >> This still wouldn't be possible. We know that Phantom Domain (grouping
> >> after uarch) is not supported in mainline but heavily used in Android
> >> (legacy deps).
> >>
> >
> > Correct, unless you convince to get a suitable notion of *whatever*
> > phantom domains represent into the DT bindings, they don't exist.
> > If someone wants to support this config, they must first represent that
> > in the firmware so that OS can infer information from the same.
>
> OK, we don't support Phantom domains via 1. level Cluster in cpu-map
> anymore. We already explicitly informed the Android community. But I'm
> sure people will only discover this if something breaks on their
> platforms and they are able to detect this.
>

Again if it was working just by cache with their own phantom domains that
are not upstream, then nothing is broken. At-least I see that we have now
fixed and aligned DT with ACPI. While I understand your concern, I see
this as main issue and not sched domains which may or may not be using
topology info incorrectly.

> >> If we say we only support L2 sharing (asymmetric here since only CPU0-3
> >> have it !!!) and we don't support Phantom then your approach will work
> >> for such systems.
> >
> > Thanks, as I said what is *Phantom* domain ;) ? Can you point me to the
> > DT or ACPI binding for the same ? Just kidding, I know they don't exist.
>
> They do ;-) 1. level Clusters ... but they are used for uArch
> boundaries, not for LLC boundaries. That's the existing issue in DT,
> topology information has 2 sources: (1) cpu-map and (2) cache info.
>

Sure, they can fix or add more optimisation on top of what I have sent[1]

> > Anyways, I understand your concern that llc_sibling must go with my set
> > of topology changes which I agree. Is that the only concern ?
>
> Cool. Let me review your v2 first ;-)

Thanks.

--
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/20220518093325.2070336-1-sudeep.holla@arm.com
