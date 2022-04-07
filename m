Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3594F8A38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiDGWKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiDGWKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D5B18A7BF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649368601; x=1680904601;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fmDwUWxOrACp+oJg5zYDbJ9JUF2ie//HA5KjnNg+4GQ=;
  b=MHd6kWOwk8Bp7B+9hlZ7k/MzmA9EYpVwdX19ezSnDpXA0r9bitJ0oU1T
   ZxHyd8ccwVQk4CxrqlxowyDklkFpY+KpuvtXYWGs9hrw5RrJL255rgp4v
   7gh3y6ss3i8J6wcBWV5TJ2F4wYQ5BqHo0BwcxEI2q0afZMkGMgNUtAcoU
   ZciVjy+J00LmxJr05LtXfuibvk5sX/+mDoAdVuTNjeBcc8KNBbY5Zb3Cy
   V8h5fiXETdgY0P02yXKggz1pMYJw5DsLIQv33XxrVSnGql9j1Jc6tPpVJ
   3qjqzZLlaQe081z97wJ0fw+sUJjcLRRyx1dRmqnXxCnN5SAmvohNtKQml
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="242045326"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="242045326"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 14:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="525106256"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Apr 2022 14:56:37 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nca7I-0005nv-N5;
        Thu, 07 Apr 2022 21:56:36 +0000
Date:   Fri, 8 Apr 2022 05:55:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 6/10] kernel/rseq.c:110:13: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202204080517.cQHElOKD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   73447e771c55e18598a6fbf6adee1002aee18ea0
commit: 92948bd2c12648f2fb8256ae69dd092ce4398a3a [6/10] x86/uaccess: Remove tags from the address before checking
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220408/202204080517.cQHElOKD-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=92948bd2c12648f2fb8256ae69dd092ce4398a3a
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 92948bd2c12648f2fb8256ae69dd092ce4398a3a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash block/ drivers/acpi/ drivers/char/ drivers/fpga/ drivers/hwmon/ drivers/media/rc/ drivers/misc/vmw_vmci/ drivers/nvme/host/ drivers/platform/x86/ drivers/rtc/ drivers/tee/ fs/btrfs/ fs/f2fs/ fs/fat/ fs/jfs/ fs/orangefs/ fs/proc/ fs/quota/ fs/reiserfs/ fs/udf/ fs/verity/ fs/xfs/ ipc/ kernel/ net/appletalk/ net/atm/ net/bluetooth/ net/can/ net/decnet/ net/ieee802154/ net/llc/ net/nfc/ net/phonet/ net/qrtr/ net/vmw_vsock/ net/x25/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/rseq.c:110:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   kernel/rseq.c:110:13: sparse:     expected unsigned int *__ptr_clean
   kernel/rseq.c:110:13: sparse:     got unsigned int [noderef] __user *
>> kernel/rseq.c:110:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:110:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/rseq.c:110:13: sparse:     got unsigned int *__ptr_clean
>> kernel/rseq.c:110:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:110:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/rseq.c:110:13: sparse:     got unsigned int *__ptr_clean
   kernel/rseq.c:117:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   kernel/rseq.c:117:13: sparse:     expected unsigned int *__ptr_clean
   kernel/rseq.c:117:13: sparse:     got unsigned int [noderef] __user *
   kernel/rseq.c:117:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:117:13: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/rseq.c:117:13: sparse:     got unsigned int *__ptr_clean
   kernel/rseq.c:117:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:117:13: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/rseq.c:117:13: sparse:     got unsigned int *__ptr_clean
>> kernel/rseq.c:160:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *[assigned] usig @@
   kernel/rseq.c:160:15: sparse:     expected unsigned int *__ptr_clean
   kernel/rseq.c:160:15: sparse:     got unsigned int [noderef] [usertype] __user *[assigned] usig
   kernel/rseq.c:160:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:160:15: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/rseq.c:160:15: sparse:     got unsigned int *__ptr_clean
   kernel/rseq.c:179:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   kernel/rseq.c:179:15: sparse:     expected unsigned int *__ptr_clean
   kernel/rseq.c:179:15: sparse:     got unsigned int [noderef] __user *
   kernel/rseq.c:179:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   kernel/rseq.c:179:15: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/rseq.c:179:15: sparse:     got unsigned int *__ptr_clean
--
>> fs/btrfs/ioctl.c:464:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *arg @@
   fs/btrfs/ioctl.c:464:16: sparse:     expected int *__ptr_clean
   fs/btrfs/ioctl.c:464:16: sparse:     got int [noderef] __user *arg
>> fs/btrfs/ioctl.c:464:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/btrfs/ioctl.c:464:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/btrfs/ioctl.c:464:16: sparse:     got int *__ptr_clean
>> fs/btrfs/ioctl.c:464:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/btrfs/ioctl.c:464:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/btrfs/ioctl.c:464:16: sparse:     got int *__ptr_clean
   fs/btrfs/ioctl.c:413:6: sparse: sparse: context imbalance in 'btrfs_exclop_start_try_lock' - wrong count at exit
   fs/btrfs/ioctl.c:426:6: sparse: sparse: context imbalance in 'btrfs_exclop_start_unlock' - unexpected unlock
--
   fs/f2fs/file.c:49:54: sparse: sparse: cast from restricted vm_fault_t
>> fs/f2fs/file.c:1986:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/f2fs/file.c:1986:16: sparse:     expected int *__ptr_clean
   fs/f2fs/file.c:1986:16: sparse:     got int [noderef] __user *
   fs/f2fs/file.c:1986:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/f2fs/file.c:1986:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:1986:16: sparse:     got int *__ptr_clean
   fs/f2fs/file.c:1986:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/f2fs/file.c:1986:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:1986:16: sparse:     got int *__ptr_clean
>> fs/f2fs/file.c:2214:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:2214:13: sparse:     expected unsigned int *__ptr_clean
   fs/f2fs/file.c:2214:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:2214:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:2214:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:2214:13: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:2447:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:2447:13: sparse:     expected unsigned int *__ptr_clean
   fs/f2fs/file.c:2447:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:2447:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:2447:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:2447:13: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:2980:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:2980:16: sparse:     expected unsigned int *__ptr_clean
   fs/f2fs/file.c:2980:16: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:2980:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:2980:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:2980:16: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:2980:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:2980:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:2980:16: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:3140:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:3140:13: sparse:     expected unsigned int *__ptr_clean
   fs/f2fs/file.c:3140:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:3140:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:3140:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3140:13: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:3197:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:3197:16: sparse:     expected unsigned int *__ptr_clean
   fs/f2fs/file.c:3197:16: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:3197:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:3197:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3197:16: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:3197:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/f2fs/file.c:3197:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:3197:16: sparse:     got unsigned int *__ptr_clean
   fs/f2fs/file.c:3301:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3301:36: sparse:     expected unsigned short const [usertype] *pwcs
   fs/f2fs/file.c:3301:36: sparse:     got restricted __le16 *
   fs/f2fs/file.c:3337:28: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned short [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3337:28: sparse:     expected unsigned short [usertype] *pwcs
   fs/f2fs/file.c:3337:28: sparse:     got restricted __le16 *
>> fs/f2fs/file.c:3362:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user * @@
   fs/f2fs/file.c:3362:16: sparse:     expected unsigned long long *__ptr_clean
   fs/f2fs/file.c:3362:16: sparse:     got unsigned long long [noderef] [usertype] __user *
   fs/f2fs/file.c:3362:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3362:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3362:16: sparse:     got unsigned long long *__ptr_clean
   fs/f2fs/file.c:3362:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3362:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:3362:16: sparse:     got unsigned long long *__ptr_clean
   fs/f2fs/file.c:3512:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user * @@
   fs/f2fs/file.c:3512:23: sparse:     expected unsigned long long *__ptr_clean
   fs/f2fs/file.c:3512:23: sparse:     got unsigned long long [noderef] [usertype] __user *
   fs/f2fs/file.c:3512:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3512:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3512:23: sparse:     got unsigned long long *__ptr_clean
   fs/f2fs/file.c:3512:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3512:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:3512:23: sparse:     got unsigned long long *__ptr_clean
   fs/f2fs/file.c:3671:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user * @@
   fs/f2fs/file.c:3671:23: sparse:     expected unsigned long long *__ptr_clean
   fs/f2fs/file.c:3671:23: sparse:     got unsigned long long [noderef] [usertype] __user *
   fs/f2fs/file.c:3671:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3671:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3671:23: sparse:     got unsigned long long *__ptr_clean
   fs/f2fs/file.c:3671:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/f2fs/file.c:3671:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/f2fs/file.c:3671:23: sparse:     got unsigned long long *__ptr_clean
--
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user * @@
   fs/fat/dir.c:759:1: sparse:     expected char *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char [noderef] __user *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:759:1: sparse:     got char *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:759:1: sparse:     got char *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short [noderef] __user *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:759:1: sparse:     got unsigned short *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:759:1: sparse:     got unsigned short *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user * @@
   fs/fat/dir.c:759:1: sparse:     expected char *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char [noderef] __user *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:759:1: sparse:     got char *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:759:1: sparse:     got char *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short [noderef] __user *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:759:1: sparse:     got unsigned short *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:759:1: sparse:     got unsigned short *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user * @@
   fs/fat/dir.c:759:1: sparse:     expected char *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char [noderef] __user *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:759:1: sparse:     got char *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:759:1: sparse:     got char *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short [noderef] __user *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:759:1: sparse:     got unsigned short *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:759:1: sparse:     got unsigned short *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   fs/fat/dir.c:759:1: sparse:     expected long *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got long [noderef] __user *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:759:1: sparse:     got long *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:759:1: sparse:     got long *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   fs/fat/dir.c:759:1: sparse:     expected long *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got long [noderef] __user *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:759:1: sparse:     got long *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:759:1: sparse:     got long *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user * @@
   fs/fat/dir.c:759:1: sparse:     expected char *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got char [noderef] __user *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:759:1: sparse:     got char *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:759:1: sparse:     got char *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   fs/fat/dir.c:759:1: sparse:     expected unsigned short *__ptr_clean
   fs/fat/dir.c:759:1: sparse:     got unsigned short [noderef] __user *
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:759:1: sparse:     got unsigned short *__ptr_clean
>> fs/fat/dir.c:759:1: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/fat/dir.c:759:1: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:759:1: sparse:     got unsigned short *__ptr_clean
   fs/fat/dir.c:812:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   fs/fat/dir.c:812:13: sparse:     expected unsigned short *__ptr_clean
   fs/fat/dir.c:812:13: sparse:     got unsigned short [noderef] __user *
   fs/fat/dir.c:812:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/fat/dir.c:812:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/dir.c:812:13: sparse:     got unsigned short *__ptr_clean
   fs/fat/dir.c:812:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/fat/dir.c:812:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/dir.c:812:13: sparse:     got unsigned short *__ptr_clean
--
>> fs/fat/file.c:32:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *user_attr @@
   fs/fat/file.c:32:16: sparse:     expected unsigned int *__ptr_clean
   fs/fat/file.c:32:16: sparse:     got unsigned int [noderef] [usertype] __user *user_attr
>> fs/fat/file.c:32:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/fat/file.c:32:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/file.c:32:16: sparse:     got unsigned int *__ptr_clean
>> fs/fat/file.c:32:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/fat/file.c:32:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/file.c:32:16: sparse:     got unsigned int *__ptr_clean
   fs/fat/file.c:44:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *user_attr @@
   fs/fat/file.c:44:15: sparse:     expected unsigned int *__ptr_clean
   fs/fat/file.c:44:15: sparse:     got unsigned int [noderef] [usertype] __user *user_attr
   fs/fat/file.c:44:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/fat/file.c:44:15: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/file.c:44:15: sparse:     got unsigned int *__ptr_clean
   fs/fat/file.c:122:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *user_attr @@
   fs/fat/file.c:122:16: sparse:     expected unsigned int *__ptr_clean
   fs/fat/file.c:122:16: sparse:     got unsigned int [noderef] [usertype] __user *user_attr
   fs/fat/file.c:122:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/fat/file.c:122:16: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/file.c:122:16: sparse:     got unsigned int *__ptr_clean
   fs/fat/file.c:122:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/fat/file.c:122:16: sparse:     expected void [noderef] __user *__ptr_pu
   fs/fat/file.c:122:16: sparse:     got unsigned int *__ptr_clean
--
>> fs/jfs/jfs_debug.c:36:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user *buffer @@
   fs/jfs/jfs_debug.c:36:13: sparse:     expected char const *__ptr_clean
   fs/jfs/jfs_debug.c:36:13: sparse:     got char const [noderef] __user *buffer
   fs/jfs/jfs_debug.c:36:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   fs/jfs/jfs_debug.c:36:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/jfs/jfs_debug.c:36:13: sparse:     got char const *__ptr_clean
--
>> fs/orangefs/devorangefs-req.c:605:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   fs/orangefs/devorangefs-req.c:605:26: sparse:     expected signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:605:26: sparse:     got signed int [noderef] [usertype] __user *
   fs/orangefs/devorangefs-req.c:605:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:605:26: sparse:     expected void const volatile [noderef] __user *ptr
   fs/orangefs/devorangefs-req.c:605:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:605:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:605:26: sparse:     expected void [noderef] __user *__ptr_pu
   fs/orangefs/devorangefs-req.c:605:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:609:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   fs/orangefs/devorangefs-req.c:609:26: sparse:     expected signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:609:26: sparse:     got signed int [noderef] [usertype] __user *
   fs/orangefs/devorangefs-req.c:609:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:609:26: sparse:     expected void const volatile [noderef] __user *ptr
   fs/orangefs/devorangefs-req.c:609:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:609:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:609:26: sparse:     expected void [noderef] __user *__ptr_pu
   fs/orangefs/devorangefs-req.c:609:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:614:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] [usertype] __user * @@
   fs/orangefs/devorangefs-req.c:614:26: sparse:     expected signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:614:26: sparse:     got signed int [noderef] [usertype] __user *
   fs/orangefs/devorangefs-req.c:614:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:614:26: sparse:     expected void const volatile [noderef] __user *ptr
   fs/orangefs/devorangefs-req.c:614:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:614:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/orangefs/devorangefs-req.c:614:26: sparse:     expected void [noderef] __user *__ptr_pu
   fs/orangefs/devorangefs-req.c:614:26: sparse:     got signed int *__ptr_clean
   fs/orangefs/devorangefs-req.c:254:28: sparse: sparse: context imbalance in 'orangefs_devreq_read' - different lock contexts for basic block
--
>> fs/proc/page.c:75:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user *out @@
   fs/proc/page.c:75:21: sparse:     expected unsigned long long *__ptr_clean
   fs/proc/page.c:75:21: sparse:     got unsigned long long [noderef] [usertype] __user *out
   fs/proc/page.c:75:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/proc/page.c:75:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/proc/page.c:75:21: sparse:     got unsigned long long *__ptr_clean
   fs/proc/page.c:75:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/proc/page.c:75:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/proc/page.c:75:21: sparse:     got unsigned long long *__ptr_clean
   fs/proc/page.c:252:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user *out @@
   fs/proc/page.c:252:21: sparse:     expected unsigned long long *__ptr_clean
   fs/proc/page.c:252:21: sparse:     got unsigned long long [noderef] [usertype] __user *out
   fs/proc/page.c:252:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   fs/proc/page.c:252:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/proc/page.c:252:21: sparse:     got unsigned long long *__ptr_clean
   fs/proc/page.c:252:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   fs/proc/page.c:252:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/proc/page.c:252:21: sparse:     got unsigned long long *__ptr_clean
--
>> fs/quota/quota.c:224:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   fs/quota/quota.c:224:21: sparse:     expected unsigned int *__ptr_clean
   fs/quota/quota.c:224:21: sparse:     got unsigned int [noderef] __user *
   fs/quota/quota.c:224:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:224:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:224:21: sparse:     got unsigned int *__ptr_clean
   fs/quota/quota.c:224:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:224:21: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:224:21: sparse:     got unsigned int *__ptr_clean
   fs/quota/quota.c:298:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   fs/quota/quota.c:298:21: sparse:     expected unsigned int *__ptr_clean
   fs/quota/quota.c:298:21: sparse:     got unsigned int [noderef] __user *
   fs/quota/quota.c:298:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:298:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:298:21: sparse:     got unsigned int *__ptr_clean
   fs/quota/quota.c:411:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   fs/quota/quota.c:411:13: sparse:     expected unsigned int *__ptr_clean
   fs/quota/quota.c:411:13: sparse:     got unsigned int [noderef] __user *
   fs/quota/quota.c:411:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:411:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:411:13: sparse:     got unsigned int *__ptr_clean
   fs/quota/quota.c:411:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:411:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:411:13: sparse:     got unsigned int *__ptr_clean
>> fs/quota/quota.c:419:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed char *__ptr_clean @@     got signed char [noderef] __user * @@
   fs/quota/quota.c:419:13: sparse:     expected signed char *__ptr_clean
   fs/quota/quota.c:419:13: sparse:     got signed char [noderef] __user *
   fs/quota/quota.c:419:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed char *__ptr_clean @@
   fs/quota/quota.c:419:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:419:13: sparse:     got signed char *__ptr_clean
   fs/quota/quota.c:419:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed char *__ptr_clean @@
   fs/quota/quota.c:419:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:419:13: sparse:     got signed char *__ptr_clean
>> fs/quota/quota.c:420:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   fs/quota/quota.c:420:13: sparse:     expected unsigned short *__ptr_clean
   fs/quota/quota.c:420:13: sparse:     got unsigned short [noderef] __user *
   fs/quota/quota.c:420:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:420:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:420:13: sparse:     got unsigned short *__ptr_clean
   fs/quota/quota.c:420:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:420:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:420:13: sparse:     got unsigned short *__ptr_clean
   fs/quota/quota.c:421:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed char *__ptr_clean @@     got signed char [noderef] __user * @@
   fs/quota/quota.c:421:13: sparse:     expected signed char *__ptr_clean
   fs/quota/quota.c:421:13: sparse:     got signed char [noderef] __user *
   fs/quota/quota.c:421:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed char *__ptr_clean @@
   fs/quota/quota.c:421:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:421:13: sparse:     got signed char *__ptr_clean
   fs/quota/quota.c:421:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed char *__ptr_clean @@
   fs/quota/quota.c:421:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:421:13: sparse:     got signed char *__ptr_clean
   fs/quota/quota.c:424:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   fs/quota/quota.c:424:13: sparse:     expected unsigned int *__ptr_clean
   fs/quota/quota.c:424:13: sparse:     got unsigned int [noderef] __user *
   fs/quota/quota.c:424:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:424:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:424:13: sparse:     got unsigned int *__ptr_clean
   fs/quota/quota.c:424:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   fs/quota/quota.c:424:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:424:13: sparse:     got unsigned int *__ptr_clean
>> fs/quota/quota.c:425:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/quota/quota.c:425:13: sparse:     expected signed int *__ptr_clean
   fs/quota/quota.c:425:13: sparse:     got signed int [noderef] __user *
   fs/quota/quota.c:425:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:425:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:425:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:425:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:425:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:425:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:426:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/quota/quota.c:426:13: sparse:     expected signed int *__ptr_clean
   fs/quota/quota.c:426:13: sparse:     got signed int [noderef] __user *
   fs/quota/quota.c:426:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:426:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:426:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:426:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:426:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:426:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:427:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/quota/quota.c:427:13: sparse:     expected signed int *__ptr_clean
   fs/quota/quota.c:427:13: sparse:     got signed int [noderef] __user *
   fs/quota/quota.c:427:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:427:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:427:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:427:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/quota/quota.c:427:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:427:13: sparse:     got signed int *__ptr_clean
   fs/quota/quota.c:428:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   fs/quota/quota.c:428:13: sparse:     expected unsigned short *__ptr_clean
   fs/quota/quota.c:428:13: sparse:     got unsigned short [noderef] __user *
   fs/quota/quota.c:428:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:428:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:428:13: sparse:     got unsigned short *__ptr_clean
   fs/quota/quota.c:428:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:428:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:428:13: sparse:     got unsigned short *__ptr_clean
   fs/quota/quota.c:429:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   fs/quota/quota.c:429:13: sparse:     expected unsigned short *__ptr_clean
   fs/quota/quota.c:429:13: sparse:     got unsigned short [noderef] __user *
   fs/quota/quota.c:429:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:429:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/quota/quota.c:429:13: sparse:     got unsigned short *__ptr_clean
   fs/quota/quota.c:429:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   fs/quota/quota.c:429:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/quota/quota.c:429:13: sparse:     got unsigned short *__ptr_clean
--
>> fs/reiserfs/ioctl.c:96:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/reiserfs/ioctl.c:96:23: sparse:     expected int *__ptr_clean
   fs/reiserfs/ioctl.c:96:23: sparse:     got int [noderef] __user *
   fs/reiserfs/ioctl.c:96:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/reiserfs/ioctl.c:96:23: sparse:     expected void const volatile [noderef] __user *ptr
   fs/reiserfs/ioctl.c:96:23: sparse:     got int *__ptr_clean
   fs/reiserfs/ioctl.c:96:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/reiserfs/ioctl.c:96:23: sparse:     expected void [noderef] __user *__ptr_pu
   fs/reiserfs/ioctl.c:96:23: sparse:     got int *__ptr_clean
   fs/reiserfs/ioctl.c:106:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/reiserfs/ioctl.c:106:21: sparse:     expected int *__ptr_clean
   fs/reiserfs/ioctl.c:106:21: sparse:     got int [noderef] __user *
   fs/reiserfs/ioctl.c:106:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/reiserfs/ioctl.c:106:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/reiserfs/ioctl.c:106:21: sparse:     got int *__ptr_clean
--
>> fs/udf/file.c:208:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   fs/udf/file.c:208:21: sparse:     expected long *__ptr_clean
   fs/udf/file.c:208:21: sparse:     got long [noderef] __user *
>> fs/udf/file.c:208:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   fs/udf/file.c:208:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/udf/file.c:208:21: sparse:     got long *__ptr_clean
   fs/udf/file.c:213:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user * @@
   fs/udf/file.c:213:34: sparse:     expected long *__ptr_clean
   fs/udf/file.c:213:34: sparse:     got long [noderef] __user *
   fs/udf/file.c:213:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   fs/udf/file.c:213:34: sparse:     expected void const volatile [noderef] __user *ptr
   fs/udf/file.c:213:34: sparse:     got long *__ptr_clean
>> fs/udf/file.c:213:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   fs/udf/file.c:213:34: sparse:     expected void [noderef] __user *__ptr_pu
   fs/udf/file.c:213:34: sparse:     got long *__ptr_clean
>> fs/udf/file.c:216:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/udf/file.c:216:24: sparse:     expected int *__ptr_clean
   fs/udf/file.c:216:24: sparse:     got int [noderef] __user *
>> fs/udf/file.c:216:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/udf/file.c:216:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/udf/file.c:216:24: sparse:     got int *__ptr_clean
>> fs/udf/file.c:216:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/udf/file.c:216:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/udf/file.c:216:24: sparse:     got int *__ptr_clean
--
>> fs/verity/measure.c:42:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   fs/verity/measure.c:42:13: sparse:     expected unsigned short *__ptr_clean
   fs/verity/measure.c:42:13: sparse:     got unsigned short [noderef] __user *
>> fs/verity/measure.c:42:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   fs/verity/measure.c:42:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/verity/measure.c:42:13: sparse:     got unsigned short *__ptr_clean
--
   kernel/locking/lockdep_proc.c:477:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/locking/lockdep_proc.c:477:17: sparse:    char const [noderef] __rcu *
   kernel/locking/lockdep_proc.c:477:17: sparse:    char const *
   kernel/locking/lockdep_proc.c:478:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/locking/lockdep_proc.c:478:17: sparse:    struct lockdep_subclass_key const [noderef] __rcu *
   kernel/locking/lockdep_proc.c:478:17: sparse:    struct lockdep_subclass_key const *
>> kernel/locking/lockdep_proc.c:683:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user *buf @@
   kernel/locking/lockdep_proc.c:683:21: sparse:     expected char const *__ptr_clean
   kernel/locking/lockdep_proc.c:683:21: sparse:     got char const [noderef] __user *buf
>> kernel/locking/lockdep_proc.c:683:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   kernel/locking/lockdep_proc.c:683:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/locking/lockdep_proc.c:683:21: sparse:     got char const *__ptr_clean
--
>> fs/xfs/xfs_ioctl.c:1420:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long *__ptr_clean @@     got signed long long [noderef] __user * @@
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     expected signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     got signed long long [noderef] __user *
   fs/xfs/xfs_ioctl.c:1420:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     got signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1420:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1420:13: sparse:     got signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1421:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long *__ptr_clean @@     got signed long long [noderef] __user * @@
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     expected signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     got signed long long [noderef] __user *
   fs/xfs/xfs_ioctl.c:1421:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     got signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1421:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1421:13: sparse:     got signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1422:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed long long *__ptr_clean @@     got signed long long [noderef] __user * @@
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     expected signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     got signed long long [noderef] __user *
   fs/xfs/xfs_ioctl.c:1422:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     got signed long long *__ptr_clean
   fs/xfs/xfs_ioctl.c:1422:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed long long *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1422:13: sparse:     got signed long long *__ptr_clean
>> fs/xfs/xfs_ioctl.c:1423:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     expected signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     got signed int [noderef] __user *
   fs/xfs/xfs_ioctl.c:1423:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1423:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1423:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1424:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     expected signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     got signed int [noderef] __user *
   fs/xfs/xfs_ioctl.c:1424:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1424:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1424:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1428:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     expected signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     got signed int [noderef] __user *
   fs/xfs/xfs_ioctl.c:1428:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1428:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1428:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1429:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     expected signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     got signed int [noderef] __user *
   fs/xfs/xfs_ioctl.c:1429:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1429:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1429:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1430:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     expected signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     got signed int [noderef] __user *
   fs/xfs/xfs_ioctl.c:1430:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1430:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1430:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1431:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     expected signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     got signed int [noderef] __user *
   fs/xfs/xfs_ioctl.c:1431:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     got signed int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1431:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1431:13: sparse:     got signed int *__ptr_clean
>> fs/xfs/xfs_ioctl.c:1934:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     expected int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     got int [noderef] __user *
   fs/xfs/xfs_ioctl.c:1934:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     got int *__ptr_clean
   fs/xfs/xfs_ioctl.c:1934:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     expected void [noderef] __user *__ptr_pu
   fs/xfs/xfs_ioctl.c:1934:24: sparse:     got int *__ptr_clean
>> fs/xfs/xfs_ioctl.c:2096:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   fs/xfs/xfs_ioctl.c:2096:21: sparse:     expected unsigned int *__ptr_clean
   fs/xfs/xfs_ioctl.c:2096:21: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/xfs/xfs_ioctl.c:2096:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   fs/xfs/xfs_ioctl.c:2096:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:2096:21: sparse:     got unsigned int *__ptr_clean
--
>> kernel/power/user.c:298:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   kernel/power/user.c:298:33: sparse:     expected int *__ptr_clean
   kernel/power/user.c:298:33: sparse:     got int [noderef] __user *
>> kernel/power/user.c:298:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   kernel/power/user.c:298:33: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/power/user.c:298:33: sparse:     got int *__ptr_clean
>> kernel/power/user.c:298:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   kernel/power/user.c:298:33: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/power/user.c:298:33: sparse:     got int *__ptr_clean
>> kernel/power/user.c:340:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long long *__ptr_clean @@     got long long [noderef] [usertype] __user * @@
   kernel/power/user.c:340:25: sparse:     expected long long *__ptr_clean
   kernel/power/user.c:340:25: sparse:     got long long [noderef] [usertype] __user *
>> kernel/power/user.c:340:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long long *__ptr_clean @@
   kernel/power/user.c:340:25: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/power/user.c:340:25: sparse:     got long long *__ptr_clean
>> kernel/power/user.c:340:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long long *__ptr_clean @@
   kernel/power/user.c:340:25: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/power/user.c:340:25: sparse:     got long long *__ptr_clean
   kernel/power/user.c:346:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long long *__ptr_clean @@     got long long [noderef] [usertype] __user * @@
   kernel/power/user.c:346:25: sparse:     expected long long *__ptr_clean
   kernel/power/user.c:346:25: sparse:     got long long [noderef] [usertype] __user *
   kernel/power/user.c:346:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long long *__ptr_clean @@
   kernel/power/user.c:346:25: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/power/user.c:346:25: sparse:     got long long *__ptr_clean
   kernel/power/user.c:346:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long long *__ptr_clean @@
   kernel/power/user.c:346:25: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/power/user.c:346:25: sparse:     got long long *__ptr_clean
   kernel/power/user.c:357:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long long *__ptr_clean @@     got long long [noderef] [usertype] __user * @@
   kernel/power/user.c:357:33: sparse:     expected long long *__ptr_clean
   kernel/power/user.c:357:33: sparse:     got long long [noderef] [usertype] __user *
   kernel/power/user.c:357:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long long *__ptr_clean @@
   kernel/power/user.c:357:33: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/power/user.c:357:33: sparse:     got long long *__ptr_clean
   kernel/power/user.c:357:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long long *__ptr_clean @@
   kernel/power/user.c:357:33: sparse:     expected void [noderef] __user *__ptr_pu
   kernel/power/user.c:357:33: sparse:     got long long *__ptr_clean
--
>> ipc/mqueue.c:1261:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *u_msg_prio @@
   ipc/mqueue.c:1261:36: sparse:     expected unsigned int *__ptr_clean
   ipc/mqueue.c:1261:36: sparse:     got unsigned int [noderef] __user *u_msg_prio
>> ipc/mqueue.c:1261:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   ipc/mqueue.c:1261:36: sparse:     expected void const volatile [noderef] __user *ptr
   ipc/mqueue.c:1261:36: sparse:     got unsigned int *__ptr_clean
>> ipc/mqueue.c:1261:36: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   ipc/mqueue.c:1261:36: sparse:     expected void [noderef] __user *__ptr_pu
   ipc/mqueue.c:1261:36: sparse:     got unsigned int *__ptr_clean
--
>> block/ioctl.c:58:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   block/ioctl.c:58:13: sparse:     expected int *__ptr_clean
   block/ioctl.c:58:13: sparse:     got int [noderef] __user *
>> block/ioctl.c:58:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/ioctl.c:58:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:58:13: sparse:     got int *__ptr_clean
>> block/ioctl.c:58:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user **__ptr_clean @@     got void [noderef] __user *[noderef] __user * @@
   block/ioctl.c:58:39: sparse:     expected void [noderef] __user **__ptr_clean
   block/ioctl.c:58:39: sparse:     got void [noderef] __user *[noderef] __user *
>> block/ioctl.c:58:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got void [noderef] __user **__ptr_clean @@
   block/ioctl.c:58:39: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:58:39: sparse:     got void [noderef] __user **__ptr_clean
>> block/ioctl.c:170:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user *argp @@
   block/ioctl.c:170:16: sparse:     expected unsigned short *__ptr_clean
   block/ioctl.c:170:16: sparse:     got unsigned short [noderef] __user *argp
>> block/ioctl.c:170:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   block/ioctl.c:170:16: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:170:16: sparse:     got unsigned short *__ptr_clean
>> block/ioctl.c:170:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   block/ioctl.c:170:16: sparse:     expected void [noderef] __user *__ptr_pu
   block/ioctl.c:170:16: sparse:     got unsigned short *__ptr_clean
>> block/ioctl.c:175:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *argp @@
   block/ioctl.c:175:16: sparse:     expected int *__ptr_clean
   block/ioctl.c:175:16: sparse:     got int [noderef] __user *argp
   block/ioctl.c:175:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/ioctl.c:175:16: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:175:16: sparse:     got int *__ptr_clean
>> block/ioctl.c:175:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   block/ioctl.c:175:16: sparse:     expected void [noderef] __user *__ptr_pu
   block/ioctl.c:175:16: sparse:     got int *__ptr_clean
>> block/ioctl.c:180:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user *argp @@
   block/ioctl.c:180:16: sparse:     expected unsigned int *__ptr_clean
   block/ioctl.c:180:16: sparse:     got unsigned int [noderef] __user *argp
>> block/ioctl.c:180:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   block/ioctl.c:180:16: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:180:16: sparse:     got unsigned int *__ptr_clean
>> block/ioctl.c:180:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   block/ioctl.c:180:16: sparse:     expected void [noderef] __user *__ptr_pu
   block/ioctl.c:180:16: sparse:     got unsigned int *__ptr_clean
>> block/ioctl.c:185:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long *__ptr_clean @@     got long [noderef] __user *argp @@
   block/ioctl.c:185:16: sparse:     expected long *__ptr_clean
   block/ioctl.c:185:16: sparse:     got long [noderef] __user *argp
>> block/ioctl.c:185:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long *__ptr_clean @@
   block/ioctl.c:185:16: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:185:16: sparse:     got long *__ptr_clean
>> block/ioctl.c:185:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got long *__ptr_clean @@
   block/ioctl.c:185:16: sparse:     expected void [noderef] __user *__ptr_pu
   block/ioctl.c:185:16: sparse:     got long *__ptr_clean
>> block/ioctl.c:190:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user *argp @@
   block/ioctl.c:190:16: sparse:     expected unsigned long *__ptr_clean
   block/ioctl.c:190:16: sparse:     got unsigned long [noderef] __user *argp
>> block/ioctl.c:190:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   block/ioctl.c:190:16: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:190:16: sparse:     got unsigned long *__ptr_clean
>> block/ioctl.c:190:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   block/ioctl.c:190:16: sparse:     expected void [noderef] __user *__ptr_pu
   block/ioctl.c:190:16: sparse:     got unsigned long *__ptr_clean
>> block/ioctl.c:195:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] [usertype] __user *argp @@
   block/ioctl.c:195:16: sparse:     expected unsigned long long *__ptr_clean
   block/ioctl.c:195:16: sparse:     got unsigned long long [noderef] [usertype] __user *argp
>> block/ioctl.c:195:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   block/ioctl.c:195:16: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:195:16: sparse:     got unsigned long long *__ptr_clean
>> block/ioctl.c:195:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   block/ioctl.c:195:16: sparse:     expected void [noderef] __user *__ptr_pu
   block/ioctl.c:195:16: sparse:     got unsigned long long *__ptr_clean
   block/ioctl.c:338:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   block/ioctl.c:338:13: sparse:     expected int *__ptr_clean
   block/ioctl.c:338:13: sparse:     got int [noderef] __user *
   block/ioctl.c:338:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/ioctl.c:338:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:338:13: sparse:     got int *__ptr_clean
   block/ioctl.c:424:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *argp @@
   block/ioctl.c:424:13: sparse:     expected int *__ptr_clean
   block/ioctl.c:424:13: sparse:     got int [noderef] __user *argp
   block/ioctl.c:424:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   block/ioctl.c:424:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:424:13: sparse:     got int *__ptr_clean
--
>> drivers/acpi/ec_sys.c:53:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user * @@
   drivers/acpi/ec_sys.c:53:21: sparse:     expected char *__ptr_clean
   drivers/acpi/ec_sys.c:53:21: sparse:     got char [noderef] __user *
   drivers/acpi/ec_sys.c:53:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   drivers/acpi/ec_sys.c:53:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/acpi/ec_sys.c:53:21: sparse:     got char *__ptr_clean
   drivers/acpi/ec_sys.c:53:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   drivers/acpi/ec_sys.c:53:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/acpi/ec_sys.c:53:21: sparse:     got char *__ptr_clean
>> drivers/acpi/ec_sys.c:87:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   drivers/acpi/ec_sys.c:87:21: sparse:     expected char const *__ptr_clean
   drivers/acpi/ec_sys.c:87:21: sparse:     got char const [noderef] __user *
   drivers/acpi/ec_sys.c:87:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/acpi/ec_sys.c:87:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/acpi/ec_sys.c:87:21: sparse:     got char const *__ptr_clean
--
>> drivers/char/hpet.c:317:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   drivers/char/hpet.c:317:18: sparse:     expected unsigned long *__ptr_clean
   drivers/char/hpet.c:317:18: sparse:     got unsigned long [noderef] __user *
>> drivers/char/hpet.c:317:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   drivers/char/hpet.c:317:18: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/hpet.c:317:18: sparse:     got unsigned long *__ptr_clean
>> drivers/char/hpet.c:317:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   drivers/char/hpet.c:317:18: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/char/hpet.c:317:18: sparse:     got unsigned long *__ptr_clean
--
>> drivers/char/mwave/3780i.c:499:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/char/mwave/3780i.c:499:20: sparse:     expected unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:499:20: sparse:     got unsigned short [noderef] __user *
>> drivers/char/mwave/3780i.c:499:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:499:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/mwave/3780i.c:499:20: sparse:     got unsigned short *__ptr_clean
>> drivers/char/mwave/3780i.c:499:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:499:20: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/char/mwave/3780i.c:499:20: sparse:     got unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:541:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/char/mwave/3780i.c:541:20: sparse:     expected unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:541:20: sparse:     got unsigned short [noderef] __user *
   drivers/char/mwave/3780i.c:541:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:541:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/mwave/3780i.c:541:20: sparse:     got unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:541:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:541:20: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/char/mwave/3780i.c:541:20: sparse:     got unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:580:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/char/mwave/3780i.c:580:20: sparse:     expected unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:580:20: sparse:     got unsigned short [noderef] __user *
   drivers/char/mwave/3780i.c:580:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:580:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/mwave/3780i.c:580:20: sparse:     got unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:629:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/char/mwave/3780i.c:629:20: sparse:     expected unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:629:20: sparse:     got unsigned short [noderef] __user *
   drivers/char/mwave/3780i.c:629:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:629:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/mwave/3780i.c:629:20: sparse:     got unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:629:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:629:20: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/char/mwave/3780i.c:629:20: sparse:     got unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:631:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/char/mwave/3780i.c:631:20: sparse:     expected unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:631:20: sparse:     got unsigned short [noderef] __user *
   drivers/char/mwave/3780i.c:631:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:631:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/mwave/3780i.c:631:20: sparse:     got unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:631:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:631:20: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/char/mwave/3780i.c:631:20: sparse:     got unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:674:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/char/mwave/3780i.c:674:20: sparse:     expected unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:674:20: sparse:     got unsigned short [noderef] __user *
   drivers/char/mwave/3780i.c:674:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:674:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/mwave/3780i.c:674:20: sparse:     got unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:676:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] __user * @@
   drivers/char/mwave/3780i.c:676:20: sparse:     expected unsigned short *__ptr_clean
   drivers/char/mwave/3780i.c:676:20: sparse:     got unsigned short [noderef] __user *
   drivers/char/mwave/3780i.c:676:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   drivers/char/mwave/3780i.c:676:20: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/char/mwave/3780i.c:676:20: sparse:     got unsigned short *__ptr_clean
--
   net/appletalk/ddp.c:100:33: sparse: sparse: restricted __be16 degrades to integer
   net/appletalk/ddp.c:113:33: sparse: sparse: restricted __be16 degrades to integer
   net/appletalk/ddp.c:409:47: sparse: sparse: restricted __be16 degrades to integer
>> net/appletalk/ddp.c:1811:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/appletalk/ddp.c:1811:22: sparse:     expected int *__ptr_clean
   net/appletalk/ddp.c:1811:22: sparse:     got int [noderef] __user *
>> net/appletalk/ddp.c:1811:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/appletalk/ddp.c:1811:22: sparse:     expected void const volatile [noderef] __user *ptr
   net/appletalk/ddp.c:1811:22: sparse:     got int *__ptr_clean
>> net/appletalk/ddp.c:1811:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/appletalk/ddp.c:1811:22: sparse:     expected void [noderef] __user *__ptr_pu
   net/appletalk/ddp.c:1811:22: sparse:     got int *__ptr_clean
   net/appletalk/ddp.c:1824:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/appletalk/ddp.c:1824:22: sparse:     expected int *__ptr_clean
   net/appletalk/ddp.c:1824:22: sparse:     got int [noderef] __user *
   net/appletalk/ddp.c:1824:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/appletalk/ddp.c:1824:22: sparse:     expected void const volatile [noderef] __user *ptr
   net/appletalk/ddp.c:1824:22: sparse:     got int *__ptr_clean
   net/appletalk/ddp.c:1824:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/appletalk/ddp.c:1824:22: sparse:     expected void [noderef] __user *__ptr_pu
   net/appletalk/ddp.c:1824:22: sparse:     got int *__ptr_clean
--
>> net/atm/svc.c:509:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/atm/svc.c:509:13: sparse:     expected int *__ptr_clean
   net/atm/svc.c:509:13: sparse:     got int [noderef] __user *optlen
>> net/atm/svc.c:509:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/atm/svc.c:509:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/svc.c:509:13: sparse:     got int *__ptr_clean
--
>> net/atm/ioctl.c:70:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/atm/ioctl.c:70:25: sparse:     expected int *__ptr_clean
   net/atm/ioctl.c:70:25: sparse:     got int [noderef] __user *
>> net/atm/ioctl.c:70:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/atm/ioctl.c:70:25: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:70:25: sparse:     got int *__ptr_clean
>> net/atm/ioctl.c:70:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/atm/ioctl.c:70:25: sparse:     expected void [noderef] __user *__ptr_pu
   net/atm/ioctl.c:70:25: sparse:     got int *__ptr_clean
   net/atm/ioctl.c:82:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/atm/ioctl.c:82:25: sparse:     expected int *__ptr_clean
   net/atm/ioctl.c:82:25: sparse:     got int [noderef] __user *
   net/atm/ioctl.c:82:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/atm/ioctl.c:82:25: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:82:25: sparse:     got int *__ptr_clean
   net/atm/ioctl.c:82:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/atm/ioctl.c:82:25: sparse:     expected void [noderef] __user *__ptr_pu
   net/atm/ioctl.c:82:25: sparse:     got int *__ptr_clean
>> net/atm/ioctl.c:125:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user * @@
   net/atm/ioctl.c:125:25: sparse:     expected unsigned short *__ptr_clean
   net/atm/ioctl.c:125:25: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/atm/ioctl.c:125:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/atm/ioctl.c:125:25: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:125:25: sparse:     got unsigned short *__ptr_clean
>> net/atm/ioctl.c:180:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user **__ptr_clean @@     got void [noderef] __user *[noderef] __user * @@
   net/atm/ioctl.c:180:29: sparse:     expected void [noderef] __user **__ptr_clean
   net/atm/ioctl.c:180:29: sparse:     got void [noderef] __user *[noderef] __user *
>> net/atm/ioctl.c:180:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got void [noderef] __user **__ptr_clean @@
   net/atm/ioctl.c:180:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:180:29: sparse:     got void [noderef] __user **__ptr_clean
   net/atm/ioctl.c:203:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user **__ptr_clean @@     got void [noderef] __user *[noderef] __user * @@
   net/atm/ioctl.c:203:29: sparse:     expected void [noderef] __user **__ptr_clean
   net/atm/ioctl.c:203:29: sparse:     got void [noderef] __user *[noderef] __user *
   net/atm/ioctl.c:203:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got void [noderef] __user **__ptr_clean @@
   net/atm/ioctl.c:203:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:203:29: sparse:     got void [noderef] __user **__ptr_clean
   net/atm/ioctl.c:205:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/atm/ioctl.c:205:29: sparse:     expected int *__ptr_clean
   net/atm/ioctl.c:205:29: sparse:     got int [noderef] __user *
   net/atm/ioctl.c:205:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/atm/ioctl.c:205:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:205:29: sparse:     got int *__ptr_clean
--
>> net/atm/resources.c:201:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *iobuf_len @@
   net/atm/resources.c:201:13: sparse:     expected int *__ptr_clean
   net/atm/resources.c:201:13: sparse:     got int [noderef] __user *iobuf_len
>> net/atm/resources.c:201:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/atm/resources.c:201:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/resources.c:201:13: sparse:     got int *__ptr_clean
   net/atm/resources.c:221:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *iobuf_len @@
   net/atm/resources.c:221:18: sparse:     expected int *__ptr_clean
   net/atm/resources.c:221:18: sparse:     got int [noderef] __user *iobuf_len
   net/atm/resources.c:221:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/atm/resources.c:221:18: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/resources.c:221:18: sparse:     got int *__ptr_clean
>> net/atm/resources.c:221:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/atm/resources.c:221:18: sparse:     expected void [noderef] __user *__ptr_pu
   net/atm/resources.c:221:18: sparse:     got int *__ptr_clean
>> net/atm/resources.c:233:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *sioc_len @@
   net/atm/resources.c:233:13: sparse:     expected int *__ptr_clean
   net/atm/resources.c:233:13: sparse:     got int [noderef] __user *sioc_len
   net/atm/resources.c:233:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/atm/resources.c:233:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/resources.c:233:13: sparse:     got int *__ptr_clean
   net/atm/resources.c:352:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *sioc_len @@
   net/atm/resources.c:352:25: sparse:     expected int *__ptr_clean
   net/atm/resources.c:352:25: sparse:     got int [noderef] __user *sioc_len
   net/atm/resources.c:352:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/atm/resources.c:352:25: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/resources.c:352:25: sparse:     got int *__ptr_clean
   net/atm/resources.c:352:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/atm/resources.c:352:25: sparse:     expected void [noderef] __user *__ptr_pu
   net/atm/resources.c:352:25: sparse:     got int *__ptr_clean
   net/atm/resources.c:395:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *sioc_len @@
   net/atm/resources.c:395:25: sparse:     expected int *__ptr_clean
   net/atm/resources.c:395:25: sparse:     got int [noderef] __user *sioc_len
   net/atm/resources.c:395:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/atm/resources.c:395:25: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/resources.c:395:25: sparse:     got int *__ptr_clean
   net/atm/resources.c:395:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/atm/resources.c:395:25: sparse:     expected void [noderef] __user *__ptr_pu
   net/atm/resources.c:395:25: sparse:     got int *__ptr_clean
--
>> net/atm/common.c:795:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/atm/common.c:795:13: sparse:     expected int *__ptr_clean
   net/atm/common.c:795:13: sparse:     got int [noderef] __user *optlen
>> net/atm/common.c:795:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/atm/common.c:795:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/common.c:795:13: sparse:     got int *__ptr_clean
>> net/atm/common.c:808:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   net/atm/common.c:808:24: sparse:     expected unsigned long *__ptr_clean
   net/atm/common.c:808:24: sparse:     got unsigned long [noderef] __user *
>> net/atm/common.c:808:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   net/atm/common.c:808:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/common.c:808:24: sparse:     got unsigned long *__ptr_clean
>> net/atm/common.c:808:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   net/atm/common.c:808:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/atm/common.c:808:24: sparse:     got unsigned long *__ptr_clean
--
>> drivers/fpga/dfl.c:1831:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/fpga/dfl.c:1831:16: sparse:     expected unsigned int *__ptr_clean
   drivers/fpga/dfl.c:1831:16: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/fpga/dfl.c:1831:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/fpga/dfl.c:1831:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fpga/dfl.c:1831:16: sparse:     got unsigned int *__ptr_clean
   drivers/fpga/dfl.c:1831:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/fpga/dfl.c:1831:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/fpga/dfl.c:1831:16: sparse:     got unsigned int *__ptr_clean
--
>> drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected int *__ptr_clean
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int [noderef] __user *
   drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int *__ptr_clean
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected int *__ptr_clean
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int [noderef] __user *
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int *__ptr_clean
--
>> net/bluetooth/af_bluetooth.c:511:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/bluetooth/af_bluetooth.c:511:23: sparse:     expected int *__ptr_clean
   net/bluetooth/af_bluetooth.c:511:23: sparse:     got int [noderef] __user *
   net/bluetooth/af_bluetooth.c:511:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/af_bluetooth.c:511:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/af_bluetooth.c:511:23: sparse:     got int *__ptr_clean
   net/bluetooth/af_bluetooth.c:511:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/bluetooth/af_bluetooth.c:511:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/af_bluetooth.c:511:23: sparse:     got int *__ptr_clean
   net/bluetooth/af_bluetooth.c:522:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/bluetooth/af_bluetooth.c:522:23: sparse:     expected int *__ptr_clean
   net/bluetooth/af_bluetooth.c:522:23: sparse:     got int [noderef] __user *
   net/bluetooth/af_bluetooth.c:522:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/af_bluetooth.c:522:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/af_bluetooth.c:522:23: sparse:     got int *__ptr_clean
   net/bluetooth/af_bluetooth.c:522:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/bluetooth/af_bluetooth.c:522:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/af_bluetooth.c:522:23: sparse:     got int *__ptr_clean
   net/bluetooth/af_bluetooth.c:176:25: sparse: sparse: context imbalance in 'bt_accept_enqueue' - different lock contexts for basic block
--
>> net/bluetooth/hci_core.c:825:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/hci_core.c:825:13: sparse:     expected unsigned short *__ptr_clean
   net/bluetooth/hci_core.c:825:13: sparse:     got unsigned short [noderef] [usertype] __user *
   net/bluetooth/hci_core.c:825:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/bluetooth/hci_core.c:825:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_core.c:825:13: sparse:     got unsigned short *__ptr_clean
--
>> net/bluetooth/hci_sock.c:1968:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/bluetooth/hci_sock.c:1968:13: sparse:     expected int *__ptr_clean
   net/bluetooth/hci_sock.c:1968:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/hci_sock.c:1968:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/hci_sock.c:1968:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:1968:13: sparse:     got int *__ptr_clean
>> net/bluetooth/hci_sock.c:1985:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *optval @@
   net/bluetooth/hci_sock.c:1985:21: sparse:     expected char *__ptr_clean
   net/bluetooth/hci_sock.c:1985:21: sparse:     got char [noderef] __user *optval
   net/bluetooth/hci_sock.c:1985:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/bluetooth/hci_sock.c:1985:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:1985:21: sparse:     got char *__ptr_clean
   net/bluetooth/hci_sock.c:1985:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/bluetooth/hci_sock.c:1985:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/hci_sock.c:1985:21: sparse:     got char *__ptr_clean
   net/bluetooth/hci_sock.c:1995:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__ptr_clean @@     got char [noderef] __user *optval @@
   net/bluetooth/hci_sock.c:1995:21: sparse:     expected char *__ptr_clean
   net/bluetooth/hci_sock.c:1995:21: sparse:     got char [noderef] __user *optval
   net/bluetooth/hci_sock.c:1995:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char *__ptr_clean @@
   net/bluetooth/hci_sock.c:1995:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:1995:21: sparse:     got char *__ptr_clean
   net/bluetooth/hci_sock.c:1995:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got char *__ptr_clean @@
   net/bluetooth/hci_sock.c:1995:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/hci_sock.c:1995:21: sparse:     got char *__ptr_clean
>> net/bluetooth/hci_sock.c:2045:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/hci_sock.c:2045:21: sparse:     expected unsigned short *__ptr_clean
   net/bluetooth/hci_sock.c:2045:21: sparse:     got unsigned short [noderef] [usertype] __user *
   net/bluetooth/hci_sock.c:2045:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/bluetooth/hci_sock.c:2045:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:2045:21: sparse:     got unsigned short *__ptr_clean
   net/bluetooth/hci_sock.c:2045:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   net/bluetooth/hci_sock.c:2045:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/hci_sock.c:2045:21: sparse:     got unsigned short *__ptr_clean
--
>> net/bluetooth/l2cap_sock.c:464:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/bluetooth/l2cap_sock.c:464:13: sparse:     expected int *__ptr_clean
   net/bluetooth/l2cap_sock.c:464:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/l2cap_sock.c:464:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:464:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:464:13: sparse:     got int *__ptr_clean
>> net/bluetooth/l2cap_sock.c:539:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/l2cap_sock.c:539:21: sparse:     expected unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:539:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/l2cap_sock.c:539:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:539:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:539:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:539:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:539:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:539:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:589:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/bluetooth/l2cap_sock.c:589:13: sparse:     expected int *__ptr_clean
   net/bluetooth/l2cap_sock.c:589:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/l2cap_sock.c:589:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:589:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:589:13: sparse:     got int *__ptr_clean
   net/bluetooth/l2cap_sock.c:625:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/l2cap_sock.c:625:21: sparse:     expected unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:625:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/l2cap_sock.c:625:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:625:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:625:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:625:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:625:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:625:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:632:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/l2cap_sock.c:632:21: sparse:     expected unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:632:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/l2cap_sock.c:632:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:632:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:632:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:632:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:632:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:632:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:654:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/l2cap_sock.c:654:21: sparse:     expected unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:654:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/l2cap_sock.c:654:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:654:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:654:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:654:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:654:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:654:21: sparse:     got unsigned int *__ptr_clean
>> net/bluetooth/l2cap_sock.c:669:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/l2cap_sock.c:669:21: sparse:     expected unsigned short *__ptr_clean
   net/bluetooth/l2cap_sock.c:669:21: sparse:     got unsigned short [noderef] [usertype] __user *
   net/bluetooth/l2cap_sock.c:669:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:669:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:669:21: sparse:     got unsigned short *__ptr_clean
   net/bluetooth/l2cap_sock.c:669:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:669:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:669:21: sparse:     got unsigned short *__ptr_clean
   net/bluetooth/l2cap_sock.c:679:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/l2cap_sock.c:679:21: sparse:     expected unsigned short *__ptr_clean
   net/bluetooth/l2cap_sock.c:679:21: sparse:     got unsigned short [noderef] [usertype] __user *
   net/bluetooth/l2cap_sock.c:679:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:679:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:679:21: sparse:     got unsigned short *__ptr_clean
   net/bluetooth/l2cap_sock.c:679:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:679:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:679:21: sparse:     got unsigned short *__ptr_clean
   net/bluetooth/l2cap_sock.c:691:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/l2cap_sock.c:691:21: sparse:     expected unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:691:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/l2cap_sock.c:691:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:691:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:691:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/l2cap_sock.c:691:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:691:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:691:21: sparse:     got unsigned int *__ptr_clean
>> net/bluetooth/l2cap_sock.c:712:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__ptr_clean @@     got unsigned char [noderef] [usertype] __user * @@
   net/bluetooth/l2cap_sock.c:712:21: sparse:     expected unsigned char *__ptr_clean
   net/bluetooth/l2cap_sock.c:712:21: sparse:     got unsigned char [noderef] [usertype] __user *
   net/bluetooth/l2cap_sock.c:712:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:712:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:712:21: sparse:     got unsigned char *__ptr_clean
   net/bluetooth/l2cap_sock.c:712:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned char *__ptr_clean @@
   net/bluetooth/l2cap_sock.c:712:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/l2cap_sock.c:712:21: sparse:     got unsigned char *__ptr_clean
--
   net/bluetooth/sco.c: note: in included file:
   include/net/bluetooth/hci_core.h:144:35: sparse: sparse: array of flexible structures
>> net/bluetooth/sco.c:976:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:976:13: sparse:     expected int *__ptr_clean
   net/bluetooth/sco.c:976:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/sco.c:976:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/sco.c:976:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:976:13: sparse:     got int *__ptr_clean
   net/bluetooth/sco.c:1047:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:1047:13: sparse:     expected int *__ptr_clean
   net/bluetooth/sco.c:1047:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/sco.c:1047:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/sco.c:1047:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:1047:13: sparse:     got int *__ptr_clean
>> net/bluetooth/sco.c:1060:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/sco.c:1060:21: sparse:     expected unsigned int *__ptr_clean
   net/bluetooth/sco.c:1060:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/bluetooth/sco.c:1060:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/sco.c:1060:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:1060:21: sparse:     got unsigned int *__ptr_clean
>> net/bluetooth/sco.c:1060:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/sco.c:1060:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/sco.c:1060:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/sco.c:1083:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/sco.c:1083:21: sparse:     expected unsigned int *__ptr_clean
   net/bluetooth/sco.c:1083:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/sco.c:1083:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/sco.c:1083:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:1083:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/sco.c:1083:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/sco.c:1083:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/sco.c:1083:21: sparse:     got unsigned int *__ptr_clean
>> net/bluetooth/sco.c:1090:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/bluetooth/sco.c:1090:21: sparse:     expected int *__ptr_clean
   net/bluetooth/sco.c:1090:21: sparse:     got int [noderef] __user *
   net/bluetooth/sco.c:1090:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/sco.c:1090:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:1090:21: sparse:     got int *__ptr_clean
>> net/bluetooth/sco.c:1090:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/bluetooth/sco.c:1090:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/sco.c:1090:21: sparse:     got int *__ptr_clean
   net/bluetooth/sco.c:1101:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/sco.c:1101:21: sparse:     expected unsigned int *__ptr_clean
   net/bluetooth/sco.c:1101:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/sco.c:1101:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/sco.c:1101:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:1101:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/sco.c:1101:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/sco.c:1101:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/sco.c:1101:21: sparse:     got unsigned int *__ptr_clean
>> net/bluetooth/sco.c:1149:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__ptr_clean @@     got unsigned char [noderef] [usertype] __user *[assigned] ptr @@
   net/bluetooth/sco.c:1149:21: sparse:     expected unsigned char *__ptr_clean
   net/bluetooth/sco.c:1149:21: sparse:     got unsigned char [noderef] [usertype] __user *[assigned] ptr
>> net/bluetooth/sco.c:1149:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char *__ptr_clean @@
   net/bluetooth/sco.c:1149:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:1149:21: sparse:     got unsigned char *__ptr_clean
>> net/bluetooth/sco.c:1149:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned char *__ptr_clean @@
   net/bluetooth/sco.c:1149:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/sco.c:1149:21: sparse:     got unsigned char *__ptr_clean
   net/bluetooth/sco.c:1192:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:1192:29: sparse:     expected int *__ptr_clean
   net/bluetooth/sco.c:1192:29: sparse:     got int [noderef] __user *optlen
   net/bluetooth/sco.c:1192:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/sco.c:1192:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:1192:29: sparse:     got int *__ptr_clean
   net/bluetooth/sco.c:1192:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/bluetooth/sco.c:1192:29: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/sco.c:1192:29: sparse:     got int *__ptr_clean
--
>> net/bluetooth/rfcomm/sock.c:743:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:743:13: sparse:     expected int *__ptr_clean
   net/bluetooth/rfcomm/sock.c:743:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/rfcomm/sock.c:743:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/rfcomm/sock.c:743:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/sock.c:743:13: sparse:     got int *__ptr_clean
>> net/bluetooth/rfcomm/sock.c:773:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/rfcomm/sock.c:773:21: sparse:     expected unsigned int *__ptr_clean
   net/bluetooth/rfcomm/sock.c:773:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/bluetooth/rfcomm/sock.c:773:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/rfcomm/sock.c:773:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/sock.c:773:21: sparse:     got unsigned int *__ptr_clean
>> net/bluetooth/rfcomm/sock.c:773:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/rfcomm/sock.c:773:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/rfcomm/sock.c:773:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/rfcomm/sock.c:821:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:821:13: sparse:     expected int *__ptr_clean
   net/bluetooth/rfcomm/sock.c:821:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/rfcomm/sock.c:821:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/bluetooth/rfcomm/sock.c:821:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/sock.c:821:13: sparse:     got int *__ptr_clean
   net/bluetooth/rfcomm/sock.c:848:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/rfcomm/sock.c:848:21: sparse:     expected unsigned int *__ptr_clean
   net/bluetooth/rfcomm/sock.c:848:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/rfcomm/sock.c:848:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/bluetooth/rfcomm/sock.c:848:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/sock.c:848:21: sparse:     got unsigned int *__ptr_clean
   net/bluetooth/rfcomm/sock.c:848:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/bluetooth/rfcomm/sock.c:848:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/bluetooth/rfcomm/sock.c:848:21: sparse:     got unsigned int *__ptr_clean
--
>> net/bluetooth/rfcomm/tty.c:513:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/rfcomm/tty.c:513:13: sparse:     expected unsigned short *__ptr_clean
   net/bluetooth/rfcomm/tty.c:513:13: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/bluetooth/rfcomm/tty.c:513:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/bluetooth/rfcomm/tty.c:513:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/tty.c:513:13: sparse:     got unsigned short *__ptr_clean
--
>> drivers/hwmon/fschmd.c:866:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__ptr_clean @@     got char const [noderef] __user * @@
   drivers/hwmon/fschmd.c:866:37: sparse:     expected char const *__ptr_clean
   drivers/hwmon/fschmd.c:866:37: sparse:     got char const [noderef] __user *
>> drivers/hwmon/fschmd.c:866:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__ptr_clean @@
   drivers/hwmon/fschmd.c:866:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/fschmd.c:866:37: sparse:     got char const *__ptr_clean
>> drivers/hwmon/fschmd.c:900:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/fschmd.c:900:23: sparse:     expected int *__ptr_clean
   drivers/hwmon/fschmd.c:900:23: sparse:     got int [noderef] __user *
>> drivers/hwmon/fschmd.c:900:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:900:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/fschmd.c:900:23: sparse:     got int *__ptr_clean
>> drivers/hwmon/fschmd.c:900:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:900:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/hwmon/fschmd.c:900:23: sparse:     got int *__ptr_clean
   drivers/hwmon/fschmd.c:905:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/fschmd.c:905:31: sparse:     expected int *__ptr_clean
   drivers/hwmon/fschmd.c:905:31: sparse:     got int [noderef] __user *
   drivers/hwmon/fschmd.c:905:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:905:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/fschmd.c:905:31: sparse:     got int *__ptr_clean
   drivers/hwmon/fschmd.c:905:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:905:31: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/hwmon/fschmd.c:905:31: sparse:     got int *__ptr_clean
   drivers/hwmon/fschmd.c:907:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/fschmd.c:907:31: sparse:     expected int *__ptr_clean
   drivers/hwmon/fschmd.c:907:31: sparse:     got int [noderef] __user *
   drivers/hwmon/fschmd.c:907:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:907:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/fschmd.c:907:31: sparse:     got int *__ptr_clean
   drivers/hwmon/fschmd.c:907:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:907:31: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/hwmon/fschmd.c:907:31: sparse:     got int *__ptr_clean
   drivers/hwmon/fschmd.c:916:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/fschmd.c:916:23: sparse:     expected int *__ptr_clean
   drivers/hwmon/fschmd.c:916:23: sparse:     got int [noderef] __user *
   drivers/hwmon/fschmd.c:916:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:916:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/fschmd.c:916:23: sparse:     got int *__ptr_clean
   drivers/hwmon/fschmd.c:916:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:916:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/hwmon/fschmd.c:916:23: sparse:     got int *__ptr_clean
   drivers/hwmon/fschmd.c:920:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/fschmd.c:920:21: sparse:     expected int *__ptr_clean
   drivers/hwmon/fschmd.c:920:21: sparse:     got int [noderef] __user *
   drivers/hwmon/fschmd.c:920:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:920:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/fschmd.c:920:21: sparse:     got int *__ptr_clean
   drivers/hwmon/fschmd.c:926:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/fschmd.c:926:31: sparse:     expected int *__ptr_clean
   drivers/hwmon/fschmd.c:926:31: sparse:     got int [noderef] __user *
   drivers/hwmon/fschmd.c:926:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:926:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/fschmd.c:926:31: sparse:     got int *__ptr_clean
   drivers/hwmon/fschmd.c:926:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:926:31: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/hwmon/fschmd.c:926:31: sparse:     got int *__ptr_clean
   drivers/hwmon/fschmd.c:930:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/hwmon/fschmd.c:930:21: sparse:     expected int *__ptr_clean
   drivers/hwmon/fschmd.c:930:21: sparse:     got int [noderef] __user *
   drivers/hwmon/fschmd.c:930:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/hwmon/fschmd.c:930:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hwmon/fschmd.c:930:21: sparse:     got int *__ptr_clean
--
>> net/can/isotp.c:1399:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/can/isotp.c:1399:13: sparse:     expected int *__ptr_clean
   net/can/isotp.c:1399:13: sparse:     got int [noderef] __user *optlen
>> net/can/isotp.c:1399:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/can/isotp.c:1399:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/can/isotp.c:1399:13: sparse:     got int *__ptr_clean
   net/can/isotp.c:1434:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/can/isotp.c:1434:13: sparse:     expected int *__ptr_clean
   net/can/isotp.c:1434:13: sparse:     got int [noderef] __user *optlen
   net/can/isotp.c:1434:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/can/isotp.c:1434:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/can/isotp.c:1434:13: sparse:     got int *__ptr_clean
>> net/can/isotp.c:1434:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/can/isotp.c:1434:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/can/isotp.c:1434:13: sparse:     got int *__ptr_clean
--
>> net/can/j1939/socket.c:752:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/can/j1939/socket.c:752:13: sparse:     expected int *__ptr_clean
   net/can/j1939/socket.c:752:13: sparse:     got int [noderef] __user *optlen
>> net/can/j1939/socket.c:752:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/can/j1939/socket.c:752:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/can/j1939/socket.c:752:13: sparse:     got int *__ptr_clean
   net/can/j1939/socket.c:779:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/can/j1939/socket.c:779:18: sparse:     expected int *__ptr_clean
   net/can/j1939/socket.c:779:18: sparse:     got int [noderef] __user *optlen
   net/can/j1939/socket.c:779:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/can/j1939/socket.c:779:18: sparse:     expected void const volatile [noderef] __user *ptr
   net/can/j1939/socket.c:779:18: sparse:     got int *__ptr_clean
>> net/can/j1939/socket.c:779:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/can/j1939/socket.c:779:18: sparse:     expected void [noderef] __user *__ptr_pu
   net/can/j1939/socket.c:779:18: sparse:     got int *__ptr_clean
--
>> net/decnet/af_decnet.c:1537:12: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/decnet/af_decnet.c:1537:12: sparse:     expected int *__ptr_clean
   net/decnet/af_decnet.c:1537:12: sparse:     got int [noderef] __user *optlen
   net/decnet/af_decnet.c:1537:12: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1537:12: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1537:12: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:1632:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/decnet/af_decnet.c:1632:21: sparse:     expected int *__ptr_clean
   net/decnet/af_decnet.c:1632:21: sparse:     got int [noderef] __user *optlen
   net/decnet/af_decnet.c:1632:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1632:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1632:21: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:1632:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1632:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/decnet/af_decnet.c:1632:21: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:250:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int hash @@     got restricted __le16 [usertype] sdn_objnamel @@
   net/decnet/af_decnet.c:250:22: sparse:     expected unsigned int hash
   net/decnet/af_decnet.c:250:22: sparse:     got restricted __le16 [usertype] sdn_objnamel
>> net/decnet/af_decnet.c:1239:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/decnet/af_decnet.c:1239:23: sparse:     expected int *__ptr_clean
   net/decnet/af_decnet.c:1239:23: sparse:     got int [noderef] __user *
   net/decnet/af_decnet.c:1239:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1239:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1239:23: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:1239:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1239:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/decnet/af_decnet.c:1239:23: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:1252:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/decnet/af_decnet.c:1252:23: sparse:     expected int *__ptr_clean
   net/decnet/af_decnet.c:1252:23: sparse:     got int [noderef] __user *
   net/decnet/af_decnet.c:1252:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1252:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1252:23: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c:1252:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/decnet/af_decnet.c:1252:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/decnet/af_decnet.c:1252:23: sparse:     got int *__ptr_clean
   net/decnet/af_decnet.c: note: in included file:
   include/net/dn.h:192:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] sport @@     got restricted __le16 [usertype] addrloc @@
   include/net/dn.h:192:24: sparse:     expected restricted __be16 [usertype] sport
   include/net/dn.h:192:24: sparse:     got restricted __le16 [usertype] addrloc
   include/net/dn.h:193:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] dport @@     got restricted __le16 [usertype] addrrem @@
   include/net/dn.h:193:24: sparse:     expected restricted __be16 [usertype] dport
   include/net/dn.h:193:24: sparse:     got restricted __le16 [usertype] addrrem
   net/decnet/af_decnet.c:2164:9: sparse: sparse: context imbalance in 'dn_socket_get_idx' - wrong count at exit
   net/decnet/af_decnet.c:2184:9: sparse: sparse: context imbalance in 'dn_socket_seq_next' - unexpected unlock
   net/decnet/af_decnet.c:2193:17: sparse: sparse: context imbalance in 'dn_socket_seq_stop' - unexpected unlock
--
>> net/ieee802154/socket.c:533:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/ieee802154/socket.c:533:24: sparse:     expected int *__ptr_clean
   net/ieee802154/socket.c:533:24: sparse:     got int [noderef] __user *
>> net/ieee802154/socket.c:533:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ieee802154/socket.c:533:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ieee802154/socket.c:533:24: sparse:     got int *__ptr_clean
>> net/ieee802154/socket.c:533:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ieee802154/socket.c:533:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ieee802154/socket.c:533:24: sparse:     got int *__ptr_clean
   net/ieee802154/socket.c:552:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/ieee802154/socket.c:552:24: sparse:     expected int *__ptr_clean
   net/ieee802154/socket.c:552:24: sparse:     got int [noderef] __user *
   net/ieee802154/socket.c:552:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ieee802154/socket.c:552:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/ieee802154/socket.c:552:24: sparse:     got int *__ptr_clean
   net/ieee802154/socket.c:552:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ieee802154/socket.c:552:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/ieee802154/socket.c:552:24: sparse:     got int *__ptr_clean
>> net/ieee802154/socket.c:836:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ieee802154/socket.c:836:13: sparse:     expected int *__ptr_clean
   net/ieee802154/socket.c:836:13: sparse:     got int [noderef] __user *optlen
   net/ieee802154/socket.c:836:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ieee802154/socket.c:836:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ieee802154/socket.c:836:13: sparse:     got int *__ptr_clean
   net/ieee802154/socket.c:866:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/ieee802154/socket.c:866:13: sparse:     expected int *__ptr_clean
   net/ieee802154/socket.c:866:13: sparse:     got int [noderef] __user *optlen
   net/ieee802154/socket.c:866:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/ieee802154/socket.c:866:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ieee802154/socket.c:866:13: sparse:     got int *__ptr_clean
   net/ieee802154/socket.c:866:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/ieee802154/socket.c:866:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/ieee802154/socket.c:866:13: sparse:     got int *__ptr_clean
--
>> net/llc/af_llc.c:1171:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/llc/af_llc.c:1171:14: sparse:     expected int *__ptr_clean
   net/llc/af_llc.c:1171:14: sparse:     got int [noderef] __user *optlen
   net/llc/af_llc.c:1171:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/llc/af_llc.c:1171:14: sparse:     expected void const volatile [noderef] __user *ptr
   net/llc/af_llc.c:1171:14: sparse:     got int *__ptr_clean
   net/llc/af_llc.c:1202:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/llc/af_llc.c:1202:13: sparse:     expected int *__ptr_clean
   net/llc/af_llc.c:1202:13: sparse:     got int [noderef] __user *optlen
   net/llc/af_llc.c:1202:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/llc/af_llc.c:1202:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/llc/af_llc.c:1202:13: sparse:     got int *__ptr_clean
   net/llc/af_llc.c:1202:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/llc/af_llc.c:1202:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/llc/af_llc.c:1202:13: sparse:     got int *__ptr_clean
--
>> drivers/media/rc/lirc_dev.c:365:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/media/rc/lirc_dev.c:365:23: sparse:     expected unsigned int *__ptr_clean
   drivers/media/rc/lirc_dev.c:365:23: sparse:     got unsigned int [noderef] [usertype] __user *argp
>> drivers/media/rc/lirc_dev.c:365:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/media/rc/lirc_dev.c:365:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/media/rc/lirc_dev.c:365:23: sparse:     got unsigned int *__ptr_clean
   drivers/media/rc/lirc_dev.c:569:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/media/rc/lirc_dev.c:569:23: sparse:     expected unsigned int *__ptr_clean
   drivers/media/rc/lirc_dev.c:569:23: sparse:     got unsigned int [noderef] [usertype] __user *argp
   drivers/media/rc/lirc_dev.c:569:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/media/rc/lirc_dev.c:569:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/media/rc/lirc_dev.c:569:23: sparse:     got unsigned int *__ptr_clean
>> drivers/media/rc/lirc_dev.c:569:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/media/rc/lirc_dev.c:569:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/media/rc/lirc_dev.c:569:23: sparse:     got unsigned int *__ptr_clean
--
>> drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *vptr @@
   drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse:     expected int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse:     got int [noderef] __user *vptr
>> drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/vmw_vmci/vmci_host.c:260:21: sparse:     got int *__ptr_clean
>> drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *[assigned] retptr @@
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     expected int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     got int [noderef] __user *[assigned] retptr
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     got int *__ptr_clean
>> drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/misc/vmw_vmci/vmci_host.c:498:13: sparse:     got int *__ptr_clean
>> drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     expected signed int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     got signed int [noderef] __user *
>> drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     got signed int *__ptr_clean
>> drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/misc/vmw_vmci/vmci_host.c:547:16: sparse:     got signed int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     expected signed int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     got signed int [noderef] __user *
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     got signed int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/misc/vmw_vmci/vmci_host.c:589:13: sparse:     got signed int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     expected signed int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     got signed int [noderef] __user *
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     got signed int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/misc/vmw_vmci/vmci_host.c:603:21: sparse:     got signed int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__ptr_clean @@     got signed int [noderef] __user * @@
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     expected signed int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     got signed int [noderef] __user *
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     got signed int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got signed int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/misc/vmw_vmci/vmci_host.c:651:16: sparse:     got signed int *__ptr_clean
>> drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     expected int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     got int [noderef] __user *
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     got int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/misc/vmw_vmci/vmci_host.c:674:16: sparse:     got int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     expected int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     got int [noderef] __user *
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     got int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/misc/vmw_vmci/vmci_host.c:698:16: sparse:     got int *__ptr_clean
>> drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *u32ptr @@
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     expected unsigned int *__ptr_clean
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     got unsigned int [noderef] [usertype] __user *u32ptr
>> drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     got unsigned int *__ptr_clean
>> drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/misc/vmw_vmci/vmci_host.c:771:16: sparse:     got unsigned int *__ptr_clean
--
>> drivers/nvme/host/ioctl.c:246:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/nvme/host/ioctl.c:246:21: sparse:     expected unsigned int *__ptr_clean
   drivers/nvme/host/ioctl.c:246:21: sparse:     got unsigned int [noderef] __user *
   drivers/nvme/host/ioctl.c:246:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/nvme/host/ioctl.c:246:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/nvme/host/ioctl.c:246:21: sparse:     got unsigned int *__ptr_clean
   drivers/nvme/host/ioctl.c:246:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/nvme/host/ioctl.c:246:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/nvme/host/ioctl.c:246:21: sparse:     got unsigned int *__ptr_clean
>> drivers/nvme/host/ioctl.c:292:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/nvme/host/ioctl.c:292:21: sparse:     expected unsigned long long *__ptr_clean
   drivers/nvme/host/ioctl.c:292:21: sparse:     got unsigned long long [noderef] __user *
   drivers/nvme/host/ioctl.c:292:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/nvme/host/ioctl.c:292:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/nvme/host/ioctl.c:292:21: sparse:     got unsigned long long *__ptr_clean
   drivers/nvme/host/ioctl.c:292:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/nvme/host/ioctl.c:292:21: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/nvme/host/ioctl.c:292:21: sparse:     got unsigned long long *__ptr_clean
--
>> drivers/platform/x86/wmi.c:903:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/platform/x86/wmi.c:903:13: sparse:     expected unsigned long long *__ptr_clean
   drivers/platform/x86/wmi.c:903:13: sparse:     got unsigned long long [noderef] __user *
   drivers/platform/x86/wmi.c:903:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/platform/x86/wmi.c:903:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/platform/x86/wmi.c:903:13: sparse:     got unsigned long long *__ptr_clean
--
>> net/nfc/llcp_sock.c:319:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/nfc/llcp_sock.c:319:13: sparse:     expected int *__ptr_clean
   net/nfc/llcp_sock.c:319:13: sparse:     got int [noderef] __user *optlen
   net/nfc/llcp_sock.c:319:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/nfc/llcp_sock.c:319:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:319:13: sparse:     got int *__ptr_clean
>> net/nfc/llcp_sock.c:333:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/nfc/llcp_sock.c:333:21: sparse:     expected unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:333:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/nfc/llcp_sock.c:333:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:333:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:333:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:333:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:333:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:333:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:342:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/nfc/llcp_sock.c:342:21: sparse:     expected unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:342:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/nfc/llcp_sock.c:342:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:342:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:342:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:342:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:342:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:342:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:351:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/nfc/llcp_sock.c:351:21: sparse:     expected unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:351:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/nfc/llcp_sock.c:351:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:351:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:351:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:351:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:351:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:351:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:357:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/nfc/llcp_sock.c:357:21: sparse:     expected unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:357:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/nfc/llcp_sock.c:357:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:357:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:357:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:357:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:357:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:357:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:363:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/nfc/llcp_sock.c:363:21: sparse:     expected unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:363:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/nfc/llcp_sock.c:363:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:363:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:363:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:363:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/nfc/llcp_sock.c:363:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:363:21: sparse:     got unsigned int *__ptr_clean
   net/nfc/llcp_sock.c:375:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/nfc/llcp_sock.c:375:13: sparse:     expected int *__ptr_clean
   net/nfc/llcp_sock.c:375:13: sparse:     got int [noderef] __user *optlen
   net/nfc/llcp_sock.c:375:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/nfc/llcp_sock.c:375:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:375:13: sparse:     got int *__ptr_clean
   net/nfc/llcp_sock.c:375:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/nfc/llcp_sock.c:375:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/nfc/llcp_sock.c:375:13: sparse:     got int *__ptr_clean
--
>> drivers/rtc/dev.c:182:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/dev.c:182:31: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/dev.c:182:31: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/dev.c:182:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/dev.c:182:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/dev.c:182:31: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/dev.c:182:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/dev.c:182:31: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/dev.c:182:31: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/dev.c:185:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   drivers/rtc/dev.c:185:31: sparse:     expected unsigned long *__ptr_clean
   drivers/rtc/dev.c:185:31: sparse:     got unsigned long [noderef] __user *
>> drivers/rtc/dev.c:185:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   drivers/rtc/dev.c:185:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/dev.c:185:31: sparse:     got unsigned long *__ptr_clean
>> drivers/rtc/dev.c:185:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   drivers/rtc/dev.c:185:31: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/dev.c:185:31: sparse:     got unsigned long *__ptr_clean
   drivers/rtc/dev.c:367:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long *__ptr_clean @@     got unsigned long [noderef] __user * @@
   drivers/rtc/dev.c:367:23: sparse:     expected unsigned long *__ptr_clean
   drivers/rtc/dev.c:367:23: sparse:     got unsigned long [noderef] __user *
   drivers/rtc/dev.c:367:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *__ptr_clean @@
   drivers/rtc/dev.c:367:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/dev.c:367:23: sparse:     got unsigned long *__ptr_clean
   drivers/rtc/dev.c:367:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long *__ptr_clean @@
   drivers/rtc/dev.c:367:23: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/dev.c:367:23: sparse:     got unsigned long *__ptr_clean
--
>> drivers/rtc/rtc-m41t80.c:741:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/rtc/rtc-m41t80.c:741:24: sparse:     expected int *__ptr_clean
   drivers/rtc/rtc-m41t80.c:741:24: sparse:     got int [noderef] __user *
>> drivers/rtc/rtc-m41t80.c:741:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/rtc/rtc-m41t80.c:741:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-m41t80.c:741:24: sparse:     got int *__ptr_clean
>> drivers/rtc/rtc-m41t80.c:741:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/rtc/rtc-m41t80.c:741:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-m41t80.c:741:24: sparse:     got int *__ptr_clean
   drivers/rtc/rtc-m41t80.c:746:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/rtc/rtc-m41t80.c:746:21: sparse:     expected int *__ptr_clean
   drivers/rtc/rtc-m41t80.c:746:21: sparse:     got int [noderef] __user *
   drivers/rtc/rtc-m41t80.c:746:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/rtc/rtc-m41t80.c:746:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-m41t80.c:746:21: sparse:     got int *__ptr_clean
   drivers/rtc/rtc-m41t80.c:755:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   drivers/rtc/rtc-m41t80.c:755:24: sparse:     expected int *__ptr_clean
   drivers/rtc/rtc-m41t80.c:755:24: sparse:     got int [noderef] __user *
   drivers/rtc/rtc-m41t80.c:755:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   drivers/rtc/rtc-m41t80.c:755:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-m41t80.c:755:24: sparse:     got int *__ptr_clean
   drivers/rtc/rtc-m41t80.c:755:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   drivers/rtc/rtc-m41t80.c:755:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-m41t80.c:755:24: sparse:     got int *__ptr_clean
--
>> drivers/rtc/rtc-rv3028.c:597:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-rv3028.c:597:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-rv3028.c:597:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-rv3028.c:597:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/rtc/rtc-rs5c372.c:527:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-rs5c372.c:527:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-rs5c372.c:527:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-rs5c372.c:527:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rs5c372.c:527:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-rs5c372.c:527:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-rs5c372.c:527:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rs5c372.c:527:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-rs5c372.c:527:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/rtc/rtc-rv3032.c:480:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/rtc/rtc-rv3032.c:480:24: sparse:     expected unsigned int *__ptr_clean
   drivers/rtc/rtc-rv3032.c:480:24: sparse:     got unsigned int [noderef] __user *
>> drivers/rtc/rtc-rv3032.c:480:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rv3032.c:480:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-rv3032.c:480:24: sparse:     got unsigned int *__ptr_clean
>> drivers/rtc/rtc-rv3032.c:480:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/rtc/rtc-rv3032.c:480:24: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/rtc/rtc-rv3032.c:480:24: sparse:     got unsigned int *__ptr_clean
--
>> drivers/tee/tee_core.c:449:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/tee/tee_core.c:449:29: sparse:     expected unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:449:29: sparse:     got unsigned long long [noderef] __user *
   drivers/tee/tee_core.c:449:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:449:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:449:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:449:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:449:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:449:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:450:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/tee/tee_core.c:450:29: sparse:     expected unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:450:29: sparse:     got unsigned long long [noderef] __user *
   drivers/tee/tee_core.c:450:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:450:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:450:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:450:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:450:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:450:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:451:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/tee/tee_core.c:451:29: sparse:     expected unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:451:29: sparse:     got unsigned long long [noderef] __user *
   drivers/tee/tee_core.c:451:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:451:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:451:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:451:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:451:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:451:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:456:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__ptr_clean @@     got unsigned long long [noderef] __user * @@
   drivers/tee/tee_core.c:456:29: sparse:     expected unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:456:29: sparse:     got unsigned long long [noderef] __user *
   drivers/tee/tee_core.c:456:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:456:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:456:29: sparse:     got unsigned long long *__ptr_clean
   drivers/tee/tee_core.c:456:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned long long *__ptr_clean @@
   drivers/tee/tee_core.c:456:29: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:456:29: sparse:     got unsigned long long *__ptr_clean
>> drivers/tee/tee_core.c:518:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:518:13: sparse:     expected unsigned int *__ptr_clean
   drivers/tee/tee_core.c:518:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:518:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:518:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:518:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:518:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:518:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:518:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:519:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:519:13: sparse:     expected unsigned int *__ptr_clean
   drivers/tee/tee_core.c:519:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:519:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:519:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:519:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:519:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:519:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:519:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:520:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:520:13: sparse:     expected unsigned int *__ptr_clean
   drivers/tee/tee_core.c:520:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:520:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:520:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:520:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:520:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:520:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:520:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:588:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:588:13: sparse:     expected unsigned int *__ptr_clean
   drivers/tee/tee_core.c:588:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:588:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:588:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:588:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:588:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:588:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:588:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:589:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:589:13: sparse:     expected unsigned int *__ptr_clean
   drivers/tee/tee_core.c:589:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:589:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:589:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:589:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:589:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:589:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:589:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:701:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:701:13: sparse:     expected unsigned int *__ptr_clean
   drivers/tee/tee_core.c:701:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:701:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:701:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:701:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:719:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:719:13: sparse:     expected unsigned int *__ptr_clean
   drivers/tee/tee_core.c:719:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:719:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:719:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:719:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:719:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:719:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:719:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:720:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:720:13: sparse:     expected unsigned int *__ptr_clean
   drivers/tee/tee_core.c:720:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:720:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:720:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:720:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:720:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:720:13: sparse:     expected void [noderef] __user *__ptr_pu
   drivers/tee/tee_core.c:720:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:799:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:799:13: sparse:     expected unsigned int *__ptr_clean
   drivers/tee/tee_core.c:799:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:799:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:799:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:799:13: sparse:     got unsigned int *__ptr_clean
   drivers/tee/tee_core.c:800:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:800:13: sparse:     expected unsigned int *__ptr_clean
   drivers/tee/tee_core.c:800:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:800:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   drivers/tee/tee_core.c:800:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:800:13: sparse:     got unsigned int *__ptr_clean
--
>> net/phonet/socket.c:367:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user * @@
   net/phonet/socket.c:367:21: sparse:     expected unsigned short *__ptr_clean
   net/phonet/socket.c:367:21: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/phonet/socket.c:367:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/phonet/socket.c:367:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/socket.c:367:21: sparse:     got unsigned short *__ptr_clean
   net/phonet/socket.c:387:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__ptr_clean @@     got unsigned short [noderef] [usertype] __user * @@
   net/phonet/socket.c:387:24: sparse:     expected unsigned short *__ptr_clean
   net/phonet/socket.c:387:24: sparse:     got unsigned short [noderef] [usertype] __user *
   net/phonet/socket.c:387:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short *__ptr_clean @@
   net/phonet/socket.c:387:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/socket.c:387:24: sparse:     got unsigned short *__ptr_clean
>> net/phonet/socket.c:387:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned short *__ptr_clean @@
   net/phonet/socket.c:387:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/phonet/socket.c:387:24: sparse:     got unsigned short *__ptr_clean
   net/phonet/socket.c:622:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:622:14: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:622:14: sparse:    struct sock *
   net/phonet/socket.c:645:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:645:17: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:645:17: sparse:    struct sock *
   net/phonet/socket.c:661:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:661:17: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:661:17: sparse:    struct sock *
   net/phonet/socket.c:680:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:680:25: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:680:25: sparse:    struct sock *
   net/phonet/socket.c:729:21: sparse: sparse: context imbalance in 'pn_res_seq_start' - wrong count at exit
   net/phonet/socket.c:744:13: sparse: sparse: context imbalance in 'pn_res_seq_stop' - wrong count at exit
--
>> net/phonet/datagram.c:42:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/phonet/datagram.c:42:24: sparse:     expected int *__ptr_clean
   net/phonet/datagram.c:42:24: sparse:     got int [noderef] __user *
>> net/phonet/datagram.c:42:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/phonet/datagram.c:42:24: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/datagram.c:42:24: sparse:     got int *__ptr_clean
>> net/phonet/datagram.c:42:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/phonet/datagram.c:42:24: sparse:     expected void [noderef] __user *__ptr_pu
   net/phonet/datagram.c:42:24: sparse:     got int *__ptr_clean
>> net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user * @@
   net/phonet/datagram.c:47:29: sparse:     expected unsigned int *__ptr_clean
   net/phonet/datagram.c:47:29: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/phonet/datagram.c:47:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/datagram.c:47:29: sparse:     got unsigned int *__ptr_clean
--
>> net/phonet/pep.c:941:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/phonet/pep.c:941:23: sparse:     expected int *__ptr_clean
   net/phonet/pep.c:941:23: sparse:     got int [noderef] __user *
>> net/phonet/pep.c:941:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/phonet/pep.c:941:23: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/pep.c:941:23: sparse:     got int *__ptr_clean
>> net/phonet/pep.c:941:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/phonet/pep.c:941:23: sparse:     expected void [noderef] __user *__ptr_pu
   net/phonet/pep.c:941:23: sparse:     got int *__ptr_clean
>> net/phonet/pep.c:1050:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/phonet/pep.c:1050:13: sparse:     expected int *__ptr_clean
   net/phonet/pep.c:1050:13: sparse:     got int [noderef] __user *optlen
   net/phonet/pep.c:1050:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/phonet/pep.c:1050:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/pep.c:1050:13: sparse:     got int *__ptr_clean
   net/phonet/pep.c:1077:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/phonet/pep.c:1077:13: sparse:     expected int *__ptr_clean
   net/phonet/pep.c:1077:13: sparse:     got int [noderef] __user *optlen
   net/phonet/pep.c:1077:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/phonet/pep.c:1077:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/pep.c:1077:13: sparse:     got int *__ptr_clean
   net/phonet/pep.c:1077:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/phonet/pep.c:1077:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/phonet/pep.c:1077:13: sparse:     got int *__ptr_clean
   net/phonet/pep.c:1079:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/phonet/pep.c:1079:13: sparse:     expected int *__ptr_clean
   net/phonet/pep.c:1079:13: sparse:     got int [noderef] __user *
   net/phonet/pep.c:1079:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/phonet/pep.c:1079:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/pep.c:1079:13: sparse:     got int *__ptr_clean
   net/phonet/pep.c:1079:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/phonet/pep.c:1079:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/phonet/pep.c:1079:13: sparse:     got int *__ptr_clean
--
   net/qrtr/af_qrtr.c:179:27: sparse: sparse: incompatible types in comparison expression (different base types):
   net/qrtr/af_qrtr.c:179:27: sparse:    void [noderef] __rcu *
   net/qrtr/af_qrtr.c:179:27: sparse:    struct qrtr_node *
   net/qrtr/af_qrtr.c:366:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] confirm_rx @@     got int @@
   net/qrtr/af_qrtr.c:630:27: sparse: sparse: incompatible types in comparison expression (different base types):
   net/qrtr/af_qrtr.c:630:27: sparse:    void [noderef] __rcu *
   net/qrtr/af_qrtr.c:630:27: sparse:    struct qrtr_node *
>> net/qrtr/af_qrtr.c:1155:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
>> net/qrtr/af_qrtr.c:1155:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
>> net/qrtr/af_qrtr.c:1155:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/qrtr/af_qrtr.c:1161:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user * @@
   net/qrtr/af_qrtr.c:1161:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/qrtr/af_qrtr.c:1161:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
--
>> net/vmw_vsock/af_vsock.c:1681:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/vmw_vsock/af_vsock.c:1681:13: sparse:     expected int *__ptr_clean
   net/vmw_vsock/af_vsock.c:1681:13: sparse:     got int [noderef] __user *optlen
>> net/vmw_vsock/af_vsock.c:1681:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/vmw_vsock/af_vsock.c:1681:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/vmw_vsock/af_vsock.c:1681:13: sparse:     got int *__ptr_clean
   net/vmw_vsock/af_vsock.c:1716:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/vmw_vsock/af_vsock.c:1716:13: sparse:     expected int *__ptr_clean
   net/vmw_vsock/af_vsock.c:1716:13: sparse:     got int [noderef] __user *optlen
   net/vmw_vsock/af_vsock.c:1716:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/vmw_vsock/af_vsock.c:1716:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/vmw_vsock/af_vsock.c:1716:13: sparse:     got int *__ptr_clean
>> net/vmw_vsock/af_vsock.c:1716:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/vmw_vsock/af_vsock.c:1716:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/vmw_vsock/af_vsock.c:1716:13: sparse:     got int *__ptr_clean
>> net/vmw_vsock/af_vsock.c:2245:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] [usertype] __user *p @@
   net/vmw_vsock/af_vsock.c:2245:21: sparse:     expected unsigned int *__ptr_clean
   net/vmw_vsock/af_vsock.c:2245:21: sparse:     got unsigned int [noderef] [usertype] __user *p
>> net/vmw_vsock/af_vsock.c:2245:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/vmw_vsock/af_vsock.c:2245:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/vmw_vsock/af_vsock.c:2245:21: sparse:     got unsigned int *__ptr_clean
>> net/vmw_vsock/af_vsock.c:2245:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/vmw_vsock/af_vsock.c:2245:21: sparse:     expected void [noderef] __user *__ptr_pu
   net/vmw_vsock/af_vsock.c:2245:21: sparse:     got unsigned int *__ptr_clean
--
>> net/x25/af_x25.c:460:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/x25/af_x25.c:460:13: sparse:     expected int *__ptr_clean
   net/x25/af_x25.c:460:13: sparse:     got int [noderef] __user *optlen
>> net/x25/af_x25.c:460:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/x25/af_x25.c:460:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/x25/af_x25.c:460:13: sparse:     got int *__ptr_clean
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__ptr_clean @@     got int [noderef] __user *optlen @@
   net/x25/af_x25.c:470:13: sparse:     expected int *__ptr_clean
   net/x25/af_x25.c:470:13: sparse:     got int [noderef] __user *optlen
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *__ptr_clean @@
   net/x25/af_x25.c:470:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/x25/af_x25.c:470:13: sparse:     got int *__ptr_clean
>> net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got int *__ptr_clean @@
   net/x25/af_x25.c:470:13: sparse:     expected void [noderef] __user *__ptr_pu
   net/x25/af_x25.c:470:13: sparse:     got int *__ptr_clean
>> net/x25/af_x25.c:1382:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   net/x25/af_x25.c:1382:22: sparse:     expected unsigned int *__ptr_clean
   net/x25/af_x25.c:1382:22: sparse:     got unsigned int [noderef] __user *
>> net/x25/af_x25.c:1382:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/x25/af_x25.c:1382:22: sparse:     expected void const volatile [noderef] __user *ptr
   net/x25/af_x25.c:1382:22: sparse:     got unsigned int *__ptr_clean
>> net/x25/af_x25.c:1382:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/x25/af_x25.c:1382:22: sparse:     expected void [noderef] __user *__ptr_pu
   net/x25/af_x25.c:1382:22: sparse:     got unsigned int *__ptr_clean
   net/x25/af_x25.c:1397:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__ptr_clean @@     got unsigned int [noderef] __user * @@
   net/x25/af_x25.c:1397:22: sparse:     expected unsigned int *__ptr_clean
   net/x25/af_x25.c:1397:22: sparse:     got unsigned int [noderef] __user *
   net/x25/af_x25.c:1397:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int *__ptr_clean @@
   net/x25/af_x25.c:1397:22: sparse:     expected void const volatile [noderef] __user *ptr
   net/x25/af_x25.c:1397:22: sparse:     got unsigned int *__ptr_clean
   net/x25/af_x25.c:1397:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *__ptr_pu @@     got unsigned int *__ptr_clean @@
   net/x25/af_x25.c:1397:22: sparse:     expected void [noderef] __user *__ptr_pu
   net/x25/af_x25.c:1397:22: sparse:     got unsigned int *__ptr_clean

vim +110 kernel/rseq.c

d7822b1e24f2df Mathieu Desnoyers 2018-06-02  102  
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  103  static int rseq_reset_rseq_cpu_id(struct task_struct *t)
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  104  {
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  105  	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  106  
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  107  	/*
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  108  	 * Reset cpu_id_start to its initial state (0).
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  109  	 */
8f28177014925f Mathieu Desnoyers 2018-07-09 @110  	if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  111  		return -EFAULT;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  112  	/*
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  113  	 * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user coming
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  114  	 * in after unregistration can figure out that rseq needs to be
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  115  	 * registered again.
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  116  	 */
8f28177014925f Mathieu Desnoyers 2018-07-09  117  	if (put_user(cpu_id, &t->rseq->cpu_id))
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  118  		return -EFAULT;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  119  	return 0;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  120  }
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  121  
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  122  static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  123  {
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  124  	struct rseq_cs __user *urseq_cs;
ec9c82e03a744e Mathieu Desnoyers 2018-07-09  125  	u64 ptr;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  126  	u32 __user *usig;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  127  	u32 sig;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  128  	int ret;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  129  
5e0ccd4a3b01c5 Eric Dumazet      2021-04-13  130  #ifdef CONFIG_64BIT
bfdf4e6208051e Mathieu Desnoyers 2022-01-27  131  	if (get_user(ptr, &t->rseq->rseq_cs))
5e0ccd4a3b01c5 Eric Dumazet      2021-04-13  132  		return -EFAULT;
5e0ccd4a3b01c5 Eric Dumazet      2021-04-13  133  #else
bfdf4e6208051e Mathieu Desnoyers 2022-01-27  134  	if (copy_from_user(&ptr, &t->rseq->rseq_cs, sizeof(ptr)))
ec9c82e03a744e Mathieu Desnoyers 2018-07-09  135  		return -EFAULT;
5e0ccd4a3b01c5 Eric Dumazet      2021-04-13  136  #endif
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  137  	if (!ptr) {
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  138  		memset(rseq_cs, 0, sizeof(*rseq_cs));
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  139  		return 0;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  140  	}
ec9c82e03a744e Mathieu Desnoyers 2018-07-09  141  	if (ptr >= TASK_SIZE)
ec9c82e03a744e Mathieu Desnoyers 2018-07-09  142  		return -EINVAL;
ec9c82e03a744e Mathieu Desnoyers 2018-07-09  143  	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  144  	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  145  		return -EFAULT;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  146  
e96d71359e9bbe Mathieu Desnoyers 2018-07-09  147  	if (rseq_cs->start_ip >= TASK_SIZE ||
e96d71359e9bbe Mathieu Desnoyers 2018-07-09  148  	    rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
e96d71359e9bbe Mathieu Desnoyers 2018-07-09  149  	    rseq_cs->abort_ip >= TASK_SIZE ||
e96d71359e9bbe Mathieu Desnoyers 2018-07-09  150  	    rseq_cs->version > 0)
e96d71359e9bbe Mathieu Desnoyers 2018-07-09  151  		return -EINVAL;
e96d71359e9bbe Mathieu Desnoyers 2018-07-09  152  	/* Check for overflow. */
e96d71359e9bbe Mathieu Desnoyers 2018-07-09  153  	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
e96d71359e9bbe Mathieu Desnoyers 2018-07-09  154  		return -EINVAL;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  155  	/* Ensure that abort_ip is not in the critical section. */
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  156  	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  157  		return -EINVAL;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  158  
e96d71359e9bbe Mathieu Desnoyers 2018-07-09  159  	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
d7822b1e24f2df Mathieu Desnoyers 2018-06-02 @160  	ret = get_user(sig, usig);
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  161  	if (ret)
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  162  		return ret;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  163  
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  164  	if (current->rseq_sig != sig) {
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  165  		printk_ratelimited(KERN_WARNING
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  166  			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  167  			sig, current->rseq_sig, current->pid, usig);
e96d71359e9bbe Mathieu Desnoyers 2018-07-09  168  		return -EINVAL;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  169  	}
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  170  	return 0;
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  171  }
d7822b1e24f2df Mathieu Desnoyers 2018-06-02  172  

:::::: The code at line 110 was first introduced by commit
:::::: 8f28177014925f968baf45fc833c25848faf8c1c rseq: Use get_user/put_user rather than __get_user/__put_user

:::::: TO: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
