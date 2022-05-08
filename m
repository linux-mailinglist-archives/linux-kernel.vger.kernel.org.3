Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5851F261
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiEIBbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiEHXse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 19:48:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7AB877
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652053481; x=1683589481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jB5h3gqPGl24VQNQexZQqqaG4C3E5vzrhzQgFm/ApcU=;
  b=LqMLF3SvmjxFEfwJl3B84wpRkdwDtQ8D/l1nd3/PWACTkILH+NJD5N2t
   NeRr0fag0TXynKqggVO/j6NomXdrgZhinb0CIlZRxoEh2XKzzo3tcOGgP
   Uy0fiA4SVWnjfUY8DMgFbzBusGQUubYIXuVTHdJXcQk5wpRI7knHCNPvG
   l9GZNPQ8ThesZXkYQQef3yrVmLgPPzb2xF5jOHzJK7x/ic/UXy9raahtW
   RH9VuFi6heYzEnE/oKB8i+CHlzI/cUDodpgFS2CItPFm3UwMGbKDZYcCd
   THd0tqCs6kJ00YJmwcnqYuG/ZKnsxSK2efmEIyvT/v0SUsV2sSkoi9ym2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="250931216"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="250931216"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 16:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="518933826"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 May 2022 16:44:39 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnqZq-000Fx8-M7;
        Sun, 08 May 2022 23:44:38 +0000
Date:   Mon, 9 May 2022 07:44:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <202205090729.mU23mv8h-lkp@intel.com>
References: <20220508200755.24586-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508200755.24586-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Fabio,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18-rc6 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/fs-ufs-Replace-kmap-with-kmap_local_page/20220509-040920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e3de3a1cda5fdc3ac42cb0d45321fb254500595f
config: arm-randconfig-s032-20220508 (https://download.01.org/0day-ci/archive/20220509/202205090729.mU23mv8h-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e73d9919e2725b216318d5d02b8a184876ab3b11
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Fabio-M-De-Francesco/fs-ufs-Replace-kmap-with-kmap_local_page/20220509-040920
        git checkout e73d9919e2725b216318d5d02b8a184876ab3b11
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/ufs/namei.c: note: in included file:
>> fs/ufs/ufs.h:114:32: sparse: sparse: marked inline, but without a definition
>> fs/ufs/ufs.h:114:32: sparse: sparse: marked inline, but without a definition
>> fs/ufs/ufs.h:114:32: sparse: sparse: marked inline, but without a definition

vim +114 fs/ufs/ufs.h

    99	
   100	/* dir.c */
   101	extern const struct inode_operations ufs_dir_inode_operations;
   102	extern int ufs_add_link (struct dentry *, struct inode *);
   103	extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
   104	extern int ufs_make_empty(struct inode *, struct inode *);
   105	extern struct ufs_dir_entry *ufs_find_entry(struct inode *, const struct qstr *,
   106						    struct page **, void **);
   107	extern int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct page *,
   108				    char *);
   109	extern int ufs_empty_dir (struct inode *);
   110	extern struct ufs_dir_entry *ufs_dotdot(struct inode *, struct page **, void **);
   111	extern void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
   112				 struct page *page, void *page_addr,
   113				 struct inode *inode, bool update_times);
 > 114	extern inline void ufs_put_page(struct page *page, void *page_addr);
   115	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
