Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C477A474ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbhLOACM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:02:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:11965 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234512AbhLOACL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639526531; x=1671062531;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VSXgUDdlFqKGlsS399TSciH7lt+O61I9XZ0vqoofX54=;
  b=XUPp2BicUX38u+AvDOzOmCV8zsbFNMEcaoNTNeKe7wi3AegcQ1KZmbVh
   HBOtfAW3Q6IQv8bMxICnciQePgBhIsJSkLZwXnrZyo0fm0MIdOWvjhllB
   LrEmQ3xjh1/FGhfpMoH/v0ITMOGoGTkhvM8Im6e+OY56wVNazktGqw9PY
   HDUm7rOF5AynZY8QCJbs/a3L1Q3OIjxcgevFNZdGVbO3Ep6j3xBZPa+tP
   Y3gLVjLJt956Ll3g4zRJ76xEsQeyyf8n4/d2/vypEvehSm9t/tERdxKji
   jt7C0k4Y/9Ioad+cmuGAmxNKr82rnzl1CeHQSWCev1NT8GRZ367oJuTwg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263256578"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="263256578"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 16:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="753160672"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2021 16:01:35 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxHjj-0000x2-3o; Wed, 15 Dec 2021 00:01:35 +0000
Date:   Wed, 15 Dec 2021 08:00:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Francis Laniel <laniel_francis@privacyrequired.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: include/linux/fortify-string.h:27:33: warning: '__builtin_strncpy'
 output may be truncated copying between 5 and 9 bytes from a string of
 length 9
Message-ID: <202112150718.rMIimid9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
commit: a28a6e860c6cf231cf3c5171c75c342adcd00406 string.h: move fortified functions definitions in a dedicated header.
date:   10 months ago
config: mips-randconfig-r011-20211214 (https://download.01.org/0day-ci/archive/20211215/202112150718.rMIimid9-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a28a6e860c6cf231cf3c5171c75c342adcd00406
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a28a6e860c6cf231cf3c5171c75c342adcd00406
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/dec/prom/ fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:269,
                    from include/linux/uuid.h:12,
                    from fs/xfs/xfs_linux.h:10,
                    from fs/xfs/xfs.h:22,
                    from fs/xfs/xfs_xattr.c:7:
   In function 'strncpy',
       inlined from '__xfs_xattr_put_listent' at fs/xfs/xfs_xattr.c:119:2,
       inlined from 'xfs_xattr_put_listent' at fs/xfs/xfs_xattr.c:181:2:
>> include/linux/fortify-string.h:27:33: warning: '__builtin_strncpy' output may be truncated copying between 5 and 9 bytes from a string of length 9 [-Wstringop-truncation]
      27 | #define __underlying_strncpy    __builtin_strncpy
         |                                 ^
   include/linux/fortify-string.h:38:16: note: in expansion of macro '__underlying_strncpy'
      38 |         return __underlying_strncpy(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~~


vim +/__builtin_strncpy +27 include/linux/fortify-string.h

     4	
     5	
     6	#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
     7	extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
     8	extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
     9	extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
    10	extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
    11	extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
    12	extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
    13	extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
    14	extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
    15	extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
    16	extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
    17	#else
    18	#define __underlying_memchr	__builtin_memchr
    19	#define __underlying_memcmp	__builtin_memcmp
    20	#define __underlying_memcpy	__builtin_memcpy
    21	#define __underlying_memmove	__builtin_memmove
    22	#define __underlying_memset	__builtin_memset
    23	#define __underlying_strcat	__builtin_strcat
    24	#define __underlying_strcpy	__builtin_strcpy
    25	#define __underlying_strlen	__builtin_strlen
    26	#define __underlying_strncat	__builtin_strncat
  > 27	#define __underlying_strncpy	__builtin_strncpy
    28	#endif
    29	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
