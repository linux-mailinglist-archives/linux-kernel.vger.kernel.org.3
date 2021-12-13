Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E17471F56
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhLMCei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:34:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:14112 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhLMCeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639362877; x=1670898877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NUNZNfY3A70ZA7Y5OadzzLS1DyVkLNw+uFSmxLYUR7Q=;
  b=T0B7hZbt6ShjI9L4ywFThMYtK71ehtuuo313LvL9Y4yCcMIIvm1E2VN9
   O7jx3Ae89VVXNd7RlzR3B+THur7Oju1Ra0lsTmcD65Sei+otUNobGsrY+
   z3GkTUwVM69vhUySe9jsUeeuR05eCEWdShHOzJJxdYzpTywOVfeRL/C5P
   UtNrdglaGwJ1cN7dCKeyOeNtjp5OK9FrdyGw0k+szlhCCch13VNOKrD8q
   CQFNmFEx893cvCOL0C54Af0hg3CA0y+SYkvo93MR4nis75lJdPHScGucm
   aVBuAVXdV8G+3fZ8XSwQhzMRGlrCDzDiMlryPMIUMu8mBvEk9WM+vVcKx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="299433550"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="299433550"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 18:34:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="603331662"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2021 18:34:34 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwbAf-0006BH-Sz; Mon, 13 Dec 2021 02:34:33 +0000
Date:   Mon, 13 Dec 2021 10:33:41 +0800
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
Subject: Re: [PATCH 1/3] vmcore: Convert copy_oldmem_page() to take an
 iov_iter
Message-ID: <202112131020.pSJ77Cjj-lkp@intel.com>
References: <20211213000636.2932569-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213000636.2932569-2-willy@infradead.org>
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
config: riscv-randconfig-r012-20211213 (https://download.01.org/0day-ci/archive/20211213/202112131020.pSJ77Cjj-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e1684ad72e2cce57ac90ae1270668753f1aa6c60
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Convert-vmcore-to-use-an-iov_iter/20211213-080748
        git checkout e1684ad72e2cce57ac90ae1270668753f1aa6c60
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/crash_dump.c: In function 'copy_oldmem_page':
>> arch/riscv/kernel/crash_dump.c:35:17: error: implicit declaration of function 'copy_to_iter'; did you mean 'copy_to_user'? [-Werror=implicit-function-declaration]
      35 |         csize = copy_to_iter(vaddr + offset, csize, iter);
         |                 ^~~~~~~~~~~~
         |                 copy_to_user
   cc1: some warnings being treated as errors
--
   fs/proc/vmcore.c:135:9: warning: no previous prototype for 'read_from_oldmem_iter' [-Wmissing-prototypes]
     135 | ssize_t read_from_oldmem_iter(struct iov_iter *iter, size_t count,
         |         ^~~~~~~~~~~~~~~~~~~~~
   fs/proc/vmcore.c: In function 'read_from_oldmem_iter':
>> fs/proc/vmcore.c:157:31: error: implicit declaration of function 'iov_iter_zero' [-Werror=implicit-function-declaration]
     157 |                         tmp = iov_iter_zero(nr_bytes, iter);
         |                               ^~~~~~~~~~~~~
   fs/proc/vmcore.c: In function 'read_from_oldmem':
>> fs/proc/vmcore.c:187:25: error: storage size of 'iter' isn't known
     187 |         struct iov_iter iter;
         |                         ^~~~
   fs/proc/vmcore.c:188:22: error: storage size of 'iov' isn't known
     188 |         struct iovec iov;
         |                      ^~~
>> fs/proc/vmcore.c:189:21: error: storage size of 'kvec' isn't known
     189 |         struct kvec kvec;
         |                     ^~~~
   fs/proc/vmcore.c:194:17: error: implicit declaration of function 'iov_iter_init'; did you mean 'klist_iter_init'? [-Werror=implicit-function-declaration]
     194 |                 iov_iter_init(&iter, READ, &iov, 1, count);
         |                 ^~~~~~~~~~~~~
         |                 klist_iter_init
>> fs/proc/vmcore.c:198:17: error: implicit declaration of function 'iov_iter_kvec' [-Werror=implicit-function-declaration]
     198 |                 iov_iter_kvec(&iter, READ, &kvec, 1, count);
         |                 ^~~~~~~~~~~~~
   fs/proc/vmcore.c:189:21: warning: unused variable 'kvec' [-Wunused-variable]
     189 |         struct kvec kvec;
         |                     ^~~~
   fs/proc/vmcore.c:188:22: warning: unused variable 'iov' [-Wunused-variable]
     188 |         struct iovec iov;
         |                      ^~~
   fs/proc/vmcore.c:187:25: warning: unused variable 'iter' [-Wunused-variable]
     187 |         struct iov_iter iter;
         |                         ^~~~
   fs/proc/vmcore.c:202:1: error: control reaches end of non-void function [-Werror=return-type]
     202 | }
         | ^
   cc1: some warnings being treated as errors


vim +35 arch/riscv/kernel/crash_dump.c

    10	
    11	/**
    12	 * copy_oldmem_page() - copy one page from old kernel memory
    13	 * @pfn: page frame number to be copied
    14	 * @buf: buffer where the copied page is placed
    15	 * @csize: number of bytes to copy
    16	 * @offset: offset in bytes into the page
    17	 * @userbuf: if set, @buf is in a user address space
    18	 *
    19	 * This function copies one page from old kernel memory into buffer pointed by
    20	 * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
    21	 * copied or negative error in case of failure.
    22	 */
    23	ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
    24				 size_t csize, unsigned long offset)
    25	{
    26		void *vaddr;
    27	
    28		if (!csize)
    29			return 0;
    30	
    31		vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
    32		if (!vaddr)
    33			return -ENOMEM;
    34	
  > 35		csize = copy_to_iter(vaddr + offset, csize, iter);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
