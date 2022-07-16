Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF4B577243
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiGPXcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiGPXcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:32:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BDC14D1F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658014320; x=1689550320;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kSMKGwd6jWOtJrME4hiCUa+UtRIyOBYJ06HJnUGBgjE=;
  b=UCv+daeI7OwZDxS54GdPOESkcdTw2ih0PlseMthSaoEDWoZ5IUwfUEKy
   HZJXuxLYsGSNtB24enchokYcKLtOkGQoPUbd/BhnIa1LEntP+J9+dpkxm
   kjfD5E3ehL7exUFgalxcZFaYwxnXgTbXEC68TRC19b21Daf+ZtnufkvUq
   hn3BP5cpxYiFpTg9phm5Cv/ObkHABSpRVHRrwM0WbWVeZxOnNWBCZVZF0
   pfdFcXMpcJZNvgUwDwZqWopz4m67Fsv3bOGAVV6gZeQ0MedO/Bh0vgp+r
   8MNWlpSMzBtIPkeJ41mF3GU4FBOf0W1SIihglKfNfITmq0Tci8g8IaFNy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="265797923"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="265797923"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 16:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="664597249"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jul 2022 16:31:58 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCrGQ-0002IM-5E;
        Sat, 16 Jul 2022 23:31:58 +0000
Date:   Sun, 17 Jul 2022 07:31:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: fs/io_uring.c:9355:9: warning: variable 'ret' is uninitialized when
 used here
Message-ID: <202207170730.1iSEta2h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220716-232000/Usama-Arif/io_uring-remove-ring-quiesce-in-io_uring_register/20220204-225343
head:   a5e1e37e8b4c9ca3f59d11e31910a7f093649d31
commit: 5c6ec2f45e82c1351622414a938ca16473523b5b io_uring: avoid ring quiesce while registering/unregistering eventfd
date:   8 hours ago
config: hexagon-randconfig-r041-20220717 (https://download.01.org/0day-ci/archive/20220717/202207170730.1iSEta2h-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5c6ec2f45e82c1351622414a938ca16473523b5b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220716-232000/Usama-Arif/io_uring-remove-ring-quiesce-in-io_uring_register/20220204-225343
        git checkout 5c6ec2f45e82c1351622414a938ca16473523b5b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/io_uring.c:9355:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
           return ret;
                  ^~~
   fs/io_uring.c:9334:13: note: initialize the variable 'ret' to silence this warning
           int fd, ret;
                      ^
                       = 0
   fs/io_uring.c:1200:20: warning: unused function 'req_ref_put' [-Wunused-function]
   static inline void req_ref_put(struct io_kiocb *req)
                      ^
   2 warnings generated.


vim +/ret +9355 fs/io_uring.c

  9329	
  9330	static int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg)
  9331	{
  9332		struct io_ev_fd *ev_fd;
  9333		__s32 __user *fds = arg;
  9334		int fd, ret;
  9335	
  9336		ev_fd = rcu_dereference_protected(ctx->io_ev_fd, lockdep_is_held(&ctx->uring_lock));
  9337		if (ev_fd)
  9338			return -EBUSY;
  9339	
  9340		if (copy_from_user(&fd, fds, sizeof(*fds)))
  9341			return -EFAULT;
  9342	
  9343		ev_fd = kmalloc(sizeof(*ev_fd), GFP_KERNEL);
  9344		if (!ev_fd)
  9345			return -ENOMEM;
  9346	
  9347		ev_fd->cq_ev_fd = eventfd_ctx_fdget(fd);
  9348		if (IS_ERR(ev_fd->cq_ev_fd)) {
  9349			ret = PTR_ERR(ev_fd->cq_ev_fd);
  9350			kfree(ev_fd);
  9351			return ret;
  9352		}
  9353	
  9354		rcu_assign_pointer(ctx->io_ev_fd, ev_fd);
> 9355		return ret;
  9356	}
  9357	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
