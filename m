Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3502B5A726F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiHaAct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiHaAco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:32:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905AFA407D;
        Tue, 30 Aug 2022 17:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661905963; x=1693441963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPTkL5Ut9qXS4ROpinL7/DFZZwH7WHdiHczciJOL6gY=;
  b=nUihuw1Ew4rdDq7A2oeAOQPE5sr8XyXENbd8KBmWGBIKV8Ae87xty2UT
   rpjJvAggQ5ygXZv0Y9Hlgx1CBwp6ZDgUT3VOSPd0VjQIX4ifBWYbb8nf2
   ZHWVbTRW2qeCdIMqOfMYaHRHWN5El6bbMen+js3/TVa9qJACHBuzdiwmP
   iJSlhM60+BRqIsBYhaa1d3EXUdxq2eK3V3FL6JNhLLrsSGcLxxP4caAmA
   dr1dkWEoTkVbVaWCcbMkEaLoSEjDmiU1T0NybzlzB/wXz3+c2W+fuVxJI
   8Jl3qNyYuSVp7YPLscYpy61Lt4CqMOcTeUOJMJpRKnCVLAFP2dKaeZfyr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381635229"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="381635229"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 17:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="701197325"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2022 17:32:40 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTBep-0000nH-34;
        Wed, 31 Aug 2022 00:32:39 +0000
Date:   Wed, 31 Aug 2022 08:32:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [RESEND PATCH v2 4/5] firmware: qcom: scm: Add wait-queue helper
 functions
Message-ID: <202208310849.pEettWuy-lkp@intel.com>
References: <1661898311-30126-5-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661898311-30126-5-git-send-email-quic_gurus@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guru,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220830]
[cannot apply to robh/for-next linus/master v6.0-rc3 v6.0-rc2 v6.0-rc1 v6.0-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guru-Das-Srinagesh/SCM-Add-support-for-wait-queue-aware-firmware/20220831-063013
base:    282342f2dc97ccf54254c5de51bcc1101229615f
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220831/202208310849.pEettWuy-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ad41ee028d07c3e3e41b15e6bd8e2985f30df508
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Guru-Das-Srinagesh/SCM-Add-support-for-wait-queue-aware-firmware/20220831-063013
        git checkout ad41ee028d07c3e3e41b15e6bd8e2985f30df508
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/firmware/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from arch/m68k/include/asm/virtconvert.h:12,
                    from arch/m68k/include/asm/io_mm.h:26,
                    from arch/m68k/include/asm/io.h:8,
                    from include/linux/io.h:13,
                    from drivers/firmware/qcom_scm-smc.c:6:
   drivers/firmware/qcom_scm-smc.c: In function 'fill_wq_resume_args':
>> arch/m68k/include/asm/string.h:68:25: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
      68 | #define memset(d, c, n) __builtin_memset(d, c, n)
         |                         ^~~~~~~~~~~~~~~~
   drivers/firmware/qcom_scm-smc.c:58:9: note: in expansion of macro 'memset'
      58 |         memset(resume->args, 0, ARRAY_SIZE(resume->args));
         |         ^~~~~~
   drivers/firmware/qcom_scm-smc.c: In function 'fill_wq_wake_ack_args':
>> arch/m68k/include/asm/string.h:68:25: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
      68 | #define memset(d, c, n) __builtin_memset(d, c, n)
         |                         ^~~~~~~~~~~~~~~~
   drivers/firmware/qcom_scm-smc.c:71:9: note: in expansion of macro 'memset'
      71 |         memset(wake_ack->args, 0, ARRAY_SIZE(wake_ack->args));
         |         ^~~~~~
   drivers/firmware/qcom_scm-smc.c: In function 'fill_get_wq_ctx_args':
>> arch/m68k/include/asm/string.h:68:25: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
      68 | #define memset(d, c, n) __builtin_memset(d, c, n)
         |                         ^~~~~~~~~~~~~~~~
   drivers/firmware/qcom_scm-smc.c:84:9: note: in expansion of macro 'memset'
      84 |         memset(get_wq_ctx->args, 0, ARRAY_SIZE(get_wq_ctx->args));
         |         ^~~~~~
   drivers/firmware/qcom_scm-smc.c: At top level:
   drivers/firmware/qcom_scm-smc.c:69:13: warning: 'fill_wq_wake_ack_args' defined but not used [-Wunused-function]
      69 | static void fill_wq_wake_ack_args(struct arm_smccc_args *wake_ack, u32 smc_call_ctx)
         |             ^~~~~~~~~~~~~~~~~~~~~
   drivers/firmware/qcom_scm-smc.c:56:13: warning: 'fill_wq_resume_args' defined but not used [-Wunused-function]
      56 | static void fill_wq_resume_args(struct arm_smccc_args *resume, u32 smc_call_ctx)
         |             ^~~~~~~~~~~~~~~~~~~


vim +/memset +68 arch/m68k/include/asm/string.h

ea61bc461d09e8 Greg Ungerer 2010-09-07  65  
ea61bc461d09e8 Greg Ungerer 2010-09-07  66  #define __HAVE_ARCH_MEMSET
ea61bc461d09e8 Greg Ungerer 2010-09-07  67  extern void *memset(void *, int, __kernel_size_t);
ea61bc461d09e8 Greg Ungerer 2010-09-07 @68  #define memset(d, c, n) __builtin_memset(d, c, n)
ea61bc461d09e8 Greg Ungerer 2010-09-07  69  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
