Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004FC4D4D31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiCJPGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344487AbiCJPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:03:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 108CE199E1B;
        Thu, 10 Mar 2022 06:55:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 935811692;
        Thu, 10 Mar 2022 06:55:15 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.195.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDD0C3F7B4;
        Thu, 10 Mar 2022 06:55:13 -0800 (PST)
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
Subject: [PATCH v4 0/3] arch_topology, ACPI: populate cpu capacity from CPPC
Date:   Thu, 10 Mar 2022 14:54:48 +0000
Message-Id: <20220310145451.15596-1-ionela.voinescu@arm.com>
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

v3->v4:
 - v3 can be found at [3]
 - rebased on linux-next 20220310 which contains patches at [4]
   requested by Rafael
 - 2/3 fixed obsolete comment as reported by Yicong at [5]
 - Kept Acked-by,Tested-by as v4 has no code changes compared
   to v3, but only a comment fix.

v2->v3:
 - v2 can be found at [2]
 - Added sanity checking on perf_caps.highest_perf

v1->v2:
 - v1 can be found at [1]
 - Changed debug prints to the format used on the DT path
 - s/init_cpu_capacity_cppc/topology_init_cpu_capacity_cppc

Patches are based on linux next 20220310.

[1] https://lore.kernel.org/lkml/20210514095339.12979-1-ionela.voinescu@arm.com/
[2] https://lore.kernel.org/lkml/20210824105651.28660-1-ionela.voinescu@arm.com/
[3] https://lore.kernel.org/lkml/20220302180913.13229-1-ionela.voinescu@arm.com/
[4] https://lore.kernel.org/linux-acpi/20220214101450.356047-1-ray.huang@amd.com/
[5] https://lore.kernel.org/lkml/477748c7-ae9e-712b-90ad-b04a6767a996@huawei.com/


Thanks,
Ionela.

Ionela Voinescu (3):
  x86, ACPI: rename init_freq_invariance_cppc to
    arch_init_invariance_cppc
  arch_topology: obtain cpu capacity using information from CPPC
  arm64, topology: enable use of init_cpu_capacity_cppc()

 arch/arm64/include/asm/topology.h |  4 +++
 arch/x86/include/asm/topology.h   |  2 +-
 drivers/acpi/cppc_acpi.c          |  6 ++---
 drivers/base/arch_topology.c      | 45 ++++++++++++++++++++++++++++---
 include/linux/arch_topology.h     |  4 +++
 5 files changed, 54 insertions(+), 7 deletions(-)

-- 
2.25.1

