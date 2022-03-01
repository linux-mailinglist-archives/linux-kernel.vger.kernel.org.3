Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836484C910A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbiCARBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiCARBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:01:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43349C77;
        Tue,  1 Mar 2022 09:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646154037; x=1677690037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cCIRMrHF0mCOd6L49Nd5tPcRzNX080z43VWjDYEi728=;
  b=YRgck4uv7jdj5Kme3AK/ovd6Shigo7KPwcjoetafWcp4AyObnkYhnhXI
   KLT7TBflhptPzDKVGnNYBPGzZqMA8K2CrZWv5awyzBpaLetd+sQjRbrV2
   kX7Epng0yW0EGaWBuQxJY9L42w+v6D1D+o29ESPdr1r4bGcI4qMarhvq7
   0qOEeZwUhwQY6fP/UPs9sYDsLqVnc95mBwf9jLsJTF3fws8maSsz/YxcF
   l406nMPLhyv/T+kl/otS0U3GTya1F1hiohxav/mihAZylpjDUQpZ7RFHw
   cZQLnqfU6tkbeuN0bRKpe7N9ruMORLhMl7YrKgf3PVwrZ/Ik8QMOXl69t
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252011958"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252011958"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 08:58:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="805364065"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2022 08:58:45 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nP5pk-0000m1-Qv; Tue, 01 Mar 2022 16:58:44 +0000
Date:   Wed, 2 Mar 2022 00:58:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] OPP: Add support of "opp-microwatt" for advanced
 EM registration
Message-ID: <202203020012.g7rYUP7M-lkp@intel.com>
References: <20220301093524.8870-4-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301093524.8870-4-lukasz.luba@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linux/master rafael-pm/linux-next linus/master v5.17-rc6 next-20220301]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Lukasz-Luba/Introduce-opp-microwatt-and-Energy-Model-from-DT/20220301-173700
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arc-randconfig-r014-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020012.g7rYUP7M-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e1e83de9bf2f261cb3e5eb9f53bde3c83c6e0647
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Lukasz-Luba/Introduce-opp-microwatt-and-Energy-Model-from-DT/20220301-173700
        git checkout e1e83de9bf2f261cb3e5eb9f53bde3c83c6e0647
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/opp/of.c: In function 'dev_pm_opp_of_register_em':
>> drivers/opp/of.c:1572:22: error: 'struct em_data_callback' has no member named 'active_power'
    1572 |                 em_cb.active_power = _get_dt_power;
         |                      ^


vim +1572 drivers/opp/of.c

  1540	
  1541	/**
  1542	 * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
  1543	 * @dev		: Device for which an Energy Model has to be registered
  1544	 * @cpus	: CPUs for which an Energy Model has to be registered. For
  1545	 *		other type of devices it should be set to NULL.
  1546	 *
  1547	 * This checks whether the "dynamic-power-coefficient" devicetree property has
  1548	 * been specified, and tries to register an Energy Model with it if it has.
  1549	 * Having this property means the voltages are known for OPPs and the EM
  1550	 * might be calculated.
  1551	 */
  1552	int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
  1553	{
  1554		struct em_data_callback em_cb = EM_DATA_CB(_get_power);
  1555		struct device_node *np;
  1556		int ret, nr_opp;
  1557		u32 cap;
  1558	
  1559		if (IS_ERR_OR_NULL(dev)) {
  1560			ret = -EINVAL;
  1561			goto failed;
  1562		}
  1563	
  1564		nr_opp = dev_pm_opp_get_opp_count(dev);
  1565		if (nr_opp <= 0) {
  1566			ret = -EINVAL;
  1567			goto failed;
  1568		}
  1569	
  1570		/* First, try to find more precised Energy Model in DT */
  1571		if (_of_has_opp_microwatt_property(dev)) {
> 1572			em_cb.active_power = _get_dt_power;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
