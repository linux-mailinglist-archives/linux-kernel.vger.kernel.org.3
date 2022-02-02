Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137024A77E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiBBS0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:26:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:42006 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234373AbiBBS0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643826379; x=1675362379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g8EoUvggp9iMAw/cQe8bM94VtwgCidVUtmv26Xm9rTY=;
  b=b7P7WI2r9xA98nVBI+d2x6YOYx4CpWqLN53zDR+50uCu96H7Zpdz2vJf
   xbJtlQJIHxvRmmQ710rSubpcx7Q8tBDsTnfzJGsN2VDhPLo+hHcxK2vRC
   iOkN2arIbkNVXwYVULcGKSwTrravNuqfx+od4pXNaNGVdtU4mC3UbEB4g
   x/Y0Ayo1t9E5ZtpsVWzxIPRNGVYbm3sgqZ2DB6/z907aHuL4fvgJ8wIgA
   tYgpYmA1nkStrFwK0dQAw6JNYFZROfJ/apeDzluj7TaZ2D2gpHQ2AEPFJ
   tW2Yq0lFzipRDxciOVlJg+9isAHZ16cms+ymXTQlZtl201HDf5iajqS00
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228647105"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="228647105"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 10:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="631064499"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Feb 2022 10:26:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFKKe-000Uxt-6q; Wed, 02 Feb 2022 18:26:16 +0000
Date:   Thu, 3 Feb 2022 02:25:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Imran Khan <imran.f.khan@oracle.com>, tj@kernel.org,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] kernfs: Replace per-fs global rwsem with per-fs
 hashed rwsem.
Message-ID: <202202030237.zeUR5agU-lkp@intel.com>
References: <20220202145027.723733-3-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202145027.723733-3-imran.f.khan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Imran,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on a70bf4a85b43cb952bd39dd948b103b1b3eb2cf8]

url:    https://github.com/0day-ci/linux/commits/Imran-Khan/kernfs-use-hashed-mutex-and-spinlock-in-place-of-global-ones/20220202-225301
base:   a70bf4a85b43cb952bd39dd948b103b1b3eb2cf8
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220203/202202030237.zeUR5agU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/e1946294e8a0e6eb1f9876e7521c92f92c8c4af9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Imran-Khan/kernfs-use-hashed-mutex-and-spinlock-in-place-of-global-ones/20220202-225301
        git checkout e1946294e8a0e6eb1f9876e7521c92f92c8c4af9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash fs/kernfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/kernfs/dir.c: In function 'kernfs_dop_revalidate':
>> fs/kernfs/dir.c:1056:22: warning: variable 'root' set but not used [-Wunused-but-set-variable]
    1056 |  struct kernfs_root *root;
         |                      ^~~~
   fs/kernfs/dir.c: In function 'kernfs_iop_lookup':
   fs/kernfs/dir.c:1126:22: warning: variable 'root' set but not used [-Wunused-but-set-variable]
    1126 |  struct kernfs_root *root;
         |                      ^~~~
   fs/kernfs/dir.c: In function 'kernfs_remove_by_name_ns':
   fs/kernfs/dir.c:1572:11: warning: unused variable 'p_idx' [-Wunused-variable]
    1572 |  int idx, p_idx;
         |           ^~~~~
   fs/kernfs/dir.c:1572:6: warning: unused variable 'idx' [-Wunused-variable]
    1572 |  int idx, p_idx;
         |      ^~~
   fs/kernfs/dir.c:1571:22: warning: variable 'root' set but not used [-Wunused-but-set-variable]
    1571 |  struct kernfs_root *root;
         |                      ^~~~
   fs/kernfs/dir.c: In function 'kernfs_rename_ns':
   fs/kernfs/dir.c:1607:22: warning: variable 'root' set but not used [-Wunused-but-set-variable]
    1607 |  struct kernfs_root *root;
         |                      ^~~~
   fs/kernfs/dir.c: In function 'kernfs_fop_readdir':
   fs/kernfs/dir.c:1837:22: warning: variable 'root' set but not used [-Wunused-but-set-variable]
    1837 |  struct kernfs_root *root;
         |                      ^~~~


vim +/root +1056 fs/kernfs/dir.c

ea015218f2f7ac Eric W. Biederman 2015-05-13  1052  
d826e0365199cc Ian Kent          2021-06-15  1053  static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
d826e0365199cc Ian Kent          2021-06-15  1054  {
d826e0365199cc Ian Kent          2021-06-15  1055  	struct kernfs_node *kn;
393c3714081a53 Minchan Kim       2021-11-18 @1056  	struct kernfs_root *root;
d826e0365199cc Ian Kent          2021-06-15  1057  
d826e0365199cc Ian Kent          2021-06-15  1058  	if (flags & LOOKUP_RCU)
d826e0365199cc Ian Kent          2021-06-15  1059  		return -ECHILD;
d826e0365199cc Ian Kent          2021-06-15  1060  
c7e7c04274b13f Ian Kent          2021-07-16  1061  	/* Negative hashed dentry? */
c7e7c04274b13f Ian Kent          2021-07-16  1062  	if (d_really_is_negative(dentry)) {
c7e7c04274b13f Ian Kent          2021-07-16  1063  		struct kernfs_node *parent;
c7e7c04274b13f Ian Kent          2021-07-16  1064  
c7e7c04274b13f Ian Kent          2021-07-16  1065  		/* If the kernfs parent node has changed discard and
c7e7c04274b13f Ian Kent          2021-07-16  1066  		 * proceed to ->lookup.
c7e7c04274b13f Ian Kent          2021-07-16  1067  		 */
c7e7c04274b13f Ian Kent          2021-07-16  1068  		spin_lock(&dentry->d_lock);
c7e7c04274b13f Ian Kent          2021-07-16  1069  		parent = kernfs_dentry_node(dentry->d_parent);
c7e7c04274b13f Ian Kent          2021-07-16  1070  		if (parent) {
c7e7c04274b13f Ian Kent          2021-07-16  1071  			spin_unlock(&dentry->d_lock);
393c3714081a53 Minchan Kim       2021-11-18  1072  			root = kernfs_root(parent);
e1946294e8a0e6 Imran Khan        2022-02-03  1073  			down_read_kernfs_rwsem(parent, LOCK_SELF, 0);
393c3714081a53 Minchan Kim       2021-11-18  1074  			if (kernfs_dir_changed(parent, dentry)) {
e1946294e8a0e6 Imran Khan        2022-02-03  1075  				up_read_kernfs_rwsem(parent);
c7e7c04274b13f Ian Kent          2021-07-16  1076  				return 0;
c7e7c04274b13f Ian Kent          2021-07-16  1077  			}
e1946294e8a0e6 Imran Khan        2022-02-03  1078  			up_read_kernfs_rwsem(parent);
393c3714081a53 Minchan Kim       2021-11-18  1079  		} else
c7e7c04274b13f Ian Kent          2021-07-16  1080  			spin_unlock(&dentry->d_lock);
c7e7c04274b13f Ian Kent          2021-07-16  1081  
c7e7c04274b13f Ian Kent          2021-07-16  1082  		/* The kernfs parent node hasn't changed, leave the
c7e7c04274b13f Ian Kent          2021-07-16  1083  		 * dentry negative and return success.
c7e7c04274b13f Ian Kent          2021-07-16  1084  		 */
c7e7c04274b13f Ian Kent          2021-07-16  1085  		return 1;
c7e7c04274b13f Ian Kent          2021-07-16  1086  	}
d826e0365199cc Ian Kent          2021-06-15  1087  
d826e0365199cc Ian Kent          2021-06-15  1088  	kn = kernfs_dentry_node(dentry);
393c3714081a53 Minchan Kim       2021-11-18  1089  	root = kernfs_root(kn);
e1946294e8a0e6 Imran Khan        2022-02-03  1090  	down_read_kernfs_rwsem(kn, LOCK_SELF, 0);
d826e0365199cc Ian Kent          2021-06-15  1091  
d826e0365199cc Ian Kent          2021-06-15  1092  	/* The kernfs node has been deactivated */
d826e0365199cc Ian Kent          2021-06-15  1093  	if (!kernfs_active(kn))
d826e0365199cc Ian Kent          2021-06-15  1094  		goto out_bad;
d826e0365199cc Ian Kent          2021-06-15  1095  
d826e0365199cc Ian Kent          2021-06-15  1096  	/* The kernfs node has been moved? */
d826e0365199cc Ian Kent          2021-06-15  1097  	if (kernfs_dentry_node(dentry->d_parent) != kn->parent)
d826e0365199cc Ian Kent          2021-06-15  1098  		goto out_bad;
d826e0365199cc Ian Kent          2021-06-15  1099  
d826e0365199cc Ian Kent          2021-06-15  1100  	/* The kernfs node has been renamed */
d826e0365199cc Ian Kent          2021-06-15  1101  	if (strcmp(dentry->d_name.name, kn->name) != 0)
d826e0365199cc Ian Kent          2021-06-15  1102  		goto out_bad;
d826e0365199cc Ian Kent          2021-06-15  1103  
d826e0365199cc Ian Kent          2021-06-15  1104  	/* The kernfs node has been moved to a different namespace */
d826e0365199cc Ian Kent          2021-06-15  1105  	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
d826e0365199cc Ian Kent          2021-06-15  1106  	    kernfs_info(dentry->d_sb)->ns != kn->ns)
d826e0365199cc Ian Kent          2021-06-15  1107  		goto out_bad;
d826e0365199cc Ian Kent          2021-06-15  1108  
e1946294e8a0e6 Imran Khan        2022-02-03  1109  	up_read_kernfs_rwsem(kn);
d826e0365199cc Ian Kent          2021-06-15  1110  	return 1;
d826e0365199cc Ian Kent          2021-06-15  1111  out_bad:
e1946294e8a0e6 Imran Khan        2022-02-03  1112  	up_read_kernfs_rwsem(kn);
d826e0365199cc Ian Kent          2021-06-15  1113  	return 0;
d826e0365199cc Ian Kent          2021-06-15  1114  }
d826e0365199cc Ian Kent          2021-06-15  1115  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
