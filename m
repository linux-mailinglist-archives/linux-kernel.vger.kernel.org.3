Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814AF508386
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376786AbiDTIiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349648AbiDTIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:38:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0181AF09
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650443715; x=1681979715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CkmnpT2BiykIfBUkPlFNUPmuDfziFdvXwZoi8G7LQ1k=;
  b=NGQTRmog+7JBGkTSJt7EWsoeiMpOzQNqVydzdCRwtB+l8UDW05lySNWi
   0CPdZS2I30sw0r2COLh8q7B+bPXsXdE4N/IQHnbuY44dZuVDr81F9N3N/
   f9YwKnKJsAzs5hw2BcY0A79UoyPCIElzGTho/QaP4TZCvdUalFOa8G2Nd
   uQVSjAKkncrXEuOs2uNqFRUCc/gLl6syNRmM5QUK/N5cHaPwfbKoXjBGd
   aZCTN8wzCMjRmA/uhyatCGR3xug1h2iGRlO9m4l/UbvpKa2HnkzFWc1Cw
   LGkm9ExdzGxJqtlg0nIUFxdYb/gxoab0oPLIp5ovC8JzuvG46wuY7OzxU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="244558168"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="244558168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 01:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="702561051"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 01:35:13 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh5ns-0006m8-Re;
        Wed, 20 Apr 2022 08:35:12 +0000
Date:   Wed, 20 Apr 2022 16:34:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, lukasz.luba@arm.com
Subject: Re: [PATCH] arch_topology: Trace the update thermal pressure
Message-ID: <202204201654.vcszVDGb-lkp@intel.com>
References: <20220419164801.29078-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419164801.29078-1-lukasz.luba@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

I love your patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on rostedt-trace/for-next linus/master linux/master v5.18-rc3 next-20220419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Luba/arch_topology-Trace-the-update-thermal-pressure/20220420-005845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 3123109284176b1532874591f7c81f3837bbdc17
config: riscv-randconfig-c024-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201654.vcszVDGb-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/aeff700a88be6a7469acfc312155bd213f76de95
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lukasz-Luba/arch_topology-Trace-the-update-thermal-pressure/20220420-005845
        git checkout aeff700a88be6a7469acfc312155bd213f76de95
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/base/arch_topology.o: in function `.L18':
>> arch_topology.c:(.text+0x136): undefined reference to `__traceiter_thermal_pressure_update'
   riscv64-linux-ld: drivers/base/arch_topology.o: in function `.L20':
>> arch_topology.c:(.text+0x168): undefined reference to `__tracepoint_thermal_pressure_update'
>> riscv64-linux-ld: arch_topology.c:(.text+0x16c): undefined reference to `__tracepoint_thermal_pressure_update'
   riscv64-linux-ld: drivers/base/arch_topology.o: in function `.L0 ':
>> arch_topology.c:(__jump_table+0x8): undefined reference to `__tracepoint_thermal_pressure_update'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
