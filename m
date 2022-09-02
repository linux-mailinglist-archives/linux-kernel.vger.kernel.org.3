Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872955AA630
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiIBDQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiIBDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:16:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8827D1C5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662088613; x=1693624613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bUi0aeVbMcIanw5XAQIVM/SJorqIa61WnrAoQoqeaUQ=;
  b=V2e+P+gnKhbAoy4QLO+681PHp5FamgiGp53fqwdpjhLn5VFZ9rleJJdH
   7es0Pg471Dt1NMFcvqH+sBfLFzQ9G2eCFaapMtzOVcgt+Ybsub+402sci
   F9obWtmWB+dHC5gWtKB626fD57KsQUazjyXXLVwFgAbdnEgRk+bVupl7l
   qdDUBD44HE7KCMPvVpODN359KbVz6Jsa2GrUsFq5sxzj4c57b9uRYO9wJ
   zA+CBORXszmW2Itrjb7u3jfd/KrET53jgrmseRg2JI01jFnxPw+S+W3t3
   /O1q2/+UQ0nSH7CQj2eD/SFpjjuN+UFtICDK2KtNE8JU7HjdZhnEepLik
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282868476"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="282868476"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 20:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="738724476"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Sep 2022 20:16:50 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTxAn-00004F-1U;
        Fri, 02 Sep 2022 03:16:49 +0000
Date:   Fri, 2 Sep 2022 11:16:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Cc:     kbuild-all@lists.01.org, Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-kernel@vger.kernel.org,
        syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com,
        Ayushman Dutta <ayudutta@amazon.com>
Subject: Re: [PATCH v1] seccomp: Release filter when copy_process() fails.
Message-ID: <202209021116.hpxQOERU-lkp@intel.com>
References: <20220822204436.26631-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822204436.26631-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuniyuki,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on linus/master v6.0-rc3]
[cannot apply to kees/for-next/seccomp next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/seccomp-Release-filter-when-copy_process-fails/20220823-044710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: arc-randconfig-r043-20220901 (https://download.01.org/0day-ci/archive/20220902/202209021116.hpxQOERU-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ea0fdd2f2e9a09bd5428bd59e81bac66e949f578
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kuniyuki-Iwashima/seccomp-Release-filter-when-copy_process-fails/20220823-044710
        git checkout ea0fdd2f2e9a09bd5428bd59e81bac66e949f578
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/fork.c:163:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
     163 | void __weak arch_release_task_struct(struct task_struct *tsk)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from kernel/fork.c:16:
   kernel/fork.c: In function 'free_task':
>> kernel/fork.c:540:34: error: 'struct seccomp' has no member named 'filter'
     540 |         WARN_ON_ONCE(tsk->seccomp.filter);
         |                                  ^
   include/asm-generic/bug.h:166:32: note: in definition of macro 'WARN_ON'
     166 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   kernel/fork.c:540:9: note: in expansion of macro 'WARN_ON_ONCE'
     540 |         WARN_ON_ONCE(tsk->seccomp.filter);
         |         ^~~~~~~~~~~~
   kernel/fork.c: At top level:
   kernel/fork.c:854:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
     854 | void __init __weak arch_task_cache_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~
   kernel/fork.c:949:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
     949 | int __weak arch_dup_task_struct(struct task_struct *dst,
         |            ^~~~~~~~~~~~~~~~~~~~


vim +540 kernel/fork.c

   537	
   538	void free_task(struct task_struct *tsk)
   539	{
 > 540		WARN_ON_ONCE(tsk->seccomp.filter);
   541		release_user_cpus_ptr(tsk);
   542		scs_release(tsk);
   543	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
