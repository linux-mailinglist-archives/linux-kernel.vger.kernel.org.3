Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A292E50ACB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442918AbiDVAW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442896AbiDVAWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:22:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05574617E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650586770; x=1682122770;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4J/5UKagLoRW1miQ6Kgk2SRBFCed7jhYgAAQPoIBM4U=;
  b=jgo12cvO26Wm7X0qC0nqwTo2x+5jPYtrsoddtDDQGOxHgiAuLMR/0mK3
   TlnUmmxR5Gpa8y3PZ8rBuWw6oQ82e315bTreRrCnOcyz41EyVUCq8v3Xv
   KGWCynTuxxHK6uDQP752IGYmdHla4i1bAT84DKeGS/zg/GhleoCddE9SU
   vXFhhkKpMJggda+4x/lvqLCu6qN21pVaEsfx3cEaUDiqX4iGbhhvkEhI+
   9h7jqvrcx2owoAojbNq6gbLJvLe0/nfcTn2R5CJJkpG3nY7x2hkPQeW4K
   kUpUJdV4dCQyopG0XRiRAwLScG8DJ9rDraAP4jrKXnlYDXtyoeOyap9Ie
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="324970332"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="324970332"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="671443819"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2022 17:19:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhh1D-00090A-TD;
        Fri, 22 Apr 2022 00:19:27 +0000
Date:   Fri, 22 Apr 2022 08:18:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [hnaz-mm:master 1/291] WARNING: modpost: vmlinux.o(.data+0x25c2ac):
 Section mismatch in reference from the variable ad7418_driver to the
 function .init.text:set_reset_devices()
Message-ID: <202204220814.GIektaty-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   ba42854fa9997614e0ffdbc35b082df3ba6e59da
commit: c94c865a5858f9ddb424d9b57b33d1664a986044 [1/291] origin
config: riscv-randconfig-r015-20220420 (https://download.01.org/0day-ci/archive/20220422/202204220814.GIektaty-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/hnaz/linux-mm/commit/c94c865a5858f9ddb424d9b57b33d1664a986044
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout c94c865a5858f9ddb424d9b57b33d1664a986044
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.data+0x25c2ac): Section mismatch in reference from the variable ad7418_driver to the function .init.text:set_reset_devices()
The variable ad7418_driver references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:


Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x126d798): Section mismatch in reference from the function ir_raw_get_allowed_protocols() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x1505c8e): Section mismatch in reference from the function tb_debugfs_exit() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x2356bc): Section mismatch in reference from the variable tuners to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x25c43c): Section mismatch in reference from the variable ad7417_attrs to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x25c444): Section mismatch in reference from the variable ad7417_attrs to the variable .meminit.text:.LBB9_3
<< WARNING: modpost: vmlinux.o(.data+0x25c454): Section mismatch in reference from the variable sensor_dev_attr_in1_input to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x25c474): Section mismatch in reference from the variable sensor_dev_attr_in2_input to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x25c494): Section mismatch in reference from the variable sensor_dev_attr_in3_input to the function .meminit.text:init_reserve_notifier()
<< WARNING: modpost: vmlinux.o(.data+0x25c4b4): Section mismatch in reference from the variable sensor_dev_attr_in4_input to the variable .meminit.text:.LBB9_4
<< WARNING: modpost: vmlinux.o(.data+0x25c4c8): Section mismatch in reference from the variable sensor_dev_attr_in4_input to the function .meminit.text:init_reserve_notifier()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
