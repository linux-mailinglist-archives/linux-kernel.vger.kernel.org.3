Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0314B3E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 00:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbiBMXO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 18:14:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBMXOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 18:14:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41454BE3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 15:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644794059; x=1676330059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2rcEb11zx0b/B2xTB+zloZNRSWRJNMpG+SxxToSQBT4=;
  b=d9E6KAD6E2Xfrv6b9PbMLl3Dw9wIFrsXvb91Y6xaitHNfD5M4KJ3A76V
   S+DiNVPZtL5Oym9Gpy1nFLnvGc2TxK9tdFVkAzhF2vlJbT7PePxaZAMTM
   W64XyfQnLD6iOZIwoxr1zuugx56ZcfqlnSMouvdktfjBhiFi6+Sig7meI
   Qg874YnVkBTpZvrry5U4dWQaXpCsvjcVEQiuA94OT8lcmQwX/Z/anEcyc
   vTMKEl60eWa9Tq5OniH1QHvMxOTSG7CCkJfBRG5X6e7HwWkWWK/cBiRTw
   TL7jvOERHowADDy1bN0C5tkJSAXDHXy7DqtEHrq9Of9RZ3a2uTcFumKuC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249928409"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="249928409"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 15:14:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="631782740"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2022 15:14:16 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJO4N-0007yS-W2; Sun, 13 Feb 2022 23:14:15 +0000
Date:   Mon, 14 Feb 2022 07:13:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/for-next 2/27]
 fs/io_uring.c:9406:9: error: variable 'ret' is uninitialized when used here
Message-ID: <202202140741.cSdNc5dQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-next
head:   9c63ffcf47865ad2d20e09d6d6531c4611674cf1
commit: 1a75fac9a0f920a13418c88e4deaa9aa005381f5 [2/27] io_uring: avoid ring quiesce while registering/unregistering eventfd
config: arm-randconfig-c002-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140741.cSdNc5dQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/1a75fac9a0f920a13418c88e4deaa9aa005381f5
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-next
        git checkout 1a75fac9a0f920a13418c88e4deaa9aa005381f5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/axboe/linux-block/for-next HEAD 9c63ffcf47865ad2d20e09d6d6531c4611674cf1 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> fs/io_uring.c:9406:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
           return ret;
                  ^~~
   fs/io_uring.c:9384:13: note: initialize the variable 'ret' to silence this warning
           int fd, ret;
                      ^
                       = 0
   1 error generated.


vim +/ret +9406 fs/io_uring.c

  9379	
  9380	static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg)
  9381	{
  9382		struct io_ev_fd *ev_fd;
  9383		__s32 __user *fds = arg;
  9384		int fd, ret;
  9385	
  9386		ev_fd = rcu_dereference_protected(ctx->io_ev_fd,
  9387						lockdep_is_held(&ctx->uring_lock));
  9388		if (ev_fd)
  9389			return -EBUSY;
  9390	
  9391		if (copy_from_user(&fd, fds, sizeof(*fds)))
  9392			return -EFAULT;
  9393	
  9394		ev_fd = kmalloc(sizeof(*ev_fd), GFP_KERNEL);
  9395		if (!ev_fd)
  9396			return -ENOMEM;
  9397	
  9398		ev_fd->cq_ev_fd = eventfd_ctx_fdget(fd);
  9399		if (IS_ERR(ev_fd->cq_ev_fd)) {
  9400			ret = PTR_ERR(ev_fd->cq_ev_fd);
  9401			kfree(ev_fd);
  9402			return ret;
  9403		}
  9404	
  9405		rcu_assign_pointer(ctx->io_ev_fd, ev_fd);
> 9406		return ret;
  9407	}
  9408	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
