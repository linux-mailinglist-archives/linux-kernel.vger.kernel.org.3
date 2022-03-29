Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02A64EA7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiC2Ger (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiC2Gen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:34:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85FC199E12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 23:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648535581; x=1680071581;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b+xsrYYgRj8ZI/u2pSfAOvTw9v5HYhv+7RXB8v+73lk=;
  b=PyIVzbX71wesui4FDz5zixM0dm5Rc4UO9JnqjPOaWO6ARoip+mQL6hsK
   g7X4Z26jsEy/pfGavPjdGvgnWnRbB23i07wQxMdiMXswC1q3LqF/F1FH3
   szog9CazcDOh9rP/mplh99LcLy4+YO8zSn883IWC0KxceDjl71AHxCKTc
   2c86Tewp0StB9GiYDU99J+9RJbKY51FG5YBTuVM9m2B5g/56w+GbMW63/
   Zn2vseU748M5FCpZaoZxiiFt4ZFJrVIdS8mBqCD8TZBb5Omaj8ZUvQbTP
   biFCz5c6bRDM/YwVPBj4/GsXa59+XJOT3/LRXms/wIfpBJfmucQOUeTjn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="241327959"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="241327959"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 23:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="585457295"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2022 23:32:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ5PW-0002kX-IA; Tue, 29 Mar 2022 06:32:58 +0000
Date:   Tue, 29 Mar 2022 14:32:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/kspp-stringop-overflow 5/5]
 arch/x86/mm/pgtable.c:442:27: warning: variable 'pmds' is uninitialized when
 used here
Message-ID: <202203291404.IHkCx1AG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/kspp-stringop-overflow
head:   d3becb16bbfe48ca524e4489b6c6c4fb1ccafa1a
commit: d3becb16bbfe48ca524e4489b6c6c4fb1ccafa1a [5/5] mm/pgtable: Fix Wstringop-overflow warnings in pgd_alloc()
config: i386-randconfig-a012-20220328 (https://download.01.org/0day-ci/archive/20220329/202203291404.IHkCx1AG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=d3becb16bbfe48ca524e4489b6c6c4fb1ccafa1a
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/kspp-stringop-overflow
        git checkout d3becb16bbfe48ca524e4489b6c6c4fb1ccafa1a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/mm/pgtable.c:442:27: warning: variable 'pmds' is uninitialized when used here [-Wuninitialized]
           if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
                                    ^~~~
   arch/x86/mm/pgtable.c:432:14: note: initialize the variable 'pmds' to silence this warning
           pmd_t **pmds;
                       ^
                        = NULL
>> arch/x86/mm/pgtable.c:445:27: warning: variable 'u_pmds' is uninitialized when used here [-Wuninitialized]
           if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
                                    ^~~~~~
   arch/x86/mm/pgtable.c:431:16: note: initialize the variable 'u_pmds' to silence this warning
           pmd_t **u_pmds;
                         ^
                          = NULL
   2 warnings generated.


vim +/pmds +442 arch/x86/mm/pgtable.c

1ec1fe73dfb711 Ingo Molnar         2008-03-19  434  
1db491f77b6ed0 Fenghua Yu          2015-01-15  435  	pgd = _pgd_alloc();
1ec1fe73dfb711 Ingo Molnar         2008-03-19  436  
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  437  	if (pgd == NULL)
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  438  		goto out;
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  439  
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  440  	mm->pgd = pgd;
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  441  
f59dbe9ca6707e Joerg Roedel        2018-07-18 @442  	if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  443  		goto out_free_pgd;
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  444  
f59dbe9ca6707e Joerg Roedel        2018-07-18 @445  	if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  446  		goto out_free_pmds;
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  447  
f59dbe9ca6707e Joerg Roedel        2018-07-18  448  	if (paravirt_pgd_alloc(mm) != 0)
f59dbe9ca6707e Joerg Roedel        2018-07-18  449  		goto out_free_user_pmds;
f59dbe9ca6707e Joerg Roedel        2018-07-18  450  
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  451  	/*
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  452  	 * Make sure that pre-populating the pmds is atomic with
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  453  	 * respect to anything walking the pgd_list, so that they
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  454  	 * never see a partially populated pgd.
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  455  	 */
a79e53d85683c6 Andrea Arcangeli    2011-02-16  456  	spin_lock(&pgd_lock);
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  457  
617d34d9e5d832 Jeremy Fitzhardinge 2010-09-21  458  	pgd_ctor(mm, pgd);
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  459  	pgd_prepopulate_pmd(mm, pgd, pmds);
f59dbe9ca6707e Joerg Roedel        2018-07-18  460  	pgd_prepopulate_user_pmd(mm, pgd, u_pmds);
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  461  
a79e53d85683c6 Andrea Arcangeli    2011-02-16  462  	spin_unlock(&pgd_lock);
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  463  
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  464  	return pgd;
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  465  
f59dbe9ca6707e Joerg Roedel        2018-07-18  466  out_free_user_pmds:
f59dbe9ca6707e Joerg Roedel        2018-07-18  467  	free_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS);
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  468  out_free_pmds:
f59dbe9ca6707e Joerg Roedel        2018-07-18  469  	free_pmds(mm, pmds, PREALLOCATED_PMDS);
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  470  out_free_pgd:
1db491f77b6ed0 Fenghua Yu          2015-01-15  471  	_pgd_free(pgd);
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  472  out:
d8d5900ef8afc5 Jeremy Fitzhardinge 2008-06-25  473  	return NULL;
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  474  }
4f76cd382213b2 Jeremy Fitzhardinge 2008-03-17  475  

:::::: The code at line 442 was first introduced by commit
:::::: f59dbe9ca6707eb7ffd0e24359085651c2d7df48 x86/pgtable/pae: Use separate kernel PMDs for user page-table

:::::: TO: Joerg Roedel <jroedel@suse.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
