Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9222536CE0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355874AbiE1M1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355826AbiE1M1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 08:27:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF71F1B7BF
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653740859; x=1685276859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OUTmfqIVpj+C34M+/IQGpHwTDrfF1IhtKteO00gm0es=;
  b=FR7NqXV9LMnCLH/MS03iuY+RrJJJ0dHOyk1d9OreuaS/VkCZ3LlEjl6G
   R02maOr5IcLaivHy1yG+/Pv3mzb3wV0uQyr1fYhqRZXelhVbodjXLnb6O
   487SsVwcHvYMosOTrKzP5tiqEdK53KXIV6AjEdjDAkOgdmj9jWKvZ/d/d
   NzFb0HvDa4vAuV8bR1+OIzN1WlJzkF5eeXETyFyuXbG+u6iqjiX31oDW5
   S1U6+Pdi29Smi4r3r9ZqneEoVYcYB4cZxMouKvPba8ZY/Q0cSR762O2h8
   4+Qk/sVuz/bQsQv7qSxUcSX+DiymoS8Z92xRdz+qUlxTTJ/a/kCxVXZvJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="255159381"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="255159381"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 05:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="902926279"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 May 2022 05:27:37 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuvXc-0000CK-CG;
        Sat, 28 May 2022 12:27:36 +0000
Date:   Sat, 28 May 2022 20:26:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yue Zou <zouyue3@huawei.com>, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, mhiramat@kernel.org,
        rostedt@goodmis.org, ahalaney@redhat.com, vbabka@suse.cz,
        Jason@zx2c4.com, mark-pk.tsai@mediatek.com,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH -next] smp: Move stub from main.c into smp.h
Message-ID: <202205282032.H8Urbl9N-lkp@intel.com>
References: <20220528111122.1888581-1-zouyue3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528111122.1888581-1-zouyue3@huawei.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220527]

url:    https://github.com/intel-lab-lkp/linux/commits/Yue-Zou/smp-Move-stub-from-main-c-into-smp-h/20220528-185146
base:    d3fde8ff50ab265749704bd7fbcf70d35235421f
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220528/202205282032.H8Urbl9N-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2efe286bd89edfa5448d29a5be89fd54df424c46
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yue-Zou/smp-Move-stub-from-main-c-into-smp-h/20220528-185146
        git checkout 2efe286bd89edfa5448d29a5be89fd54df424c46
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/smp.h:186:27: warning: 'setup_max_cpus' defined but not used [-Wunused-const-variable=]
     186 | static const unsigned int setup_max_cpus = NR_CPUS;
         |                           ^~~~~~~~~~~~~~
--
   fs/d_path.c:318:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
     318 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
         |       ^~~~~~~~~~~~
   In file included from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from fs/d_path.c:2:
>> include/linux/smp.h:186:27: warning: 'setup_max_cpus' defined but not used [-Wunused-const-variable=]
     186 | static const unsigned int setup_max_cpus = NR_CPUS;
         |                           ^~~~~~~~~~~~~~
--
   fs/io_uring.c: In function '__io_submit_flush_completions':
   fs/io_uring.c:3152:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    3152 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   In file included from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from fs/io_uring.c:45:
   At top level:
>> include/linux/smp.h:186:27: warning: 'setup_max_cpus' defined but not used [-Wunused-const-variable=]
     186 | static const unsigned int setup_max_cpus = NR_CPUS;
         |                           ^~~~~~~~~~~~~~
--
   In file included from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:20,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/smp.h:186:27: warning: 'setup_max_cpus' defined but not used [-Wunused-const-variable=]
     186 | static const unsigned int setup_max_cpus = NR_CPUS;
         |                           ^~~~~~~~~~~~~~


vim +/setup_max_cpus +186 include/linux/smp.h

   185	
 > 186	static const unsigned int setup_max_cpus = NR_CPUS;
   187	static inline void setup_nr_cpu_ids(void) { }
   188	static inline void smp_prepare_cpus(unsigned int maxcpus) { }
   189	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
