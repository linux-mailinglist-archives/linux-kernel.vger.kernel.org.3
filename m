Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18792520622
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiEIUtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiEIUs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:48:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F27428ABA3;
        Mon,  9 May 2022 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652129100; x=1683665100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kV3QGIMkK5UaMhz5OyUHz2Njf2odm8K27ZLZvtIEh9Q=;
  b=GtD2EeDRAdDMJMD0Op0heoq1GIVrupuGNtTZa19wTQ/2cpFUQyVe9af1
   gfHcAan/ko5zT8miSYLGEuHA6y2ENbaBjb1Fy2IlHe3dy/7BdsQx5Z4V6
   3OuXx1rTDGb15o41y1MnO42Sy0GJLLoxm9CngQaarCCpuNG0e6IeFtRUD
   u6rCDEwS33TbE107Boy55p8p6OAKr4E0xqqu8xmmQn1tHm3OqU/3NMmrM
   q0/KqTFwTV+Ytd4KmWxgv/5ZVxudlB3t3zdq7aD2KXOsuZ4RKqYf3qmSk
   KQgzAc+3VP7LsBOtQNwOCFVcgn2+R2A9YsKn4q1G7OcvBGNPFfIdfYhqZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266756049"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="266756049"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 13:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="623144724"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 May 2022 13:44:57 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noAFV-000GtM-1O;
        Mon, 09 May 2022 20:44:57 +0000
Date:   Tue, 10 May 2022 04:44:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ene <sebastianene@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org, will@kernel.org,
        qperret@google.com, Guenter Roeck <linux@roeck-us.net>,
        Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v5 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <202205100420.UlVQD7zP-lkp@intel.com>
References: <20220509091103.2220604-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509091103.2220604-3-sebastianene@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on char-misc/char-misc-testing soc/for-next v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Ene/Detect-stalls-on-guest-vCPUS/20220509-174959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: h8300-randconfig-s032-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100420.UlVQD7zP-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d3152372fdd19448b32806c0bffd78d8729d02e4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sebastian-Ene/Detect-stalls-on-guest-vCPUS/20220509-174959
        git checkout d3152372fdd19448b32806c0bffd78d8729d02e4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/vcpu_stall_detector.c:106:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct vm_stall_detect_s * @@
   drivers/misc/vcpu_stall_detector.c:106:33: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/misc/vcpu_stall_detector.c:106:33: sparse:     got struct vm_stall_detect_s *
   drivers/misc/vcpu_stall_detector.c:115:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct vm_stall_detect_s * @@
   drivers/misc/vcpu_stall_detector.c:115:32: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/misc/vcpu_stall_detector.c:115:32: sparse:     got struct vm_stall_detect_s *
>> drivers/misc/vcpu_stall_detector.c:131:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vm_stall_detect_s *vm_stall_detect @@     got struct vm_stall_detect_s [noderef] __percpu * @@
   drivers/misc/vcpu_stall_detector.c:131:25: sparse:     expected struct vm_stall_detect_s *vm_stall_detect
   drivers/misc/vcpu_stall_detector.c:131:25: sparse:     got struct vm_stall_detect_s [noderef] __percpu *
   drivers/misc/vcpu_stall_detector.c:154:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct vm_stall_detect_s * @@
   drivers/misc/vcpu_stall_detector.c:154:36: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/misc/vcpu_stall_detector.c:154:36: sparse:     got struct vm_stall_detect_s *
>> drivers/misc/vcpu_stall_detector.c:177:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct vm_stall_detect_s *vm_stall_detect @@
   drivers/misc/vcpu_stall_detector.c:177:21: sparse:     expected void [noderef] __percpu *__pdata
   drivers/misc/vcpu_stall_detector.c:177:21: sparse:     got struct vm_stall_detect_s *vm_stall_detect
   drivers/misc/vcpu_stall_detector.c:189:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct vm_stall_detect_s * @@
   drivers/misc/vcpu_stall_detector.c:189:36: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/misc/vcpu_stall_detector.c:189:36: sparse:     got struct vm_stall_detect_s *
   drivers/misc/vcpu_stall_detector.c:194:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct vm_stall_detect_s *vm_stall_detect @@
   drivers/misc/vcpu_stall_detector.c:194:21: sparse:     expected void [noderef] __percpu *__pdata
   drivers/misc/vcpu_stall_detector.c:194:21: sparse:     got struct vm_stall_detect_s *vm_stall_detect
   drivers/misc/vcpu_stall_detector.c: note: in included file (through include/linux/io.h):
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression
   arch/h8300/include/asm/io.h:44:11: sparse: sparse: cast removes address space '__iomem' of expression

vim +106 drivers/misc/vcpu_stall_detector.c

   100	
   101	static int start_stall_detector_on_cpu(unsigned int cpu)
   102	{
   103		struct vm_stall_detect_s *vm_stall_detect;
   104	
   105		vm_stall_detect = platform_get_drvdata(virt_dev);
 > 106		vcpu_stall_detect_start(this_cpu_ptr(vm_stall_detect));
   107		return 0;
   108	}
   109	
   110	static int stop_stall_detector_on_cpu(unsigned int cpu)
   111	{
   112		struct vm_stall_detect_s *vm_stall_detect;
   113	
   114		vm_stall_detect = platform_get_drvdata(virt_dev);
   115		vcpu_stall_detect_stop(this_cpu_ptr(vm_stall_detect));
   116		return 0;
   117	}
   118	
   119	static int vcpu_stall_detect_probe(struct platform_device *dev)
   120	{
   121		int cpu, ret, err;
   122		void __iomem *membase;
   123		struct resource *r;
   124		struct vm_stall_detect_s *vm_stall_detect;
   125		u32 stall_detect_clock, stall_detect_timeout_sec = 0;
   126	
   127		r = platform_get_resource(dev, IORESOURCE_MEM, 0);
   128		if (r == NULL)
   129			return -ENOENT;
   130	
 > 131		vm_stall_detect = alloc_percpu(typeof(struct vm_stall_detect_s));
   132		if (!vm_stall_detect)
   133			return -ENOMEM;
   134	
   135		membase = ioremap(r->start, resource_size(r));
   136		if (!membase) {
   137			ret = -ENXIO;
   138			goto err_withmem;
   139		}
   140	
   141		virt_dev = dev;
   142		platform_set_drvdata(dev, vm_stall_detect);
   143		if (of_property_read_u32(dev->dev.of_node, "clock-frequency",
   144					 &stall_detect_clock))
   145			stall_detect_clock = DEFAULT_CLOCK_HZ;
   146	
   147		if (of_property_read_u32(dev->dev.of_node, "timeout-sec",
   148					 &stall_detect_timeout_sec))
   149			stall_detect_timeout_sec = DEFAULT_TIMEOT_SEC;
   150	
   151		for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
   152			struct vm_stall_detect_s *cpu_stall_detect;
   153	
   154			cpu_stall_detect = per_cpu_ptr(vm_stall_detect, cpu);
   155			cpu_stall_detect->membase = membase + cpu * REG_LEN;
   156			cpu_stall_detect->clock_freq = stall_detect_clock;
   157			cpu_stall_detect->expiration_sec = stall_detect_timeout_sec;
   158			cpu_stall_detect->ping_timeout_ms = stall_detect_timeout_sec *
   159				MSEC_PER_SEC / 2;
   160			smp_call_function_single(cpu, vcpu_stall_detect_start,
   161						 cpu_stall_detect, true);
   162		}
   163	
   164		err = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
   165						"virt/vcpu_stall_detector:online",
   166						start_stall_detector_on_cpu,
   167						stop_stall_detector_on_cpu);
   168		if (err < 0) {
   169			dev_warn(&dev->dev, "failed to install cpu hotplug");
   170			ret = err;
   171			goto err_withmem;
   172		}
   173	
   174		return 0;
   175	
   176	err_withmem:
 > 177		free_percpu(vm_stall_detect);
   178		return ret;
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
