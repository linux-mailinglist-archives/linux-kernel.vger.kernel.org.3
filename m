Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB295564880
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiGCPzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:55:00 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CACBBF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 08:54:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VIBul8d_1656863685;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VIBul8d_1656863685)
          by smtp.aliyun-inc.com;
          Sun, 03 Jul 2022 23:54:47 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH v5 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com
References: <20220622164629.20795-1-james.morse@arm.com>
Message-ID: <f5ab048c-4a3a-8292-8a08-5fdaff739381@linux.alibaba.com>
Date:   Sun, 3 Jul 2022 23:54:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220622164629.20795-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  james,

I have a review all of the patches, it looks goot to me, but i also test 
them once again, i have a little confusion with my test.

# mkdir p1

# echo "L3:0=001;1=001" > p1/schemata

# [root@iZbp1bu26qv0j3ddyusot3Z p1]# cat schemata
     MB:0=100;1=100
     L3:0=001;1=001

# memhog -r1000000 1000m > /mnt/log &

[1] 53023
[root@iZbp1bu26qv0j3ddyusot3Z p1]# echo 53023 > tasks
[
[root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
3833856
[root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
3620864
[root@iZbp1bu26qv0j3ddyusot3Z p1]# cat mon_data/mon_L3_00/llc_occupancy
3727360
[root@iZbp1bu26qv0j3ddyusot3Z p1]# cat size
     MB:0=100;1=100
     L3:0=3407872;1=3407872

Obviously, the value has been overflowed,  Can you explain why？

My machine environment is:

Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz

numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 
23 24 25 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 
73 74 75 76 77
node 0 size: 191813 MB
node 0 free: 189340 MB
node 1 cpus: 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 
46 47 48 49 50 51 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 
96 97 98 99 100 101 102 103
node 1 size: 193522 MB
node 1 free: 192332 MB
node distances:
node   0   1
   0:  10  21
   1:  21  10

On 6/23/22 12:46 AM, James Morse wrote:
> Changes in this version?
>   * Use supports_mba_mbps() in resctrl_{on,off}line_domain()
>   * Remove some error handling for errors that can't happen.
>   * Restored mbps_val[] reset code to set_mba_sc().
>   * Moved mbps_val[] reset in rdtgroup_init_mba() to reduce noise.
>   * Added resctrl_arch_round_mon_val() to fix the user provided value.
>
> ---
> The aim of this series is to insert a split between the parts of the monitor
> code that the architecture must implement, and those that are part of the
> resctrl filesystem. The eventual aim is to move all filesystem parts out
> to live in /fs/resctrl, so that resctrl can be wired up for MPAM.
>
> What's MPAM? See the cover letter of a previous series. [1]
>
> The series adds domain online/offline callbacks to allow the filesystem to
> manage some of its structures itself, then moves all the 'mba_sc' behaviour
> to be part of the filesystem.
> This means another architecture doesn't need to provide an mbps_val array.
> As its all software, the resctrl filesystem should be able to do this without
> any help from the architecture code.
>
> Finally __rmid_read() is refactored to be the API call that the architecture
> provides to read a counter value. All the hardware specific overflow detection,
> scaling and value correction should occur behind this helper.
>
>
> This series is based on v5.19-rc1, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_monitors_in_bytes/v5
>
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v7
> [1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/
>
> [v1] https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com/
> [v2] https://lore.kernel.org/lkml/20211001160302.31189-1-james.morse@arm.com/
> [v3] https://lore.kernel.org/lkml/20220217182110.7176-1-james.morse@arm.com/
> [v4] https://lore.kernel.org/lkml/20220412124419.30689-1-james.morse@arm.com/
>
> James Morse (21):
>    x86/resctrl: Kill off alloc_enabled
>    x86/resctrl: Merge mon_capable and mon_enabled
>    x86/resctrl: Add domain online callback for resctrl work
>    x86/resctrl: Group struct rdt_hw_domain cleanup
>    x86/resctrl: Add domain offline callback for resctrl work
>    x86/resctrl: Remove set_mba_sc()s control array re-initialisation
>    x86/resctrl: Abstract and use supports_mba_mbps()
>    x86/resctrl: Create mba_sc configuration in the rdt_domain
>    x86/resctrl: Switch over to the resctrl mbps_val list
>    x86/resctrl: Remove architecture copy of mbps_val
>    x86/resctrl: Allow update_mba_bw() to update controls directly
>    x86/resctrl: Calculate bandwidth from the previous __mon_event_count()
>      chunks
>    x86/resctrl: Add per-rmid arch private storage for overflow and chunks
>    x86/resctrl: Allow per-rmid arch private storage to be reset
>    x86/resctrl: Abstract __rmid_read()
>    x86/resctrl: Pass the required parameters into
>      resctrl_arch_rmid_read()
>    x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
>    x86/resctrl: Move get_corrected_mbm_count() into
>      resctrl_arch_rmid_read()
>    x86/resctrl: Rename and change the units of resctrl_cqm_threshold
>    x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's
>      boot_cpu_data
>    x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
>
>   arch/x86/include/asm/resctrl.h            |   9 +
>   arch/x86/kernel/cpu/resctrl/core.c        | 117 ++++-------
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  75 ++++---
>   arch/x86/kernel/cpu/resctrl/internal.h    |  61 +++---
>   arch/x86/kernel/cpu/resctrl/monitor.c     | 232 ++++++++++++++--------
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 216 ++++++++++++++++----
>   include/linux/resctrl.h                   |  64 +++++-
>   8 files changed, 514 insertions(+), 262 deletions(-)
>
-- 
Best Regards!
Xin Hao

