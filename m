Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152065A3926
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiH0RPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiH0RPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:15:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA961E018
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661620507; x=1693156507;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fSQFqVYQTk5CXYvvW3yMbPWigoAj1zX3fsmoe9OiOoM=;
  b=eqQO7uZr8kA53p8VtByCos8G/O5mT2JUzS+6edv7hXg1y11RszWokn5Y
   ycQmSfcTQ10m1VMa8ujIqV2wmpf9KBzxlWYUZwLFex0UGOxae6/I8q37G
   R6470snpVhkLd2H5s+veBhFg2xUth9h8AUls1QNIulrkr11TPBpInaR0x
   jXLqc+z3d5wNVcrCql2AvgTzrXfO8f04Hu55IY/gQp11Y7qmCocrvabBY
   /v8RNOPClAyb+ihdgYXGtGuvqM0rVksNHTMBG00g1938eaU9RAmfIpzIq
   bNKxVqRE7gZROc7Dslpr0oyoH3xM4892RGbsP4FVxF5O0N+HFhzGg+2Y2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="356392857"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="356392857"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 10:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="643988790"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2022 10:15:05 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRzOj-0000KH-0C;
        Sat, 27 Aug 2022 17:15:05 +0000
Date:   Sun, 28 Aug 2022 01:14:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: net/9p/trans_fd.c:263:31: sparse: sparse: incorrect type in argument
 1 (different address spaces)
Message-ID: <202208280102.vCNrXRCa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220827-141406/Tetsuo-Handa/9p-trans_fd-always-use-O_NONBLOCK-read-write/20220826-233109
head:   a1740a60720018fa78f0cfe45db5cfc85e2d3a6d
commit: a1740a60720018fa78f0cfe45db5cfc85e2d3a6d 9p/trans_fd: perform read/write with TIF_SIGPENDING set
date:   11 hours ago
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220828/202208280102.vCNrXRCa-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a1740a60720018fa78f0cfe45db5cfc85e2d3a6d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220827-141406/Tetsuo-Handa/9p-trans_fd-always-use-O_NONBLOCK-read-write/20220826-233109
        git checkout a1740a60720018fa78f0cfe45db5cfc85e2d3a6d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/9p/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> net/9p/trans_fd.c:263:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   net/9p/trans_fd.c:263:31: sparse:     expected struct spinlock [usertype] *lock
   net/9p/trans_fd.c:263:31: sparse:     got struct spinlock [noderef] __rcu *
   net/9p/trans_fd.c:265:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   net/9p/trans_fd.c:265:33: sparse:     expected struct spinlock [usertype] *lock
   net/9p/trans_fd.c:265:33: sparse:     got struct spinlock [noderef] __rcu *
   net/9p/trans_fd.c:431:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   net/9p/trans_fd.c:431:31: sparse:     expected struct spinlock [usertype] *lock
   net/9p/trans_fd.c:431:31: sparse:     got struct spinlock [noderef] __rcu *
   net/9p/trans_fd.c:433:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   net/9p/trans_fd.c:433:33: sparse:     expected struct spinlock [usertype] *lock
   net/9p/trans_fd.c:433:33: sparse:     got struct spinlock [noderef] __rcu *

vim +263 net/9p/trans_fd.c

   238	
   239	/**
   240	 * p9_fd_read- read from a fd
   241	 * @client: client instance
   242	 * @v: buffer to receive data into
   243	 * @len: size of receive buffer
   244	 *
   245	 */
   246	
   247	static int p9_fd_read(struct p9_client *client, void *v, int len)
   248	{
   249		int ret;
   250		struct p9_trans_fd *ts = NULL;
   251		loff_t pos;
   252	
   253		if (client && client->status != Disconnected)
   254			ts = client->trans;
   255	
   256		if (!ts)
   257			return -EREMOTEIO;
   258	
   259		pos = ts->rd->f_pos;
   260		/* Force non-blocking read() even without O_NONBLOCK. */
   261		set_thread_flag(TIF_SIGPENDING);
   262		ret = kernel_read(ts->rd, v, len, &pos);
 > 263		spin_lock_irq(&current->sighand->siglock);
   264		recalc_sigpending();
   265		spin_unlock_irq(&current->sighand->siglock);
   266		if (ret <= 0 && ret != -ERESTARTSYS && ret != -EAGAIN)
   267			client->status = Disconnected;
   268		return ret;
   269	}
   270	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
