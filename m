Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7FD4D21AA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350048AbiCHTgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350026AbiCHTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:36:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69C546B2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646768139; x=1678304139;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GM1RmpbIfZkiuL7FpoG0nJJMuCXjKQf+orHk/Bunz5w=;
  b=NXPLjImoJETVwoFfOA5DqeDvvz3CYbVAOSjz78eegnD0kTwGzT2NxBrc
   NxF85fvj7jqqmdTxjW6GETnlNZhRPZriXaIOWL52679zz05wN16ZeuK+F
   8gqtTB1FDa4ar7dB2uQcCTNaCc91dXMSVUhOGHvUxiRDutp5O0TuIZj6B
   HfcINo/2mgtuRPhRKztxLl80tvrAh1T/FvJ1L+Vsrj+r+9YEWldLtwHwF
   H/il3GSTWb31LZx6Oc6kx3oLivfz6wWkEW/A20bE5G5EW5vDInup/Yc1l
   eLaJ2KuMxawsfDa1eMdDARdWxt9wCefenuOI7+bdMZmgBTdmDY7zS79A2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253623658"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="253623658"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 11:35:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="495576840"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 11:35:36 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRfcN-0001sB-VI; Tue, 08 Mar 2022 19:35:35 +0000
Date:   Wed, 9 Mar 2022 03:34:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 55/60]
 drivers/platform/x86/thinkpad_acpi.c:10363:13: warning: variable 'err' is
 used uninitialized whenever 'if' condition is false
Message-ID: <202203090344.60tG1m9i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   3b27ba0ca419a059f5473ccb5e183a2c0c0a0771
commit: e1c21608e3cfc4b44ecdf04e12986b6564667095 [55/60] platform/x86: thinkpad_acpi: Add PSC mode support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203090344.60tG1m9i-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d74a3a514cf64731ecd21e1453aa78af79a565f2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=e1c21608e3cfc4b44ecdf04e12986b6564667095
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout e1c21608e3cfc4b44ecdf04e12986b6564667095
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/thinkpad_acpi.c:10363:13: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           } else if (dytc_profile_available == DYTC_FUNCMODE_PSC)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/thinkpad_acpi.c:10367:6: note: uninitialized use occurs here
           if (err)
               ^~~
   drivers/platform/x86/thinkpad_acpi.c:10363:9: note: remove the 'if' if its condition is always true
           } else if (dytc_profile_available == DYTC_FUNCMODE_PSC)
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/thinkpad_acpi.c:10354:17: note: initialize the variable 'err' to silence this warning
           int output, err;
                          ^
                           = 0
   1 warning generated.


vim +10363 drivers/platform/x86/thinkpad_acpi.c

 10350	
 10351	static void dytc_profile_refresh(void)
 10352	{
 10353		enum platform_profile_option profile;
 10354		int output, err;
 10355		int perfmode;
 10356	
 10357		mutex_lock(&dytc_mutex);
 10358		if (dytc_profile_available == DYTC_FUNCMODE_MMC) {
 10359			if (dytc_mmc_get_available)
 10360				err = dytc_command(DYTC_CMD_MMC_GET, &output);
 10361			else
 10362				err = dytc_cql_command(DYTC_CMD_GET, &output);
 10363		} else if (dytc_profile_available == DYTC_FUNCMODE_PSC)
 10364			err = dytc_command(DYTC_CMD_GET, &output);
 10365	
 10366		mutex_unlock(&dytc_mutex);
 10367		if (err)
 10368			return;
 10369	
 10370		perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
 10371		convert_dytc_to_profile(perfmode, &profile);
 10372		if (profile != dytc_current_profile) {
 10373			dytc_current_profile = profile;
 10374			platform_profile_notify();
 10375		}
 10376	}
 10377	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
