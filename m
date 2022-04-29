Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD8514026
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353860AbiD2BT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353759AbiD2BT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:19:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C474C42D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651195000; x=1682731000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JKAWPyMmGWeSqGKBDfdla8W3JVW6ENVJgotiQ/gpd0k=;
  b=JefPqd0bwkIiXMo1EGx+k9zKmvtfeXN/Lf+XLsMKnpcaSC1/pt10hlhJ
   yvE/TmbNDDqWc306S9D/cCCoImUNTwS5qvbKmwcHjb8/yxCH+Jx4tSQqr
   ZAHrgIZPP/oWPmtnQezN4gwiy6iIpACP2fPy/CXgwuhw0T2nxoFiM9M9u
   EGAeEqAK0B9QmUVWAK00SlgmZeLardLe4xGBe2BK13Zr0OAoWw26kggno
   9lfIFVk9xY0vvL3IEk5IalZqLr3xHgwN4YhpsHzXNCuddhvATmHJfiE42
   ECkybxmqeawH7EFNDmLHEotFFBsUNlIdENH+MQd/YaXY1ShPUB9oUA8w0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="266301000"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="266301000"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 18:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="731798937"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Apr 2022 18:16:38 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkFFO-0005qB-8I;
        Fri, 29 Apr 2022 01:16:38 +0000
Date:   Fri, 29 Apr 2022 09:15:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [trondmy-nfs-2.6:testing 4/10] net/sunrpc/xprtsock.c:1436:23:
 warning: variable 'transport' is uninitialized when used here
Message-ID: <202204290947.alhq7Gbj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git testing
head:   b44c0c653b27127aba20075ef53b0d641a36a3ae
commit: 8869b563cd42a4cb725604322454ed4fb29a0c18 [4/10] SUNRPC: Ensure timely close of disconnected AF_LOCAL sockets
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220429/202204290947.alhq7Gbj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c59473aacce38cd7dd77eebceaf3c98c5707ab3b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add trondmy-nfs-2.6 git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
        git fetch --no-tags trondmy-nfs-2.6 testing
        git checkout 8869b563cd42a4cb725604322454ed4fb29a0c18
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/sunrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/sunrpc/xprtsock.c:36:
   In file included from include/linux/sunrpc/clnt.h:20:
   In file included from include/linux/sunrpc/sched.h:19:
   include/linux/sunrpc/xdr.h:734:10: warning: result of comparison of constant 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           if (len > SIZE_MAX / sizeof(*p))
               ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~
>> net/sunrpc/xprtsock.c:1436:23: warning: variable 'transport' is uninitialized when used here [-Wuninitialized]
                   xs_run_error_worker(transport, XPRT_SOCK_WAKE_DISCONNECT);
                                       ^~~~~~~~~
   net/sunrpc/xprtsock.c:1429:29: note: initialize the variable 'transport' to silence this warning
           struct sock_xprt *transport;
                                      ^
                                       = NULL
   2 warnings generated.


vim +/transport +1436 net/sunrpc/xprtsock.c

  1420	
  1421	/**
  1422	 * xs_local_state_change - callback to handle AF_LOCAL socket state changes
  1423	 * @sk: socket whose state has changed
  1424	 *
  1425	 */
  1426	static void xs_local_state_change(struct sock *sk)
  1427	{
  1428		struct rpc_xprt *xprt;
  1429		struct sock_xprt *transport;
  1430	
  1431		if (!(xprt = xprt_from_sock(sk)))
  1432			return;
  1433		if (sk->sk_shutdown & SHUTDOWN_MASK) {
  1434			clear_bit(XPRT_CONNECTED, &xprt->state);
  1435			/* Trigger the socket release */
> 1436			xs_run_error_worker(transport, XPRT_SOCK_WAKE_DISCONNECT);
  1437		}
  1438	}
  1439	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
