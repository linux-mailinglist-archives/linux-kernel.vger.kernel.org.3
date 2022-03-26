Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34B24E843E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 21:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiCZU5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiCZU5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:57:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB3674DE5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648328141; x=1679864141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6QaBuzK9xzxNTQw6dxJrzISS6d9uJyAB2wH4iKGnYhE=;
  b=kORKOkFL7OPwT2KG/7+kaAWY+GIIK5TNBmaadd8iyVdpX55OFopNarhH
   osDz8xrTr59ttPCUbDcMWoR2bRyGrnTv82OHwp3wsDHKnwuCOsvF20YDC
   7iar+U+EZf6DR4B4lk93ndTdbJ3G7O0XqtgEKYvhiN7KcnGKuZGTUMgBR
   Z+Te7503CgaiSIuET7guQ+uDMVwOhxk6pwPDGo+P3/7eykJi1eLoHtfZe
   KLTQYWcD9QsO2r+O6+v8K5mjX4GOICV3AeCf+dVXu6L+3IyvDRbqI2L3y
   Sh6IAWvAdeCdkN6JcPGwcRPtyOi8oVLsUwa+Zq9/CHWzqj7vKt6C3TynW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="258772418"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="258772418"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 13:55:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="520556971"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2022 13:55:37 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYDRh-0000PE-7A; Sat, 26 Mar 2022 20:55:37 +0000
Date:   Sun, 27 Mar 2022 04:55:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, paul@paul-moore.com, eparis@redhat.com,
        linux-audit@redhat.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
Message-ID: <202203270449.WBYQF9X3-lkp@intel.com>
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on pcmoore-audit/next]
[also build test ERROR on v5.17 next-20220325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/audit-do-a-quick-exit-when-syscall-number-is-invalid/20220326-174904
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220327/202203270449.WBYQF9X3-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/052b1a11a0bec23358ecc22ad9b085590efd3057
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/audit-do-a-quick-exit-when-syscall-number-is-invalid/20220326-174904
        git checkout 052b1a11a0bec23358ecc22ad9b085590efd3057
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/init.h:5,
                    from kernel/auditsc.c:34:
   kernel/auditsc.c: In function '__audit_syscall_exit':
>> kernel/auditsc.c:2081:61: error: 'NR_syscalls' undeclared (first use in this function); did you mean 'si_syscall'?
    2081 |             unlikely(context->major < 0 || context->major > NR_syscalls))
         |                                                             ^~~~~~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   kernel/auditsc.c:2081:61: note: each undeclared identifier is reported only once for each function it appears in
    2081 |             unlikely(context->major < 0 || context->major > NR_syscalls))
         |                                                             ^~~~~~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^


vim +2081 kernel/auditsc.c

  2063	
  2064	/**
  2065	 * __audit_syscall_exit - deallocate audit context after a system call
  2066	 * @success: success value of the syscall
  2067	 * @return_code: return value of the syscall
  2068	 *
  2069	 * Tear down after system call.  If the audit context has been marked as
  2070	 * auditable (either because of the AUDIT_STATE_RECORD state from
  2071	 * filtering, or because some other part of the kernel wrote an audit
  2072	 * message), then write out the syscall information.  In call cases,
  2073	 * free the names stored from getname().
  2074	 */
  2075	void __audit_syscall_exit(int success, long return_code)
  2076	{
  2077		struct audit_context *context = audit_context();
  2078	
  2079		if (!context || context->dummy ||
  2080		    context->context != AUDIT_CTX_SYSCALL ||
> 2081		    unlikely(context->major < 0 || context->major > NR_syscalls))
  2082			goto out;
  2083	
  2084		/* this may generate CONFIG_CHANGE records */
  2085		if (!list_empty(&context->killed_trees))
  2086			audit_kill_trees(context);
  2087	
  2088		/* run through both filters to ensure we set the filterkey properly */
  2089		audit_filter_syscall(current, context);
  2090		audit_filter_inodes(current, context);
  2091		if (context->current_state < AUDIT_STATE_RECORD)
  2092			goto out;
  2093	
  2094		audit_return_fixup(context, success, return_code);
  2095		audit_log_exit();
  2096	
  2097	out:
  2098		audit_reset_context(context);
  2099	}
  2100	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
