Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7125352ED96
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350025AbiETNzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbiETNy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:54:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FA7A5EDC2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:54:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5280B1477;
        Fri, 20 May 2022 06:54:56 -0700 (PDT)
Received: from bogus (unknown [10.57.66.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11AF3F73D;
        Fri, 20 May 2022 06:54:53 -0700 (PDT)
Date:   Fri, 20 May 2022 14:54:47 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/8] arch_topology: Set cluster identifier in each
 core/thread from /cpu-map
Message-ID: <20220520135447.bvdipvgjuy4dx64d@bogus>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-4-sudeep.holla@arm.com>
 <YoZ2gjjS3rbRaJZm@arm.com>
 <26f39a9d-1a02-b77d-5c89-88a1fb0e4eac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f39a9d-1a02-b77d-5c89-88a1fb0e4eac@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:33:19PM +0200, Dietmar Eggemann wrote:
> On 19/05/2022 18:55, Ionela Voinescu wrote:
> > Hi,
> > 
> > As said before, this creates trouble for CONFIG_SCHED_CLUSTER=y.
> > The output below is obtained from Juno.
> > 
> > When cluster_id is populated, a new CLS level is created by the scheduler
> > topology code. In this case the clusters in DT determine that the cluster
> > siblings and llc siblings are the same so the MC scheduler domain will
> > be removed and, for Juno, only CLS and DIE will be kept.
> 
> [...]
> 
> > To be noted that we also get a new flag SD_PREFER_SIBLING for the CLS
> > level that is not appropriate. We usually remove it for the child of a
> > SD_ASYM_CPUCAPACITY domain, but we don't currently redo this after some
> > levels are degenerated. This is a fixable issue.
> > 
> > But looking at the bigger picture, a good question is what is the best
> > thing to do when cluster domains and llc domains span the same CPUs?
> > 
> > Possibly it would be best to restrict clusters (which are almost an
> > arbitrary concept) to always span a subset of CPUs of the llc domain,
> > if llc siblings can be obtained? If those clusters are not properly set
> > up in DT to respect this condition, cluster_siblings would need to be
> > cleared (or set to the current CPU) so the CLS domain is not created at
> > all.
> > 
> > Additionally, should we use cluster information from DT (cluster_id) to
> > create an MC level if we don't have llc information, even if
> > CONFIG_SCHED_CLUSTER=n?
> > 
> > I currently don't have a very clear picture of how cluster domains and
> > llc domains would "live" together in a variety of topologies. I'll try
> > other DT topologies to see if there are others that can lead to trouble.
> 
> This would be an issue. Depending on CONFIG_SCHED_CLUSTER we would get
> two different systems from the viewpoint of the scheduler.
>

Agreed, but that is the issue with the change that updates cpu_coregroup_mask
based on CONFIG_SCHED_CLUSTER, the one that we added recent for Ampere
systems. Sorry, but I admit I was OK for the work around then but all
these discussions has made to disagree with that change now.

> To me `cluster_id/_sibling` don't describe a certain level of CPU
> grouping (e.g. one level above core or one level below package).
>

True, but based on how it is extracted from the firmware todat(ACPI and DT
with this series, it is one level above the cores.

> They were introduced to describe one level below LLC (e.g. Kunpeng920 L3
> (24 CPUs LLC) -> L3 tag (4 CPUs) or x86 Jacobsville L3 -> L2), (Commit
>                  ^^^^^^                                   ^^
> c5e22feffdd7 ("topology: Represent clusters of CPUs within a die")).
>

Again correct, but the description of sysfs is what we need to rely on from
now. If that is not clear, we need to make it clear. But I don't real bother
much on how it is related to LLC as it is known to vary with different
systems.

> The Ampere Altra issue already gave us a taste of the possible issues of
> this definition, commit db1e59483dfd ("topology: make core_mask include
> at least cluster_siblings").
>

Yes this is one I am referring above. I tend to disagree with that now.

> If we link `cluster_id/_sibling` against (1. level) cpu-map cluster
> nodes plus using llc and `cluster_sibling >= llc_sibling` we will run
> into these issues.

As I said you can't change the topology because it causes issues the
way we build sched_domains. You need to figure how to build sched domains
for such systems. If current set of domains or how the masks for each of
the domains are derived is not sufficient or incorrect, we need to fix that.
We are not changing topology masks for that, whatever the reason might be,
sorry as these are userspace visible.

--
Regards,
Sudeep
