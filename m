Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE144B5917
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbiBNRvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:51:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357308AbiBNRu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:50:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD22652C4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:50:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE8261598
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0463C340E9;
        Mon, 14 Feb 2022 17:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644861047;
        bh=uov7EjYTMvpPjFpkPhJJRxqMsegsnmPylESXjrtQkOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jt0SSb6zZbVQJoycFRPYUImdn1TOg90ZrzSCxXNea/Oro76q1iBhjHf5uGq+cv7Pe
         r/KRw+qgDlX7R4xka9Mx+2TU7C4vQpHb7OCfPIBSKWix3fD+kD5wuPyhM1DjT87r+y
         zpFAOmlFvnkU1Pk1k8zOeZ2e1fPjjuobFE2J6NiFngUEvdjCMerTs7e7Ou/3TudhL7
         ood1ZW2rIlu9c3tJ1SFIRDxL9sATELtzlGC10X31ZYCMLKjf+4pwBFEEeJ9lITph45
         bA/SAZGT5UWsGcUZyWcTyvr+hzgLZhGFr/ShksK9GzS6NweT2MLGSrbgsy8hkiTqf1
         kmHYbo++DOQcQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>,
        kernel test robot <lkp@intel.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org
Subject: Re: [PATCH v6 7/7] kernfs: Replace per-fs rwsem with hashed ones.
Date:   Mon, 14 Feb 2022 10:49:51 -0700
Message-Id: <20220214174951.131423-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214120322.2402628-8-imran.f.khan@oracle.com>
References: <20220214120322.2402628-8-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:19:23AM +0800, kernel test robot wrote:
> Hi Imran,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on 6d9bd4ad4ca08b1114e814c2c42383b8b13be631]
> 
> url:    https://github.com/0day-ci/linux/commits/Imran-Khan/kernfs-Introduce-hashed-mutexes-to-replace-global-kernfs_open_file_mutex/20220214-200700
> base:   6d9bd4ad4ca08b1114e814c2c42383b8b13be631
> config: hexagon-randconfig-r012-20220213 (https://download.01.org/0day-ci/archive/20220214/202202142322.OezS0EtW-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/48eab913f80f1555d57b964ef7cdba17f5ec5d1f
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Imran-Khan/kernfs-Introduce-hashed-mutexes-to-replace-global-kernfs_open_file_mutex/20220214-200700
>         git checkout 48eab913f80f1555d57b964ef7cdba17f5ec5d1f
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/kernfs/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/kernfs/dir.c:1619:7: warning: variable 'old_parent' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>                    if (!new_name)
>                        ^~~~~~~~~
>    fs/kernfs/dir.c:1653:50: note: uninitialized use occurs here
>            up_write_kernfs_rwsem_rename_ns(kn, new_parent, old_parent);
>                                                            ^~~~~~~~~~
>    fs/kernfs/dir.c:1619:3: note: remove the 'if' if its condition is always false
>                    if (!new_name)
>                    ^~~~~~~~~~~~~~
>    fs/kernfs/dir.c:1612:6: warning: variable 'old_parent' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>            if (kernfs_find_ns(new_parent, new_name, new_ns))
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/kernfs/dir.c:1653:50: note: uninitialized use occurs here
>            up_write_kernfs_rwsem_rename_ns(kn, new_parent, old_parent);
>                                                            ^~~~~~~~~~
>    fs/kernfs/dir.c:1612:2: note: remove the 'if' if its condition is always false
>            if (kernfs_find_ns(new_parent, new_name, new_ns))
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/kernfs/dir.c:1607:6: warning: variable 'old_parent' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>            if ((kn->parent == new_parent) && (kn->ns == new_ns) &&
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/kernfs/dir.c:1653:50: note: uninitialized use occurs here
>            up_write_kernfs_rwsem_rename_ns(kn, new_parent, old_parent);
>                                                            ^~~~~~~~~~
>    fs/kernfs/dir.c:1607:2: note: remove the 'if' if its condition is always false
>            if ((kn->parent == new_parent) && (kn->ns == new_ns) &&
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/kernfs/dir.c:1602:6: warning: variable 'old_parent' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>            if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/kernfs/dir.c:1653:50: note: uninitialized use occurs here
>            up_write_kernfs_rwsem_rename_ns(kn, new_parent, old_parent);
>                                                            ^~~~~~~~~~
>    fs/kernfs/dir.c:1602:2: note: remove the 'if' if its condition is always false
>            if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> fs/kernfs/dir.c:1602:6: warning: variable 'old_parent' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
>            if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    fs/kernfs/dir.c:1653:50: note: uninitialized use occurs here
>            up_write_kernfs_rwsem_rename_ns(kn, new_parent, old_parent);
>                                                            ^~~~~~~~~~
>    fs/kernfs/dir.c:1602:6: note: remove the '||' if its condition is always false
>            if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> fs/kernfs/dir.c:1602:6: warning: variable 'old_parent' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
>            if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
>                ^~~~~~~~~~~~~~~~~~
>    fs/kernfs/dir.c:1653:50: note: uninitialized use occurs here
>            up_write_kernfs_rwsem_rename_ns(kn, new_parent, old_parent);
>                                                            ^~~~~~~~~~
>    fs/kernfs/dir.c:1602:6: note: remove the '||' if its condition is always false
>            if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
>                ^~~~~~~~~~~~~~~~~~~~~
>    fs/kernfs/dir.c:1591:32: note: initialize the variable 'old_parent' to silence this warning
>            struct kernfs_node *old_parent;
>                                          ^
>                                           = NULL
>    6 warnings generated.
> 
> 
> vim +1619 fs/kernfs/dir.c
> 
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1580  
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1581  /**
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1582   * kernfs_rename_ns - move and rename a kernfs_node
> 324a56e16e44ba Tejun Heo          2013-12-11  1583   * @kn: target node
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1584   * @new_parent: new parent to put @sd under
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1585   * @new_name: new name
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1586   * @new_ns: new namespace tag
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1587   */
> 324a56e16e44ba Tejun Heo          2013-12-11  1588  int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1589  		     const char *new_name, const void *new_ns)
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1590  {
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1591  	struct kernfs_node *old_parent;
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1592  	const char *old_name = NULL;
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1593  	int error;
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1594  
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1595  	/* can't move or rename root */
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1596  	if (!kn->parent)
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1597  		return -EINVAL;
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1598  
> 48eab913f80f15 Imran Khan         2022-02-14  1599  	down_write_kernfs_rwsem_rename_ns(kn, kn->parent, new_parent);
> 798c75a0d44cdb Greg Kroah-Hartman 2014-01-13  1600  
> d0ae3d4347ee02 Tejun Heo          2013-12-11  1601  	error = -ENOENT;
> ea015218f2f7ac Eric W. Biederman  2015-05-13 @1602  	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
> ea015218f2f7ac Eric W. Biederman  2015-05-13  1603  	    (new_parent->flags & KERNFS_EMPTY_DIR))
> d0ae3d4347ee02 Tejun Heo          2013-12-11  1604  		goto out;
> d0ae3d4347ee02 Tejun Heo          2013-12-11  1605  
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1606  	error = 0;
> adc5e8b58f4886 Tejun Heo          2013-12-11  1607  	if ((kn->parent == new_parent) && (kn->ns == new_ns) &&
> adc5e8b58f4886 Tejun Heo          2013-12-11  1608  	    (strcmp(kn->name, new_name) == 0))
> 798c75a0d44cdb Greg Kroah-Hartman 2014-01-13  1609  		goto out;	/* nothing to rename */
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1610  
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1611  	error = -EEXIST;
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1612  	if (kernfs_find_ns(new_parent, new_name, new_ns))
> 798c75a0d44cdb Greg Kroah-Hartman 2014-01-13  1613  		goto out;
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1614  
> 324a56e16e44ba Tejun Heo          2013-12-11  1615  	/* rename kernfs_node */
> adc5e8b58f4886 Tejun Heo          2013-12-11  1616  	if (strcmp(kn->name, new_name) != 0) {
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1617  		error = -ENOMEM;
> 75287a677ba1be Andrzej Hajda      2015-02-13  1618  		new_name = kstrdup_const(new_name, GFP_KERNEL);
> fd7b9f7b9776b1 Tejun Heo          2013-11-28 @1619  		if (!new_name)
> 798c75a0d44cdb Greg Kroah-Hartman 2014-01-13  1620  			goto out;
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1621  	} else {
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1622  		new_name = NULL;
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1623  	}
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1624  
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1625  	/*
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1626  	 * Move to the appropriate place in the appropriate directories rbtree.
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1627  	 */
> c637b8acbe079e Tejun Heo          2013-12-11  1628  	kernfs_unlink_sibling(kn);
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1629  	kernfs_get(new_parent);
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1630  
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1631  	/* rename_lock protects ->parent and ->name accessors */
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1632  	spin_lock_irq(&kernfs_rename_lock);
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1633  
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1634  	old_parent = kn->parent;
> adc5e8b58f4886 Tejun Heo          2013-12-11  1635  	kn->parent = new_parent;
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1636  
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1637  	kn->ns = new_ns;
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1638  	if (new_name) {
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1639  		old_name = kn->name;
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1640  		kn->name = new_name;
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1641  	}
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1642  
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1643  	spin_unlock_irq(&kernfs_rename_lock);
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1644  
> 9561a8961c708f Tejun Heo          2014-02-10  1645  	kn->hash = kernfs_name_hash(kn->name, kn->ns);
> c637b8acbe079e Tejun Heo          2013-12-11  1646  	kernfs_link_sibling(kn);
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1647  
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1648  	kernfs_put(old_parent);
> 75287a677ba1be Andrzej Hajda      2015-02-13  1649  	kfree_const(old_name);
> 3eef34ad7dc369 Tejun Heo          2014-02-07  1650  
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1651  	error = 0;
> ae34372eb8408b Tejun Heo          2014-01-10  1652   out:
> 48eab913f80f15 Imran Khan         2022-02-14  1653  	up_write_kernfs_rwsem_rename_ns(kn, new_parent, old_parent);
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1654  	return error;
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1655  }
> fd7b9f7b9776b1 Tejun Heo          2013-11-28  1656  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

I am forwarding this along as a reply to the original posting so that
this patch series is not picked up in its current form. This warning
looks legitimate to me and it will break allmodconfig due to -Werror.

Intel folks, why did this get sent to the author privately, rather than
as a reply to the original posting, given the patch is still in review?

Cheers,
Nathan
