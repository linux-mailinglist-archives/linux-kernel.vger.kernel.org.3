Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A25D545631
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345341AbiFIVI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343754AbiFIVIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:08:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA1726E3AE;
        Thu,  9 Jun 2022 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654808932; x=1686344932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FbGkoYDcKil9L4cjrpUTys3dGh2NgTLalBdxCIb5Goo=;
  b=ANhNfraEO4HJWKIZ/dPMfBw036TPdqCbaoiKS81vQVzVlZF+KoaLCSJI
   vdlph4+xB668bbu4QXHBaF13ReJ4oMZh8bU6HP1KyssNsfBucGJAHkJSO
   tuJjkkPeAj+HmaSAL+29NAqYvrZ8ZQcmLyJVVQxG+nOZMWFU49yRBkQ89
   SES9UHHn+v9ak6OwK7ir5L2ESsW/cJNLJjQ1FKKlBWNYdCWwWdnbvFxv9
   t+iKnI+uCxRUuUyhktukeHqVObvKAQSBvjPbhaDUMHcM8Goa7wKRz+94D
   JZzz5rtFGjcJwvREQn+u5rpS7e9eB7/SUXW/PZA8RXsIJw+AlX8qlaHx5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276191120"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="276191120"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 14:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="710610570"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Jun 2022 14:08:49 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzPOa-000GOM-V9;
        Thu, 09 Jun 2022 21:08:48 +0000
Date:   Fri, 10 Jun 2022 05:08:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saud Farooqui <farooqui_saud@hotmail.com>,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Saud Farooqui <farooqui_saud@hotmail.com>
Subject: Re: [PATCH] rpmsg: strcpy is not safe, use strncpy
Message-ID: <202206100428.A3CCM24E-lkp@intel.com>
References: <PA4P189MB1421005C22E46EBD708EBA798BA49@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4P189MB1421005C22E46EBD708EBA798BA49@PA4P189MB1421.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saud,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.19-rc1]
[also build test WARNING on next-20220609]
[cannot apply to remoteproc/rpmsg-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Saud-Farooqui/rpmsg-strcpy-is-not-safe-use-strncpy/20220609-024555
base:    f2906aa863381afb0015a9eb7fefad885d4e5a56
config: sparc64-randconfig-r026-20220609 (https://download.01.org/0day-ci/archive/20220610/202206100428.A3CCM24E-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b6e6a64ab89042911604aa4741584a422cdfe8a5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Saud-Farooqui/rpmsg-strcpy-is-not-safe-use-strncpy/20220609-024555
        git checkout b6e6a64ab89042911604aa4741584a422cdfe8a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/rpmsg/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/rpmsg/rpmsg_core.c: In function 'rpmsg_register_device_override':
>> drivers/rpmsg/rpmsg_core.c:607:17: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
     607 |                 strncpy(rpdev->id.name, driver_override, sizeof(rpdev->id.name));
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +607 drivers/rpmsg/rpmsg_core.c

   595	
   596	/*
   597	 * A helper for registering rpmsg device with driver override and name.
   598	 * Drivers should not be using it, but instead rpmsg_register_device().
   599	 */
   600	int rpmsg_register_device_override(struct rpmsg_device *rpdev,
   601					   const char *driver_override)
   602	{
   603		struct device *dev = &rpdev->dev;
   604		int ret;
   605	
   606		if (driver_override)
 > 607			strncpy(rpdev->id.name, driver_override, sizeof(rpdev->id.name));
   608	
   609		dev_set_name(dev, "%s.%s.%d.%d", dev_name(dev->parent),
   610			     rpdev->id.name, rpdev->src, rpdev->dst);
   611	
   612		dev->bus = &rpmsg_bus;
   613	
   614		device_initialize(dev);
   615		if (driver_override) {
   616			ret = driver_set_override(dev, &rpdev->driver_override,
   617						  driver_override,
   618						  strlen(driver_override));
   619			if (ret) {
   620				dev_err(dev, "device_set_override failed: %d\n", ret);
   621				return ret;
   622			}
   623		}
   624	
   625		ret = device_add(dev);
   626		if (ret) {
   627			dev_err(dev, "device_add failed: %d\n", ret);
   628			kfree(rpdev->driver_override);
   629			rpdev->driver_override = NULL;
   630			put_device(dev);
   631		}
   632	
   633		return ret;
   634	}
   635	EXPORT_SYMBOL(rpmsg_register_device_override);
   636	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
