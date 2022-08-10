Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B6158E93A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiHJJCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbiHJJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:02:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE25485F9B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660122167; x=1691658167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tSMiKFJPplfUxPd7X/bi0WDjUs+4liE/nO4gbPAmfiw=;
  b=e/rQ7ANDWzUYrX35sm8Gg65u0J7++I3hyklzbJ5esQppjqbijIaOocVq
   y/BKCB73p7RmGFWUcuUs8jIOJlptXn+h3MBf3+Ywp3XMLwg9cVXn0uMdd
   7dDe/5QUkw3wQUwr3bUxH/W9ATVh25aE71FZY0zsHb0mqwiMhOuRaygxU
   1ZmDywVwqvOW2y+pmko8oGqbw3DkdMEzNo9f/P+6aRgFbm0Y06HNlr/wo
   iB87GUKiW1jjrz/Y7E51+Adj3EhSXKNIjuEB7AU19vPruqpFKYR4NHtRY
   S0FIogwb/GX5hEMS/0fFQqaHGsRSWr73/CI3p9CtG7X13oVhRMruUZtLq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="292287947"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="292287947"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 02:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="731430131"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Aug 2022 02:02:44 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLhbw-00006N-10;
        Wed, 10 Aug 2022 09:02:44 +0000
Date:   Wed, 10 Aug 2022 17:02:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kassey Li <quic_yingangl@quicinc.com>, akpm@linux-foundation.org,
        vbabka@kernel.org
Cc:     kbuild-all@lists.01.org, Kassey Li <quic_yingangl@quicinc.com>,
        minchan@kernel.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6] mm/page_owner.c: add llseek for page_owner
Message-ID: <202208101628.o6qUzx50-lkp@intel.com>
References: <20220810013218.27416-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810013218.27416-1-quic_yingangl@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kassey,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.19]
[also build test ERROR on next-20220810]
[cannot apply to akpm-mm/mm-everything linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220810-093417
base:    3d7cb6b04c3f3115719235cc6866b10326de34cd
config: parisc-buildonly-randconfig-r004-20220810 (https://download.01.org/0day-ci/archive/20220810/202208101628.o6qUzx50-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d2decd69a8d5756c1706092c805a4c8af14df471
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kassey-Li/mm-page_owner-c-add-llseek-for-page_owner/20220810-093417
        git checkout d2decd69a8d5756c1706092c805a4c8af14df471
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/page_owner.c:16:
>> mm/../fs/proc/internal.h:51:9: error: unknown type name 'proc_write_t'
      51 |         proc_write_t write;
         |         ^~~~~~~~~~~~


vim +/proc_write_t +51 mm/../fs/proc/internal.h

^1da177e4c3f41 Linus Torvalds    2005-04-16  19  
59d8053f1e1690 David Howells     2013-04-11  20  /*
59d8053f1e1690 David Howells     2013-04-11  21   * This is not completely implemented yet. The idea is to
59d8053f1e1690 David Howells     2013-04-11  22   * create an in-memory tree (like the actual /proc filesystem
59d8053f1e1690 David Howells     2013-04-11  23   * tree) of these proc_dir_entries, so that we can dynamically
59d8053f1e1690 David Howells     2013-04-11  24   * add new files to /proc.
59d8053f1e1690 David Howells     2013-04-11  25   *
710585d4922fd3 Nicolas Dichtel   2014-12-10  26   * parent/subdir are used for the directory structure (every /proc file has a
710585d4922fd3 Nicolas Dichtel   2014-12-10  27   * parent, but "subdir" is empty for all non-directory entries).
710585d4922fd3 Nicolas Dichtel   2014-12-10  28   * subdir_node is used to build the rb tree "subdir" of the parent.
59d8053f1e1690 David Howells     2013-04-11  29   */
59d8053f1e1690 David Howells     2013-04-11  30  struct proc_dir_entry {
163cf548db8887 Alexey Dobriyan   2018-02-06  31  	/*
163cf548db8887 Alexey Dobriyan   2018-02-06  32  	 * number of callers into module in progress;
163cf548db8887 Alexey Dobriyan   2018-02-06  33  	 * negative -> it's going away RSN
163cf548db8887 Alexey Dobriyan   2018-02-06  34  	 */
163cf548db8887 Alexey Dobriyan   2018-02-06  35  	atomic_t in_use;
9cdd83e3100651 Alexey Dobriyan   2018-04-10  36  	refcount_t refcnt;
163cf548db8887 Alexey Dobriyan   2018-02-06  37  	struct list_head pde_openers;	/* who did ->open, but not ->release */
53f63345d893df Alexey Dobriyan   2018-02-06  38  	/* protects ->pde_openers and all struct pde_opener instances */
53f63345d893df Alexey Dobriyan   2018-02-06  39  	spinlock_t pde_unload_lock;
163cf548db8887 Alexey Dobriyan   2018-02-06  40  	struct completion *pde_unload_completion;
163cf548db8887 Alexey Dobriyan   2018-02-06  41  	const struct inode_operations *proc_iops;
d56c0d45f0e27f Alexey Dobriyan   2020-02-03  42  	union {
d56c0d45f0e27f Alexey Dobriyan   2020-02-03  43  		const struct proc_ops *proc_ops;
d56c0d45f0e27f Alexey Dobriyan   2020-02-03  44  		const struct file_operations *proc_dir_ops;
d56c0d45f0e27f Alexey Dobriyan   2020-02-03  45  	};
1fde6f21d90f8b Alexey Dobriyan   2019-02-01  46  	const struct dentry_operations *proc_dops;
3f3942aca6da35 Christoph Hellwig 2018-05-15  47  	union {
fddda2b7b52118 Christoph Hellwig 2018-04-13  48  		const struct seq_operations *seq_ops;
3f3942aca6da35 Christoph Hellwig 2018-05-15  49  		int (*single_show)(struct seq_file *, void *);
3f3942aca6da35 Christoph Hellwig 2018-05-15  50  	};
564def71765caf David Howells     2018-05-18 @51  	proc_write_t write;
163cf548db8887 Alexey Dobriyan   2018-02-06  52  	void *data;
44414d82cfe0f6 Christoph Hellwig 2018-04-24  53  	unsigned int state_size;
59d8053f1e1690 David Howells     2013-04-11  54  	unsigned int low_ino;
59d8053f1e1690 David Howells     2013-04-11  55  	nlink_t nlink;
59d8053f1e1690 David Howells     2013-04-11  56  	kuid_t uid;
59d8053f1e1690 David Howells     2013-04-11  57  	kgid_t gid;
59d8053f1e1690 David Howells     2013-04-11  58  	loff_t size;
710585d4922fd3 Nicolas Dichtel   2014-12-10  59  	struct proc_dir_entry *parent;
4f1134370a29a5 Alexey Dobriyan   2018-04-10  60  	struct rb_root subdir;
710585d4922fd3 Nicolas Dichtel   2014-12-10  61  	struct rb_node subdir_node;
b4884f23331ae3 Alexey Dobriyan   2018-04-10  62  	char *name;
163cf548db8887 Alexey Dobriyan   2018-02-06  63  	umode_t mode;
d919b33dafb3e2 Alexey Dobriyan   2020-04-06  64  	u8 flags;
59d8053f1e1690 David Howells     2013-04-11  65  	u8 namelen;
24074a35c5c975 David Howells     2018-06-13  66  	char inline_name[];
3859a271a003ab Kees Cook         2016-10-28  67  } __randomize_layout;
^1da177e4c3f41 Linus Torvalds    2005-04-16  68  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
