Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35B355FF27
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiF2L7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiF2L67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:58:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D720B387B1;
        Wed, 29 Jun 2022 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656503938; x=1688039938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rqyy90LBrWIUchSPPwXkNXZArjHXk98JSzOsryKu6/0=;
  b=ntWO2YS5fFejrcDSW1GjteybebECugotLkHLzl405KTvQH16OLedpacb
   I2WgIKdc7uo9QCqsUNYVB1Drod92GCQPXz4pXSYyl45rVMZKpUbBTMPkw
   X0ErSUCvF/89MWks/l9UqWlyDjnlp20GoiIvtpaHuVkUCE+rd7I1QHAak
   7MSJVovDvxCYclLjP+rObP0YZV0KlTa++aEnjFQ4vn3qV2b8WxcCL6kP2
   Lo1f5bCJ3G6pCgVp+lFSbpbOe8Y9xLic7HbuS/Hq4Znau98yWv4nEKKJv
   Xar7arCPHry/kWT6d5hisej/MigwIbH/QuHpDimijMUomPCOmpqqtz+IO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="261812421"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="261812421"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="917577894"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2022 04:58:56 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6WLP-000B98-UF;
        Wed, 29 Jun 2022 11:58:55 +0000
Date:   Wed, 29 Jun 2022 19:58:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     xiongxin <xiongxin@kylinos.cn>, rafael@kernel.org,
        len.brown@intel.com, pavel@ucw.cz
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiongxin@kylinos.cn
Subject: Re: [PATCH -next 2/2] PM: suspend: advanced pm_wakeup_clear() for
 normal suspend/hibernate
Message-ID: <202206291941.94EV5b6M-lkp@intel.com>
References: <20220629003338.299195-3-xiongxin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629003338.299195-3-xiongxin@kylinos.cn>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi xiongxin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220628]

url:    https://github.com/intel-lab-lkp/linux/commits/xiongxin/PM-suspend-Optimized-suspend-is-fail-returned-by-wakeup/20220629-114731
base:    cb71b93c2dc36d18a8b05245973328d018272cdf
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220629/202206291941.94EV5b6M-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2e0bc447b95996d1757038708bd6adf613f0b936
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review xiongxin/PM-suspend-Optimized-suspend-is-fail-returned-by-wakeup/20220629-114731
        git checkout 2e0bc447b95996d1757038708bd6adf613f0b936
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/power/process.c: In function 'freeze_processes':
>> kernel/power/process.c:134:13: error: 'pm_suspend_target_state' undeclared (first use in this function)
     134 |         if (pm_suspend_target_state != PM_SUSPEND_ON)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/power/process.c:134:13: note: each undeclared identifier is reported only once for each function it appears in


vim +/pm_suspend_target_state +134 kernel/power/process.c

   112	
   113	/**
   114	 * freeze_processes - Signal user space processes to enter the refrigerator.
   115	 * The current thread will not be frozen.  The same process that calls
   116	 * freeze_processes must later call thaw_processes.
   117	 *
   118	 * On success, returns 0.  On failure, -errno and system is fully thawed.
   119	 */
   120	int freeze_processes(void)
   121	{
   122		int error;
   123	
   124		error = __usermodehelper_disable(UMH_FREEZING);
   125		if (error)
   126			return error;
   127	
   128		/* Make sure this task doesn't get frozen */
   129		current->flags |= PF_SUSPEND_TASK;
   130	
   131		if (!pm_freezing)
   132			atomic_inc(&system_freezing_cnt);
   133	
 > 134		if (pm_suspend_target_state != PM_SUSPEND_ON)
   135			pm_wakeup_clear(1);
   136		else
   137			pm_wakeup_clear(0);
   138		pr_info("Freezing user space processes ... ");
   139		pm_freezing = true;
   140		error = try_to_freeze_tasks(true);
   141		if (!error) {
   142			__usermodehelper_set_disable_depth(UMH_DISABLED);
   143			pr_cont("done.");
   144		}
   145		pr_cont("\n");
   146		BUG_ON(in_atomic());
   147	
   148		/*
   149		 * Now that the whole userspace is frozen we need to disable
   150		 * the OOM killer to disallow any further interference with
   151		 * killable tasks. There is no guarantee oom victims will
   152		 * ever reach a point they go away we have to wait with a timeout.
   153		 */
   154		if (!error && !oom_killer_disable(msecs_to_jiffies(freeze_timeout_msecs)))
   155			error = -EBUSY;
   156	
   157		if (error)
   158			thaw_processes();
   159		return error;
   160	}
   161	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
