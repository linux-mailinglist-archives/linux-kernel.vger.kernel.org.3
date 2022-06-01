Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23D8539A9A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 03:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348842AbiFABIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 21:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiFABIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 21:08:30 -0400
Received: from p3plwbeout26-05.prod.phx3.secureserver.net (p3plsmtp26-05-2.prod.phx3.secureserver.net [216.69.139.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF87340CE
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 18:08:24 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id wCqUnNKE6uX6jwCqVn2ja2; Tue, 31 May 2022 18:08:23 -0700
X-CMAE-Analysis: v=2.4 cv=X5eXlEfe c=1 sm=1 tr=0 ts=6296bc07
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=cm27Pg_UAAAA:8
 a=vDMkPy1eL_Zqfcaux0MA:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  wCqUnNKE6uX6j
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp13.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nwCqU-0000ej-46; Wed, 01 Jun 2022 02:08:22 +0100
Message-ID: <e4de2e23-bbb8-369f-fa3b-4f4e296ab494@squashfs.org.uk>
Date:   Wed, 1 Jun 2022 02:08:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/3] squashfs: implement readahead
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
References: <20220523065909.883444-1-hsinyi@chromium.org>
 <20220523065909.883444-4-hsinyi@chromium.org>
 <20220531134740.91ae4dcea1e06640ba1bfc12@linux-foundation.org>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20220531134740.91ae4dcea1e06640ba1bfc12@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfGJo5YgBC7NbnhQ8hOy3sVJSF+0jkN8uwgPJwgdHwZvSWMNF+daxX9zSLeB+JXUHuWR5Qi+NqwmLs9RGrquvn15y47sCDryqZAzXjxEq6EDj0xjquaEq
 DxUJkZTHdmuhq1u0DYaghHllEiRB/yOkhyb//lhfzkgvsB8tlsvd2p13VF2+W/+ADG3Gdgtk/VQbUox8uG7Vo2pTgNmWpKkbBcI=
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 21:47, Andrew Morton wrote:
> On Mon, 23 May 2022 14:59:13 +0800 Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> 
>> Implement readahead callback for squashfs. It will read datablocks
>> which cover pages in readahead request. For a few cases it will
>> not mark page as uptodate, including:
>> - file end is 0.
>> - zero filled blocks.
>> - current batch of pages isn't in the same datablock or not enough in a
>>    datablock.
>> - decompressor error.
>> Otherwise pages will be marked as uptodate. The unhandled pages will be
>> updated by readpage later.
>>
>> ...
>>
> 
> The choice of types seems somewhat confused.
> 
>> @@ -495,7 +496,95 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>>   	return 0;
>>   }
>>   
>> +static void squashfs_readahead(struct readahead_control *ractl)
>> +{
>> +	struct inode *inode = ractl->mapping->host;
>> +	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>> +	size_t mask = (1UL << msblk->block_log) - 1;
>> +	size_t shift = msblk->block_log - PAGE_SHIFT;
> 
> block_log is unsigned short.  Why size_t?
> 
>> +	loff_t start = readahead_pos(ractl) &~ mask;
>> +	size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
>> +	struct squashfs_page_actor *actor;
>> +	unsigned int nr_pages = 0;
> 
> OK.
> 
>> +	struct page **pages;
>> +	u64 block = 0;
>> +	int bsize, res, i, index, bytes, expected;
> 
> `res' could be local to the inner loop.
> 
> `i' is used in situations where an unsigned type would be more
> appropriate.  If it is made unsigned then `i' is no longer a suitable
> identifier.  Doesn't matter much.
> 
> `index' is from page.index, which is pgoff_t.
> 
> `bytes' could be local to the innermost loop.
> 
> `expected' is inappropriately a signed type and could be local to the
> inner loop.
> 
>> +	int file_end = i_size_read(inode) >> msblk->block_log;
>> +	unsigned int max_pages = 1UL << shift;
>> +	void *pageaddr;
>> +

pageaddr could be made local to the innermost scope.

Apart from that the patch and updated error handling looks
good.

Phillip

>> +	readahead_expand(ractl, start, (len | mask) + 1);
>> +
>> +	if (file_end == 0)
>> +		return;
>> +
>> +	pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
>> +	if (!pages)
>> +		return;
>> +
>> +	actor = squashfs_page_actor_init_special(pages, max_pages, 0);
>> +	if (!actor)
>> +		goto out;
>> +
>> +	for (;;) {
>> +		nr_pages = __readahead_batch(ractl, pages, max_pages);
>> +		if (!nr_pages)
>> +			break;
>> +
>> +		if (readahead_pos(ractl) >= i_size_read(inode) ||
>> +		    nr_pages < max_pages)
>> +			goto skip_pages;
>> +
>> +		index = pages[0]->index >> shift;
>> +		if ((pages[nr_pages - 1]->index >> shift) != index)
>> +			goto skip_pages;
>> +
>> +		expected = index == file_end ?
>> +			   (i_size_read(inode) & (msblk->block_size - 1)) :
>> +			    msblk->block_size;
>> +
>> +		bsize = read_blocklist(inode, index, &block);
>> +		if (bsize == 0)
>> +			goto skip_pages;
>> +
>> +		res = squashfs_read_data(inode->i_sb, block, bsize, NULL,
>> +					 actor);
>> +
>> +		if (res == expected) {
>> +			/* Last page may have trailing bytes not filled */
>> +			bytes = res % PAGE_SIZE;
>> +			if (bytes) {
>> +				pageaddr = kmap_atomic(pages[nr_pages - 1]);
>> +				memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
>> +				kunmap_atomic(pageaddr);
>> +			}
>> +
>> +			for (i = 0; i < nr_pages; i++)
>> +				SetPageUptodate(pages[i]);
>> +		}
> 
> res == -EIO is unhandled?
> 
>> +		for (i = 0; i < nr_pages; i++) {
>> +			unlock_page(pages[i]);
>> +			put_page(pages[i]);
>> +		}
>> +	}
>> +
>> +	kfree(actor);
>> +	kfree(pages);
>> +	return;
>> +
>> +skip_pages:
>> +	for (i = 0; i < nr_pages; i++) {
>> +		unlock_page(pages[i]);
>> +		put_page(pages[i]);
>> +	}
>> +
>> +	kfree(actor);
>> +out:
>> +	kfree(pages);
>> +}
>>   
>>   const struct address_space_operations squashfs_aops = {
>> -	.read_folio = squashfs_read_folio
>> +	.read_folio = squashfs_read_folio,
>> +	.readahead = squashfs_readahead
>>   };
> 

