Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC64F229F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiDEFns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDEFnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:43:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904F263E8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649137308; x=1680673308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G2BO2/B3jnRoD2tEVHLw9dKyHuY6CFl1kJyzuzD+qdk=;
  b=Lt2d8/wLVWflgOy0t4TeEERObNkRcEabTmEDDBDYTVB1ked4OF3Zmvw6
   4lFPSh5eJKS74BMFYJsm7jglFByU/f0mv2ic6XrxIzUU543qVvq2U4pZ+
   /u4vQnt4VDsxRslRSqXoXkRr+oX2lcI/2hYyUu31hOvsKdFNM5FcAplrW
   x+Esnw2O3hfylZewvCqSRe9ItIYLdsB3uCLgSYEJGTtK+aMgR+p4wy8ts
   HGhmSTtk3JOzn7Pp6QcT9iwI7DSkvVQiQrntwFJque4IUyXujPSf5Mur8
   omYjpKtP1h46adbeI3sRd38xkXchw2/iYT8uTWo8c9l7XBGRe4h0gq6B6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="347108966"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="347108966"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="587811921"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2022 22:41:46 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbbwn-0002gX-Kv;
        Tue, 05 Apr 2022 05:41:45 +0000
Date:   Tue, 5 Apr 2022 13:40:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 35/40]
 fs/netfs/buffered_write.c:757:6: warning: variable 'spare_region' is used
 uninitialized whenever 'if' condition is true
Message-ID: <202204051308.qn1GUtl6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: fc20927bc9709523b2a53feee2a52423b9d66456 [35/40] netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220405/202204051308.qn1GUtl6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/fc20927bc9709523b2a53feee2a52423b9d66456
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout fc20927bc9709523b2a53feee2a52423b9d66456
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/netfs/buffered_write.c:757:6: warning: variable 'spare_region' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (mas_expected_entries(&mas, 2) < 0) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:793:30: note: uninitialized use occurs here
           netfs_put_dirty_region(ctx, spare_region, netfs_region_trace_put_discard);
                                       ^~~~~~~~~~~~
   fs/netfs/buffered_write.c:757:2: note: remove the 'if' if its condition is always false
           if (mas_expected_entries(&mas, 2) < 0) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:754:6: warning: variable 'spare_region' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (folio_lock_killable(folio) < 0)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:793:30: note: uninitialized use occurs here
           netfs_put_dirty_region(ctx, spare_region, netfs_region_trace_put_discard);
                                       ^~~~~~~~~~~~
   fs/netfs/buffered_write.c:754:2: note: remove the 'if' if its condition is always false
           if (folio_lock_killable(folio) < 0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:751:6: warning: variable 'spare_region' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (folio_wait_writeback_killable(folio))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:793:30: note: uninitialized use occurs here
           netfs_put_dirty_region(ctx, spare_region, netfs_region_trace_put_discard);
                                       ^~~~~~~~~~~~
   fs/netfs/buffered_write.c:751:2: note: remove the 'if' if its condition is always false
           if (folio_wait_writeback_killable(folio))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:734:41: note: initialize the variable 'spare_region' to silence this warning
           struct netfs_dirty_region *spare_region;
                                                  ^
                                                   = NULL
   3 warnings generated.


vim +757 fs/netfs/buffered_write.c

   727	
   728	/*
   729	 * Notification that a previously read-only page is about to become writable.
   730	 * Note that the caller indicates a single page of a multipage folio.
   731	 */
   732	vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf)
   733	{
   734		struct netfs_dirty_region *spare_region;
   735		struct folio *folio = page_folio(vmf->page);
   736		struct file *file = vmf->vma->vm_file;
   737		struct inode *inode = file_inode(file);
   738		struct netfs_i_context *ctx = netfs_i_context(inode);
   739		vm_fault_t ret = VM_FAULT_RETRY;
   740		int err;
   741	
   742		MA_STATE(mas, &ctx->dirty_regions, vmf->page->index, PAGE_SIZE);
   743	
   744		_enter("%lx", folio->index);
   745	
   746		if (ctx->ops->validate_for_write(inode, file) < 0)
   747			return VM_FAULT_SIGBUS;
   748	
   749		sb_start_pagefault(inode->i_sb);
   750	
   751		if (folio_wait_writeback_killable(folio))
   752			goto out;
   753	
   754		if (folio_lock_killable(folio) < 0)
   755			goto out;
   756	
 > 757		if (mas_expected_entries(&mas, 2) < 0) {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
