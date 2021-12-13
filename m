Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D54734BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhLMTQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:16:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:65225 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231878AbhLMTQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639423017; x=1670959017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bp3F5ril2o2hFHFGNs2ohZXce1AXnq3rH4wu9NdRWF4=;
  b=PqzPwKnQO1KQ/Q3bkea+ZF29nKxmyhHbecenuQX+GCKrJCbEbcLqO8UJ
   yCrZgMkZQBnyMH+rDVkp+0mAg/r9JPZz//YAnqHrR8NPGnRlfPJBkfDPf
   Wve1OQuryQVdqiMs9wIk2GZoOXc9vQ+E8JoDO1ORnyUci/c6KFIf9Qnsg
   DADC6lY/kTtBDijltgKSTl2s+0vHyzdG3akDmGL4R3FUuhQ+ItCwkOO0L
   HSDa0jtzXstdstWRPpcHJgAkhrzLoTRgzjymnDLLpKyxc7iGPEOFAAFJS
   2uydQpWs5m1ch1OG2zLv83jq4bfg9HQYRHBz3c4rCFo7M9/8GdvaURr9b
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="262940003"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="262940003"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 11:16:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="464762074"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 11:16:54 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwqof-0006yR-Bq; Mon, 13 Dec 2021 19:16:53 +0000
Date:   Tue, 14 Dec 2021 03:16:42 +0800
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
Subject: Re: [PATCH v2 4/4] coresight: etm3x: Don't trace PID for non-root
 PID namespace
Message-ID: <202112140344.viPmOWp6-lkp@intel.com>
References: <20211213121323.1887180-5-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213121323.1887180-5-leo.yan@linaro.org>
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
config: arm-buildonly-randconfig-r003-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140344.viPmOWp6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/81d5f47788c40d34c8159d64d4505eb485254e8f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Leo-Yan/coresight-etm-Correct-PID-tracing-for-non-root-namespace/20211213-201632
        git checkout 81d5f47788c40d34c8159d64d4505eb485254e8f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-etm3x-core.c:344:7: error: implicit declaration of function 'task_is_in_init_pid_ns' [-Werror,-Wimplicit-function-declaration]
           if (!task_is_in_init_pid_ns(current))
                ^
   1 error generated.


vim +/task_is_in_init_pid_ns +344 drivers/hwtracing/coresight/coresight-etm3x-core.c

   301	
   302	#define ETM3X_SUPPORTED_OPTIONS (ETMCR_CYC_ACC | \
   303					 ETMCR_TIMESTAMP_EN | \
   304					 ETMCR_RETURN_STACK)
   305	
   306	static int etm_parse_event_config(struct etm_drvdata *drvdata,
   307					  struct perf_event *event)
   308	{
   309		struct etm_config *config = &drvdata->config;
   310		struct perf_event_attr *attr = &event->attr;
   311	
   312		if (!attr)
   313			return -EINVAL;
   314	
   315		/* Clear configuration from previous run */
   316		memset(config, 0, sizeof(struct etm_config));
   317	
   318		if (attr->exclude_kernel)
   319			config->mode = ETM_MODE_EXCL_KERN;
   320	
   321		if (attr->exclude_user)
   322			config->mode = ETM_MODE_EXCL_USER;
   323	
   324		/* Always start from the default config */
   325		etm_set_default(config);
   326	
   327		/*
   328		 * By default the tracers are configured to trace the whole address
   329		 * range.  Narrow the field only if requested by user space.
   330		 */
   331		if (config->mode)
   332			etm_config_trace_mode(config);
   333	
   334		/*
   335		 * At this time only cycle accurate, return stack  and timestamp
   336		 * options are available.
   337		 */
   338		if (attr->config & ~ETM3X_SUPPORTED_OPTIONS)
   339			return -EINVAL;
   340	
   341		config->ctrl = attr->config;
   342	
   343		/* Don't trace contextID when runs in non-root PID namespace */
 > 344		if (!task_is_in_init_pid_ns(current))
   345			config->ctrl &= ~ETMCR_CTXID_SIZE;
   346	
   347		/*
   348		 * Possible to have cores with PTM (supports ret stack) and ETM
   349		 * (never has ret stack) on the same SoC. So if we have a request
   350		 * for return stack that can't be honoured on this core then
   351		 * clear the bit - trace will still continue normally
   352		 */
   353		if ((config->ctrl & ETMCR_RETURN_STACK) &&
   354		    !(drvdata->etmccer & ETMCCER_RETSTACK))
   355			config->ctrl &= ~ETMCR_RETURN_STACK;
   356	
   357		return 0;
   358	}
   359	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
