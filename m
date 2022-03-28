Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D522D4E9AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiC1PVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiC1PVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:21:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8FE36691
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648480768; x=1680016768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2wUGy4d9mKtw71o7cuH+vA05hF6UVwVRGJArJmjuXnI=;
  b=S0SDbzK2yzBy3izbTGPya8mkLVaawYYgDDntR1B8uqW9/cUHtZ0719pi
   /kCR4qqlXI4j6lQYUgqDede0JiXqnkST1q6JO9ggFQcsLZhvPqJBXDSRZ
   tWiFZqi1xqcrPwLtuOmIXZuEFUavpxCKYWbq8Z6k92hjq56W1+Q5KIJih
   Yn2zx6hJ+yT3BMDbtvDVime6nygZC1iNbpSZPMub6m5CfkTgAXq2px1BF
   sMjNyHcx58amzsQV8TCLXKT7Q+QhgLTASKz87/8CWE6hjXZyRPTwVObAi
   nfsIpj/+LDnTJT3beWTKBrIv/OR4TNMrYvg14l3rI7WYqvqJtzauE5ryt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="238957685"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="238957685"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 08:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="518185484"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Mar 2022 08:19:23 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYr9O-00027a-W4; Mon, 28 Mar 2022 15:19:23 +0000
Date:   Mon, 28 Mar 2022 23:19:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, rth@twiddle.net, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, paul@paul-moore.com, eparis@redhat.com,
        linux-audit@redhat.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH v2] audit: do a quick exit when syscall number is invalid
Message-ID: <202203282351.MEKxtuyE-lkp@intel.com>
References: <20220328054641.2372974-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328054641.2372974-1-yang.yang29@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pcmoore-audit/next]
[also build test WARNING on linus/master v5.17 next-20220328]
[cannot apply to mattst88-alpha/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/audit-do-a-quick-exit-when-syscall-number-is-invalid/20220328-140250
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: alpha-alldefconfig (https://download.01.org/0day-ci/archive/20220328/202203282351.MEKxtuyE-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6459e446233463392d6268ee2154ed9f20c0b82c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/audit-do-a-quick-exit-when-syscall-number-is-invalid/20220328-140250
        git checkout 6459e446233463392d6268ee2154ed9f20c0b82c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:33: warning: "__NR_io_setup" redefined
      33 | #define __NR_io_setup 0
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:323: note: this is the location of the previous definition
     323 | #define __NR_io_setup 398
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:35: warning: "__NR_io_destroy" redefined
      35 | #define __NR_io_destroy 1
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:324: note: this is the location of the previous definition
     324 | #define __NR_io_destroy 399
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:37: warning: "__NR_io_submit" redefined
      37 | #define __NR_io_submit 2
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:326: note: this is the location of the previous definition
     326 | #define __NR_io_submit 401
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:39: warning: "__NR_io_cancel" redefined
      39 | #define __NR_io_cancel 3
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:327: note: this is the location of the previous definition
     327 | #define __NR_io_cancel 402
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:42: warning: "__NR_io_getevents" redefined
      42 | #define __NR_io_getevents 4
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:325: note: this is the location of the previous definition
     325 | #define __NR_io_getevents 400
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:47: warning: "__NR_setxattr" redefined
      47 | #define __NR_setxattr 5
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:307: note: this is the location of the previous definition
     307 | #define __NR_setxattr 382
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:49: warning: "__NR_lsetxattr" redefined
      49 | #define __NR_lsetxattr 6
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:308: note: this is the location of the previous definition
     308 | #define __NR_lsetxattr 383
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:51: warning: "__NR_fsetxattr" redefined
      51 | #define __NR_fsetxattr 7
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:309: note: this is the location of the previous definition
     309 | #define __NR_fsetxattr 384
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:53: warning: "__NR_getxattr" redefined
      53 | #define __NR_getxattr 8
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:310: note: this is the location of the previous definition
     310 | #define __NR_getxattr 385
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:55: warning: "__NR_lgetxattr" redefined
      55 | #define __NR_lgetxattr 9
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:311: note: this is the location of the previous definition
     311 | #define __NR_lgetxattr 386
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:57: warning: "__NR_fgetxattr" redefined
      57 | #define __NR_fgetxattr 10
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:312: note: this is the location of the previous definition
     312 | #define __NR_fgetxattr 387
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:59: warning: "__NR_listxattr" redefined
      59 | #define __NR_listxattr 11
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:313: note: this is the location of the previous definition
     313 | #define __NR_listxattr 388
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:61: warning: "__NR_llistxattr" redefined
      61 | #define __NR_llistxattr 12
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:314: note: this is the location of the previous definition
     314 | #define __NR_llistxattr 389
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:63: warning: "__NR_flistxattr" redefined
      63 | #define __NR_flistxattr 13
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:315: note: this is the location of the previous definition
     315 | #define __NR_flistxattr 390
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:65: warning: "__NR_removexattr" redefined
      65 | #define __NR_removexattr 14
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:316: note: this is the location of the previous definition
     316 | #define __NR_removexattr 391
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:67: warning: "__NR_lremovexattr" redefined
      67 | #define __NR_lremovexattr 15
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:317: note: this is the location of the previous definition
     317 | #define __NR_lremovexattr 392
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:69: warning: "__NR_fremovexattr" redefined
      69 | #define __NR_fremovexattr 16
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:318: note: this is the location of the previous definition
     318 | #define __NR_fremovexattr 393
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:73: warning: "__NR_getcwd" redefined
      73 | #define __NR_getcwd 17
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:293: note: this is the location of the previous definition
     293 | #define __NR_getcwd 367
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:77: warning: "__NR_lookup_dcookie" redefined
      77 | #define __NR_lookup_dcookie 18
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:329: note: this is the location of the previous definition
     329 | #define __NR_lookup_dcookie 406
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:81: warning: "__NR_eventfd2" redefined
      81 | #define __NR_eventfd2 19
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:408: note: this is the location of the previous definition
     408 | #define __NR_eventfd2 485
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   include/uapi/asm-generic/unistd.h:85: warning: "__NR_epoll_create1" redefined
      85 | #define __NR_epoll_create1 20
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:409: note: this is the location of the previous definition
     409 | #define __NR_epoll_create1 486
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   include/uapi/asm-generic/unistd.h:87: warning: "__NR_epoll_ctl" redefined
      87 | #define __NR_epoll_ctl 21
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:331: note: this is the location of the previous definition
     331 | #define __NR_epoll_ctl 408
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   include/uapi/asm-generic/unistd.h:89: warning: "__NR_epoll_pwait" redefined
      89 | #define __NR_epoll_pwait 22
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:397: note: this is the location of the previous definition
     397 | #define __NR_epoll_pwait 474
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   include/uapi/asm-generic/unistd.h:93: warning: "__NR_dup" redefined
      93 | #define __NR_dup 23
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:45: note: this is the location of the previous definition
      45 | #define __NR_dup 41
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   include/uapi/asm-generic/unistd.h:95: warning: "__NR_dup3" redefined
      95 | #define __NR_dup3 24
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:410: note: this is the location of the previous definition
     410 | #define __NR_dup3 487
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   include/uapi/asm-generic/unistd.h:101: warning: "__NR_inotify_init1" redefined
     101 | #define __NR_inotify_init1 26
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:412: note: this is the location of the previous definition
     412 | #define __NR_inotify_init1 489
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   include/uapi/asm-generic/unistd.h:103: warning: "__NR_inotify_add_watch" redefined
     103 | #define __NR_inotify_add_watch 27
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   ./arch/alpha/include/generated/uapi/asm/unistd_32.h:368: note: this is the location of the previous definition
     368 | #define __NR_inotify_add_watch 445
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:16,
                    from arch/alpha/include/asm/unistd.h:5,
                    from <stdin>:2:
   include/uapi/asm-generic/unistd.h:105: warning: "__NR_inotify_rm_watch" redefined
     105 | #define __NR_inotify_rm_watch 28
         | 
   In file included from arch/alpha/include/uapi/asm/unistd.h:15,
                    from arch/alpha/include/asm/unistd.h:5,
..


vim +/__NR_io_setup +33 include/uapi/asm-generic/unistd.h

8a1ab3155c2ac7 David Howells     2012-10-04   32  
8a1ab3155c2ac7 David Howells     2012-10-04  @33  #define __NR_io_setup 0
8a1ab3155c2ac7 David Howells     2012-10-04   34  __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
8a1ab3155c2ac7 David Howells     2012-10-04  @35  #define __NR_io_destroy 1
8a1ab3155c2ac7 David Howells     2012-10-04   36  __SYSCALL(__NR_io_destroy, sys_io_destroy)
8a1ab3155c2ac7 David Howells     2012-10-04  @37  #define __NR_io_submit 2
8a1ab3155c2ac7 David Howells     2012-10-04   38  __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
8a1ab3155c2ac7 David Howells     2012-10-04  @39  #define __NR_io_cancel 3
8a1ab3155c2ac7 David Howells     2012-10-04   40  __SYSCALL(__NR_io_cancel, sys_io_cancel)
c8ce48f06503ee Arnd Bergmann     2019-02-18   41  #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
8a1ab3155c2ac7 David Howells     2012-10-04  @42  #define __NR_io_getevents 4
00bf25d693e7f6 Arnd Bergmann     2019-01-01   43  __SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
c8ce48f06503ee Arnd Bergmann     2019-02-18   44  #endif
8a1ab3155c2ac7 David Howells     2012-10-04   45  
8a1ab3155c2ac7 David Howells     2012-10-04   46  /* fs/xattr.c */
8a1ab3155c2ac7 David Howells     2012-10-04  @47  #define __NR_setxattr 5
8a1ab3155c2ac7 David Howells     2012-10-04   48  __SYSCALL(__NR_setxattr, sys_setxattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @49  #define __NR_lsetxattr 6
8a1ab3155c2ac7 David Howells     2012-10-04   50  __SYSCALL(__NR_lsetxattr, sys_lsetxattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @51  #define __NR_fsetxattr 7
8a1ab3155c2ac7 David Howells     2012-10-04   52  __SYSCALL(__NR_fsetxattr, sys_fsetxattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @53  #define __NR_getxattr 8
8a1ab3155c2ac7 David Howells     2012-10-04   54  __SYSCALL(__NR_getxattr, sys_getxattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @55  #define __NR_lgetxattr 9
8a1ab3155c2ac7 David Howells     2012-10-04   56  __SYSCALL(__NR_lgetxattr, sys_lgetxattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @57  #define __NR_fgetxattr 10
8a1ab3155c2ac7 David Howells     2012-10-04   58  __SYSCALL(__NR_fgetxattr, sys_fgetxattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @59  #define __NR_listxattr 11
8a1ab3155c2ac7 David Howells     2012-10-04   60  __SYSCALL(__NR_listxattr, sys_listxattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @61  #define __NR_llistxattr 12
8a1ab3155c2ac7 David Howells     2012-10-04   62  __SYSCALL(__NR_llistxattr, sys_llistxattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @63  #define __NR_flistxattr 13
8a1ab3155c2ac7 David Howells     2012-10-04   64  __SYSCALL(__NR_flistxattr, sys_flistxattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @65  #define __NR_removexattr 14
8a1ab3155c2ac7 David Howells     2012-10-04   66  __SYSCALL(__NR_removexattr, sys_removexattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @67  #define __NR_lremovexattr 15
8a1ab3155c2ac7 David Howells     2012-10-04   68  __SYSCALL(__NR_lremovexattr, sys_lremovexattr)
8a1ab3155c2ac7 David Howells     2012-10-04  @69  #define __NR_fremovexattr 16
8a1ab3155c2ac7 David Howells     2012-10-04   70  __SYSCALL(__NR_fremovexattr, sys_fremovexattr)
8a1ab3155c2ac7 David Howells     2012-10-04   71  
8a1ab3155c2ac7 David Howells     2012-10-04   72  /* fs/dcache.c */
8a1ab3155c2ac7 David Howells     2012-10-04  @73  #define __NR_getcwd 17
8a1ab3155c2ac7 David Howells     2012-10-04   74  __SYSCALL(__NR_getcwd, sys_getcwd)
8a1ab3155c2ac7 David Howells     2012-10-04   75  
8a1ab3155c2ac7 David Howells     2012-10-04   76  /* fs/cookies.c */
8a1ab3155c2ac7 David Howells     2012-10-04  @77  #define __NR_lookup_dcookie 18
8a1ab3155c2ac7 David Howells     2012-10-04   78  __SC_COMP(__NR_lookup_dcookie, sys_lookup_dcookie, compat_sys_lookup_dcookie)
8a1ab3155c2ac7 David Howells     2012-10-04   79  
8a1ab3155c2ac7 David Howells     2012-10-04   80  /* fs/eventfd.c */
8a1ab3155c2ac7 David Howells     2012-10-04  @81  #define __NR_eventfd2 19
8a1ab3155c2ac7 David Howells     2012-10-04   82  __SYSCALL(__NR_eventfd2, sys_eventfd2)
8a1ab3155c2ac7 David Howells     2012-10-04   83  
8a1ab3155c2ac7 David Howells     2012-10-04   84  /* fs/eventpoll.c */
8a1ab3155c2ac7 David Howells     2012-10-04  @85  #define __NR_epoll_create1 20
8a1ab3155c2ac7 David Howells     2012-10-04   86  __SYSCALL(__NR_epoll_create1, sys_epoll_create1)
8a1ab3155c2ac7 David Howells     2012-10-04  @87  #define __NR_epoll_ctl 21
8a1ab3155c2ac7 David Howells     2012-10-04   88  __SYSCALL(__NR_epoll_ctl, sys_epoll_ctl)
8a1ab3155c2ac7 David Howells     2012-10-04  @89  #define __NR_epoll_pwait 22
8a1ab3155c2ac7 David Howells     2012-10-04   90  __SC_COMP(__NR_epoll_pwait, sys_epoll_pwait, compat_sys_epoll_pwait)
8a1ab3155c2ac7 David Howells     2012-10-04   91  
8a1ab3155c2ac7 David Howells     2012-10-04   92  /* fs/fcntl.c */
8a1ab3155c2ac7 David Howells     2012-10-04  @93  #define __NR_dup 23
8a1ab3155c2ac7 David Howells     2012-10-04   94  __SYSCALL(__NR_dup, sys_dup)
8a1ab3155c2ac7 David Howells     2012-10-04  @95  #define __NR_dup3 24
8a1ab3155c2ac7 David Howells     2012-10-04   96  __SYSCALL(__NR_dup3, sys_dup3)
8a1ab3155c2ac7 David Howells     2012-10-04   97  #define __NR3264_fcntl 25
8a1ab3155c2ac7 David Howells     2012-10-04   98  __SC_COMP_3264(__NR3264_fcntl, sys_fcntl64, sys_fcntl, compat_sys_fcntl64)
8a1ab3155c2ac7 David Howells     2012-10-04   99  
8a1ab3155c2ac7 David Howells     2012-10-04  100  /* fs/inotify_user.c */
8a1ab3155c2ac7 David Howells     2012-10-04 @101  #define __NR_inotify_init1 26
8a1ab3155c2ac7 David Howells     2012-10-04  102  __SYSCALL(__NR_inotify_init1, sys_inotify_init1)
8a1ab3155c2ac7 David Howells     2012-10-04 @103  #define __NR_inotify_add_watch 27
8a1ab3155c2ac7 David Howells     2012-10-04  104  __SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
8a1ab3155c2ac7 David Howells     2012-10-04 @105  #define __NR_inotify_rm_watch 28
8a1ab3155c2ac7 David Howells     2012-10-04  106  __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
8a1ab3155c2ac7 David Howells     2012-10-04  107  
8a1ab3155c2ac7 David Howells     2012-10-04  108  /* fs/ioctl.c */
8a1ab3155c2ac7 David Howells     2012-10-04 @109  #define __NR_ioctl 29
8a1ab3155c2ac7 David Howells     2012-10-04  110  __SC_COMP(__NR_ioctl, sys_ioctl, compat_sys_ioctl)
8a1ab3155c2ac7 David Howells     2012-10-04  111  
8a1ab3155c2ac7 David Howells     2012-10-04  112  /* fs/ioprio.c */
8a1ab3155c2ac7 David Howells     2012-10-04 @113  #define __NR_ioprio_set 30
8a1ab3155c2ac7 David Howells     2012-10-04  114  __SYSCALL(__NR_ioprio_set, sys_ioprio_set)
8a1ab3155c2ac7 David Howells     2012-10-04 @115  #define __NR_ioprio_get 31
8a1ab3155c2ac7 David Howells     2012-10-04  116  __SYSCALL(__NR_ioprio_get, sys_ioprio_get)
8a1ab3155c2ac7 David Howells     2012-10-04  117  
8a1ab3155c2ac7 David Howells     2012-10-04  118  /* fs/locks.c */
8a1ab3155c2ac7 David Howells     2012-10-04 @119  #define __NR_flock 32
8a1ab3155c2ac7 David Howells     2012-10-04  120  __SYSCALL(__NR_flock, sys_flock)
8a1ab3155c2ac7 David Howells     2012-10-04  121  
8a1ab3155c2ac7 David Howells     2012-10-04  122  /* fs/namei.c */
8a1ab3155c2ac7 David Howells     2012-10-04 @123  #define __NR_mknodat 33
8a1ab3155c2ac7 David Howells     2012-10-04  124  __SYSCALL(__NR_mknodat, sys_mknodat)
8a1ab3155c2ac7 David Howells     2012-10-04 @125  #define __NR_mkdirat 34
8a1ab3155c2ac7 David Howells     2012-10-04  126  __SYSCALL(__NR_mkdirat, sys_mkdirat)
8a1ab3155c2ac7 David Howells     2012-10-04 @127  #define __NR_unlinkat 35
8a1ab3155c2ac7 David Howells     2012-10-04  128  __SYSCALL(__NR_unlinkat, sys_unlinkat)
8a1ab3155c2ac7 David Howells     2012-10-04 @129  #define __NR_symlinkat 36
8a1ab3155c2ac7 David Howells     2012-10-04  130  __SYSCALL(__NR_symlinkat, sys_symlinkat)
8a1ab3155c2ac7 David Howells     2012-10-04 @131  #define __NR_linkat 37
8a1ab3155c2ac7 David Howells     2012-10-04  132  __SYSCALL(__NR_linkat, sys_linkat)
b0da6d44157aa6 James Hogan       2016-04-29  133  #ifdef __ARCH_WANT_RENAMEAT
b0da6d44157aa6 James Hogan       2016-04-29  134  /* renameat is superseded with flags by renameat2 */
8a1ab3155c2ac7 David Howells     2012-10-04  135  #define __NR_renameat 38
8a1ab3155c2ac7 David Howells     2012-10-04  136  __SYSCALL(__NR_renameat, sys_renameat)
b0da6d44157aa6 James Hogan       2016-04-29  137  #endif /* __ARCH_WANT_RENAMEAT */
8a1ab3155c2ac7 David Howells     2012-10-04  138  
8a1ab3155c2ac7 David Howells     2012-10-04  139  /* fs/namespace.c */
8a1ab3155c2ac7 David Howells     2012-10-04 @140  #define __NR_umount2 39
8a1ab3155c2ac7 David Howells     2012-10-04  141  __SYSCALL(__NR_umount2, sys_umount)
8a1ab3155c2ac7 David Howells     2012-10-04 @142  #define __NR_mount 40
028abd9222df0c Christoph Hellwig 2020-09-17  143  __SYSCALL(__NR_mount, sys_mount)
8a1ab3155c2ac7 David Howells     2012-10-04 @144  #define __NR_pivot_root 41
8a1ab3155c2ac7 David Howells     2012-10-04  145  __SYSCALL(__NR_pivot_root, sys_pivot_root)
8a1ab3155c2ac7 David Howells     2012-10-04  146  
8a1ab3155c2ac7 David Howells     2012-10-04  147  /* fs/nfsctl.c */
8a1ab3155c2ac7 David Howells     2012-10-04 @148  #define __NR_nfsservctl 42
8a1ab3155c2ac7 David Howells     2012-10-04  149  __SYSCALL(__NR_nfsservctl, sys_ni_syscall)
8a1ab3155c2ac7 David Howells     2012-10-04  150  
8a1ab3155c2ac7 David Howells     2012-10-04  151  /* fs/open.c */
8a1ab3155c2ac7 David Howells     2012-10-04  152  #define __NR3264_statfs 43
8a1ab3155c2ac7 David Howells     2012-10-04  153  __SC_COMP_3264(__NR3264_statfs, sys_statfs64, sys_statfs, \
8a1ab3155c2ac7 David Howells     2012-10-04  154  	       compat_sys_statfs64)
8a1ab3155c2ac7 David Howells     2012-10-04  155  #define __NR3264_fstatfs 44
8a1ab3155c2ac7 David Howells     2012-10-04  156  __SC_COMP_3264(__NR3264_fstatfs, sys_fstatfs64, sys_fstatfs, \
8a1ab3155c2ac7 David Howells     2012-10-04  157  	       compat_sys_fstatfs64)
8a1ab3155c2ac7 David Howells     2012-10-04  158  #define __NR3264_truncate 45
8a1ab3155c2ac7 David Howells     2012-10-04  159  __SC_COMP_3264(__NR3264_truncate, sys_truncate64, sys_truncate, \
8a1ab3155c2ac7 David Howells     2012-10-04  160  	       compat_sys_truncate64)
8a1ab3155c2ac7 David Howells     2012-10-04  161  #define __NR3264_ftruncate 46
8a1ab3155c2ac7 David Howells     2012-10-04  162  __SC_COMP_3264(__NR3264_ftruncate, sys_ftruncate64, sys_ftruncate, \
8a1ab3155c2ac7 David Howells     2012-10-04  163  	       compat_sys_ftruncate64)
8a1ab3155c2ac7 David Howells     2012-10-04  164  
8a1ab3155c2ac7 David Howells     2012-10-04 @165  #define __NR_fallocate 47
8a1ab3155c2ac7 David Howells     2012-10-04  166  __SC_COMP(__NR_fallocate, sys_fallocate, compat_sys_fallocate)
8a1ab3155c2ac7 David Howells     2012-10-04 @167  #define __NR_faccessat 48
8a1ab3155c2ac7 David Howells     2012-10-04  168  __SYSCALL(__NR_faccessat, sys_faccessat)
8a1ab3155c2ac7 David Howells     2012-10-04 @169  #define __NR_chdir 49
8a1ab3155c2ac7 David Howells     2012-10-04  170  __SYSCALL(__NR_chdir, sys_chdir)
8a1ab3155c2ac7 David Howells     2012-10-04 @171  #define __NR_fchdir 50
8a1ab3155c2ac7 David Howells     2012-10-04  172  __SYSCALL(__NR_fchdir, sys_fchdir)
8a1ab3155c2ac7 David Howells     2012-10-04 @173  #define __NR_chroot 51
8a1ab3155c2ac7 David Howells     2012-10-04  174  __SYSCALL(__NR_chroot, sys_chroot)
8a1ab3155c2ac7 David Howells     2012-10-04 @175  #define __NR_fchmod 52
8a1ab3155c2ac7 David Howells     2012-10-04  176  __SYSCALL(__NR_fchmod, sys_fchmod)
8a1ab3155c2ac7 David Howells     2012-10-04 @177  #define __NR_fchmodat 53
8a1ab3155c2ac7 David Howells     2012-10-04  178  __SYSCALL(__NR_fchmodat, sys_fchmodat)
8a1ab3155c2ac7 David Howells     2012-10-04 @179  #define __NR_fchownat 54
8a1ab3155c2ac7 David Howells     2012-10-04  180  __SYSCALL(__NR_fchownat, sys_fchownat)
8a1ab3155c2ac7 David Howells     2012-10-04 @181  #define __NR_fchown 55
8a1ab3155c2ac7 David Howells     2012-10-04  182  __SYSCALL(__NR_fchown, sys_fchown)
8a1ab3155c2ac7 David Howells     2012-10-04 @183  #define __NR_openat 56
0d0216c03a7a14 Yury Norov        2018-05-16  184  __SYSCALL(__NR_openat, sys_openat)
8a1ab3155c2ac7 David Howells     2012-10-04 @185  #define __NR_close 57
8a1ab3155c2ac7 David Howells     2012-10-04  186  __SYSCALL(__NR_close, sys_close)
8a1ab3155c2ac7 David Howells     2012-10-04 @187  #define __NR_vhangup 58
8a1ab3155c2ac7 David Howells     2012-10-04  188  __SYSCALL(__NR_vhangup, sys_vhangup)
8a1ab3155c2ac7 David Howells     2012-10-04  189  
8a1ab3155c2ac7 David Howells     2012-10-04  190  /* fs/pipe.c */
8a1ab3155c2ac7 David Howells     2012-10-04 @191  #define __NR_pipe2 59
8a1ab3155c2ac7 David Howells     2012-10-04  192  __SYSCALL(__NR_pipe2, sys_pipe2)
8a1ab3155c2ac7 David Howells     2012-10-04  193  
8a1ab3155c2ac7 David Howells     2012-10-04  194  /* fs/quota.c */
8a1ab3155c2ac7 David Howells     2012-10-04 @195  #define __NR_quotactl 60
8a1ab3155c2ac7 David Howells     2012-10-04  196  __SYSCALL(__NR_quotactl, sys_quotactl)
8a1ab3155c2ac7 David Howells     2012-10-04  197  
8a1ab3155c2ac7 David Howells     2012-10-04  198  /* fs/readdir.c */
8a1ab3155c2ac7 David Howells     2012-10-04 @199  #define __NR_getdents64 61
2611dc19395697 Al Viro           2017-04-08  200  __SYSCALL(__NR_getdents64, sys_getdents64)
8a1ab3155c2ac7 David Howells     2012-10-04  201  
8a1ab3155c2ac7 David Howells     2012-10-04  202  /* fs/read_write.c */
8a1ab3155c2ac7 David Howells     2012-10-04  203  #define __NR3264_lseek 62
8a1ab3155c2ac7 David Howells     2012-10-04  204  __SC_3264(__NR3264_lseek, sys_llseek, sys_lseek)
8a1ab3155c2ac7 David Howells     2012-10-04 @205  #define __NR_read 63
8a1ab3155c2ac7 David Howells     2012-10-04  206  __SYSCALL(__NR_read, sys_read)
8a1ab3155c2ac7 David Howells     2012-10-04 @207  #define __NR_write 64
8a1ab3155c2ac7 David Howells     2012-10-04  208  __SYSCALL(__NR_write, sys_write)
8a1ab3155c2ac7 David Howells     2012-10-04 @209  #define __NR_readv 65
5f764d624a89d4 Christoph Hellwig 2020-09-25  210  __SC_COMP(__NR_readv, sys_readv, sys_readv)
8a1ab3155c2ac7 David Howells     2012-10-04 @211  #define __NR_writev 66
5f764d624a89d4 Christoph Hellwig 2020-09-25  212  __SC_COMP(__NR_writev, sys_writev, sys_writev)
8a1ab3155c2ac7 David Howells     2012-10-04 @213  #define __NR_pread64 67
8a1ab3155c2ac7 David Howells     2012-10-04  214  __SC_COMP(__NR_pread64, sys_pread64, compat_sys_pread64)
8a1ab3155c2ac7 David Howells     2012-10-04 @215  #define __NR_pwrite64 68
8a1ab3155c2ac7 David Howells     2012-10-04  216  __SC_COMP(__NR_pwrite64, sys_pwrite64, compat_sys_pwrite64)
8a1ab3155c2ac7 David Howells     2012-10-04 @217  #define __NR_preadv 69
8a1ab3155c2ac7 David Howells     2012-10-04  218  __SC_COMP(__NR_preadv, sys_preadv, compat_sys_preadv)
8a1ab3155c2ac7 David Howells     2012-10-04 @219  #define __NR_pwritev 70
8a1ab3155c2ac7 David Howells     2012-10-04  220  __SC_COMP(__NR_pwritev, sys_pwritev, compat_sys_pwritev)
8a1ab3155c2ac7 David Howells     2012-10-04  221  
8a1ab3155c2ac7 David Howells     2012-10-04  222  /* fs/sendfile.c */
8a1ab3155c2ac7 David Howells     2012-10-04  223  #define __NR3264_sendfile 71
8a1ab3155c2ac7 David Howells     2012-10-04  224  __SYSCALL(__NR3264_sendfile, sys_sendfile64)
8a1ab3155c2ac7 David Howells     2012-10-04  225  
8a1ab3155c2ac7 David Howells     2012-10-04  226  /* fs/select.c */
c8ce48f06503ee Arnd Bergmann     2019-02-18  227  #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
8a1ab3155c2ac7 David Howells     2012-10-04 @228  #define __NR_pselect6 72
00bf25d693e7f6 Arnd Bergmann     2019-01-01  229  __SC_COMP_3264(__NR_pselect6, sys_pselect6_time32, sys_pselect6, compat_sys_pselect6_time32)
8a1ab3155c2ac7 David Howells     2012-10-04 @230  #define __NR_ppoll 73
00bf25d693e7f6 Arnd Bergmann     2019-01-01  231  __SC_COMP_3264(__NR_ppoll, sys_ppoll_time32, sys_ppoll, compat_sys_ppoll_time32)
c8ce48f06503ee Arnd Bergmann     2019-02-18  232  #endif
8a1ab3155c2ac7 David Howells     2012-10-04  233  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
