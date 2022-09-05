Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EEC5AD77D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiIEQcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiIEQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:32:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E202F38F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662395562; x=1693931562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1wvwsRe1oK6DGxnPpO6P7bCm1Oj7YYrvrDBldpkw57Y=;
  b=TyMmVAyHo3qI6MsOfxqgYuy8p46cegPytMN9K/BuF0hGtKHSf6LX1O1p
   911Xw2qirFR2pNFvk6XjOyUzjcpzUcvL982nH92PO0k058tAZZRf43Fkw
   g76Wiq7KErp+sWZAvvnJJSgU5qour2wbd3j5WVcgITC7uvQGFMeDKEIqK
   OYPYgF76hGZxFbr/Dcsdqf8ToYWqZuWT8uLvPwmxwbxy++3upbRm2ai4M
   x4PlZ2z/52q3kEfugjXP0CAyaUGej4bf6Mn6tYB679RqItryFQTueL1+E
   JOIx5OKBEil0xbfNTyjthtlxpszYjzJtRThqSWOBxqUVOFDMNntIvYxXR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="358137215"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="358137215"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 09:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="942159714"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 09:32:39 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVF1a-0004Ll-32;
        Mon, 05 Sep 2022 16:32:38 +0000
Date:   Tue, 6 Sep 2022 00:31:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        rafael.j.wysocki@intel.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        tangmeng <tangmeng@uniontech.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: ACPI: reboot: Reinstate S5 for reboot
Message-ID: <202209060009.J18tERPi-lkp@intel.com>
References: <20220905071559.1576801-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905071559.1576801-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v6.0-rc4 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kai-Heng-Feng/PM-ACPI-reboot-Reinstate-S5-for-reboot/20220905-152323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: mips-randconfig-r034-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060009.J18tERPi-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/b2191fe14b5426dcef80f2935fdfa47af98b0ee2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kai-Heng-Feng/PM-ACPI-reboot-Reinstate-S5-for-reboot/20220905-152323
        git checkout b2191fe14b5426dcef80f2935fdfa47af98b0ee2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/reboot.c:257:6: error: use of undeclared identifier 'pm_power_off_prepare'; did you mean 'pm_generic_prepare'?
           if (pm_power_off_prepare)
               ^~~~~~~~~~~~~~~~~~~~
               pm_generic_prepare
   include/linux/pm.h:795:12: note: 'pm_generic_prepare' declared here
   extern int pm_generic_prepare(struct device *dev);
              ^
>> kernel/reboot.c:258:3: error: call to undeclared function 'pm_power_off_prepare'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   pm_power_off_prepare();
                   ^
   2 errors generated.


vim +257 kernel/reboot.c

   245	
   246	/**
   247	 *	kernel_restart - reboot the system
   248	 *	@cmd: pointer to buffer containing command to execute for restart
   249	 *		or %NULL
   250	 *
   251	 *	Shutdown everything and perform a clean reboot.
   252	 *	This is not safe to call in interrupt context.
   253	 */
   254	void kernel_restart(char *cmd)
   255	{
   256		kernel_restart_prepare(cmd);
 > 257		if (pm_power_off_prepare)
 > 258			pm_power_off_prepare();
   259		migrate_to_reboot_cpu();
   260		syscore_shutdown();
   261		if (!cmd)
   262			pr_emerg("Restarting system\n");
   263		else
   264			pr_emerg("Restarting system with command '%s'\n", cmd);
   265		kmsg_dump(KMSG_DUMP_SHUTDOWN);
   266		machine_restart(cmd);
   267	}
   268	EXPORT_SYMBOL_GPL(kernel_restart);
   269	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
