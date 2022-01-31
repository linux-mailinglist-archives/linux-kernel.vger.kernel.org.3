Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02524A4CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380755AbiAaRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:12:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:19764 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380753AbiAaRMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643649164; x=1675185164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eLSPOn9wNcCBpQFdvY19r2J/AzPe22vJrtaej4/hWbc=;
  b=cz+fv2v9LiLlfLRv+h+H1+k9WvGslV494SX84Hk0uOa+uAIESDic40R0
   r2Lwf5Nsrkkuq9btjEMgAulz+VI0eAptLIdYzpHqp66oPCUPwMDwPcy+G
   y/XrUogMth/OH65ol9vyPB+/1qHNxxXlwQm8g0d801+8/eU/XHRn7fd75
   iuWOkMxjS9QO0Gp0vpFD91x4rdJyQ6cBS/1W9bt8SFOdJUDi/BvHEmw25
   slXnD/AgNhkBBgOMiZ05PhOEqlGO9fmeJ5aKDCxANZxc7ViJxeEBlqn1U
   vfnJR86wBBVYADiXXnNQwlNEsOpyLtUPO+4aSaSMbPH2KKTQ8NHU7XScO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="271981357"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="271981357"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 09:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="496992439"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2022 09:12:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEaEJ-000SBT-VE; Mon, 31 Jan 2022 17:12:39 +0000
Date:   Tue, 1 Feb 2022 01:11:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 57/62]
 drivers/soc/sifive/sifive_l2_cache.c:158:17: error: implicit declaration of
 function 'writeq'; did you mean 'writel'?
Message-ID: <202202010133.vBBeLOsj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

First bad commit (maybe != root cause):

tree:   https://github.com/esmil/linux visionfive
head:   8c758048edfd830baceb991167131c9d55786544
commit: 8ee233dc08b97b5cde863d4be4f9b331ac586963 [57/62] RISC-V: Enable SIFIVE_L2_FLUSH for StarFive SoCs
config: riscv-randconfig-r003-20220131 (https://download.01.org/0day-ci/archive/20220201/202202010133.vBBeLOsj-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/8ee233dc08b97b5cde863d4be4f9b331ac586963
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 8ee233dc08b97b5cde863d4be4f9b331ac586963
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/starfive/ drivers/soc/sifive/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/soc/sifive/sifive_l2_cache.c: In function 'sifive_l2_flush64_range':
>> drivers/soc/sifive/sifive_l2_cache.c:158:17: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
     158 |                 writeq(line, l2_base + SIFIVE_L2_FLUSH64);
         |                 ^~~~~~
         |                 writel
   cc1: some warnings being treated as errors
--
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:11,
                    from include/linux/dma-buf-map.h:9,
                    from include/linux/dma-buf.h:16,
                    from drivers/gpu/drm/starfive/starfive_drm_gem.c:5:
   drivers/gpu/drm/starfive/starfive_drm_gem.c: In function 'starfive_drm_gem_alloc_dma':
>> include/linux/kern_levels.h:5:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/drm/drm_print.h:494:9: note: in expansion of macro 'printk'
     494 |         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/drm/drm_print.h:494:22: note: in expansion of macro 'KERN_INFO'
     494 |         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
         |                      ^~~~~
   include/drm/drm_print.h:498:9: note: in expansion of macro '_DRM_PRINTK'
     498 |         _DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~
   drivers/gpu/drm/starfive/starfive_drm_gem.c:132:9: note: in expansion of macro 'DRM_INFO'
     132 |         DRM_INFO("dma_addr = 0x%llx, size = %lu\n", starfive_obj->dma_addr, obj->size);
         |         ^~~~~~~~
>> include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/drm/drm_print.h:494:9: note: in expansion of macro 'printk'
     494 |         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/drm/drm_print.h:494:22: note: in expansion of macro 'KERN_INFO'
     494 |         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
         |                      ^~~~~
   include/drm/drm_print.h:498:9: note: in expansion of macro '_DRM_PRINTK'
     498 |         _DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~
   drivers/gpu/drm/starfive/starfive_drm_gem.c:132:9: note: in expansion of macro 'DRM_INFO'
     132 |         DRM_INFO("dma_addr = 0x%llx, size = %lu\n", starfive_obj->dma_addr, obj->size);
         |         ^~~~~~~~
   At top level:
   drivers/gpu/drm/starfive/starfive_drm_gem.c:17:42: warning: 'mmap_mem_ops' defined but not used [-Wunused-const-variable=]
      17 | static const struct vm_operations_struct mmap_mem_ops = {
         |                                          ^~~~~~~~~~~~
--
   drivers/gpu/drm/starfive/starfive_drm_crtc.c: In function 'starfive_crtc_atomic_flush':
>> drivers/gpu/drm/starfive/starfive_drm_crtc.c:204:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     204 |         int ret;
         |             ^~~
   drivers/gpu/drm/starfive/starfive_drm_crtc.c: In function 'starfive_crtc_atomic_enable':
   drivers/gpu/drm/starfive/starfive_drm_crtc.c:221:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     221 |         int ret;
         |             ^~~
   drivers/gpu/drm/starfive/starfive_drm_crtc.c: At top level:
>> drivers/gpu/drm/starfive/starfive_drm_crtc.c:272:5: warning: no previous prototype for 'starfive_crtc_create' [-Wmissing-prototypes]
     272 | int starfive_crtc_create(struct drm_device *drm_dev,
         |     ^~~~~~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/starfive/starfive_drm_vpp.c: In function 'vpp1_isr_handler':
>> drivers/gpu/drm/starfive/starfive_drm_vpp.c:590:13: warning: variable 'intr_status' set but not used [-Wunused-but-set-variable]
     590 |         u32 intr_status = 0;
         |             ^~~~~~~~~~~


vim +158 drivers/soc/sifive/sifive_l2_cache.c

a967a289f169695 arch/riscv/mm/sifive_l2_cache.c      Yash Shah          2019-05-06  126  
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  127  #ifdef CONFIG_SIFIVE_L2_FLUSH
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  128  void sifive_l2_flush64_range(unsigned long start, unsigned long len)
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  129  {
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  130  	unsigned long line;
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  131  
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  132  	if(!l2_base) {
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  133  		pr_warn("L2CACHE: base addr invalid, skipping flush\n");
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  134  		return;
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  135  	}
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  136  
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  137  	/* TODO: if (len == 0), skipping flush or going on? */
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  138  	if(!len) {
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  139  		pr_debug("L2CACHE: flush64 range @ 0x%lx(len:0)\n", start);
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  140  		return;
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  141  	}
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  142  
b4d19807f25f01a drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  143  	len = len + (start % SIFIVE_L2_FLUSH64_LINE_LEN);
b4d19807f25f01a drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  144  	start = ALIGN_DOWN(start, SIFIVE_L2_FLUSH64_LINE_LEN);
b4d19807f25f01a drivers/soc/sifive/sifive_l2_cache.c Atish Patra        2021-06-12  145  
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  146  	/* make sure the address is in the range */
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  147  	if(start < CONFIG_SIFIVE_L2_FLUSH_START ||
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  148  	   (start + len) > (CONFIG_SIFIVE_L2_FLUSH_START +
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  149  			     CONFIG_SIFIVE_L2_FLUSH_SIZE)) {
e53ad16756cae6c drivers/soc/sifive/sifive_l2_cache.c Geert Uytterhoeven 2021-05-21  150  		WARN(1, "L2CACHE: flush64 out of range: %lx(%lx), skip flush\n",
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  151  		     start, len);
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  152  		return;
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  153  	}
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  154  
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  155  	mb();	/* sync */
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  156  	for (line = start; line < start + len;
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  157  	     line += SIFIVE_L2_FLUSH64_LINE_LEN) {
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08 @158  		writeq(line, l2_base + SIFIVE_L2_FLUSH64);
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  159  		mb();
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  160  	}
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  161  }
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  162  EXPORT_SYMBOL_GPL(sifive_l2_flush64_range);
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  163  #endif
601a2f4e945153e drivers/soc/sifive/sifive_l2_cache.c Tom                2021-01-08  164  

:::::: The code at line 158 was first introduced by commit
:::::: 601a2f4e945153ebae8645596eda50ea39369c88 sifive/sifive_l2_cache: Add sifive_l2_flush64_range function

:::::: TO: Tom <support@vamrs.com>
:::::: CC: Emil Renner Berthing <kernel@esmil.dk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
