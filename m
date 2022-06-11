Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC19954765B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239382AbiFKQNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiFKQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:13:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E8E39815
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654964002; x=1686500002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ML5pdHk40QEa1TxA5mVW1n6giskH9h6L4ibWC8gVMBA=;
  b=ZVwpJqfFbFFj4GneYSLSs8et1ULvlcbRC3H4pjmnhn98w6hog3G6pW30
   zg6vUVszd2C1lgabsgRgha4A32Y4SGr3+mrK3TLzCrQzbP9AaI8ZXvO3X
   4bvonKGpNtXiJOHjXGEcEyAbuT42pwrfFAP6JXNh/x3MOkafUfKLfB6KD
   yfvF4Ahk89922JO8FpicgF4NLazLotj8yfYLRQO0SLwWoV9N4NYGX7WEs
   iUkGE423y0vHm4pt3RXiOXcZaKP3N3rSfHmGSywLWBv9TcVP+6l6M4Nuf
   5dO5w/v2atZNMG6+e1mZCzrqx5KDISS43zZ6Ov/gYC7qYMQjA9kTnf3Ut
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="258339400"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="258339400"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 09:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="567290238"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2022 09:13:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o03jk-000J3m-D5;
        Sat, 11 Jun 2022 16:13:20 +0000
Date:   Sun, 12 Jun 2022 00:12:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm/mm/copypage-feroceon.c:65:6: warning: no previous prototype
 for 'feroceon_copy_user_highpage'
Message-ID: <202206120025.LnzrdX8M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0885eacdc81f920c3e0554d5615e69a66504a28d
commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
date:   8 days ago
config: arm-randconfig-r004-20220611 (https://download.01.org/0day-ci/archive/20220612/202206120025.LnzrdX8M-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7036440eab3e2d47a775d4616909f8235488d714
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7036440eab3e2d47a775d4616909f8235488d714
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-lpc32xx/ arch/arm/mach-versatile/ arch/arm/mm/ drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm/mm/copypage-feroceon.c:65:6: warning: no previous prototype for 'feroceon_copy_user_highpage' [-Wmissing-prototypes]
      65 | void feroceon_copy_user_highpage(struct page *to, struct page *from,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mm/copypage-feroceon.c:78:6: warning: no previous prototype for 'feroceon_clear_user_highpage' [-Wmissing-prototypes]
      78 | void feroceon_clear_user_highpage(struct page *page, unsigned long vaddr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> arch/arm/mach-lpc32xx/serial.c:63:6: warning: no previous prototype for 'lpc32xx_loopback_set' [-Wmissing-prototypes]
      63 | void lpc32xx_loopback_set(resource_size_t mapbase, int state)
         |      ^~~~~~~~~~~~~~~~~~~~
--
>> arch/arm/mach-versatile/versatile.c:56:14: warning: no previous prototype for 'mmc_status' [-Wmissing-prototypes]
      56 | unsigned int mmc_status(struct device *dev)
         |              ^~~~~~~~~~
--
>> drivers/cpufreq/davinci-cpufreq.c:151:12: warning: no previous prototype for 'davinci_cpufreq_init' [-Wmissing-prototypes]
     151 | int __init davinci_cpufreq_init(void)
         |            ^~~~~~~~~~~~~~~~~~~~


vim +/feroceon_copy_user_highpage +65 arch/arm/mm/copypage-feroceon.c

d73e60b7144a86 Russell King  2008-10-31   64  
063b0a4207e43a Russell King  2008-10-31  @65  void feroceon_copy_user_highpage(struct page *to, struct page *from,
f00a75c094c340 Russell King  2009-10-05   66  	unsigned long vaddr, struct vm_area_struct *vma)
063b0a4207e43a Russell King  2008-10-31   67  {
063b0a4207e43a Russell King  2008-10-31   68  	void *kto, *kfrom;
063b0a4207e43a Russell King  2008-10-31   69  
5472e862de2bc4 Cong Wang     2011-11-25   70  	kto = kmap_atomic(to);
5472e862de2bc4 Cong Wang     2011-11-25   71  	kfrom = kmap_atomic(from);
2725898fc9bb21 Russell King  2009-10-05   72  	flush_cache_page(vma, vaddr, page_to_pfn(from));
063b0a4207e43a Russell King  2008-10-31   73  	feroceon_copy_user_page(kto, kfrom);
5472e862de2bc4 Cong Wang     2011-11-25   74  	kunmap_atomic(kfrom);
5472e862de2bc4 Cong Wang     2011-11-25   75  	kunmap_atomic(kto);
063b0a4207e43a Russell King  2008-10-31   76  }
063b0a4207e43a Russell King  2008-10-31   77  
303c6443659bc1 Russell King  2008-10-31  @78  void feroceon_clear_user_highpage(struct page *page, unsigned long vaddr)
d73e60b7144a86 Russell King  2008-10-31   79  {
5472e862de2bc4 Cong Wang     2011-11-25   80  	void *ptr, *kaddr = kmap_atomic(page);
43ae286b7d4d8c Nicolas Pitre 2008-11-04   81  	asm volatile ("\
43ae286b7d4d8c Nicolas Pitre 2008-11-04   82  	mov	r1, %2				\n\
d73e60b7144a86 Russell King  2008-10-31   83  	mov	r2, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   84  	mov	r3, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   85  	mov	r4, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   86  	mov	r5, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   87  	mov	r6, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   88  	mov	r7, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   89  	mov	ip, #0				\n\
d73e60b7144a86 Russell King  2008-10-31   90  	mov	lr, #0				\n\
303c6443659bc1 Russell King  2008-10-31   91  1:	stmia	%0, {r2-r7, ip, lr}		\n\
d73e60b7144a86 Russell King  2008-10-31   92  	subs	r1, r1, #1			\n\
303c6443659bc1 Russell King  2008-10-31   93  	mcr	p15, 0, %0, c7, c14, 1		@ clean and invalidate D line\n\
43ae286b7d4d8c Nicolas Pitre 2008-11-04   94  	add	%0, %0, #32			\n\
d73e60b7144a86 Russell King  2008-10-31   95  	bne	1b				\n\
303c6443659bc1 Russell King  2008-10-31   96  	mcr	p15, 0, r1, c7, c10, 4		@ drain WB"
43ae286b7d4d8c Nicolas Pitre 2008-11-04   97  	: "=r" (ptr)
43ae286b7d4d8c Nicolas Pitre 2008-11-04   98  	: "0" (kaddr), "I" (PAGE_SIZE / 32)
303c6443659bc1 Russell King  2008-10-31   99  	: "r1", "r2", "r3", "r4", "r5", "r6", "r7", "ip", "lr");
5472e862de2bc4 Cong Wang     2011-11-25  100  	kunmap_atomic(kaddr);
d73e60b7144a86 Russell King  2008-10-31  101  }
d73e60b7144a86 Russell King  2008-10-31  102  

:::::: The code at line 65 was first introduced by commit
:::::: 063b0a4207e43acbeff3d4b09f43e750e0212b48 [ARM] copypage: provide our own copy_user_highpage()

:::::: TO: Russell King <rmk@dyn-67.arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
