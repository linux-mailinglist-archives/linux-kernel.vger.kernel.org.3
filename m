Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9ED51835E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiECLlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiECLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:41:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9381B34BA7
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651577862; x=1683113862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rj6k8i4NSJE8pME/0W61Emogrx7B5WO8hPAZJn6IJso=;
  b=ZbiUb1+pDrfV8fBwetQdgqUdzsfbG/AISqCu8GNn+XHSuJXR4FX51u8g
   rklrQC3ZuELQhAAkYnMMaB2IspolnygEG0KwtvVqz8+qWGCasdSzNfm1+
   o4fz+8jiWaKPNKwXBb87KDBTnXcIHUIQXZowYwwrvZBHfo4ywN+Ac5T8C
   cGxgUNCdph6E/Ow0MkR/S9jhaW3RBYb3GjFBwrZPhf0OvSUSUX8c88I9W
   WiTGTbOhryOnkanzvL5nk9++u54xVC7f1weEXPWc9+dw1W9mh8AhVrdhQ
   SBeHLn/0WH0QtLksKifABClbhBD6KKnj3zq64aDk1de4BoOCW5SYHRNJb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="266299958"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="266299958"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 04:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="567603093"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 May 2022 04:37:41 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlqqa-000AQT-J8;
        Tue, 03 May 2022 11:37:40 +0000
Date:   Tue, 3 May 2022 19:37:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:flexcpy/next-20220502 5/33]
 include/linux/fortify-string.h:46:33: warning: '__builtin_memcpy' pointer
 overflow between offset 29 and size [2147483648, 4294967295]
Message-ID: <202205031926.FVP7epJM-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git flexcpy/next-20220502
head:   4edcb4b48dd527edbbdd660c94d497723b3c69c0
commit: b95aed127f619370dfa5e2b94c387cc805aa8884 [5/33] fortify: Add run-time WARN for cross-field memcpy()
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220503/202205031926.FVP7epJM-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=b95aed127f619370dfa5e2b94c387cc805aa8884
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees flexcpy/next-20220502
        git checkout b95aed127f619370dfa5e2b94c387cc805aa8884
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/chelsio/cxgb4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/delay.h:23,
                    from drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:35:
   drivers/net/ethernet/chelsio/cxgb4/t4_hw.c: In function 't4_get_raw_vpd_params':
>> include/linux/fortify-string.h:46:33: warning: '__builtin_memcpy' pointer overflow between offset 29 and size [2147483648, 4294967295] [-Warray-bounds]
      46 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:388:9: note: in expansion of macro '__underlying_memcpy'
     388 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:433:26: note: in expansion of macro '__fortify_memcpy_chk'
     433 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:2796:9: note: in expansion of macro 'memcpy'
    2796 |         memcpy(p->id, vpd + id, min_t(int, id_len, ID_LEN));
         |         ^~~~~~
   include/linux/fortify-string.h:46:33: warning: '__builtin_memcpy' pointer overflow between offset 0 and size [2147483648, 4294967295] [-Warray-bounds]
      46 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:388:9: note: in expansion of macro '__underlying_memcpy'
     388 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:433:26: note: in expansion of macro '__fortify_memcpy_chk'
     433 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:2798:9: note: in expansion of macro 'memcpy'
    2798 |         memcpy(p->sn, vpd + sn, min_t(int, sn_len, SERNUM_LEN));
         |         ^~~~~~


vim +/__builtin_memcpy +46 include/linux/fortify-string.h

3009f891bb9f32 Kees Cook      2021-08-02  31  
a28a6e860c6cf2 Francis Laniel 2021-02-25  32  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
a28a6e860c6cf2 Francis Laniel 2021-02-25  33  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
a28a6e860c6cf2 Francis Laniel 2021-02-25  34  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
a28a6e860c6cf2 Francis Laniel 2021-02-25  35  extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  36  extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
a28a6e860c6cf2 Francis Laniel 2021-02-25  37  extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
a28a6e860c6cf2 Francis Laniel 2021-02-25  38  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  39  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  40  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
a28a6e860c6cf2 Francis Laniel 2021-02-25  41  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  42  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  43  #else
a28a6e860c6cf2 Francis Laniel 2021-02-25  44  #define __underlying_memchr	__builtin_memchr
a28a6e860c6cf2 Francis Laniel 2021-02-25  45  #define __underlying_memcmp	__builtin_memcmp
a28a6e860c6cf2 Francis Laniel 2021-02-25 @46  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  47  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf2 Francis Laniel 2021-02-25  48  #define __underlying_memset	__builtin_memset
a28a6e860c6cf2 Francis Laniel 2021-02-25  49  #define __underlying_strcat	__builtin_strcat
a28a6e860c6cf2 Francis Laniel 2021-02-25  50  #define __underlying_strcpy	__builtin_strcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  51  #define __underlying_strlen	__builtin_strlen
a28a6e860c6cf2 Francis Laniel 2021-02-25  52  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf2 Francis Laniel 2021-02-25  53  #define __underlying_strncpy	__builtin_strncpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  54  #endif
a28a6e860c6cf2 Francis Laniel 2021-02-25  55  

:::::: The code at line 46 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
