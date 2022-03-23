Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365804E4F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbiCWJgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiCWJf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:35:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C034974DF3;
        Wed, 23 Mar 2022 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648028068; x=1679564068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJv5+3wfNL9GVTmJdE4b7/NUS6LcmBN/AhqlopqLrj0=;
  b=bUKZBqULVfQGScPE4eQ/cP1ht8txV9iE5GKoR9ONaUfOKahaLTDqGISk
   AEbYC/y3CHdlbX8RYi8hmiDgMaGecGgRQKjBEAX7Jl4uxMsKjvLXSKNGI
   fvZ8IG0Gjpgu0zX7DxR6OkHT8VtkU9K4cJvwV4q4WiDLmTbVLStk+oR3m
   4QL154Z36+k7O3ULq6VrLsu7j1V0gVmV5moWVxi7istxrHSoLs51cp3Ez
   sbyQK1qaE7iPCmA8rWE1z1gpfpQVaaLKBDRVpU4mhjqd+KttqX7pnDC7A
   XdnSH44F7bUU9zPjav0Dm5UCvpv8LW9EiotNSrzDx6qY0aogQWM8raHaT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="238671276"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="238671276"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 02:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="519290674"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2022 02:34:25 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWxNo-000Ju3-6K; Wed, 23 Mar 2022 09:34:24 +0000
Date:   Wed, 23 Mar 2022 17:33:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: Re: [PATCH 2/2] drivers: usb: dwc3: Add AM62 USB wrapper driver
Message-ID: <202203231743.8JXV829j-lkp@intel.com>
References: <20220323053524.7009-3-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323053524.7009-3-a-govindraju@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

I love your patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on usb/usb-testing linus/master v5.17 next-20220322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Aswath-Govindraju/AM62-Add-support-for-AM62-USB-wrapper-driver/20220323-133708
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: mips-randconfig-c004-20220323 (https://download.01.org/0day-ci/archive/20220323/202203231743.8JXV829j-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4ca423573f638454724a40416042d84552db81af
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Aswath-Govindraju/AM62-Add-support-for-AM62-USB-wrapper-driver/20220323-133708
        git checkout 4ca423573f638454724a40416042d84552db81af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/usb/dwc3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/usb/dwc3/dwc3-am62.c:567:28: error: 'dwc3_ti_pm_ops' undeclared here (not in a function); did you mean 'dwc3_ti_probe'?
     567 |                 .pm     = &dwc3_ti_pm_ops,
         |                            ^~~~~~~~~~~~~~
         |                            dwc3_ti_probe


vim +567 drivers/usb/dwc3/dwc3-am62.c

   561	
   562	static struct platform_driver dwc3_ti_driver = {
   563		.probe		= dwc3_ti_probe,
   564		.remove		= dwc3_ti_remove,
   565		.driver		= {
   566			.name	= "dwc3-am62",
 > 567			.pm	= &dwc3_ti_pm_ops,
   568			.of_match_table = dwc3_ti_of_match,
   569		},
   570	};
   571	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
