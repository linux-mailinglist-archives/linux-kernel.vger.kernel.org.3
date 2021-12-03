Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2874C466EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 02:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbhLCBG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 20:06:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:61814 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233835AbhLCBGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:06:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="235618654"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="235618654"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 17:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="597382158"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2021 17:02:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mswyP-000GwB-W5; Fri, 03 Dec 2021 01:02:49 +0000
Date:   Fri, 3 Dec 2021 09:01:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, jolsa@redhat.com,
        mingo@redhat.com, dave@stgolabs.net,
        linux-perf-users@vger.kernel.org, arnd@arndb.de,
        namhyung@kernel.org, alistair23@gmail.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v4 3/6] uapi: futex: Add a futex syscall
Message-ID: <202112030822.dtjQPM06-lkp@intel.com>
References: <20211202111659.2077911-3-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202111659.2077911-3-alistair.francis@opensource.wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on linux/master soc/for-next linus/master v5.16-rc3 next-20211202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Alistair-Francis/perf-bench-futex-Add-support-for-32-bit-systems-with-64-bit-time_t/20211202-192015
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 4e0d84634445ed550498d613a49ea8f6cfa5e66c
config: x86_64-randconfig-a002-20211202 (https://download.01.org/0day-ci/archive/20211203/202112030822.dtjQPM06-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4b553297ef3ee4dc2119d5429adf3072e90fac38)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/710fc0b1a255e93e04efbaccf76f6445db51ff1f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Alistair-Francis/perf-bench-futex-Add-support-for-32-bit-systems-with-64-bit-time_t/20211202-192015
        git checkout 710fc0b1a255e93e04efbaccf76f6445db51ff1f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
   ./usr/include/linux/futex_syscall.h:33:16: warning: declaration of 'struct timespec' will not be visible outside of this function [-Wvisibility]
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
>> ./usr/include/linux/futex_syscall.h:45:12: error: invalid application of 'sizeof' to an incomplete type 'struct timespec'
           if (sizeof(*timeout) == sizeof(struct __kernel_old_timespec))
                     ^~~~~~~~~~
   ./usr/include/linux/futex_syscall.h:33:16: note: forward declaration of 'struct timespec'
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
>> ./usr/include/linux/futex_syscall.h:46:10: error: implicit declaration of function 'syscall' [-Werror,-Wimplicit-function-declaration]
                   return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
                          ^
>> ./usr/include/linux/futex_syscall.h:48:24: error: incomplete definition of type 'struct timespec'
           if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {
                          ~~~~~~~^
   ./usr/include/linux/futex_syscall.h:33:16: note: forward declaration of 'struct timespec'
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
   ./usr/include/linux/futex_syscall.h:48:49: error: incomplete definition of type 'struct timespec'
           if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {
                                                   ~~~~~~~^
   ./usr/include/linux/futex_syscall.h:33:16: note: forward declaration of 'struct timespec'
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
   ./usr/include/linux/futex_syscall.h:51:44: error: incomplete definition of type 'struct timespec'
                   ts_old.tv_sec = (__kernel_long_t) timeout->tv_sec;
                                                     ~~~~~~~^
   ./usr/include/linux/futex_syscall.h:33:16: note: forward declaration of 'struct timespec'
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
   ./usr/include/linux/futex_syscall.h:52:45: error: incomplete definition of type 'struct timespec'
                   ts_old.tv_nsec = (__kernel_long_t) timeout->tv_nsec;
                                                      ~~~~~~~^
   ./usr/include/linux/futex_syscall.h:33:16: note: forward declaration of 'struct timespec'
                         struct timespec *timeout, __volatile__ uint32_t *uaddr2, int val3)
                                ^
   ./usr/include/linux/futex_syscall.h:85:9: error: implicit declaration of function 'syscall' [-Werror,-Wimplicit-function-declaration]
           return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, val3);
                  ^
   1 warning and 7 errors generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
