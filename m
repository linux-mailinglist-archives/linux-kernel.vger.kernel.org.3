Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF534736AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbhLMVqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:46:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:39864 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232880AbhLMVqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639431960; x=1670967960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODwpa4UD3cYTZoE09MpsHk3csZgputflriPMeV4XqDo=;
  b=BRdH3AWbfsAxGcZKgD3A6oEWOPEpY7sbTiU/xrKpz9AwYSVLLkahNX1n
   2QcCh/aH8T0Q2wZ9op6KAacm9uca/qJoms8cJn7cGpcFMdx5V9PbiEeLg
   jMb7kB1KyatsjyYmFV9A/wfBccJ2GrDhzRoakUbZkbTUsMU3bXau0fuVK
   Vs1QI+ESVZV/10Q8SJhaa9lqqFQAKLBLLz6rl/I7pwIXoTO2vZOk7tW/U
   kfityAOdqoiBPTWk++pH3T8+SF6NqHAFPVzWgMR7Ky5qwd2NmOCWYYgE+
   6vuRsD4QjHIytkxLuDmzPvYRrubA67XRjCe91OrwjgG520qdR4WX5jaxJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="237572190"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="237572190"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 13:46:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="463541162"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2021 13:45:57 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwt8u-00075v-Ai; Mon, 13 Dec 2021 21:45:56 +0000
Date:   Tue, 14 Dec 2021 05:45:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v2 3/4] coresight: etm4x: Don't trace PID for non-root
 PID namespace
Message-ID: <202112140527.RSkgSFCc-lkp@intel.com>
References: <20211213121323.1887180-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213121323.1887180-4-leo.yan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Leo-Yan/coresight-etm-Correct-PID-tracing-for-non-root-namespace/20211213-201632
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2585cf9dfaaddf00b069673f27bb3f8530e2039c
config: arm64-randconfig-r034-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140527.RSkgSFCc-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/dd716cd12b2f0e47fcc2b0e3e9172e4e70ad4877
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Leo-Yan/coresight-etm-Correct-PID-tracing-for-non-root-namespace/20211213-201632
        git checkout dd716cd12b2f0e47fcc2b0e3e9172e4e70ad4877
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-etm4x-core.c:661:6: error: implicit declaration of function 'task_is_in_init_pid_ns' [-Werror,-Wimplicit-function-declaration]
               task_is_in_init_pid_ns(current))
               ^
   1 error generated.


vim +/task_is_in_init_pid_ns +661 drivers/hwtracing/coresight/coresight-etm4x-core.c

   606	
   607	static int etm4_parse_event_config(struct coresight_device *csdev,
   608					   struct perf_event *event)
   609	{
   610		int ret = 0;
   611		struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
   612		struct etmv4_config *config = &drvdata->config;
   613		struct perf_event_attr *attr = &event->attr;
   614		unsigned long cfg_hash;
   615		int preset;
   616	
   617		/* Clear configuration from previous run */
   618		memset(config, 0, sizeof(struct etmv4_config));
   619	
   620		if (attr->exclude_kernel)
   621			config->mode = ETM_MODE_EXCL_KERN;
   622	
   623		if (attr->exclude_user)
   624			config->mode = ETM_MODE_EXCL_USER;
   625	
   626		/* Always start from the default config */
   627		etm4_set_default_config(config);
   628	
   629		/* Configure filters specified on the perf cmd line, if any. */
   630		ret = etm4_set_event_filters(drvdata, event);
   631		if (ret)
   632			goto out;
   633	
   634		/* Go from generic option to ETMv4 specifics */
   635		if (attr->config & BIT(ETM_OPT_CYCACC)) {
   636			config->cfg |= BIT(4);
   637			/* TRM: Must program this for cycacc to work */
   638			config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
   639		}
   640		if (attr->config & BIT(ETM_OPT_TS)) {
   641			/*
   642			 * Configure timestamps to be emitted at regular intervals in
   643			 * order to correlate instructions executed on different CPUs
   644			 * (CPU-wide trace scenarios).
   645			 */
   646			ret = etm4_config_timestamp_event(drvdata);
   647	
   648			/*
   649			 * No need to go further if timestamp intervals can't
   650			 * be configured.
   651			 */
   652			if (ret)
   653				goto out;
   654	
   655			/* bit[11], Global timestamp tracing bit */
   656			config->cfg |= BIT(11);
   657		}
   658	
   659		/* Only trace contextID when runs in root PID namespace */
   660		if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
 > 661		    task_is_in_init_pid_ns(current))
   662			/* bit[6], Context ID tracing bit */
   663			config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
   664	
   665		/*
   666		 * If set bit ETM_OPT_CTXTID2 in perf config, this asks to trace VMID
   667		 * for recording CONTEXTIDR_EL2.  Do not enable VMID tracing if the
   668		 * kernel is not running in EL2.
   669		 */
   670		if (attr->config & BIT(ETM_OPT_CTXTID2)) {
   671			if (!is_kernel_in_hyp_mode()) {
   672				ret = -EINVAL;
   673				goto out;
   674			}
   675	
   676			/* Only trace virtual contextID when runs in root PID namespace */
   677			if (task_is_in_init_pid_ns(current))
   678				config->cfg |= BIT(ETM4_CFG_BIT_VMID) |
   679					       BIT(ETM4_CFG_BIT_VMID_OPT);
   680		}
   681	
   682		/* return stack - enable if selected and supported */
   683		if ((attr->config & BIT(ETM_OPT_RETSTK)) && drvdata->retstack)
   684			/* bit[12], Return stack enable bit */
   685			config->cfg |= BIT(12);
   686	
   687		/*
   688		 * Set any selected configuration and preset.
   689		 *
   690		 * This extracts the values of PMU_FORMAT_ATTR(configid) and PMU_FORMAT_ATTR(preset)
   691		 * in the perf attributes defined in coresight-etm-perf.c.
   692		 * configid uses bits 63:32 of attr->config2, preset uses bits 3:0 of attr->config.
   693		 * A zero configid means no configuration active, preset = 0 means no preset selected.
   694		 */
   695		if (attr->config2 & GENMASK_ULL(63, 32)) {
   696			cfg_hash = (u32)(attr->config2 >> 32);
   697			preset = attr->config & 0xF;
   698			ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
   699		}
   700	
   701	out:
   702		return ret;
   703	}
   704	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
