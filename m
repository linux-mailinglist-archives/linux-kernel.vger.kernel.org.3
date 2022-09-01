Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCED85AA0D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiIAUVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiIAUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:20:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC6952838
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662063656; x=1693599656;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RIdw1o8lMeQiPYD/hq6j4185lloDV+aPMtOEshs7Rzg=;
  b=HElRujAne/Ypu02orXZPXyQK2xL61X2dK5zXA4bHWENmDdZLkY+Jm6r7
   pdPicJJrNehKTHiSw2VJ4+rR3XSem2JQsKOxsx8T5yZdZPSrkcbAHM3Ei
   fNhTCiADg1XsPebxXriNKXcoDGsOrHsM/J5/X+noxnBJUxLrH3grMfo+z
   7jL42BAqJhXlBw2pgZockKZzD0tilvvEgRWV8RGOdjRXKd/6K1tt11U5o
   KKkkeHl2CYzMUJmkvUyZ/VqRvkGGiuDsAZpDa2UshAHA3mNCuby/jbXdL
   Lbtmmx+gK1FKz8WhfyPyL6wG/CFl2G2gBtoNSPKRRl07Jdz4ZujAJlV9y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="276219418"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="276219418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:20:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="754977544"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 01 Sep 2022 13:20:54 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTqgI-0000jx-16;
        Thu, 01 Sep 2022 20:20:54 +0000
Date:   Fri, 2 Sep 2022 04:20:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted
 __le32
Message-ID: <202209020435.vmFRI5KR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42e66b1cc3a070671001f8a1e933a80818a192bf
commit: 2255411d1d0f0661d1e5acd5f6edf4e6652a345a powerpc/44x: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')
date:   5 weeks ago
config: powerpc-randconfig-s053-20220901 (https://download.01.org/0day-ci/archive/20220902/202209020435.vmFRI5KR-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2255411d1d0f0661d1e5acd5f6edf4e6652a345a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2255411d1d0f0661d1e5acd5f6edf4e6652a345a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/dma/ppc4xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
>> drivers/dma/ppc4xx/adma.c:543:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sg1l @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:543:35: sparse:     expected unsigned int [usertype] sg1l
   drivers/dma/ppc4xx/adma.c:543:35: sparse:     got restricted __le32 [usertype]
>> drivers/dma/ppc4xx/adma.c:544:35: sparse: sparse: invalid assignment: |=
>> drivers/dma/ppc4xx/adma.c:544:35: sparse:    left side has type unsigned int
>> drivers/dma/ppc4xx/adma.c:544:35: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:589:23: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:589:23: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:589:23: sparse:    right side has type restricted __le32
>> drivers/dma/ppc4xx/adma.c:627:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:627:23: sparse:     expected unsigned int [usertype]
   drivers/dma/ppc4xx/adma.c:627:23: sparse:     got restricted __le32 [usertype]
   drivers/dma/ppc4xx/adma.c:628:23: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:628:23: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:628:23: sparse:    right side has type restricted __le32
>> drivers/dma/ppc4xx/adma.c:653:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cnt @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:653:34: sparse:     expected unsigned int [usertype] cnt
   drivers/dma/ppc4xx/adma.c:653:34: sparse:     got restricted __le32 [usertype]
>> drivers/dma/ppc4xx/adma.c:686:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:686:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:686:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:687:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:687:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:687:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:689:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:689:39: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:689:39: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:734:17: sparse: sparse: Using plain integer as NULL pointer
>> drivers/dma/ppc4xx/adma.c:1185:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1185:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1185:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1186:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1186:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1186:34: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1188:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1188:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1188:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
>> drivers/dma/ppc4xx/adma.c:1189:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1189:36: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1189:36: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1136:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1136:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1136:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1145:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1145:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1145:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1155:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1155:49: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1155:49: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1157:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1157:38: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1157:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:909:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:909:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:909:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:910:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:910:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:910:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:927:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:972:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:972:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:972:32: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:977:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:977:40: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:977:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:982:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:982:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:982:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:983:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:983:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:983:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:984:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:984:34: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:984:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:991:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:991:55: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:991:55: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:993:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:993:51: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:993:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:997:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:997:46: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:997:46: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1006:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1006:35: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1006:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1025:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1025:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1025:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1029:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1029:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1029:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1029:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1029:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1029:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1030:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1030:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1030:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1030:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1030:60: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1030:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1036:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1036:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1036:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1037:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1037:37: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1037:37: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1051:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1051:48: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1051:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1053:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1053:25: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1053:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1060:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1060:41: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1060:41: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1062:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1062:39: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1062:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1063:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1063:25: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1063:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1064:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1064:33: sparse:     expected void const [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1064:33: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1065:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1065:22: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1065:22: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1078:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1078:48: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1078:48: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1088:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1088:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1088:26: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1208:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1208:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1208:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1212:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1212:30: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/ppc4xx/adma.c:1212:30: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:2775:62: sparse: sparse: Using plain integer as NULL pointer
>> drivers/dma/ppc4xx/adma.c:4091:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *regs @@     got void [noderef] __iomem * @@
   drivers/dma/ppc4xx/adma.c:4091:14: sparse:     expected void *regs
   drivers/dma/ppc4xx/adma.c:4091:14: sparse:     got void [noderef] __iomem *
>> drivers/dma/ppc4xx/adma.c:4099:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs [noderef] __iomem *xor_reg @@     got void *regs @@
   drivers/dma/ppc4xx/adma.c:4099:31: sparse:     expected struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:4099:31: sparse:     got void *regs
>> drivers/dma/ppc4xx/adma.c:4106:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs [noderef] __iomem *dma_reg @@     got void *regs @@
   drivers/dma/ppc4xx/adma.c:4106:31: sparse:     expected struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:4106:31: sparse:     got void *regs

vim +140 drivers/dma/ppc4xx/adma.c

12458ea06efd7b Anatolij Gustschin 2009-12-11  128  
12458ea06efd7b Anatolij Gustschin 2009-12-11  129  static void print_cb(struct ppc440spe_adma_chan *chan, void *block)
12458ea06efd7b Anatolij Gustschin 2009-12-11  130  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  131  	struct dma_cdb *cdb;
12458ea06efd7b Anatolij Gustschin 2009-12-11  132  	struct xor_cb *cb;
12458ea06efd7b Anatolij Gustschin 2009-12-11  133  	int i;
12458ea06efd7b Anatolij Gustschin 2009-12-11  134  
12458ea06efd7b Anatolij Gustschin 2009-12-11  135  	switch (chan->device->id) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  136  	case 0:
12458ea06efd7b Anatolij Gustschin 2009-12-11  137  	case 1:
12458ea06efd7b Anatolij Gustschin 2009-12-11  138  		cdb = block;
12458ea06efd7b Anatolij Gustschin 2009-12-11  139  
12458ea06efd7b Anatolij Gustschin 2009-12-11 @140  		pr_debug("CDB at %p [%d]:\n"
12458ea06efd7b Anatolij Gustschin 2009-12-11  141  			"\t attr 0x%02x opc 0x%02x cnt 0x%08x\n"
12458ea06efd7b Anatolij Gustschin 2009-12-11  142  			"\t sg1u 0x%08x sg1l 0x%08x\n"
12458ea06efd7b Anatolij Gustschin 2009-12-11  143  			"\t sg2u 0x%08x sg2l 0x%08x\n"
12458ea06efd7b Anatolij Gustschin 2009-12-11  144  			"\t sg3u 0x%08x sg3l 0x%08x\n",
12458ea06efd7b Anatolij Gustschin 2009-12-11  145  			cdb, chan->device->id,
12458ea06efd7b Anatolij Gustschin 2009-12-11  146  			cdb->attr, cdb->opc, le32_to_cpu(cdb->cnt),
12458ea06efd7b Anatolij Gustschin 2009-12-11  147  			le32_to_cpu(cdb->sg1u), le32_to_cpu(cdb->sg1l),
12458ea06efd7b Anatolij Gustschin 2009-12-11  148  			le32_to_cpu(cdb->sg2u), le32_to_cpu(cdb->sg2l),
12458ea06efd7b Anatolij Gustschin 2009-12-11  149  			le32_to_cpu(cdb->sg3u), le32_to_cpu(cdb->sg3l)
12458ea06efd7b Anatolij Gustschin 2009-12-11  150  		);
12458ea06efd7b Anatolij Gustschin 2009-12-11  151  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  152  	case 2:
12458ea06efd7b Anatolij Gustschin 2009-12-11  153  		cb = block;
12458ea06efd7b Anatolij Gustschin 2009-12-11  154  
12458ea06efd7b Anatolij Gustschin 2009-12-11  155  		pr_debug("CB at %p [%d]:\n"
12458ea06efd7b Anatolij Gustschin 2009-12-11  156  			"\t cbc 0x%08x cbbc 0x%08x cbs 0x%08x\n"
12458ea06efd7b Anatolij Gustschin 2009-12-11  157  			"\t cbtah 0x%08x cbtal 0x%08x\n"
12458ea06efd7b Anatolij Gustschin 2009-12-11  158  			"\t cblah 0x%08x cblal 0x%08x\n",
12458ea06efd7b Anatolij Gustschin 2009-12-11  159  			cb, chan->device->id,
12458ea06efd7b Anatolij Gustschin 2009-12-11  160  			cb->cbc, cb->cbbc, cb->cbs,
12458ea06efd7b Anatolij Gustschin 2009-12-11  161  			cb->cbtah, cb->cbtal,
12458ea06efd7b Anatolij Gustschin 2009-12-11  162  			cb->cblah, cb->cblal);
12458ea06efd7b Anatolij Gustschin 2009-12-11  163  		for (i = 0; i < 16; i++) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  164  			if (i && !cb->ops[i].h && !cb->ops[i].l)
12458ea06efd7b Anatolij Gustschin 2009-12-11  165  				continue;
12458ea06efd7b Anatolij Gustschin 2009-12-11  166  			pr_debug("\t ops[%2d]: h 0x%08x l 0x%08x\n",
12458ea06efd7b Anatolij Gustschin 2009-12-11  167  				i, cb->ops[i].h, cb->ops[i].l);
12458ea06efd7b Anatolij Gustschin 2009-12-11  168  		}
12458ea06efd7b Anatolij Gustschin 2009-12-11  169  		break;
12458ea06efd7b Anatolij Gustschin 2009-12-11  170  	}
12458ea06efd7b Anatolij Gustschin 2009-12-11  171  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  172  

:::::: The code at line 140 was first introduced by commit
:::::: 12458ea06efd7b44281e68fe59c950ec7d59c649 ppc440spe-adma: adds updated ppc440spe adma driver

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
