Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0092D4D18E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbiCHNRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiCHNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:17:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E0C37A10
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646745386; x=1678281386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XnpNx2zkvClD9LnMuEsL+qDCabOhJHkgitdVTK2dYd8=;
  b=Wh8vo/wjYPXNncKRr7VrVRKhh6ey90HmAwFdaWVRg2GgQdwMohfje2EY
   QO2uZYrjfQ+CH3+l6iGvjJt4uA+xKv7H3bYlQ9LOJ0IhmEgCxLWHCV4cO
   8Af1Xzo4XXEYT3X7BQ0kat3OrAKtC2fil83mzZ01lD4/0OoFPtr/6DO91
   NZxtIixZmKpIJJlN+GEB9QGp3oHJGJJkpNg3x0RZjPWvyVJ9+pcbLNAKS
   E1gS553JMA57IRtChFWMBBe9M1dfsmwI4Pr2JFkerOMjqv57lBQh6rM4I
   dhZjVh3EbiJChKX89SRQqQIPt5bBSI2RxHIMeDqALTIBXt4SYVSjcYKO1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="279392768"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="279392768"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 05:16:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="711531449"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2022 05:16:24 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRZhP-0001R7-Ns; Tue, 08 Mar 2022 13:16:23 +0000
Date:   Tue, 8 Mar 2022 21:15:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 33/41]
 include/linux/fortify-string.h:47:30: warning: '__builtin_strncat' output
 truncated before terminating nul copying as many bytes from a string as its
 length
Message-ID: <202203082112.Iu7tvFl4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/ftrace/core
head:   7ab34c09507b05b91207c596490e3b6c935b7b97
commit: 9f8e5aee93ed2482638d577a56806b455084b595 [33/41] tracing: Fix allocation of last_cmd in last_cmd_set()
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220308/202203082112.Iu7tvFl4-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/9f8e5aee93ed2482638d577a56806b455084b595
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/ftrace/core
        git checkout 9f8e5aee93ed2482638d577a56806b455084b595
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from kernel/trace/trace_events_hist.c:8:
   In function 'strncat',
       inlined from 'last_cmd_set' at kernel/trace/trace_events_hist.c:760:2,
       inlined from 'event_hist_trigger_parse' at kernel/trace/trace_events_hist.c:6191:3:
>> include/linux/fortify-string.h:47:30: warning: '__builtin_strncat' output truncated before terminating nul copying as many bytes from a string as its length [-Wstringop-truncation]
      47 | #define __underlying_strncat __builtin_strncat
         |                              ^
   include/linux/fortify-string.h:191:10: note: in expansion of macro '__underlying_strncat'
     191 |   return __underlying_strncat(p, q, count);
         |          ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace_events_hist.c: In function 'event_hist_trigger_parse':
   include/linux/fortify-string.h:46:29: note: length computed here
      46 | #define __underlying_strlen __builtin_strlen
         |                             ^
   include/linux/fortify-string.h:102:10: note: in expansion of macro '__underlying_strlen'
     102 |   return __underlying_strlen(p);
         |          ^~~~~~~~~~~~~~~~~~~


vim +/__builtin_strncat +47 include/linux/fortify-string.h

3009f891bb9f32 Kees Cook      2021-08-02  26  
a28a6e860c6cf2 Francis Laniel 2021-02-25  27  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
a28a6e860c6cf2 Francis Laniel 2021-02-25  28  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
a28a6e860c6cf2 Francis Laniel 2021-02-25  29  extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
a28a6e860c6cf2 Francis Laniel 2021-02-25  30  extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  31  extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
a28a6e860c6cf2 Francis Laniel 2021-02-25  32  extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
a28a6e860c6cf2 Francis Laniel 2021-02-25  33  extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  34  extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  35  extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
a28a6e860c6cf2 Francis Laniel 2021-02-25  36  extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
a28a6e860c6cf2 Francis Laniel 2021-02-25  37  extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
a28a6e860c6cf2 Francis Laniel 2021-02-25  38  #else
a28a6e860c6cf2 Francis Laniel 2021-02-25  39  #define __underlying_memchr	__builtin_memchr
a28a6e860c6cf2 Francis Laniel 2021-02-25  40  #define __underlying_memcmp	__builtin_memcmp
a28a6e860c6cf2 Francis Laniel 2021-02-25  41  #define __underlying_memcpy	__builtin_memcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  42  #define __underlying_memmove	__builtin_memmove
a28a6e860c6cf2 Francis Laniel 2021-02-25  43  #define __underlying_memset	__builtin_memset
a28a6e860c6cf2 Francis Laniel 2021-02-25  44  #define __underlying_strcat	__builtin_strcat
a28a6e860c6cf2 Francis Laniel 2021-02-25  45  #define __underlying_strcpy	__builtin_strcpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  46  #define __underlying_strlen	__builtin_strlen
a28a6e860c6cf2 Francis Laniel 2021-02-25 @47  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf2 Francis Laniel 2021-02-25  48  #define __underlying_strncpy	__builtin_strncpy
a28a6e860c6cf2 Francis Laniel 2021-02-25  49  #endif
a28a6e860c6cf2 Francis Laniel 2021-02-25  50  

:::::: The code at line 47 was first introduced by commit
:::::: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.

:::::: TO: Francis Laniel <laniel_francis@privacyrequired.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
