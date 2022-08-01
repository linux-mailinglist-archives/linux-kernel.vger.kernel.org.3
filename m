Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE26586E84
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiHAQ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHAQ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:26:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D1815FFC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659371199; x=1690907199;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=It0H6nm9UIBqNOs9o9jHekTAAKKWAtaD7Oz8hhPieaw=;
  b=Bw0COXbbHHQ8w0/IxF3rNamqmyBm6Ox7yEqkzFcc0YI5nQjVNafRkv92
   vzIxrFEPTCmWoRqh/tEv/045XY04fTS4NSFH3OzO/7yZTYuNke5d+SEmQ
   xUXkgw+BVJk7CjniGycZjQQ2EdXArdVBn6OJMFhU/cQkkBFlcNf5JMFoU
   wvLu3PN+PbPTmygRkeTVTEbIo6o3YdvDtFmhLWFV1k1XYgYP/n7vZ7nHe
   guIhmo4zg41+AkYHAIsGrDWF88OH92By07T5AQozFQiwJosfzfmlTQh5h
   8eZQEzRj66xmjtK7eFXyX60wYf3QYnVUyPwJGNfyd7QXSwm/06IbiZX0P
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290400533"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="290400533"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="670097873"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2022 09:26:37 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIYFZ-000F9d-0R;
        Mon, 01 Aug 2022 16:26:37 +0000
Date:   Tue, 2 Aug 2022 00:26:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: drivers/clocksource/timer-clint.c:82:24: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202208020048.JB7pUSUy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aurelien,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3d7cb6b04c3f3115719235cc6866b10326de34cd
commit: 6df2a016c0c8a3d0933ef33dd192ea6606b115e3 riscv: fix build with binutils 2.38
date:   6 months ago
config: riscv-randconfig-s041-20220801 (https://download.01.org/0day-ci/archive/20220802/202208020048.JB7pUSUy-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6df2a016c0c8a3d0933ef33dd192ea6606b115e3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6df2a016c0c8a3d0933ef33dd192ea6606b115e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ drivers/clocksource/ net/dccp/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/clocksource/timer-clint.c:82:24: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/clocksource/timer-clint.c:82:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/clocksource/timer-clint.c:82:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/clocksource/timer-clint.c:82:24: sparse:     got unsigned int [usertype] *
   drivers/clocksource/timer-clint.c:80:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/clocksource/timer-clint.c:80:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/clocksource/timer-clint.c:80:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/clocksource/timer-clint.c:80:22: sparse:     got unsigned int [usertype] *
   drivers/clocksource/timer-clint.c:237:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct clock_event_device [noderef] __percpu * @@
   drivers/clocksource/timer-clint.c:237:36: sparse:     expected void *
   drivers/clocksource/timer-clint.c:237:36: sparse:     got struct clock_event_device [noderef] __percpu *
--
   net/dccp/proto.c:524:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] service @@     got int [addressable] val @@
   net/dccp/proto.c:524:52: sparse:     expected restricted __be32 const [usertype] service
   net/dccp/proto.c:524:52: sparse:     got int [addressable] val
>> net/dccp/proto.c:595:13: sparse: sparse: restricted __be32 degrades to integer
>> net/dccp/proto.c:595:13: sparse: sparse: restricted __be32 degrades to integer
   net/dccp/proto.c:595:13: sparse: sparse: cast from restricted __be32
   net/dccp/proto.c:707:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] param @@     got int cmsg_type @@
   net/dccp/proto.c:707:57: sparse:     expected restricted __be32 [usertype] param
   net/dccp/proto.c:707:57: sparse:     got int cmsg_type

vim +/__iomem +82 drivers/clocksource/timer-clint.c

2ac6795fcc085e Anup Patel 2020-08-17  68  
2ac6795fcc085e Anup Patel 2020-08-17  69  #ifdef CONFIG_64BIT
2ac6795fcc085e Anup Patel 2020-08-17  70  static u64 notrace clint_get_cycles64(void)
2ac6795fcc085e Anup Patel 2020-08-17  71  {
2ac6795fcc085e Anup Patel 2020-08-17  72  	return clint_get_cycles();
2ac6795fcc085e Anup Patel 2020-08-17  73  }
2ac6795fcc085e Anup Patel 2020-08-17  74  #else /* CONFIG_64BIT */
2ac6795fcc085e Anup Patel 2020-08-17  75  static u64 notrace clint_get_cycles64(void)
2ac6795fcc085e Anup Patel 2020-08-17  76  {
2ac6795fcc085e Anup Patel 2020-08-17  77  	u32 hi, lo;
2ac6795fcc085e Anup Patel 2020-08-17  78  
2ac6795fcc085e Anup Patel 2020-08-17  79  	do {
2ac6795fcc085e Anup Patel 2020-08-17  80  		hi = clint_get_cycles_hi();
2ac6795fcc085e Anup Patel 2020-08-17  81  		lo = clint_get_cycles();
2ac6795fcc085e Anup Patel 2020-08-17 @82  	} while (hi != clint_get_cycles_hi());
2ac6795fcc085e Anup Patel 2020-08-17  83  
2ac6795fcc085e Anup Patel 2020-08-17  84  	return ((u64)hi << 32) | lo;
2ac6795fcc085e Anup Patel 2020-08-17  85  }
2ac6795fcc085e Anup Patel 2020-08-17  86  #endif /* CONFIG_64BIT */
2ac6795fcc085e Anup Patel 2020-08-17  87  

:::::: The code at line 82 was first introduced by commit
:::::: 2ac6795fcc085e8d03649f1bbd0d70aaff612cad clocksource/drivers: Add CLINT timer driver

:::::: TO: Anup Patel <anup.patel@wdc.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
