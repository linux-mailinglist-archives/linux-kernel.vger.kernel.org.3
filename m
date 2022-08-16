Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FE059609D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiHPQxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiHPQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:53:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E98B7B1D9;
        Tue, 16 Aug 2022 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660668783; x=1692204783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JMQasI3jp4QSDblLur902dOnDKdWj/6zrU1a6jWVATA=;
  b=V+B01D04kNbPKb8NNuU5aDXwhu+2ZpnrnAO/oT9BITkOk+PpSDu1ABhO
   3OIVJ5EoRMDs1hCQQLZbTbyT/QT4eZAP7tmrH2GCxaD2ImlCCsA4z3KHr
   NWtbvXLRlwlcleLvhgTibYXSeJf4CQUt0Ex+cSST1RA0YfafhhV2xQ7EN
   hL2AaHdd7E0xkqN0FI465h+QQ4BAzhoAC7Cryo7jCbDOOFhPh5SLrQ6Ic
   10iiljmRI5qpQhy23e5Ob/xED9XJMKeQEWqABAznIolUtWxj1iYhgj4h8
   GmiLTGboWe9rCmqag7o0vfLaXvUFD3WFSKw7ofzfmYM9I7RG6UUb2mmQf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="356274496"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="356274496"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 09:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="733362460"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2022 09:52:58 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNzoH-00005Y-1A;
        Tue, 16 Aug 2022 16:52:57 +0000
Date:   Wed, 17 Aug 2022 00:52:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eliav Farber <farbere@amazon.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, farbere@amazon.com,
        talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dwmw@amazon.co.uk, rtanwar@maxlinear.com
Subject: Re: [PATCH 08/16] hwmon: (mr75203) add VM active channel support
Message-ID: <202208170047.kXOyBIXA-lkp@intel.com>
References: <20220816082757.11990-9-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816082757.11990-9-farbere@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eliav,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.0-rc1 next-20220816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eliav-Farber/Variety-of-fixes-and-new-features-for-mr75203-driver/20220816-183655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: powerpc-randconfig-r024-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170047.kXOyBIXA-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/75e49737eb6188733096da72eb4692cfed872101
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eliav-Farber/Variety-of-fixes-and-new-features-for-mr75203-driver/20220816-183655
        git checkout 75e49737eb6188733096da72eb4692cfed872101
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:43:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:178:1: note: expanded from here
   __do_insb
   ^
   arch/powerpc/include/asm/io.h:577:56: note: expanded from macro '__do_insb'
   #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/hwmon/mr75203.c:19:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:180:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:578:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/hwmon/mr75203.c:19:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:182:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:579:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/hwmon/mr75203.c:19:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:184:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:580:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/hwmon/mr75203.c:19:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:186:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:581:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/hwmon/mr75203.c:19:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:188:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:582:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> drivers/hwmon/mr75203.c:604:13: warning: variable length array used [-Wvla]
                   u8 vm_idx[vm_num];
                             ^~~~~~
   drivers/hwmon/mr75203.c:605:19: warning: variable length array used [-Wvla]
                   u8 vm_active_ch[vm_num];
                                   ^~~~~~
   8 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]


vim +604 drivers/hwmon/mr75203.c

   514	
   515	static int mr75203_probe(struct platform_device *pdev)
   516	{
   517		const struct hwmon_channel_info **pvt_info;
   518		u32 ts_num, vm_num, pd_num, ch_num, val, index, i, j, k;
   519		struct device *dev = &pdev->dev;
   520		u32 *temp_config, *in_config;
   521		struct device *hwmon_dev;
   522		struct pvt_device *pvt;
   523		int ret;
   524	
   525		pvt = devm_kzalloc(dev, sizeof(*pvt), GFP_KERNEL);
   526		if (!pvt)
   527			return -ENOMEM;
   528	
   529		ret = pvt_get_regmap(pdev, "common", pvt);
   530		if (ret)
   531			return ret;
   532	
   533		pvt->clk = devm_clk_get(dev, NULL);
   534		if (IS_ERR(pvt->clk))
   535			return dev_err_probe(dev, PTR_ERR(pvt->clk), "failed to get clock\n");
   536	
   537		ret = pvt_clk_enable(dev, pvt);
   538		if (ret) {
   539			dev_err(dev, "failed to enable clock\n");
   540			return ret;
   541		}
   542	
   543		if (of_property_read_bool(dev->of_node, "reset-control-skip")) {
   544			dev_info(dev, "skipping reset-control\n");
   545		} else {
   546			pvt->rst = devm_reset_control_get_exclusive(dev, NULL);
   547			if (IS_ERR(pvt->rst))
   548				return dev_err_probe(dev, PTR_ERR(pvt->rst),
   549						     "failed to get reset control\n");
   550	
   551			ret = pvt_reset_control_deassert(dev, pvt);
   552			if (ret)
   553				return dev_err_probe(dev, ret,
   554						     "cannot deassert reset control\n");
   555		}
   556	
   557		ret = regmap_read(pvt->c_map, PVT_IP_CONFIG, &val);
   558		if(ret < 0)
   559			return ret;
   560	
   561		ts_num = (val & TS_NUM_MSK) >> TS_NUM_SFT;
   562		pd_num = (val & PD_NUM_MSK) >> PD_NUM_SFT;
   563		vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
   564		ch_num = (val & CH_NUM_MSK) >> CH_NUM_SFT;
   565		pvt->t_num = ts_num;
   566		pvt->p_num = pd_num;
   567		pvt->v_num = vm_num;
   568		val = 0;
   569		if (ts_num)
   570			val++;
   571		if (vm_num)
   572			val++;
   573		if (!val)
   574			return -ENODEV;
   575	
   576		pvt_info = devm_kcalloc(dev, val + 2, sizeof(*pvt_info), GFP_KERNEL);
   577		if (!pvt_info)
   578			return -ENOMEM;
   579		pvt_info[0] = HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ);
   580		index = 1;
   581	
   582		if (ts_num) {
   583			ret = pvt_get_regmap(pdev, "ts", pvt);
   584			if (ret)
   585				return ret;
   586	
   587			temp_config = devm_kcalloc(dev, ts_num + 1,
   588						   sizeof(*temp_config), GFP_KERNEL);
   589			if (!temp_config)
   590				return -ENOMEM;
   591	
   592			memset32(temp_config, HWMON_T_INPUT, ts_num);
   593			pvt_temp.config = temp_config;
   594			pvt_info[index++] = &pvt_temp;
   595		}
   596	
   597		if (pd_num) {
   598			ret = pvt_get_regmap(pdev, "pd", pvt);
   599			if (ret)
   600				return ret;
   601		}
   602	
   603		if (vm_num) {
 > 604			u8 vm_idx[vm_num];
   605			u8 vm_active_ch[vm_num];
   606	
   607			ret = pvt_get_regmap(pdev, "vm", pvt);
   608			if (ret)
   609				return ret;
   610	
   611			ret = device_property_read_u8_array(dev, "intel,vm-map", vm_idx,
   612							    vm_num);
   613			if (ret) {
   614				/*
   615				 * Incase intel,vm-map property is not defined, we
   616				 * assume incremental channel numbers.
   617				 */
   618				for (i = 0; i < vm_num; i++)
   619					vm_idx[i] = i;
   620			} else {
   621				for (i = 0; i < vm_num; i++)
   622					if (vm_idx[i] >= vm_num || vm_idx[i] == 0xff)
   623						break;
   624	
   625				vm_num = i;
   626				pvt->v_num = i;
   627			}
   628	
   629			ret = device_property_read_u8_array(dev, "vm-active-channels",
   630							    vm_active_ch, vm_num);
   631			if (ret) {
   632				/*
   633				 * Incase vm-active-channels property is not defined,
   634				 * we assume each VM sensor has all of its channels
   635				 * active.
   636				 */
   637				for (i = 0; i < vm_num; i++)
   638					vm_active_ch[i] = ch_num;
   639	
   640				pvt->vm_ch_max = ch_num;
   641				pvt->vm_ch_total = ch_num * vm_num;
   642			} else {
   643				for (i = 0; i < vm_num; i++) {
   644					if (vm_active_ch[i] > ch_num) {
   645						dev_err(dev,
   646							"invalid active channels: %u\n",
   647							vm_active_ch[i]);
   648						return -EINVAL;
   649					}
   650	
   651					pvt->vm_ch_total += vm_active_ch[i];
   652	
   653					if (vm_active_ch[i] > pvt->vm_ch_max)
   654						pvt->vm_ch_max = vm_active_ch[i];
   655				}
   656			}
   657	
   658			/*
   659			 * Map between the channel-number to VM-index and channel-index.
   660			 * Example - 3 VMs, vm_active_ch = [05 02 04]:
   661			 * vm_map = [0 0 0 0 0 1 1 2 2 2 2]
   662			 * ch_map = [0 1 2 3 4 0 1 0 1 2 3]
   663			 */
   664			pvt->vd = devm_kcalloc(dev, pvt->vm_ch_total, sizeof(*pvt->vd),
   665					       GFP_KERNEL);
   666			if (!pvt->vd)
   667				return -ENOMEM;
   668	
   669			k = 0;
   670			for (i = 0; i < vm_num; i++)
   671				for (j = 0; j < vm_active_ch[i]; j++) {
   672					pvt->vd[k].vm_map = vm_idx[i];
   673					pvt->vd[k].ch_map = j;
   674					k++;
   675				}
   676	
   677			in_config = devm_kcalloc(dev, pvt->vm_ch_total + 1,
   678						 sizeof(*in_config), GFP_KERNEL);
   679			if (!in_config)
   680				return -ENOMEM;
   681	
   682			memset32(in_config, HWMON_I_INPUT, pvt->vm_ch_total);
   683			in_config[pvt->vm_ch_total] = 0;
   684			pvt_in.config = in_config;
   685	
   686			pvt_info[index++] = &pvt_in;
   687		}
   688	
   689		ret = pvt_init(pvt);
   690		if (ret) {
   691			dev_err(dev, "failed to init pvt: %d\n", ret);
   692			return ret;
   693		}
   694	
   695		pvt_chip_info.info = pvt_info;
   696		hwmon_dev = devm_hwmon_device_register_with_info(dev, "pvt",
   697								 pvt,
   698								 &pvt_chip_info,
   699								 NULL);
   700	
   701		return PTR_ERR_OR_ZERO(hwmon_dev);
   702	}
   703	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
