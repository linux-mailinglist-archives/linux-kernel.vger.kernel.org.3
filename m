Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF64AE54D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiBHXLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBHXLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:11:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E10C061578;
        Tue,  8 Feb 2022 15:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644361879; x=1675897879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SX+Ukr/Axms+ZkUXzepwxZRP4Htag+UHnjtIv0GwVmA=;
  b=hWCe9Itvwu1RBY9Jn7f6102d5Nl5M9vVEGwI5MqFTrocFV+6yvBZp6mP
   N2tvd628//4qpBpZaSlZ8raWlGxhVv5QURGydlTgW61x8olkRWzEGXdgH
   GiN72/CH3Nc2KAMxUm3KZv76Xckxc6DPGh37Iw7LVBblmmHj8ctiieOZH
   V6nuho2VTnCAXpOK9qHQGKhDZ190L0j16LB2NVOm/RXAEIqq1ycOf1yat
   5aznqYnxtuWBaHDslZgIH5qxYJD2t5cRDkgqtbnFQ9acD4f+j8ooCjfFk
   HRwpglN1olDePWVJ3ZLSUttEPyy7vrtcl4OfOtnM/wVWXONEsTg1e9m5B
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236480229"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="236480229"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 15:11:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="771145853"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2022 15:11:14 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHZdh-0000uZ-QM; Tue, 08 Feb 2022 23:11:13 +0000
Date:   Wed, 9 Feb 2022 07:10:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>, john.stultz@linaro.org,
        tglx@linutronix.de, sboyd@kernel.org,
        alexandre.belloni@bootlin.com, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, geert@linux-m68k.org,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        boon.leong.ong@intel.com, mhiramat@kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-rtc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com, jgross@suse.com,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] include: linux: Reorganize timekeeping and ktime
 headers
Message-ID: <202202090656.Bx5FpSa7-lkp@intel.com>
References: <20220208161049.865402-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208161049.865402-1-carlos.bilbao@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlos,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on geert-m68k/for-next]
[also build test ERROR on tip/timers/core tip/x86/core linus/master v5.17-rc3]
[cannot apply to next-20220208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20220209-001309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
config: alpha-randconfig-r001-20220208 (https://download.01.org/0day-ci/archive/20220209/202202090656.Bx5FpSa7-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5ed7d76f2d6aabedc437bc0b99020dc655ab5719
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20220209-001309
        git checkout 5ed7d76f2d6aabedc437bc0b99020dc655ab5719
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash arch/alpha/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/alpha/kernel/osf_sys.c: In function '__do_sys_osf_settimeofday':
>> arch/alpha/kernel/osf_sys.c:1013:16: error: implicit declaration of function 'do_sys_settimeofday64'; did you mean 'sys_settimeofday'? [-Werror=implicit-function-declaration]
    1013 |         return do_sys_settimeofday64(tv ? &kts : NULL, tz ? &ktz : NULL);
         |                ^~~~~~~~~~~~~~~~~~~~~
         |                sys_settimeofday
   cc1: some warnings being treated as errors


vim +1013 arch/alpha/kernel/osf_sys.c

^1da177e4c3f415 Linus Torvalds  2005-04-16   997  
e5d9a90c36e05dd Ivan Kokshaysky 2009-01-29   998  SYSCALL_DEFINE2(osf_settimeofday, struct timeval32 __user *, tv,
e5d9a90c36e05dd Ivan Kokshaysky 2009-01-29   999  		struct timezone __user *, tz)
^1da177e4c3f415 Linus Torvalds  2005-04-16  1000  {
ce4c253573ad184 Arnd Bergmann   2017-11-08  1001  	struct timespec64 kts;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1002  	struct timezone ktz;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1003  
^1da177e4c3f415 Linus Torvalds  2005-04-16  1004   	if (tv) {
ce4c253573ad184 Arnd Bergmann   2017-11-08  1005  		if (get_tv32(&kts, tv))
^1da177e4c3f415 Linus Torvalds  2005-04-16  1006  			return -EFAULT;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1007  	}
^1da177e4c3f415 Linus Torvalds  2005-04-16  1008  	if (tz) {
^1da177e4c3f415 Linus Torvalds  2005-04-16  1009  		if (copy_from_user(&ktz, tz, sizeof(*tz)))
^1da177e4c3f415 Linus Torvalds  2005-04-16  1010  			return -EFAULT;
^1da177e4c3f415 Linus Torvalds  2005-04-16  1011  	}
^1da177e4c3f415 Linus Torvalds  2005-04-16  1012  
ce4c253573ad184 Arnd Bergmann   2017-11-08 @1013  	return do_sys_settimeofday64(tv ? &kts : NULL, tz ? &ktz : NULL);
^1da177e4c3f415 Linus Torvalds  2005-04-16  1014  }
^1da177e4c3f415 Linus Torvalds  2005-04-16  1015  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
