Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E1F51AEC3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377906AbiEDUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377903AbiEDUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:14:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94214E3AA
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651695062; x=1683231062;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zyaGWU6dc4sJyiCu9lx0sTzHkueZWVwMWhYROsaMyQU=;
  b=DJM8CmcFPFduml2wOEP+RTtXE9hgImZuCa6GQqSJ07ksywn7gakD8h9g
   NLChyurrjEC+fQcf6qMSUJ4ENLbQlhT/IkFOIZuILCqlBlUExHXZO7c9t
   i7w/qVmRzRjbvCnGXLJp2xK4vMkxG00Hn9wEt6LdGHyK5JeSAB6evBWl+
   bZD8egWLkeOMGf9fvH6K3vpb8yKg/FHkDrLGS82aO9P8KZCOnxSg/WsiQ
   MdwcmD/goPjpbdgtxKf3RCKVfwYTJnC6gGgtP/RqDDGr7bT/Ei7mfY1VU
   EoEH0jl9uDKjKfMl4c//q7DIIgmS6ax9GabqJR2OyjE1l2xPSM3pnr027
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="248422459"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="248422459"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 13:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="664631589"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 May 2022 13:11:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmLKu-000BkZ-Al;
        Wed, 04 May 2022 20:11:00 +0000
Date:   Thu, 5 May 2022 04:10:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jchao Sun <sunjunchao2870@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: fs/fs-writeback.c:2397:6: warning: variable 'wb' is used
 uninitialized whenever 'if' condition is false
Message-ID: <202205050403.jB6rulkz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220505-023756/Jchao-Sun/Add-assert-for-inode-i_io_list-in-inode_io_list_move_locked/20220503-180501
head:   af0b042e914fbaf7a7ac9d463c91b8566461c39f
commit: af0b042e914fbaf7a7ac9d463c91b8566461c39f writeback: Fix inode->i_io_list not be protected by inode->i_lock error
date:   87 minutes ago
config: x86_64-randconfig-a011-20220502 (https://download.01.org/0day-ci/archive/20220505/202205050403.jB6rulkz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/af0b042e914fbaf7a7ac9d463c91b8566461c39f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220505-023756/Jchao-Sun/Add-assert-for-inode-i_io_list-in-inode_io_list_move_locked/20220503-180501
        git checkout af0b042e914fbaf7a7ac9d463c91b8566461c39f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/fs-writeback.c:2397:6: warning: variable 'wb' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if ((inode->i_state & flags) != flags) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fs-writeback.c:2467:15: note: uninitialized use occurs here
           spin_unlock(&wb->list_lock);
                        ^~
   fs/fs-writeback.c:2397:2: note: remove the 'if' if its condition is always true
           if ((inode->i_state & flags) != flags) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fs-writeback.c:2355:26: note: initialize the variable 'wb' to silence this warning
           struct bdi_writeback *wb;
                                   ^
                                    = NULL
   1 warning generated.


vim +2397 fs/fs-writeback.c

1efff914afac8a Theodore Ts'o         2015-03-17  2323  
03ba3782e8dcc5 Jens Axboe            2009-09-09  2324  /**
35d14f278e530e Eric Biggers          2021-01-12  2325   * __mark_inode_dirty -	internal function to mark an inode dirty
0117d4272b1acd Mauro Carvalho Chehab 2017-05-12  2326   *
03ba3782e8dcc5 Jens Axboe            2009-09-09  2327   * @inode: inode to mark
35d14f278e530e Eric Biggers          2021-01-12  2328   * @flags: what kind of dirty, e.g. I_DIRTY_SYNC.  This can be a combination of
35d14f278e530e Eric Biggers          2021-01-12  2329   *	   multiple I_DIRTY_* flags, except that I_DIRTY_TIME can't be combined
35d14f278e530e Eric Biggers          2021-01-12  2330   *	   with I_DIRTY_PAGES.
0117d4272b1acd Mauro Carvalho Chehab 2017-05-12  2331   *
35d14f278e530e Eric Biggers          2021-01-12  2332   * Mark an inode as dirty.  We notify the filesystem, then update the inode's
35d14f278e530e Eric Biggers          2021-01-12  2333   * dirty flags.  Then, if needed we add the inode to the appropriate dirty list.
03ba3782e8dcc5 Jens Axboe            2009-09-09  2334   *
35d14f278e530e Eric Biggers          2021-01-12  2335   * Most callers should use mark_inode_dirty() or mark_inode_dirty_sync()
35d14f278e530e Eric Biggers          2021-01-12  2336   * instead of calling this directly.
03ba3782e8dcc5 Jens Axboe            2009-09-09  2337   *
35d14f278e530e Eric Biggers          2021-01-12  2338   * CAREFUL!  We only add the inode to the dirty list if it is hashed or if it
35d14f278e530e Eric Biggers          2021-01-12  2339   * refers to a blockdev.  Unhashed inodes will never be added to the dirty list
35d14f278e530e Eric Biggers          2021-01-12  2340   * even if they are later hashed, as they will have been marked dirty already.
03ba3782e8dcc5 Jens Axboe            2009-09-09  2341   *
35d14f278e530e Eric Biggers          2021-01-12  2342   * In short, ensure you hash any inodes _before_ you start marking them dirty.
03ba3782e8dcc5 Jens Axboe            2009-09-09  2343   *
03ba3782e8dcc5 Jens Axboe            2009-09-09  2344   * Note that for blockdevs, inode->dirtied_when represents the dirtying time of
03ba3782e8dcc5 Jens Axboe            2009-09-09  2345   * the block-special inode (/dev/hda1) itself.  And the ->dirtied_when field of
03ba3782e8dcc5 Jens Axboe            2009-09-09  2346   * the kernel-internal blockdev inode represents the dirtying time of the
03ba3782e8dcc5 Jens Axboe            2009-09-09  2347   * blockdev's pages.  This is why for I_DIRTY_PAGES we always use
03ba3782e8dcc5 Jens Axboe            2009-09-09  2348   * page->mapping->host, so the page-dirtying time is recorded in the internal
03ba3782e8dcc5 Jens Axboe            2009-09-09  2349   * blockdev inode.
03ba3782e8dcc5 Jens Axboe            2009-09-09  2350   */
03ba3782e8dcc5 Jens Axboe            2009-09-09  2351  void __mark_inode_dirty(struct inode *inode, int flags)
03ba3782e8dcc5 Jens Axboe            2009-09-09  2352  {
03ba3782e8dcc5 Jens Axboe            2009-09-09  2353  	struct super_block *sb = inode->i_sb;
35d14f278e530e Eric Biggers          2021-01-12  2354  	int dirtytime = 0;
af0b042e914fba Jchao Sun             2022-05-04  2355  	struct bdi_writeback *wb;
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2356  
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2357  	trace_writeback_mark_inode_dirty(inode, flags);
03ba3782e8dcc5 Jens Axboe            2009-09-09  2358  
35d14f278e530e Eric Biggers          2021-01-12  2359  	if (flags & I_DIRTY_INODE) {
03ba3782e8dcc5 Jens Axboe            2009-09-09  2360  		/*
35d14f278e530e Eric Biggers          2021-01-12  2361  		 * Notify the filesystem about the inode being dirtied, so that
35d14f278e530e Eric Biggers          2021-01-12  2362  		 * (if needed) it can update on-disk fields and journal the
35d14f278e530e Eric Biggers          2021-01-12  2363  		 * inode.  This is only needed when the inode itself is being
35d14f278e530e Eric Biggers          2021-01-12  2364  		 * dirtied now.  I.e. it's only needed for I_DIRTY_INODE, not
35d14f278e530e Eric Biggers          2021-01-12  2365  		 * for just I_DIRTY_PAGES or I_DIRTY_TIME.
03ba3782e8dcc5 Jens Axboe            2009-09-09  2366  		 */
9fb0a7da0c528d Tejun Heo             2013-01-11  2367  		trace_writeback_dirty_inode_start(inode, flags);
03ba3782e8dcc5 Jens Axboe            2009-09-09  2368  		if (sb->s_op->dirty_inode)
a38ed483a72672 Eric Biggers          2021-01-12  2369  			sb->s_op->dirty_inode(inode, flags & I_DIRTY_INODE);
9fb0a7da0c528d Tejun Heo             2013-01-11  2370  		trace_writeback_dirty_inode(inode, flags);
e2728c5621fd9c Eric Biggers          2021-01-12  2371  
35d14f278e530e Eric Biggers          2021-01-12  2372  		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2373  		flags &= ~I_DIRTY_TIME;
35d14f278e530e Eric Biggers          2021-01-12  2374  	} else {
35d14f278e530e Eric Biggers          2021-01-12  2375  		/*
35d14f278e530e Eric Biggers          2021-01-12  2376  		 * Else it's either I_DIRTY_PAGES, I_DIRTY_TIME, or nothing.
35d14f278e530e Eric Biggers          2021-01-12  2377  		 * (We don't support setting both I_DIRTY_PAGES and I_DIRTY_TIME
35d14f278e530e Eric Biggers          2021-01-12  2378  		 * in one call to __mark_inode_dirty().)
35d14f278e530e Eric Biggers          2021-01-12  2379  		 */
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2380  		dirtytime = flags & I_DIRTY_TIME;
35d14f278e530e Eric Biggers          2021-01-12  2381  		WARN_ON_ONCE(dirtytime && flags != I_DIRTY_TIME);
35d14f278e530e Eric Biggers          2021-01-12  2382  	}
03ba3782e8dcc5 Jens Axboe            2009-09-09  2383  
03ba3782e8dcc5 Jens Axboe            2009-09-09  2384  	/*
9c6ac78eb3521c Tejun Heo             2014-10-24  2385  	 * Paired with smp_mb() in __writeback_single_inode() for the
9c6ac78eb3521c Tejun Heo             2014-10-24  2386  	 * following lockless i_state test.  See there for details.
03ba3782e8dcc5 Jens Axboe            2009-09-09  2387  	 */
03ba3782e8dcc5 Jens Axboe            2009-09-09  2388  	smp_mb();
03ba3782e8dcc5 Jens Axboe            2009-09-09  2389  
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2390  	if (((inode->i_state & flags) == flags) ||
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2391  	    (dirtytime && (inode->i_state & I_DIRTY_INODE)))
03ba3782e8dcc5 Jens Axboe            2009-09-09  2392  		return;
03ba3782e8dcc5 Jens Axboe            2009-09-09  2393  
250df6ed274d76 Dave Chinner          2011-03-22  2394  	spin_lock(&inode->i_lock);
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2395  	if (dirtytime && (inode->i_state & I_DIRTY_INODE))
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2396  		goto out_unlock_inode;
03ba3782e8dcc5 Jens Axboe            2009-09-09 @2397  	if ((inode->i_state & flags) != flags) {
03ba3782e8dcc5 Jens Axboe            2009-09-09  2398  		const int was_dirty = inode->i_state & I_DIRTY;
03ba3782e8dcc5 Jens Axboe            2009-09-09  2399  
52ebea749aaed1 Tejun Heo             2015-05-22  2400  		inode_attach_wb(inode, NULL);
52ebea749aaed1 Tejun Heo             2015-05-22  2401  
35d14f278e530e Eric Biggers          2021-01-12  2402  		/* I_DIRTY_INODE supersedes I_DIRTY_TIME. */
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2403  		if (flags & I_DIRTY_INODE)
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2404  			inode->i_state &= ~I_DIRTY_TIME;
03ba3782e8dcc5 Jens Axboe            2009-09-09  2405  		inode->i_state |= flags;
03ba3782e8dcc5 Jens Axboe            2009-09-09  2406  
af0b042e914fba Jchao Sun             2022-05-04  2407  		wb = locked_inode_to_wb_and_lock_list(inode);
af0b042e914fba Jchao Sun             2022-05-04  2408  		spin_lock(&inode->i_lock);
af0b042e914fba Jchao Sun             2022-05-04  2409  
03ba3782e8dcc5 Jens Axboe            2009-09-09  2410  		/*
5afced3bf28100 Jan Kara              2020-05-29  2411  		 * If the inode is queued for writeback by flush worker, just
5afced3bf28100 Jan Kara              2020-05-29  2412  		 * update its dirty state. Once the flush worker is done with
5afced3bf28100 Jan Kara              2020-05-29  2413  		 * the inode it will place it on the appropriate superblock
5afced3bf28100 Jan Kara              2020-05-29  2414  		 * list, based upon its state.
03ba3782e8dcc5 Jens Axboe            2009-09-09  2415  		 */
5afced3bf28100 Jan Kara              2020-05-29  2416  		if (inode->i_state & I_SYNC_QUEUED)
af0b042e914fba Jchao Sun             2022-05-04  2417  			goto out_unlock;
03ba3782e8dcc5 Jens Axboe            2009-09-09  2418  
03ba3782e8dcc5 Jens Axboe            2009-09-09  2419  		/*
03ba3782e8dcc5 Jens Axboe            2009-09-09  2420  		 * Only add valid (hashed) inodes to the superblock's
03ba3782e8dcc5 Jens Axboe            2009-09-09  2421  		 * dirty list.  Add blockdev inodes as well.
03ba3782e8dcc5 Jens Axboe            2009-09-09  2422  		 */
03ba3782e8dcc5 Jens Axboe            2009-09-09  2423  		if (!S_ISBLK(inode->i_mode)) {
1d3382cbf02986 Al Viro               2010-10-23  2424  			if (inode_unhashed(inode))
af0b042e914fba Jchao Sun             2022-05-04  2425  				goto out_unlock;
03ba3782e8dcc5 Jens Axboe            2009-09-09  2426  		}
a4ffdde6e56fdf Al Viro               2010-06-02  2427  		if (inode->i_state & I_FREEING)
af0b042e914fba Jchao Sun             2022-05-04  2428  			goto out_unlock;
03ba3782e8dcc5 Jens Axboe            2009-09-09  2429  
03ba3782e8dcc5 Jens Axboe            2009-09-09  2430  		/*
03ba3782e8dcc5 Jens Axboe            2009-09-09  2431  		 * If the inode was already on b_dirty/b_io/b_more_io, don't
03ba3782e8dcc5 Jens Axboe            2009-09-09  2432  		 * reposition it (that would break b_dirty time-ordering).
03ba3782e8dcc5 Jens Axboe            2009-09-09  2433  		 */
03ba3782e8dcc5 Jens Axboe            2009-09-09  2434  		if (!was_dirty) {
d6c10f1fc8626d Tejun Heo             2015-05-22  2435  			struct list_head *dirty_list;
a66979abad090b Dave Chinner          2011-03-22  2436  			bool wakeup_bdi = false;
500b067c5e6cee Jens Axboe            2009-09-09  2437  
03ba3782e8dcc5 Jens Axboe            2009-09-09  2438  			inode->dirtied_when = jiffies;
a2f4870697a5bc Theodore Ts'o         2015-03-17  2439  			if (dirtytime)
a2f4870697a5bc Theodore Ts'o         2015-03-17  2440  				inode->dirtied_time_when = jiffies;
d6c10f1fc8626d Tejun Heo             2015-05-22  2441  
0e11f6443f522f Christoph Hellwig     2018-02-21  2442  			if (inode->i_state & I_DIRTY)
0747259d13febf Tejun Heo             2015-05-22  2443  				dirty_list = &wb->b_dirty;
a2f4870697a5bc Theodore Ts'o         2015-03-17  2444  			else
0747259d13febf Tejun Heo             2015-05-22  2445  				dirty_list = &wb->b_dirty_time;
d6c10f1fc8626d Tejun Heo             2015-05-22  2446  
c7f5408493aeb0 Dave Chinner          2015-03-04  2447  			wakeup_bdi = inode_io_list_move_locked(inode, wb,
d6c10f1fc8626d Tejun Heo             2015-05-22  2448  							       dirty_list);
d6c10f1fc8626d Tejun Heo             2015-05-22  2449  
0747259d13febf Tejun Heo             2015-05-22  2450  			spin_unlock(&wb->list_lock);
af0b042e914fba Jchao Sun             2022-05-04  2451  			spin_unlock(&inode->i_lock);
0ae45f63d4ef8d Theodore Ts'o         2015-02-02  2452  			trace_writeback_dirty_inode_enqueue(inode);
a66979abad090b Dave Chinner          2011-03-22  2453  
d6c10f1fc8626d Tejun Heo             2015-05-22  2454  			/*
d6c10f1fc8626d Tejun Heo             2015-05-22  2455  			 * If this is the first dirty inode for this bdi,
d6c10f1fc8626d Tejun Heo             2015-05-22  2456  			 * we have to wake-up the corresponding bdi thread
d6c10f1fc8626d Tejun Heo             2015-05-22  2457  			 * to make sure background write-back happens
d6c10f1fc8626d Tejun Heo             2015-05-22  2458  			 * later.
d6c10f1fc8626d Tejun Heo             2015-05-22  2459  			 */
f56753ac2a9081 Christoph Hellwig     2020-09-24  2460  			if (wakeup_bdi &&
f56753ac2a9081 Christoph Hellwig     2020-09-24  2461  			    (wb->bdi->capabilities & BDI_CAP_WRITEBACK))
0747259d13febf Tejun Heo             2015-05-22  2462  				wb_wakeup_delayed(wb);
a66979abad090b Dave Chinner          2011-03-22  2463  			return;
03ba3782e8dcc5 Jens Axboe            2009-09-09  2464  		}
03ba3782e8dcc5 Jens Axboe            2009-09-09  2465  	}
af0b042e914fba Jchao Sun             2022-05-04  2466  out_unlock:
af0b042e914fba Jchao Sun             2022-05-04  2467  	spin_unlock(&wb->list_lock);
250df6ed274d76 Dave Chinner          2011-03-22  2468  out_unlock_inode:
250df6ed274d76 Dave Chinner          2011-03-22  2469  	spin_unlock(&inode->i_lock);
03ba3782e8dcc5 Jens Axboe            2009-09-09  2470  }
03ba3782e8dcc5 Jens Axboe            2009-09-09  2471  EXPORT_SYMBOL(__mark_inode_dirty);
03ba3782e8dcc5 Jens Axboe            2009-09-09  2472  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
