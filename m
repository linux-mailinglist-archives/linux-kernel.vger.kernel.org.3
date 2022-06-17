Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF8D54EF95
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379963AbiFQDGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 23:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379936AbiFQDGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:06:48 -0400
Received: from p3plwbeout16-04.prod.phx3.secureserver.net (p3plsmtp16-04-2.prod.phx3.secureserver.net [173.201.193.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A39663C3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:06:46 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id 22JpogyhEGLmT22Jpo2mxi; Thu, 16 Jun 2022 20:06:46 -0700
X-CMAE-Analysis: v=2.4 cv=V5S4bcri c=1 sm=1 tr=0 ts=62abefc6
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=JfrnYn6hAAAA:8
 a=cm27Pg_UAAAA:8 a=FXvPX3liAAAA:8 a=t7CeM3EgAAAA:8 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=fkwhclkGT6zG_8sy5TwA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22 a=UObqyxdv-6Yh2QiB9mM_:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  22JpogyhEGLmT
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp05.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1o22Jo-0006fY-5k; Fri, 17 Jun 2022 04:06:44 +0100
Message-ID: <f532bf0c-8944-7197-88f8-cd5433ef48d9@squashfs.org.uk>
Date:   Fri, 17 Jun 2022 04:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 3/3] squashfs: implement readahead
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
References: <20220613082802.1301238-1-hsinyi@chromium.org>
 <20220613082802.1301238-4-hsinyi@chromium.org>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20220613082802.1301238-4-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfBhQD4mm0pi40dEMfMz0tD3YZiFDcV/3mUL9GOrgnaUr5Gx0ll5oI9e3izanj2y9RtkFLMENFTolLUL12XzSGiFMJ2CGohiLhYYnBiQyo2UNWy5iMrQ6
 p2QxRq/3kJOkLdzJT4mr7y5OEeNxvi8awKWO5wJwOTBibnqp2zOvbc/axvcVkhKcUjMjcvABG5R1vqcIz8+N4J4yF7PWsqY47t4=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2022 09:28, Hsin-Yi Wang wrote:
> Implement readahead callback for squashfs. It will read datablocks
> which cover pages in readahead request. For a few cases it will
> not mark page as uptodate, including:
> - file end is 0.
> - zero filled blocks.
> - current batch of pages isn't in the same datablock.
> - decompressor error.
> Otherwise pages will be marked as uptodate. The unhandled pages will be
> updated by readpage later.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> v5->v6:
> - use the new squashfs_page_actor_init_special() to handle short file
>    cases as well.

Hi Hsin-Yi,

Thanks for adding the improved page actor support to your patch.

There is currently another problem with the patch, which is it
doesn't handle fragments.

Normally a file (using Mksquashfs defaults) will consist of either:

1. A fragment, stored inside a fragment block, if the file is less
    than the block size, OR

2. One or more datablocks, if the file is greater than the block size.

Your readahead patch handles datablocks, and ignores any file less than
block size by the lines

 > +	if (file_end == 0)
 > +		return;

So in theory the readahead function doesn't have to handle fragments
stored in fragment blocks.

But you can tell Mksquashfs to pack the file tailend into a fragment
block, using the -tailends (or -always-use-fragments) option.

Here, you will get a file which has one or more datablocks, and the last
datablock will be stored in a fragment block.

The readahead code has to handle this, and it is easy to show the code
doesn't by building a filesystem with that option.

I have written a function which can be called to do the work.  This I 
have posted here as a patch.

https://lore.kernel.org/all/20220617030345.24712-1-phillip@squashfs.org.uk/

Obviously, now that fragment blocks are supported, readahead can be
supported for files less than the block size too.

The diff to update the readahead code to use the new function is

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 1e28fcc22640..aae76de72e2d 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -548,9 +548,6 @@ static void squashfs_readahead(struct 
readahead_control *ractl)

         readahead_expand(ractl, start, (len | mask) + 1);

-       if (file_end == 0)
-               return;
-
         pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
         if (!pages)
                 return;
@@ -576,6 +573,14 @@ static void squashfs_readahead(struct 
readahead_control *ractl)
                            (i_size_read(inode) & (msblk->block_size - 1)) :
                             msblk->block_size;

+               if (index == file_end && 
squashfs_i(inode)->fragment_block !=
+                                       SQUASHFS_INVALID_BLK) {
+                       res = squashfs_readahead_fragment(pages, 
nr_pages, expected);
+                       if (res)
+                               goto skip_pages;
+                       continue;
+               }
+
                 bsize = read_blocklist(inode, index, &block);
                 if (bsize == 0)
                         goto skip_pages;
--
2.34.1



> - use memzero_page().
> 
> v5:
> https://lore.kernel.org/lkml/20220606150305.1883410-4-hsinyi@chromium.org/
> v4:
> https://lore.kernel.org/lkml/20220601103922.1338320-4-hsinyi@chromium.org/
> v3:
> https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.org/
> v2:
> https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
> v1:
> https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
> ---
>   fs/squashfs/file.c | 92 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 7f0904b203294..f0c64ee272d5d 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -39,6 +39,7 @@
>   #include "squashfs_fs_sb.h"
>   #include "squashfs_fs_i.h"
>   #include "squashfs.h"
> +#include "page_actor.h"
>   
>   /*
>    * Locate cache slot in range [offset, index] for specified inode.  If
> @@ -496,7 +497,96 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>   	return res;
>   }
>   
> +static void squashfs_readahead(struct readahead_control *ractl)
> +{
> +	struct inode *inode = ractl->mapping->host;
> +	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> +	size_t mask = (1UL << msblk->block_log) - 1;
> +	unsigned short shift = msblk->block_log - PAGE_SHIFT;
> +	loff_t start = readahead_pos(ractl) & ~mask;
> +	size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> +	struct squashfs_page_actor *actor;
> +	unsigned int nr_pages = 0;
> +	struct page **pages;
> +	int i, file_end = i_size_read(inode) >> msblk->block_log;
> +	unsigned int max_pages = 1UL << shift;
> +
> +	readahead_expand(ractl, start, (len | mask) + 1);
> +
> +	if (file_end == 0)
> +		return;
> +
> +	pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
> +	if (!pages)
> +		return;
> +
> +	for (;;) {
> +		pgoff_t index;
> +		int res, bsize;
> +		u64 block = 0;
> +		unsigned int expected;
> +
> +		nr_pages = __readahead_batch(ractl, pages, max_pages);
> +		if (!nr_pages)
> +			break;
> +
> +		if (readahead_pos(ractl) >= i_size_read(inode))
> +			goto skip_pages;
> +
> +		index = pages[0]->index >> shift;
> +		if ((pages[nr_pages - 1]->index >> shift) != index)
> +			goto skip_pages;
> +
> +		expected = index == file_end ?
> +			   (i_size_read(inode) & (msblk->block_size - 1)) :
> +			    msblk->block_size;
> +
> +		bsize = read_blocklist(inode, index, &block);
> +		if (bsize == 0)
> +			goto skip_pages;
> +
> +		actor = squashfs_page_actor_init_special(msblk, pages, nr_pages,
> +							 expected);
> +		if (!actor)
> +			goto skip_pages;
> +
> +		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
> +
> +		kfree(actor);
> +
> +		if (res == expected) {
> +			int bytes;
> +
> +			/* Last page (if present) may have trailing bytes not filled */
> +			bytes = res % PAGE_SIZE;
> +			if (pages[nr_pages - 1]->index == file_end && bytes)
> +				memzero_page(pages[nr_pages - 1], bytes,
> +					     PAGE_SIZE - bytes);
> +
> +			for (i = 0; i < nr_pages; i++) {
> +				flush_dcache_page(pages[i]);
> +				SetPageUptodate(pages[i]);
> +			}
> +		}
> +
> +		for (i = 0; i < nr_pages; i++) {
> +			unlock_page(pages[i]);
> +			put_page(pages[i]);
> +		}
> +	}
> +
> +	kfree(pages);
> +	return;
> +
> +skip_pages:
> +	for (i = 0; i < nr_pages; i++) {
> +		unlock_page(pages[i]);
> +		put_page(pages[i]);
> +	}
> +	kfree(pages);
> +}
>   
>   const struct address_space_operations squashfs_aops = {
> -	.read_folio = squashfs_read_folio
> +	.read_folio = squashfs_read_folio,
> +	.readahead = squashfs_readahead
>   };

