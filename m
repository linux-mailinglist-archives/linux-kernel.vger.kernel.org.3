Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291F94B94B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiBPXsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:48:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiBPXsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:48:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF1251E44
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645055276; x=1676591276;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fs4JKPq5X+QC5yD0VVUEKvyhnjnWCNRaHddlh6dhTqI=;
  b=gU2kDXxqSWYQmS1Siqz5wSfGd32W76O/VPW/WHdk/pkyRWqZiyjb58Gw
   z+rZKBxzRl+GyxY1YyLG5iySKSlZGqzIXGvGBKeXL0BBF0Lespg8cgkk+
   qZDzuDmzRpTiox1N0o2OlIy3JP1rfRYV3zqy9x1Oq5uVb1cil3BuBFJI4
   3D6469UWrMv5ukg1E0hEKKqg8SU/75DBlL9bnXk9rY3EHuGsTcVXW84+d
   40jv41aVwI0AP0gYo97P2pn90YwPHIVr9QqS8d+1MVceyvFG09YXxprgI
   XVf2ywxSaE7Ekk8J3g5hDgmGtkJ+Ofs4d4K6Tbax8eiJNBvcxRCS5l5oh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250947337"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="250947337"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 15:47:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="704516440"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Feb 2022 15:47:54 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKU1Z-000BFL-P5; Wed, 16 Feb 2022 23:47:53 +0000
Date:   Thu, 17 Feb 2022 07:47:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 31/42]
 fs/netfs/buffered_write.c:749:6: warning: variable 'spare_region' is used
 uninitialized whenever 'if' condition is true
Message-ID: <202202170739.jOmFwlAm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   5cb7f190822d09757b30cd9539e57eef72552d1f
commit: eefdd180445e96088f4a69f0e733643e9a794b1f [31/42] netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()
config: hexagon-randconfig-r005-20220216 (https://download.01.org/0day-ci/archive/20220217/202202170739.jOmFwlAm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0e628a783b935c70c80815db6c061ec84f884af5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/eefdd180445e96088f4a69f0e733643e9a794b1f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout eefdd180445e96088f4a69f0e733643e9a794b1f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/netfs/buffered_write.c:28:26: warning: comparison of distinct pointer types ('typeof ((1UL << 14) - offset) *' (aka 'unsigned long *') and 'typeof (size) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
                   unsigned int psize   = min(PAGE_SIZE - offset, size);
                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:95:18: warning: comparison of distinct pointer types ('typeof (target->from) *' (aka 'unsigned long long *') and 'typeof (folio_pos(folio) + offset) *' (aka 'long long *')) [-Wcompare-distinct-pointer-types]
           target->from  = min(target->from, folio_pos(folio) + offset);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:96:18: warning: comparison of distinct pointer types ('typeof (target->to) *' (aka 'unsigned long long *') and 'typeof (folio_pos(folio) + offset + len) *' (aka 'long long *')) [-Wcompare-distinct-pointer-types]
           target->to    = max(target->to,   folio_pos(folio) + offset + len);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:52:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(x, y, >)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
>> fs/netfs/buffered_write.c:749:6: warning: variable 'spare_region' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (mas_expected_entries(&mas, 2) < 0) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:785:30: note: uninitialized use occurs here
           netfs_put_dirty_region(ctx, spare_region, netfs_region_trace_put_discard);
                                       ^~~~~~~~~~~~
   fs/netfs/buffered_write.c:749:2: note: remove the 'if' if its condition is always false
           if (mas_expected_entries(&mas, 2) < 0) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:746:6: warning: variable 'spare_region' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (folio_lock_killable(folio) < 0)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:785:30: note: uninitialized use occurs here
           netfs_put_dirty_region(ctx, spare_region, netfs_region_trace_put_discard);
                                       ^~~~~~~~~~~~
   fs/netfs/buffered_write.c:746:2: note: remove the 'if' if its condition is always false
           if (folio_lock_killable(folio) < 0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:743:6: warning: variable 'spare_region' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (folio_wait_writeback_killable(folio))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:785:30: note: uninitialized use occurs here
           netfs_put_dirty_region(ctx, spare_region, netfs_region_trace_put_discard);
                                       ^~~~~~~~~~~~
   fs/netfs/buffered_write.c:743:2: note: remove the 'if' if its condition is always false
           if (folio_wait_writeback_killable(folio))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/netfs/buffered_write.c:726:41: note: initialize the variable 'spare_region' to silence this warning
           struct netfs_dirty_region *spare_region;
                                                  ^
                                                   = NULL
   6 warnings generated.


vim +749 fs/netfs/buffered_write.c

   719	
   720	/*
   721	 * Notification that a previously read-only page is about to become writable.
   722	 * Note that the caller indicates a single page of a multipage folio.
   723	 */
   724	vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf)
   725	{
   726		struct netfs_dirty_region *spare_region;
   727		struct folio *folio = page_folio(vmf->page);
   728		struct file *file = vmf->vma->vm_file;
   729		struct inode *inode = file_inode(file);
   730		struct netfs_i_context *ctx = netfs_i_context(inode);
   731		vm_fault_t ret = VM_FAULT_RETRY;
   732		int err;
   733	
   734		MA_STATE(mas, &ctx->dirty_regions, vmf->page->index, PAGE_SIZE);
   735	
   736		_enter("%lx", folio->index);
   737	
   738		if (ctx->ops->validate_for_write(inode, file) < 0)
   739			return VM_FAULT_SIGBUS;
   740	
   741		sb_start_pagefault(inode->i_sb);
   742	
   743		if (folio_wait_writeback_killable(folio))
   744			goto out;
   745	
   746		if (folio_lock_killable(folio) < 0)
   747			goto out;
   748	
 > 749		if (mas_expected_entries(&mas, 2) < 0) {

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
