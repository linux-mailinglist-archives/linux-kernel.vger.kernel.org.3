Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788DA471FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 05:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhLMEFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 23:05:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:58126 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhLMEFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 23:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639368339; x=1670904339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SIKrcXiNkEqdWrtSf7SK+haGM38rR9yNMx/1JXebCf0=;
  b=Ts1UyL6s42oWuPSJgSmvFjo2NoNT3C478mEUnl4QeXz8/nv2d0vJmMJH
   TL3vhyI6dyANRvF7OoMtgD/yUO3a/woqKJd04LJUmpn1yPpjvRM2FW456
   Ybsz4PgUCzaLo4AGm5s2OZBLZ6osN9rzawjcMde4Xgt4z/CemPcA479oX
   lBXXy4TUu3SlPvlbKAciXeT6v52+S/28qeCNwHJzGu+0d8vOgtQ1nCUgr
   ngBoPfuTHSKeJGkCC6oQYIGlotp4bYcUrGa+ptypt/N5Vypuamifr1Czr
   d70MeZjUqymFCU/78vOHMzx25NdVnZqxrf54hu03JhAthpa6f/2XMZEr/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="299441232"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="299441232"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 20:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="754092926"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2021 20:05:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwcal-0006Fu-8r; Mon, 13 Dec 2021 04:05:35 +0000
Date:   Mon, 13 Dec 2021 12:04:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] vmcore: Convert read_from_oldmem() to take an
 iov_iter
Message-ID: <202112131249.lfVULc7X-lkp@intel.com>
References: <20211213000636.2932569-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213000636.2932569-4-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on arm64/for-next/core powerpc/next s390/features linus/master v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/Convert-vmcore-to-use-an-iov_iter/20211213-080748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git e463a09af2f0677b9485a7e8e4e70b396b2ffb6f
config: riscv-randconfig-r012-20211213 (https://download.01.org/0day-ci/archive/20211213/202112131249.lfVULc7X-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/22576d6aef6fb4cffad0a4e85953662c147dfe66
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Convert-vmcore-to-use-an-iov_iter/20211213-080748
        git checkout 22576d6aef6fb4cffad0a4e85953662c147dfe66
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   fs/proc/vmcore.c: In function 'read_from_oldmem':
   fs/proc/vmcore.c:157:31: error: implicit declaration of function 'iov_iter_zero' [-Werror=implicit-function-declaration]
     157 |                         tmp = iov_iter_zero(nr_bytes, iter);
         |                               ^~~~~~~~~~~~~
   fs/proc/vmcore.c: In function 'elfcorehdr_read':
>> fs/proc/vmcore.c:202:16: error: variable 'kvec' has initializer but incomplete type
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                ^~~~
>> fs/proc/vmcore.c:202:31: error: 'struct kvec' has no member named 'iov_base'
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                               ^~~~~~~~
>> fs/proc/vmcore.c:202:42: warning: excess elements in struct initializer
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                          ^~~
   fs/proc/vmcore.c:202:42: note: (near initialization for 'kvec')
>> fs/proc/vmcore.c:202:48: error: 'struct kvec' has no member named 'iov_len'
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                                ^~~~~~~
   fs/proc/vmcore.c:202:58: warning: excess elements in struct initializer
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                                          ^~~~~
   fs/proc/vmcore.c:202:58: note: (near initialization for 'kvec')
   fs/proc/vmcore.c:202:21: error: storage size of 'kvec' isn't known
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                     ^~~~
   fs/proc/vmcore.c:203:25: error: storage size of 'iter' isn't known
     203 |         struct iov_iter iter;
         |                         ^~~~
   fs/proc/vmcore.c:205:9: error: implicit declaration of function 'iov_iter_kvec' [-Werror=implicit-function-declaration]
     205 |         iov_iter_kvec(&iter, READ, &kvec, 1, count);
         |         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:203:25: warning: unused variable 'iter' [-Wunused-variable]
     203 |         struct iov_iter iter;
         |                         ^~~~
   fs/proc/vmcore.c:202:21: warning: unused variable 'kvec' [-Wunused-variable]
     202 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                     ^~~~
   fs/proc/vmcore.c: In function 'elfcorehdr_read_notes':
   fs/proc/vmcore.c:215:16: error: variable 'kvec' has initializer but incomplete type
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                ^~~~
   fs/proc/vmcore.c:215:31: error: 'struct kvec' has no member named 'iov_base'
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                               ^~~~~~~~
   fs/proc/vmcore.c:215:42: warning: excess elements in struct initializer
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                          ^~~
   fs/proc/vmcore.c:215:42: note: (near initialization for 'kvec')
   fs/proc/vmcore.c:215:48: error: 'struct kvec' has no member named 'iov_len'
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                                ^~~~~~~
   fs/proc/vmcore.c:215:58: warning: excess elements in struct initializer
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                                                          ^~~~~
   fs/proc/vmcore.c:215:58: note: (near initialization for 'kvec')
   fs/proc/vmcore.c:215:21: error: storage size of 'kvec' isn't known
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                     ^~~~
   fs/proc/vmcore.c:216:25: error: storage size of 'iter' isn't known
     216 |         struct iov_iter iter;
         |                         ^~~~
   fs/proc/vmcore.c:216:25: warning: unused variable 'iter' [-Wunused-variable]
   fs/proc/vmcore.c:215:21: warning: unused variable 'kvec' [-Wunused-variable]
     215 |         struct kvec kvec = { .iov_base = buf, .iov_len = count };
         |                     ^~~~
   fs/proc/vmcore.c: In function '__read_vmcore':
   fs/proc/vmcore.c:327:17: error: invalid use of undefined type 'struct iov_iter'
     327 |         if (iter->count == 0 || *fpos >= vmcore_size)
         |                 ^~
   fs/proc/vmcore.c:331:17: error: invalid use of undefined type 'struct iov_iter'
     331 |         if (iter->count > vmcore_size - *fpos)
         |                 ^~
   fs/proc/vmcore.c:332:21: error: invalid use of undefined type 'struct iov_iter'
     332 |                 iter->count = vmcore_size - *fpos;
         |                     ^~
   In file included from include/linux/kernel.h:17,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from fs/proc/vmcore.c:11:
   fs/proc/vmcore.c:336:62: error: invalid use of undefined type 'struct iov_iter'
     336 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                                                              ^~
   include/linux/minmax.h:20:46: note: in definition of macro '__typecheck'
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                              ^
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/proc/vmcore.c:336:23: note: in expansion of macro 'min'
     336 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                       ^~~
   In file included from arch/riscv/include/asm/bug.h:10,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from fs/proc/vmcore.c:11:
   fs/proc/vmcore.c:336:62: error: invalid use of undefined type 'struct iov_iter'
     336 |                 tsz = min(elfcorebuf_sz - (size_t)*fpos, iter->count);
         |                                                              ^~
   include/linux/const.h:12:55: note: in definition of macro '__is_constexpr'
      12 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                       ^
   include/linux/minmax.h:26:39: note: in expansion of macro '__no_side_effects'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                                       ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~


vim +/kvec +202 fs/proc/vmcore.c

   196	
   197	/*
   198	 * Architectures may override this function to read from ELF header
   199	 */
   200	ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
   201	{
 > 202		struct kvec kvec = { .iov_base = buf, .iov_len = count };
   203		struct iov_iter iter;
   204	
   205		iov_iter_kvec(&iter, READ, &kvec, 1, count);
   206	
   207		return read_from_oldmem(&iter, count, ppos, false);
   208	}
   209	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
