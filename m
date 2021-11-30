Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624374629AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 02:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhK3Bcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 20:32:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:53470 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhK3Bcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 20:32:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="260053833"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="260053833"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 17:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458646078"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2021 17:29:25 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrrxV-000CZp-4R; Tue, 30 Nov 2021 01:29:25 +0000
Date:   Tue, 30 Nov 2021 09:28:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 2147/2411]
 drivers/bus/ti-sysc.c:2446:13: warning: variable 'error' set but not used
Message-ID: <202111300927.gR4hZApS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   cd4fd0597d3787df6c6771a7b41379d35a8f31b0
commit: 5eca1c8412f40dd798c28549cd4c032217ad2faf [2147/2411] bus: ti-sysc: Add quirk handling for reinit on context lost
config: arm-defconfig (https://download.01.org/0day-ci/archive/20211130/202111300927.gR4hZApS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=5eca1c8412f40dd798c28549cd4c032217ad2faf
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 5eca1c8412f40dd798c28549cd4c032217ad2faf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/bus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/bus/ti-sysc.c: In function 'sysc_reinit_modules':
>> drivers/bus/ti-sysc.c:2446:13: warning: variable 'error' set but not used [-Wunused-but-set-variable]
    2446 |         int error = 0;
         |             ^~~~~


vim +/error +2446 drivers/bus/ti-sysc.c

  2439	
  2440	/* Caller needs to take list_lock if ever used outside of cpu_pm */
  2441	static void sysc_reinit_modules(struct sysc_soc_info *soc)
  2442	{
  2443		struct sysc_module *module;
  2444		struct list_head *pos;
  2445		struct sysc *ddata;
> 2446		int error = 0;
  2447	
  2448		list_for_each(pos, &sysc_soc->restored_modules) {
  2449			module = list_entry(pos, struct sysc_module, node);
  2450			ddata = module->ddata;
  2451			error = sysc_reinit_module(ddata, ddata->enabled);
  2452		}
  2453	}
  2454	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
