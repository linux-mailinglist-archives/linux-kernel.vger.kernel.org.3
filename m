Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E2487896
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347719AbiAGNzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:55:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:30015 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347706AbiAGNzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641563701; x=1673099701;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=69u99/6sYlODDkJH1cqo79tAvytw6zvYBBRpPUtEcY0=;
  b=TLuqiVwPO0S86JKq1D5xNLhYYVxkZ4UHwdsy8m8q4lHd/KAcgNAKVxgR
   e9ikAuy/JumIswSCHdnwW0sQMQumQYUhrsDai0aYUutXY0FXvmAc0ARcK
   AN+ktiO4dCkrCqIzT4xIuPH0397tm4VxUZPZVZ4xxDARPhkkyijL0ngfx
   PFrxqNGlSNE5tF5suMLFCkGav+i4HeufgnQ0ZNW7ucU6V0UJzHhMR0sqw
   cp1zuowucUT88KBnxG0rXENSkiyxRGqdvvU1iATWmCxoNFfLgbkO6kXiV
   2UyJBhBfsC89eHsXEo1ODhtbR2KpUm8JK5APYEEhuil0V7eGb/7lrfBe/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="222859244"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="222859244"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 05:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="689796445"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Jan 2022 05:54:59 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5phq-000Ijn-IC; Fri, 07 Jan 2022 13:54:58 +0000
Date:   Fri, 7 Jan 2022 21:54:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: fs/file.c:401:54: sparse: sparse: incorrect type in initializer
 (different address spaces)
Message-ID: <202201072134.vhC4HnC4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ddec8ed2d4905d0967ce2ec432e440e582aa52c6
commit: e188f3330a13df904d77003846eafd3edf99009d ARC: cmpxchg/xchg: rewrite as macros to make type safe
date:   5 months ago
config: arc-randconfig-s031-20220107 (https://download.01.org/0day-ci/archive/20220107/202201072134.vhC4HnC4-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e188f3330a13df904d77003846eafd3edf99009d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e188f3330a13df904d77003846eafd3edf99009d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash fs/ kernel/ net/ipv4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/file.c:350:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **old_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:350:17: sparse:     expected struct file **old_fds
   fs/file.c:350:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:351:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **new_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:351:17: sparse:     expected struct file **new_fds
   fs/file.c:351:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:366:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/file.c:366:17: sparse:    struct file [noderef] __rcu *
   fs/file.c:366:17: sparse:    struct file *
>> fs/file.c:401:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu *[assigned] _val_ @@
   fs/file.c:441:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fdtable [noderef] __rcu *fdt @@     got struct fdtable * @@
   fs/file.c:608:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:762:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:813:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:1038:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *tofree @@     got struct file [noderef] __rcu * @@
--
   net/ipv4/tcp_cong.c:238:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct tcp_congestion_ops const [noderef] __rcu *_val_ @@     got struct tcp_congestion_ops *[assigned] ca @@
   net/ipv4/tcp_cong.c:238:24: sparse:     expected struct tcp_congestion_ops const [noderef] __rcu *_val_
   net/ipv4/tcp_cong.c:238:24: sparse:     got struct tcp_congestion_ops *[assigned] ca
>> net/ipv4/tcp_cong.c:238:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct tcp_congestion_ops const *prev @@     got struct tcp_congestion_ops const [noderef] __rcu *[assigned] _val_ @@
   net/ipv4/tcp_cong.c:238:22: sparse:     expected struct tcp_congestion_ops const *prev
   net/ipv4/tcp_cong.c:238:22: sparse:     got struct tcp_congestion_ops const [noderef] __rcu *[assigned] _val_

vim +401 fs/file.c

02afc6267f6d55 Al Viro          2008-05-08  382  
ce08b62d18b3f9 Oleg Nesterov    2014-01-11  383  static struct fdtable *close_files(struct files_struct * files)
7cf4dc3c8dbfdf Al Viro          2012-08-15  384  {
7cf4dc3c8dbfdf Al Viro          2012-08-15  385  	/*
7cf4dc3c8dbfdf Al Viro          2012-08-15  386  	 * It is safe to dereference the fd table without RCU or
7cf4dc3c8dbfdf Al Viro          2012-08-15  387  	 * ->file_lock because this is the last reference to the
ce08b62d18b3f9 Oleg Nesterov    2014-01-11  388  	 * files structure.
7cf4dc3c8dbfdf Al Viro          2012-08-15  389  	 */
ce08b62d18b3f9 Oleg Nesterov    2014-01-11  390  	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
9b80a184eaadc1 Alexey Dobriyan  2016-09-02  391  	unsigned int i, j = 0;
ce08b62d18b3f9 Oleg Nesterov    2014-01-11  392  
7cf4dc3c8dbfdf Al Viro          2012-08-15  393  	for (;;) {
7cf4dc3c8dbfdf Al Viro          2012-08-15  394  		unsigned long set;
7cf4dc3c8dbfdf Al Viro          2012-08-15  395  		i = j * BITS_PER_LONG;
7cf4dc3c8dbfdf Al Viro          2012-08-15  396  		if (i >= fdt->max_fds)
7cf4dc3c8dbfdf Al Viro          2012-08-15  397  			break;
7cf4dc3c8dbfdf Al Viro          2012-08-15  398  		set = fdt->open_fds[j++];
7cf4dc3c8dbfdf Al Viro          2012-08-15  399  		while (set) {
7cf4dc3c8dbfdf Al Viro          2012-08-15  400  			if (set & 1) {
7cf4dc3c8dbfdf Al Viro          2012-08-15 @401  				struct file * file = xchg(&fdt->fd[i], NULL);
7cf4dc3c8dbfdf Al Viro          2012-08-15  402  				if (file) {
7cf4dc3c8dbfdf Al Viro          2012-08-15  403  					filp_close(file, files);
388a4c88064e7e Paul E. McKenney 2017-10-24  404  					cond_resched();
7cf4dc3c8dbfdf Al Viro          2012-08-15  405  				}
7cf4dc3c8dbfdf Al Viro          2012-08-15  406  			}
7cf4dc3c8dbfdf Al Viro          2012-08-15  407  			i++;
7cf4dc3c8dbfdf Al Viro          2012-08-15  408  			set >>= 1;
7cf4dc3c8dbfdf Al Viro          2012-08-15  409  		}
7cf4dc3c8dbfdf Al Viro          2012-08-15  410  	}
ce08b62d18b3f9 Oleg Nesterov    2014-01-11  411  
ce08b62d18b3f9 Oleg Nesterov    2014-01-11  412  	return fdt;
7cf4dc3c8dbfdf Al Viro          2012-08-15  413  }
7cf4dc3c8dbfdf Al Viro          2012-08-15  414  

:::::: The code at line 401 was first introduced by commit
:::::: 7cf4dc3c8dbfdfde163d4636f621cf99a1f63bfb move files_struct-related bits from kernel/exit.c to fs/file.c

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
