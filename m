Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A14046C71B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbhLGWLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:11:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:10367 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237622AbhLGWLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:11:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="224565675"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="224565675"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 14:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="611853386"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Dec 2021 14:08:15 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muidC-000N0v-KZ; Tue, 07 Dec 2021 22:08:14 +0000
Date:   Wed, 8 Dec 2021 06:07:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls 8/8] net/sunrpc/svcauth.c:39:10: error:
 'RPC_AUTH_TLS' undeclared here (not in a function); did you mean
 'RPC_AUTH_GSS'?
Message-ID: <202112080624.nH4NZavB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls
head:   21c40b0003975c1afe4b59126aba2c547103ccae
commit: 21c40b0003975c1afe4b59126aba2c547103ccae [8/8] SUNRPC: Teach server to recognize RPC_AUTH_TLS
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211208/202112080624.nH4NZavB-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=21c40b0003975c1afe4b59126aba2c547103ccae
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls
        git checkout 21c40b0003975c1afe4b59126aba2c547103ccae
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash net/sunrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/sunrpc/svcauth.c:39:10: error: 'RPC_AUTH_TLS' undeclared here (not in a function); did you mean 'RPC_AUTH_GSS'?
      39 |         [RPC_AUTH_TLS]  = (struct auth_ops __force __rcu *)&svcauth_tls,
         |          ^~~~~~~~~~~~
         |          RPC_AUTH_GSS
>> net/sunrpc/svcauth.c:39:10: error: array index in initializer not of integer type
   net/sunrpc/svcauth.c:39:10: note: (near initialization for 'authtab')
--
   net/sunrpc/svcauth_unix.c: In function 'svcauth_tls_accept':
>> net/sunrpc/svcauth_unix.c:842:36: error: 'RPC_AUTH_TLS' undeclared (first use in this function); did you mean 'RPC_AUTH_GSS'?
     842 |         rqstp->rq_cred.cr_flavor = RPC_AUTH_TLS;
         |                                    ^~~~~~~~~~~~
         |                                    RPC_AUTH_GSS
   net/sunrpc/svcauth_unix.c:842:36: note: each undeclared identifier is reported only once for each function it appears in
   net/sunrpc/svcauth_unix.c: At top level:
>> net/sunrpc/svcauth_unix.c:849:27: error: 'RPC_AUTH_TLS' undeclared here (not in a function); did you mean 'RPC_AUTH_GSS'?
     849 |         .flavour        = RPC_AUTH_TLS,
         |                           ^~~~~~~~~~~~
         |                           RPC_AUTH_GSS

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_SHA1_SSSE3
   Depends on CRYPTO && X86 && 64BIT
   Selected by
   - TLS_HANDSHAKE && NET && TLS && TLS_SOFTIRQ


vim +39 net/sunrpc/svcauth.c

    35	
    36	static struct auth_ops __rcu *authtab[RPC_AUTH_MAXFLAVOR] = {
    37		[RPC_AUTH_NULL] = (struct auth_ops __force __rcu *)&svcauth_null,
    38		[RPC_AUTH_UNIX] = (struct auth_ops __force __rcu *)&svcauth_unix,
  > 39		[RPC_AUTH_TLS]  = (struct auth_ops __force __rcu *)&svcauth_tls,
    40	};
    41	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
