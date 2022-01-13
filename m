Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5C248D94A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiAMNrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:47:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:36001 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235091AbiAMNrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642081671; x=1673617671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/4uRvoTvLfeiMbp8As2cFKlxzm+YR8u6juEOamjmJX0=;
  b=YB0Q0NTeERlXCa+/684l4GCOZFMlOJ/jV/1YTqAMV9E6+56dWvuKkrjT
   KsZLdEgyp84Y1e17z22HGZqbshSf9M6H4va1XYbGIaqWzXOYPua7uBbzl
   JwuN7D81Gjx8T6TQkSTDzKm8vgKmoU9S81SglJpPwlKK2apg+SHt6FMhu
   3f3NvDgRSL5X1Zdx1UKmXqe2k3rjBnuXGYka5eg0YRq2Nkm5qiEKpDDOG
   zCCeqha8rTYBPkW+l147DMFrg6BuytzB7NPiITaoNi7wCEzaohkpY7K6O
   Osr3gnu5a7MYTkx6GzvBO8Lz2GbklqQQ7sT8XiroKqKhlxsqF2L2+8Am6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307353883"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="307353883"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 05:47:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="691805013"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 05:47:49 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n80SC-0007Fj-NV; Thu, 13 Jan 2022 13:47:48 +0000
Date:   Thu, 13 Jan 2022 21:47:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: fs/iomap/buffered-io.c:1098 iomap_finish_ioends() warn: inconsistent
 indenting
Message-ID: <202201132101.AoT0bCj5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220111-073805/trondmy-kernel-org/iomap-Address-soft-lockup-in-iomap_finish_ioend/20211231-034313
head:   f1c8b8b2e616895aa0f5be4e53d4cd1ffa751001
commit: f1c8b8b2e616895aa0f5be4e53d4cd1ffa751001 iomap: Address soft lockup in iomap_finish_ioend()
date:   3 days ago
config: arm-randconfig-m031-20220113 (https://download.01.org/0day-ci/archive/20220113/202201132101.AoT0bCj5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
fs/iomap/buffered-io.c:1098 iomap_finish_ioends() warn: inconsistent indenting
fs/iomap/buffered-io.c:1330 iomap_add_to_ioend() warn: inconsistent indenting

Old smatch warnings:
fs/iomap/buffered-io.c:1434 iomap_writepage_map() warn: inconsistent indenting

vim +1098 fs/iomap/buffered-io.c

  1072	
  1073	/*
  1074	 * Ioend completion routine for merged bios. This can only be called from task
  1075	 * contexts as merged ioends can be of unbound length. Hence we have to break up
  1076	 * the page writeback completion into manageable chunks to avoid long scheduler
  1077	 * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
  1078	 * good batch processing throughput without creating adverse scheduler latency
  1079	 * conditions.
  1080	 */
  1081	void
  1082	iomap_finish_ioends(struct iomap_ioend *ioend, int error)
  1083	{
  1084		struct list_head tmp;
  1085		u32 pages;
  1086	
  1087		might_sleep();
  1088	
  1089		list_replace_init(&ioend->io_list, &tmp);
  1090		pages = iomap_finish_ioend(ioend, error);
  1091	
  1092		while (!list_empty(&tmp)) {
  1093		trace_printk("pages %u, start sector 0x%llx size %lu pcnt %u",
  1094			ioend->io_pages,
  1095			ioend->io_sector,
  1096			ioend->io_size,
  1097			pages);
> 1098			if (pages > 32768) {
  1099				cond_resched();
  1100				pages = 0;
  1101			}
  1102			ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
  1103			list_del_init(&ioend->io_list);
  1104			pages += iomap_finish_ioend(ioend, error);
  1105		}
  1106		trace_printk("pages %u, start sector 0x%llx size %lu pcnt %u",
  1107			ioend->io_pages,
  1108			ioend->io_sector,
  1109			ioend->io_size,
  1110			pages);
  1111	}
  1112	EXPORT_SYMBOL_GPL(iomap_finish_ioends);
  1113	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
