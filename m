Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A0757EB82
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 04:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiGWCO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 22:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiGWCOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 22:14:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63620550DE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 19:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658542494; x=1690078494;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EWBnpyQ5vvpv4RH5JNb39sXUSCGSaq3sr26h68Er0G8=;
  b=NVROl13asz0T3gDt459wWNTLjFNdJ1XCdJ3PvLo1CnRc+wQPtRpY3ee1
   EpuRd3dl3vRMWCGUeqxp7vzMjWHJ5i/yE7DxWxKUaIFwPz+HTE4p36oHD
   uhUm7lRYoGVVH0EQpTeK4Ceq7ejG4OHGelnVNY8nLaSC04/ibL6rK4KWd
   of/0nDrQ0JQzXoPvXl/fvaTExeIC0q6kQWfHRSKL9nDS9MZ7agg9/vgNt
   89ylm5bXVvrVvNFCHEE1fCl7R6+42zwYLM4nwHVCoFlYUqJ6wopOXZ97C
   oiRTnC5B2tVWbmB0tHrI093lVx3QENmVMy/YZiHrZuH2i76/11/oBTYpK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="288195251"
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="288195251"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 19:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,187,1654585200"; 
   d="scan'208";a="725604996"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Jul 2022 19:14:52 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oF4fL-00024C-2p;
        Sat, 23 Jul 2022 02:14:51 +0000
Date:   Sat, 23 Jul 2022 10:13:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Redpath <chris.redpath@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 1457/9999]
 kernel/sched/fair.c:7171 find_energy_efficient_cpu() warn: inconsistent
 indenting
Message-ID: <202207231015.TQ62MYh3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: e56a97123c10e6d5ca2ce9a0f1329f02f79f2319 [1457/9999] ANDROID: Add find_best_target to minimise energy calculation overhead
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220723/202207231015.TQ62MYh3-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
kernel/sched/fair.c:7171 find_energy_efficient_cpu() warn: inconsistent indenting

vim +7171 kernel/sched/fair.c

  7092	
  7093	/*
  7094	 * Needs to be called inside rcu_read_lock critical section.
  7095	 * sd is a pointer to the sched domain we wish to use for an
  7096	 * energy-aware placement option.
  7097	 */
  7098	static int find_energy_efficient_cpu(struct sched_domain *sd,
  7099					     struct task_struct *p,
  7100					     int cpu, int prev_cpu,
  7101					     int sync)
  7102	{
  7103		int use_fbt = sched_feat(FIND_BEST_TARGET);
  7104		int cpu_iter, eas_cpu_idx = EAS_CPU_NXT;
  7105		int energy_cpu = prev_cpu;
  7106		struct energy_env *eenv;
  7107	
  7108		if (sysctl_sched_sync_hint_enable && sync) {
  7109			if (cpumask_test_cpu(cpu, &p->cpus_allowed)) {
  7110				return cpu;
  7111			}
  7112		}
  7113	
  7114		/* take ownership of our per-cpu data structure */
  7115		eenv = get_eenv(p, prev_cpu);
  7116		if (eenv->max_cpu_count < 2)
  7117			return energy_cpu;
  7118	
  7119		if(!use_fbt) {
  7120			/*
  7121			 * using this function outside wakeup balance will not supply
  7122			 * an sd ptr. Instead, fetch the highest level with energy data.
  7123			 */
  7124			if (!sd)
  7125				sd = rcu_dereference(per_cpu(sd_ea, prev_cpu));
  7126	
  7127			for_each_cpu_and(cpu_iter, &p->cpus_allowed, sched_domain_span(sd)) {
  7128				unsigned long spare;
  7129	
  7130				/* prev_cpu already in list */
  7131				if (cpu_iter == prev_cpu)
  7132					continue;
  7133	
  7134				spare = capacity_spare_wake(cpu_iter, p);
  7135	
  7136				if (spare * 1024 < capacity_margin * task_util(p))
  7137					continue;
  7138	
  7139				/* Add CPU candidate */
  7140				eenv->cpu[eas_cpu_idx++].cpu_id = cpu_iter;
  7141				eenv->max_cpu_count = eas_cpu_idx;
  7142	
  7143				/* stop adding CPUs if we have no space left */
  7144				if (eas_cpu_idx >= eenv->eenv_cpu_count)
  7145					break;
  7146			}
  7147		} else {
  7148			int boosted = (schedtune_task_boost(p) > 0);
  7149			int prefer_idle;
  7150	
  7151			/*
  7152			 * give compiler a hint that if sched_features
  7153			 * cannot be changed, it is safe to optimise out
  7154			 * all if(prefer_idle) blocks.
  7155			 */
  7156			prefer_idle = sched_feat(EAS_PREFER_IDLE) ?
  7157					(schedtune_prefer_idle(p) > 0) : 0;
  7158	
  7159			eenv->max_cpu_count = EAS_CPU_BKP+1;
  7160	
  7161			/* Find a cpu with sufficient capacity */
  7162			eenv->cpu[EAS_CPU_NXT].cpu_id = find_best_target(p,
  7163					&eenv->cpu[EAS_CPU_BKP].cpu_id,
  7164					boosted, prefer_idle);
  7165	
  7166			/* take note if no backup was found */
  7167			if (eenv->cpu[EAS_CPU_BKP].cpu_id < 0)
  7168				eenv->max_cpu_count = EAS_CPU_BKP;
  7169	
  7170			/* take note if no target was found */
> 7171			 if (eenv->cpu[EAS_CPU_NXT].cpu_id < 0)
  7172				 eenv->max_cpu_count = EAS_CPU_NXT;
  7173		}
  7174	
  7175		if (eenv->max_cpu_count == EAS_CPU_NXT) {
  7176			/*
  7177			 * we did not find any energy-awareness
  7178			 * candidates beyond prev_cpu, so we will
  7179			 * fall-back to the regular slow-path.
  7180			 */
  7181			return energy_cpu;
  7182		}
  7183	
  7184		/* find most energy-efficient CPU */
  7185		eas_cpu_idx = select_energy_cpu_idx(eenv);
  7186		energy_cpu = eenv->cpu[eas_cpu_idx].cpu_id;
  7187	
  7188		return energy_cpu;
  7189	}
  7190	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
