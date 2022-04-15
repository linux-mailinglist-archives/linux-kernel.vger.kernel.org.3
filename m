Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D243C5025BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350625AbiDOGpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350605AbiDOGph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:45:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FB7AFB10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650004989; x=1681540989;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3wYDi8gOtSLszzx2cpMJSzuhWjZ002JXdJ813ftshcc=;
  b=UEAPTyiWO1U4e7PVDYOsRpyBXlJV+W/BxVz3TDjCtOC/aauXsG0TVmrP
   VetEfw2FFlmKMMQrU0maRzLMiObtRltVh+GAWpA1uJ/Edr9Uu6cIElxY9
   JUAN/UnFY/Xk3AU1s8q3HwmX5cV7a5I6Ab21IKb5Gj+bUUmjw83UxbvK3
   QGn+m561L9K3hs1ybZ2z/97OiFCR7Y6Fxa/VsUZMVKpdTjoHD0OSrr61u
   +dr0E7YgfKPp69PKQF282ZcE7GofAJsLs8NRV5/+9LEJA2tfQAnjp/4kA
   DY8qsSb7NA7A+j62XjRFOdRbtMODXPEw/G8x0BWCYaNsH74L4JYy5qhL2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="244991435"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="244991435"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 23:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="574210329"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Apr 2022 23:43:05 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfFfd-0001fN-Ad;
        Fri, 15 Apr 2022 06:43:05 +0000
Date:   Fri, 15 Apr 2022 14:42:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Wei Fu <wefu@redhat.com>,
        Liu Shaohua <liush@allwinnertech.com>,
        Guo Ren <guoren@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: [esmil:visionfive-nc 9/28] <inline asm>:27:6: error: expected
 assembly-time absolute expression
Message-ID: <202204151455.LXfFw7ik-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive-nc
head:   b0b9e814967f0f06d0baca439d5e0d7a71201cf1
commit: 2c47ef8bb308963658bc94e8a2074bf4ec12c612 [9/28] riscv: add RISC-V Svpbmt extension support
config: riscv-randconfig-c006-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151455.LXfFw7ik-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/2c47ef8bb308963658bc94e8a2074bf4ec12c612
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive-nc
        git checkout 2c47ef8bb308963658bc94e8a2074bf4ec12c612
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> <inline asm>:27:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:28:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from drivers/uio/uio_sercos3.c:29:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:114:
   arch/riscv/include/asm/pgtable-64.h:93:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_MTMASK);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
       ^
   arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:98:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:27:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from drivers/uio/uio_sercos3.c:29:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:114:
   arch/riscv/include/asm/pgtable-64.h:93:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_MTMASK);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
       ^
   arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:99:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:28:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from drivers/uio/uio_sercos3.c:29:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:114:
   arch/riscv/include/asm/pgtable-64.h:109:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
       ^
   arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:98:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:27:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
--
>> <inline asm>:27:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:28:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
>> <inline asm>:27:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:28:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
>> <inline asm>:27:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:28:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
>> <inline asm>:27:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:28:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
>> <inline asm>:27:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:28:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
>> <inline asm>:27:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:28:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   12 errors generated.
--
>> <inline asm>:27:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:28:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
>> <inline asm>:27:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:28:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
>> <inline asm>:27:6: error: expected assembly-time absolute expression
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   <inline asm>:28:6: error: expected assembly-time absolute expression
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from drivers/pci/pci.c:18:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:114:
   arch/riscv/include/asm/pgtable-64.h:93:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_MTMASK);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
       ^
   arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:98:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:27:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)
           ^
   In file included from drivers/pci/pci.c:18:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:114:
   arch/riscv/include/asm/pgtable-64.h:93:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_MTMASK);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
       ^
   arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:99:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
            ^
   <inline asm>:28:6: note: instantiated into assembly here
   .org    . - (889b - 888b) + (887b - 886b)
           ^
   In file included from drivers/pci/pci.c:18:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:15:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:114:
   arch/riscv/include/asm/pgtable-64.h:109:2: error: expected assembly-time absolute expression
           ALT_SVPBMT(val, _PAGE_IO);
           ^
   arch/riscv/include/asm/errata_list.h:46:5: note: expanded from macro 'ALT_SVPBMT'
   asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,     \
       ^
   arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
           ^
   arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
           ^
   arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
           ^
   arch/riscv/include/asm/alternative-macros.h:98:3: note: expanded from macro 'ALT_NEW_CONTENT'
           ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
            ^
   <inline asm>:27:6: note: instantiated into assembly here
   .org    . - (887b - 886b) + (889b - 888b)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
