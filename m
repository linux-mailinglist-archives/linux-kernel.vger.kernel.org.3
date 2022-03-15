Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0844D9A16
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347893AbiCOLN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiCOLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:13:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62960C2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647342765; x=1678878765;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VKFgjfudXHmL9h7/gvou1SgAx5x1ypUkfwPHc05EsB4=;
  b=NLJhseKCFc0n/0XjFBUp3rf8AGVR4viz1lOLMiWkWCwKS0r3kdAPtkQT
   vLn8C4c2WtS4xjhHy8XmlN4RAY25Cj1oLegSk/Zo+DLM0l+b+mll42BnA
   rtVUR7EsiTtg6zRgGw99E8Y1BmEHZp1mEscLn9N3W6/iwKsHHQR4xIlKJ
   5YPjC17ZNewpdyK1bPOgaUVT25QLVMO/vMG6Ox3iugmWlbR5NYoyIewSh
   PdsT1mnYfhWeZZr9Pn5j9Xyow5Yot+b+s2RCjeD635XRFT/EXfH6rvbki
   UBtiSCvjznwC7QHFGphorUbbJniL08KXtO7lNIkUs7KkX2VUwH8fXxj77
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238439269"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="238439269"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 04:12:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="634549010"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Mar 2022 04:12:27 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU56I-000AtF-QY; Tue, 15 Mar 2022 11:12:26 +0000
Date:   Tue, 15 Mar 2022 19:11:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 174/179] fs/nilfs2/inode.c:227:13:
 warning: variable 'nr_dirty' is used uninitialized whenever 'if' condition
 is false
Message-ID: <202203151941.WVgUZDhE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   af564d7369d44fbbe697a5f631fe3bba5ebecd59
commit: 248cfe55743b4293f9fa06384e35581121d60ee1 [174/179] nilfs: Convert nilfs_set_page_dirty() to nilfs_dirty_folio()
config: i386-randconfig-a012-20220314 (https://download.01.org/0day-ci/archive/20220315/202203151941.WVgUZDhE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 248cfe55743b4293f9fa06384e35581121d60ee1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/nilfs2/ mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/nilfs2/inode.c:227:13: warning: variable 'nr_dirty' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           } else if (ret) {
                      ^~~
   fs/nilfs2/inode.c:232:6: note: uninitialized use occurs here
           if (nr_dirty)
               ^~~~~~~~
   fs/nilfs2/inode.c:227:9: note: remove the 'if' if its condition is always true
           } else if (ret) {
                  ^~~~~~~~~
   fs/nilfs2/inode.c:207:23: note: initialize the variable 'nr_dirty' to silence this warning
           unsigned int nr_dirty;
                                ^
                                 = 0
   1 warning generated.


vim +227 fs/nilfs2/inode.c

05fe58fdc10df9e Ryusuke Konishi         2009-04-06  201  
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  202) static bool nilfs_dirty_folio(struct address_space *mapping,
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  203) 		struct folio *folio)
05fe58fdc10df9e Ryusuke Konishi         2009-04-06  204  {
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  205) 	struct inode *inode = mapping->host;
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  206) 	struct buffer_head *head;
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  207) 	unsigned int nr_dirty;
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  208) 	bool ret = filemap_dirty_folio(mapping, folio);
05fe58fdc10df9e Ryusuke Konishi         2009-04-06  209  
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  210  	/*
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  211) 	 * The page may not be locked, eg if called from try_to_unmap_one()
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  212  	 */
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  213) 	spin_lock(&mapping->private_lock);
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  214) 	head = folio_buffers(folio);
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  215) 	if (head) {
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  216) 		struct buffer_head *bh = head;
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  217) 
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  218) 		nr_dirty = 0;
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  219  		do {
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  220  			/* Do not mark hole blocks dirty */
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  221  			if (buffer_dirty(bh) || !buffer_mapped(bh))
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  222  				continue;
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  223  
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  224  			set_buffer_dirty(bh);
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  225  			nr_dirty++;
136e8770cd5d1fe Ryusuke Konishi         2013-05-24  226  		} while (bh = bh->b_this_page, bh != head);
56d7acc792c0d98 Andreas Rohner          2014-09-25 @227  	} else if (ret) {
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  228) 		nr_dirty = 1 << (PAGE_SHIFT - inode->i_blkbits);
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  229) 	}
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  230) 	spin_unlock(&mapping->private_lock);
56d7acc792c0d98 Andreas Rohner          2014-09-25  231  
248cfe55743b429 Matthew Wilcox (Oracle  2022-02-09  232) 	if (nr_dirty)
bcbc8c648d6cc88 Ryusuke Konishi         2010-12-27  233  		nilfs_set_file_dirty(inode, nr_dirty);
05fe58fdc10df9e Ryusuke Konishi         2009-04-06  234  	return ret;
05fe58fdc10df9e Ryusuke Konishi         2009-04-06  235  }
05fe58fdc10df9e Ryusuke Konishi         2009-04-06  236  

:::::: The code at line 227 was first introduced by commit
:::::: 56d7acc792c0d98f38f22058671ee715ff197023 nilfs2: fix data loss with mmap()

:::::: TO: Andreas Rohner <andreas.rohner@gmx.net>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
