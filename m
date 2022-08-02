Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD0D5874F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiHBBFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHBBFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:05:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9714504B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659402299; x=1690938299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eZ27QcnMat+V3xP3GPKnoUwOfJszKlQMtB66lmaY3n8=;
  b=AQjayNG+eU2L8oJs8S7fAFfmhuhg7PJiJS2sj/iUpMdxi65quJSy4o5J
   /10SK4y/+5CadCn0+ZeNn7pjEyyGBiOfbhSX8j+lR7vE00DREtDnZb55s
   tZELKAC3ubzPfuWsS8SQ33H3iQiJmeDr1JECH4Q8Abx2rvhgfkUIW4NLy
   SUTwo8JDlMfCbtXzyVUbG+LQ7U32quHIazcT4GxBmudEbW1lkyQK0B7mF
   NdzDI8h2e64lsBJIWj7OdSV5Y+hFqteDmEAVhc7VyBOTwDIboCKT68y8s
   XD1QK5+27FR9HyjUvH506fmytckqUk4c2swFa8yq6+5Ws8uwi7P9Yt8rL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="288046344"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="288046344"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 18:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="630491549"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2022 18:04:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIgLB-000FXX-0U;
        Tue, 02 Aug 2022 01:04:57 +0000
Date:   Tue, 2 Aug 2022 09:04:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: arch/x86/kernel/fpu/xstate.c:1117:7: warning: Local variable 'mask'
 shadows outer variable [shadowVariable]
Message-ID: <202208020949.LCC9Ch2H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9de1f9c8ca5100a02a2e271bdbde36202e251b4b
commit: 522e92743b35351bda1b6a9136560f833a9c2490 x86/fpu: Deduplicate copy_uabi_from_user/kernel_to_xstate()
date:   1 year, 1 month ago
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 522e92743b35351bda1b6a9136560f833a9c2490
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)
>> arch/x86/kernel/fpu/xstate.c:1117:7: warning: Local variable 'mask' shadows outer variable [shadowVariable]
     u64 mask = ((u64)1 << i);
         ^
   arch/x86/kernel/fpu/xstate.c:1086:6: note: Shadowed declaration
    u64 mask;
        ^
   arch/x86/kernel/fpu/xstate.c:1117:7: note: Shadow variable
     u64 mask = ((u64)1 << i);
         ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/thermal/intel/therm_throt.c:323:12: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
      state = &pstate->core_throttle;
              ^
   drivers/thermal/intel/therm_throt.c:318:33: note: Address of variable taken here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                   ^
   drivers/thermal/intel/therm_throt.c:323:12: note: Address of variable taken here.
      state = &pstate->core_throttle;
              ^
   drivers/thermal/intel/therm_throt.c:318:41: note: Temporary created here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                           ^
   drivers/thermal/intel/therm_throt.c:323:12: note: Using pointer that is a temporary.
      state = &pstate->core_throttle;
              ^
   drivers/thermal/intel/therm_throt.c:323:13: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
      state = &pstate->core_throttle;
               ^
   drivers/thermal/intel/therm_throt.c:318:33: note: Address of variable taken here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                   ^
   drivers/thermal/intel/therm_throt.c:318:41: note: Temporary created here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                           ^
   drivers/thermal/intel/therm_throt.c:323:13: note: Using pointer that is a temporary.
      state = &pstate->core_throttle;
               ^
   drivers/thermal/intel/therm_throt.c:325:12: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
      state = &pstate->core_power_limit;
              ^
   drivers/thermal/intel/therm_throt.c:318:33: note: Address of variable taken here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                   ^
   drivers/thermal/intel/therm_throt.c:325:12: note: Address of variable taken here.
      state = &pstate->core_power_limit;
              ^
   drivers/thermal/intel/therm_throt.c:318:41: note: Temporary created here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                           ^
   drivers/thermal/intel/therm_throt.c:325:12: note: Using pointer that is a temporary.
      state = &pstate->core_power_limit;
              ^
   drivers/thermal/intel/therm_throt.c:325:13: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
      state = &pstate->core_power_limit;
               ^
   drivers/thermal/intel/therm_throt.c:318:33: note: Address of variable taken here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                   ^
   drivers/thermal/intel/therm_throt.c:318:41: note: Temporary created here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                           ^
   drivers/thermal/intel/therm_throt.c:325:13: note: Using pointer that is a temporary.
      state = &pstate->core_power_limit;
               ^
   drivers/thermal/intel/therm_throt.c:330:12: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
      state = &pstate->package_throttle;
              ^
   drivers/thermal/intel/therm_throt.c:318:33: note: Address of variable taken here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                   ^
   drivers/thermal/intel/therm_throt.c:330:12: note: Address of variable taken here.
      state = &pstate->package_throttle;
              ^
   drivers/thermal/intel/therm_throt.c:318:41: note: Temporary created here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                           ^
   drivers/thermal/intel/therm_throt.c:330:12: note: Using pointer that is a temporary.
      state = &pstate->package_throttle;
              ^
   drivers/thermal/intel/therm_throt.c:330:13: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
      state = &pstate->package_throttle;
               ^
   drivers/thermal/intel/therm_throt.c:318:33: note: Address of variable taken here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                   ^
   drivers/thermal/intel/therm_throt.c:318:41: note: Temporary created here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                           ^
   drivers/thermal/intel/therm_throt.c:330:13: note: Using pointer that is a temporary.
      state = &pstate->package_throttle;
               ^
   drivers/thermal/intel/therm_throt.c:332:12: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
      state = &pstate->package_power_limit;
              ^
   drivers/thermal/intel/therm_throt.c:318:33: note: Address of variable taken here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                   ^
   drivers/thermal/intel/therm_throt.c:332:12: note: Address of variable taken here.
      state = &pstate->package_power_limit;
              ^
   drivers/thermal/intel/therm_throt.c:318:41: note: Temporary created here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
                                           ^
   drivers/thermal/intel/therm_throt.c:332:12: note: Using pointer that is a temporary.
      state = &pstate->package_power_limit;
              ^
   drivers/thermal/intel/therm_throt.c:332:13: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
      state = &pstate->package_power_limit;
               ^
   drivers/thermal/intel/therm_throt.c:318:33: note: Address of variable taken here.
    struct thermal_state *pstate = &per_cpu(thermal_state, this_cpu);
--

vim +/mask +1117 arch/x86/kernel/fpu/xstate.c

947f4947cf00ea Thomas Gleixner           2021-06-23  1079  
522e92743b3535 Thomas Gleixner           2021-06-23  1080  
522e92743b3535 Thomas Gleixner           2021-06-23  1081  static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
522e92743b3535 Thomas Gleixner           2021-06-23  1082  			       const void __user *ubuf)
79fecc2b7506f2 Ingo Molnar               2017-09-23  1083  {
79fecc2b7506f2 Ingo Molnar               2017-09-23  1084  	unsigned int offset, size;
80d8ae86b36791 Eric Biggers              2017-09-24  1085  	struct xstate_header hdr;
522e92743b3535 Thomas Gleixner           2021-06-23  1086  	u64 mask;
522e92743b3535 Thomas Gleixner           2021-06-23  1087  	int i;
79fecc2b7506f2 Ingo Molnar               2017-09-23  1088  
79fecc2b7506f2 Ingo Molnar               2017-09-23  1089  	offset = offsetof(struct xregs_state, header);
522e92743b3535 Thomas Gleixner           2021-06-23  1090  	if (copy_from_buffer(&hdr, offset, sizeof(hdr), kbuf, ubuf))
522e92743b3535 Thomas Gleixner           2021-06-23  1091  		return -EFAULT;
79fecc2b7506f2 Ingo Molnar               2017-09-23  1092  
5274e6c172c472 Fenghua Yu                2020-05-12  1093  	if (validate_user_xstate_header(&hdr))
79fecc2b7506f2 Ingo Molnar               2017-09-23  1094  		return -EINVAL;
79fecc2b7506f2 Ingo Molnar               2017-09-23  1095  
522e92743b3535 Thomas Gleixner           2021-06-23  1096  	/* Validate MXCSR when any of the related features is in use */
522e92743b3535 Thomas Gleixner           2021-06-23  1097  	mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
522e92743b3535 Thomas Gleixner           2021-06-23  1098  	if (hdr.xfeatures & mask) {
522e92743b3535 Thomas Gleixner           2021-06-23  1099  		u32 mxcsr[2];
522e92743b3535 Thomas Gleixner           2021-06-23  1100  
522e92743b3535 Thomas Gleixner           2021-06-23  1101  		offset = offsetof(struct fxregs_state, mxcsr);
522e92743b3535 Thomas Gleixner           2021-06-23  1102  		if (copy_from_buffer(mxcsr, offset, sizeof(mxcsr), kbuf, ubuf))
522e92743b3535 Thomas Gleixner           2021-06-23  1103  			return -EFAULT;
522e92743b3535 Thomas Gleixner           2021-06-23  1104  
522e92743b3535 Thomas Gleixner           2021-06-23  1105  		/* Reserved bits in MXCSR must be zero. */
522e92743b3535 Thomas Gleixner           2021-06-23  1106  		if (mxcsr[0] & ~mxcsr_feature_mask)
947f4947cf00ea Thomas Gleixner           2021-06-23  1107  			return -EINVAL;
947f4947cf00ea Thomas Gleixner           2021-06-23  1108  
522e92743b3535 Thomas Gleixner           2021-06-23  1109  		/* SSE and YMM require MXCSR even when FP is not in use. */
522e92743b3535 Thomas Gleixner           2021-06-23  1110  		if (!(hdr.xfeatures & XFEATURE_MASK_FP)) {
522e92743b3535 Thomas Gleixner           2021-06-23  1111  			xsave->i387.mxcsr = mxcsr[0];
522e92743b3535 Thomas Gleixner           2021-06-23  1112  			xsave->i387.mxcsr_mask = mxcsr[1];
522e92743b3535 Thomas Gleixner           2021-06-23  1113  		}
522e92743b3535 Thomas Gleixner           2021-06-23  1114  	}
522e92743b3535 Thomas Gleixner           2021-06-23  1115  
79fecc2b7506f2 Ingo Molnar               2017-09-23  1116  	for (i = 0; i < XFEATURE_MAX; i++) {
79fecc2b7506f2 Ingo Molnar               2017-09-23 @1117  		u64 mask = ((u64)1 << i);
79fecc2b7506f2 Ingo Molnar               2017-09-23  1118  
b89eda482d7849 Eric Biggers              2017-09-24  1119  		if (hdr.xfeatures & mask) {
07baeb04f37c95 Sebastian Andrzej Siewior 2019-04-03  1120  			void *dst = __raw_xsave_addr(xsave, i);
79fecc2b7506f2 Ingo Molnar               2017-09-23  1121  
79fecc2b7506f2 Ingo Molnar               2017-09-23  1122  			offset = xstate_offsets[i];
79fecc2b7506f2 Ingo Molnar               2017-09-23  1123  			size = xstate_sizes[i];
79fecc2b7506f2 Ingo Molnar               2017-09-23  1124  
522e92743b3535 Thomas Gleixner           2021-06-23  1125  			if (copy_from_buffer(dst, offset, size, kbuf, ubuf))
522e92743b3535 Thomas Gleixner           2021-06-23  1126  				return -EFAULT;
79fecc2b7506f2 Ingo Molnar               2017-09-23  1127  		}
79fecc2b7506f2 Ingo Molnar               2017-09-23  1128  	}
79fecc2b7506f2 Ingo Molnar               2017-09-23  1129  
79fecc2b7506f2 Ingo Molnar               2017-09-23  1130  	/*
79fecc2b7506f2 Ingo Molnar               2017-09-23  1131  	 * The state that came in from userspace was user-state only.
79fecc2b7506f2 Ingo Molnar               2017-09-23  1132  	 * Mask all the user states out of 'xfeatures':
79fecc2b7506f2 Ingo Molnar               2017-09-23  1133  	 */
8ab22804efefea Fenghua Yu                2020-05-12  1134  	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR_ALL;
79fecc2b7506f2 Ingo Molnar               2017-09-23  1135  
79fecc2b7506f2 Ingo Molnar               2017-09-23  1136  	/*
79fecc2b7506f2 Ingo Molnar               2017-09-23  1137  	 * Add back in the features that came in from userspace:
79fecc2b7506f2 Ingo Molnar               2017-09-23  1138  	 */
b89eda482d7849 Eric Biggers              2017-09-24  1139  	xsave->header.xfeatures |= hdr.xfeatures;
79fecc2b7506f2 Ingo Molnar               2017-09-23  1140  
79fecc2b7506f2 Ingo Molnar               2017-09-23  1141  	return 0;
79fecc2b7506f2 Ingo Molnar               2017-09-23  1142  }
79fecc2b7506f2 Ingo Molnar               2017-09-23  1143  

:::::: The code at line 1117 was first introduced by commit
:::::: 79fecc2b7506f29fb91becc65e8788e5ae7eba9f x86/fpu: Split copy_user_to_xstate() into copy_kernel_to_xstate() & copy_user_to_xstate()

:::::: TO: Ingo Molnar <mingo@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
