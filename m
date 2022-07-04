Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B6E5651E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiGDKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiGDKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:16:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F968D11D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:16:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F36023A;
        Mon,  4 Jul 2022 03:16:15 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 695803F792;
        Mon,  4 Jul 2022 03:16:13 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, conor.dooley@microchip.com,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v6 00/21] arch_topology: Updates to add socket support and fix cluster ids
Date:   Mon,  4 Jul 2022 11:15:44 +0100
Message-Id: <20220704101605.1318280-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Let me know if you prefer to pull the patches directly or prefer pull
request. It has been in -next for a while now.

Hi All,

This version updates cacheinfo to populate and use the information from
there for all the cache topology.

This series intends to fix some discrepancies we have in the CPU topology
parsing from the device tree /cpu-map node. Also this diverges from the
behaviour on a ACPI enabled platform. The expectation is that both DT
and ACPI enabled systems must present consistent view of the CPU topology.

Currently we assign generated cluster count as the physical package identifier
for each CPU which is wrong. The device tree bindings for CPU topology supports
sockets to infer the socket or physical package identifier for a given CPU.
Also we don't check if all the cores/threads belong to the same cluster before
updating their sibling masks which is fine as we don't set the cluster id yet.

These changes also assigns the cluster identifier as parsed from the device tree
cluster nodes within /cpu-map without support for nesting of the clusters.
Finally, it also add support for socket nodes in /cpu-map. With this the
parsing of exact same information from ACPI PPTT and /cpu-map DT node
aligns well.

The only exception is that the last level cache id information can be
inferred from the same ACPI PPTT while we need to parse CPU cache nodes
in the device tree.


v5[5]->v6:
	- Handled out of memory case in early detected correctly after
	  Conor reported boot failures on some RISC-V platform. Also
	  added a log to show up failure of early cacheinfo detection.
	- Added "Remove the unused find_acpi_cpu_cache_topology()" which
	  was missed earlier and posted separately
	- Added all the additional tags recieved

v4[4]->v5[5]:
	- Added all the tags recieved so far. Rafael has acked only change
	  in ACPI and Catalin has acked only change in arm64.
	- Addressed all the typos pointed by Ionela and dropped the patch
	  removing the checks for invalid package id as discussed and update
	  depth in nested cluster warning check.

v3[3]->v4[4]:
	- Updated ACPI PPTT fw_token to use table offset instead of virtual
	  address as it could get changed for everytime it is mapped before
	  the global acpi_permanent_mmap is set
	- Added warning for the topology with nested clusters
	- Added update to cpu_clustergroup_mask so that introduction of
	  correct cluster_id doesn't break existing platforms by limiting
	  the span of clustergroup_mask(by Ionela)

v2[2]->v3[3]:
        - Dropped support to get the device node for the CPU's LLC
        - Updated cacheinfo to support calling of detect_cache_attributes
          early in smp_prepare_cpus stage
        - Added support to check if LLC is valid and shared in the cacheinfo
        - Used the same in arch_topology

v1[1]->v2[2]:
        - Updated ID validity check include all non-negative value
        - Added support to get the device node for the CPU's last level cache
        - Added support to build llc_sibling on DT platforms

[1] https://lore.kernel.org/lkml/20220513095559.1034633-1-sudeep.holla@arm.com
[2] https://lore.kernel.org/lkml/20220518093325.2070336-1-sudeep.holla@arm.com
[3] https://lore.kernel.org/lkml/20220525081416.3306043-1-sudeep.holla@arm.com
[4] https://lore.kernel.org/lkml/20220621192034.3332546-1-sudeep.holla@arm.com
[5] https://lore.kernel.org/lkml/20220627165047.336669-1-sudeep.holla@arm.com

Ionela Voinescu (1):
  arch_topology: Limit span of cpu_clustergroup_mask()

Sudeep Holla (20):
  ACPI: PPTT: Use table offset as fw_token instead of virtual address
  cacheinfo: Use of_cpu_device_node_get instead cpu_dev->of_node
  cacheinfo: Add helper to access any cache index for a given CPU
  cacheinfo: Move cache_leaves_are_shared out of CONFIG_OF
  cacheinfo: Add support to check if last level cache(LLC) is valid or shared
  cacheinfo: Allow early detection and population of cache attributes
  cacheinfo: Use cache identifiers to check if the caches are shared if available
  cacheinfo: Align checks in cache_shared_cpu_map_{setup,remove} for readability
  arch_topology: Add support to parse and detect cache attributes
  arch_topology: Use the last level cache information from the cacheinfo
  arm64: topology: Remove redundant setting of llc_id in CPU topology
  arch_topology: Drop LLC identifier stash from the CPU topology
  arch_topology: Set thread sibling cpumask only within the cluster
  arch_topology: Check for non-negative value rather than -1 for IDs validity
  arch_topology: Avoid parsing through all the CPUs once a outlier CPU is found
  arch_topology: Don't set cluster identifier as physical package identifier
  arch_topology: Set cluster identifier in each core/thread from /cpu-map
  arch_topology: Add support for parsing sockets in /cpu-map
  arch_topology: Warn that topology for nested clusters is not supported
  ACPI: Remove the unused find_acpi_cpu_cache_topology()

 arch/arm64/kernel/topology.c  |  14 ----
 drivers/acpi/pptt.c           |  40 +---------
 drivers/base/arch_topology.c  | 102 ++++++++++++++++++------
 drivers/base/cacheinfo.c      | 143 ++++++++++++++++++++++------------
 include/linux/acpi.h          |   5 --
 include/linux/arch_topology.h |   1 -
 include/linux/cacheinfo.h     |   3 +
 7 files changed, 175 insertions(+), 133 deletions(-)

--
2.37.0

