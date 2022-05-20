Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8DD52EF4B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350890AbiETPdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbiETPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:33:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C47D178556
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:33:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C0E51477;
        Fri, 20 May 2022 08:33:18 -0700 (PDT)
Received: from bogus (unknown [10.57.66.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AADFA3F73D;
        Fri, 20 May 2022 08:33:15 -0700 (PDT)
Date:   Fri, 20 May 2022 16:33:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/8] arch_topology: Updates to add socket support and
 fix cluster ids
Message-ID: <20220520153309.rjtticnfxidz4x7p@bogus>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <YoZxKJ6TiAsxTXNl@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZxKJ6TiAsxTXNl@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 05:32:49PM +0100, Ionela Voinescu wrote:
> Hi Sudeep,
> 
> On Wednesday 18 May 2022 at 10:33:17 (+0100), Sudeep Holla wrote:
> > Hi All,
> > 
> > This series intends to fix some discrepancies we have in the CPU topology
> > parsing from the device tree /cpu-map node. Also this diverges from the
> > behaviour on a ACPI enabled platform. The expectation is that both DT
> > and ACPI enabled systems must present consistent view of the CPU topology.
> > 
> > Currently we assign generated cluster count as the physical package identifier
> > for each CPU which is wrong. The device tree bindings for CPU topology supports
> > sockets to infer the socket or physical package identifier for a given CPU.
> > Also we don't check if all the cores/threads belong to the same cluster before
> > updating their sibling masks which is fine as we don't set the cluster id yet.
> > 
> > These changes also assigns the cluster identifier as parsed from the device tree
> > cluster nodes within /cpu-map without support for nesting of the clusters.
> > Finally, it also add support for socket nodes in /cpu-map. With this the
> > parsing of exact same information from ACPI PPTT and /cpu-map DT node
> > aligns well.
> > 
> > The only exception is that the last level cache id information can be
> > inferred from the same ACPI PPTT while we need to parse CPU cache nodes
> > in the device tree.
> > 
> > P.S: I have not cc-ed Greg and Rafael so that all the users of arch_topology
> > agree with the changes first before we include them.
> > 
> > v1[1]->v2:
> > 	- Updated ID validity check include all non-negative value
> > 	- Added support to get the device node for the CPU's last level cache
> > 	- Added support to build llc_sibling on DT platforms
> > 
> > [1] https://lore.kernel.org/lkml/20220513095559.1034633-1-sudeep.holla@arm.com
> > 
> > Sudeep Holla (8):
> >   arch_topology: Don't set cluster identifier as physical package identifier
> >   arch_topology: Set thread sibling cpumask only within the cluster
> >   arch_topology: Set cluster identifier in each core/thread from /cpu-map
> >   arch_topology: Add support for parsing sockets in /cpu-map
> >   arch_topology: Check for non-negative value rather than -1 for IDs validity
> >   arch_topology: Avoid parsing through all the CPUs once a outlier CPU is found
> >   of: base: add support to get the device node for the CPU's last level cache
> >   arch_topology: Add support to build llc_sibling on DT platforms
> > 
> 
> Just a recommendation for patch-set structure: it would be best to have
> the following sequence to maintain the same scheduler topology and
> behaviour when partially applying the set (currently testing this on Juno,
> but should be the case for other platforms as well):
> 
> 2/8 arch_topology: Set thread sibling cpumask only within the cluster
> 5/8 arch_topology: Check for non-negative value rather than -1 for IDs validity
> 6/8 arch_topology: Avoid parsing through all the CPUs once a outlier CPU is found
> 
> --> these are only preparation/cleanup patches and don't affect current
> functionality
>

Agreed. It was in my TODO list but I just to post this v2 for some reason.
I knew the patches were more in the order of my thoughts on what all needs
to be done and the order I added them. I knew it would result in issue
with kernel bisection.


> 7/8 of: base: add support to get the device node for the CPU's last level cache
> 8/8 arch_topology: Add support to build llc_sibling on DT platforms
>
> --> these will populate llc siblings but this list will be equal to
> core siblings (based on package_id) so nothing changes in the scheduler
> topology. Even if CONFIG_SCHED_CLUSTER=y, we still have cluster_id=-1 so
> nothing will change in that case either, for the patches so far.
>

Correct, I had worked out this much detail.

> 1/8 arch_topology: Don't set cluster identifier as physical package identifier
> 
> --> 1/8 is the trouble maker if it's the first patch as it will result
> in having all CPUs in core_siblings so the topology will be flattened to
> just an MC level for a typical b.L system like Juno. But if you add it after
> all of the above patches, the llc_siblings will contribute to create the same
> MC and DIE levels we expect.
> 
> 3/8 arch_topology: Set cluster identifier in each core/thread from /cpu-map
> 4/8 arch_topology: Add support for parsing sockets in /cpu-map
> 
> --> Here 3/8 will start creating complications when having clusters in
> DT and we have CONFIG_SCHED_CLUSTER=y. But I'll detail this in a reply
> to that patch. For CONFIG_SCHED_CLUSTER=n the topology and scheduler
> behaviour should be the same as before this set.
>

Thanks for the ordering of the last 3. I wanted to work out, but you need
to have done more work than me on that and thanks for saving my time. Much
appreciated.

> Hope it helps,

Yes definitely, thanks again.

-- 
Regards,
Sudeep
