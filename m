Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFBF5AC1DF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 02:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIDAf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 20:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDAfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 20:35:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFCE25E84;
        Sat,  3 Sep 2022 17:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662251721; x=1693787721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DR9Og7TufHVcJZwDjl7qukiXl119wqG8vdjGKb2Jlbs=;
  b=P8rF2aPzEc1aKM28MgM5uZ0yIuTntCOfOfUAlgAE2eQWUYbL7Opv2MOK
   xyBW3j0RobPs0cJrHOD+xFSIn3KrE+oJq+VbPs9ctmguhg5EzbGDTrnJs
   B4Jl4rNXlqfn0JeAqDuk63p7t4A88vAo2/NE3TYoLT/rAH9ds/p5FH88x
   Q18I56NVusfufRD9kVnO8ZMagUT5NMccp+Y2q3Jrl7N2DZT8LEs0IP89K
   EMiraM6k14TNwq60iCmXY55sm1TG7XGlKHQab1+PO4vRJFS393UovyESf
   ItepUTR3lu+KhioBelasvfP9ykYe0cRqDJt010BY1QZraFz5qs7bDqvmR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="296202531"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="296202531"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 17:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="564351821"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2022 17:35:18 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUdbZ-0002Mj-1I;
        Sun, 04 Sep 2022 00:35:17 +0000
Date:   Sun, 4 Sep 2022 08:34:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     kbuild-all@lists.01.org,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 19/23] ata: ahci: Add DWC AHCI SATA controller support
Message-ID: <202209040834.w5y0s1NR-lkp@intel.com>
References: <20220822183728.24434-20-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822183728.24434-20-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on axboe-block/for-next linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220823-024133
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220904/202209040834.w5y0s1NR-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e628913a210e29775bc995d1ed3ed58ab13416b8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220823-024133
        git checkout e628913a210e29775bc995d1ed3ed58ab13416b8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/clk.h:13,
                    from drivers/ata/ahci_dwc.c:11:
>> drivers/ata/ahci_dwc.c:372:50: error: 'ahci_dwc_suspend' undeclared here (not in a function); did you mean 'ahci_dwc_probe'?
     372 | static DEFINE_SIMPLE_DEV_PM_OPS(ahci_dwc_pm_ops, ahci_dwc_suspend,
         |                                                  ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:57:44: note: in definition of macro 'PTR_IF'
      57 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:313:20: note: in expansion of macro 'pm_sleep_ptr'
     313 |         .suspend = pm_sleep_ptr(suspend_fn), \
         |                    ^~~~~~~~~~~~
   include/linux/pm.h:373:9: note: in expansion of macro 'SYSTEM_SLEEP_PM_OPS'
     373 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:399:9: note: in expansion of macro '_DEFINE_DEV_PM_OPS'
     399 |         _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/ata/ahci_dwc.c:372:8: note: in expansion of macro 'DEFINE_SIMPLE_DEV_PM_OPS'
     372 | static DEFINE_SIMPLE_DEV_PM_OPS(ahci_dwc_pm_ops, ahci_dwc_suspend,
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ata/ahci_dwc.c:373:33: error: 'ahci_dwc_resume' undeclared here (not in a function); did you mean 'ahci_port_resume'?
     373 |                                 ahci_dwc_resume);
         |                                 ^~~~~~~~~~~~~~~
   include/linux/kernel.h:57:44: note: in definition of macro 'PTR_IF'
      57 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:314:19: note: in expansion of macro 'pm_sleep_ptr'
     314 |         .resume = pm_sleep_ptr(resume_fn), \
         |                   ^~~~~~~~~~~~
   include/linux/pm.h:373:9: note: in expansion of macro 'SYSTEM_SLEEP_PM_OPS'
     373 |         SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/pm.h:399:9: note: in expansion of macro '_DEFINE_DEV_PM_OPS'
     399 |         _DEFINE_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL)
         |         ^~~~~~~~~~~~~~~~~~
   drivers/ata/ahci_dwc.c:372:8: note: in expansion of macro 'DEFINE_SIMPLE_DEV_PM_OPS'
     372 | static DEFINE_SIMPLE_DEV_PM_OPS(ahci_dwc_pm_ops, ahci_dwc_suspend,
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/ahci_dwc.c:267:12: warning: 'ahci_dwc_reinit_host' defined but not used [-Wunused-function]
     267 | static int ahci_dwc_reinit_host(struct ahci_host_priv *hpriv)
         |            ^~~~~~~~~~~~~~~~~~~~


vim +372 drivers/ata/ahci_dwc.c

   371	
 > 372	static DEFINE_SIMPLE_DEV_PM_OPS(ahci_dwc_pm_ops, ahci_dwc_suspend,
 > 373					ahci_dwc_resume);
   374	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
