Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8966534F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiEZMuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347434AbiEZMuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:50:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430601C136
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653569408; x=1685105408;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TFEtc6n6+D2R1pdxx/1bbjFRAI4nGU6ETu0Ewc5L1Ro=;
  b=HO8cif0M5AQmTf9FY9+A93hjFljhump5sMoIaQXrN6dO+Sf8u6e32JUV
   SaqDMcwyTxghQXrp7vNUtL/OgjsNdq8hP8bxrXbNXudFHLK7JjJ+QRvRM
   pWaTGHKol3CGqn4975lnkTPx8UUElVcEYoHLiPrcWqoEV+x34TruGLHSU
   C/VWgVYC8KU5osivthPZwLOOlX9TeUbUknpuYQPxQKwEBwfc3lSb+16n0
   Y+ANCb0BJRbcWSxIm7ER1XCoeBTexqFYlMWrv0VBrQQap7lGxb2TRz16a
   EuUIl6LHw4tdBTEplXZLQpYGPBcC9xiWK89IKhBdLRTc1lVARx4ROSxac
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="256211519"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="256211519"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 05:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="704530413"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 May 2022 05:50:06 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuCwI-0003sQ-4E;
        Thu, 26 May 2022 12:50:06 +0000
Date:   Thu, 26 May 2022 20:49:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [sbates130272-p2pmem:md-bug-v2 13/17]
 drivers/md/raid5-cache.c:409:35: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202205262005.fOq3Ctsn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/sbates130272/linux-p2pmem.git md-bug-v2
head:   1816687fa5c6ba0cecc43d38a583d2ff56da9597
commit: c6c798f230d28e6ac1e28faa7d255ed7cf5ba3ff [13/17] md/raid5-cache: Add RCU protection to conf->log accesses
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220526/202205262005.fOq3Ctsn-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://github.com/sbates130272/linux-p2pmem/commit/c6c798f230d28e6ac1e28faa7d255ed7cf5ba3ff
        git remote add sbates130272-p2pmem https://github.com/sbates130272/linux-p2pmem.git
        git fetch --no-tags sbates130272-p2pmem md-bug-v2
        git checkout c6c798f230d28e6ac1e28faa7d255ed7cf5ba3ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/md/raid5-cache.c: note: in included file:
   drivers/md/raid5.h:271:14: sparse: sparse: array of flexible structures
>> drivers/md/raid5-cache.c:409:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct r5l_log *log @@     got struct r5l_log [noderef] __rcu *log @@
   drivers/md/raid5-cache.c:409:35: sparse:     expected struct r5l_log *log
   drivers/md/raid5-cache.c:409:35: sparse:     got struct r5l_log [noderef] __rcu *log
   drivers/md/raid5-cache.c:2668:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **pslot @@     got void [noderef] __rcu ** @@
   drivers/md/raid5-cache.c:2668:23: sparse:     expected void **pslot
   drivers/md/raid5-cache.c:2668:23: sparse:     got void [noderef] __rcu **
   drivers/md/raid5-cache.c:2672:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __rcu **slot @@     got void **pslot @@
   drivers/md/raid5-cache.c:2672:33: sparse:     expected void [noderef] __rcu **slot
   drivers/md/raid5-cache.c:2672:33: sparse:     got void **pslot
   drivers/md/raid5-cache.c:2675:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slot @@     got void **pslot @@
   drivers/md/raid5-cache.c:2675:56: sparse:     expected void [noderef] __rcu **slot
   drivers/md/raid5-cache.c:2675:56: sparse:     got void **pslot
   drivers/md/raid5-cache.c:2823:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void **pslot @@     got void [noderef] __rcu ** @@
   drivers/md/raid5-cache.c:2823:23: sparse:     expected void **pslot
   drivers/md/raid5-cache.c:2823:23: sparse:     got void [noderef] __rcu **
   drivers/md/raid5-cache.c:2827:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __rcu **slot @@     got void **pslot @@
   drivers/md/raid5-cache.c:2827:25: sparse:     expected void [noderef] __rcu **slot
   drivers/md/raid5-cache.c:2827:25: sparse:     got void **pslot
   drivers/md/raid5-cache.c:2833:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __rcu **slot @@     got void **pslot @@
   drivers/md/raid5-cache.c:2833:56: sparse:     expected void [noderef] __rcu **slot
   drivers/md/raid5-cache.c:2833:56: sparse:     got void **pslot

vim +409 drivers/md/raid5-cache.c

a39f7afde358ca Song Liu 2016-11-17  401  
2ded370373a400 Song Liu 2016-11-17  402  /*
2ded370373a400 Song Liu 2016-11-17  403   * Put the stripe into writing-out phase by clearing STRIPE_R5C_CACHING.
2ded370373a400 Song Liu 2016-11-17  404   * This function should only be called in write-back mode.
2ded370373a400 Song Liu 2016-11-17  405   */
a39f7afde358ca Song Liu 2016-11-17  406  void r5c_make_stripe_write_out(struct stripe_head *sh)
2ded370373a400 Song Liu 2016-11-17  407  {
2ded370373a400 Song Liu 2016-11-17  408  	struct r5conf *conf = sh->raid_conf;
2ded370373a400 Song Liu 2016-11-17 @409  	struct r5l_log *log = conf->log;
2ded370373a400 Song Liu 2016-11-17  410  
2ded370373a400 Song Liu 2016-11-17  411  	BUG_ON(!r5c_is_writeback(log));
2ded370373a400 Song Liu 2016-11-17  412  
2ded370373a400 Song Liu 2016-11-17  413  	WARN_ON(!test_bit(STRIPE_R5C_CACHING, &sh->state));
2ded370373a400 Song Liu 2016-11-17  414  	clear_bit(STRIPE_R5C_CACHING, &sh->state);
1e6d690b9334b7 Song Liu 2016-11-17  415  
1e6d690b9334b7 Song Liu 2016-11-17  416  	if (!test_and_set_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
1e6d690b9334b7 Song Liu 2016-11-17  417  		atomic_inc(&conf->preread_active_stripes);
1e6d690b9334b7 Song Liu 2016-11-17  418  }
1e6d690b9334b7 Song Liu 2016-11-17  419  

:::::: The code at line 409 was first introduced by commit
:::::: 2ded370373a400c20cf0c6e941e724e61582a867 md/r5cache: State machine for raid5-cache write back mode

:::::: TO: Song Liu <songliubraving@fb.com>
:::::: CC: Shaohua Li <shli@fb.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
