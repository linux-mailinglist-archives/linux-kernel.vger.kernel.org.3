Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6715849FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiG2C4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiG2C4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:56:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F752982E;
        Thu, 28 Jul 2022 19:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659063374; x=1690599374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E/Uyyb+h/AV7J/aT5ZRju9JhnFkYi1/BQWx3o8jvrNM=;
  b=CHy+eMlBZ2HLixmxZxTNQre6NLs4+n7NdhvTzuPTgHDxpt8YuchK6st7
   NDhAimrU6rvws5LlsxUrvizEvif2iwjnlA714zTJD1jF0w2/Bh+OHJ5S6
   JziKmHyk8SWvQvxiEax+7F2KLC9OxASTi2tUPNoXGWuL+bUO1qD1B6bEs
   GFdkdh1APLRqe9I7ewaiuVVb7BpHxxstgtLHxaKUYWMKxDkDOP4e1Wf4B
   YZ9t3ShNo6IhkDbWHgRQmEDwXDpLPROTnAH9ho0e5pHH2N2IR9nEXvKiA
   GAd14ytAdJ3YkIpROUIcbgxG6o119I7HdkWi+brQ0Q7e915HT4ltPuoEZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="268440538"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="268440538"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 19:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="928578998"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2022 19:56:11 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHGAd-000Ay1-05;
        Fri, 29 Jul 2022 02:56:11 +0000
Date:   Fri, 29 Jul 2022 10:55:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, rafael@kernel.org, lenb@kernel.org,
        viresh.kumar@linaro.org, robert.moore@intel.com, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH] ACPI: CPPC: Disable FIE if registers in PCC regions
Message-ID: <202207291003.Wk3c06eH-lkp@intel.com>
References: <20220726145948.2194684-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726145948.2194684-1-jeremy.linton@arm.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/ACPI-CPPC-Disable-FIE-if-registers-in-PCC-regions/20220726-230217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220729/202207291003.Wk3c06eH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a4dd80cfc857eef429f60e999bdc9479179d495e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeremy-Linton/ACPI-CPPC-Disable-FIE-if-registers-in-PCC-regions/20220726-230217
        git checkout a4dd80cfc857eef429f60e999bdc9479179d495e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/acpi-cpufreq.c:29:
>> include/acpi/cppc_acpi.h:177:12: warning: no previous prototype for 'cppc_perf_ctrs_in_pcc' [-Wmissing-prototypes]
     177 | extern int cppc_perf_ctrs_in_pcc(void)
         |            ^~~~~~~~~~~~~~~~~~~~~
--
   ld: drivers/cpufreq/intel_pstate.o: in function `cppc_perf_ctrs_in_pcc':
>> include/acpi/cppc_acpi.h:178: multiple definition of `cppc_perf_ctrs_in_pcc'; drivers/cpufreq/acpi-cpufreq.o:include/acpi/cppc_acpi.h:178: first defined here


vim +178 include/acpi/cppc_acpi.h

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
 > 178	{
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
