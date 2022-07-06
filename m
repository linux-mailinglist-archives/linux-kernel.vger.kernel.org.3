Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86FD56889F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiGFMq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiGFMqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:46:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BB81201AA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:46:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F2BF106F;
        Wed,  6 Jul 2022 05:46:53 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 201873F792;
        Wed,  6 Jul 2022 05:46:51 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] cacheinfo/arch_topology: Updates for v5.20
Date:   Wed,  6 Jul 2022 13:46:44 +0100
Message-Id: <20220706124644.2276077-1-sudeep.holla@arm.com>
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

This is my first pull request to you, not sure if you are open to
pull request or prefer pulling the patch series directly. I am fine
either way. You can ignore this and pull the patches from[1] if you
prefer.

Most of these changes are in -next for almost 2 weeks with small update
to fix issue reported on RISC-V last week. The small changes in ACPI
and arm64 are acked-by Rafael and Catalin.

Regards,
Sudeep

[1] https://lore.kernel.org/all/20220704101605.1318280-1-sudeep.holla@arm.com/


-->8

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/arch-cache-topo-5.20

for you to fetch changes up to 7128af87c7f1c30cd6cebe0b012cc25872c689e2:

  ACPI: Remove the unused find_acpi_cpu_cache_topology() (2022-07-04 16:23:23 +0100)

----------------------------------------------------------------
cacheinfo and arch_topology updates for v5.20

These are updates to fix some discrepancies we have in the CPU topology
parsing from the device tree /cpu-map node and the divergence from the
behaviour on a ACPI enabled platform. The expectation is that both DT
and ACPI enabled systems must present consistent view of the CPU topology.

The current assignment of generated cluster count as the physical package
identifier for each CPU is wrong. The device tree bindings for CPU
topology supports sockets to infer the socket or physical package
identifier for a given CPU. It is now being made use of you address the
issue. These updates also assigns the cluster identifier as parsed from
the device tree cluster nodes within /cpu-map without support for
nesting of the clusters as there are no such reported/known platforms.

In order to be on par with ACPI PPTT physical package/socket support,
these updates also include support for socket nodes in /cpu-map.

The only exception is that the last level cache id information can be
inferred from the same ACPI PPTT while we need to parse CPU cache nodes
in the device tree. The cacheinfo changes here is to enable the re-use
of the cacheinfo to detect the cache attributes for all the CPU quite
early even before the scondardaries are booted so that the information
can be used to build the schedular domains especially the last level
cache(LLC).

----------------------------------------------------------------
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

 arch/arm64/kernel/topology.c  |  14 -----
 drivers/acpi/pptt.c           |  40 +-----------
 drivers/base/arch_topology.c  | 102 +++++++++++++++++++++++-------
 drivers/base/cacheinfo.c      | 143 +++++++++++++++++++++++++++---------------
 include/linux/acpi.h          |   5 --
 include/linux/arch_topology.h |   1 -
 include/linux/cacheinfo.h     |   3 +
 7 files changed, 175 insertions(+), 133 deletions(-)
