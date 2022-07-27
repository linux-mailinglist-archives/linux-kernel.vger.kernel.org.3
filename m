Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CCF581E55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiG0Dku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiG0Dkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:40:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454AC248DC;
        Tue, 26 Jul 2022 20:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658893245; x=1690429245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H3clCfHQ5Hd46X71EZ2SgoDShniIrDMAoWzjfHTbGNE=;
  b=d0YEff+yWj2j10h5Mh390YSSa4fxs/Pr9cVC+qEwyxvEEFnfJEDgA9cQ
   yCZ316Z+ZeLm6Wr3+UXL5EHAiGU0afImE+cW6+S5OoS1sJ3bDoKh8cEUo
   ohORre6j7BB192trYtG1+evNGWB/AgWaVVVArTYWgVwEACO+SlXIm0OsG
   s2DNoYcXPtYGi3MR76Ss6zyCeHe8uRFwqpLBRcTypRArvQvW5zfStXSIr
   FMTKeC4dtRNxgc3yPDyIX2xU2i33/AcZGY+ZObvuyJnpvpvsKagLQ1oYY
   42rH1s5/wiMyo1Zp9ADC1ovHCjYIjEp3Bq25VFRN+jA5Xxv22IqEFfczF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="268520211"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="268520211"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 20:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="550686759"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2022 20:40:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGXub-0008GY-0e;
        Wed, 27 Jul 2022 03:40:41 +0000
Date:   Wed, 27 Jul 2022 11:39:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pm@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, rafael@kernel.org,
        lenb@kernel.org, viresh.kumar@linaro.org, robert.moore@intel.com,
        devel@acpica.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH] ACPI: CPPC: Disable FIE if registers in PCC regions
Message-ID: <202207271136.DESdyKRY-lkp@intel.com>
References: <20220726145948.2194684-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726145948.2194684-1-jeremy.linton@arm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v5.19-rc8 next-20220726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/ACPI-CPPC-Disable-FIE-if-registers-in-PCC-regions/20220726-230217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220727/202207271136.DESdyKRY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 83882606dbd7ffb0bdd3460356202d97705809c8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a4dd80cfc857eef429f60e999bdc9479179d495e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeremy-Linton/ACPI-CPPC-Disable-FIE-if-registers-in-PCC-regions/20220726-230217
        git checkout a4dd80cfc857eef429f60e999bdc9479179d495e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/intel_pstate.c:45:
>> include/acpi/cppc_acpi.h:177:12: warning: no previous prototype for function 'cppc_perf_ctrs_in_pcc' [-Wmissing-prototypes]
   extern int cppc_perf_ctrs_in_pcc(void)
              ^
   include/acpi/cppc_acpi.h:177:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
   extern int cppc_perf_ctrs_in_pcc(void)
          ^
   1 warning generated.


vim +/cppc_perf_ctrs_in_pcc +177 include/acpi/cppc_acpi.h

   135	
   136	#ifdef CONFIG_ACPI_CPPC_LIB
   137	extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
   138	extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
   139	extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
   140	extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
   141	extern int cppc_set_enable(int cpu, bool enable);
   142	extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
   143	extern int cppc_perf_ctrs_in_pcc(void);
   144	extern bool acpi_cpc_valid(void);
   145	extern bool cppc_allow_fast_switch(void);
   146	extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
   147	extern unsigned int cppc_get_transition_latency(int cpu);
   148	extern bool cpc_ffh_supported(void);
   149	extern bool cpc_supported_by_cpu(void);
   150	extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
   151	extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
   152	#else /* !CONFIG_ACPI_CPPC_LIB */
   153	static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
   154	{
   155		return -ENOTSUPP;
   156	}
   157	static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
   158	{
   159		return -ENOTSUPP;
   160	}
   161	static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
   162	{
   163		return -ENOTSUPP;
   164	}
   165	static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
   166	{
   167		return -ENOTSUPP;
   168	}
   169	static inline int cppc_set_enable(int cpu, bool enable)
   170	{
   171		return -ENOTSUPP;
   172	}
   173	static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
   174	{
   175		return -ENOTSUPP;
   176	}
 > 177	extern int cppc_perf_ctrs_in_pcc(void)
   178	{
   179		return false;
   180	}
   181	static inline bool acpi_cpc_valid(void)
   182	{
   183		return false;
   184	}
   185	static inline bool cppc_allow_fast_switch(void)
   186	{
   187		return false;
   188	}
   189	static inline unsigned int cppc_get_transition_latency(int cpu)
   190	{
   191		return CPUFREQ_ETERNAL;
   192	}
   193	static inline bool cpc_ffh_supported(void)
   194	{
   195		return false;
   196	}
   197	static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
   198	{
   199		return -ENOTSUPP;
   200	}
   201	static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
   202	{
   203		return -ENOTSUPP;
   204	}
   205	#endif /* !CONFIG_ACPI_CPPC_LIB */
   206	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
