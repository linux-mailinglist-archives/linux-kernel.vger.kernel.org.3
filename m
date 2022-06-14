Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6197D54A9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348934AbiFNHAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbiFNHAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:00:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC83B03B;
        Tue, 14 Jun 2022 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655190043; x=1686726043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PHYT8LtTB+UCVv1AVqoKGvivIiIEQbiDWdQzxCZx89Q=;
  b=mNga914b4kzUGz5zDDPZBTxluvpIv38YKwNI6AVmDq+WVOK228uNkCFb
   1BL1iNp8FZka3W8OXjanj9Kp49l55cxWvlGFjUPd3a5W6ymklL1weQYpD
   tIfGcini4bbqAq1jOJQLZ3pu4X8SiY0ZnqziMDjhS3SywCi5UXFQDX9SX
   gYqRwSAZJL/RYE/JBzhqdLi1sGZEe26FR2fpkxuu95g77JDicP0ioTT9f
   q76q57b/c/F5aCUHu3njkQyOplR1Er+j2ev83aqR2AOOGgIPa6wMgVIvA
   mKgznl+klqkAYSxyOeYfP0b74sq34DCc6vMbFXnbHw5IYTCU4QNU6lmt7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="342496382"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="342496382"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="617846962"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jun 2022 00:00:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o10XC-000LbB-7B;
        Tue, 14 Jun 2022 07:00:18 +0000
Date:   Tue, 14 Jun 2022 14:59:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 1/5] PM / devfreq: Fix cpufreq passive unregister
 erroring on PROBE_DEFER
Message-ID: <202206141415.1BsuJvCD-lkp@intel.com>
References: <20220613134213.8904-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613134213.8904-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on chanwoo/devfreq-testing]
[also build test ERROR on linus/master v5.19-rc2 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Ansuel-Marangi/PM-devfreq-Various-Fixes-to-cpufreq-based-passive-governor/20220614-020616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
config: arm-randconfig-r026-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141415.1BsuJvCD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c97436f8b6e2718286e8496faf53a2c800e281cf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/378807dd7da24162524c0ba84e996157b3e289c6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christian-Ansuel-Marangi/PM-devfreq-Various-Fixes-to-cpufreq-based-passive-governor/20220614-020616
        git checkout 378807dd7da24162524c0ba84e996157b3e289c6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/devfreq/governor_passive.c:235:72: error: too few arguments provided to function-like macro invocation
           list_for_each_entry_safe(parent_cpu_data, &p_data->cpu_data_list, node) {
                                                                                 ^
   include/linux/list.h:760:9: note: macro 'list_for_each_entry_safe' defined here
   #define list_for_each_entry_safe(pos, n, head, member)                  \
           ^
>> drivers/devfreq/governor_passive.c:235:2: error: use of undeclared identifier 'list_for_each_entry_safe'
           list_for_each_entry_safe(parent_cpu_data, &p_data->cpu_data_list, node) {
           ^
   2 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
   Depends on ARCH_SUSPEND_POSSIBLE
   Selected by
   - ARM_TEGRA_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_TEGRA || COMPILE_TEST && !ARM64 && MMU
   - ARM_QCOM_SPM_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_QCOM || COMPILE_TEST && !ARM64 && MMU


vim +235 drivers/devfreq/governor_passive.c

   220	
   221	static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
   222	{
   223		struct devfreq_passive_data *p_data
   224				= (struct devfreq_passive_data *)devfreq->data;
   225		struct devfreq_cpu_data *parent_cpu_data;
   226		int ret;
   227	
   228		if (p_data->nb.notifier_call) {
   229			ret = cpufreq_unregister_notifier(&p_data->nb,
   230						CPUFREQ_TRANSITION_NOTIFIER);
   231			if (ret < 0)
   232				return ret;
   233		}
   234	
 > 235		list_for_each_entry_safe(parent_cpu_data, &p_data->cpu_data_list, node) {
   236			list_del(&parent_cpu_data->node);
   237	
   238			if (parent_cpu_data->opp_table)
   239				dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
   240	
   241			kfree(parent_cpu_data);
   242		}
   243	
   244		return 0;
   245	}
   246	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
