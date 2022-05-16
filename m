Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE75C5286D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbiEPOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiEPOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:22:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699841EADB
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652710955; x=1684246955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DEXNUePlUH324Ru0ZGL3Smq6hYqkFrrSzw/mQFjXSHc=;
  b=Fe3qItPi5fO3uckK4nn95knTotYpJvV9vp9fQhemXanBAIhdo1nMYZY/
   dATyFg2M/qKzDbXUu16vBwPWKmLYQ/0vpcrcvqcu1BDw+AWYerSj12eG7
   HCGakft/ftPIFbTURd+JRsJtAv57RhPpS0Q4TA+SjYTBzxqcy+jlSRWLE
   fjIf2XRfeNg3Q7gTTdmcInrq6agh0wrm0rNsoPf3KnqB7s2C+ZSL7Nubg
   WlTvjfrL8Xc7Ir+Bz/27ZXn1uY4f4iHYP0GBDyJBkajhGehG+itLlOznz
   OSjzPIHLMthYRAlQU/Zr7i7di/GT1Jk8MXsXEjnVhraJXBbSYCTG4E/0z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="269673600"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="269673600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 07:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="713390768"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2022 07:22:31 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqbcF-00005V-3h;
        Mon, 16 May 2022 14:22:31 +0000
Date:   Mon, 16 May 2022 22:21:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>
Cc:     kbuild-all@lists.01.org, Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] squashfs: implement readahead
Message-ID: <202205162245.LVgJF5HH-lkp@intel.com>
References: <20220516105100.1412740-3-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516105100.1412740-3-hsinyi@chromium.org>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220513]
[cannot apply to akpm-mm/mm-everything v5.18-rc7 v5.18-rc6 v5.18-rc5 v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Hsin-Yi-Wang/Implement-readahead-for-squashfs/20220516-185438
base:    1e1b28b936aed946122b4e0991e7144fdbbfd77e
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220516/202205162245.LVgJF5HH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/573e1f2ced0df097c30c595d5bf5a9e7a5fcb8d5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hsin-Yi-Wang/Implement-readahead-for-squashfs/20220516-185438
        git checkout 573e1f2ced0df097c30c595d5bf5a9e7a5fcb8d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/squashfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/squashfs/file.c: In function 'squashfs_readahead':
   fs/squashfs/file.c:526:17: error: implicit declaration of function 'squashfs_page_actor_init_special'; did you mean 'squashfs_page_actor_init'? [-Werror=implicit-function-declaration]
     526 |         actor = squashfs_page_actor_init_special(pages, max_pages, 0);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 squashfs_page_actor_init
>> fs/squashfs/file.c:526:15: warning: assignment to 'struct squashfs_page_actor *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     526 |         actor = squashfs_page_actor_init_special(pages, max_pages, 0);
         |               ^
   fs/squashfs/file.c: At top level:
   fs/squashfs/file.c:577:9: error: request for member 'readahead' in something not a structure or union
     577 |         .readahead = squashfs_readahead
         |         ^
   cc1: some warnings being treated as errors


vim +526 fs/squashfs/file.c

   498	
   499	static void squashfs_readahead(struct readahead_control *ractl)
   500	{
   501		struct inode *inode = ractl->mapping->host;
   502		struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
   503		size_t mask = (1UL << msblk->block_log) - 1;
   504		size_t shift = msblk->block_log - PAGE_SHIFT;
   505		loff_t req_end = readahead_pos(ractl) + readahead_length(ractl);
   506		loff_t start = readahead_pos(ractl) &~ mask;
   507		size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
   508		struct squashfs_page_actor *actor;
   509		unsigned int nr_pages = 0;
   510		struct page **pages;
   511		u64 block = 0;
   512		int bsize, res, i, index;
   513		int file_end = i_size_read(inode) >> msblk->block_log;
   514		unsigned int max_pages = 1UL << shift;
   515	
   516		readahead_expand(ractl, start, (len | mask) + 1);
   517	
   518		if (readahead_pos(ractl) + readahead_length(ractl) < req_end ||
   519		    file_end == 0)
   520			return;
   521	
   522		pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
   523		if (!pages)
   524			return;
   525	
 > 526		actor = squashfs_page_actor_init_special(pages, max_pages, 0);
   527		if (!actor)
   528			goto out;
   529	
   530		for (;;) {
   531			nr_pages = __readahead_batch(ractl, pages, max_pages);
   532			if (!nr_pages)
   533				break;
   534	
   535			if (readahead_pos(ractl) >= i_size_read(inode) ||
   536			    nr_pages < max_pages)
   537				goto skip_pages;
   538	
   539			index = pages[0]->index >> shift;
   540			if ((pages[nr_pages - 1]->index >> shift) != index)
   541				goto skip_pages;
   542	
   543			bsize = read_blocklist(inode, index, &block);
   544			if (bsize == 0)
   545				goto skip_pages;
   546	
   547			res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
   548						 actor);
   549	
   550			if (res >= 0)
   551				for (i = 0; i < nr_pages; i++)
   552					SetPageUptodate(pages[i]);
   553	
   554			for (i = 0; i < nr_pages; i++) {
   555				unlock_page(pages[i]);
   556				put_page(pages[i]);
   557			}
   558		}
   559	
   560		kfree(actor);
   561		kfree(pages);
   562		return;
   563	
   564	skip_pages:
   565		for (i = 0; i < nr_pages; i++) {
   566			unlock_page(pages[i]);
   567			put_page(pages[i]);
   568		}
   569	
   570		kfree(actor);
   571	out:
   572		kfree(pages);
   573	}
   574	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
