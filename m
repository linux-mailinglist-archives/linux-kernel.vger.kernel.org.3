Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ABA509871
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385282AbiDUGtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385174AbiDUGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F741572C;
        Wed, 20 Apr 2022 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523436; x=1682059436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8tuzYD0kzCxwjDALEtiW/79HnfPkTWedPSRkSD6YBCc=;
  b=Rfp15x59W1iWfViGMrSAtLaf5j1HT+83gDIRH0JVf3YR58rCKCO7R7jY
   U/IOiG34fRCf8tml3BnJoSvxWpjoplrq5x5r3uuwOBuPTx0ERQjl2rFPo
   jYAWCPkx1HgiOCIqgxdqKuQH1Dy+MoBy0Cflb65EHnx9BsqprgmOMf7AN
   BgK5Xe/G35uWp/3Kx+L4iXjuQZ6iP2pSm7CDcaB2ZSDCsEYQZAOIVP6tb
   4beSGKNh9LlpopqiSA3AZB2T3+UgiNmOIFAVQBeOEB2ohXf/gptnCXZWr
   a57iEKVdxDLk2/BxrNGaP+e9z+n9qSws66vw/PWD/1zq7ADbsPK6ccAPQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="289369465"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="289369465"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="670049059"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2022 23:43:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXf-000811-5k;
        Thu, 21 Apr 2022 06:43:51 +0000
Date:   Thu, 21 Apr 2022 14:43:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>, mcgrof@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, cl@linux.com,
        pmladek@suse.com, mbenes@suse.cz, christophe.leroy@csgroup.eu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com
Subject: Re: [PATCH v3 2/2] module: Introduce module unload taint tracking
Message-ID: <202204210819.DQQP836u-lkp@intel.com>
References: <20220420115257.3498300-3-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420115257.3498300-3-atomlin@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on eeaec7801c421e17edda6e45a32d4a5596b633da]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/module-Introduce-module-unload-taint-tracking/20220420-195459
base:   eeaec7801c421e17edda6e45a32d4a5596b633da
config: hexagon-randconfig-r045-20220420 (https://download.01.org/0day-ci/archive/20220421/202204210819.DQQP836u-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/523ff1f52de42049b9cc5a4db0495a5f21a7ee7c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aaron-Tomlin/module-Introduce-module-unload-taint-tracking/20220420-195459
        git checkout 523ff1f52de42049b9cc5a4db0495a5f21a7ee7c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/module/main.c:3204:2: error: meaningless 'volatile' on asm outside function
           preempt_enable();
           ^
   include/linux/preempt.h:277:28: note: expanded from macro 'preempt_enable'
   #define preempt_enable()                        barrier()
                                                   ^
   include/linux/compiler.h:86:28: note: expanded from macro 'barrier'
   # define barrier() __asm__ __volatile__("": : :"memory")
                              ^
   kernel/module/main.c:3204:2: error: expected ')'
   include/linux/preempt.h:277:28: note: expanded from macro 'preempt_enable'
   #define preempt_enable()                        barrier()
                                                   ^
   include/linux/compiler.h:86:43: note: expanded from macro 'barrier'
   # define barrier() __asm__ __volatile__("": : :"memory")
                                             ^
   kernel/module/main.c:3204:2: note: to match this '('
   include/linux/preempt.h:277:28: note: expanded from macro 'preempt_enable'
   #define preempt_enable()                        barrier()
                                                   ^
   include/linux/compiler.h:86:40: note: expanded from macro 'barrier'
   # define barrier() __asm__ __volatile__("": : :"memory")
                                          ^
   kernel/module/main.c:3205:2: error: expected identifier or '('
           if (last_unloaded_module[0])
           ^
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   kernel/module/main.c:3207:2: error: expected identifier or '('
           pr_cont("\n");
           ^
   include/linux/printk.h:531:2: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
           ^
   include/linux/printk.h:446:26: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                            ^
   include/linux/printk.h:416:3: note: expanded from macro 'printk_index_wrap'
           ({                                                              \
            ^
   kernel/module/main.c:3207:2: error: expected ')'
   include/linux/printk.h:531:2: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
           ^
   include/linux/printk.h:446:26: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                            ^
   include/linux/printk.h:416:3: note: expanded from macro 'printk_index_wrap'
           ({                                                              \
            ^
   kernel/module/main.c:3207:2: note: to match this '('
   include/linux/printk.h:531:2: note: expanded from macro 'pr_cont'
           printk(KERN_CONT fmt, ##__VA_ARGS__)
           ^
   include/linux/printk.h:446:26: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                            ^
   include/linux/printk.h:416:2: note: expanded from macro 'printk_index_wrap'
           ({                                                              \
           ^
   kernel/module/main.c:3208:1: error: extraneous closing brace ('}')
   }
   ^
   6 errors generated.


vim +/volatile +3204 kernel/module/main.c

e610499e2656e61 kernel/module.c      Rusty Russell  2009-03-31  3172  
^1da177e4c3f415 kernel/module.c      Linus Torvalds 2005-04-16  3173  /* Don't grab lock, we're oopsing. */
^1da177e4c3f415 kernel/module.c      Linus Torvalds 2005-04-16  3174  void print_modules(void)
^1da177e4c3f415 kernel/module.c      Linus Torvalds 2005-04-16  3175  {
^1da177e4c3f415 kernel/module.c      Linus Torvalds 2005-04-16  3176  	struct module *mod;
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3177  #ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3178  	struct mod_unload_taint *mod_taint;
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3179  #endif
7fd8329ba502ef7 kernel/module.c      Petr Mladek    2016-09-21  3180  	char buf[MODULE_FLAGS_BUF_SIZE];
^1da177e4c3f415 kernel/module.c      Linus Torvalds 2005-04-16  3181  
b231125af7811a2 kernel/module.c      Linus Torvalds 2009-06-16  3182  	printk(KERN_DEFAULT "Modules linked in:");
d72b37513cdfbd3 kernel/module.c      Andi Kleen     2008-08-30  3183  	/* Most callers should already have preempt disabled, but make sure */
d72b37513cdfbd3 kernel/module.c      Andi Kleen     2008-08-30  3184  	preempt_disable();
0d21b0e3477395e kernel/module.c      Rusty Russell  2013-01-12  3185  	list_for_each_entry_rcu(mod, &modules, list) {
0d21b0e3477395e kernel/module.c      Rusty Russell  2013-01-12  3186  		if (mod->state == MODULE_STATE_UNFORMED)
0d21b0e3477395e kernel/module.c      Rusty Russell  2013-01-12  3187  			continue;
27bba4d6bb3779a kernel/module.c      Jiri Slaby     2014-02-03  3188  		pr_cont(" %s%s", mod->name, module_flags(mod, buf));
0d21b0e3477395e kernel/module.c      Rusty Russell  2013-01-12  3189  	}
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3190  #ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3191  	if (!list_empty(&unloaded_tainted_modules)) {
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3192  		printk(KERN_DEFAULT "Unloaded tainted modules:");
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3193  		list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules,
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3194  					list) {
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3195  			size_t l;
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3196  
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3197  			l = module_flags_taint(mod_taint->taints, buf);
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3198  			buf[l++] = '\0';
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3199  			pr_cont(" %s(%s):%llu", mod_taint->name, buf,
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3200  				mod_taint->count);
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3201  		}
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3202  #endif
523ff1f52de4204 kernel/module/main.c Aaron Tomlin   2022-04-20  3203  	}
d72b37513cdfbd3 kernel/module.c      Andi Kleen     2008-08-30 @3204  	preempt_enable();

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
