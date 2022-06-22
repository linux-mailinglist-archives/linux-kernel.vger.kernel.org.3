Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29055519A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376788AbiFVQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359441AbiFVQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:47:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35A9240A3F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:46:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D60B212FC;
        Wed, 22 Jun 2022 09:46:48 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57A6A3F792;
        Wed, 22 Jun 2022 09:46:46 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com
Subject: [PATCH v5 00/21] x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
Date:   Wed, 22 Jun 2022 16:46:08 +0000
Message-Id: <20220622164629.20795-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
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

Changes in this version?
 * Use supports_mba_mbps() in resctrl_{on,off}line_domain()
 * Remove some error handling for errors that can't happen.
 * Restored mbps_val[] reset code to set_mba_sc().
 * Moved mbps_val[] reset in rdtgroup_init_mba() to reduce noise.
 * Added resctrl_arch_round_mon_val() to fix the user provided value.

---
The aim of this series is to insert a split between the parts of the monitor
code that the architecture must implement, and those that are part of the
resctrl filesystem. The eventual aim is to move all filesystem parts out
to live in /fs/resctrl, so that resctrl can be wired up for MPAM.

What's MPAM? See the cover letter of a previous series. [1]

The series adds domain online/offline callbacks to allow the filesystem to
manage some of its structures itself, then moves all the 'mba_sc' behaviour
to be part of the filesystem.
This means another architecture doesn't need to provide an mbps_val array.
As its all software, the resctrl filesystem should be able to do this without
any help from the architecture code.

Finally __rmid_read() is refactored to be the API call that the architecture
provides to read a counter value. All the hardware specific overflow detection,
scaling and value correction should occur behind this helper.


This series is based on v5.19-rc1, and can be retrieved from:
git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_monitors_in_bytes/v5

[0] git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v7
[1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/

[v1] https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com/
[v2] https://lore.kernel.org/lkml/20211001160302.31189-1-james.morse@arm.com/
[v3] https://lore.kernel.org/lkml/20220217182110.7176-1-james.morse@arm.com/
[v4] https://lore.kernel.org/lkml/20220412124419.30689-1-james.morse@arm.com/

James Morse (21):
  x86/resctrl: Kill off alloc_enabled
  x86/resctrl: Merge mon_capable and mon_enabled
  x86/resctrl: Add domain online callback for resctrl work
  x86/resctrl: Group struct rdt_hw_domain cleanup
  x86/resctrl: Add domain offline callback for resctrl work
  x86/resctrl: Remove set_mba_sc()s control array re-initialisation
  x86/resctrl: Abstract and use supports_mba_mbps()
  x86/resctrl: Create mba_sc configuration in the rdt_domain
  x86/resctrl: Switch over to the resctrl mbps_val list
  x86/resctrl: Remove architecture copy of mbps_val
  x86/resctrl: Allow update_mba_bw() to update controls directly
  x86/resctrl: Calculate bandwidth from the previous __mon_event_count()
    chunks
  x86/resctrl: Add per-rmid arch private storage for overflow and chunks
  x86/resctrl: Allow per-rmid arch private storage to be reset
  x86/resctrl: Abstract __rmid_read()
  x86/resctrl: Pass the required parameters into
    resctrl_arch_rmid_read()
  x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
  x86/resctrl: Move get_corrected_mbm_count() into
    resctrl_arch_rmid_read()
  x86/resctrl: Rename and change the units of resctrl_cqm_threshold
  x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's
    boot_cpu_data
  x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes

 arch/x86/include/asm/resctrl.h            |   9 +
 arch/x86/kernel/cpu/resctrl/core.c        | 117 ++++-------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  75 ++++---
 arch/x86/kernel/cpu/resctrl/internal.h    |  61 +++---
 arch/x86/kernel/cpu/resctrl/monitor.c     | 232 ++++++++++++++--------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 216 ++++++++++++++++----
 include/linux/resctrl.h                   |  64 +++++-
 8 files changed, 514 insertions(+), 262 deletions(-)

-- 
2.30.2

