Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE56F5B1EAE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiIHNYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIHNYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:24:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D134BF8278
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662643453; x=1694179453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4mM/be4xRu9iAMtnY+OTsAdF0ce1Y0x7jdy017x46LA=;
  b=CH406t3pQBjElaf/2ThUiunvldxjTgSX5OKjIwjMqnQoIO6JVtkd92it
   O5XRlqKbt/lIB/38gm7TJ8uxUz2zThE/oxmbqjvHwxqtDpKoXpF3Ahnvf
   Y091v8wpvzbRcQuBtuqtpfw2QKQ7xnBMZPwDeEltA6CwPKChuKNozSKSX
   abgrj80zg6J08zqzI0+yvu8PdwNXJ/NvDvUB+yYTKjmkaHvq+BJXq+hqu
   alOccrun8lJrpfckGJZWF83XbW70395HOSqQRSaOD1GRr240yzQIMwHD7
   Ma056zPCCnSnw7NAbx/655boppZU6DSHSSG2IBXJIlKKT7vCDF5CYG3hX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276899997"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="276899997"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="943342284"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 06:24:10 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWHVp-0007n5-2C;
        Thu, 08 Sep 2022 13:24:09 +0000
Date:   Thu, 8 Sep 2022 21:23:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Redpath <chris.redpath@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 1457/9999]
 kernel/sched/fair.c:7171 find_energy_efficient_cpu() warn: inconsistent
 indenting
Message-ID: <202209082104.85MdOYy3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: e56a97123c10e6d5ca2ce9a0f1329f02f79f2319 [1457/9999] ANDROID: Add find_best_target to minimise energy calculation overhead
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220908/202209082104.85MdOYy3-lkp@intel.com/config)
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
