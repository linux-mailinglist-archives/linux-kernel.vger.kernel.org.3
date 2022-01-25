Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC549B496
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384691AbiAYNEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:04:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:46661 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1574301AbiAYM6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643115488; x=1674651488;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=drsjVuY8z1grpOG0WDWezE+NIKu9MM0RBXPz+zXOdeA=;
  b=akcYQKOOHYW5k18zfZRe4pXN98UGmMLezkc5bm/x/uZbGOiiPKqTNnnn
   3k57V2j0jL4lh7VMVowiB2FdJ3RAep0D738+ccfBiwi2WYaS4T657KKo/
   qipuvz7FsSeZp2uQ9MDgcN1LoFVxcsiLjzURpIJwOFgdJNvxpmm8GGWdZ
   PvcdwzaK8udod2jjvpjU0bQGC9WgBuckit/4Tx1F8Y28x/ebHLbkyczbz
   YToD26MDFJDU2qF37GWQZLebC9XE7U25wMRALTg2IUCUjjYBQcxQHXX3H
   8shu6bH2Duje2l6yytf/JHpKU9dLbrNNUQ1125JCLtcv6HU7+M5MC5lTs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233662916"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="233662916"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 04:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="477093389"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jan 2022 04:50:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCLHh-000Jtt-Dv; Tue, 25 Jan 2022 12:50:53 +0000
Date:   Tue, 25 Jan 2022 20:50:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>
Subject: drivers/md/raid5.c:7055:9: sparse: sparse: cast removes address
 space '__percpu' of expression
Message-ID: <202201252042.IYjJbxV8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a08b41ab9e2e468647f78eb17c28e29b93006394
commit: 770b1d216d7371c94c88713824da4be4bc39a4e0 md/raid5: play nice with PREEMPT_RT
date:   3 weeks ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220125/202201252042.IYjJbxV8-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=770b1d216d7371c94c88713824da4be4bc39a4e0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 770b1d216d7371c94c88713824da4be4bc39a4e0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/md/raid5.c: note: in included file:
   drivers/md/raid5.h:271:14: sparse: sparse: array of flexible structures
   drivers/md/raid5.c:641:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:641:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:641:40: sparse:    struct md_rdev *
   drivers/md/raid5.c:643:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:643:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:643:32: sparse:    struct md_rdev *
   drivers/md/raid5.c:667:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:667:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:667:40: sparse:    struct md_rdev *
   drivers/md/raid5.c:669:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:669:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:669:32: sparse:    struct md_rdev *
   drivers/md/raid5.c:1101:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:1101:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:1101:25: sparse:    struct md_rdev *
   drivers/md/raid5.c:1103:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:1103:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:1103:24: sparse:    struct md_rdev *
   drivers/md/raid5.c:3563:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:3563:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:3563:32: sparse:    struct md_rdev *
   drivers/md/raid5.c:3689:48: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:3689:48: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:3689:48: sparse:    struct md_rdev *
   drivers/md/raid5.c:3696:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:3696:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:3696:32: sparse:    struct md_rdev *
   drivers/md/raid5.c:3718:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:3718:16: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:3718:16: sparse:    struct md_rdev *
   drivers/md/raid5.c:4646:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4646:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4646:24: sparse:    struct md_rdev *
   drivers/md/raid5.c:4657:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4657:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4657:32: sparse:    struct md_rdev *
   drivers/md/raid5.c:4704:49: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4704:49: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4704:49: sparse:    struct md_rdev *
   drivers/md/raid5.c:4717:49: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4717:49: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4717:49: sparse:    struct md_rdev *
   drivers/md/raid5.c:4726:49: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4726:49: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4726:49: sparse:    struct md_rdev *
   drivers/md/raid5.c:4748:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:4748:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:4748:40: sparse:    struct md_rdev *
   drivers/md/raid5.c:5419:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:5419:16: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:5419:16: sparse:    struct md_rdev *
   drivers/md/raid5.c:5422:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:5422:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:5422:24: sparse:    struct md_rdev *
>> drivers/md/raid5.c:7055:9: sparse: sparse: cast removes address space '__percpu' of expression
>> drivers/md/raid5.c:7055:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map *lock @@     got struct lockdep_map [noderef] __percpu * @@
   drivers/md/raid5.c:7055:9: sparse:     expected struct lockdep_map *lock
   drivers/md/raid5.c:7055:9: sparse:     got struct lockdep_map [noderef] __percpu *
>> drivers/md/raid5.c:7055:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct local_lock_t [usertype] *l @@     got struct local_lock_t [noderef] __percpu * @@
   drivers/md/raid5.c:7055:9: sparse:     expected struct local_lock_t [usertype] *l
   drivers/md/raid5.c:7055:9: sparse:     got struct local_lock_t [noderef] __percpu *
   drivers/md/raid5.c:7808:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:7808:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:7808:40: sparse:    struct md_rdev *
   drivers/md/raid5.c:8021:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:8021:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:8021:25: sparse:    struct md_rdev *
   drivers/md/raid5.c:8037:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid5.c:8037:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid5.c:8037:25: sparse:    struct md_rdev *
   drivers/md/raid5.c:1476:16: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:1476:39: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:2208:54: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:2419:16: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:2421:9: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:2422:9: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7031:23: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7031:23: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7032:9: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7033:16: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7034:9: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7039:34: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7040:17: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:7041:22: sparse: sparse: dereference of noderef expression
   drivers/md/raid5.c:97:9: sparse: sparse: context imbalance in 'raid5_quiesce' - different lock contexts for basic block

vim +/__percpu +7055 drivers/md/raid5.c

  7036	
  7037	static int alloc_scratch_buffer(struct r5conf *conf, struct raid5_percpu *percpu)
  7038	{
  7039		if (conf->level == 6 && !percpu->spare_page) {
  7040			percpu->spare_page = alloc_page(GFP_KERNEL);
  7041			if (!percpu->spare_page)
  7042				return -ENOMEM;
  7043		}
  7044	
  7045		if (scribble_alloc(percpu,
  7046				   max(conf->raid_disks,
  7047				       conf->previous_raid_disks),
  7048				   max(conf->chunk_sectors,
  7049				       conf->prev_chunk_sectors)
  7050				   / RAID5_STRIPE_SECTORS(conf))) {
  7051			free_scratch_buffer(conf, percpu);
  7052			return -ENOMEM;
  7053		}
  7054	
> 7055		local_lock_init(&percpu->lock);
  7056		return 0;
  7057	}
  7058	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
