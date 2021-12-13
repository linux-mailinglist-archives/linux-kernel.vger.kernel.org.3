Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6186547353C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbhLMTsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:48:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:36201 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240623AbhLMTsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639424883; x=1670960883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BXOlpb85cWRWIL2HuIS1h4sB0JpmQfhe0W8/DKIs/2A=;
  b=UZgnueMNgj9jaN0KfdGlc/+wTFTwGqcH4xLmawDO8rZrWZqmh2m7wJp5
   /jq12qffGxJYwCyVJRDyXLq4CLlKANsbNWPUOSYUyqb9ZNlB1PxMFXrti
   WThooonjjfM28sx/NyCNS3HaZ83/SxpQFdrQ2uRSeR3gvJoGGUovL1TSd
   x1LxTkDZMw4At7z7gsrU+k0WTVsrlLtgwXBgWOjFQeyFPfj5gsCPlXR7F
   V6w10YoNfV1T6QVcMpGMNiEi595kUcKauJhlQwLwANJwYFnD2VS/iTrn9
   vmFQfMPuSuKNSZxlFhaXWQ9JXaxCs+0+/iTWEJJNgrSMZe2zRwmo5ZohQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="239038158"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="239038158"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 11:47:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="603838051"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2021 11:47:54 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwrIg-00070X-1R; Mon, 13 Dec 2021 19:47:54 +0000
Date:   Tue, 14 Dec 2021 03:47:22 +0800
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
Subject: Re: [PATCH v2 2/4] coresight: etm4x: Don't use virtual contextID for
 non-root PID namespace
Message-ID: <202112140333.58pdbVRp-lkp@intel.com>
References: <20211213121323.1887180-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213121323.1887180-3-leo.yan@linaro.org>
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
config: arm64-randconfig-r034-20211213 (https://download.01.org/0day-ci/archive/20211214/202112140333.58pdbVRp-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/3b7eceb25155c98432dea4821c4fc571b44d72e3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Leo-Yan/coresight-etm-Correct-PID-tracing-for-non-root-namespace/20211213-201632
        git checkout 3b7eceb25155c98432dea4821c4fc571b44d72e3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-etm4x-sysfs.c:2118:7: error: implicit declaration of function 'task_is_in_init_pid_ns' [-Werror,-Wimplicit-function-declaration]
           if (!task_is_in_init_pid_ns(current))
                ^
   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c:2139:7: error: implicit declaration of function 'task_is_in_init_pid_ns' [-Werror,-Wimplicit-function-declaration]
           if (!task_is_in_init_pid_ns(current))
                ^
   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c:2169:7: error: implicit declaration of function 'task_is_in_init_pid_ns' [-Werror,-Wimplicit-function-declaration]
           if (!task_is_in_init_pid_ns(current))
                ^
   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c:2193:7: error: implicit declaration of function 'task_is_in_init_pid_ns' [-Werror,-Wimplicit-function-declaration]
           if (!task_is_in_init_pid_ns(current))
                ^
   4 errors generated.


vim +/task_is_in_init_pid_ns +2118 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c

  2105	
  2106	static ssize_t vmid_val_show(struct device *dev,
  2107				     struct device_attribute *attr,
  2108				     char *buf)
  2109	{
  2110		unsigned long val;
  2111		struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
  2112		struct etmv4_config *config = &drvdata->config;
  2113	
  2114		/*
  2115		 * Don't use virtual contextID tracing if coming from a PID namespace.
  2116		 * See comment in ctxid_pid_store().
  2117		 */
> 2118		if (!task_is_in_init_pid_ns(current))
  2119			return -EINVAL;
  2120	
  2121		spin_lock(&drvdata->spinlock);
  2122		val = (unsigned long)config->vmid_val[config->vmid_idx];
  2123		spin_unlock(&drvdata->spinlock);
  2124		return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
  2125	}
  2126	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
