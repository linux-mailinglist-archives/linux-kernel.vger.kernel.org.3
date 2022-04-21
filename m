Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A67B50A948
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355133AbiDUThq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377598AbiDUThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:37:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B63F4D9D5;
        Thu, 21 Apr 2022 12:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650569679; x=1682105679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V2XhEu/xK4MjbS65hi/Q6lIMusoHCPvjG1fI1HXbNTE=;
  b=nJ7Rb/eWohIPpKgDA/zWA4EuU2Zo9AqJsDK6orWfoYbd6EANon8hL88I
   q48VEJ1SJhFsdzU3pImmQfqDOV6GNn5xukGk5QJ5m52mKtJjDVmTMlv4P
   4DNHcT0LP4r1mjok/hpVB8fxTEXObfuP/8WSfBAXj/0fROwWCfRwOm+Ml
   XK/J4DkNc4k1vsVmZlvNFbaFJvbDIzDh3SsGFHCs27V4lAhiFqhnivkC7
   ND3y7im4sWd/osBEq/17XYwZLIQlH5SIRDkQdbGqzsDfC/NmJP20gIzA0
   dcvYWcwDNx/lNxlESw0ZQv85UQwT4b9E1rlVR8lPk6Ucti4B4HqAuAyZA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263928170"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="263928170"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 12:34:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="866667170"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Apr 2022 12:34:36 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhcZX-0008if-Fv;
        Thu, 21 Apr 2022 19:34:35 +0000
Date:   Fri, 22 Apr 2022 03:34:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, kael_w@yeah.net,
        Wan Jiabing <wanjiabing@vivo.com>
Subject: Re: [PATCH] of: Add missing of_node_put() before return
Message-ID: <202204220349.GgbfoMrp-lkp@intel.com>
References: <20220421122303.111766-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421122303.111766-1-wanjiabing@vivo.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220421]
[cannot apply to robh/for-next v5.18-rc3 v5.18-rc2 v5.18-rc1 v5.18-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Wan-Jiabing/of-Add-missing-of_node_put-before-return/20220421-202418
base:    65eb92e4c9f0a962656f131521f4fbc0d24c9d4c
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220422/202204220349.GgbfoMrp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e54621b530fe295566dfa8bc3d3481e624c3ee01
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wan-Jiabing/of-Add-missing-of_node_put-before-return/20220421-202418
        git checkout e54621b530fe295566dfa8bc3d3481e624c3ee01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/of/platform.c: In function 'of_platform_default_populate_init':
>> drivers/of/platform.c:560:50: error: expected ';' before 'return'
     560 |                                 of_node_put(node)
         |                                                  ^
         |                                                  ;
     561 |                                 return -ENOMEM;
         |                                 ~~~~~~            


vim +560 drivers/of/platform.c

   515	
   516	static int __init of_platform_default_populate_init(void)
   517	{
   518		struct device_node *node;
   519	
   520		device_links_supplier_sync_state_pause();
   521	
   522		if (!of_have_populated_dt())
   523			return -ENODEV;
   524	
   525		if (IS_ENABLED(CONFIG_PPC)) {
   526			struct device_node *boot_display = NULL;
   527			struct platform_device *dev;
   528			int ret;
   529	
   530			/* Check if we have a MacOS display without a node spec */
   531			if (of_get_property(of_chosen, "linux,bootx-noscreen", NULL)) {
   532				/*
   533				 * The old code tried to work out which node was the MacOS
   534				 * display based on the address. I'm dropping that since the
   535				 * lack of a node spec only happens with old BootX versions
   536				 * (users can update) and with this code, they'll still get
   537				 * a display (just not the palette hacks).
   538				 */
   539				dev = platform_device_alloc("bootx-noscreen", 0);
   540				if (WARN_ON(!dev))
   541					return -ENOMEM;
   542				ret = platform_device_add(dev);
   543				if (WARN_ON(ret)) {
   544					platform_device_put(dev);
   545					return ret;
   546				}
   547			}
   548	
   549			/*
   550			 * For OF framebuffers, first create the device for the boot display,
   551			 * then for the other framebuffers. Only fail for the boot display;
   552			 * ignore errors for the rest.
   553			 */
   554			for_each_node_by_type(node, "display") {
   555				if (!of_get_property(node, "linux,opened", NULL) ||
   556				    !of_get_property(node, "linux,boot-display", NULL))
   557					continue;
   558				dev = of_platform_device_create(node, "of-display", NULL);
   559				if (WARN_ON(!dev)) {
 > 560					of_node_put(node)
   561					return -ENOMEM;
   562				}
   563				boot_display = node;
   564				break;
   565			}
   566			for_each_node_by_type(node, "display") {
   567				if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
   568					continue;
   569				of_platform_device_create(node, "of-display", NULL);
   570			}
   571	
   572		} else {
   573			/*
   574			 * Handle certain compatibles explicitly, since we don't want to create
   575			 * platform_devices for every node in /reserved-memory with a
   576			 * "compatible",
   577			 */
   578			for_each_matching_node(node, reserved_mem_matches)
   579				of_platform_device_create(node, NULL, NULL);
   580	
   581			node = of_find_node_by_path("/firmware");
   582			if (node) {
   583				of_platform_populate(node, NULL, NULL, NULL);
   584				of_node_put(node);
   585			}
   586	
   587			node = of_get_compatible_child(of_chosen, "simple-framebuffer");
   588			of_platform_device_create(node, NULL, NULL);
   589			of_node_put(node);
   590	
   591			/* Populate everything else. */
   592			of_platform_default_populate(NULL, NULL, NULL);
   593		}
   594	
   595		return 0;
   596	}
   597	arch_initcall_sync(of_platform_default_populate_init);
   598	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
