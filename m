Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253E75AA632
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiIBDRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiIBDQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:16:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAC07EFEE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662088613; x=1693624613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PzY+4y2w6s54YP2t8HhQriB1UCF30mNKpCM7R/JOZcQ=;
  b=C1YZiHadyclTwIt3nQDGN7K18q6GMx834M0+912vrMBBxJcfGIKc66Ru
   Gk/FI3iFiW8mBa0m707bSaCZPFDYwreRpVJuyMs6SXGVEzCmTwGa44VGK
   tUKkNUOP6CSG4NDpUoRBj1RipqcCxpQsfwRORAH95FLXEv4h5pdmCxdRb
   eckyH6qmqjXOpXSlIjLSC3cX/Mp6/06biv+pFwwurbHXEKqLVDrcgvg8J
   8NC+uaQ0Gbz8XCZIa8NDYRHIm8AQ/Uvsvw+h0gCarqA6p3CyCkR2UjS9n
   BDRVLQpGqW6hdnNodn34uwy3bRMMASnNwzpSTqfOpSeZJXkcnU263Zru4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="322037848"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="322037848"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 20:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="563808928"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2022 20:16:50 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTxAn-00004B-1F;
        Fri, 02 Sep 2022 03:16:49 +0000
Date:   Fri, 2 Sep 2022 11:16:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-kernel@vger.kernel.org,
        syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com,
        Ayushman Dutta <ayudutta@amazon.com>
Subject: Re: [PATCH v1] seccomp: Release filter when copy_process() fails.
Message-ID: <202209021045.YbjuMbic-lkp@intel.com>
References: <20220822204436.26631-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822204436.26631-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuniyuki,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on linus/master v6.0-rc3]
[cannot apply to kees/for-next/seccomp next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/seccomp-Release-filter-when-copy_process-fails/20220823-044710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: s390-buildonly-randconfig-r006-20220901 (https://download.01.org/0day-ci/archive/20220902/202209021045.YbjuMbic-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/ea0fdd2f2e9a09bd5428bd59e81bac66e949f578
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kuniyuki-Iwashima/seccomp-Release-filter-when-copy_process-fails/20220823-044710
        git checkout ea0fdd2f2e9a09bd5428bd59e81bac66e949f578
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:79:
   In file included from include/linux/tty.h:12:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from kernel/fork.c:79:
   In file included from include/linux/tty.h:12:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from kernel/fork.c:79:
   In file included from include/linux/tty.h:12:
   In file included from include/linux/tty_port.h:5:
   In file included from include/linux/kfifo.h:42:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> kernel/fork.c:540:28: error: no member named 'filter' in 'struct seccomp'
           WARN_ON_ONCE(tsk->seccomp.filter);
                        ~~~~~~~~~~~~ ^
   include/asm-generic/bug.h:104:25: note: expanded from macro 'WARN_ON_ONCE'
           int __ret_warn_on = !!(condition);                      \
                                  ^~~~~~~~~
   kernel/fork.c:854:20: warning: no previous prototype for function 'arch_task_cache_init' [-Wmissing-prototypes]
   void __init __weak arch_task_cache_init(void) { }
                      ^
   kernel/fork.c:854:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_task_cache_init(void) { }
   ^
   static 
   13 warnings and 1 error generated.


vim +540 kernel/fork.c

   537	
   538	void free_task(struct task_struct *tsk)
   539	{
 > 540		WARN_ON_ONCE(tsk->seccomp.filter);
   541		release_user_cpus_ptr(tsk);
   542		scs_release(tsk);
   543	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
