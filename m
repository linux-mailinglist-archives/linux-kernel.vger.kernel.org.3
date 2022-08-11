Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0C5908C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiHKWmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHKWmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:42:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387C99C8F4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660257733; x=1691793733;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/U6rzMO88TQdePdqFGiKcIg5zqKeKBvTMkqsW6yj2Fc=;
  b=Mte66H9Xdgs30vL/VUWRobR0Mb7+fDVdygewbnJVrmiXQL8M9ZYQiIMS
   aBFx6JfgSr2OSx7/B56iDYfSzRQbcItwx10kExLXd9fRb6SUz85O5hwYV
   1KjosNkYb/Ip3ePkP6Mlsj4eruHjsuOeqOMqhMnj6SzCvxXo0W+RLP9el
   wEXzWtYQl1lB3pZ1FIaVBKTVGspF2PkDgs+1AYXg9Zz0rdon87Rart0kT
   QFkKtUgVEpnSUSeP4YF8Hh1NXMyydggRcLf4BBPBPZQ2IhMmv43b7kn3p
   K9x7z7Pc1wFutXR1oP9h+UhzhtNSTWBaxXUC/4KKASQFthd/kbnPfl9y7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="355481716"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="355481716"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 15:42:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="581851451"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Aug 2022 15:42:11 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMGsU-0000kT-37;
        Thu, 11 Aug 2022 22:42:10 +0000
Date:   Fri, 12 Aug 2022 06:42:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [riscv:for-next 3/14] arch/riscv/mm/dma-noncoherent.c:107:6:
 warning: variable 'cbom_hartid' is uninitialized when used here
Message-ID: <202208120635.bMNAowDE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git for-next
head:   d8357e3bf8f7aabd98bf4dc2709ee877b741cefc
commit: 3aefb2ee5bdd4a8976298415a5a017bf9844bfd5 [3/14] riscv: implement Zicbom-based CMO instructions + the t-head variant
config: riscv-randconfig-r042-20220811 (https://download.01.org/0day-ci/archive/20220812/202208120635.bMNAowDE-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?id=3aefb2ee5bdd4a8976298415a5a017bf9844bfd5
        git remote add riscv https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
        git fetch --no-tags riscv for-next
        git checkout 3aefb2ee5bdd4a8976298415a5a017bf9844bfd5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/mm/dma-noncoherent.c:107:6: warning: variable 'cbom_hartid' is uninitialized when used here [-Wuninitialized]
                                           cbom_hartid, hartid);
                                           ^~~~~~~~~~~
   include/linux/printk.h:517:37: note: expanded from macro 'pr_warn'
           printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                              ^~~~~~~~~~~
   include/linux/printk.h:464:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:436:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
   arch/riscv/mm/dma-noncoherent.c:87:18: note: initialize the variable 'cbom_hartid' to silence this warning
                   int cbom_hartid;
                                  ^
                                   = 0
   1 warning generated.


vim +/cbom_hartid +107 arch/riscv/mm/dma-noncoherent.c

1631ba1259d6d7 Heiko Stuebner 2022-07-07   77  
1631ba1259d6d7 Heiko Stuebner 2022-07-07   78  #ifdef CONFIG_RISCV_ISA_ZICBOM
1631ba1259d6d7 Heiko Stuebner 2022-07-07   79  void riscv_init_cbom_blocksize(void)
1631ba1259d6d7 Heiko Stuebner 2022-07-07   80  {
1631ba1259d6d7 Heiko Stuebner 2022-07-07   81  	struct device_node *node;
1631ba1259d6d7 Heiko Stuebner 2022-07-07   82  	int ret;
1631ba1259d6d7 Heiko Stuebner 2022-07-07   83  	u32 val;
1631ba1259d6d7 Heiko Stuebner 2022-07-07   84  
1631ba1259d6d7 Heiko Stuebner 2022-07-07   85  	for_each_of_cpu_node(node) {
3aefb2ee5bdd4a Palmer Dabbelt 2022-08-10   86  		unsigned long hartid;
1631ba1259d6d7 Heiko Stuebner 2022-07-07   87  		int cbom_hartid;
1631ba1259d6d7 Heiko Stuebner 2022-07-07   88  
3aefb2ee5bdd4a Palmer Dabbelt 2022-08-10   89  		ret = riscv_of_processor_hartid(node, &hartid);
3aefb2ee5bdd4a Palmer Dabbelt 2022-08-10   90  		if (ret)
3aefb2ee5bdd4a Palmer Dabbelt 2022-08-10   91  			continue;
3aefb2ee5bdd4a Palmer Dabbelt 2022-08-10   92  
1631ba1259d6d7 Heiko Stuebner 2022-07-07   93  		if (hartid < 0)
1631ba1259d6d7 Heiko Stuebner 2022-07-07   94  			continue;
1631ba1259d6d7 Heiko Stuebner 2022-07-07   95  
1631ba1259d6d7 Heiko Stuebner 2022-07-07   96  		/* set block-size for cbom extension if available */
1631ba1259d6d7 Heiko Stuebner 2022-07-07   97  		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
1631ba1259d6d7 Heiko Stuebner 2022-07-07   98  		if (ret)
1631ba1259d6d7 Heiko Stuebner 2022-07-07   99  			continue;
1631ba1259d6d7 Heiko Stuebner 2022-07-07  100  
1631ba1259d6d7 Heiko Stuebner 2022-07-07  101  		if (!riscv_cbom_block_size) {
1631ba1259d6d7 Heiko Stuebner 2022-07-07  102  			riscv_cbom_block_size = val;
1631ba1259d6d7 Heiko Stuebner 2022-07-07  103  			cbom_hartid = hartid;
1631ba1259d6d7 Heiko Stuebner 2022-07-07  104  		} else {
1631ba1259d6d7 Heiko Stuebner 2022-07-07  105  			if (riscv_cbom_block_size != val)
3aefb2ee5bdd4a Palmer Dabbelt 2022-08-10  106  				pr_warn("cbom-block-size mismatched between harts %d and %lu\n",
1631ba1259d6d7 Heiko Stuebner 2022-07-07 @107  					cbom_hartid, hartid);
1631ba1259d6d7 Heiko Stuebner 2022-07-07  108  		}
1631ba1259d6d7 Heiko Stuebner 2022-07-07  109  	}
1631ba1259d6d7 Heiko Stuebner 2022-07-07  110  }
1631ba1259d6d7 Heiko Stuebner 2022-07-07  111  #endif
1631ba1259d6d7 Heiko Stuebner 2022-07-07  112  

:::::: The code at line 107 was first introduced by commit
:::::: 1631ba1259d6d7f49b6028f2a1a0fa02be1c522a riscv: Add support for non-coherent devices using zicbom extension

:::::: TO: Heiko Stuebner <heiko@sntech.de>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
