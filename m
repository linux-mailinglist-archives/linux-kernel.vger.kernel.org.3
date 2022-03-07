Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B704CFF47
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiCGM6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242626AbiCGM5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:57:44 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD98189CE7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646657810; x=1678193810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xfVVfeaA8GbHOu/ccuyhTSuqZuonBT5KzDitMXqX1IY=;
  b=ORDikbHfkw36fUTtsig38AiVsWhk+Z6+uND2gaJ7Uiqlt3eO5bDu3hLA
   Fsa5+HdQK5QzwBJkEnlSiGBgQ4z3lTGecQbt3LtAt9rUImnf9MExIYI6K
   lUAjgOvpesMxAHlxt0wJXnNJc6Tn0y/y5frW4b3iTnOE1P+jf8qqLYZWh
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 07 Mar 2022 04:56:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 04:56:49 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Mar 2022 04:56:48 -0800
Received: from localhost (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 7 Mar 2022
 04:56:47 -0800
Date:   Mon, 7 Mar 2022 12:56:45 +0000
From:   Jamie Iles <quic_jiles@quicinc.com>
To:     James Morse <james.morse@arm.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
Subject: Re: [PATCH v3 00/21] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Message-ID: <YiYAfiSZg6uNlwPN@hazel>
References: <20220217182110.7176-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220217182110.7176-1-james.morse@arm.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:20:49PM +0000, James Morse wrote:
> Changes in this version? Expanded the commit message of patch 12, and
> made a few things static, as reported by the kbuild robot.
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
> This series is based on v5.17-rc1, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_monitors_in_bytes/v3
> 
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v7
> [1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/
> 
> [v1] https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com/
> [v2] https://lore.kernel.org/lkml/20211001160302.31189-1-james.morse@arm.com/
> 
> Thanks,
> 
> James Morse (21):
>   x86/resctrl: Kill off alloc_enabled
>   x86/resctrl: Merge mon_capable and mon_enabled
>   x86/resctrl: Add domain online callback for resctrl work
>   x86/resctrl: Group struct rdt_hw_domain cleanup
>   x86/resctrl: Add domain offline callback for resctrl work
>   x86/resctrl: Remove set_mba_sc()s control array re-initialisation
>   x86/resctrl: Create mba_sc configuration in the rdt_domain
>   x86/resctrl: Switch over to the resctrl mbps_val list
>   x86/resctrl: Remove architecture copy of mbps_val
>   x86/resctrl: Abstract and use supports_mba_mbps()
>   x86/resctrl: Allow update_mba_bw() to update controls directly
>   x86/resctrl: Calculate bandwidth from the previous __mon_event_count()
>     chunks
>   x86/recstrl: Add per-rmid arch private storage for overflow and chunks
>   x86/recstrl: Allow per-rmid arch private storage to be reset
>   x86/resctrl: Abstract __rmid_read()
>   x86/resctrl: Pass the required parameters into
>     resctrl_arch_rmid_read()
>   x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
>   x86/resctrl: Move get_corrected_mbm_count() into
>     resctrl_arch_rmid_read()
>   x86/resctrl: Rename and change the units of resctrl_cqm_threshold
>   x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's
>     boot_cpu_data
>   x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
> 
>  arch/x86/kernel/cpu/resctrl/core.c        | 117 ++++--------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  75 +++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  61 +++----
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 211 ++++++++++++++--------
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 205 +++++++++++++++++----
>  include/linux/resctrl.h                   |  62 ++++++-
>  7 files changed, 478 insertions(+), 255 deletions(-)

Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
