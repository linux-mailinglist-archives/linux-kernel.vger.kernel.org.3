Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA464C058F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbiBVXxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiBVXxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:53:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B22D3337D;
        Tue, 22 Feb 2022 15:52:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122EF611C8;
        Tue, 22 Feb 2022 23:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C0C340E8;
        Tue, 22 Feb 2022 23:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645573956;
        bh=UwaC5xY+ZaDH26vO4EYbimVhcqyY47M9XO1A6/S8skU=;
        h=From:To:Cc:Subject:Date:From;
        b=nwo8uyYMIf7IAKkP0j1TRdG9qYY7wE3B4N3HLA9pPUzcHg3OPHdWNUmcvaZMqSF+g
         Maj0fyyV9zvDUBUfEpJUiVHylcqnVcLLR8tffz4bhAi0UOMlVKtZksiYDYuhIXoj3r
         dPNDSvxPXHDHbCHzpCxU1GOHNF9aON8r+m9ClNqZcFqy4wTTxTwCL79iJWjFP6l8yJ
         VEb5jg9TGS/npKWFpZ6xPG69lOduKtv7SUThsHrqF1w2cHRZDYBJiEUMa/iQBiQ54V
         5uzNJRY0E3ozKci48z2oBL43lKvttrxvr5vdlRUB5ND4CIP/r254QqoxfvuD6okRH+
         rBbHCFUusM6Ag==
From:   broonie@kernel.org
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        sujiaxun <sujiaxun@uniontech.com>,
        tangmeng <tangmeng@uniontech.com>,
        zhanglianjie <zhanglianjie@uniontech.com>,
        Zhen Ni <nizhen@uniontech.com>
Subject: linux-next: manual merge of the sysctl tree with the tip tree
Date:   Tue, 22 Feb 2022 23:52:18 +0000
Message-Id: <20220222235218.906101-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the sysctl tree got conflicts in:

  include/linux/sched/sysctl.h
  kernel/sysctl.c

between commit:

  c8eaf6ac76f40 ("sched: move autogroup sysctls into its own file")

from the tip tree and commits:

  fc12aa67daba8 ("kernel/do_mount_initrd: move real_root_dev sysctls to its own file")
  97d4da3bab169 ("kernel/delayacct: move delayacct sysctls to its own file")
  c7c1839c3c942 ("kernel/acct: move acct sysctls to its own file")
  b5fefe080be0f ("kernel/panic: move panic sysctls to its own file")
  3831fb33e3f35 ("kernel/lockdep: move lockdep sysctls to its own file")
  f31483d6edf09 ("sched: Move energy_aware sysctls to topology.c")
  301ee4d2abae7 ("sched: Move cfs_bandwidth_slice sysctls to fair.c")
  eb862b3dc6dbf ("sched: Move uclamp_util sysctls to core.c")
  4925401d06dc2 ("sched: Move rr_timeslice sysctls to rt.c")
  ebb891f03580b ("sched: Move deadline_period sysctls to deadline.c")
  5f6e55c2485c8 ("sched: Move rt_period/runtime sysctls to rt.c")

from the sysctl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc include/linux/sched/sysctl.h
index 3f2b70f8d32ce,187d8c1eade69..0000000000000
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@@ -23,46 -21,11 +21,7 @@@ enum sched_tunable_scaling 
  	SCHED_TUNABLESCALING_END,
  };
  
- /*
-  *  control realtime throttling:
-  *
-  *  /proc/sys/kernel/sched_rt_period_us
-  *  /proc/sys/kernel/sched_rt_runtime_us
-  */
- extern unsigned int sysctl_sched_rt_period;
- extern int sysctl_sched_rt_runtime;
- 
- extern unsigned int sysctl_sched_dl_period_max;
- extern unsigned int sysctl_sched_dl_period_min;
- 
- #ifdef CONFIG_UCLAMP_TASK
- extern unsigned int sysctl_sched_uclamp_util_min;
- extern unsigned int sysctl_sched_uclamp_util_max;
- extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
- #endif
- 
- #ifdef CONFIG_CFS_BANDWIDTH
- extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 -#ifdef CONFIG_SCHED_AUTOGROUP
 -extern unsigned int sysctl_sched_autogroup_enabled;
--#endif
- 
- extern int sysctl_sched_rr_timeslice;
- extern int sched_rr_timeslice;
--
- int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
- 		size_t *lenp, loff_t *ppos);
- int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
- 		size_t *lenp, loff_t *ppos);
- int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
- 		void *buffer, size_t *lenp, loff_t *ppos);
  int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
  		size_t *lenp, loff_t *ppos);
- int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
- 		size_t *lenp, loff_t *ppos);
- 
- #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
- extern unsigned int sysctl_sched_energy_aware;
- int sched_energy_aware_handler(struct ctl_table *table, int write,
- 		void *buffer, size_t *lenp, loff_t *ppos);
- #endif
  
  #endif /* _LINUX_SCHED_SYSCTL_H */
diff --cc kernel/sysctl.c
index 6a494ab55beaf,22037f03cd2bc..0000000000000
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@@ -1701,103 -1654,17 +1663,6 @@@ static struct ctl_table kern_table[] = 
  		.extra2		= SYSCTL_ONE,
  	},
  #endif /* CONFIG_NUMA_BALANCING */
- 	{
- 		.procname	= "sched_rt_period_us",
- 		.data		= &sysctl_sched_rt_period,
- 		.maxlen		= sizeof(unsigned int),
- 		.mode		= 0644,
- 		.proc_handler	= sched_rt_handler,
- 	},
- 	{
- 		.procname	= "sched_rt_runtime_us",
- 		.data		= &sysctl_sched_rt_runtime,
- 		.maxlen		= sizeof(int),
- 		.mode		= 0644,
- 		.proc_handler	= sched_rt_handler,
- 	},
- 	{
- 		.procname	= "sched_deadline_period_max_us",
- 		.data		= &sysctl_sched_dl_period_max,
- 		.maxlen		= sizeof(unsigned int),
- 		.mode		= 0644,
- 		.proc_handler	= proc_dointvec,
- 	},
- 	{
- 		.procname	= "sched_deadline_period_min_us",
- 		.data		= &sysctl_sched_dl_period_min,
- 		.maxlen		= sizeof(unsigned int),
- 		.mode		= 0644,
- 		.proc_handler	= proc_dointvec,
- 	},
- 	{
- 		.procname	= "sched_rr_timeslice_ms",
- 		.data		= &sysctl_sched_rr_timeslice,
- 		.maxlen		= sizeof(int),
- 		.mode		= 0644,
- 		.proc_handler	= sched_rr_handler,
- 	},
- #ifdef CONFIG_UCLAMP_TASK
- 	{
- 		.procname	= "sched_util_clamp_min",
- 		.data		= &sysctl_sched_uclamp_util_min,
- 		.maxlen		= sizeof(unsigned int),
- 		.mode		= 0644,
- 		.proc_handler	= sysctl_sched_uclamp_handler,
- 	},
- 	{
- 		.procname	= "sched_util_clamp_max",
- 		.data		= &sysctl_sched_uclamp_util_max,
- 		.maxlen		= sizeof(unsigned int),
- 		.mode		= 0644,
- 		.proc_handler	= sysctl_sched_uclamp_handler,
- 	},
- 	{
- 		.procname	= "sched_util_clamp_min_rt_default",
- 		.data		= &sysctl_sched_uclamp_util_min_rt_default,
- 		.maxlen		= sizeof(unsigned int),
- 		.mode		= 0644,
- 		.proc_handler	= sysctl_sched_uclamp_handler,
- 	},
- #endif
- #ifdef CONFIG_CFS_BANDWIDTH
 -#ifdef CONFIG_SCHED_AUTOGROUP
--	{
- 		.procname	= "sched_cfs_bandwidth_slice_us",
- 		.data		= &sysctl_sched_cfs_bandwidth_slice,
 -		.procname	= "sched_autogroup_enabled",
 -		.data		= &sysctl_sched_autogroup_enabled,
--		.maxlen		= sizeof(unsigned int),
--		.mode		= 0644,
--		.proc_handler	= proc_dointvec_minmax,
- 		.extra1		= SYSCTL_ONE,
- 	},
- #endif
- #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
- 	{
- 		.procname	= "sched_energy_aware",
- 		.data		= &sysctl_sched_energy_aware,
- 		.maxlen		= sizeof(unsigned int),
- 		.mode		= 0644,
- 		.proc_handler	= sched_energy_aware_handler,
--		.extra1		= SYSCTL_ZERO,
--		.extra2		= SYSCTL_ONE,
- 	},
- #endif
- #ifdef CONFIG_PROVE_LOCKING
- 	{
- 		.procname	= "prove_locking",
- 		.data		= &prove_locking,
- 		.maxlen		= sizeof(int),
- 		.mode		= 0644,
- 		.proc_handler	= proc_dointvec,
- 	},
- #endif
- #ifdef CONFIG_LOCK_STAT
- 	{
- 		.procname	= "lock_stat",
- 		.data		= &lock_stat,
- 		.maxlen		= sizeof(int),
- 		.mode		= 0644,
- 		.proc_handler	= proc_dointvec,
--	},
--#endif
  	{
  		.procname	= "panic",
  		.data		= &panic_timeout,
