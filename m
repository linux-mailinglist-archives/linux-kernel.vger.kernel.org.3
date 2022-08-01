Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0858621B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 03:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbiHABCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 21:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiHABCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 21:02:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9550B11469
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 18:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659315727; x=1690851727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aLneOQk6oCRAyT1JaL97eQtx9S06S+0MJ/BWaEHOme4=;
  b=QEfMlNXi8GYLtgv6Wry0wv8K3mbl/DcKfd1nrfKhte9yC8Galwte2hik
   /6d+rXU05YiItcA3RY/Bzdv8+ruxqYrEMLADAFsw9plut5YqkOt0Vo2Nn
   C+Lcuy6AsFqnOd2mEVwuPZraKj0yt4V04miiLD2gcPXiZleZeKwmsqTxy
   dr1dE0D2Q1XjAQdnJ4mRtzz9wUW+2oqMAAzbSPH807dhjOyqyxPJw/rCa
   GqyYH0pYfwibuOJ7SscIqLEKu6nyfUxA+Oa3bT0dZuDr5kejH73gjyZ6C
   9kj+fNngFdlyhSl621cqjXDDZEHc4veFkpFZ9c6TCxQ4YjMW5tl0vqSPN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="314859242"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="314859242"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 18:02:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="847666320"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jul 2022 18:02:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIJop-000Efr-2v;
        Mon, 01 Aug 2022 01:02:03 +0000
Date:   Mon, 1 Aug 2022 09:01:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] fs/isofs: Replace kmap() with kmap_local_page()
Message-ID: <202208010804.HdlHVBnW-lkp@intel.com>
References: <20220731190101.7928-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731190101.7928-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Fabio,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jack-fs/for_next]
[also build test WARNING on akpm-mm/mm-everything linus/master v5.19 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/fs-isofs-Replace-kmap-with-kmap_local_page/20220801-030233
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
config: nios2-randconfig-s043-20220731 (https://download.01.org/0day-ci/archive/20220801/202208010804.HdlHVBnW-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/7c25888be273e928336283deae5b57f8ffa78a50
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Fabio-M-De-Francesco/fs-isofs-Replace-kmap-with-kmap_local_page/20220801-030233
        git checkout 7c25888be273e928336283deae5b57f8ffa78a50
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash fs/isofs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> fs/isofs/compress.c:178:45: sparse: sparse: incompatible types in comparison expression (different signedness):
>> fs/isofs/compress.c:178:45: sparse:    unsigned char [usertype] *
>> fs/isofs/compress.c:178:45: sparse:    char *
   fs/isofs/compress.c:189:48: sparse: sparse: incompatible types in comparison expression (different signedness):
   fs/isofs/compress.c:189:48: sparse:    unsigned char [usertype] *
   fs/isofs/compress.c:189:48: sparse:    char *

vim +178 fs/isofs/compress.c

    34	
    35	/*
    36	 * Read data of @inode from @block_start to @block_end and uncompress
    37	 * to one zisofs block. Store the data in the @pages array with @pcount
    38	 * entries. Start storing at offset @poffset of the first page.
    39	 */
    40	static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
    41					      loff_t block_end, int pcount,
    42					      struct page **pages, unsigned poffset,
    43					      int *errp)
    44	{
    45		unsigned int zisofs_block_shift = ISOFS_I(inode)->i_format_parm[1];
    46		unsigned int bufsize = ISOFS_BUFFER_SIZE(inode);
    47		unsigned int bufshift = ISOFS_BUFFER_BITS(inode);
    48		unsigned int bufmask = bufsize - 1;
    49		int i, block_size = block_end - block_start;
    50		z_stream stream = { .total_out = 0,
    51				    .avail_in = 0,
    52				    .avail_out = 0, };
    53		int zerr;
    54		int needblocks = (block_size + (block_start & bufmask) + bufmask)
    55					>> bufshift;
    56		int haveblocks;
    57		blkcnt_t blocknum;
    58		struct buffer_head **bhs;
    59		int curbh, curpage;
    60	
    61		if (block_size > deflateBound(1UL << zisofs_block_shift)) {
    62			*errp = -EIO;
    63			return 0;
    64		}
    65		/* Empty block? */
    66		if (block_size == 0) {
    67			for ( i = 0 ; i < pcount ; i++ ) {
    68				if (!pages[i])
    69					continue;
    70				memzero_page(pages[i], 0, PAGE_SIZE);
    71				SetPageUptodate(pages[i]);
    72			}
    73			return ((loff_t)pcount) << PAGE_SHIFT;
    74		}
    75	
    76		/* Because zlib is not thread-safe, do all the I/O at the top. */
    77		blocknum = block_start >> bufshift;
    78		bhs = kcalloc(needblocks + 1, sizeof(*bhs), GFP_KERNEL);
    79		if (!bhs) {
    80			*errp = -ENOMEM;
    81			return 0;
    82		}
    83		haveblocks = isofs_get_blocks(inode, blocknum, bhs, needblocks);
    84		ll_rw_block(REQ_OP_READ, 0, haveblocks, bhs);
    85	
    86		curbh = 0;
    87		curpage = 0;
    88		/*
    89		 * First block is special since it may be fractional.  We also wait for
    90		 * it before grabbing the zlib mutex; odds are that the subsequent
    91		 * blocks are going to come in in short order so we don't hold the zlib
    92		 * mutex longer than necessary.
    93		 */
    94	
    95		if (!bhs[0])
    96			goto b_eio;
    97	
    98		wait_on_buffer(bhs[0]);
    99		if (!buffer_uptodate(bhs[0])) {
   100			*errp = -EIO;
   101			goto b_eio;
   102		}
   103	
   104		stream.workspace = zisofs_zlib_workspace;
   105		mutex_lock(&zisofs_zlib_lock);
   106			
   107		zerr = zlib_inflateInit(&stream);
   108		if (zerr != Z_OK) {
   109			if (zerr == Z_MEM_ERROR)
   110				*errp = -ENOMEM;
   111			else
   112				*errp = -EIO;
   113			printk(KERN_DEBUG "zisofs: zisofs_inflateInit returned %d\n",
   114				       zerr);
   115			goto z_eio;
   116		}
   117	
   118		while (curpage < pcount && curbh < haveblocks &&
   119		       zerr != Z_STREAM_END) {
   120			if (!stream.avail_out) {
   121				if (pages[curpage]) {
   122					stream.next_out = kmap_local_page(pages[curpage])
   123							+ poffset;
   124					stream.avail_out = PAGE_SIZE - poffset;
   125					poffset = 0;
   126				} else {
   127					stream.next_out = (void *)&zisofs_sink_page;
   128					stream.avail_out = PAGE_SIZE;
   129				}
   130			}
   131			if (!stream.avail_in) {
   132				wait_on_buffer(bhs[curbh]);
   133				if (!buffer_uptodate(bhs[curbh])) {
   134					*errp = -EIO;
   135					break;
   136				}
   137				stream.next_in  = bhs[curbh]->b_data +
   138							(block_start & bufmask);
   139				stream.avail_in = min_t(unsigned, bufsize -
   140							(block_start & bufmask),
   141							block_size);
   142				block_size -= stream.avail_in;
   143				block_start = 0;
   144			}
   145	
   146			while (stream.avail_out && stream.avail_in) {
   147				zerr = zlib_inflate(&stream, Z_SYNC_FLUSH);
   148				if (zerr == Z_BUF_ERROR && stream.avail_in == 0)
   149					break;
   150				if (zerr == Z_STREAM_END)
   151					break;
   152				if (zerr != Z_OK) {
   153					/* EOF, error, or trying to read beyond end of input */
   154					if (zerr == Z_MEM_ERROR)
   155						*errp = -ENOMEM;
   156					else {
   157						printk(KERN_DEBUG
   158						       "zisofs: zisofs_inflate returned"
   159						       " %d, inode = %lu,"
   160						       " page idx = %d, bh idx = %d,"
   161						       " avail_in = %ld,"
   162						       " avail_out = %ld\n",
   163						       zerr, inode->i_ino, curpage,
   164						       curbh, stream.avail_in,
   165						       stream.avail_out);
   166						*errp = -EIO;
   167					}
   168					goto inflate_out;
   169				}
   170			}
   171	
   172			if (!stream.avail_out) {
   173				/* This page completed */
   174				if (pages[curpage]) {
   175					flush_dcache_page(pages[curpage]);
   176					SetPageUptodate(pages[curpage]);
   177				}
 > 178				if (stream.next_out != (char *)zisofs_sink_page) {
   179					kunmap_local(stream.next_out);
   180					stream.next_out = NULL;
   181				}
   182				curpage++;
   183			}
   184			if (!stream.avail_in)
   185				curbh++;
   186		}
   187	inflate_out:
   188		zlib_inflateEnd(&stream);
   189		if (stream.next_out && stream.next_out != (char *)zisofs_sink_page)
   190			kunmap_local(stream.next_out);
   191	
   192	z_eio:
   193		mutex_unlock(&zisofs_zlib_lock);
   194	
   195	b_eio:
   196		for (i = 0; i < haveblocks; i++)
   197			brelse(bhs[i]);
   198		kfree(bhs);
   199		return stream.total_out;
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
