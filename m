Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6775911FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiHLONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbiHLONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:13:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC7018E1E
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660313627; x=1691849627;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=22YQUqkc0i/CvWkkdtsS780mUlph5ByO4MPEPu5nFgg=;
  b=Bly8+8RX0SFdNP3Aogv2ieRMPsBlzg/ttqlV4Drb9PmKAbjG5wCBlUx+
   g/HMZRUoalnug5nKr0lcSxsSK3PpADS3RE5b3J7LbnWPYHopB3iK7tUu6
   GqqaZGU6UNPDKTd862t+Sj8gS50HanO+LcFFn8ip8nb5Ly02YX3UoVtrn
   PMa7ratDcFWhR2qGNXHkv46AWVr5HLmJh33vpxE1M1bZ4K5r7n0G7EKpJ
   rtJQ3Qp/W72QtQBJf2Lj1gTxENqwSkNi+NVLMAXXO+HRebjLPg8g2pVEK
   N//KGo0JloN0LIO0mVCgFxleyLsbZwf2gm+TwJPhDoVTdsHDS2ndvIjj3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353343625"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="353343625"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 07:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="634654362"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Aug 2022 07:13:45 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMVQ0-0000bz-23;
        Fri, 12 Aug 2022 14:13:44 +0000
Date:   Fri, 12 Aug 2022 22:12:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: block/blk-map.c:254:16: warning: variable 'added' set but not used
Message-ID: <202208122209.qe4Bg8hH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ebfc85e2cd7b08f518b526173e9a33b56b3913b
commit: 480cb846c27bda4e14d98a45a9f50c250f38f266 block: convert to advancing variants of iov_iter_get_pages{,_alloc}()
date:   4 days ago
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220812/202208122209.qe4Bg8hH-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=480cb846c27bda4e14d98a45a9f50c250f38f266
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 480cb846c27bda4e14d98a45a9f50c250f38f266
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/blk-map.c:254:16: warning: variable 'added' set but not used [-Wunused-but-set-variable]
                   size_t offs, added = 0;
                                ^
   1 warning generated.


vim +/added +254 block/blk-map.c

130879f1ee0e25 Christoph Hellwig 2020-03-27  233  
7589ad6729d6a7 Christoph Hellwig 2020-08-27  234  static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
7589ad6729d6a7 Christoph Hellwig 2020-08-27  235  		gfp_t gfp_mask)
130879f1ee0e25 Christoph Hellwig 2020-03-27  236  {
7589ad6729d6a7 Christoph Hellwig 2020-08-27  237  	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
066ff571011d84 Christoph Hellwig 2022-04-06  238  	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
393bb12e00580a Christoph Hellwig 2021-03-31  239  	struct bio *bio;
130879f1ee0e25 Christoph Hellwig 2020-03-27  240  	int ret;
7589ad6729d6a7 Christoph Hellwig 2020-08-27  241  	int j;
130879f1ee0e25 Christoph Hellwig 2020-03-27  242  
130879f1ee0e25 Christoph Hellwig 2020-03-27  243  	if (!iov_iter_count(iter))
7589ad6729d6a7 Christoph Hellwig 2020-08-27  244  		return -EINVAL;
130879f1ee0e25 Christoph Hellwig 2020-03-27  245  
066ff571011d84 Christoph Hellwig 2022-04-06  246  	bio = bio_kmalloc(nr_vecs, gfp_mask);
130879f1ee0e25 Christoph Hellwig 2020-03-27  247  	if (!bio)
7589ad6729d6a7 Christoph Hellwig 2020-08-27  248  		return -ENOMEM;
066ff571011d84 Christoph Hellwig 2022-04-06  249  	bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
130879f1ee0e25 Christoph Hellwig 2020-03-27  250  
130879f1ee0e25 Christoph Hellwig 2020-03-27  251  	while (iov_iter_count(iter)) {
130879f1ee0e25 Christoph Hellwig 2020-03-27  252  		struct page **pages;
130879f1ee0e25 Christoph Hellwig 2020-03-27  253  		ssize_t bytes;
130879f1ee0e25 Christoph Hellwig 2020-03-27 @254  		size_t offs, added = 0;
130879f1ee0e25 Christoph Hellwig 2020-03-27  255  		int npages;
130879f1ee0e25 Christoph Hellwig 2020-03-27  256  
480cb846c27bda Al Viro           2022-06-09  257  		bytes = iov_iter_get_pages_alloc2(iter, &pages, LONG_MAX, &offs);
130879f1ee0e25 Christoph Hellwig 2020-03-27  258  		if (unlikely(bytes <= 0)) {
130879f1ee0e25 Christoph Hellwig 2020-03-27  259  			ret = bytes ? bytes : -EFAULT;
130879f1ee0e25 Christoph Hellwig 2020-03-27  260  			goto out_unmap;
130879f1ee0e25 Christoph Hellwig 2020-03-27  261  		}
130879f1ee0e25 Christoph Hellwig 2020-03-27  262  
130879f1ee0e25 Christoph Hellwig 2020-03-27  263  		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
130879f1ee0e25 Christoph Hellwig 2020-03-27  264  
7ab89db9790172 Michal Orzel      2022-04-23  265  		if (unlikely(offs & queue_dma_alignment(rq->q)))
130879f1ee0e25 Christoph Hellwig 2020-03-27  266  			j = 0;
7ab89db9790172 Michal Orzel      2022-04-23  267  		else {
130879f1ee0e25 Christoph Hellwig 2020-03-27  268  			for (j = 0; j < npages; j++) {
130879f1ee0e25 Christoph Hellwig 2020-03-27  269  				struct page *page = pages[j];
130879f1ee0e25 Christoph Hellwig 2020-03-27  270  				unsigned int n = PAGE_SIZE - offs;
130879f1ee0e25 Christoph Hellwig 2020-03-27  271  				bool same_page = false;
130879f1ee0e25 Christoph Hellwig 2020-03-27  272  
130879f1ee0e25 Christoph Hellwig 2020-03-27  273  				if (n > bytes)
130879f1ee0e25 Christoph Hellwig 2020-03-27  274  					n = bytes;
130879f1ee0e25 Christoph Hellwig 2020-03-27  275  
7589ad6729d6a7 Christoph Hellwig 2020-08-27  276  				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
e4581105771b35 Christoph Hellwig 2020-05-12  277  						     max_sectors, &same_page)) {
130879f1ee0e25 Christoph Hellwig 2020-03-27  278  					if (same_page)
130879f1ee0e25 Christoph Hellwig 2020-03-27  279  						put_page(page);
130879f1ee0e25 Christoph Hellwig 2020-03-27  280  					break;
130879f1ee0e25 Christoph Hellwig 2020-03-27  281  				}
130879f1ee0e25 Christoph Hellwig 2020-03-27  282  
130879f1ee0e25 Christoph Hellwig 2020-03-27  283  				added += n;
130879f1ee0e25 Christoph Hellwig 2020-03-27  284  				bytes -= n;
130879f1ee0e25 Christoph Hellwig 2020-03-27  285  				offs = 0;
130879f1ee0e25 Christoph Hellwig 2020-03-27  286  			}
130879f1ee0e25 Christoph Hellwig 2020-03-27  287  		}
130879f1ee0e25 Christoph Hellwig 2020-03-27  288  		/*
130879f1ee0e25 Christoph Hellwig 2020-03-27  289  		 * release the pages we didn't map into the bio, if any
130879f1ee0e25 Christoph Hellwig 2020-03-27  290  		 */
130879f1ee0e25 Christoph Hellwig 2020-03-27  291  		while (j < npages)
130879f1ee0e25 Christoph Hellwig 2020-03-27  292  			put_page(pages[j++]);
130879f1ee0e25 Christoph Hellwig 2020-03-27  293  		kvfree(pages);
130879f1ee0e25 Christoph Hellwig 2020-03-27  294  		/* couldn't stuff something into bio? */
480cb846c27bda Al Viro           2022-06-09  295  		if (bytes) {
480cb846c27bda Al Viro           2022-06-09  296  			iov_iter_revert(iter, bytes);
130879f1ee0e25 Christoph Hellwig 2020-03-27  297  			break;
130879f1ee0e25 Christoph Hellwig 2020-03-27  298  		}
480cb846c27bda Al Viro           2022-06-09  299  	}
130879f1ee0e25 Christoph Hellwig 2020-03-27  300  
393bb12e00580a Christoph Hellwig 2021-03-31  301  	ret = blk_rq_append_bio(rq, bio);
7589ad6729d6a7 Christoph Hellwig 2020-08-27  302  	if (ret)
393bb12e00580a Christoph Hellwig 2021-03-31  303  		goto out_unmap;
7589ad6729d6a7 Christoph Hellwig 2020-08-27  304  	return 0;
7589ad6729d6a7 Christoph Hellwig 2020-08-27  305  
130879f1ee0e25 Christoph Hellwig 2020-03-27  306   out_unmap:
130879f1ee0e25 Christoph Hellwig 2020-03-27  307  	bio_release_pages(bio, false);
066ff571011d84 Christoph Hellwig 2022-04-06  308  	bio_uninit(bio);
066ff571011d84 Christoph Hellwig 2022-04-06  309  	kfree(bio);
7589ad6729d6a7 Christoph Hellwig 2020-08-27  310  	return ret;
130879f1ee0e25 Christoph Hellwig 2020-03-27  311  }
130879f1ee0e25 Christoph Hellwig 2020-03-27  312  

:::::: The code at line 254 was first introduced by commit
:::::: 130879f1ee0e25b0391b8c78b3baac6fe41f4d38 block: move bio_map_* to blk-map.c

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
