Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D3653A488
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351816AbiFAMEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiFAMEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:04:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 859894C781
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:04:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 261B7ED1;
        Wed,  1 Jun 2022 05:04:44 -0700 (PDT)
Received: from bogus (unknown [10.57.9.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9707D3F73D;
        Wed,  1 Jun 2022 05:04:41 -0700 (PDT)
Date:   Wed, 1 Jun 2022 13:03:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 00/16] arch_topology: Updates to add socket support
 and fix cluster ids
Message-ID: <20220601120353.mz3t3sse2ja6engx@bogus>
References: <20220525081416.3306043-1-sudeep.holla@arm.com>
 <5258e7c2-7829-af20-6416-1a40a09d1917@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5258e7c2-7829-af20-6416-1a40a09d1917@redhat.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 11:49:07AM +0800, Gavin Shan wrote:
> Hi Sudeep,
> 
> On 5/25/22 4:14 PM, Sudeep Holla wrote:
> > This version updates cacheinfo to populate and use the information from
> > there for all the cache topology. Sorry for posting in the middle of
> > merge window but better to get this tested earlier so that it is ready
> > for next merge window.
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
> > v2[2]->v3:
> > 	- Dropped support to get the device node for the CPU's LLC
> > 	- Updated cacheinfo to support calling of detect_cache_attributes
> > 	  early in smp_prepare_cpus stage
> > 	- Added support to check if LLC is valid and shared in the cacheinfo
> > 	- Used the same in arch_topology
> > 
> > v1[1]->v2[2]:
> > 	- Updated ID validity check include all non-negative value
> > 	- Added support to get the device node for the CPU's last level cache
> > 	- Added support to build llc_sibling on DT platforms
> > 
> > [1] https://lore.kernel.org/lkml/20220513095559.1034633-1-sudeep.holla@arm.com
> > [2] https://lore.kernel.org/lkml/20220518093325.2070336-1-sudeep.holla@arm.com
> > 
> > Sudeep Holla (16):
> >    cacheinfo: Use of_cpu_device_node_get instead cpu_dev->of_node
> >    cacheinfo: Add helper to access any cache index for a given CPU
> >    cacheinfo: Move cache_leaves_are_shared out of CONFIG_OF
> >    cacheinfo: Add support to check if last level cache(LLC) is valid or shared
> >    cacheinfo: Allow early detection and population of cache attributes
> >    arch_topology: Add support to parse and detect cache attributes
> >    arch_topology: Use the last level cache information from the cacheinfo
> >    arm64: topology: Remove redundant setting of llc_id in CPU topology
> >    arch_topology: Drop LLC identifier stash from the CPU topology
> >    arch_topology: Set thread sibling cpumask only within the cluster
> >    arch_topology: Check for non-negative value rather than -1 for IDs validity
> >    arch_topology: Avoid parsing through all the CPUs once a outlier CPU is found
> >    arch_topology: Don't set cluster identifier as physical package identifier
> >    arch_topology: Drop unnecessary check for uninitialised package_id
> >    arch_topology: Set cluster identifier in each core/thread from /cpu-map
> >    arch_topology: Add support for parsing sockets in /cpu-map
> > 
> >   arch/arm64/kernel/topology.c  |  14 -----
> >   drivers/base/arch_topology.c  |  92 +++++++++++++++++----------
> >   drivers/base/cacheinfo.c      | 114 +++++++++++++++++++++-------------
> >   include/linux/arch_topology.h |   1 -
> >   include/linux/cacheinfo.h     |   3 +
> >   5 files changed, 135 insertions(+), 89 deletions(-)
> > 
> 
> I tried this series on virtual machine where ACPI is enabled and looks good.
> Especially for PATCH[10], resolving the issue I have. So I provided my tested-by
> tag for it. Besides, I checked the changes related to ACPI part and looks to
> me either after the mentioned nits fixed. I leave the changes related to device-tree
> to be reviewed by the experts :)
> 

Thanks for the review and testing, much appreciated!
Yes the changes for ACPI is very minimal in this series, except the bug fix
you are interested, nothing changes in the system behaviour. The main aim
is to get the same behaviour on a similar DT based system.

-- 
Regards,
Sudeep
