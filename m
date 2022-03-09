Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9324D2BFF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiCIJaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiCIJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:29:58 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE597EB30C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646818140; x=1678354140;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=CVn+ZT5avv8HOvgaAaNLsjJaTQhv2nlshh1mq8i1iV0=;
  b=PtMsaIwJ3kfOyZcsWNiS4AJcVsSadbaZ5ww5MZj22Ng9GedneYnMidbt
   H64qXkFfc4ATBMgaAbcN7tHruJLZDPLdnMwjN2CkEGZ63AOeCP7s21QFL
   6bFMiL0yqo3XIk+Ah1WN7RjpIPPUFPVFu9WCesumimVRXZ52ZeiPSxS6v
   P6cSwLiVEcNV5x7u/9u8veSUQOlISVz9noGAYzeudkJh+A2HcYe3BD7vo
   T45PVQ1LxE6wJktGiOgEj03kACyaTwhOMryqRT6MiY51QjhVo0qp0tF9v
   hghqEyUtiixA56xxuCX02+g2F0oxrf9BfSDcXsyv1fALKqYNB4d9qcdlc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252501840"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="252501840"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 01:29:00 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="537936493"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 01:28:57 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, fengwei.yin@intel.com,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [LKP] Re: [sched/numa]  0fb3978b0a:
  stress-ng.fstat.ops_per_sec -18.9% regression
References: <20220302140220.GA32817@xsang-OptiPlex-9020>
        <87mti7s9xz.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Wed, 09 Mar 2022 17:28:55 +0800
In-Reply-To: <87mti7s9xz.fsf@yhuang6-desk2.ccr.corp.intel.com> (Ying Huang's
        message of "Thu, 03 Mar 2022 16:43:20 +0800")
Message-ID: <87tuc7fp9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All,

"Huang, Ying" <ying.huang@intel.com> writes:

> Hi, Oliver,
>
> Thanks for report.
>
> I still cannot connect the regression with the patch yet.  To double
> check, I have run test again with "sched_verbose" kernel command line,
> and verified that the sched_domain isn't changed at all with the patch.
>
> kernel test robot <oliver.sang@intel.com> writes:
>>       0.11   6%      +0.1        0.16   4%  perf-profile.self.cycles-pp.update_rq_clock
>>       0.00            +0.1        0.06   6%  perf-profile.self.cycles-pp.memset_erms
>>       0.00            +0.1        0.07   5%  perf-profile.self.cycles-pp.get_pid_task
>>       0.06   7%      +0.1        0.17   6%  perf-profile.self.cycles-pp.select_task_rq_fair
>>       0.54   5%      +0.1        0.68        perf-profile.self.cycles-pp.lockref_put_return
>>       4.26            +1.1        5.33        perf-profile.self.cycles-pp.common_perm_cond
>>      15.45            +4.9       20.37        perf-profile.self.cycles-pp.lockref_put_or_lock
>>      20.12            +6.7       26.82        perf-profile.self.cycles-pp.lockref_get_not_dead
>
> From the perf-profile above, the most visible change is more cycles in
> lockref_get_not_dead(), which will loop with cmpxchg on
> dentry->d_lockref.  So this appears to be related to the memory layout.
> I will try to debug that.
>
> Because stress-ng is a weird "benchmark" although it's a very good
> functionality test, and I cannot connect the patch with the test case
> and performance metrics collected.  I think this regression should be a
> low priority one which shouldn't prevent the merging etc.  But I will
> continue to investigate the regression to try to root cause it.

Done more investigation for this.  It turns out the sched_domain has
been changed after commit 0fb3978b0a, although it's not shown in default
sched_verbose output.  sd->imb_numa_nr of level "NUMA" has been changed
from 24 to 12 after the commit.  So the following debug patch restore
the performance.

From 6c79c858248196ea71da4be02a0774bb6e277581 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 9 Mar 2022 10:45:18 +0800
Subject: [PATCH] dbg: restore sd->imb_numa_nr

---
 kernel/sched/topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5e05fb7a817b..c348747e4166 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2351,6 +2351,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 					sd->name, imb, factor, sd->imb_numa_nr);
 #endif
 			}
+#ifdef CONFIG_SCHED_DEBUG
+			if (!strcmp(sd->name, "NUMA"))
+				sd->imb_numa_nr = 24;
+#endif
 		}
 	}
 
-- 
2.30.2

I haven't researched much about the influence of sd->imb_numa_nr.  But
it seems that commit 0fb3978b0a just follows the behavior of a normal 2
sockets (2 LLCs) machine.  This is intended.  So the regression report
isn't important for the commit itself.

About the impact of sd->imb_numa_nr, we will continue work on that.

Best Regards,
Huang, Ying
