Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012FF53F74F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiFGHfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiFGHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:35:22 -0400
Received: from p3plwbeout15-03.prod.phx3.secureserver.net (p3plsmtp15-03-2.prod.phx3.secureserver.net [173.201.193.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3253160BBB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:35:18 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id yTkDnHTqFg7ZlyTkEnGQxR; Tue, 07 Jun 2022 00:35:18 -0700
X-CMAE-Analysis: v=2.4 cv=a//1SWeF c=1 sm=1 tr=0 ts=629effb6
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=JfrnYn6hAAAA:8
 a=cm27Pg_UAAAA:8 a=FXvPX3liAAAA:8 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8
 a=gozxAr8Rxt5D4kyEU7QA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=xmb-EsYY8bH0VWELuYED:22 a=UObqyxdv-6Yh2QiB9mM_:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  yTkDnHTqFg7Zl
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp01.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nyTk9-0003Xi-M1; Tue, 07 Jun 2022 08:35:17 +0100
Message-ID: <31ed17e7-29d1-55e8-cb09-a750ab80da15@squashfs.org.uk>
Date:   Tue, 7 Jun 2022 08:35:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
References: <20220601103922.1338320-1-hsinyi@chromium.org>
 <20220601103922.1338320-4-hsinyi@chromium.org>
 <CGME20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75@eucas1p1.samsung.com>
 <c017d992-2746-045b-47c8-c5b9c3025f1a@samsung.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <c017d992-2746-045b-47c8-c5b9c3025f1a@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfGwJrZcAmJiVw4SQzSorIGvTYoP8Ng9Fc8C1qZ2c8WCA3wTTufIq7AJ/RgsZsYtTkp1IQcjWai8uLQ6QN2hl8W9A0G6fVGElhMR9biqCLE7RpiyW8O2/
 9usqtE3vi7Wkae2oI213/1X6Hw1phrrvXXbGPACw54Yp+gBZBOaAyRXpfcEEHr2FhLmN0VKqY3sAz5U4fpiatTZKV2+uQZe4vlo=
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 13:54, Marek Szyprowski wrote:
> Hi,
> 
> On 01.06.2022 12:39, Hsin-Yi Wang wrote:
>> Implement readahead callback for squashfs. It will read datablocks
>> which cover pages in readahead request. For a few cases it will
>> not mark page as uptodate, including:
>> - file end is 0.
>> - zero filled blocks.
>> - current batch of pages isn't in the same datablock or not enough in a
>>     datablock.
>> - decompressor error.
>> Otherwise pages will be marked as uptodate. The unhandled pages will be
>> updated by readpage later.
>>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> Reported-by: Matthew Wilcox <willy@infradead.org>
>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
>> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
>> ---
> 
> This patch landed recently in linux-next as commit 95f7a26191de
> ("squashfs: implement readahead"). I've noticed that it causes serious
> issues on my test systems (various ARM 32bit and 64bit based boards).
> The easiest way to observe is udev timeout 'waiting for /dev to be fully
> populated' and prolonged booting time. I'm using squashfs for deploying
> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on
> top of the next-20220603 fixes the issue.
> 
> Let me know how I can help debugging this issue. There is no hurry
> though, because the next week I will be on holidays.

Hi Marek,

Can you supply an example Squashfs filesystem and script that
reproduces the slow-down?  Failing that, can you supply a copy
of your initrd/root-filesystem that can be run under emulation
to reproduce the issue? (I don't have any modern ARM embedded
systems).

Again failing that, are you happy to test some debug code?

Thanks

Phillip (Squashfs maintainer and author).

> 
>> v3->v4: Fix a few variable type and their locations.
>> v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.org/
>> v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
>> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
>> ---
>>    fs/squashfs/file.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-
>>    1 file changed, 96 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
>> index a8e495d8eb86..df7ad4b3e99c 100644
>> --- a/fs/squashfs/file.c
>> +++ b/fs/squashfs/file.c
>> @@ -39,6 +39,7 @@
>>    #include "squashfs_fs_sb.h"
>>    #include "squashfs_fs_i.h"
>>    #include "squashfs.h"
>> +#include "page_actor.h"
>>    
>>    /*
>>     * Locate cache slot in range [offset, index] for specified inode.  If
>> @@ -495,7 +496,101 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>>    	return 0;
>>    }
>>    
>> +static void squashfs_readahead(struct readahead_control *ractl)
>> +{
>> +	struct inode *inode = ractl->mapping->host;
>> +	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>> +	size_t mask = (1UL << msblk->block_log) - 1;
>> +	unsigned short shift = msblk->block_log - PAGE_SHIFT;
>> +	loff_t start = readahead_pos(ractl) &~ mask;
>> +	size_t len = readahead_length(ractl) + readahead_pos(ractl) - start;
>> +	struct squashfs_page_actor *actor;
>> +	unsigned int nr_pages = 0;
>> +	struct page **pages;
>> +	int i, file_end = i_size_read(inode) >> msblk->block_log;
>> +	unsigned int max_pages = 1UL << shift;
>> +
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
>> +		pgoff_t index;
>> +		int res, bsize;
>> +		u64 block = 0;
>> +		unsigned int expected;
>> +
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
>> +			int bytes;
>> +
>> +			/* Last page may have trailing bytes not filled */
>> +			bytes = res % PAGE_SIZE;
>> +			if (bytes) {
>> +				void *pageaddr;
>> +
>> +				pageaddr = kmap_atomic(pages[nr_pages - 1]);
>> +				memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
>> +				kunmap_atomic(pageaddr);
>> +			}
>> +
>> +			for (i = 0; i < nr_pages; i++)
>> +				SetPageUptodate(pages[i]);
>> +		}
>> +
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
>>    const struct address_space_operations squashfs_aops = {
>> -	.read_folio = squashfs_read_folio
>> +	.read_folio = squashfs_read_folio,
>> +	.readahead = squashfs_readahead
>>    };
> 
> Best regards

