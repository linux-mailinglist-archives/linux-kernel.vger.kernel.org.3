Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D924F5234
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849609AbiDFCj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452776AbiDEWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:32:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A571A396
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649193998; x=1680729998;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rX0tzqX8YFSgrdRxxHnGr/NwDUBIKDrHrm+BwAzF8xE=;
  b=M4xSitIeXKFhta2LZkSh/hPsiKvqYf7cXN6efZBvfj2WM2yLEEYXSTKT
   LI63jeF7jgAN75lRwvj8uMQ53UEN8XMTU0+t+7C87+lUTaE0piq/gHR/O
   yZy4QEWou5zbJsq9Y7gGnKejwGWCo+JYIxtSXK0jzHFiCCu1KIMx4MOug
   5wiZ2t5pKb1TMDqPYJ7ShuGUPojI+VO2LFsqVPrrOwm1QnJpNxfGpsYYe
   6F1fme3jfwHi9+IaAJxmey7FPCSbZG21ue+vfA1LevwsyRPAnIi2/a/oa
   Ay1FV0hLxnH8RHHCmK7zBK1qQQXFoay4+PUm6P1F+ou8NkIuWm7kCREDH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="241453990"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="241453990"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 14:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="588098251"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 14:26:34 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbqh8-0003lv-3H;
        Tue, 05 Apr 2022 21:26:34 +0000
Date:   Wed, 6 Apr 2022 05:25:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [mcgrof:modules-next 1/24] kernel/module/main.c:912:1: sparse:
 sparse: Using plain integer as NULL pointer
Message-ID: <202204060500.lvFfHP76-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
head:   eeaec7801c421e17edda6e45a32d4a5596b633da
commit: cfc1d277891eb499b3b5354df33b30f598683e90 [1/24] module: Move all into module/
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220406/202204060500.lvFfHP76-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=cfc1d277891eb499b3b5354df33b30f598683e90
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof modules-next
        git checkout cfc1d277891eb499b3b5354df33b30f598683e90
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/module/main.c:912:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/module/main.c:912:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/module/main.c:2761:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct mod_kallsyms [noderef] __rcu *kallsyms @@     got void * @@
   kernel/module/main.c:2761:23: sparse:     expected struct mod_kallsyms [noderef] __rcu *kallsyms
   kernel/module/main.c:2761:23: sparse:     got void *
   kernel/module/main.c:4169:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/module/main.c:4169:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/module/main.c:4169:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/module/main.c:4169:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/module/main.c:4189:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/module/main.c:4189:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/module/main.c:4486:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct mod_kallsyms *kallsyms @@     got struct mod_kallsyms [noderef] __rcu *kallsyms @@
   kernel/module/main.c:4486:52: sparse:     expected struct mod_kallsyms *kallsyms
   kernel/module/main.c:4486:52: sparse:     got struct mod_kallsyms [noderef] __rcu *kallsyms
   kernel/module/main.c: note: in included file (through include/linux/mm_types.h, include/linux/buildid.h, include/linux/module.h, ...):
   include/linux/rbtree.h:74:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree.h:74:9: sparse:    struct rb_node [noderef] __rcu *
   include/linux/rbtree.h:74:9: sparse:    struct rb_node *
   include/linux/rbtree.h:74:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree.h:74:9: sparse:    struct rb_node [noderef] __rcu *
   include/linux/rbtree.h:74:9: sparse:    struct rb_node *

vim +912 kernel/module/main.c

^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  911  
17da2bd90abf428 kernel/module.c Heiko Carstens      2009-01-14 @912  SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
17da2bd90abf428 kernel/module.c Heiko Carstens      2009-01-14  913  		unsigned int, flags)
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  914  {
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  915  	struct module *mod;
dfff0a0671baf4e kernel/module.c Greg Kroah-Hartman  2007-02-23  916  	char name[MODULE_NAME_LEN];
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  917  	int ret, forced = 0;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  918  
3d43321b7015387 kernel/module.c Kees Cook           2009-04-02  919  	if (!capable(CAP_SYS_MODULE) || modules_disabled)
dfff0a0671baf4e kernel/module.c Greg Kroah-Hartman  2007-02-23  920  		return -EPERM;
dfff0a0671baf4e kernel/module.c Greg Kroah-Hartman  2007-02-23  921  
dfff0a0671baf4e kernel/module.c Greg Kroah-Hartman  2007-02-23  922  	if (strncpy_from_user(name, name_user, MODULE_NAME_LEN-1) < 0)
dfff0a0671baf4e kernel/module.c Greg Kroah-Hartman  2007-02-23  923  		return -EFAULT;
dfff0a0671baf4e kernel/module.c Greg Kroah-Hartman  2007-02-23  924  	name[MODULE_NAME_LEN-1] = '\0';
dfff0a0671baf4e kernel/module.c Greg Kroah-Hartman  2007-02-23  925  
f6276ac95bde431 kernel/module.c Richard Guy Briggs  2017-05-02  926  	audit_log_kern_module(name);
f6276ac95bde431 kernel/module.c Richard Guy Briggs  2017-05-02  927  
3fc1f1e27a5b807 kernel/module.c Tejun Heo           2010-05-06  928  	if (mutex_lock_interruptible(&module_mutex) != 0)
3fc1f1e27a5b807 kernel/module.c Tejun Heo           2010-05-06  929  		return -EINTR;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  930  
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  931  	mod = find_module(name);
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  932  	if (!mod) {
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  933  		ret = -ENOENT;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  934  		goto out;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  935  	}
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  936  
2c02dfe7fe3fba9 kernel/module.c Linus Torvalds      2010-05-31  937  	if (!list_empty(&mod->source_list)) {
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  938  		/* Other modules depend on us: get rid of them first. */
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  939  		ret = -EWOULDBLOCK;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  940  		goto out;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  941  	}
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  942  
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  943  	/* Doing init or already dying? */
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  944  	if (mod->state != MODULE_STATE_LIVE) {
3f2b9c9cdf389e3 kernel/module.c Rusty Russell       2013-09-17  945  		/* FIXME: if (force), slam module count damn the torpedoes */
5e12416927975aa kernel/module.c Jim Cromie          2011-12-06  946  		pr_debug("%s already dying\n", mod->name);
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  947  		ret = -EBUSY;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  948  		goto out;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  949  	}
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  950  
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  951  	/* If it has an init func, it must have an exit func to unload */
af49d9248fca6f2 kernel/module.c Rusty Russell       2007-10-16  952  	if (mod->init && !mod->exit) {
fb1697933a03ec4 kernel/module.c Akinobu Mita        2006-01-08  953  		forced = try_force_unload(flags);
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  954  		if (!forced) {
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  955  			/* This module can't be removed */
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  956  			ret = -EBUSY;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  957  			goto out;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  958  		}
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  959  	}
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  960  
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  961  	ret = try_stop_module(mod, flags, &forced);
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  962  	if (ret != 0)
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  963  		goto out;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  964  
6389a385114ae35 kernel/module.c Ashutosh Naik       2006-03-23  965  	mutex_unlock(&module_mutex);
df4b565e1fbc777 kernel/module.c Peter Oberparleiter 2008-04-21  966  	/* Final destruction now no one is using it. */
df4b565e1fbc777 kernel/module.c Peter Oberparleiter 2008-04-21  967  	if (mod->exit != NULL)
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  968  		mod->exit();
df4b565e1fbc777 kernel/module.c Peter Oberparleiter 2008-04-21  969  	blocking_notifier_call_chain(&module_notify_list,
df4b565e1fbc777 kernel/module.c Peter Oberparleiter 2008-04-21  970  				     MODULE_STATE_GOING, mod);
7e545d6eca20ce8 kernel/module.c Jessica Yu          2016-03-16  971  	klp_module_going(mod);
7dcd182bec271ab kernel/module.c Jessica Yu          2016-02-16  972  	ftrace_release_mod(mod);
7dcd182bec271ab kernel/module.c Jessica Yu          2016-02-16  973  
22a9d645677feef kernel/module.c Arjan van de Ven    2009-01-07  974  	async_synchronize_full();
75676500f8298f0 kernel/module.c Rusty Russell       2010-06-05  975  
e14af7eeb47ea96 kernel/module.c Arjan van de Ven    2008-01-25  976  	/* Store the name of the last unloaded module for diagnostic purposes */
efa5345e39d01de kernel/module.c Rusty Russell       2008-01-29  977  	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  978  
75676500f8298f0 kernel/module.c Rusty Russell       2010-06-05  979  	free_module(mod);
5d603311615f612 kernel/module.c Konstantin Khorenko 2019-11-13  980  	/* someone could wait for the module in add_unformed_module() */
5d603311615f612 kernel/module.c Konstantin Khorenko 2019-11-13  981  	wake_up_all(&module_wq);
75676500f8298f0 kernel/module.c Rusty Russell       2010-06-05  982  	return 0;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  983  out:
6389a385114ae35 kernel/module.c Ashutosh Naik       2006-03-23  984  	mutex_unlock(&module_mutex);
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  985  	return ret;
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  986  }
^1da177e4c3f415 kernel/module.c Linus Torvalds      2005-04-16  987  

:::::: The code at line 912 was first introduced by commit
:::::: 17da2bd90abf428523de0fb98f7075e00e3ed42e [CVE-2009-0029] System call wrappers part 08

:::::: TO: Heiko Carstens <heiko.carstens@de.ibm.com>
:::::: CC: Heiko Carstens <heiko.carstens@de.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
