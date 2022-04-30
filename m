Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A6515A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 06:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbiD3EEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 00:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbiD3ED5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:03:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD0418B1E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651291235; x=1682827235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GhatxogM+TcyLu+Wj4Yx4dNU/T7lftu7wiWXf1UjNW8=;
  b=m940brXUBnASJnH7R3F8WkiVlDiLYZUjaRhhN+NIBsMvRLlZ7RT3QNE1
   azW+bPdKV133w18K8erHRLWsIeeq62/t+/wZHRZm1BeUAqNuDuldRuZ6D
   Uq7eFjmhUyXXSV6nv2V9nAmjWoFSnE0vUwcq8IUPdHCG4/BGW3e42jOZ6
   P6DXFvj/AcI9sjoyi+wkJZ0RNLd7nTcNRDVjN6+90NZx3uGMbhK66C5FU
   ARqASNEBwvZKyh21mXy9MKuq3SrT6b+NdArgcav6pXOv0CjKlwa8ub4kr
   A25pZ8LV36xZQMNo/XLm0pXMVRMDPotG7emUp4oQpPOGUcjxyXC9OOSt6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="327332198"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="327332198"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 21:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="652043877"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2022 21:00:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkeHY-0006r3-Jx;
        Sat, 30 Apr 2022 04:00:32 +0000
Date:   Sat, 30 Apr 2022 12:00:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 37/69] fs/buffer.c:2254:5: warning: stack
 frame size (2144) exceeds limit (1024) in 'block_read_full_folio'
Message-ID: <202204301116.pp5cVx6I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   00da6d4b7219d455e5f7e8870e4f93aaef4fc0d2
commit: 352198e3bea3edf14f83cb42ca361e9e10a5a31f [37/69] fs: Convert block_read_full_page() to block_read_full_folio()
config: hexagon-randconfig-r041-20220428 (https://download.01.org/0day-ci/archive/20220430/202204301116.pp5cVx6I-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 400775649969b9baf3bc2a510266e7912bb16ae9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 352198e3bea3edf14f83cb42ca361e9e10a5a31f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/buffer.c:2254:5: warning: stack frame size (2144) exceeds limit (1024) in 'block_read_full_folio' [-Wframe-larger-than]
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
