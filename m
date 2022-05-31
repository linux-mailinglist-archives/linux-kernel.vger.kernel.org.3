Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332DB53983C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347870AbiEaUrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347857AbiEaUrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:47:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9228F33E33
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B10861309
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9D1C385A9;
        Tue, 31 May 2022 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654030061;
        bh=fzrQx5AYSFavOiUDERP8KYImhoo/bZrSeE+sPb05Gxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XT2pd6nBD2ZUibRo5HLGsXDK0DYHXIz/ZJEYSYmiHtRI6GvB5VFLpGgBu/StnzLR8
         Z24TA09jTeG+htfqQvOEjT07aUdREe5b0xwxJBKH4EvU9aihE9FwC+TfKu2dAa+unH
         EiZT4/A9G7Pa90bZ390dRUQ00NWJyh/P9Fwkg0nY=
Date:   Tue, 31 May 2022 13:47:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] squashfs: implement readahead
Message-Id: <20220531134740.91ae4dcea1e06640ba1bfc12@linux-foundation.org>
In-Reply-To: <20220523065909.883444-4-hsinyi@chromium.org>
References: <20220523065909.883444-1-hsinyi@chromium.org>
        <20220523065909.883444-4-hsinyi@chromium.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 14:59:13 +0800 Hsin-Yi Wang <hsinyi@chromium.org> wrote:

> Implement readahead callback for squashfs. It will read datablocks
> which cover pages in readahead request. For a few cases it will
> not mark page as uptodate, including:
> - file end is 0.
> - zero filled blocks.
> - current batch of pages isn't in the same datablock or not enough in a
>   datablock.
> - decompressor error.
> Otherwise pages will be marked as uptodate. The unhandled pages will be
> updated by readpage later.
> 
> ...
>

The choice of types seems somewhat confused.

> @@ -495,7 +496,95 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>  	return 0;
>  }
>  
> +static void squashfs_readahead(struct readahead_control *ractl)
> +{
> +	struct inode *inode = ractl->mapping->host;
> +	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> +	size_t mask = (1UL << msblk->block_log) - 1;
> +	size_t shift = msblk->block_log - PAGE_SHIFT;

block_log is unsigned short.  Why size_t?

> +	loff_t start = readahead_pos(ractl) &~ mask;
> +	size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
> +	struct squashfs_page_actor *actor;
> +	unsigned int nr_pages = 0;

OK.

> +	struct page **pages;
> +	u64 block = 0;
> +	int bsize, res, i, index, bytes, expected;

`res' could be local to the inner loop.

`i' is used in situations where an unsigned type would be more
appropriate.  If it is made unsigned then `i' is no longer a suitable
identifier.  Doesn't matter much.

`index' is from page.index, which is pgoff_t.

`bytes' could be local to the innermost loop.

`expected' is inappropriately a signed type and could be local to the
inner loop.

> +	int file_end = i_size_read(inode) >> msblk->block_log;
> +	unsigned int max_pages = 1UL << shift;
> +	void *pageaddr;
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
> +		nr_pages = __readahead_batch(ractl, pages, max_pages);
> +		if (!nr_pages)
> +			break;
> +
> +		if (readahead_pos(ractl) >= i_size_read(inode) ||
> +		    nr_pages < max_pages)
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
> +		res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
> +					 actor);
> +
> +		if (res == expected) {
> +			/* Last page may have trailing bytes not filled */
> +			bytes = res % PAGE_SIZE;
> +			if (bytes) {
> +				pageaddr = kmap_atomic(pages[nr_pages - 1]);
> +				memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
> +				kunmap_atomic(pageaddr);
> +			}
> +
> +			for (i = 0; i < nr_pages; i++)
> +				SetPageUptodate(pages[i]);
> +		}

res == -EIO is unhandled?

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
>  const struct address_space_operations squashfs_aops = {
> -	.read_folio = squashfs_read_folio
> +	.read_folio = squashfs_read_folio,
> +	.readahead = squashfs_readahead
>  };

