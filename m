Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36C656CC23
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 03:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGJBNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 21:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJBN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 21:13:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442310FF2;
        Sat,  9 Jul 2022 18:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657415607; x=1688951607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OhWo23JWwfXIx3sgChlYW09NF6N1Xz6MXcIILyS2Nto=;
  b=Opj0iOw6ckGTWHiK9WSFFv3zL91yaMdv+DoIEFdfmwXT5Agfeml2v4f8
   vm0ONvCjzRfMJQNPQf6QnGjEGJm86Vfqm+baXxJIfnsLz6zypZZhcBzVB
   WXQxVg65eaEMdmgeedgpO4k2tltg3nyV0gmKDGdUknRgc08xTqGoq8nvt
   QW9IBchWJdjbClA5M6Rc3YiieL8/QdI2NJ3gnEg9u4JEzPwB+6kh8jgZw
   SqrAcYgunX7Qt0vjHlMbP4yJS7EArpNnbAXZOof39oOcDeuDlcMMLTCBv
   YTe6sZpFgmXjIyAUZkc/mT+lS8IseSu1PBf4rvIBJIHdr5OoEqSv23CD6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="348455567"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="348455567"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 18:13:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="594494740"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2022 18:13:24 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oALVj-000PLG-Jk;
        Sun, 10 Jul 2022 01:13:23 +0000
Date:   Sun, 10 Jul 2022 09:12:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v4 12/12] thermal/of: Initialize trip points separately
Message-ID: <202207100924.K7DHJPX2-lkp@intel.com>
References: <20220709223229.1619339-13-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709223229.1619339-13-daniel.lezcano@linexp.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on tegra/for-next linus/master v5.19-rc5 next-20220708]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-OF-rework/20220710-063550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220710/202207100924.K7DHJPX2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 77a38f6839980bfac61babb40d83772c51427011)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ae09a5baa03d816f54f1e0654fd0ad08eab5d427
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Lezcano/thermal-OF-rework/20220710-063550
        git checkout ae09a5baa03d816f54f1e0654fd0ad08eab5d427
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/thermal/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/thermal/thermal_of.c:977:6: warning: variable 'gchild' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!tz->tbps) {
               ^~~~~~~~~
   drivers/thermal/thermal_of.c:1010:14: note: uninitialized use occurs here
           of_node_put(gchild);
                       ^~~~~~
   drivers/thermal/thermal_of.c:977:2: note: remove the 'if' if its condition is always false
           if (!tz->tbps) {
           ^~~~~~~~~~~~~~~~
   drivers/thermal/thermal_of.c:917:43: note: initialize the variable 'gchild' to silence this warning
           struct device_node *child = NULL, *gchild;
                                                    ^
                                                     = NULL
   1 warning generated.


vim +977 drivers/thermal/thermal_of.c

ae09a5baa03d81 drivers/thermal/thermal_of.c Daniel Lezcano     2022-07-10   899  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   900  /**
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   901   * thermal_of_build_thermal_zone - parse and fill one thermal zone data
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   902   * @np: DT node containing a thermal zone node
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   903   *
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   904   * This function parses a thermal zone type of node represented by
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   905   * @np parameter and fills the read data into a __thermal_zone data structure
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   906   * and return this pointer.
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   907   *
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   908   * TODO: Missing properties to parse: thermal-sensor-names
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   909   *
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   910   * Return: On success returns a valid struct __thermal_zone,
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   911   * otherwise, it returns a corresponding ERR_PTR(). Caller must
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   912   * check the return value with help of IS_ERR() helper.
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   913   */
c0ff8aaae36955 drivers/thermal/of-thermal.c Julia Lawall       2016-04-19   914  static struct __thermal_zone
c0ff8aaae36955 drivers/thermal/of-thermal.c Julia Lawall       2016-04-19   915  __init *thermal_of_build_thermal_zone(struct device_node *np)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   916  {
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   917  	struct device_node *child = NULL, *gchild;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   918  	struct __thermal_zone *tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   919  	int ret, i;
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   920  	u32 prop, coef[2];
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   921  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   922  	if (!np) {
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   923  		pr_err("no thermal zone np\n");
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   924  		return ERR_PTR(-EINVAL);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   925  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   926  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   927  	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   928  	if (!tz)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   929  		return ERR_PTR(-ENOMEM);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   930  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   931  	ret = of_property_read_u32(np, "polling-delay-passive", &prop);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   932  	if (ret < 0) {
3079f340caa72a drivers/thermal/of-thermal.c Amit Kucheria      2019-01-21   933  		pr_err("%pOFn: missing polling-delay-passive property\n", np);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   934  		goto free_tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   935  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   936  	tz->passive_delay = prop;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   937  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   938  	ret = of_property_read_u32(np, "polling-delay", &prop);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   939  	if (ret < 0) {
3079f340caa72a drivers/thermal/of-thermal.c Amit Kucheria      2019-01-21   940  		pr_err("%pOFn: missing polling-delay property\n", np);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   941  		goto free_tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   942  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   943  	tz->polling_delay = prop;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   944  
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   945  	/*
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   946  	 * REVIST: for now, the thermal framework supports only
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   947  	 * one sensor per thermal zone. Thus, we are considering
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   948  	 * only the first two values as slope and offset.
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   949  	 */
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   950  	ret = of_property_read_u32_array(np, "coefficients", coef, 2);
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   951  	if (ret == 0) {
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   952  		tz->slope = coef[0];
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   953  		tz->offset = coef[1];
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   954  	} else {
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   955  		tz->slope = 1;
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   956  		tz->offset = 0;
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   957  	}
a46dbae8abe5cd drivers/thermal/of-thermal.c Eduardo Valentin   2015-05-11   958  
ae09a5baa03d81 drivers/thermal/thermal_of.c Daniel Lezcano     2022-07-10   959  	tz->trips = thermal_of_trips_init(np, &tz->ntrips);
ae09a5baa03d81 drivers/thermal/thermal_of.c Daniel Lezcano     2022-07-10   960  	if (IS_ERR(tz->trips)) {
ae09a5baa03d81 drivers/thermal/thermal_of.c Daniel Lezcano     2022-07-10   961  		ret = PTR_ERR(tz->trips);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   962  		goto finish;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   963  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   964  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   965  	/* cooling-maps */
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   966  	child = of_get_child_by_name(np, "cooling-maps");
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   967  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   968  	/* cooling-maps not provided */
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   969  	if (!child)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   970  		goto finish;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   971  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   972  	tz->num_tbps = of_get_child_count(child);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   973  	if (tz->num_tbps == 0)
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   974  		goto finish;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   975  
6396bb221514d2 drivers/thermal/of-thermal.c Kees Cook          2018-06-12   976  	tz->tbps = kcalloc(tz->num_tbps, sizeof(*tz->tbps), GFP_KERNEL);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  @977  	if (!tz->tbps) {
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   978  		ret = -ENOMEM;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   979  		goto free_trips;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   980  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   981  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   982  	i = 0;
ca9521b770c988 drivers/thermal/of-thermal.c Stephen Boyd       2014-06-18   983  	for_each_child_of_node(child, gchild) {
ae09a5baa03d81 drivers/thermal/thermal_of.c Daniel Lezcano     2022-07-10   984  		ret = thermal_of_populate_bind_params(np, gchild, &tz->tbps[i++]);
ae09a5baa03d81 drivers/thermal/thermal_of.c Daniel Lezcano     2022-07-10   985  		if (ret) {
ae09a5baa03d81 drivers/thermal/thermal_of.c Daniel Lezcano     2022-07-10   986  			of_node_put(gchild);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   987  			goto free_tbps;
ca9521b770c988 drivers/thermal/of-thermal.c Stephen Boyd       2014-06-18   988  		}
ae09a5baa03d81 drivers/thermal/thermal_of.c Daniel Lezcano     2022-07-10   989  	}
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   990  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   991  finish:
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   992  	of_node_put(child);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   993  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   994  	return tz;
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   995  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03   996  free_tbps:
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   997  	for (i = i - 1; i >= 0; i--) {
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   998  		struct __thermal_bind_params *tbp = tz->tbps + i;
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08   999  		int j;
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08  1000  
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08  1001  		for (j = 0; j < tbp->count; j++)
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08  1002  			of_node_put(tbp->tcbp[j].cooling_device);
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08  1003  
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08  1004  		kfree(tbp->tcbp);
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08  1005  	}
a92bab8919e3fb drivers/thermal/of-thermal.c Viresh Kumar       2018-08-08  1006  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1007  	kfree(tz->tbps);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1008  free_trips:
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1009  	kfree(tz->trips);
c2aad93c7edd5e drivers/thermal/of-thermal.c Vladimir Zapolskiy 2014-09-29  1010  	of_node_put(gchild);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1011  free_tz:
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1012  	kfree(tz);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1013  	of_node_put(child);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1014  
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1015  	return ERR_PTR(ret);
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1016  }
4e5e4705bf69ea drivers/thermal/of-thermal.c Eduardo Valentin   2013-07-03  1017  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
