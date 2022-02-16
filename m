Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F89F4B7B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242818AbiBPAKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:10:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiBPAK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:10:29 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72AACD324;
        Tue, 15 Feb 2022 16:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644970218; x=1676506218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uEyOI3gBkM4gqhuOyvcPW9N22GUaDMH9evCDrwsFc+8=;
  b=oGJskdGVR7SOFJGS955T1S1jFizlJ0zFRzsjdf8vrQL82g9BFittSvKm
   4ZowtFu9dJx6D5kXPifQOQzJt9y3j1ibDjeAWgvN2fO8NxThrWbQ6DiT9
   +T4DL9E5ofFfWJ2DKEoSBQESgiwiyVxbWQA2TM6qULmQfx6kVPtHs0pkK
   032NpxMUPId/0lg5xwwdePkupLdC/lbplhwfylD1stjmC0bDexuxLJGGC
   yV8BGTk+03IUeqwOXCeADpcZupOiMZ7u9wCX52ZPfkXdnH9URFrHn1EcI
   iiFSuhyvqRQ//2w/zVohV/WPtY1hHGdNddrnVIN8W8EeXQZSD4b7QtgTB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="230451553"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="230451553"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 16:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="704022345"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2022 16:10:16 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK7tf-000ABK-Bg; Wed, 16 Feb 2022 00:10:15 +0000
Date:   Wed, 16 Feb 2022 08:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Armin Wolf <W_Armin@gmx.de>, pali@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, jdelvare@suse.com,
        linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] hwmon: (dell-smm) Improve assembly code
Message-ID: <202202160842.6EYIVsJn-lkp@intel.com>
References: <20220215191113.16640-6-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215191113.16640-6-W_Armin@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on next-20220215]
[cannot apply to linus/master v5.17-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Armin-Wolf/hwmon-dell-smm-Miscellaneous-improvements/20220216-031722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: i386-randconfig-a004-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160842.6EYIVsJn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e03bd707be4885b219afdfd7a24778fb0a8129e1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Armin-Wolf/hwmon-dell-smm-Miscellaneous-improvements/20220216-031722
        git checkout e03bd707be4885b219afdfd7a24778fb0a8129e1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hwmon/dell-smm-hwmon.c:178:15: error: inline assembly requires more registers than available
           asm volatile("out %%al,$0xb2\n\t"
                        ^
   1 error generated.


vim +178 drivers/hwmon/dell-smm-hwmon.c

   161	
   162	/*
   163	 * Call the System Management Mode BIOS. Code provided by Jonathan Buzzard.
   164	 */
   165	static int i8k_smm_func(void *par)
   166	{
   167		ktime_t calltime = ktime_get();
   168		struct smm_regs *regs = par;
   169		int eax = regs->eax;
   170		int ebx = regs->ebx;
   171		long long duration;
   172		int rc;
   173	
   174		/* SMM requires CPU 0 */
   175		if (smp_processor_id() != 0)
   176			return -EBUSY;
   177	
 > 178		asm volatile("out %%al,$0xb2\n\t"
   179			     "out %%al,$0x84\n"
   180			     : "=a" (regs->eax),
   181			       "=b" (regs->ebx),
   182			       "=c" (regs->ecx),
   183			       "=d" (regs->edx),
   184			       "=S" (regs->esi),
   185			       "=D" (regs->edi),
   186			       CC_OUT(c) (rc)
   187			     : "a" (regs->eax),
   188			       "b" (regs->ebx),
   189			       "c" (regs->ecx),
   190			       "d" (regs->edx),
   191			       "S" (regs->esi),
   192			       "D" (regs->edi));
   193	
   194		if (rc != 0 || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
   195			rc = -EINVAL;
   196	
   197		duration = ktime_us_delta(ktime_get(), calltime);
   198		pr_debug("smm(0x%.4x 0x%.4x) = 0x%.4x  (took %7lld usecs)\n", eax, ebx,
   199			 (rc ? 0xffff : regs->eax & 0xffff), duration);
   200	
   201		return rc;
   202	}
   203	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
