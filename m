Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D62558345D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiG0VDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiG0VC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:02:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB31558D0;
        Wed, 27 Jul 2022 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658955778; x=1690491778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iGjz6Q1KujnWecsXb+ueart3CwmcROP94oxBajhhL9Q=;
  b=AUW4DO7Ii6eH1UAeBZmXVzISM+rXVByEhoBxEy2kagDvTxaasts6fMBt
   D5t4cdxRlKMRTP/jis7NKAQYyJi7Hee4Fp0paLXT8MafzdxIFX0MbWaam
   2pC0OnnlfIstxv1Bn6GvlARL7OZe4K8SwIr3ux5hpIH2C7BpHWywnqA79
   iNAj42r3sM+COuY+GhbjE/rR/RGIpb7fajC4UW9S7uL+WdhmhWzA4dKLQ
   CtdxsRQPZW+imtRxzYcUcv6iKYAANKbhNMTzi314njZsoWoB8WsQa0aTD
   yvfIoH6Whf7cdB8R86UmHi5r7K4+J132rj661iBX+eh0kRKMTR7Ht63Vk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="288360076"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="288360076"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 14:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="776845230"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2022 14:02:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGoBC-00096w-2L;
        Wed, 27 Jul 2022 21:02:54 +0000
Date:   Thu, 28 Jul 2022 05:02:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     kah.jing.lee@intel.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     kbuild-all@lists.01.org, rafael.j.wysocki@intel.com,
        tien.sung.ang@intel.com, dinh.nguyen@intel.com,
        Kah Jing Lee <kah.jing.lee@intel.com>, Zhou@vger.kernel.org,
        Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] drivers: misc: intel_sysid: Add sysid from arch
 to drivers
Message-ID: <202207280422.mCMrDg9E-lkp@intel.com>
References: <20220721123149.416618-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721123149.416618-1-kah.jing.lee@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on soc/for-next linus/master v5.19-rc8]
[cannot apply to char-misc/char-misc-testing next-20220727]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/kah-jing-lee-intel-com/drivers-misc-intel_sysid-Add-sysid-from-arch-to-drivers/20220721-213214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 8af028c2b22bc04f5ab59cd39fa97ccf14aa8f25
config: s390-randconfig-p001-20220727 (https://download.01.org/0day-ci/archive/20220728/202207280422.mCMrDg9E-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5e0d691312542fbb751afb99bd7b537b9a975750
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review kah-jing-lee-intel-com/drivers-misc-intel_sysid-Add-sysid-from-arch-to-drivers/20220721-213214
        git checkout 5e0d691312542fbb751afb99bd7b537b9a975750
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 5e0d691312542fbb751afb99bd7b537b9a975750
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/misc/intel_sysid.o: in function `intel_sysid_probe':
>> drivers/misc/intel_sysid.c:85: undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
>> drivers/net/ethernet/altera/altera_tse_main.c:1339: undefined reference to `devm_ioremap'
   pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> arch/s390/kernel/perf_cpum_sf.c:805:8: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
     si = cpuhw->qsi;
          ^
   arch/s390/kernel/perf_cpum_sf.c:804:11: note: Address of variable taken here.
     cpuhw = &per_cpu(cpu_hw_sf, event->cpu);
             ^
   arch/s390/kernel/perf_cpum_sf.c:804:19: note: Temporary created here.
     cpuhw = &per_cpu(cpu_hw_sf, event->cpu);
                     ^
   arch/s390/kernel/perf_cpum_sf.c:805:8: note: Using pointer that is a temporary.
     si = cpuhw->qsi;
          ^
   arch/s390/kernel/perf_cpum_sf.c:867:27: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
      err = allocate_buffers(cpuhw, hwc);
                             ^
   arch/s390/kernel/perf_cpum_sf.c:866:12: note: Address of variable taken here.
      cpuhw = &per_cpu(cpu_hw_sf, cpu);
              ^
   arch/s390/kernel/perf_cpum_sf.c:866:20: note: Temporary created here.
      cpuhw = &per_cpu(cpu_hw_sf, cpu);
                      ^
   arch/s390/kernel/perf_cpum_sf.c:867:27: note: Using pointer that is a temporary.
      err = allocate_buffers(cpuhw, hwc);
                             ^
   arch/s390/kernel/perf_cpum_sf.c:1825:8: warning: Using pointer that is a temporary. [danglingTemporaryLifetime]
     si = cpuhw->qsi;
          ^
   arch/s390/kernel/perf_cpum_sf.c:1823:29: note: Address of variable taken here.
     struct cpu_hw_sf *cpuhw = &per_cpu(cpu_hw_sf, event->cpu);
                               ^
   arch/s390/kernel/perf_cpum_sf.c:1823:37: note: Temporary created here.
     struct cpu_hw_sf *cpuhw = &per_cpu(cpu_hw_sf, event->cpu);
                                       ^
   arch/s390/kernel/perf_cpum_sf.c:1825:8: note: Using pointer that is a temporary.
     si = cpuhw->qsi;
          ^

vim +85 drivers/misc/intel_sysid.c

    70	
    71	static int intel_sysid_probe(struct platform_device *pdev)
    72	{
    73		struct intel_sysid *sysid;
    74		struct resource	*regs;
    75	
    76		sysid = devm_kzalloc(&pdev->dev, sizeof(struct intel_sysid),
    77			GFP_KERNEL);
    78		if (!sysid)
    79			return -ENOMEM;
    80	
    81		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    82		if (!regs)
    83			return -ENXIO;
    84	
  > 85		sysid->regs = devm_ioremap_resource(&pdev->dev, regs);
    86		if (IS_ERR(sysid->regs))
    87			return PTR_ERR(sysid->regs);
    88	
    89		platform_set_drvdata(pdev, sysid);
    90	
    91		return devm_device_add_group(&pdev->dev, &intel_sysid_attr_group);
    92	}
    93	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
