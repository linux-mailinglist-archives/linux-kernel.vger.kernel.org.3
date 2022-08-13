Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B994591AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbiHMNt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbiHMNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:49:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9BE00C;
        Sat, 13 Aug 2022 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660398563; x=1691934563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JaEvKL+AdxwiSWRlV+uCBYdtPcSSE/UBNzAyRFE7VoI=;
  b=apWI1AljpOI1clF/g8FNMI5VWYENGqhLWYzX2wIMZR2x/hXA3n34w6m/
   b/4p/EKmvWV+2+59PMofQMoWkFO4Yqtr4N4r2JzCTcrIF40LWDmCPHzGP
   m3BQFUX2FgutKk91N3/EmJPMmet3bmyZCeyU8YnX8167lD4u8mr+QimQt
   bUzqzvFcKCpBObYqHzTnsD7NFqPBgBEQdrM/0WzYYAyS/BUzPJ7F/ywaF
   s40ZQgq7cwoRkKmTDCK1rP7SXoR6TbHY/bjjwa0oHFIgOr6GxqbBjvbrC
   kcIJS7EK18K5SSPZRpHFeW+nvDiAn6CWLG2V46ux5dvTEL1h5Fuv1AL2s
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353496792"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="353496792"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 06:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="695536376"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2022 06:49:19 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMrVv-0001jI-0L;
        Sat, 13 Aug 2022 13:49:19 +0000
Date:   Sat, 13 Aug 2022 21:48:19 +0800
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
Message-ID: <202208132126.X6alpomk-lkp@intel.com>
References: <20220809223401.24599-6-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809223401.24599-6-mike.leach@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

I love your patch! Yet something to improve:

[auto build test ERROR on acme/perf/core]
[also build test ERROR on tip/perf/core atorgue-stm32/stm32-next linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Leach/coresight-Add-new-API-to-allocate-trace-source-ID-values/20220810-063940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220813/202208132126.X6alpomk-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/hwtracing/coresight/coresight-etm3x-core.c:509:44: warning: 'struct etmv4_drvdata' declared inside parameter list will not be visible outside of this definition or declaration
     509 | static int etm_set_current_trace_id(struct etmv4_drvdata *drvdata)
         |                                            ^~~~~~~~~~~~~
   drivers/hwtracing/coresight/coresight-etm3x-core.c: In function 'etm_set_current_trace_id':
>> drivers/hwtracing/coresight/coresight-etm3x-core.c:517:58: error: invalid use of undefined type 'struct etmv4_drvdata'
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
>> drivers/hwtracing/coresight/coresight-etm3x-core.c:547:40: error: passing argument 1 of 'etm_set_current_trace_id' from incompatible pointer type [-Werror=incompatible-pointer-types]
     547 |         ret = etm_set_current_trace_id(drvdata);
         |                                        ^~~~~~~
         |                                        |
         |                                        struct etm_drvdata *
   drivers/hwtracing/coresight/coresight-etm3x-core.c:509:59: note: expected 'struct etmv4_drvdata *' but argument is of type 'struct etm_drvdata *'
     509 | static int etm_set_current_trace_id(struct etmv4_drvdata *drvdata)
         |                                     ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   cc1: some warnings being treated as errors


vim +517 drivers/hwtracing/coresight/coresight-etm3x-core.c

   508	
   509	static int etm_set_current_trace_id(struct etmv4_drvdata *drvdata)
   510	{
   511		int trace_id;
   512	
   513		/*
   514		 * Set the currently allocated trace ID - perf allocates IDs
   515		 * as part of setup_aux for all CPUs it may use.
   516		 */
 > 517		trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
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
   529	void etm_release_trace_id(struct etm_drvdata *drvdata)
   530	{
   531		coresight_trace_id_put_cpu_id(drvdata->cpu);
   532	}
   533	
   534	static int etm_enable_perf(struct coresight_device *csdev,
   535				   struct perf_event *event)
   536	{
   537		struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
   538		int ret;
   539	
   540		if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
   541			return -EINVAL;
   542	
   543		/* Configure the tracer based on the session's specifics */
   544		etm_parse_event_config(drvdata, event);
   545	
   546		/* perf allocates cpu IDs in setup aux - set the current on device */
 > 547		ret = etm_set_current_trace_id(drvdata);
   548		if (ret < 0)
   549			return ret;
   550	
   551		/* And enable it */
   552		ret = etm_enable_hw(drvdata);
   553	
   554		return ret;
   555	}
   556	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
