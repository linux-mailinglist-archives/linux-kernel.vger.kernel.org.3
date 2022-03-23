Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0051F4E5205
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiCWMTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiCWMTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:19:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC2376E2E;
        Wed, 23 Mar 2022 05:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648037852; x=1679573852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PSHcI897D2zwxp8xEylKJ3SYcDP8lVWYEjAmdTs22kM=;
  b=JvztOgiYfjHuuPoDvTvt1ftKhcgovQ3A40U1kdwutYHiritjVaRd1Pbi
   KWIpRtj4T1LTN1mkwv3f3QO/mgSEHnZoNpMMLidJ7FaDqcqqKD1MrrAiE
   18bd5wxwrb098Q92EZSXzosKGpZup91qc5obMHJE4M7sEbHDI1BnbAa/D
   OwRBTHCyT+97BzkmpKyjCqRB+19AkBdpYV4x06MrSVLCLiCOLInCQ7R7o
   SzvmDv1YBCilu8qU2midHQoZsW7SVENGwxctLzzUW7ZTmvj0eshodiO1d
   FAS0TNgA7KIsckM5dcIhuKzbCLwvZamMEa6fQtwrJFG4eH7OwibYBFwJo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="282942188"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="282942188"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 05:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="583669177"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2022 05:17:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWzvb-000K2T-L6; Wed, 23 Mar 2022 12:17:27 +0000
Date:   Wed, 23 Mar 2022 20:17:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: Re: [PATCH 2/2] drivers: usb: dwc3: Add AM62 USB wrapper driver
Message-ID: <202203232002.K45zQUfY-lkp@intel.com>
References: <20220323053524.7009-3-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323053524.7009-3-a-govindraju@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

I love your patch! Yet something to improve:

[auto build test ERROR on linux/master]
[also build test ERROR on usb/usb-testing linus/master v5.17 next-20220323]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Aswath-Govindraju/AM62-Add-support-for-AM62-USB-wrapper-driver/20220323-133708
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: hexagon-buildonly-randconfig-r002-20220323 (https://download.01.org/0day-ci/archive/20220323/202203232002.K45zQUfY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4ca423573f638454724a40416042d84552db81af
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Aswath-Govindraju/AM62-Add-support-for-AM62-USB-wrapper-driver/20220323-133708
        git checkout 4ca423573f638454724a40416042d84552db81af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/usb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/usb/dwc3/dwc3-am62.c:567:10: error: use of undeclared identifier 'dwc3_ti_pm_ops'; did you mean 'dwc3_ti_probe'?
                   .pm     = &dwc3_ti_pm_ops,
                              ^~~~~~~~~~~~~~
                              dwc3_ti_probe
   drivers/usb/dwc3/dwc3-am62.c:379:12: note: 'dwc3_ti_probe' declared here
   static int dwc3_ti_probe(struct platform_device *pdev)
              ^
>> drivers/usb/dwc3/dwc3-am62.c:567:9: error: incompatible pointer types initializing 'const struct dev_pm_ops *' with an expression of type 'int (*)(struct platform_device *)' [-Werror,-Wincompatible-pointer-types]
                   .pm     = &dwc3_ti_pm_ops,
                             ^~~~~~~~~~~~~~~
   2 errors generated.


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
