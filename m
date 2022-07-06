Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB98567B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 02:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiGFAYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 20:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiGFAYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:24:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE91B12AF5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 17:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657067056; x=1688603056;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NzPgZDZ1/C1339edFWZfg3lPwFjYpEBnGuVVnHSss30=;
  b=KuJARquk91AiNUF6qXU1RCSbFYyy6w7e71vYz+KYQqIV17NOMDahi8/T
   lWSXtUwfBvq4hcdKbBxYUPsCFnRIte/xXWTl9do8xC+RkNa2n7zlqvZDQ
   s4RAh2155afelEOeHkyKx3EV8+nABbi84jExHbJ5vKlTF7DrluobSFxCh
   6QO4yiKe/AVZe2a+vaJBq6JgFaLIPnt2BRXmCBBjbyG1TCjLYdbCidY+s
   swZnjy6dnsXM0d4xTqoyUkCvp6vnBOC2Qqe7R5qvPNMdwCeSs5KTcDBpd
   Kh4Tw0v3KPKnH+uNupk3jaSNoCUiVwPs/wAawwnEdyAMs6WD3JHniZjiE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272376442"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="272376442"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 17:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="719919425"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Jul 2022 17:24:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8spm-000Jk7-8W;
        Wed, 06 Jul 2022 00:24:02 +0000
Date:   Wed, 6 Jul 2022 08:23:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbusch:alignment-fixes 3/3] block/bio.c:1229:6: warning: variable
 'i' is used uninitialized whenever 'if' condition is true
Message-ID: <202207060806.4qoJVWlL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git alignment-fixes
head:   9d1ebc4c688471ccd3bffa5e6b08a82a71431f7b
commit: 9d1ebc4c688471ccd3bffa5e6b08a82a71431f7b [3/3] block: fix leaking page ref on truncated direct io
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220706/202207060806.4qoJVWlL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 142aca7741d5b06207e87bf4880fbe308c8d6823)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=9d1ebc4c688471ccd3bffa5e6b08a82a71431f7b
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch alignment-fixes
        git checkout 9d1ebc4c688471ccd3bffa5e6b08a82a71431f7b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/bio.c:1229:6: warning: variable 'i' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (unlikely(size <= 0)) {
               ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:78:22: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   block/bio.c:1251:9: note: uninitialized use occurs here
           while (i < nr_pages)
                  ^
   block/bio.c:1229:2: note: remove the 'if' if its condition is always false
           if (unlikely(size <= 0)) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   block/bio.c:1202:17: note: initialize the variable 'i' to silence this warning
           unsigned len, i;
                          ^
                           = 0
   1 warning generated.


vim +1229 block/bio.c

  1184	
  1185	/**
  1186	 * __bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
  1187	 * @bio: bio to add pages to
  1188	 * @iter: iov iterator describing the region to be mapped
  1189	 *
  1190	 * Pins pages from *iter and appends them to @bio's bvec array. The
  1191	 * pages will have to be released using put_page() when done.
  1192	 * For multi-segment *iter, this function only adds pages from the
  1193	 * next non-empty segment of the iov iterator.
  1194	 */
  1195	static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
  1196	{
  1197		unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
  1198		unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
  1199		struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
  1200		struct page **pages = (struct page **)bv;
  1201		ssize_t size, left;
  1202		unsigned len, i;
  1203		size_t offset;
  1204		int ret = 0;
  1205	
  1206		/*
  1207		 * Move page array up in the allocated memory for the bio vecs as far as
  1208		 * possible so that we can start filling biovecs from the beginning
  1209		 * without overwriting the temporary page array.
  1210		 */
  1211		BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
  1212		pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
  1213	
  1214		/*
  1215		 * Each segment in the iov is required to be a block size multiple.
  1216		 * However, we may not be able to get the entire segment if it spans
  1217		 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
  1218		 * result to ensure the bio's total size is correct. The remainder of
  1219		 * the iov data will be picked up in the next bio iteration.
  1220		 */
  1221		size = iov_iter_get_pages(iter, pages, UINT_MAX - bio->bi_iter.bi_size,
  1222					  nr_pages, &offset);
  1223		if (size > 0) {
  1224			nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
  1225			size = ALIGN_DOWN(size, bdev_logical_block_size(bio->bi_bdev));
  1226		} else
  1227			nr_pages = 0;
  1228	
> 1229		if (unlikely(size <= 0)) {
  1230			ret = size ? size : -EFAULT;
  1231			goto out;
  1232		}
  1233	
  1234		for (left = size, i = 0; left > 0; left -= len, i++) {
  1235			struct page *page = pages[i];
  1236	
  1237			len = min_t(size_t, PAGE_SIZE - offset, left);
  1238			if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
  1239				ret = bio_iov_add_zone_append_page(bio, page, len,
  1240						offset);
  1241				if (ret)
  1242					break;
  1243			} else
  1244				bio_iov_add_page(bio, page, len, offset);
  1245	
  1246			offset = 0;
  1247		}
  1248	
  1249		iov_iter_advance(iter, size - left);
  1250	out:
  1251		while (i < nr_pages)
  1252			put_page(pages[i++]);
  1253	
  1254		return ret;
  1255	}
  1256	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
