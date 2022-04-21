Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE93509A60
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386511AbiDUIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386512AbiDUIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:12:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F7F2BF9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650528601; x=1682064601;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P5roUSkFEdYxfkUf4Y/Vo5c1eCrtYNSGsKadG1mq/HI=;
  b=kvQ3aASbkJgEq82I9s8KgKUwvBY3xlRS6A6vX9vBf5ZoFHxf/J8HE6c+
   LLgTqHihQM4YZKuf3CHRCWC+gNJcz+RoGWFHlqiwOBbt5AHiN/q1anDPJ
   VoiBM2qo2zaIKttKezEjbaLtgdAg5Zfq/aQhIXcbSImwFsne+Osko3u+X
   5v4hJnaWflLCDYDUivBvGkuTyDqaHgBgKI7J+UXckK/AQmDdU1BLi2+Bn
   hemltcjacT5PxveUooP+4/rYI/lmtoFt6BDDlgfYVaTr28lab/J6dzyQ7
   YXXIj8+o3dhkY62n+67nRZOnWsn9NWFmHOQbPIw8/SpbgAwORCgkNTrKO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246170782"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="246170782"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 01:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="805409957"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2022 01:09:58 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhRt0-00086a-3Z;
        Thu, 21 Apr 2022 08:09:58 +0000
Date:   Thu, 21 Apr 2022 16:09:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.10.y 644/5321]
 drivers/staging/comedi/drivers/comedi_isadma.c:25:17: error: implicit
 declaration of function 'claim_dma_lock'
Message-ID: <202204211543.9kdHTsCb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
head:   1052f9bce62982023737a95b7ff1ad26a5149af6
commit: 87ae522e467e17a13b796e2cb595f9c3943e4d5e [644/5321] m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
config: m68k-randconfig-r035-20220420 (https://download.01.org/0day-ci/archive/20220421/202204211543.9kdHTsCb-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=87ae522e467e17a13b796e2cb595f9c3943e4d5e
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.10.y
        git checkout 87ae522e467e17a13b796e2cb595f9c3943e4d5e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from drivers/staging/comedi/drivers/comedi_isadma.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:50: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                  ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:143:9: note: in expansion of macro 'BUG_ON'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:143:17: note: in expansion of macro 'virt_addr_valid'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   drivers/staging/comedi/drivers/comedi_isadma.c: In function 'comedi_isadma_program':
>> drivers/staging/comedi/drivers/comedi_isadma.c:25:17: error: implicit declaration of function 'claim_dma_lock' [-Werror=implicit-function-declaration]
      25 |         flags = claim_dma_lock();
         |                 ^~~~~~~~~~~~~~
   drivers/staging/comedi/drivers/comedi_isadma.c:31:9: error: implicit declaration of function 'release_dma_lock'; did you mean 'release_task'? [-Werror=implicit-function-declaration]
      31 |         release_dma_lock(flags);
         |         ^~~~~~~~~~~~~~~~
         |         release_task
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for NEED_MULTIPLE_NODES
   Depends on DISCONTIGMEM || NUMA
   Selected by
   - SINGLE_MEMORY_CHUNK && MMU


vim +/claim_dma_lock +25 drivers/staging/comedi/drivers/comedi_isadma.c

20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  16  
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  17  /**
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  18   * comedi_isadma_program - program and enable an ISA DMA transfer
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  19   * @desc:	the ISA DMA cookie to program and enable
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  20   */
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  21  void comedi_isadma_program(struct comedi_isadma_desc *desc)
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  22  {
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  23  	unsigned long flags;
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  24  
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14 @25  	flags = claim_dma_lock();
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  26  	clear_dma_ff(desc->chan);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  27  	set_dma_mode(desc->chan, desc->mode);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  28  	set_dma_addr(desc->chan, desc->hw_addr);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  29  	set_dma_count(desc->chan, desc->size);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  30  	enable_dma(desc->chan);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  31  	release_dma_lock(flags);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  32  }
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  33  EXPORT_SYMBOL_GPL(comedi_isadma_program);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  34  

:::::: The code at line 25 was first introduced by commit
:::::: 20a1ea7d6ba184a1f6e25e85786738003387cada staging: comedi: comedi_isadma: introduce helper module for ISA DMA

:::::: TO: H Hartley Sweeten <hsweeten@visionengravers.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
