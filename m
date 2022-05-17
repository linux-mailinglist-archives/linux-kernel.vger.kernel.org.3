Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7C8529859
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiEQDkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiEQDkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:40:39 -0400
Received: from p3plwbeout26-03.prod.phx3.secureserver.net (p3plsmtp26-03-2.prod.phx3.secureserver.net [216.69.139.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B79146653
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:40:37 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id qo4anPay8SaPdqo4bnDN6K; Mon, 16 May 2022 20:40:37 -0700
X-CMAE-Analysis: v=2.4 cv=XcVMcK15 c=1 sm=1 tr=0 ts=62831935
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=anyJmfQTAAAA:8
 a=NEAV23lmAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=i-5SCMXTAAAA:20
 a=7XGxkfBbjmLJC-YlxtgA:9 a=QEXdDO2ut3YA:10 a=YJ_ntbLOlx1v6PCnmBeL:22
 a=mmqRlSCDY2ywfjPLJ4af:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  qo4anPay8SaPd
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp10.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nqo4Z-00039O-7W; Tue, 17 May 2022 04:40:36 +0100
Message-ID: <33ebeb79-c428-8920-35e3-712f9db6eb28@squashfs.org.uk>
Date:   Tue, 17 May 2022 04:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] squashfs: implement readahead
To:     kernel test robot <lkp@intel.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
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
References: <20220516105100.1412740-3-hsinyi@chromium.org>
 <202205162245.LVgJF5HH-lkp@intel.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <202205162245.LVgJF5HH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfNtiRXC2i0AuUHIAqMKa0ErJuRwC3Law8mcUb9xXOnV3PGSuNUWZmJSiQQrriQkZO9to7+xPQRA+w6r0bx8pQVZwRNiSrQrgJDycJGhl7PaQdMr6Fh7Z
 OWpY7QOB41hSTEdr27fKKeWAeEz1KPEdaIq5wLnt6SX0Bn+G2zOi6A8h6vJ57/sG0BUjpDwuAXbnIgEuSxXpcSMh8qnlRw3322Q=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 15:21, kernel test robot wrote:
> Hi Hsin-Yi,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on next-20220513]
> [cannot apply to akpm-mm/mm-everything v5.18-rc7 v5.18-rc6 v5.18-rc5 v5.18-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 

This is fixed by

[PATCH 3/2] squashfs: always build "file direct" version of page actor

Which I have just sent.

Phillip

> url:    https://github.com/intel-lab-lkp/linux/commits/Hsin-Yi-Wang/Implement-readahead-for-squashfs/20220516-185438
> base:    1e1b28b936aed946122b4e0991e7144fdbbfd77e
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220516/202205162245.LVgJF5HH-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/573e1f2ced0df097c30c595d5bf5a9e7a5fcb8d5
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Hsin-Yi-Wang/Implement-readahead-for-squashfs/20220516-185438
>          git checkout 573e1f2ced0df097c30c595d5bf5a9e7a5fcb8d5
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/squashfs/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     fs/squashfs/file.c: In function 'squashfs_readahead':
>     fs/squashfs/file.c:526:17: error: implicit declaration of function 'squashfs_page_actor_init_special'; did you mean 'squashfs_page_actor_init'? [-Werror=implicit-function-declaration]
>       526 |         actor = squashfs_page_actor_init_special(pages, max_pages, 0);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                 squashfs_page_actor_init
>>> fs/squashfs/file.c:526:15: warning: assignment to 'struct squashfs_page_actor *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>       526 |         actor = squashfs_page_actor_init_special(pages, max_pages, 0);
>           |               ^
>     fs/squashfs/file.c: At top level:
>     fs/squashfs/file.c:577:9: error: request for member 'readahead' in something not a structure or union
>       577 |         .readahead = squashfs_readahead
>           |         ^
>     cc1: some warnings being treated as errors
> 
> 
> vim +526 fs/squashfs/file.c
> 
>     498	
>     499	static void squashfs_readahead(struct readahead_control *ractl)
>     500	{
>     501		struct inode *inode = ractl->mapping->host;
>     502		struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>     503		size_t mask = (1UL << msblk->block_log) - 1;
>     504		size_t shift = msblk->block_log - PAGE_SHIFT;
>     505		loff_t req_end = readahead_pos(ractl) + readahead_length(ractl);
>     506		loff_t start = readahead_pos(ractl) &~ mask;
>     507		size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
>     508		struct squashfs_page_actor *actor;
>     509		unsigned int nr_pages = 0;
>     510		struct page **pages;
>     511		u64 block = 0;
>     512		int bsize, res, i, index;
>     513		int file_end = i_size_read(inode) >> msblk->block_log;
>     514		unsigned int max_pages = 1UL << shift;
>     515	
>     516		readahead_expand(ractl, start, (len | mask) + 1);
>     517	
>     518		if (readahead_pos(ractl) + readahead_length(ractl) < req_end ||
>     519		    file_end == 0)
>     520			return;
>     521	
>     522		pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
>     523		if (!pages)
>     524			return;
>     525	
>   > 526		actor = squashfs_page_actor_init_special(pages, max_pages, 0);
>     527		if (!actor)
>     528			goto out;
>     529	
>     530		for (;;) {
>     531			nr_pages = __readahead_batch(ractl, pages, max_pages);
>     532			if (!nr_pages)
>     533				break;
>     534	
>     535			if (readahead_pos(ractl) >= i_size_read(inode) ||
>     536			    nr_pages < max_pages)
>     537				goto skip_pages;
>     538	
>     539			index = pages[0]->index >> shift;
>     540			if ((pages[nr_pages - 1]->index >> shift) != index)
>     541				goto skip_pages;
>     542	
>     543			bsize = read_blocklist(inode, index, &block);
>     544			if (bsize == 0)
>     545				goto skip_pages;
>     546	
>     547			res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
>     548						 actor);
>     549	
>     550			if (res >= 0)
>     551				for (i = 0; i < nr_pages; i++)
>     552					SetPageUptodate(pages[i]);
>     553	
>     554			for (i = 0; i < nr_pages; i++) {
>     555				unlock_page(pages[i]);
>     556				put_page(pages[i]);
>     557			}
>     558		}
>     559	
>     560		kfree(actor);
>     561		kfree(pages);
>     562		return;
>     563	
>     564	skip_pages:
>     565		for (i = 0; i < nr_pages; i++) {
>     566			unlock_page(pages[i]);
>     567			put_page(pages[i]);
>     568		}
>     569	
>     570		kfree(actor);
>     571	out:
>     572		kfree(pages);
>     573	}
>     574	
> 

