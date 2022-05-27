Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1359653686E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354744AbiE0V1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352945AbiE0V1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:27:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB882BB2A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653686842; x=1685222842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yBhoFx0LzjfmGipvTJkyTcdSxGSvYgNr6XT6BnGtZ3Q=;
  b=nHG9gu0SShgB3WZ0xnXWh5SJOviJCQ6Zz6JgQqFWuLyGhQLUPrPM+9Od
   N4v0mSfn7C+ET5Imns/b2nxtaQyacHEVPfxyQmo3RSfW49vK10nniG6YQ
   LSoIi5Vv7DFMHptJuWJ3FQozV7MWg2PWfWN13jiNlKslFEGrSg89j1rQp
   nQupBrrt+XudoCVbEcisfm3AGndx1C/SBVux3EgVKNA9mcn0jYrQop0Dq
   MvPZYeWqzt25sIJf9+GQtQqdaYCVqhM0VRH60sPSQnE6TZ5jvfgPPrsd8
   8Wh0PidJLBnQkvAPPr3M55bvkR61bwJ58BDVxz5YSdyVeSAYHqMrOUN4u
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="273394377"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="273394377"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 14:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="747265855"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2022 14:27:21 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuhUO-00059F-Ov;
        Fri, 27 May 2022 21:27:20 +0000
Date:   Sat, 28 May 2022 05:26:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [dhowells-fs:cifs-for-sfrench 7/9] fs/cifs/file.c:2496
 cifs_write_back_from_locked_folio() error: potential null dereference
 'wdata'.  (cifs_writedata_alloc returns null)
Message-ID: <202205280552.tAo4vYPe-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git cifs-for-sfrench
head:   c1da8a43f0f920f86394ca254c99a91622bb3fe4
commit: 058279f48aab49f18536d30e1bb778c8b35620b1 [7/9] cifs: Trace writedata page wrangling
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220528/202205280552.tAo4vYPe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
fs/cifs/file.c:2496 cifs_write_back_from_locked_folio() error: potential null dereference 'wdata'.  (cifs_writedata_alloc returns null)
fs/cifs/file.c:2496 cifs_write_back_from_locked_folio() error: we previously assumed 'wdata' could be null (see line 2414)
fs/cifs/file.c:2496 cifs_write_back_from_locked_folio() error: potentially dereferencing uninitialized 'wdata'.

vim +/wdata +2496 fs/cifs/file.c

  2370	
  2371	/*
  2372	 * Write back the locked page and any subsequent non-locked dirty pages.
  2373	 */
  2374	static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
  2375							 struct writeback_control *wbc,
  2376							 struct folio *folio,
  2377							 loff_t start, loff_t end)
  2378	{
  2379		struct inode *inode = mapping->host;
  2380		struct TCP_Server_Info *server;
  2381		struct cifs_writedata *wdata;
  2382		struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
  2383		struct cifs_credits credits_on_stack;
  2384		struct cifs_credits *credits = &credits_on_stack;
  2385		struct cifsFileInfo *cfile = NULL;
  2386		unsigned int xid, wsize, len;
  2387		loff_t i_size = i_size_read(inode);
  2388		size_t max_len;
  2389		long count = wbc->nr_to_write;
  2390		int rc;
  2391	
  2392		/* The folio should be locked, dirty and not undergoing writeback. */
  2393		if (folio_start_writeback(folio))
  2394			WARN_ON(1);
  2395	
  2396		count -= folio_nr_pages(folio);
  2397		len = folio_size(folio);
  2398	
  2399		xid = get_xid();
  2400		server = cifs_pick_channel(cifs_sb_master_tcon(cifs_sb)->ses);
  2401	
  2402		rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY, &cfile);
  2403		if (rc) {
  2404			cifs_dbg(VFS, "No writable handle in writepages rc=%d\n", rc);
  2405			goto err_xid;
  2406		}
  2407	
  2408		rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->wsize,
  2409						   &wsize, credits);
  2410		if (rc != 0)
  2411			goto err_close;
  2412	
  2413		wdata = cifs_writedata_alloc(cifs_writev_complete);
> 2414		if (!wdata) {
  2415			rc = -ENOMEM;
  2416			goto err_uncredit;
  2417		}
  2418	
  2419		wdata->sync_mode = wbc->sync_mode;
  2420		wdata->offset = folio_pos(folio);
  2421		wdata->pid = cfile->pid;
  2422		wdata->credits = credits_on_stack;
  2423		wdata->cfile = cfile;
  2424		wdata->server = server;
  2425		cfile = NULL;
  2426	
  2427		/* Find all consecutive lockable dirty pages, stopping when we find a
  2428		 * page that is not immediately lockable, is not dirty or is missing,
  2429		 * or we reach the end of the range.
  2430		 */
  2431		if (start < i_size) {
  2432			/* Trim the write to the EOF; the extra data is ignored.  Also
  2433			 * put an upper limit on the size of a single storedata op.
  2434			 */
  2435			max_len = wsize;
  2436			max_len = min_t(unsigned long long, max_len, end - start + 1);
  2437			max_len = min_t(unsigned long long, max_len, i_size - start);
  2438	
  2439			if (len < max_len) {
  2440				int max_pages = INT_MAX;
  2441	
  2442	#ifdef CONFIG_CIFS_SMB_DIRECT
  2443				if (server->smbd_conn)
  2444					max_pages = server->smbd_conn->max_frmr_depth;
  2445	#endif
  2446				max_pages -= folio_nr_pages(folio);
  2447	
  2448				if (max_pages > 0)
  2449					cifs_extend_writeback(mapping, &count, start,
  2450							      max_pages, max_len, &len);
  2451			}
  2452			len = min_t(loff_t, len, max_len);
  2453		}
  2454	
  2455		wdata->bytes = len;
  2456	
  2457		/* We now have a contiguous set of dirty pages, each with writeback
  2458		 * set; the first page is still locked at this point, but all the rest
  2459		 * have been unlocked.
  2460		 */
  2461		folio_unlock(folio);
  2462	
  2463		if (start < i_size) {
  2464			iov_iter_xarray(&wdata->iter, WRITE, &mapping->i_pages, start, len);
  2465	
  2466			rc = adjust_credits(wdata->server, &wdata->credits, wdata->bytes);
  2467			if (rc)
  2468				goto err_wdata;
  2469	
  2470			trace_smb3_pages_write_back(inode, start, len, 0, wdata->debug_id);
  2471			if (wdata->cfile->invalidHandle)
  2472				rc = -EAGAIN;
  2473			else
  2474				rc = wdata->server->ops->async_writev(wdata,
  2475								      cifs_writedata_release);
  2476			if (rc >= 0) {
  2477				kref_put(&wdata->refcount, cifs_writedata_release);
  2478				goto err_close;
  2479			}
  2480		} else {
  2481			/* The dirty region was entirely beyond the EOF. */
  2482			trace_smb3_pages_write_beyond(inode, start, len, rc, wdata->debug_id);
  2483			cifs_pages_written_back(inode, start, len, wdata->debug_id);
  2484			rc = 0;
  2485		}
  2486	
  2487	err_wdata:
  2488		kref_put(&wdata->refcount, cifs_writedata_release);
  2489	err_uncredit:
  2490		add_credits_and_wake_if(server, credits, 0);
  2491	err_close:
  2492		if (cfile)
  2493			cifsFileInfo_put(cfile);
  2494	err_xid:
  2495		free_xid(xid);
> 2496		trace_smb3_pages_write_end(inode, start, len, rc, wdata->debug_id);
  2497		if (rc == 0) {
  2498			wbc->nr_to_write = count;
  2499		} else if (is_retryable_error(rc)) {
  2500			cifs_pages_write_redirty(inode, start, len, wdata->debug_id);
  2501		} else {
  2502			cifs_pages_write_failed(inode, start, len, wdata->debug_id);
  2503			mapping_set_error(mapping, rc);
  2504		}
  2505		/* Indication to update ctime and mtime as close is deferred */
  2506		set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
  2507		return rc;
  2508	}
  2509	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
