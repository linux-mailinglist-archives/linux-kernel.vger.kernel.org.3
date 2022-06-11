Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCF7547687
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiFKQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiFKQo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:44:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C1F2624
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654965864; x=1686501864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WWax4Pxd/xlLWgN6LOWzJK2g5hNw5C+MhLB7NSAY3jU=;
  b=jSxMl2UDhjJIUropb2LZMxKsFk3RbR8/07UuBzDcj2heFmM65no3dB+l
   LUYU5ToD+/qTODw5ZJOKzLitpXSFQ+J1D52st1QlH4jfbv++Y9KDa3u8g
   tTNIvZuHxfW3X0l0yyPOT2w+CQJcUB3v9znwEjEYcsedi2W1XvX5GbJqw
   NV5nALu042fUf6ENSLJpyi0hjD5GlFYfqqEflbp3kJwMsCuNpues0hcoR
   99PyVkTmzmFx7vKpGpwWuIMO+pR8vohYVzOP4p4AnIwUigDvH/Nl24w6N
   RVsZ0UCBvv2m1hMd0N80blmuXITn6vEJLSZRlh5qQbVoyHFxYXz43o6JJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="275441217"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="275441217"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 09:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="828824240"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jun 2022 09:44:22 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o04Dl-000J5t-MR;
        Sat, 11 Jun 2022 16:44:21 +0000
Date:   Sun, 12 Jun 2022 00:43:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Subject: lib/overflow_kunit.c:644:1: warning: the frame size of 2832 bytes is
 larger than 1024 bytes
Message-ID: <202206120046.YKeKzlVN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0885eacdc81f920c3e0554d5615e69a66504a28d
commit: 617f55e20743fc50c989b498f9dee289eb644cfd lib: overflow: Convert to Kunit
date:   3 months ago
config: powerpc-buildonly-randconfig-r006-20220611 (https://download.01.org/0day-ci/archive/20220612/202206120046.YKeKzlVN-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=617f55e20743fc50c989b498f9dee289eb644cfd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 617f55e20743fc50c989b498f9dee289eb644cfd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/overflow_kunit.c:191:19: warning: 's64_tests' defined but not used [-Wunused-const-variable=]
     191 | DEFINE_TEST_ARRAY(s64) = {
         |                   ^~~
   lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
      24 |         } t ## _tests[]
         |           ^
   lib/overflow_kunit.c:94:19: warning: 'u64_tests' defined but not used [-Wunused-const-variable=]
      94 | DEFINE_TEST_ARRAY(u64) = {
         |                   ^~~
   lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
      24 |         } t ## _tests[]
         |           ^
   lib/overflow_kunit.c: In function 'overflow_size_helpers_test':
>> lib/overflow_kunit.c:644:1: warning: the frame size of 2832 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     644 | }
         | ^
   lib/overflow_kunit.c: In function 'overflow_shift_test':
   lib/overflow_kunit.c:451:1: warning: the frame size of 7232 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     451 | }
         | ^


vim +644 lib/overflow_kunit.c

e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  577  
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  578  	var = 4;
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  579  	check_one_size_helper(20,	size_mul, var++, 5);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  580  	check_one_size_helper(20,	size_mul, 4, var++);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  581  	check_one_size_helper(0,	size_mul, 0, 3);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  582  	check_one_size_helper(0,	size_mul, 3, 0);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  583  	check_one_size_helper(6,	size_mul, 2, 3);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  584  	check_one_size_helper(SIZE_MAX,	size_mul, SIZE_MAX,  1);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  585  	check_one_size_helper(SIZE_MAX,	size_mul, SIZE_MAX,  3);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  586  	check_one_size_helper(SIZE_MAX,	size_mul, SIZE_MAX, -3);
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  587  
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  588  	var = 4;
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  589  	check_one_size_helper(9,	size_add, var++, 5);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  590  	check_one_size_helper(9,	size_add, 4, var++);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  591  	check_one_size_helper(9,	size_add, 9, 0);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  592  	check_one_size_helper(9,	size_add, 0, 9);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  593  	check_one_size_helper(5,	size_add, 2, 3);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  594  	check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  1);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  595  	check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX,  3);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  596  	check_one_size_helper(SIZE_MAX, size_add, SIZE_MAX, -3);
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  597  
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  598  	var = 4;
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  599  	check_one_size_helper(1,	size_sub, var--, 3);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  600  	check_one_size_helper(1,	size_sub, 4, var--);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  601  	check_one_size_helper(1,	size_sub, 3, 2);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  602  	check_one_size_helper(9,	size_sub, 9, 0);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  603  	check_one_size_helper(SIZE_MAX, size_sub, 9, -3);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  604  	check_one_size_helper(SIZE_MAX, size_sub, 0, 9);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  605  	check_one_size_helper(SIZE_MAX, size_sub, 2, 3);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  606  	check_one_size_helper(SIZE_MAX, size_sub, SIZE_MAX,  0);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  607  	check_one_size_helper(SIZE_MAX, size_sub, SIZE_MAX, 10);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  608  	check_one_size_helper(SIZE_MAX, size_sub, 0,  SIZE_MAX);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  609  	check_one_size_helper(SIZE_MAX, size_sub, 14, SIZE_MAX);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  610  	check_one_size_helper(SIZE_MAX - 2, size_sub, SIZE_MAX - 1,  1);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  611  	check_one_size_helper(SIZE_MAX - 4, size_sub, SIZE_MAX - 1,  3);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  612  	check_one_size_helper(1,		size_sub, SIZE_MAX - 1, -3);
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  613  
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  614  	var = 4;
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  615  	check_one_size_helper(4 * sizeof(*obj->data),
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  616  			      flex_array_size, obj, data, var++);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  617  	check_one_size_helper(5 * sizeof(*obj->data),
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  618  			      flex_array_size, obj, data, var++);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  619  	check_one_size_helper(0, flex_array_size, obj, data, 0 + unconst);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  620  	check_one_size_helper(sizeof(*obj->data),
230f6fa2c1db6a lib/test_overflow.c  Kees Cook 2022-02-09  621  			      flex_array_size, obj, data, 1 + unconst);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  622  	check_one_size_helper(7 * sizeof(*obj->data),
230f6fa2c1db6a lib/test_overflow.c  Kees Cook 2022-02-09  623  			      flex_array_size, obj, data, 7 + unconst);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  624  	check_one_size_helper(SIZE_MAX,
230f6fa2c1db6a lib/test_overflow.c  Kees Cook 2022-02-09  625  			      flex_array_size, obj, data, -1 + unconst);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  626  	check_one_size_helper(SIZE_MAX,
230f6fa2c1db6a lib/test_overflow.c  Kees Cook 2022-02-09  627  			      flex_array_size, obj, data, SIZE_MAX - 4 + unconst);
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  628  
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  629  	var = 4;
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  630  	check_one_size_helper(sizeof(*obj) + (4 * sizeof(*obj->data)),
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  631  			      struct_size, obj, data, var++);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  632  	check_one_size_helper(sizeof(*obj) + (5 * sizeof(*obj->data)),
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  633  			      struct_size, obj, data, var++);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  634  	check_one_size_helper(sizeof(*obj), struct_size, obj, data, 0 + unconst);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  635  	check_one_size_helper(sizeof(*obj) + sizeof(*obj->data),
230f6fa2c1db6a lib/test_overflow.c  Kees Cook 2022-02-09  636  			      struct_size, obj, data, 1 + unconst);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  637  	check_one_size_helper(SIZE_MAX,
230f6fa2c1db6a lib/test_overflow.c  Kees Cook 2022-02-09  638  			      struct_size, obj, data, -3 + unconst);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  639  	check_one_size_helper(SIZE_MAX,
230f6fa2c1db6a lib/test_overflow.c  Kees Cook 2022-02-09  640  			      struct_size, obj, data, SIZE_MAX - 3 + unconst);
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  641  
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  642  	kunit_info(test, "%d overflow size helper tests finished\n", count);
617f55e20743fc lib/overflow_kunit.c Kees Cook 2022-02-16  643  #undef check_one_size_helper
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18 @644  }
e1be43d9b5d0d1 lib/test_overflow.c  Kees Cook 2021-09-18  645  

:::::: The code at line 644 was first introduced by commit
:::::: e1be43d9b5d0d1310dbd90185a8e5c7145dde40f overflow: Implement size_t saturating arithmetic helpers

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
