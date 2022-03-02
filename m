Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD34CACFF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbiCBSKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244029AbiCBSKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:10:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7980D7090E;
        Wed,  2 Mar 2022 10:09:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40621139F;
        Wed,  2 Mar 2022 10:09:48 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.195.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71FB53F73D;
        Wed,  2 Mar 2022 10:09:46 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] arch_topology, ACPI: populate cpu capacity from CPPC
Date:   Wed,  2 Mar 2022 18:09:10 +0000
Message-Id: <20220302180913.13229-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

v2->v3:
 - v2 can be found at [2]
 - Added sanity checking on perf_caps.highest_perf

v1->v2:
 - v1 can be found at [1]
 - Changed debug prints to the format used on the DT path
 - s/init_cpu_capacity_cppc/topology_init_cpu_capacity_cppc

Patches are based on v5.17-rc6.

The patches have been build tested on x86 and more thoroughly tested on
Juno R2 (arm64), which uses the new functionality, with the following
results:

root@buildroot:~# dmesg | grep cpu_capacity
[    2.191152] cpu_capacity: CPU0 cpu_capacity=38300 (raw).
[    2.196482] cpu_capacity: CPU1 cpu_capacity=38300 (raw).
[    2.201809] cpu_capacity: CPU2 cpu_capacity=38300 (raw).
[    2.207136] cpu_capacity: CPU3 cpu_capacity=38300 (raw).
[    2.212463] cpu_capacity: CPU4 cpu_capacity=102400 (raw).
[    2.217877] cpu_capacity: CPU5 cpu_capacity=102400 (raw).
[    2.223291] cpu_capacity: capacity_scale=102400
[    2.227834] cpu_capacity: CPU0 cpu_capacity=383
[    2.232376] cpu_capacity: CPU1 cpu_capacity=383
[    2.236919] cpu_capacity: CPU2 cpu_capacity=383
[    2.241462] cpu_capacity: CPU3 cpu_capacity=383
[    2.246004] cpu_capacity: CPU4 cpu_capacity=1024
[    2.250634] cpu_capacity: CPU5 cpu_capacity=1024
[    2.255321] cpu_capacity: cpu_capacity initialization done

root@buildroot:~# tail -n +1 /sys/devices/system/cpu/cpu*/cpu_capacity
==> /sys/devices/system/cpu/cpu0/cpu_capacity <==
383
==> /sys/devices/system/cpu/cpu1/cpu_capacity <==
383
==> /sys/devices/system/cpu/cpu2/cpu_capacity <==
383
==> /sys/devices/system/cpu/cpu3/cpu_capacity <==
383
==> /sys/devices/system/cpu/cpu4/cpu_capacity <==
1024
==> /sys/devices/system/cpu/cpu5/cpu_capacity <==
1024

[1]
https://lore.kernel.org/lkml/20210514095339.12979-1-ionela.voinescu@arm.com/
[2]
https://lore.kernel.org/lkml/20210824105651.28660-1-ionela.voinescu@arm.com/

Thanks,
Ionela.

Ionela Voinescu (3):
  x86, ACPI: rename init_freq_invariance_cppc to
    arch_init_invariance_cppc
  arch_topology: obtain cpu capacity using information from CPPC
  arm64, topology: enable use of init_cpu_capacity_cppc()

 arch/arm64/include/asm/topology.h |  4 ++++
 arch/x86/include/asm/topology.h   |  2 +-
 drivers/acpi/cppc_acpi.c          |  6 ++---
 drivers/base/arch_topology.c      | 40 +++++++++++++++++++++++++++++++
 include/linux/arch_topology.h     |  4 ++++
 5 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.25.1

