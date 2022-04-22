Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B9F50C582
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiDVX4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiDVX4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:56:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA30D1836EE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650671610; x=1682207610;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RsBMCVMzBkjT8W09i+11DEN4xVbA08k28FT5HMuqVf0=;
  b=X1oxcHHlgJzim+r4dbNtU9nUfRXFxN7dEf8vhja28/xDG7vVbQenRTal
   5Z3tE1d2m3Zjiv0bc0R66Q3pbKdwhutrmPHvLfbX6jw9TaB40gBc/psOx
   zcW9hYkWfLJ/GWIXTQNK0MSenJBcjJGi83opiy45YvgRyHq4QaSG36jxX
   DdxPavWz3/7mOV0Sqak8RiFOWhnMgmXRPGF0vJDojlKXykXv+lyhVKitl
   3uLimm415yDOCMx8wWuSiY78tWMElWuxSAz0WUEj1KzzW1/ka+Tkdkebj
   fqff8qf2rr/MzySVS3ADlU1Cu4Dk5mwlxV2eQ25aNJGc24/wXdbZ0HM5I
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289945398"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="289945398"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="659263330"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2022 16:53:27 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni35a-000Agl-HB;
        Fri, 22 Apr 2022 23:53:26 +0000
Date:   Sat, 23 Apr 2022 07:53:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 37/44]
 fs/netfs/buffered_write.c:757:6: warning: variable 'spare_region' is used
 uninitialized whenever 'if' condition is true
Message-ID: <202204230756.Ep4wbrdW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 289cadcc7f9a897a36b3cba0e12083ce36182827 [37/44] netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220423/202204230756.Ep4wbrdW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/289cadcc7f9a897a36b3cba0e12083ce36182827
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 289cadcc7f9a897a36b3cba0e12083ce36182827
        # save the config file
        mkdir build_dir && cp config build_dir/.config
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
