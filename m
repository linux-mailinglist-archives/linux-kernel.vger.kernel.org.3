Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04F54D94C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345275AbiCOGp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345273AbiCOGpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:45:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930AE167DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647326647; x=1678862647;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gW3Vm5mt+vLThltYqtT30lxxWl2VJq0wNPuHLeVRcOw=;
  b=d8KG3B7Lo1R1B0VJIIWhWNuyR4/++MiR339DtIOVEkxEEWpMkGbD/6II
   uiFg1buicowIc19soMOpUAI227U7Y+h1w168DaQKBapvY6rR20rMhm2ml
   Jyjkw6KwuIUmz5vg84275Btn8yF04H7nI/KqChM/4CpXbYxBxfsClhf1h
   /IGZCB05RNinXAS9iJzfgJsWzDo9RJ4E02O85D1VjVfnI4yZYjjVlAkID
   bSC83iSk7f0PMAsk1cAxCl3W13KQqIVHgwCrVWYzQL0TQ5pGUTdrU6FQ+
   LrJmYDnClGs18LfIeEtdyeVdX9770ik4nas9fHN3ipUhj/WB+7gs82pNy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256178248"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="256178248"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 23:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="714042247"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Mar 2022 23:43:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU0uS-000Aej-PS; Tue, 15 Mar 2022 06:43:56 +0000
Date:   Tue, 15 Mar 2022 14:43:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt-sparse 72/74] fs/ceph/file.c:1032:4: warning:
 variable 'fret' is uninitialized when used here
Message-ID: <202203151433.MbNp3362-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt-sparse
head:   0d355bda666e44314f11974167e8d9bb010a539e
commit: cbe05f4053d9f2f72668b9385e0e14c11c9adf32 [72/74] ceph: use r_pp for sparse reads
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220315/202203151433.MbNp3362-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=cbe05f4053d9f2f72668b9385e0e14c11c9adf32
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt-sparse
        git checkout cbe05f4053d9f2f72668b9385e0e14c11c9adf32
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ceph/file.c:1032:4: warning: variable 'fret' is uninitialized when used here [-Wuninitialized]
                           fret -= (off - read_off);
                           ^~~~
   fs/ceph/file.c:1029:12: note: initialize the variable 'fret' to silence this warning
                           int fret;
                                   ^
                                    = 0
   1 warning generated.


vim +/fret +1032 fs/ceph/file.c

83701246aee8f83 Yan, Zheng   2014-11-14   921  
124e68e74099090 Sage Weil    2009-10-06   922  /*
124e68e74099090 Sage Weil    2009-10-06   923   * Completely synchronous read and write methods.  Direct from __user
124e68e74099090 Sage Weil    2009-10-06   924   * buffer to osd, or directly to user pages (if O_DIRECT).
124e68e74099090 Sage Weil    2009-10-06   925   *
fce7a9744bdf3ba Yan, Zheng   2018-09-29   926   * If the read spans object boundary, just do multiple reads.  (That's not
fce7a9744bdf3ba Yan, Zheng   2018-09-29   927   * atomic, but good enough for now.)
fce7a9744bdf3ba Yan, Zheng   2018-09-29   928   *
fce7a9744bdf3ba Yan, Zheng   2018-09-29   929   * If we get a short result from the OSD, check against i_size; we need to
fce7a9744bdf3ba Yan, Zheng   2018-09-29   930   * only return a short read to the caller if we hit EOF.
124e68e74099090 Sage Weil    2009-10-06   931   */
1c3b32d36296389 Xiubo Li     2021-11-05   932  ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
cd6ba7d365023a0 Xiubo Li     2021-12-08   933  			 struct iov_iter *to, int *retry_op,
cd6ba7d365023a0 Xiubo Li     2021-12-08   934  			 u64 *last_objver)
124e68e74099090 Sage Weil    2009-10-06   935  {
fce7a9744bdf3ba Yan, Zheng   2018-09-29   936  	struct ceph_inode_info *ci = ceph_inode(inode);
fce7a9744bdf3ba Yan, Zheng   2018-09-29   937  	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
fce7a9744bdf3ba Yan, Zheng   2018-09-29   938  	struct ceph_osd_client *osdc = &fsc->client->osdc;
7ce469a53e7106a Yan, Zheng   2016-11-08   939  	ssize_t ret;
1c3b32d36296389 Xiubo Li     2021-11-05   940  	u64 off = *ki_pos;
fce7a9744bdf3ba Yan, Zheng   2018-09-29   941  	u64 len = iov_iter_count(to);
e485d028bb1075d Jeff Layton  2021-11-23   942  	u64 i_size = i_size_read(inode);
cd6ba7d365023a0 Xiubo Li     2021-12-08   943  	u64 objver = 0;
124e68e74099090 Sage Weil    2009-10-06   944  
1c3b32d36296389 Xiubo Li     2021-11-05   945  	dout("sync_read on inode %p %llu~%u\n", inode, *ki_pos, (unsigned)len);
d0d0db2268cc343 Yan, Zheng   2014-07-21   946  
d0d0db2268cc343 Yan, Zheng   2014-07-21   947  	if (!len)
d0d0db2268cc343 Yan, Zheng   2014-07-21   948  		return 0;
124e68e74099090 Sage Weil    2009-10-06   949  	/*
124e68e74099090 Sage Weil    2009-10-06   950  	 * flush any page cache pages in this range.  this
e98b6fed84d0f01 Sage Weil    2010-11-09   951  	 * will make concurrent normal and sync io slow,
124e68e74099090 Sage Weil    2009-10-06   952  	 * but it will at least behave sensibly when they are
124e68e74099090 Sage Weil    2009-10-06   953  	 * in sequence.
124e68e74099090 Sage Weil    2009-10-06   954  	 */
e450f4d1a5d633d zhengbin     2019-02-01   955  	ret = filemap_write_and_wait_range(inode->i_mapping,
e450f4d1a5d633d zhengbin     2019-02-01   956  					   off, off + len - 1);
29065a513aa4c7e Yehuda Sadeh 2010-02-09   957  	if (ret < 0)
8eb4efb091c8d8f majianpeng   2013-09-26   958  		return ret;
29065a513aa4c7e Yehuda Sadeh 2010-02-09   959  
fce7a9744bdf3ba Yan, Zheng   2018-09-29   960  	ret = 0;
fce7a9744bdf3ba Yan, Zheng   2018-09-29   961  	while ((len = iov_iter_count(to)) > 0) {
fce7a9744bdf3ba Yan, Zheng   2018-09-29   962  		struct ceph_osd_request *req;
fce7a9744bdf3ba Yan, Zheng   2018-09-29   963  		struct page **pages;
fce7a9744bdf3ba Yan, Zheng   2018-09-29   964  		int num_pages;
7ce469a53e7106a Yan, Zheng   2016-11-08   965  		size_t page_off;
fce7a9744bdf3ba Yan, Zheng   2018-09-29   966  		bool more;
c5f575ed08c38d0 Jeff Layton  2020-08-21   967  		int idx;
c5f575ed08c38d0 Jeff Layton  2020-08-21   968  		size_t left;
7b8289467f2eaaf Jeff Layton  2021-01-28   969  		u64 read_off = off;
7b8289467f2eaaf Jeff Layton  2021-01-28   970  		u64 read_len = len;
7b8289467f2eaaf Jeff Layton  2021-01-28   971  
7b8289467f2eaaf Jeff Layton  2021-01-28   972  		/* determine new offset/length if encrypted */
7b8289467f2eaaf Jeff Layton  2021-01-28   973  		ceph_fscrypt_adjust_off_and_len(inode, &read_off, &read_len);
7b8289467f2eaaf Jeff Layton  2021-01-28   974  
7b8289467f2eaaf Jeff Layton  2021-01-28   975  		dout("sync_read orig %llu~%llu reading %llu~%llu",
7b8289467f2eaaf Jeff Layton  2021-01-28   976  		     off, len, read_off, read_len);
fce7a9744bdf3ba Yan, Zheng   2018-09-29   977  
fce7a9744bdf3ba Yan, Zheng   2018-09-29   978  		req = ceph_osdc_new_request(osdc, &ci->i_layout,
7b8289467f2eaaf Jeff Layton  2021-01-28   979  					ci->i_vino, read_off, &read_len, 0, 1,
5020f1a5464bf0c Jeff Layton  2022-02-26   980  					CEPH_OSD_OP_SPARSE_READ, CEPH_OSD_FLAG_READ,
fce7a9744bdf3ba Yan, Zheng   2018-09-29   981  					NULL, ci->i_truncate_seq,
fce7a9744bdf3ba Yan, Zheng   2018-09-29   982  					ci->i_truncate_size, false);
fce7a9744bdf3ba Yan, Zheng   2018-09-29   983  		if (IS_ERR(req)) {
fce7a9744bdf3ba Yan, Zheng   2018-09-29   984  			ret = PTR_ERR(req);
fce7a9744bdf3ba Yan, Zheng   2018-09-29   985  			break;
fce7a9744bdf3ba Yan, Zheng   2018-09-29   986  		}
fce7a9744bdf3ba Yan, Zheng   2018-09-29   987  
7b8289467f2eaaf Jeff Layton  2021-01-28   988  		/* adjust len downward if the request truncated the len */
7b8289467f2eaaf Jeff Layton  2021-01-28   989  		if (off + len > read_off + read_len)
7b8289467f2eaaf Jeff Layton  2021-01-28   990  			len = read_off + read_len - off;
fce7a9744bdf3ba Yan, Zheng   2018-09-29   991  		more = len < iov_iter_count(to);
fce7a9744bdf3ba Yan, Zheng   2018-09-29   992  
7b8289467f2eaaf Jeff Layton  2021-01-28   993  		num_pages = calc_pages_for(read_off, read_len);
7b8289467f2eaaf Jeff Layton  2021-01-28   994  		page_off = offset_in_page(off);
fce7a9744bdf3ba Yan, Zheng   2018-09-29   995  		pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
fce7a9744bdf3ba Yan, Zheng   2018-09-29   996  		if (IS_ERR(pages)) {
fce7a9744bdf3ba Yan, Zheng   2018-09-29   997  			ceph_osdc_put_request(req);
fce7a9744bdf3ba Yan, Zheng   2018-09-29   998  			ret = PTR_ERR(pages);
fce7a9744bdf3ba Yan, Zheng   2018-09-29   999  			break;
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1000  		}
7ce469a53e7106a Yan, Zheng   2016-11-08  1001  
7b8289467f2eaaf Jeff Layton  2021-01-28  1002  		osd_req_op_extent_osd_data_pages(req, 0, pages, read_len,
7b8289467f2eaaf Jeff Layton  2021-01-28  1003  						 offset_in_page(read_off),
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1004  						 false, false);
cbe05f4053d9f2f Jeff Layton  2022-03-11  1005  		ihold(inode);
cbe05f4053d9f2f Jeff Layton  2022-03-11  1006  		req->r_inode = inode;
cbe05f4053d9f2f Jeff Layton  2022-03-11  1007  		req->r_pp = ceph_sparse_read_pp;
cbe05f4053d9f2f Jeff Layton  2022-03-11  1008  
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1009  		ret = ceph_osdc_start_request(osdc, req, false);
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1010  		if (!ret)
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1011  			ret = ceph_osdc_wait_request(osdc, req);
97e27aaa9a2cbd6 Xiubo Li     2020-03-19  1012  
8ae99ae2b40766a Xiubo Li     2021-03-22  1013  		ceph_update_read_metrics(&fsc->mdsc->metric,
97e27aaa9a2cbd6 Xiubo Li     2020-03-19  1014  					 req->r_start_latency,
97e27aaa9a2cbd6 Xiubo Li     2020-03-19  1015  					 req->r_end_latency,
7b8289467f2eaaf Jeff Layton  2021-01-28  1016  					 read_len, ret);
97e27aaa9a2cbd6 Xiubo Li     2020-03-19  1017  
cd6ba7d365023a0 Xiubo Li     2021-12-08  1018  		if (ret > 0)
cd6ba7d365023a0 Xiubo Li     2021-12-08  1019  			objver = req->r_version;
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1020  		ceph_osdc_put_request(req);
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1021  		i_size = i_size_read(inode);
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1022  		dout("sync_read %llu~%llu got %zd i_size %llu%s\n",
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1023  		     off, len, ret, i_size, (more ? " MORE" : ""));
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1024  
7b8289467f2eaaf Jeff Layton  2021-01-28  1025  		if (ret == -ENOENT) {
7b8289467f2eaaf Jeff Layton  2021-01-28  1026  			/* No object? Then this is a hole */
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1027  			ret = 0;
7b8289467f2eaaf Jeff Layton  2021-01-28  1028  		} else if (ret > 0 && IS_ENCRYPTED(inode)) {
7b8289467f2eaaf Jeff Layton  2021-01-28  1029  			int fret;
7b8289467f2eaaf Jeff Layton  2021-01-28  1030  
7b8289467f2eaaf Jeff Layton  2021-01-28  1031  			/* account for any partial block at the beginning */
7b8289467f2eaaf Jeff Layton  2021-01-28 @1032  			fret -= (off - read_off);
7b8289467f2eaaf Jeff Layton  2021-01-28  1033  
7b8289467f2eaaf Jeff Layton  2021-01-28  1034  			/*
7b8289467f2eaaf Jeff Layton  2021-01-28  1035  			 * Short read after big offset adjustment?
7b8289467f2eaaf Jeff Layton  2021-01-28  1036  			 * Nothing is usable, just call it a zero
7b8289467f2eaaf Jeff Layton  2021-01-28  1037  			 * len read.
7b8289467f2eaaf Jeff Layton  2021-01-28  1038  			 */
7b8289467f2eaaf Jeff Layton  2021-01-28  1039  			fret = max(fret, 0);
7b8289467f2eaaf Jeff Layton  2021-01-28  1040  
7b8289467f2eaaf Jeff Layton  2021-01-28  1041  			/* account for partial block at the end */
7b8289467f2eaaf Jeff Layton  2021-01-28  1042  			ret = min_t(ssize_t, fret, len);
7b8289467f2eaaf Jeff Layton  2021-01-28  1043  		}
7b8289467f2eaaf Jeff Layton  2021-01-28  1044  
7b8289467f2eaaf Jeff Layton  2021-01-28  1045  		/* Short read but not EOF? Zero out the remainder. */
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1046  		if (ret >= 0 && ret < len && (off + ret < i_size)) {
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1047  			int zlen = min(len - ret, i_size - off - ret);
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1048  			int zoff = page_off + ret;
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1049  			dout("sync_read zero gap %llu~%llu\n",
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1050  			     off + ret, off + ret + zlen);
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1051  			ceph_zero_page_vector_range(zoff, zlen, pages);
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1052  			ret += zlen;
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1053  		}
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1054  
c5f575ed08c38d0 Jeff Layton  2020-08-21  1055  		idx = 0;
c5f575ed08c38d0 Jeff Layton  2020-08-21  1056  		left = ret > 0 ? ret : 0;
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1057  		while (left > 0) {
7b8289467f2eaaf Jeff Layton  2021-01-28  1058  			size_t plen, copied;
7b8289467f2eaaf Jeff Layton  2021-01-28  1059  			plen = min_t(size_t, left, PAGE_SIZE - page_off);
c5f575ed08c38d0 Jeff Layton  2020-08-21  1060  			SetPageUptodate(pages[idx]);
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1061  			copied = copy_page_to_iter(pages[idx++],
7b8289467f2eaaf Jeff Layton  2021-01-28  1062  						   page_off, plen, to);
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1063  			off += copied;
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1064  			left -= copied;
7b8289467f2eaaf Jeff Layton  2021-01-28  1065  			page_off = 0;
7b8289467f2eaaf Jeff Layton  2021-01-28  1066  			if (copied < plen) {
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1067  				ret = -EFAULT;
8eb4efb091c8d8f majianpeng   2013-09-26  1068  				break;
8eb4efb091c8d8f majianpeng   2013-09-26  1069  			}
8eb4efb091c8d8f majianpeng   2013-09-26  1070  		}
124e68e74099090 Sage Weil    2009-10-06  1071  		ceph_release_page_vector(pages, num_pages);
8eb4efb091c8d8f majianpeng   2013-09-26  1072  
131d7eb4faa1fc0 Yan, Zheng   2019-07-25  1073  		if (ret < 0) {
0b98acd61883093 Ilya Dryomov 2020-09-14  1074  			if (ret == -EBLOCKLISTED)
0b98acd61883093 Ilya Dryomov 2020-09-14  1075  				fsc->blocklisted = true;
131d7eb4faa1fc0 Yan, Zheng   2019-07-25  1076  			break;
131d7eb4faa1fc0 Yan, Zheng   2019-07-25  1077  		}
131d7eb4faa1fc0 Yan, Zheng   2019-07-25  1078  
131d7eb4faa1fc0 Yan, Zheng   2019-07-25  1079  		if (off >= i_size || !more)
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1080  			break;
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1081  	}
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1082  
7b8289467f2eaaf Jeff Layton  2021-01-28  1083  	if (ret > 0) {
1c3b32d36296389 Xiubo Li     2021-11-05  1084  		if (off > *ki_pos) {
c3d8e0b5de487a7 Xiubo Li     2021-10-30  1085  			if (off >= i_size) {
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1086  				*retry_op = CHECK_EOF;
1c3b32d36296389 Xiubo Li     2021-11-05  1087  				ret = i_size - *ki_pos;
1c3b32d36296389 Xiubo Li     2021-11-05  1088  				*ki_pos = i_size;
c3d8e0b5de487a7 Xiubo Li     2021-10-30  1089  			} else {
1c3b32d36296389 Xiubo Li     2021-11-05  1090  				ret = off - *ki_pos;
1c3b32d36296389 Xiubo Li     2021-11-05  1091  				*ki_pos = off;
8eb4efb091c8d8f majianpeng   2013-09-26  1092  			}
c3d8e0b5de487a7 Xiubo Li     2021-10-30  1093  		}
8eb4efb091c8d8f majianpeng   2013-09-26  1094  
7b8289467f2eaaf Jeff Layton  2021-01-28  1095  		if (last_objver)
cd6ba7d365023a0 Xiubo Li     2021-12-08  1096  			*last_objver = objver;
7b8289467f2eaaf Jeff Layton  2021-01-28  1097  	}
fce7a9744bdf3ba Yan, Zheng   2018-09-29  1098  	dout("sync_read result %zd retry_op %d\n", ret, *retry_op);
124e68e74099090 Sage Weil    2009-10-06  1099  	return ret;
124e68e74099090 Sage Weil    2009-10-06  1100  }
124e68e74099090 Sage Weil    2009-10-06  1101  

:::::: The code at line 1032 was first introduced by commit
:::::: 7b8289467f2eaafe662a32ddc148c8302b4c1ef6 ceph: plumb in decryption during sync reads

:::::: TO: Jeff Layton <jlayton@kernel.org>
:::::: CC: Jeff Layton <jlayton@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
