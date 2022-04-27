Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA67B511402
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiD0JGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiD0JGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:06:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A5311C98C;
        Wed, 27 Apr 2022 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651050165; x=1682586165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3/wGqdZEGCmi4VUJP2w+KBYIsRrkHRBi4b2f3O4JXoA=;
  b=Lw/798PqrUf12Bos4+escT7qy0xkn00j1qhoaVoaWp6baIkCldJJxaOq
   mzD5sfKLzb6NZ6f7gpOdRZ5Z60z+viNiIvXLacGIf5hKZ11L8NpRD91WF
   uv+kegx8BSQoY34hxQ6BYp/Am8m/vqN+OYplJjeu+mNY8/tHzAN1Sgz7d
   66vfxUFREz0ZPOzuHkgCP/yYWuFVfjGa05gXDNNFdBLbKLRFkjsKg7zc6
   129RTNoimPeIHFb868JSny+P0Px2OHmNCBGbrAULX0R3kC0AG73ms166v
   gLw57efRbV95uoXevHC823GZmW3LLYwV4sOTPfxE5sNhhQz0PNG1JYN9P
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="291017843"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="291017843"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 02:02:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="807942526"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2022 02:02:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njdZB-0004X7-Vk;
        Wed, 27 Apr 2022 09:02:33 +0000
Date:   Wed, 27 Apr 2022 17:01:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] thermal/of: Initialize trip points separately
Message-ID: <202204271620.h0RD5aZy-lkp@intel.com>
References: <20220426221523.3056696-16-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426221523.3056696-16-daniel.lezcano@linexp.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tegra/for-next]
[also build test WARNING on sre-power-supply/for-next linus/master v5.18-rc4]
[cannot apply to rafael-pm/thermal next-20220427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-OF-rework/20220427-061937
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: i386-randconfig-a004-20220425 (https://download.01.org/0day-ci/archive/20220427/202204271620.h0RD5aZy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b446fa392d1d9fa791ca672608b0860fe37e040f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-OF-rework/20220427-061937
        git checkout b446fa392d1d9fa791ca672608b0860fe37e040f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_of.c:965:2: warning: variable 'gchild' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!tz->tbps) {
           ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:30: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/thermal/thermal_of.c:996:14: note: uninitialized use occurs here
           of_node_put(gchild);
                       ^~~~~~
   drivers/thermal/thermal_of.c:965:2: note: remove the 'if' if its condition is always false
           if (!tz->tbps) {
           ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   drivers/thermal/thermal_of.c:905:43: note: initialize the variable 'gchild' to silence this warning
           struct device_node *child = NULL, *gchild;
                                                    ^
                                                     = NULL
   1 warning generated.


vim +965 drivers/thermal/thermal_of.c

b446fa392d1d9f drivers/thermal/thermal_of.c Daniel Lezcano     2022-04-27   887  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   888  /**
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   889   * thermal_of_build_thermal_zone - parse and fill one thermal zone data
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   890   * @np: DT node containing a thermal zone node
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   891   *
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   892   * This function parses a thermal zone type of node represented by
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   893   * @np parameter and fills the read data into a __thermal_zone data structure
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   894   * and return this pointer.
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   895   *
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   896   * TODO: Missing properties to parse: thermal-sensor-names
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   897   *
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   898   * Return: On success returns a valid struct __thermal_zone,
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   899   * otherwise, it returns a corresponding ERR_PTR(). Caller must
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   900   * check the return value with help of IS_ERR() helper.
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   901   */
c0ff8aaae36955 drivers/thermal/of-thermal.c Julia Lawall       2016-04-19   902  static struct __thermal_zone
c0ff8aaae36955 drivers/thermal/of-thermal.c Julia Lawall       2016-04-19   903  __init *thermal_of_build_thermal_zone(struct device_node *np)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   904  {
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   905  	struct device_node *child = NULL, *gchild;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   906  	struct __thermal_zone *tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   907  	int ret, i;
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   908  	u32 prop, coef[2];
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   909  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   910  	if (!np) {
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   911  		pr_err("no thermal zone np\n");
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   912  		return ERR_PTR(-EINVAL);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   913  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   914  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   915  	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   916  	if (!tz)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   917  		return ERR_PTR(-ENOMEM);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   918  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   919  	ret = of_property_read_u32(np, "polling-delay-passive", &prop);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   920  	if (ret < 0) {
3079f340caa72a drivers/thermal/of-thermal.c Amit Kucheria      2019-01-21   921  		pr_err("%pOFn: missing polling-delay-passive property\n", np);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   922  		goto free_tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   923  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   924  	tz->passive_delay = prop;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   925  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   926  	ret = of_property_read_u32(np, "polling-delay", &prop);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   927  	if (ret < 0) {
3079f340caa72a drivers/thermal/of-thermal.c Amit Kucheria      2019-01-21   928  		pr_err("%pOFn: missing polling-delay property\n", np);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   929  		goto free_tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   930  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   931  	tz->polling_delay = prop;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   932  
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   933  	/*
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   934  	 * REVIST: for now, the thermal framework supports only
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   935  	 * one sensor per thermal zone. Thus, we are considering
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   936  	 * only the first two values as slope and offset.
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   937  	 */
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   938  	ret = of_property_read_u32_array(np, "coefficients", coef, 2);
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   939  	if (ret == 0) {
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   940  		tz->slope = coef[0];
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   941  		tz->offset = coef[1];
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   942  	} else {
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   943  		tz->slope = 1;
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   944  		tz->offset = 0;
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   945  	}
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   946  
b446fa392d1d9f drivers/thermal/thermal_of.c Daniel Lezcano     2022-04-27   947  	tz->trips = thermal_of_trips_init(np, &tz->ntrips);
b446fa392d1d9f drivers/thermal/thermal_of.c Daniel Lezcano     2022-04-27   948  	if (IS_ERR(tz->trips)) {
b446fa392d1d9f drivers/thermal/thermal_of.c Daniel Lezcano     2022-04-27   949  		ret = PTR_ERR(tz->trips);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   950  		goto finish;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   951  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   952  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   953  	/* cooling-maps */
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   954  	child = of_get_child_by_name(np, "cooling-maps");
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   955  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   956  	/* cooling-maps not provided */
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   957  	if (!child)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   958  		goto finish;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   959  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   960  	tz->num_tbps = of_get_child_count(child);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   961  	if (tz->num_tbps == 0)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   962  		goto finish;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   963  
6396bb221514d2 drivers/thermal/of-thermal.c Kees Cook          2018-06-12   964  	tz->tbps = kcalloc(tz->num_tbps, sizeof(*tz->tbps), GFP_KERNEL);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  @965  	if (!tz->tbps) {
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   966  		ret = -ENOMEM;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   967  		goto free_trips;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   968  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   969  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   970  	i = 0;
ca9521b770c988 drivers/thermal/of-thermal.c Stephen Boyd       2014-06-18   971  	for_each_child_of_node(child, gchild) {
b446fa392d1d9f drivers/thermal/thermal_of.c Daniel Lezcano     2022-04-27   972  		ret = thermal_of_populate_bind_params(np, gchild, &tz->tbps[i++]);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   973  		if (ret)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   974  			goto free_tbps;
ca9521b770c988 drivers/thermal/of-thermal.c Stephen Boyd       2014-06-18   975  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   976  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   977  finish:
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   978  	of_node_put(child);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   979  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   980  	return tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   981  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   982  free_tbps:
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   983  	for (i = i - 1; i >= 0; i--) {
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   984  		struct __thermal_bind_params *tbp = tz->tbps + i;
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   985  		int j;
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   986  
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   987  		for (j = 0; j < tbp->count; j++)
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   988  			of_node_put(tbp->tcbp[j].cooling_device);
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   989  
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   990  		kfree(tbp->tcbp);
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   991  	}
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   992  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   993  	kfree(tz->tbps);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   994  free_trips:
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   995  	kfree(tz->trips);
c2aad93c7edd5e drivers/thermal/of-thermal.c Vladimir Zapolskiy 2014-09-29   996  	of_node_put(gchild);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   997  free_tz:
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   998  	kfree(tz);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   999  	of_node_put(child);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1000  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1001  	return ERR_PTR(ret);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1002  }
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1003  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
