Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862B513260
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345678AbiD1LYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbiD1LXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:23:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A0724092
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651144825; x=1682680825;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZPrsh+0tNzPO483bOJM93YSxdd0XN/16xX0+69NhVQQ=;
  b=JqB83HvWAvjcfE/qdRCj0Va5swAzF+WhFVIO9zDS0gnU7TUppZKPoGk1
   lMk0IRZxqrsWKCY43rwUjdcHKfXwAnV2Vw7k1qpfMKBdYMVvb6DbxjZYi
   khhYGt5VMJGtKFhEYHMYknxgImhpnEuPEfBI9r7xaGdDNgiUGJgidRoj9
   N3+7pnSBFw41rrJMPJDXd72tSY6KcHvOI6yFlwwmpuGw/y072iPcb+8t7
   NfZLU1LSzsjg5TNJ4LXRIl5WagnyXwZsVIPwa8TYuOJIAVPSNkPIhzFvi
   B5n8p7FhRamrXuSJwkUl5trvxgQSruBTEM3Q9Mvl6tO2LKkBh67fmUze6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="263845737"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="263845737"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 04:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="706015599"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2022 04:20:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk2C6-0005JH-8V;
        Thu, 28 Apr 2022 11:20:22 +0000
Date:   Thu, 28 Apr 2022 19:19:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 39/45]
 fs/netfs/buffered_write.c:670 netfs_page_mkwrite() warn: unsigned 'ret' is
 never less than zero.
Message-ID: <202204281931.WsLfU7aL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   a20ca5707a9b524115f5ded439fed1f8e552dd6b
commit: 95f517db4cb2fbcfdabe76d0be06d75746958b0b [39/45] netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220428/202204281931.WsLfU7aL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
fs/netfs/buffered_write.c:670 netfs_page_mkwrite() warn: unsigned 'ret' is never less than zero.

vim +/ret +670 fs/netfs/buffered_write.c

   640	
   641	/*
   642	 * Notification that a previously read-only page is about to become writable.
   643	 * Note that the caller indicates a single page of a multipage folio.
   644	 */
   645	vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf)
   646	{
   647		struct netfs_dirty_region *region;
   648		struct folio *folio = page_folio(vmf->page);
   649		struct file *file = vmf->vma->vm_file;
   650		struct inode *inode = file_inode(file);
   651		struct netfs_i_context *ctx = netfs_i_context(inode);
   652		vm_fault_t ret = VM_FAULT_RETRY;
   653		int err;
   654		LIST_HEAD(spare_regions);
   655	
   656		_enter("%lx", folio->index);
   657	
   658		if (ctx->ops->validate_for_write(inode, file) < 0)
   659			return VM_FAULT_SIGBUS;
   660	
   661		sb_start_pagefault(inode->i_sb);
   662	
   663		if (folio_wait_writeback_killable(folio))
   664			goto out;
   665	
   666		if (folio_lock_killable(folio) < 0)
   667			goto out;
   668	
   669		ret = netfs_preallocate_regions(&spare_regions);
 > 670		if (ret < 0) {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
