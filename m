Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C63D547B1D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 19:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiFLRET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 13:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFLRER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 13:04:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5577C3137C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655053456; x=1686589456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s0HDjSYBMcvQBnzmTmJjZHW0Z/MkYoA0719o+df8DbA=;
  b=dUGkXAwBv0koLlyVkSvCeO4Pf+n7wlL+AV/MJGOUdVZjiqcsCr2+zvLd
   EgJNz6yFCFZiyAkvhgD22yYKlbHmYKyQvmo0IGQ5gAqLnjxq66LMqZk/b
   ntR8RnLcgP1mY6SKuXJvWmn7lnIL+/MiYylLgGzJ46DI0oXWhoTL7aohR
   jxwTdMrvMNKOvBV80ZHDUIwtfI/VP0+TibHM1suFrDUAzzouOzFTh9YTE
   Wx2CQzr9HL1b/ZUAayfuw2rrZAAm6d8jswB6/3n15imAdZhoDBHqWuKf5
   kkZZ38UFjAsVjmWYUG9iZZOERuMvxCtlBCJIB9l+0RM4DMOjBAtYjUdlb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="278111400"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="278111400"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 10:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="639252278"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2022 10:04:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0R0X-000K5D-N3;
        Sun, 12 Jun 2022 17:04:13 +0000
Date:   Mon, 13 Jun 2022 01:03:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [linux-stable-rc:queue/5.15 165/165] lib/iov_iter.c:1466:9: warning:
 comparison of distinct pointer types ('typeof (nr * (1UL << 16) - offset) *'
 (aka 'unsigned long *') and 'typeof (maxsize) *' (aka 'unsigned int *'))
Message-ID: <202206130107.hjrRK0jH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.15
head:   04983d84c84ee97abcab8bd9e6488790086cb082
commit: 04983d84c84ee97abcab8bd9e6488790086cb082 [165/165] iov_iter: Fix iter_xarray_get_pages{,_alloc}()
config: hexagon-randconfig-r041-20220612 (https://download.01.org/0day-ci/archive/20220613/202206130107.hjrRK0jH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6466c9abf3674bade1f6ee859f24ebc7aaf9cd88)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=04983d84c84ee97abcab8bd9e6488790086cb082
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.15
        git checkout 04983d84c84ee97abcab8bd9e6488790086cb082
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/iov_iter.c:1466:9: warning: comparison of distinct pointer types ('typeof (nr * (1UL << 16) - offset) *' (aka 'unsigned long *') and 'typeof (maxsize) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
           return min(nr * PAGE_SIZE - offset, maxsize);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   lib/iov_iter.c:1630:9: warning: comparison of distinct pointer types ('typeof (nr * (1UL << 16) - offset) *' (aka 'unsigned long *') and 'typeof (maxsize) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
           return min(nr * PAGE_SIZE - offset, maxsize);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   2 warnings generated.


vim +1466 lib/iov_iter.c

  1432	
  1433	static ssize_t iter_xarray_get_pages(struct iov_iter *i,
  1434					     struct page **pages, size_t maxsize,
  1435					     unsigned maxpages, size_t *_start_offset)
  1436	{
  1437		unsigned nr, offset;
  1438		pgoff_t index, count;
  1439		size_t size = maxsize;
  1440		loff_t pos;
  1441	
  1442		if (!size || !maxpages)
  1443			return 0;
  1444	
  1445		pos = i->xarray_start + i->iov_offset;
  1446		index = pos >> PAGE_SHIFT;
  1447		offset = pos & ~PAGE_MASK;
  1448		*_start_offset = offset;
  1449	
  1450		count = 1;
  1451		if (size > PAGE_SIZE - offset) {
  1452			size -= PAGE_SIZE - offset;
  1453			count += size >> PAGE_SHIFT;
  1454			size &= ~PAGE_MASK;
  1455			if (size)
  1456				count++;
  1457		}
  1458	
  1459		if (count > maxpages)
  1460			count = maxpages;
  1461	
  1462		nr = iter_xarray_populate_pages(pages, i->xarray, index, count);
  1463		if (nr == 0)
  1464			return 0;
  1465	
> 1466		return min(nr * PAGE_SIZE - offset, maxsize);
  1467	}
  1468	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
