Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EEA4D764B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiCMPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiCMPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:18:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA99548B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647184621; x=1678720621;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O0VqEfqjnBx+Dpm+Q40vwVnp1fvnK7PimOrVNx2xalU=;
  b=PKEXd2ToSizFgaPVMRrHsv6BszCBuaiyJPqDcHatUJXBaT5QCaRZ6MBx
   0ERS6J//mDNHqYs9EURcmO6+aJR3b09IubMIEretgSIZekT6UjBJDb8TU
   dLm/zy404WyeFaGjZd8baN2jcq5m1yb9xja/fDFysQ+tA8VahW89mXQ7V
   gzb56lvfvtTJn/BnYoSwpqbDBcezcnLx7cRNUxdWyQDip8tE87v+PA7OX
   7pI4kDZDGUUgVm0zr8mN5y45TVpEOSUqnCzhYtbT6QPBcU4jCajkWfrye
   Cx+H5RHYZ9TXjXbXSNbJnwm7y8sFzqddsXtIHQDtHs+OFNKRHUzLOzPjC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="253437781"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="253437781"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 08:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="497324618"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Mar 2022 08:16:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTPxq-000948-U5; Sun, 13 Mar 2022 15:16:58 +0000
Date:   Sun, 13 Mar 2022 23:16:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 152/156] net/tls/af_tlsh.c:647:6:
 warning: variable 'outlen' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202203132353.gVyyCtsm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 90c95b5f64cbdc8e88523332e8c28796669b2db1 [152/156] af_tlsh: allocate priorities string
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220313/202203132353.gVyyCtsm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0467eb2cb7654c15ae366967ef35093c5724c416)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=90c95b5f64cbdc8e88523332e8c28796669b2db1
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 90c95b5f64cbdc8e88523332e8c28796669b2db1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/tls/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/tls/af_tlsh.c:647:6: warning: variable 'outlen' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (val) {
               ^~~
   net/tls/af_tlsh.c:659:15: note: uninitialized use occurs here
           if (put_user(outlen, optlen))
                        ^~~~~~
   arch/x86/include/asm/uaccess.h:252:70: note: expanded from macro 'put_user'
   #define put_user(x, ptr) ({ might_fault(); do_put_user_call(put_user,x,ptr); })
                                                                        ^
   arch/x86/include/asm/uaccess.h:224:14: note: expanded from macro 'do_put_user_call'
           __val_pu = (x);                                                 \
                       ^
   net/tls/af_tlsh.c:647:2: note: remove the 'if' if its condition is always false
           if (val) {
           ^~~~~~~~~~
   net/tls/af_tlsh.c:623:12: note: initialize the variable 'outlen' to silence this warning
           int outlen, len, ret;
                     ^
                      = 0
   1 warning generated.


vim +647 net/tls/af_tlsh.c

33ec82590b0b91 Chuck Lever     2021-11-19  618  
33ec82590b0b91 Chuck Lever     2021-11-19  619  static int tlsh_getsockopt_priorities(struct sock *sk, char __user *optval,
33ec82590b0b91 Chuck Lever     2021-11-19  620  				      int __user *optlen)
33ec82590b0b91 Chuck Lever     2021-11-19  621  {
33ec82590b0b91 Chuck Lever     2021-11-19  622  	struct tlsh_sock_info *info;
33ec82590b0b91 Chuck Lever     2021-11-19  623  	int outlen, len, ret;
33ec82590b0b91 Chuck Lever     2021-11-19  624  	const char *val;
33ec82590b0b91 Chuck Lever     2021-11-19  625  
33ec82590b0b91 Chuck Lever     2021-11-19  626  	if (get_user(len, optlen))
33ec82590b0b91 Chuck Lever     2021-11-19  627  		return -EFAULT;
33ec82590b0b91 Chuck Lever     2021-11-19  628  	if (!optval)
33ec82590b0b91 Chuck Lever     2021-11-19  629  		return -EINVAL;
33ec82590b0b91 Chuck Lever     2021-11-19  630  
33ec82590b0b91 Chuck Lever     2021-11-19  631  	ret = 0;
33ec82590b0b91 Chuck Lever     2021-11-19  632  
33ec82590b0b91 Chuck Lever     2021-11-19  633  	sock_hold(sk);
33ec82590b0b91 Chuck Lever     2021-11-19  634  	write_lock_bh(&sk->sk_callback_lock);
33ec82590b0b91 Chuck Lever     2021-11-19  635  
33ec82590b0b91 Chuck Lever     2021-11-19  636  	info = sk->sk_tlsh_priv;
33ec82590b0b91 Chuck Lever     2021-11-19  637  	if (info) {
33ec82590b0b91 Chuck Lever     2021-11-19  638  		val = info->tsi_tls_priorities;
33ec82590b0b91 Chuck Lever     2021-11-19  639  	} else {
33ec82590b0b91 Chuck Lever     2021-11-19  640  		write_unlock_bh(&sk->sk_callback_lock);
33ec82590b0b91 Chuck Lever     2021-11-19  641  		ret = -EBUSY;
33ec82590b0b91 Chuck Lever     2021-11-19  642  		goto out_put;
33ec82590b0b91 Chuck Lever     2021-11-19  643  	}
33ec82590b0b91 Chuck Lever     2021-11-19  644  
33ec82590b0b91 Chuck Lever     2021-11-19  645  	write_unlock_bh(&sk->sk_callback_lock);
33ec82590b0b91 Chuck Lever     2021-11-19  646  
33ec82590b0b91 Chuck Lever     2021-11-19 @647  	if (val) {
33ec82590b0b91 Chuck Lever     2021-11-19  648  		int outlen = strlen(val);
33ec82590b0b91 Chuck Lever     2021-11-19  649  
90c95b5f64cbdc Hannes Reinecke 2022-03-10  650  		if (len < outlen)
33ec82590b0b91 Chuck Lever     2021-11-19  651  			ret = -EINVAL;
90c95b5f64cbdc Hannes Reinecke 2022-03-10  652  		else if (copy_to_user(optval, val, outlen))
90c95b5f64cbdc Hannes Reinecke 2022-03-10  653  			ret = -EFAULT;
33ec82590b0b91 Chuck Lever     2021-11-19  654  	} else {
33ec82590b0b91 Chuck Lever     2021-11-19  655  		outlen = 0;
33ec82590b0b91 Chuck Lever     2021-11-19  656  	}
33ec82590b0b91 Chuck Lever     2021-11-19  657  
90c95b5f64cbdc Hannes Reinecke 2022-03-10  658  
90c95b5f64cbdc Hannes Reinecke 2022-03-10  659  	if (put_user(outlen, optlen))
33ec82590b0b91 Chuck Lever     2021-11-19  660  		ret = -EFAULT;
33ec82590b0b91 Chuck Lever     2021-11-19  661  
33ec82590b0b91 Chuck Lever     2021-11-19  662  out_put:
33ec82590b0b91 Chuck Lever     2021-11-19  663  	sock_put(sk);
33ec82590b0b91 Chuck Lever     2021-11-19  664  	return ret;
33ec82590b0b91 Chuck Lever     2021-11-19  665  }
33ec82590b0b91 Chuck Lever     2021-11-19  666  

:::::: The code at line 647 was first introduced by commit
:::::: 33ec82590b0b919215a255fb431d661be4807b45 net/tls: Add support for PF_TLSH (a TLS handshake listener)

:::::: TO: Chuck Lever <chuck.lever@oracle.com>
:::::: CC: Hannes Reinecke <hare@suse.de>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
