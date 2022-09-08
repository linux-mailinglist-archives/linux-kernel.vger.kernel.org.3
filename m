Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4B05B1897
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIHJZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIHJYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:24:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA1D796B0;
        Thu,  8 Sep 2022 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662629055; x=1694165055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NMMdOivcSzeIEVychxnk3SDpIBJqhUWIwpaRsOdPn7c=;
  b=RN47XvmPnEkju8y+xW8dBERMgRsthYJtg3mEk08W0+Od1R8F3JVLDd2I
   cUI+LvBEzVebgBs5NOGHztTaPj1SOzLte5T4DwU4CwrLqI0SWbEI9Yszo
   FjphqNMiNUHpwHHH8EmIfkfqAgeM04AxlaoM4zqauH8KECO0+BZ4F2QLL
   uZqEyFJWlflxx2lB0btTm+uv7yXYR5peByoTczOY1SN81Gu9wXDdVxhTs
   r5CD/Qq6ALOpVuxxn26pybIYYNv90EF3GwWtd5G6outI0StUEnK4pZyBv
   qkl9ByH4E3m6K8MWUcPw0m9Z6JMaAC5ijGs1tZ3g7kacoRzHfs05dCQhf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="383414849"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="383414849"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 02:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="647976047"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Sep 2022 02:23:59 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWDlP-0007a9-0c;
        Thu, 08 Sep 2022 09:23:59 +0000
Date:   Thu, 8 Sep 2022 17:23:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     kbuild-all@lists.01.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2 6/7] arm64/perf: Add BRBE driver
Message-ID: <202209081717.00OiPpzm-lkp@intel.com>
References: <20220908051046.465307-7-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908051046.465307-7-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on acme/perf/core]
[also build test ERROR on tip/perf/core arm64/for-next/core linus/master v6.0-rc4 next-20220907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220908-131425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
config: arm64-buildonly-randconfig-r002-20220907 (https://download.01.org/0day-ci/archive/20220908/202209081717.00OiPpzm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5b70e42a715860504646cb5bd1788ddb823dd50b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220908-131425
        git checkout 5b70e42a715860504646cb5bd1788ddb823dd50b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/perf/arm_pmu_brbe.c: In function 'brbe_fetch_perf_type':
>> drivers/perf/arm_pmu_brbe.c:251:24: error: 'PERF_BR_ARM64_DEBUG_HALT' undeclared (first use in this function)
     251 |                 return PERF_BR_ARM64_DEBUG_HALT;
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_pmu_brbe.c:251:24: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/perf/arm_pmu_brbe.c:253:24: error: 'PERF_BR_SERROR' undeclared (first use in this function); did you mean 'PERF_BR_ERET'?
     253 |                 return PERF_BR_SERROR;
         |                        ^~~~~~~~~~~~~~
         |                        PERF_BR_ERET
>> drivers/perf/arm_pmu_brbe.c:256:24: error: 'PERF_BR_ARM64_DEBUG_INST' undeclared (first use in this function)
     256 |                 return PERF_BR_ARM64_DEBUG_INST;
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:259:24: error: 'PERF_BR_ARM64_DEBUG_DATA' undeclared (first use in this function)
     259 |                 return PERF_BR_ARM64_DEBUG_DATA;
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:262:24: error: 'PERF_BR_NEW_FAULT_ALGN' undeclared (first use in this function)
     262 |                 return PERF_BR_NEW_FAULT_ALGN;
         |                        ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:265:24: error: 'PERF_BR_NEW_FAULT_INST' undeclared (first use in this function)
     265 |                 return PERF_BR_NEW_FAULT_INST;
         |                        ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:268:24: error: 'PERF_BR_NEW_FAULT_DATA' undeclared (first use in this function)
     268 |                 return PERF_BR_NEW_FAULT_DATA;
         |                        ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:271:24: error: 'PERF_BR_ARM64_FIQ' undeclared (first use in this function); did you mean 'PERF_REG_ARM64_MAX'?
     271 |                 return PERF_BR_ARM64_FIQ;
         |                        ^~~~~~~~~~~~~~~~~
         |                        PERF_REG_ARM64_MAX
>> drivers/perf/arm_pmu_brbe.c:274:24: error: 'PERF_BR_ARM64_DEBUG_EXIT' undeclared (first use in this function)
     274 |                 return PERF_BR_ARM64_DEBUG_EXIT;
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_pmu_brbe.c: In function 'brbe_fetch_perf_priv':
>> drivers/perf/arm_pmu_brbe.c:287:23: error: 'PERF_BR_PRIV_USER' undeclared (first use in this function)
     287 |                return PERF_BR_PRIV_USER;
         |                       ^~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:289:23: error: 'PERF_BR_PRIV_KERNEL' undeclared (first use in this function); did you mean 'PERF_SECURITY_KERNEL'?
     289 |                return PERF_BR_PRIV_KERNEL;
         |                       ^~~~~~~~~~~~~~~~~~~
         |                       PERF_SECURITY_KERNEL
>> drivers/perf/arm_pmu_brbe.c:293:23: error: 'PERF_BR_PRIV_HV' undeclared (first use in this function)
     293 |                return PERF_BR_PRIV_HV;
         |                       ^~~~~~~~~~~~~~~
   drivers/perf/arm_pmu_brbe.c: In function 'capture_brbe_flags':
>> drivers/perf/arm_pmu_brbe.c:306:14: error: implicit declaration of function 'branch_sample_no_cycles' [-Werror=implicit-function-declaration]
     306 |         if (!branch_sample_no_cycles(event))
         |              ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:309:13: error: implicit declaration of function 'branch_sample_type' [-Werror=implicit-function-declaration]
     309 |         if (branch_sample_type(event)) {
         |             ^~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:312:56: error: 'PERF_BR_EXTEND_ABI' undeclared (first use in this function)
     312 |                         cpuc->brbe_entries[idx].type = PERF_BR_EXTEND_ABI;
         |                                                        ^~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:313:48: error: 'struct perf_branch_entry' has no member named 'new_type'
     313 |                         cpuc->brbe_entries[idx].new_type = branch_type;
         |                                                ^
>> drivers/perf/arm_pmu_brbe.c:319:14: error: implicit declaration of function 'branch_sample_no_flags' [-Werror=implicit-function-declaration]
     319 |         if (!branch_sample_no_flags(event)) {
         |              ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:341:13: error: implicit declaration of function 'branch_sample_priv' [-Werror=implicit-function-declaration]
     341 |         if (branch_sample_priv(event)) {
         |             ^~~~~~~~~~~~~~~~~~
>> drivers/perf/arm_pmu_brbe.c:347:48: error: 'struct perf_branch_entry' has no member named 'priv'
     347 |                         cpuc->brbe_entries[idx].priv = brbe_fetch_perf_priv(brbinf);
         |                                                ^
   drivers/perf/arm_pmu_brbe.c: In function 'brbe_fetch_perf_type':
>> drivers/perf/arm_pmu_brbe.c:250:34: warning: this statement may fall through [-Wimplicit-fallthrough=]
     250 |                 *new_branch_type = true;
         |                 ~~~~~~~~~~~~~~~~~^~~~~~
   drivers/perf/arm_pmu_brbe.c:252:9: note: here
     252 |         case BRBINF_TYPE_SERROR:
         |         ^~~~
   drivers/perf/arm_pmu_brbe.c:255:34: warning: this statement may fall through [-Wimplicit-fallthrough=]
     255 |                 *new_branch_type = true;
         |                 ~~~~~~~~~~~~~~~~~^~~~~~
   drivers/perf/arm_pmu_brbe.c:257:9: note: here
     257 |         case BRBINF_TYPE_DATA_DEBUG:
         |         ^~~~
   drivers/perf/arm_pmu_brbe.c:258:34: warning: this statement may fall through [-Wimplicit-fallthrough=]
     258 |                 *new_branch_type = true;
         |                 ~~~~~~~~~~~~~~~~~^~~~~~
   drivers/perf/arm_pmu_brbe.c:260:9: note: here
     260 |         case BRBINF_TYPE_ALGN_FAULT:
         |         ^~~~
   drivers/perf/arm_pmu_brbe.c:261:34: warning: this statement may fall through [-Wimplicit-fallthrough=]
     261 |                 *new_branch_type = true;
         |                 ~~~~~~~~~~~~~~~~~^~~~~~
   drivers/perf/arm_pmu_brbe.c:263:9: note: here
     263 |         case BRBINF_TYPE_INST_FAULT:
         |         ^~~~
   drivers/perf/arm_pmu_brbe.c:264:34: warning: this statement may fall through [-Wimplicit-fallthrough=]
     264 |                 *new_branch_type = true;
         |                 ~~~~~~~~~~~~~~~~~^~~~~~
   drivers/perf/arm_pmu_brbe.c:266:9: note: here
     266 |         case BRBINF_TYPE_DATA_FAULT:
         |         ^~~~
   drivers/perf/arm_pmu_brbe.c:267:34: warning: this statement may fall through [-Wimplicit-fallthrough=]
     267 |                 *new_branch_type = true;
         |                 ~~~~~~~~~~~~~~~~~^~~~~~
   drivers/perf/arm_pmu_brbe.c:269:9: note: here
     269 |         case BRBINF_TYPE_FIQ:
         |         ^~~~
   drivers/perf/arm_pmu_brbe.c:270:34: warning: this statement may fall through [-Wimplicit-fallthrough=]
     270 |                 *new_branch_type = true;
         |                 ~~~~~~~~~~~~~~~~~^~~~~~
   drivers/perf/arm_pmu_brbe.c:272:9: note: here
     272 |         case BRBINF_TYPE_DEBUG_EXIT:
         |         ^~~~
   drivers/perf/arm_pmu_brbe.c:273:34: warning: this statement may fall through [-Wimplicit-fallthrough=]
     273 |                 *new_branch_type = true;
         |                 ~~~~~~~~~~~~~~~~~^~~~~~
   drivers/perf/arm_pmu_brbe.c:275:9: note: here
     275 |         default:
         |         ^~~~~~~
   cc1: some warnings being treated as errors


vim +/PERF_BR_ARM64_DEBUG_HALT +251 drivers/perf/arm_pmu_brbe.c

   222	
   223	static int brbe_fetch_perf_type(u64 brbinf, bool *new_branch_type)
   224	{
   225		int brbe_type = brbe_fetch_type(brbinf);
   226		*new_branch_type = false;
   227	
   228		switch (brbe_type) {
   229		case BRBINF_TYPE_UNCOND_DIR:
   230			return PERF_BR_UNCOND;
   231		case BRBINF_TYPE_INDIR:
   232			return PERF_BR_IND;
   233		case BRBINF_TYPE_DIR_LINK:
   234			return PERF_BR_CALL;
   235		case BRBINF_TYPE_INDIR_LINK:
   236			return PERF_BR_IND_CALL;
   237		case BRBINF_TYPE_RET_SUB:
   238			return PERF_BR_RET;
   239		case BRBINF_TYPE_COND_DIR:
   240			return PERF_BR_COND;
   241		case BRBINF_TYPE_CALL:
   242			return PERF_BR_CALL;
   243		case BRBINF_TYPE_TRAP:
   244			return PERF_BR_SYSCALL;
   245		case BRBINF_TYPE_RET_EXCPT:
   246			return PERF_BR_ERET;
   247		case BRBINF_TYPE_IRQ:
   248			return PERF_BR_IRQ;
   249		case BRBINF_TYPE_DEBUG_HALT:
 > 250			*new_branch_type = true;
 > 251			return PERF_BR_ARM64_DEBUG_HALT;
   252		case BRBINF_TYPE_SERROR:
 > 253			return PERF_BR_SERROR;
   254		case BRBINF_TYPE_INST_DEBUG:
   255			*new_branch_type = true;
 > 256			return PERF_BR_ARM64_DEBUG_INST;
   257		case BRBINF_TYPE_DATA_DEBUG:
   258			*new_branch_type = true;
 > 259			return PERF_BR_ARM64_DEBUG_DATA;
   260		case BRBINF_TYPE_ALGN_FAULT:
   261			*new_branch_type = true;
 > 262			return PERF_BR_NEW_FAULT_ALGN;
   263		case BRBINF_TYPE_INST_FAULT:
   264			*new_branch_type = true;
 > 265			return PERF_BR_NEW_FAULT_INST;
   266		case BRBINF_TYPE_DATA_FAULT:
   267			*new_branch_type = true;
 > 268			return PERF_BR_NEW_FAULT_DATA;
   269		case BRBINF_TYPE_FIQ:
   270			*new_branch_type = true;
 > 271			return PERF_BR_ARM64_FIQ;
   272		case BRBINF_TYPE_DEBUG_EXIT:
   273			*new_branch_type = true;
 > 274			return PERF_BR_ARM64_DEBUG_EXIT;
   275		default:
   276			pr_warn("unknown branch type captured\n");
   277			return PERF_BR_UNKNOWN;
   278		}
   279	}
   280	
   281	static int brbe_fetch_perf_priv(u64 brbinf)
   282	{
   283	       int brbe_el = brbe_fetch_el(brbinf);
   284	
   285	       switch (brbe_el) {
   286	       case BRBINF_EL_EL0:
 > 287	               return PERF_BR_PRIV_USER;
   288	       case BRBINF_EL_EL1:
 > 289	               return PERF_BR_PRIV_KERNEL;
   290	       case BRBINF_EL_EL2:
   291	               if (is_kernel_in_hyp_mode())
   292	                       return PERF_BR_PRIV_KERNEL;
 > 293	               return PERF_BR_PRIV_HV;
   294	       default:
   295	               pr_warn("unknown branch privilege captured\n");
   296	               return -1;
   297	       }
   298	}
   299	
   300	static void capture_brbe_flags(struct pmu_hw_events *cpuc, struct perf_event *event,
   301				       u64 brbinf, int idx)
   302	{
   303		int branch_type, type = brbe_record_valid(brbinf);
   304		bool new_branch_type;
   305	
 > 306		if (!branch_sample_no_cycles(event))
   307			cpuc->brbe_entries[idx].cycles = brbe_fetch_cycles(brbinf);
   308	
 > 309		if (branch_sample_type(event)) {
   310			branch_type = brbe_fetch_perf_type(brbinf, &new_branch_type);
   311			if (new_branch_type) {
 > 312				cpuc->brbe_entries[idx].type = PERF_BR_EXTEND_ABI;
 > 313				cpuc->brbe_entries[idx].new_type = branch_type;
   314			} else {
   315				cpuc->brbe_entries[idx].type = branch_type;
   316			}
   317		}
   318	
 > 319		if (!branch_sample_no_flags(event)) {
   320			/*
   321			 * BRBINF_LASTFAILED does not indicate that the last transaction
   322			 * got failed or aborted during the current branch record itself.
   323			 * Rather, this indicates that all the branch records which were
   324			 * in transaction until the curret branch record have failed. So
   325			 * the entire BRBE buffer needs to be processed later on to find
   326			 * all branch records which might have failed.
   327			 */
   328			cpuc->brbe_entries[idx].abort = brbinf & BRBINF_LASTFAILED;
   329	
   330			/*
   331			 * All these information (i.e transaction state and mispredicts)
   332			 * are not available for target only branch records.
   333			 */
   334			if (type != BRBINF_VALID_TARGET) {
   335				cpuc->brbe_entries[idx].mispred = brbinf & BRBINF_MPRED;
   336				cpuc->brbe_entries[idx].predicted = !(brbinf & BRBINF_MPRED);
   337				cpuc->brbe_entries[idx].in_tx = brbinf & BRBINF_TX;
   338			}
   339		}
   340	
 > 341		if (branch_sample_priv(event)) {
   342			/*
   343			 * All these information (i.e branch privilege level) are not
   344			 * available for source only branch records.
   345			 */
   346			if (type != BRBINF_VALID_SOURCE)
 > 347				cpuc->brbe_entries[idx].priv = brbe_fetch_perf_priv(brbinf);
   348		}
   349	}
   350	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
