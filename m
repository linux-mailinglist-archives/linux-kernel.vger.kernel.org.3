Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E4546837F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384428AbhLDJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384422AbhLDJRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:17:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75860C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 01:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=40DL9oGEmTOO27E5h86qeKzj4QLj0MixZPKrxmbZcRY=; b=W9a+nB1BVI9r7k9+iZw5Q9+WAV
        GgWiL9BHUHoIkoGzuxyBApTFU06msZ6L0uiPbvUPA6OUBh1gBFhBK2kFXdkcog1ToXA0BM2V+yAsD
        Wkt3G98n1h0nX+OJAnkBRMGLjXHk+5hJpLg8NK7vj3nW/p2nd7qiTwVOca9g0DHOHp9GDDQWcUE8b
        6do//wLUZ5Lh4qyufeq760xK4ObD0Xgd3Vp/iYBn+iTTD/rUOJ1TBgxMCY5FOtWFC4tw3bbHS4WQM
        kO23j+q1+KoNbTceRYTC9Dlo5iFtYmFbt3/SxfkHrWu9KFR9A1khGNYFDBWJW6ek9anOx+DaXzjdM
        1nhh9olQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtR7L-002AUX-0j; Sat, 04 Dec 2021 09:14:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A89C98106D; Sat,  4 Dec 2021 10:14:02 +0100 (CET)
Date:   Sat, 4 Dec 2021 10:14:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        Michael Larabel <Michael@MichaelLarabel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Make Cluster Scheduling Configurable
Message-ID: <20211204091402.GM16608@worktop.programming.kicks-ass.net>
References: <cover.1638563225.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638563225.git.tim.c.chen@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 12:32:37PM -0800, Tim Chen wrote:
> Tim Chen (5):
>   scheduler: Create SDTL_SKIP flag to skip topology level
>   scheduler: Add SD_CLUSTER topology flag to cluster sched domain
>   scheduler: Add runtime knob sysctl_sched_cluster
>   scheduler: Add boot time enabling/disabling of cluster scheduling
>   scheduler: Default cluster scheduling to off on x86 hybrid CPU

s/scheduler:/sched:/, surely?

>  .../admin-guide/kernel-parameters.txt         |  4 +
>  arch/x86/kernel/smpboot.c                     | 26 +++++++
>  drivers/base/arch_topology.c                  | 23 +++++-
>  include/linux/sched/sd_flags.h                |  7 ++
>  include/linux/sched/sysctl.h                  |  6 ++
>  include/linux/sched/topology.h                |  3 +-
>  include/linux/topology.h                      |  7 ++
>  kernel/sched/core.c                           |  1 +
>  kernel/sched/sched.h                          |  6 ++
>  kernel/sched/topology.c                       | 75 ++++++++++++++++++-
>  kernel/sysctl.c                               | 11 +++
>  11 files changed, 163 insertions(+), 6 deletions(-)

*groan*,... I was more thinking of something like so.

---
 arch/x86/kernel/smpboot.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ac2909f0cab3..617012f4619f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -579,6 +579,17 @@ static struct sched_domain_topology_level x86_numa_in_package_topology[] = {
 	{ NULL, },
 };
 
+static struct sched_domain_topology_level x86_hybrid_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+#ifdef CONFIG_SCHED_MC
+	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
+#endif
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
 static struct sched_domain_topology_level x86_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
@@ -1469,8 +1480,11 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 
 	calculate_max_logical_packages();
 
+	/* XXX for now assume numa-in-package and hybrid don't overlap */
 	if (x86_has_numa_in_package)
 		set_sched_topology(x86_numa_in_package_topology);
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		set_sched_topology(x86_hybrid_topology);
 
 	nmi_selftest();
 	impress_friends();
