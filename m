Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CB15919B2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiHMJxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:53:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3187646F;
        Sat, 13 Aug 2022 02:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660384398; x=1691920398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OamMQmkw1kw/qgC1ToQfGGYK5wCJuB1mv86EUB851PE=;
  b=QH1WsiawuHZZ3SX4ZexhqUUZs5TMHQq4vPmWqLLWv3NXS0EGh8yf73S6
   VxEFxq6jtKUnvtmdNbUrwC0h6fM7Ylug5Z/hXamO9jC1K4bQkj8G3Q7ZL
   Ndv9ngrHvb0uxcTIU5i0LQdV3ejIxEtDG7CLc0SnKhqZz9xiUJxv7koBb
   t+fh0TZ/4BRBhiula5WqTFiUNfvj3KGKZBIwBLsbwlcY07dHFo5UICWBn
   ea0cu/VyjqCA++jRerz4nWJm6Ftz+XV5oLKK/lHHSnAx22tYfCnPvxAt0
   yNInB6IqmnEdB5xHRt2/s58Bqi2Wmiklpy0o6o3Yp45Wq+ov+yy03YmNM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292537612"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292537612"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 02:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="582354751"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Aug 2022 02:53:14 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMnpR-0001Xd-36;
        Sat, 13 Aug 2022 09:53:13 +0000
Date:   Sat, 13 Aug 2022 17:53:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v3 05/13] coresight: etm3x: Update ETM3 driver to use
 Trace ID API
Message-ID: <202208131723.4WupJz5f-lkp@intel.com>
References: <20220809223401.24599-6-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809223401.24599-6-mike.leach@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

I love your patch! Perhaps something to improve:

[auto build test WARNING on acme/perf/core]
[also build test WARNING on tip/perf/core atorgue-stm32/stm32-next linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Leach/coresight-Add-new-API-to-allocate-trace-source-ID-values/20220810-063940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220813/202208131723.4WupJz5f-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/48c9bb1ba00758132c4523dba423071440723ccd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mike-Leach/coresight-Add-new-API-to-allocate-trace-source-ID-values/20220810-063940
        git checkout 48c9bb1ba00758132c4523dba423071440723ccd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-etm3x-core.c:509:44: warning: 'struct etmv4_drvdata' declared inside parameter list will not be visible outside of this definition or declaration
     509 | static int etm_set_current_trace_id(struct etmv4_drvdata *drvdata)
         |                                            ^~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-etm3x-core.c: In function 'etm_set_current_trace_id':
   drivers/hwtracing/coresight/coresight-etm3x-core.c:517:58: error: invalid use of undefined type 'struct etmv4_drvdata'
     517 |         trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
         |                                                          ^~
   drivers/hwtracing/coresight/coresight-etm3x-core.c:519:24: error: invalid use of undefined type 'struct etmv4_drvdata'
     519 |                 drvdata->traceid = (u8)trace_id;
         |                        ^~
   In file included from include/linux/device.h:15,
                    from drivers/hwtracing/coresight/coresight-etm3x-core.c:12:
   drivers/hwtracing/coresight/coresight-etm3x-core.c:523:25: error: invalid use of undefined type 'struct etmv4_drvdata'
     523 |         dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
         |                         ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/hwtracing/coresight/coresight-etm3x-core.c:523:9: note: in expansion of macro 'dev_err'
     523 |         dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
         |         ^~~~~~~
   drivers/hwtracing/coresight/coresight-etm3x-core.c:524:34: error: invalid use of undefined type 'struct etmv4_drvdata'
     524 |                 dev_name(&drvdata->csdev->dev), drvdata->cpu);
         |                                  ^~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-etm3x-core.c:523:9: note: in expansion of macro 'dev_err'
     523 |         dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
         |         ^~~~~~~
   drivers/hwtracing/coresight/coresight-etm3x-core.c:524:56: error: invalid use of undefined type 'struct etmv4_drvdata'
     524 |                 dev_name(&drvdata->csdev->dev), drvdata->cpu);
         |                                                        ^~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-etm3x-core.c:523:9: note: in expansion of macro 'dev_err'
     523 |         dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
         |         ^~~~~~~
   drivers/hwtracing/coresight/coresight-etm3x-core.c: In function 'etm_enable_perf':
   drivers/hwtracing/coresight/coresight-etm3x-core.c:547:40: error: passing argument 1 of 'etm_set_current_trace_id' from incompatible pointer type [-Werror=incompatible-pointer-types]
     547 |         ret = etm_set_current_trace_id(drvdata);
         |                                        ^~~~~~~
         |                                        |
         |                                        struct etm_drvdata *
   drivers/hwtracing/coresight/coresight-etm3x-core.c:509:59: note: expected 'struct etmv4_drvdata *' but argument is of type 'struct etm_drvdata *'
     509 | static int etm_set_current_trace_id(struct etmv4_drvdata *drvdata)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   cc1: some warnings being treated as errors


vim +509 drivers/hwtracing/coresight/coresight-etm3x-core.c

   508	
 > 509	static int etm_set_current_trace_id(struct etmv4_drvdata *drvdata)
   510	{
   511		int trace_id;
   512	
   513		/*
   514		 * Set the currently allocated trace ID - perf allocates IDs
   515		 * as part of setup_aux for all CPUs it may use.
   516		 */
   517		trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
   518		if (IS_VALID_ID(trace_id)) {
   519			drvdata->traceid = (u8)trace_id;
   520			return 0;
   521		}
   522	
   523		dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
   524			dev_name(&drvdata->csdev->dev), drvdata->cpu);
   525	
   526		return -EINVAL;
   527	}
   528	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
