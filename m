Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43F2500CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbiDNMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbiDNMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:02:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617E3CDB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649937622; x=1681473622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7Xxdd7CTU4JSmAB8vadoOE5nFDUv6g9RmCSrNgR6vQE=;
  b=Ai+wY5l3JTWhsnlpRnKvTkvnaVLk7uoYzp968oM4SZxg4sWNv8rSAc7w
   pFD+HX3um0PZXF8Yi59Ir2MYh/ICh5zBX6mhOBqJ0KPZlUSVlyyge8l59
   ShJSlPyjJwc5utn9wYAQrA+kP65N4tMSDzm+0FXcBQZ3bekkNqROInNiy
   ZvRPmlKm0p5uy9Vl11U8yhJFFs2osxooFMouE2//pIwN50fWfxz4S70el
   xuVM9Pxcw/umE/MWCN8nM55065cjBsL2ZfkuOehrULaH6V6EBDFqiyQ9v
   4Xijll9m+IrsbQYaksEzc0ws5onNYoEafGCqDcGUk6jLUIi6dJGNmLVRk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="242846379"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="242846379"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="661351212"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2022 05:00:20 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ney95-0000w1-Cu;
        Thu, 14 Apr 2022 12:00:19 +0000
Date:   Thu, 14 Apr 2022 19:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 5/21] net/tls/af_tlsh.c:635:6:
 warning: variable 'outlen' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202204141943.5IfaboCX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   77d1002f5a5209bebd901cf895b52730199c0ba4
commit: 10e1271d05810b1163c4e79bc9597c0177e2aaeb [5/21] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220414/202204141943.5IfaboCX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=10e1271d05810b1163c4e79bc9597c0177e2aaeb
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout 10e1271d05810b1163c4e79bc9597c0177e2aaeb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/tls/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/tls/af_tlsh.c:635:6: warning: variable 'outlen' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (val) {
               ^~~
   net/tls/af_tlsh.c:647:15: note: uninitialized use occurs here
           if (put_user(outlen, optlen))
                        ^~~~~~
   arch/x86/include/asm/uaccess.h:225:70: note: expanded from macro 'put_user'
   #define put_user(x, ptr) ({ might_fault(); do_put_user_call(put_user,x,ptr); })
                                                                        ^
   arch/x86/include/asm/uaccess.h:197:14: note: expanded from macro 'do_put_user_call'
           __val_pu = (x);                                                 \
                       ^
   net/tls/af_tlsh.c:635:2: note: remove the 'if' if its condition is always false
           if (val) {
           ^~~~~~~~~~
   net/tls/af_tlsh.c:611:12: note: initialize the variable 'outlen' to silence this warning
           int outlen, len, ret;
                     ^
                      = 0
   1 warning generated.


vim +635 net/tls/af_tlsh.c

   606	
   607	static int tlsh_getsockopt_priorities(struct sock *sk, char __user *optval,
   608					      int __user *optlen)
   609	{
   610		struct tlsh_sock_info *info;
   611		int outlen, len, ret;
   612		const char *val;
   613	
   614		if (get_user(len, optlen))
   615			return -EFAULT;
   616		if (!optval)
   617			return -EINVAL;
   618	
   619		ret = 0;
   620	
   621		sock_hold(sk);
   622		write_lock_bh(&sk->sk_callback_lock);
   623	
   624		info = sk->sk_tlsh_priv;
   625		if (info) {
   626			val = info->tsi_tls_priorities;
   627		} else {
   628			write_unlock_bh(&sk->sk_callback_lock);
   629			ret = -EBUSY;
   630			goto out_put;
   631		}
   632	
   633		write_unlock_bh(&sk->sk_callback_lock);
   634	
 > 635		if (val) {
   636			int outlen = strlen(val);
   637	
   638			if (len < outlen)
   639				ret = -EINVAL;
   640			else if (copy_to_user(optval, val, outlen))
   641				ret = -EFAULT;
   642		} else {
   643			outlen = 0;
   644		}
   645	
   646	
   647		if (put_user(outlen, optlen))
   648			ret = -EFAULT;
   649	
   650	out_put:
   651		sock_put(sk);
   652		return ret;
   653	}
   654	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
