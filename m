Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1D5977FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbiHQUen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbiHQUei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:34:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AC6A98D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660768477; x=1692304477;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=NZBwv6qSD3S9lLwAdPwsfuroic2uiLUrwUjxG30xUS0=;
  b=BwKKd9q+XullHi9v0zymcb2QkZ57ammuhJtbnK6vOJpQRdODlDP9moRp
   KjcRUrXjbi4cgZXo7XI3ANhXuzss/cWO0tYRhZIXURkWINjpzC9zsP0og
   fQARFf/qCacCaQbAyx8tUGbMhbARb+Xpeep62XquUd8BBCWTpIZ5peQ/e
   P4sXQ2TlyTSoTwSreAcqt1ghyr742gGxbcq7qEqLfFoE+3LzDXqsJPUTq
   caxuPST0zz9NKfCtFUTzaWwcXmA7zgIu+Ke8V2tgfRG3KdcnJW0SwlFyC
   NVLYyKbkcL1YILpf6jYlLu/D7vF35Bb1wig/V841XOQt3no0onRPUbVuD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="291350793"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="291350793"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 13:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="675784000"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2022 13:34:34 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOPkI-0001Jo-0C;
        Wed, 17 Aug 2022 20:34:34 +0000
Date:   Thu, 18 Aug 2022 04:34:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: security/selinux/selinuxfs.c:2093:6: warning: variable 'fsi' is used
 uninitialized whenever 'if' condition is true
Message-ID: <202208180442.9ncBZM8u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220817-225425/Dongliang-Mu/drivers-binderfs-fix-memory-leak-in-binderfs_fill_super/20220812-212646
head:   592368c18a257eccb1c2de5eca89421a0a333a34
commit: 592368c18a257eccb1c2de5eca89421a0a333a34 binderfs: rework superblock destruction
date:   6 hours ago
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220818/202208180442.9ncBZM8u-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/592368c18a257eccb1c2de5eca89421a0a333a34
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220817-225425/Dongliang-Mu/drivers-binderfs-fix-memory-leak-in-binderfs_fill_super/20220812-212646
        git checkout 592368c18a257eccb1c2de5eca89421a0a333a34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash security/selinux/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> security/selinux/selinuxfs.c:2093:6: warning: variable 'fsi' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (ret)
               ^~~
   security/selinux/selinuxfs.c:2181:23: note: uninitialized use occurs here
           selinux_fs_info_free(fsi);
                                ^~~
   security/selinux/selinuxfs.c:2093:2: note: remove the 'if' if its condition is always false
           if (ret)
           ^~~~~~~~
   security/selinux/selinuxfs.c:2089:6: warning: variable 'fsi' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (ret)
               ^~~
   security/selinux/selinuxfs.c:2181:23: note: uninitialized use occurs here
           selinux_fs_info_free(fsi);
                                ^~~
   security/selinux/selinuxfs.c:2089:2: note: remove the 'if' if its condition is always false
           if (ret)
           ^~~~~~~~
   security/selinux/selinuxfs.c:2059:29: note: initialize the variable 'fsi' to silence this warning
           struct selinux_fs_info *fsi;
                                      ^
                                       = NULL
   2 warnings generated.


vim +2093 security/selinux/selinuxfs.c

0619f0f5e36f12e Stephen Smalley     2018-03-20  2056  
920f50b2a44bbc5 David Howells       2019-03-25  2057  static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
^1da177e4c3f415 Linus Torvalds      2005-04-16  2058  {
0619f0f5e36f12e Stephen Smalley     2018-03-20  2059  	struct selinux_fs_info *fsi;
^1da177e4c3f415 Linus Torvalds      2005-04-16  2060  	int ret;
^1da177e4c3f415 Linus Torvalds      2005-04-16  2061  	struct dentry *dentry;
a1c2aa1e86a25e7 Al Viro             2012-03-18  2062  	struct inode *inode;
^1da177e4c3f415 Linus Torvalds      2005-04-16  2063  	struct inode_security_struct *isec;
^1da177e4c3f415 Linus Torvalds      2005-04-16  2064  
cda37124f4e95ad Eric Biggers        2017-03-25  2065  	static const struct tree_descr selinux_files[] = {
^1da177e4c3f415 Linus Torvalds      2005-04-16  2066  		[SEL_LOAD] = {"load", &sel_load_ops, S_IRUSR|S_IWUSR},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2067  		[SEL_ENFORCE] = {"enforce", &sel_enforce_ops, S_IRUGO|S_IWUSR},
ce9982d048bb498 Stephen Smalley     2005-11-08  2068  		[SEL_CONTEXT] = {"context", &transaction_ops, S_IRUGO|S_IWUGO},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2069  		[SEL_ACCESS] = {"access", &transaction_ops, S_IRUGO|S_IWUGO},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2070  		[SEL_CREATE] = {"create", &transaction_ops, S_IRUGO|S_IWUGO},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2071  		[SEL_RELABEL] = {"relabel", &transaction_ops, S_IRUGO|S_IWUGO},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2072  		[SEL_USER] = {"user", &transaction_ops, S_IRUGO|S_IWUGO},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2073  		[SEL_POLICYVERS] = {"policyvers", &sel_policyvers_ops, S_IRUGO},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2074  		[SEL_COMMIT_BOOLS] = {"commit_pending_bools", &sel_commit_bools_ops, S_IWUSR},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2075  		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2076  		[SEL_DISABLE] = {"disable", &sel_disable_ops, S_IWUSR},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2077  		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2078  		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
3f12070e27b4a21 Eric Paris          2007-09-21  2079  		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
3f12070e27b4a21 Eric Paris          2007-09-21  2080  		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
119041672592d18 KaiGai Kohei        2010-09-14  2081  		[SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
72e8c8593f8fdb9 Eric Paris          2012-02-16  2082  		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
f9df6458218f4fe Andrew Perepechko   2015-12-24  2083  		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
f9df6458218f4fe Andrew Perepechko   2015-12-24  2084  					S_IWUGO},
^1da177e4c3f415 Linus Torvalds      2005-04-16  2085  		/* last one */ {""}
^1da177e4c3f415 Linus Torvalds      2005-04-16  2086  	};
0619f0f5e36f12e Stephen Smalley     2018-03-20  2087  
0619f0f5e36f12e Stephen Smalley     2018-03-20  2088  	ret = selinux_fs_info_create(sb);
0619f0f5e36f12e Stephen Smalley     2018-03-20  2089  	if (ret)
0619f0f5e36f12e Stephen Smalley     2018-03-20  2090  		goto err;
0619f0f5e36f12e Stephen Smalley     2018-03-20  2091  
^1da177e4c3f415 Linus Torvalds      2005-04-16  2092  	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
^1da177e4c3f415 Linus Torvalds      2005-04-16 @2093  	if (ret)
161ce45a8a34ba8 James Morris        2006-03-22  2094  		goto err;
^1da177e4c3f415 Linus Torvalds      2005-04-16  2095  
0619f0f5e36f12e Stephen Smalley     2018-03-20  2096  	fsi = sb->s_fs_info;
0619f0f5e36f12e Stephen Smalley     2018-03-20  2097  	fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
0619f0f5e36f12e Stephen Smalley     2018-03-20  2098  	if (IS_ERR(fsi->bool_dir)) {
0619f0f5e36f12e Stephen Smalley     2018-03-20  2099  		ret = PTR_ERR(fsi->bool_dir);
0619f0f5e36f12e Stephen Smalley     2018-03-20  2100  		fsi->bool_dir = NULL;
161ce45a8a34ba8 James Morris        2006-03-22  2101  		goto err;
a1c2aa1e86a25e7 Al Viro             2012-03-18  2102  	}
^1da177e4c3f415 Linus Torvalds      2005-04-16  2103  
161ce45a8a34ba8 James Morris        2006-03-22  2104  	ret = -ENOMEM;
b77a493b1dc8010 Eric Paris          2010-11-23  2105  	dentry = d_alloc_name(sb->s_root, NULL_FILE_NAME);
b77a493b1dc8010 Eric Paris          2010-11-23  2106  	if (!dentry)
161ce45a8a34ba8 James Morris        2006-03-22  2107  		goto err;
^1da177e4c3f415 Linus Torvalds      2005-04-16  2108  
161ce45a8a34ba8 James Morris        2006-03-22  2109  	ret = -ENOMEM;
b77a493b1dc8010 Eric Paris          2010-11-23  2110  	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
7e4237faa7213c1 nixiaoming          2018-08-05  2111  	if (!inode) {
7e4237faa7213c1 nixiaoming          2018-08-05  2112  		dput(dentry);
161ce45a8a34ba8 James Morris        2006-03-22  2113  		goto err;
7e4237faa7213c1 nixiaoming          2018-08-05  2114  	}
b77a493b1dc8010 Eric Paris          2010-11-23  2115  
0619f0f5e36f12e Stephen Smalley     2018-03-20  2116  	inode->i_ino = ++fsi->last_ino;
80788c229116b28 Casey Schaufler     2018-09-21  2117  	isec = selinux_inode(inode);
^1da177e4c3f415 Linus Torvalds      2005-04-16  2118  	isec->sid = SECINITSID_DEVNULL;
^1da177e4c3f415 Linus Torvalds      2005-04-16  2119  	isec->sclass = SECCLASS_CHR_FILE;
420591128cb2062 Andreas Gruenbacher 2016-11-10  2120  	isec->initialized = LABEL_INITIALIZED;
^1da177e4c3f415 Linus Torvalds      2005-04-16  2121  
^1da177e4c3f415 Linus Torvalds      2005-04-16  2122  	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, MKDEV(MEM_MAJOR, 3));
^1da177e4c3f415 Linus Torvalds      2005-04-16  2123  	d_add(dentry, inode);
^1da177e4c3f415 Linus Torvalds      2005-04-16  2124  
0619f0f5e36f12e Stephen Smalley     2018-03-20  2125  	dentry = sel_make_dir(sb->s_root, "avc", &fsi->last_ino);
a1c2aa1e86a25e7 Al Viro             2012-03-18  2126  	if (IS_ERR(dentry)) {
a1c2aa1e86a25e7 Al Viro             2012-03-18  2127  		ret = PTR_ERR(dentry);
161ce45a8a34ba8 James Morris        2006-03-22  2128  		goto err;
a1c2aa1e86a25e7 Al Viro             2012-03-18  2129  	}
^1da177e4c3f415 Linus Torvalds      2005-04-16  2130  
^1da177e4c3f415 Linus Torvalds      2005-04-16  2131  	ret = sel_make_avc_files(dentry);
bcb62828e3e8c81 Christian Göttsche  2022-01-25  2132  	if (ret)
bcb62828e3e8c81 Christian Göttsche  2022-01-25  2133  		goto err;
66f8e2f03c02e81 Jeff Vander Stoep   2019-11-22  2134  
66f8e2f03c02e81 Jeff Vander Stoep   2019-11-22  2135  	dentry = sel_make_dir(sb->s_root, "ss", &fsi->last_ino);
66f8e2f03c02e81 Jeff Vander Stoep   2019-11-22  2136  	if (IS_ERR(dentry)) {
66f8e2f03c02e81 Jeff Vander Stoep   2019-11-22  2137  		ret = PTR_ERR(dentry);
66f8e2f03c02e81 Jeff Vander Stoep   2019-11-22  2138  		goto err;
66f8e2f03c02e81 Jeff Vander Stoep   2019-11-22  2139  	}
66f8e2f03c02e81 Jeff Vander Stoep   2019-11-22  2140  
66f8e2f03c02e81 Jeff Vander Stoep   2019-11-22  2141  	ret = sel_make_ss_files(dentry);
^1da177e4c3f415 Linus Torvalds      2005-04-16  2142  	if (ret)
161ce45a8a34ba8 James Morris        2006-03-22  2143  		goto err;
f0ee2e467ffa68c James Carter        2007-04-04  2144  
0619f0f5e36f12e Stephen Smalley     2018-03-20  2145  	dentry = sel_make_dir(sb->s_root, "initial_contexts", &fsi->last_ino);
a1c2aa1e86a25e7 Al Viro             2012-03-18  2146  	if (IS_ERR(dentry)) {
a1c2aa1e86a25e7 Al Viro             2012-03-18  2147  		ret = PTR_ERR(dentry);
f0ee2e467ffa68c James Carter        2007-04-04  2148  		goto err;
a1c2aa1e86a25e7 Al Viro             2012-03-18  2149  	}
f0ee2e467ffa68c James Carter        2007-04-04  2150  
f0ee2e467ffa68c James Carter        2007-04-04  2151  	ret = sel_make_initcon_files(dentry);
f0ee2e467ffa68c James Carter        2007-04-04  2152  	if (ret)
f0ee2e467ffa68c James Carter        2007-04-04  2153  		goto err;
f0ee2e467ffa68c James Carter        2007-04-04  2154  
613ba18798ac3cf Daniel Burgener     2020-08-19  2155  	fsi->class_dir = sel_make_dir(sb->s_root, CLASS_DIR_NAME, &fsi->last_ino);
0619f0f5e36f12e Stephen Smalley     2018-03-20  2156  	if (IS_ERR(fsi->class_dir)) {
0619f0f5e36f12e Stephen Smalley     2018-03-20  2157  		ret = PTR_ERR(fsi->class_dir);
0619f0f5e36f12e Stephen Smalley     2018-03-20  2158  		fsi->class_dir = NULL;
3bb56b25dbe0a4b Paul Moore          2008-01-29  2159  		goto err;
a1c2aa1e86a25e7 Al Viro             2012-03-18  2160  	}
3bb56b25dbe0a4b Paul Moore          2008-01-29  2161  
613ba18798ac3cf Daniel Burgener     2020-08-19  2162  	fsi->policycap_dir = sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
0619f0f5e36f12e Stephen Smalley     2018-03-20  2163  					  &fsi->last_ino);
0619f0f5e36f12e Stephen Smalley     2018-03-20  2164  	if (IS_ERR(fsi->policycap_dir)) {
0619f0f5e36f12e Stephen Smalley     2018-03-20  2165  		ret = PTR_ERR(fsi->policycap_dir);
0619f0f5e36f12e Stephen Smalley     2018-03-20  2166  		fsi->policycap_dir = NULL;
3bb56b25dbe0a4b Paul Moore          2008-01-29  2167  		goto err;
a1c2aa1e86a25e7 Al Viro             2012-03-18  2168  	}
0619f0f5e36f12e Stephen Smalley     2018-03-20  2169  
02a52c5c8c3b8cb Stephen Smalley     2020-08-07  2170  	ret = sel_make_policycap(fsi);
02a52c5c8c3b8cb Stephen Smalley     2020-08-07  2171  	if (ret) {
02a52c5c8c3b8cb Stephen Smalley     2020-08-07  2172  		pr_err("SELinux: failed to load policy capabilities\n");
0619f0f5e36f12e Stephen Smalley     2018-03-20  2173  		goto err;
02a52c5c8c3b8cb Stephen Smalley     2020-08-07  2174  	}
02a52c5c8c3b8cb Stephen Smalley     2020-08-07  2175  
b77a493b1dc8010 Eric Paris          2010-11-23  2176  	return 0;
161ce45a8a34ba8 James Morris        2006-03-22  2177  err:
f8b69a5f00ee0a8 peter enderborg     2018-06-12  2178  	pr_err("SELinux: %s:  failed while creating inodes\n",
744ba35e455b0d5 Eric Paris          2008-04-17  2179  		__func__);
0619f0f5e36f12e Stephen Smalley     2018-03-20  2180  
592368c18a257ec Christian Brauner   2022-08-17  2181  	selinux_fs_info_free(fsi);
0619f0f5e36f12e Stephen Smalley     2018-03-20  2182  
b77a493b1dc8010 Eric Paris          2010-11-23  2183  	return ret;
^1da177e4c3f415 Linus Torvalds      2005-04-16  2184  }
^1da177e4c3f415 Linus Torvalds      2005-04-16  2185  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
