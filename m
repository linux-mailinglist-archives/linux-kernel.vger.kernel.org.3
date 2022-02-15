Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71134B6221
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiBOEeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:34:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiBOEep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:34:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3658AA9A63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 20:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644899675; x=1676435675;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sQoCwA26t7bohLjBxsistapM0bOlvqxoeLeHcbXfGVU=;
  b=j7t7DWgBzpSMFvCWV2UcCE74tLSL3aL6Jngj8y11tkksUbBr5cWFzfaz
   Ax0uWf2/97Ze51Xhkec4uXO8wdMowc3y7zrL+6GOgqaHgUUEswJHU0Lrp
   pLLZaf9kIwgEpF2FiNAQnM2nm8GeNVr/wJTvqtp6neAs1E3h0DndJaynl
   s3iP4RillAsG69Le9eZ3BJT9lxhkoIXXLsSyaIM8jzJvSVbx/vYZFywzb
   0s/HNDFB6bzSAKOiYyclzUWGCdAgjrRmpB6Z4HWORs079tzu4iflbRnBu
   LPWXVHV8XBrEzOUfvlJ1jL+H/4FH5yKw8n4OlbfJV8I5E5POcoNv/Oq58
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250194201"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="250194201"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 20:34:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="485951089"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2022 20:34:33 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJpXs-0009Gr-IU; Tue, 15 Feb 2022 04:34:32 +0000
Date:   Tue, 15 Feb 2022 12:33:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-sparse-read 13/13] net/ceph/messenger_v2.c:3642:56:
 warning: variable 'recved' is uninitialized when used here
Message-ID: <202202151220.h4Fu215q-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-sparse-read
head:   c0521644c264a8578ab61182209f303610af16e7
commit: c0521644c264a8578ab61182209f303610af16e7 [13/13] libceph: add revoke support for sparse data
config: i386-randconfig-a003-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151220.h4Fu215q-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=c0521644c264a8578ab61182209f303610af16e7
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-sparse-read
        git checkout c0521644c264a8578ab61182209f303610af16e7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ceph/messenger_v2.c:3642:56: warning: variable 'recved' is uninitialized when used here [-Wuninitialized]
           dout("%s con %p recved %d resid %d\n", __func__, con, recved, resid);
                                                                 ^~~~~~
   include/linux/ceph/ceph_debug.h:35:45: note: expanded from macro 'dout'
   # define dout(fmt, ...) pr_debug(" " fmt, ##__VA_ARGS__)
                                               ^~~~~~~~~~~
   include/linux/printk.h:570:26: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
                                   ^~~~~~~~~~~
   include/linux/dynamic_debug.h:163:22: note: expanded from macro 'dynamic_pr_debug'
                              pr_fmt(fmt), ##__VA_ARGS__)
                                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   net/ceph/messenger_v2.c:3635:12: note: initialize the variable 'recved' to silence this warning
           int recved, resid;  /* current piece of data */
                     ^
                      = 0
   1 warning generated.


vim +/recved +3642 net/ceph/messenger_v2.c

  3632	
  3633	static void revoke_at_prepare_sparse_data(struct ceph_connection *con)
  3634	{
  3635		int recved, resid;  /* current piece of data */
  3636		int remaining;
  3637	
  3638		WARN_ON(con_secure(con));
  3639		WARN_ON(!data_len(con->in_msg));
  3640		WARN_ON(!iov_iter_is_bvec(&con->v2.in_iter));
  3641		resid = iov_iter_count(&con->v2.in_iter);
> 3642		dout("%s con %p recved %d resid %d\n", __func__, con, recved, resid);
  3643	
  3644		remaining = CEPH_EPILOGUE_PLAIN_LEN + con->v2.data_len_remain;
  3645		con->v2.in_iter.count -= resid;
  3646		set_in_skip(con, resid + remaining);
  3647		con->v2.in_state = IN_S_FINISH_SKIP;
  3648	}
  3649	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
