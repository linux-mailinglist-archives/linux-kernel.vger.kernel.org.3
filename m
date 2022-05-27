Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754285368CB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 00:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347838AbiE0W2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiE0W2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 18:28:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FC662130
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653690522; x=1685226522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=37o5tLPhehU6/zb42CwBz1nIUpHr5ux2rsBX/d2liDc=;
  b=QB4tGI4YJmXRVI/aHHclfLtCEYvwDtDlSCdve7owsKOpkynWipWQPpMG
   lJXouivTNnxD4nU2UV3D7cu4r09bVtvkdD0YDqTz6RxiY2dzTzVEUxQu/
   ikPIBonVPJj6YpcD6gFTtW2soG1vryPf/TNx9Nfs5+BzKfQV34M6oc6u8
   ma96+WlEoiTRiCCH5kNq/kdEl/pA7gYj0vrUZgpNNghz3PA18/juMcSZu
   MIjzVa+oZ5M141yKk+yQNHkkaZ0JBnt75zrgNuSgf5lS0RPU882/SBLm2
   Kpsp1JoxHruQzT0EkKRINCARX3Ez+FvfRCvjw2zBBoTfrPHNKbtgVZJnP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="255082592"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="255082592"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 15:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="705333352"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2022 15:28:34 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuiRd-0005BZ-Hn;
        Fri, 27 May 2022 22:28:33 +0000
Date:   Sat, 28 May 2022 06:28:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: fs/buffer.c:2254:5: warning: stack frame size (2128) exceeds limit
 (1024) in 'block_read_full_folio'
Message-ID: <202205280641.ummbxaI0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8291eaafed36f575f23951f3ce18407f480e9ecf
commit: 2c69e2057962b6bd76d72446453862eb59325b49 fs: Convert block_read_full_page() to block_read_full_folio()
date:   3 weeks ago
config: hexagon-randconfig-r045-20220527 (https://download.01.org/0day-ci/archive/20220528/202205280641.ummbxaI0-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2c69e2057962b6bd76d72446453862eb59325b49
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2c69e2057962b6bd76d72446453862eb59325b49
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/buffer.c:2254:5: warning: stack frame size (2128) exceeds limit (1024) in 'block_read_full_folio' [-Wframe-larger-than]
   int block_read_full_folio(struct folio *folio, get_block_t *get_block)
       ^
   1 warning generated.


vim +/block_read_full_folio +2254 fs/buffer.c

  2246	
  2247	/*
  2248	 * Generic "read_folio" function for block devices that have the normal
  2249	 * get_block functionality. This is most of the block device filesystems.
  2250	 * Reads the folio asynchronously --- the unlock_buffer() and
  2251	 * set/clear_buffer_uptodate() functions propagate buffer state into the
  2252	 * folio once IO has completed.
  2253	 */
> 2254	int block_read_full_folio(struct folio *folio, get_block_t *get_block)
  2255	{
  2256		struct inode *inode = folio->mapping->host;
  2257		sector_t iblock, lblock;
  2258		struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
  2259		unsigned int blocksize, bbits;
  2260		int nr, i;
  2261		int fully_mapped = 1;
  2262	
  2263		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
  2264	
  2265		head = create_page_buffers(&folio->page, inode, 0);
  2266		blocksize = head->b_size;
  2267		bbits = block_size_bits(blocksize);
  2268	
  2269		iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
  2270		lblock = (i_size_read(inode)+blocksize-1) >> bbits;
  2271		bh = head;
  2272		nr = 0;
  2273		i = 0;
  2274	
  2275		do {
  2276			if (buffer_uptodate(bh))
  2277				continue;
  2278	
  2279			if (!buffer_mapped(bh)) {
  2280				int err = 0;
  2281	
  2282				fully_mapped = 0;
  2283				if (iblock < lblock) {
  2284					WARN_ON(bh->b_size != blocksize);
  2285					err = get_block(inode, iblock, bh, 0);
  2286					if (err)
  2287						folio_set_error(folio);
  2288				}
  2289				if (!buffer_mapped(bh)) {
  2290					folio_zero_range(folio, i * blocksize,
  2291							blocksize);
  2292					if (!err)
  2293						set_buffer_uptodate(bh);
  2294					continue;
  2295				}
  2296				/*
  2297				 * get_block() might have updated the buffer
  2298				 * synchronously
  2299				 */
  2300				if (buffer_uptodate(bh))
  2301					continue;
  2302			}
  2303			arr[nr++] = bh;
  2304		} while (i++, iblock++, (bh = bh->b_this_page) != head);
  2305	
  2306		if (fully_mapped)
  2307			folio_set_mappedtodisk(folio);
  2308	
  2309		if (!nr) {
  2310			/*
  2311			 * All buffers are uptodate - we can set the folio uptodate
  2312			 * as well. But not if get_block() returned an error.
  2313			 */
  2314			if (!folio_test_error(folio))
  2315				folio_mark_uptodate(folio);
  2316			folio_unlock(folio);
  2317			return 0;
  2318		}
  2319	
  2320		/* Stage two: lock the buffers */
  2321		for (i = 0; i < nr; i++) {
  2322			bh = arr[i];
  2323			lock_buffer(bh);
  2324			mark_buffer_async_read(bh);
  2325		}
  2326	
  2327		/*
  2328		 * Stage 3: start the IO.  Check for uptodateness
  2329		 * inside the buffer lock in case another process reading
  2330		 * the underlying blockdev brought it uptodate (the sct fix).
  2331		 */
  2332		for (i = 0; i < nr; i++) {
  2333			bh = arr[i];
  2334			if (buffer_uptodate(bh))
  2335				end_buffer_async_read(bh, 1);
  2336			else
  2337				submit_bh(REQ_OP_READ, 0, bh);
  2338		}
  2339		return 0;
  2340	}
  2341	EXPORT_SYMBOL(block_read_full_folio);
  2342	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
