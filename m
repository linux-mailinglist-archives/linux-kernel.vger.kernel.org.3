Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D2753F4C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbiFGD7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbiFGD7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:59:36 -0400
Received: from p3plwbeout24-06.prod.phx3.secureserver.net (p3plsmtp24-06-2.prod.phx3.secureserver.net [68.178.252.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2564557B1E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:59:33 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id yQNPnjwKlzpSYyQNQnNUrC; Mon, 06 Jun 2022 20:59:32 -0700
X-CMAE-Analysis: v=2.4 cv=QtCbYX+d c=1 sm=1 tr=0 ts=629ecd24
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=JfrnYn6hAAAA:8
 a=cm27Pg_UAAAA:8 a=FXvPX3liAAAA:8 a=t7CeM3EgAAAA:8 a=hD80L64hAAAA:8
 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=5-cV24NVlsSd070NXMcA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22 a=UObqyxdv-6Yh2QiB9mM_:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  yQNPnjwKlzpSY
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp12.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nyQNN-0002Hk-5Y; Tue, 07 Jun 2022 04:59:31 +0100
Message-ID: <81b1828d-37d3-5b05-410e-7e931d966ed8@squashfs.org.uk>
Date:   Tue, 7 Jun 2022 04:59:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 3/3] squashfs: implement readahead
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
References: <20220606150305.1883410-1-hsinyi@chromium.org>
 <20220606150305.1883410-4-hsinyi@chromium.org>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20220606150305.1883410-4-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfKhZUBqmB4V2HF6ZN7OgJt1LQ7pIfjL+JE0ueKopFSDAS8EbBEGEx+UmXHJqME5cNeFQjwrutC4W7ZILo7WvphwMZCBKvUIM+scug/ASMpnVC3N/j0hZ
 8Hp2gaUP1YDBg0octJ6EB5nE1qBLcEkT3KnPRkT8qP6hOAUOpfrlFQO19hx8K6Z22ePS6uYcSms4SOelx9RTyFGJiBYDdsnrXdI=
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 16:03, Hsin-Yi Wang wrote:
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
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> v4->v5:
> - Handle short file cases reported by Marek and Matthew.
> - Fix checkpatch error reported by Andrew.

Thanks for the updated patch.  I'm currently testing and
reviewing the patch, and this may take a couple of days.

Phillip

> 
> v4: https://lore.kernel.org/lkml/20220601103922.1338320-4-hsinyi@chromium.org/
> v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.org/
> v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
> ---
>   fs/squashfs/file.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 123 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index a8e495d8eb86..fbd096cd15f4 100644
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
> @@ -495,7 +496,128 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>   	return 0;
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
> +	actor = squashfs_page_actor_init_special(pages, max_pages, 0);
> +	if (!actor)
> +		goto out;
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
> +		if (nr_pages < max_pages) {
> +			struct squashfs_cache_entry *buffer;
> +			unsigned int block_mask = max_pages - 1;
> +			int offset = pages[0]->index - (pages[0]->index & ~block_mask);
> +
> +			buffer = squashfs_get_datablock(inode->i_sb, block,
> +							bsize);
> +			if (buffer->error) {
> +				squashfs_cache_put(buffer);
> +				goto skip_pages;
> +			}
> +
> +			expected -= offset * PAGE_SIZE;
> +			for (i = 0; i < nr_pages && expected > 0; i++,
> +						expected -= PAGE_SIZE, offset++) {
> +				int avail = min_t(int, expected, PAGE_SIZE);
> +
> +				squashfs_fill_page(pages[i], buffer,
> +						offset * PAGE_SIZE, avail);
> +				unlock_page(pages[i]);
> +			}
> +
> +			squashfs_cache_put(buffer);
> +			continue;
> +		}
> +
> +		res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
> +					 actor);
> +
> +		if (res == expected) {
> +			int bytes;
> +
> +			/* Last page may have trailing bytes not filled */
> +			bytes = res % PAGE_SIZE;
> +			if (bytes) {
> +				void *pageaddr;
> +
> +				pageaddr = kmap_atomic(pages[nr_pages - 1]);
> +				memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> +				kunmap_atomic(pageaddr);
> +			}
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
> +	kfree(actor);
> +	kfree(pages);
> +	return;
> +
> +skip_pages:
> +	for (i = 0; i < nr_pages; i++) {
> +		unlock_page(pages[i]);
> +		put_page(pages[i]);
> +	}
> +
> +	kfree(actor);
> +out:
> +	kfree(pages);
> +}
>   
>   const struct address_space_operations squashfs_aops = {
> -	.read_folio = squashfs_read_folio
> +	.read_folio = squashfs_read_folio,
> +	.readahead = squashfs_readahead
>   };

