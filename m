Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2989452B365
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiERHQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiERHQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:16:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D688FD7A;
        Wed, 18 May 2022 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652858199; x=1684394199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0IL0WsCd3/HrKBEhnZxB/UtqoL3AiE13Ig/YdXaNECc=;
  b=eFQDZfadVSk4x17IA06xFmftv8weyNNCUQ6ymjTKMoaZJ01iwuQC4uza
   HUFQzDw0iyWjtVG16ndwvJCeSFgkoQ713Q0So0mJR+z8g0ZbkxTym63JI
   e5EE9BKE2xypVWaI4fYTSMTQOXwCCxs4zpdfDEQXgeNqTBQMoklqFKSqM
   PS+u1HlMSilA+adW6rjj23Q2Kop8Yl8O8wTkfABOi8S1GquOoLz72uSy6
   mVIOK82OT72fArfdO4I6e7YvTOdUELDRalAVrGCH7Njwgrqw4gmN4m8Gj
   HIhU9N/Sn4j1ptq0siWsldYUBoJQ2DM81/Wmsj/xpk1ok2uKprQFmMCI6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="357931708"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="357931708"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="898089195"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 May 2022 00:16:22 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrDuw-0001v6-6S;
        Wed, 18 May 2022 07:16:22 +0000
Date:   Wed, 18 May 2022 15:16:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>, robin.murphy@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        suzuki.poulose@arm.com, treding@nvidia.com, jonathanh@nvidia.com,
        vsethi@nvidia.com, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: Re: [PATCH v2 1/2] perf: coresight_pmu: Add support for ARM
 CoreSight PMU driver
Message-ID: <202205181534.wuyBFt9d-lkp@intel.com>
References: <20220515163044.50055-2-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515163044.50055-2-bwicaksono@nvidia.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Besar,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on soc/for-next linus/master v5.18-rc7 next-20220517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Besar-Wicaksono/perf-coresight_pmu-Add-support-for-ARM-CoreSight-PMU-driver/20220516-013131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220518/202205181534.wuyBFt9d-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/79f30980a7a91e6bbe7430206e4e46fa8134cfa9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Besar-Wicaksono/perf-coresight_pmu-Add-support-for-ARM-CoreSight-PMU-driver/20220516-013131
        git checkout 79f30980a7a91e6bbe7430206e4e46fa8134cfa9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/media/platform/qcom/venus/ drivers/perf/coresight_pmu/ drivers/rtc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/perf/coresight_pmu/arm_coresight_pmu.c:165:49: error: incomplete definition of type 'struct acpi_apmt_node'
           return CHECK_APMT_FLAG(coresight_pmu->apmt_node->flags, ATOMIC, SUPP);
                                  ~~~~~~~~~~~~~~~~~~~~~~~~^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:4: note: expanded from macro 'CHECK_APMT_FLAG'
           ((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
             ^~~~~
   drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward declaration of 'struct acpi_apmt_node'
           struct acpi_apmt_node *apmt_node;
                  ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:165:9: error: use of undeclared identifier 'ACPI_APMT_FLAGS_ATOMIC'
           return CHECK_APMT_FLAG(coresight_pmu->apmt_node->flags, ATOMIC, SUPP);
                  ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:13: note: expanded from macro 'CHECK_APMT_FLAG'
           ((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
                      ^
   <scratch space>:61:1: note: expanded from here
   ACPI_APMT_FLAGS_ATOMIC
   ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:165:9: error: use of undeclared identifier 'ACPI_APMT_FLAGS_ATOMIC_SUPP'
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:41: note: expanded from macro 'CHECK_APMT_FLAG'
           ((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
                                                  ^
   <scratch space>:64:1: note: expanded from here
   ACPI_APMT_FLAGS_ATOMIC_SUPP
   ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:369:13: error: incomplete definition of type 'struct acpi_apmt_node'
                   (apmt_node->impl_id) ? apmt_node->impl_id :
                    ~~~~~~~~~^
   drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward declaration of 'struct acpi_apmt_node'
           struct acpi_apmt_node *apmt_node;
                  ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:369:35: error: incomplete definition of type 'struct acpi_apmt_node'
                   (apmt_node->impl_id) ? apmt_node->impl_id :
                                          ~~~~~~~~~^
   drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward declaration of 'struct acpi_apmt_node'
           struct acpi_apmt_node *apmt_node;
                  ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:894:58: error: incomplete definition of type 'struct acpi_apmt_node'
                   devm_kasprintf(dev, GFP_KERNEL, PMUNAME "%u", apmt_node->id);
                                                                 ~~~~~~~~~^
   drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward declaration of 'struct acpi_apmt_node'
           struct acpi_apmt_node *apmt_node;
                  ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:920:31: error: incomplete definition of type 'struct acpi_apmt_node'
           if (CHECK_APMT_FLAG(apmt_node->flags, DUAL_PAGE, SUPP)) {
                               ~~~~~~~~~^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:4: note: expanded from macro 'CHECK_APMT_FLAG'
           ((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
             ^~~~~
   drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward declaration of 'struct acpi_apmt_node'
           struct acpi_apmt_node *apmt_node;
                  ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:920:6: error: use of undeclared identifier 'ACPI_APMT_FLAGS_DUAL_PAGE'
           if (CHECK_APMT_FLAG(apmt_node->flags, DUAL_PAGE, SUPP)) {
               ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:13: note: expanded from macro 'CHECK_APMT_FLAG'
           ((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
                      ^
   <scratch space>:60:1: note: expanded from here
   ACPI_APMT_FLAGS_DUAL_PAGE
   ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:920:6: error: use of undeclared identifier 'ACPI_APMT_FLAGS_DUAL_PAGE_SUPP'
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:129:41: note: expanded from macro 'CHECK_APMT_FLAG'
           ((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
                                                  ^
   <scratch space>:63:1: note: expanded from here
   ACPI_APMT_FLAGS_DUAL_PAGE_SUPP
   ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:1028:15: error: incomplete definition of type 'struct acpi_apmt_node'
           if (apmt_node->ovflw_irq == 0)
               ~~~~~~~~~^
   drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward declaration of 'struct acpi_apmt_node'
           struct acpi_apmt_node *apmt_node;
                  ^
>> drivers/perf/coresight_pmu/arm_coresight_pmu.c:1053:6: warning: variable 'level' set but not used [-Wunused-but-set-variable]
           int level = 0;
               ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:1079:27: error: incomplete definition of type 'struct acpi_apmt_node'
           affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
                           ~~~~~~~~~^
   drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward declaration of 'struct acpi_apmt_node'
           struct acpi_apmt_node *apmt_node;
                  ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:1079:37: error: use of undeclared identifier 'ACPI_APMT_FLAGS_AFFINITY'
           affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
                                              ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:1081:23: error: use of undeclared identifier 'ACPI_APMT_FLAGS_AFFINITY_PROC'
           if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
                                ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:1083:17: error: incomplete definition of type 'struct acpi_apmt_node'
                           if (apmt_node->proc_affinity ==
                               ~~~~~~~~~^
   drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward declaration of 'struct acpi_apmt_node'
           struct acpi_apmt_node *apmt_node;
                  ^
   drivers/perf/coresight_pmu/arm_coresight_pmu.c:1093:23: error: incomplete definition of type 'struct acpi_apmt_node'
                                       cpu, apmt_node->proc_affinity))
                                            ~~~~~~~~~^
   drivers/perf/coresight_pmu/arm_coresight_pmu.h:116:9: note: forward declaration of 'struct acpi_apmt_node'
           struct acpi_apmt_node *apmt_node;
                  ^
   1 warning and 15 errors generated.


vim +/level +1053 drivers/perf/coresight_pmu/arm_coresight_pmu.c

  1047	
  1048	static inline int coresight_pmu_find_cpu_container(int cpu, u32 container_uid)
  1049	{
  1050		u32 acpi_uid;
  1051		struct device *cpu_dev = get_cpu_device(cpu);
  1052		struct acpi_device *acpi_dev = ACPI_COMPANION(cpu_dev);
> 1053		int level = 0;
  1054	
  1055		if (!cpu_dev)
  1056			return -ENODEV;
  1057	
  1058		while (acpi_dev) {
  1059			if (!strcmp(acpi_device_hid(acpi_dev),
  1060				    ACPI_PROCESSOR_CONTAINER_HID) &&
  1061			    !kstrtouint(acpi_device_uid(acpi_dev), 0, &acpi_uid) &&
  1062			    acpi_uid == container_uid)
  1063				return 0;
  1064	
  1065			acpi_dev = acpi_dev->parent;
  1066			level++;
  1067		}
  1068	
  1069		return -ENODEV;
  1070	}
  1071	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
