Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8668549FC32
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbiA1Oyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:54:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:9931 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbiA1Oy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643381669; x=1674917669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iqtXsvLLgcuDFWQEAjNmfTJbNdGDPjDGzi77gNCcokc=;
  b=hdZwZ1YIb7PNm1HBaaZxlg22wM9AdsuTPeGBgXFvSTC5JqiVPpMNz3fc
   bI833X1TUleKLMHuao50gaZMwTlrbQd4c29SUeO6sscm76U3iVZlhxfLr
   fJ0QmcfQK0tJqE2ro1eQpXgXxsB1NtriN5LXRFwM1z+xfcftRtrXVONfO
   0ZWw6srOPXA5njd49iuMM73nqyxJE7QBO/1UPvnGf+pd3vhTTbdiCEjJG
   DkqKoRu8GxckmRGQO+vfIzGzc/eAninS2z+1yTWIinKzMTxRWKH98GXLW
   7pkfKRi6PhI9nU/70cN+Xo1x3u5FBla7rtAKdKbPZVYfcci5mM9BNEt1S
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227109740"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="227109740"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="521730521"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2022 06:54:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDSdu-000Nzq-DZ; Fri, 28 Jan 2022 14:54:26 +0000
Date:   Fri, 28 Jan 2022 22:54:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, stefanr@s5r6.in-berlin.de
Cc:     kbuild-all@lists.01.org, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers/firewire: use struct_size over open coded
 arithmetic
Message-ID: <202201282234.A43HZoSH-lkp@intel.com>
References: <20220128080336.1211525-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128080336.1211525-1-chi.minghao@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on ieee1394-linux1394/for-next]
[also build test ERROR on v5.17-rc1 next-20220128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/cgel-zte-gmail-com/drivers-firewire-use-struct_size-over-open-coded-arithmetic/20220128-160602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git for-next
config: arm-randconfig-c002-20220124 (https://download.01.org/0day-ci/archive/20220128/202201282234.A43HZoSH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1567c3f747219c35e83d9c1f4ac3c3d36f447d90
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/drivers-firewire-use-struct_size-over-open-coded-arithmetic/20220128-160602
        git checkout 1567c3f747219c35e83d9c1f4ac3c3d36f447d90
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:29,
                    from drivers/firewire/core-transaction.c:10:
   drivers/firewire/core-transaction.c: In function 'allocate_request':
>> include/linux/overflow.h:326:32: error: invalid type argument of '->' (have 'struct fw_request')
     326 |                     sizeof(*(p)->member) + __must_be_array((p)->member),\
         |                                ^~
   drivers/firewire/core-transaction.c:780:27: note: in expansion of macro 'struct_size'
     780 |         request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
         |                           ^~~~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/kernel.h:12,
                    from include/asm-generic/bug.h:20,
                    from arch/arm/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from drivers/firewire/core-transaction.c:8:
   include/linux/overflow.h:326:63: error: invalid type argument of '->' (have 'struct fw_request')
     326 |                     sizeof(*(p)->member) + __must_be_array((p)->member),\
         |                                                               ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:240:51: note: in expansion of macro '__same_type'
     240 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/overflow.h:326:44: note: in expansion of macro '__must_be_array'
     326 |                     sizeof(*(p)->member) + __must_be_array((p)->member),\
         |                                            ^~~~~~~~~~~~~~~
   drivers/firewire/core-transaction.c:780:27: note: in expansion of macro 'struct_size'
     780 |         request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
         |                           ^~~~~~~~~~~
   include/linux/overflow.h:326:63: error: invalid type argument of '->' (have 'struct fw_request')
     326 |                     sizeof(*(p)->member) + __must_be_array((p)->member),\
         |                                                               ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:240:51: note: in expansion of macro '__same_type'
     240 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/overflow.h:326:44: note: in expansion of macro '__must_be_array'
     326 |                     sizeof(*(p)->member) + __must_be_array((p)->member),\
         |                                            ^~~~~~~~~~~~~~~
   drivers/firewire/core-transaction.c:780:27: note: in expansion of macro 'struct_size'
     780 |         request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
         |                           ^~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:240:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     240 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/overflow.h:326:44: note: in expansion of macro '__must_be_array'
     326 |                     sizeof(*(p)->member) + __must_be_array((p)->member),\
         |                                            ^~~~~~~~~~~~~~~
   drivers/firewire/core-transaction.c:780:27: note: in expansion of macro 'struct_size'
     780 |         request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
         |                           ^~~~~~~~~~~
   In file included from include/linux/device.h:29,
                    from drivers/firewire/core-transaction.c:10:
>> include/linux/overflow.h:327:28: error: invalid type argument of unary '*' (have 'struct fw_request')
     327 |                     sizeof(*(p)))
         |                            ^~~~
   drivers/firewire/core-transaction.c:780:27: note: in expansion of macro 'struct_size'
     780 |         request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
         |                           ^~~~~~~~~~~


vim +326 include/linux/overflow.h

610b15c50e86eb1 Kees Cook           2018-05-07  312  
610b15c50e86eb1 Kees Cook           2018-05-07  313  /**
610b15c50e86eb1 Kees Cook           2018-05-07  314   * struct_size() - Calculate size of structure with trailing array.
610b15c50e86eb1 Kees Cook           2018-05-07  315   * @p: Pointer to the structure.
610b15c50e86eb1 Kees Cook           2018-05-07  316   * @member: Name of the array member.
b19d57d0f3cc6f1 Gustavo A. R. Silva 2020-06-08  317   * @count: Number of elements in the array.
610b15c50e86eb1 Kees Cook           2018-05-07  318   *
610b15c50e86eb1 Kees Cook           2018-05-07  319   * Calculates size of memory needed for structure @p followed by an
b19d57d0f3cc6f1 Gustavo A. R. Silva 2020-06-08  320   * array of @count number of @member elements.
610b15c50e86eb1 Kees Cook           2018-05-07  321   *
610b15c50e86eb1 Kees Cook           2018-05-07  322   * Return: number of bytes needed or SIZE_MAX on overflow.
610b15c50e86eb1 Kees Cook           2018-05-07  323   */
b19d57d0f3cc6f1 Gustavo A. R. Silva 2020-06-08  324  #define struct_size(p, member, count)					\
b19d57d0f3cc6f1 Gustavo A. R. Silva 2020-06-08  325  	__ab_c_size(count,						\
610b15c50e86eb1 Kees Cook           2018-05-07 @326  		    sizeof(*(p)->member) + __must_be_array((p)->member),\
610b15c50e86eb1 Kees Cook           2018-05-07 @327  		    sizeof(*(p)))
610b15c50e86eb1 Kees Cook           2018-05-07  328  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
