Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05144473CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhLNFsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:48:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:53452 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhLNFsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639460891; x=1670996891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vi09+GGPG5ou9EPdnHVDZBLNuC2wKrMH7b+DLbIOrsE=;
  b=QUIqjluNS0/e0wMmyEbMogjoSJN7IRPs/qUsn6Vo3CSIwbeBsa/4Hb5V
   o6a7Wb8zrwVMnkS9FTmzX0Ingk6nYPHHU1hs/ACYbczxDr2nk+XYWFmeZ
   Vbv0y8kWpeVWzhLoC8embVtM/k34LBXEQV16Fq/Ux+VQ5UbPjYmsVZKn7
   6LNzA/s6gPljPnzLkuuo1J1tUhqNMFeiBJEEyADJc6JIYREqnrB3V8f7+
   /C4JMAIeNF+L15L8LO9mUpcdH4T5ZxvgG2AKAbR67jjqlcrwVL4pWSXzu
   sjuxbaPMekxGS+Z3Nb26BQa4K2WR6rQ10xdBvVyMZ4Jx0bi83Si9bNSEl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236434979"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="236434979"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 21:48:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="463667833"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2021 21:48:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx0fZ-0007To-Bh; Tue, 14 Dec 2021 05:48:09 +0000
Date:   Tue, 14 Dec 2021 13:47:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ebiederm-user-namespace:signal-for-v5.17 10/12]
 kernel/kthread.c:299: warning: expecting prototype for kthread_complete_and
 exit(). Prototype was for kthread_complete_and_exit() instead
Message-ID: <202112141329.KBkyJ5ql-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
head:   6b1248798eb6f6d5285db214299996ecc5dc1e6b
commit: cead18552660702a4a46f58e65188fe5f36e9dfe [10/12] exit: Rename complete_and_exit to kthread_complete_and_exit
config: x86_64-randconfig-a011-20211213 (https://download.01.org/0day-ci/archive/20211214/202112141329.KBkyJ5ql-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=cead18552660702a4a46f58e65188fe5f36e9dfe
        git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
        git fetch --no-tags ebiederm-user-namespace signal-for-v5.17
        git checkout cead18552660702a4a46f58e65188fe5f36e9dfe
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/kthread.c:299: warning: expecting prototype for kthread_complete_and exit(). Prototype was for kthread_complete_and_exit() instead


vim +299 kernel/kthread.c

   285	
   286	/**
   287	 * kthread_complete_and exit - Exit the current kthread.
   288	 * @comp: Completion to complete
   289	 * @code: The integer value to return to kthread_stop().
   290	 *
   291	 * If present complete @comp and the reuturn code to kthread_stop().
   292	 *
   293	 * A kernel thread whose module may be removed after the completion of
   294	 * @comp can use this function exit safely.
   295	 *
   296	 * Does not return.
   297	 */
   298	void __noreturn kthread_complete_and_exit(struct completion *comp, long code)
 > 299	{
   300		if (comp)
   301			complete(comp);
   302	
   303		kthread_exit(code);
   304	}
   305	EXPORT_SYMBOL(kthread_complete_and_exit);
   306	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
