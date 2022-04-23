Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0BF50C7B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 07:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiDWGBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 02:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiDWGBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 02:01:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615037642
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650693531; x=1682229531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OAXIXrUNWg62uanhPdyhxS+ibbfcv+PR/GWk9a6cA/A=;
  b=Gyo2lEyu3hCvLENyAzzjxpM+0xnubP8faW7kSN8O822wZLf+Fl7Pbmm4
   QI93t2VKNF9vOCfHvaXAn+Jpfv5JsbSO2ZakSvBXYusaNc3nXp9n8mrcG
   bm6Zf/AIvi8Hy6yJLmje8/V0u7gymjwWMX6aVAXMo8PyNJv/XjE9mgVab
   HUkTLCqJcd4yNQh6ClJeeWIjlXzQ9QF75O4M9MuHm6F0ZOd1LWqgpjSq4
   JUDDh36ZskT5QkRM5cGX2Rr4EbRm6z37WrWoXGg7CZIkFXM1K7ZWn8lVz
   4/H2cV0oLECmTlKC0WN4MFmap39w6rhhrzvUkJyrkVvmEeTyR6S6nb3L6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="327770995"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="327770995"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 22:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="806292341"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2022 22:58:47 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni8n8-000B4F-FD;
        Sat, 23 Apr 2022 05:58:46 +0000
Date:   Sat, 23 Apr 2022 13:58:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Donghai Qiao <dqiao@redhat.com>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, arnd@arndb.de, peterz@infradead.org,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: Re: [PATCH v2 11/11] smp: modify up.c to adopt the same format of
 cross CPU call.
Message-ID: <202204231305.905VHc1H-lkp@intel.com>
References: <20220422200040.93813-12-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-12-dqiao@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Donghai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on rafael-pm/linux-next linus/master v5.18-rc3]
[cannot apply to tip/x86/core next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Donghai-Qiao/smp-cross-CPU-call-interface/20220423-060436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220423/202204231305.905VHc1H-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/655b898028ef1555f6bec036db8d4681b551aaa8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Donghai-Qiao/smp-cross-CPU-call-interface/20220423-060436
        git checkout 655b898028ef1555f6bec036db8d4681b551aaa8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/up.c:50:11: error: use of undeclared identifier 'cpu'
           smp_call(cpu, func, info, type);
                    ^
   kernel/up.c:80:12: error: use of undeclared identifier 'cpu'
                   smp_call(cpu, func, info, type);
                            ^
   2 errors generated.


vim +/cpu +50 kernel/up.c

    41	
    42	void smp_call_mask(const struct cpumask *mask, smp_call_func_t func, void *info, unsigned int type)
    43	{
    44		unsigned long flags;
    45	
    46		if (!cpumask_test_cpu(0, mask))
    47			return;
    48	
    49		preempt_disable();
  > 50		smp_call(cpu, func, info, type);
    51		preempt_enable();
    52	}
    53	EXPORT_SYMBOL(smp_call_mask);
    54	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
