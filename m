Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ADC50E5F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243489AbiDYQiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbiDYQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:37:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1421DEB80
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650904464; x=1682440464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZYTVedgyRPyp5vY18ocyoCSbrb5gKagd4hpHITPwGkg=;
  b=HvZH0ROyuouXZZRPjAvPmHByzB1OJP+FaPQ9DNchKPSQWSMi1MAcj6wN
   86RB7BGNqNTh3PWqqnKvmVFa79ZnPRSMd22umEzguh7KocV37Scgi+83i
   Q5oViNXsKM8HgkW0QZxOIcCEUo1C0C68NGPer63xEiR75PC/Qbnit8F1d
   kdhmye1Vh3jz6aEwCwsJdzwOAOLhXG+JJvTp6tABQxnk/7o+IinXeBRse
   noH+EHvbD49xX2PGwEbR/l+BA9oIubJf+CdBzr+navWQh2SJ/45yrEqPO
   ByI2CgxkOPOFZLB/BxzCE+gccPnpjWp4U/C2aQWR7rZyd7Y8GE+2axXc+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247227720"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="247227720"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="537670469"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Apr 2022 09:34:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj1fJ-0002hC-8X;
        Mon, 25 Apr 2022 16:34:21 +0000
Date:   Tue, 26 Apr 2022 00:33:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, dan.j.williams@intel.com
Cc:     kbuild-all@lists.01.org, vishal.l.verma@intel.com,
        dave.jiang@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] device-dax: use kobj_to_dev()
Message-ID: <202204260044.wlRoUZiW-lkp@intel.com>
References: <20220425105307.3515215-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425105307.3515215-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18-rc4 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/device-dax-use-kobj_to_dev/20220425-185400
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git af2d861d4cd2a4da5137f795ee3509e6f944a25b
config: i386-randconfig-r016-20220425 (https://download.01.org/0day-ci/archive/20220426/202204260044.wlRoUZiW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/83eff180ded41da8e042373de81fa823835a1be0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/device-dax-use-kobj_to_dev/20220425-185400
        git checkout 83eff180ded41da8e042373de81fa823835a1be0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/dax/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/dax/bus.c: In function 'dax_region_visible':
>> drivers/dax/bus.c:516:9: error: expected ',' or ';' before 'struct'
     516 |         struct dax_region *dax_region = dev_get_drvdata(dev);
         |         ^~~~~~
>> drivers/dax/bus.c:518:23: error: 'dax_region' undeclared (first use in this function)
     518 |         if (is_static(dax_region))
         |                       ^~~~~~~~~~
   drivers/dax/bus.c:518:23: note: each undeclared identifier is reported only once for each function it appears in
   drivers/dax/bus.c:515:24: warning: unused variable 'dev' [-Wunused-variable]
     515 |         struct device *dev = kobj_to_dev(kobj)
         |                        ^~~


vim +516 drivers/dax/bus.c

0f3da14a4f0503 Dan Williams 2020-10-13  511  
c2f3011ee697f8 Dan Williams 2020-10-13  512  static umode_t dax_region_visible(struct kobject *kobj, struct attribute *a,
c2f3011ee697f8 Dan Williams 2020-10-13  513  		int n)
c2f3011ee697f8 Dan Williams 2020-10-13  514  {
83eff180ded41d Minghao Chi  2022-04-25  515  	struct device *dev = kobj_to_dev(kobj)
c2f3011ee697f8 Dan Williams 2020-10-13 @516  	struct dax_region *dax_region = dev_get_drvdata(dev);
c2f3011ee697f8 Dan Williams 2020-10-13  517  
0f3da14a4f0503 Dan Williams 2020-10-13 @518  	if (is_static(dax_region))
0f3da14a4f0503 Dan Williams 2020-10-13  519  		if (a == &dev_attr_available_size.attr
0f3da14a4f0503 Dan Williams 2020-10-13  520  				|| a == &dev_attr_create.attr
0f3da14a4f0503 Dan Williams 2020-10-13  521  				|| a == &dev_attr_seed.attr
0f3da14a4f0503 Dan Williams 2020-10-13  522  				|| a == &dev_attr_delete.attr)
c2f3011ee697f8 Dan Williams 2020-10-13  523  			return 0;
c2f3011ee697f8 Dan Williams 2020-10-13  524  	return a->mode;
c2f3011ee697f8 Dan Williams 2020-10-13  525  }
c2f3011ee697f8 Dan Williams 2020-10-13  526  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
