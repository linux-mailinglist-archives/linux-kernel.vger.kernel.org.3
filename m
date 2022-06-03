Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD1053CA3F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244435AbiFCMyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiFCMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:54:30 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD9636E08
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:54:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220603125423euoutp0182e7cca1d8cf5fa5319cec91eafeffc7~1HX2Efzog1440814408euoutp01C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:54:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220603125423euoutp0182e7cca1d8cf5fa5319cec91eafeffc7~1HX2Efzog1440814408euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654260863;
        bh=ccW9O603lDuGqsKU/x3fpqBU4KZeJccXslpvNCfaor4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=rmgQBUY6N7xskEZcRqw2yaBTF9LJcwOU2lWIJzO5SOdTSK3ifCtVsXM2fOeJAqOBP
         tnLAfKQ+jnw3oQs8+X+8WssbKW+3NwQuHky1QOK0C1kY5CwEey1v2W61xyMk9CFPGk
         9j7RqW4nnX7RmfXJZZs1elEV+Ed4W9z1HTDO98s4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220603125422eucas1p1aaf212c4e94fa3aacb5a98a5b8257ba0~1HX1ptMRT0068000680eucas1p1W;
        Fri,  3 Jun 2022 12:54:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 71.18.10067.E740A926; Fri,  3
        Jun 2022 13:54:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75~1HX1FChv-0107801078eucas1p1G;
        Fri,  3 Jun 2022 12:54:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220603125421eusmtrp256cf7b3873dfa5f427dac42ea9fb59f3~1HX1EH_av0625406254eusmtrp2u;
        Fri,  3 Jun 2022 12:54:21 +0000 (GMT)
X-AuditID: cbfec7f4-dc1ff70000002753-24-629a047e5f7c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.98.09095.D740A926; Fri,  3
        Jun 2022 13:54:21 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220603125421eusmtip24f45cf71d8b5f6e60954a841ef9535e4~1HX0UkGeM0882208822eusmtip2B;
        Fri,  3 Jun 2022 12:54:21 +0000 (GMT)
Message-ID: <c017d992-2746-045b-47c8-c5b9c3025f1a@samsung.com>
Date:   Fri, 3 Jun 2022 14:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
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
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220601103922.1338320-4-hsinyi@chromium.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7p1LLOSDM5ukbOYs34Nm8WmQ2/Y
        LCa0bme2uLxrDpvFvTX/WS06Vt5jtTjas5nN4uqueovfP4Din3a9Z7W49u4Mm8X3B5uZHHg8
        ZjdcZPFoOfKW1WPzCi2PTZ8msXucmPGbxWP3gs9MHlO+Pmf2+LxJzmP9lq1MAZxRXDYpqTmZ
        ZalF+nYJXBmNDz8xFrxXr1j2XKGBcZN8FyMnh4SAiUT7hU3sILaQwApGiUdTcroYuYDsL4wS
        cxpbmCGcz4wSHTfXssB03O3Zyw6RWM4oMXvOOhYI5yOjxKp968CqeAXsJG6ePsIIYrMIqEjc
        P/+LHSIuKHFy5hOwGlGBJIn521pZQWxhAUuJB7uWM4PYzALiEreezGcCGSoCctO//tssEIlb
        TBJds41AbDYBQ4mut11sIDangLXE2//v2CFq5CW2v50DdreEwGxOif6bfYwQd7tIvFi4mRnC
        FpZ4dXwLO4QtI/F/J8g2DiA7X+LvDGOIcIXEtddroMqtJe6c+8UGUsIsoCmxfpc+RNhRYv3y
        z1CdfBI33gpCXMAnMWnbdGaIMK9ER5sQRLWaxKzj6+B2HrxwiXkCo9IspECZheT5WUh+mYWw
        dwEjyypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzApHb63/EvOxiXv/qod4iRiYPxEKME
        B7OSCG/ZvJlJQrwpiZVVqUX58UWlOanFhxilOViUxHmTMzckCgmkJ5akZqemFqQWwWSZODil
        GphSDlqq2KrNnfS+JKhwN9uT26/2P1B9Vap+9vWff6ZJ2s6LLeNd6qOcTdcdum34eW2XuQbb
        9f38Nf0ny7ftfTlj2bc1DhXzP044+GXexlO6K/cudDVXuKTBqif6RGhicLpUukbShEaroLbH
        V5UXH3Twnq6oHJv9Rfc3V2940Ouu/R9KS+aLMuU8/8vcv4J7fe5Sp7ANq8V3zX+l+Ye9/8PH
        R9+WFveyrV+723f+pOVv/xdKcd5b+qPEh4N/zx7ftO6URx+tDm96b1v9TfmRlPJBm39Z9f7n
        VsZ8WaQb2nTUIXRywYXKunjmh4WnfiW/br8s+0esWTOifzOvxOJ/UQvc4uL2dfewp+79wh0Q
        If1BiaU4I9FQi7moOBEAhsIkCNkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7q1LLOSDNb0WVjMWb+GzWLToTds
        FhNatzNbXN41h83i3pr/rBYdK++xWhzt2cxmcXVXvcXvH0DxT7ves1pce3eGzeL7g81MDjwe
        sxsusni0HHnL6rF5hZbHpk+T2D1OzPjN4rF7wWcmjylfnzN7fN4k57F+y1amAM4oPZui/NKS
        VIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzGh58YC96rVyx7
        rtDAuEm+i5GTQ0LAROJuz152EFtIYCmjxPZ70hBxGYmT0xpYIWxhiT/Xuti6GLmAat4zSlxd
        uY8ZJMErYCdx8/QRRhCbRUBF4v75X+wQcUGJkzOfsIDYogJJEvP2rgarERawlHiwazlYL7OA
        uMStJ/OZQIaKCKxilFi9cwYrROIOk8T1BmaIi7IlOjq/gdlsAoYSXW9BruDk4BSwlnj7/x07
        RL2ZRNfWLkYIW15i+9s5zBMYhWYhuWMWkn2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWle
        ul5yfu4mRmAkbzv2c/MOxnmvPuodYmTiYDzEKMHBrCTCWzZvZpIQb0piZVVqUX58UWlOavEh
        RlNgYExklhJNzgemkrySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6p
        BqY9VXsa1Fs/vFN5syKGz2z/9Wj/KpuIQpfgm1ecl3/LK15z7nPauqdvOaK5ZjOdn/bZq/h1
        x1kHFtHgJxU1VyQdnPs6w7ZIrq2eHXX6eOdb9vkPDhlNZZjql33298Rbv8KW6P4S3GS4KpBH
        tHiR0B3j5e1lIQbVyteYg0+mOfk+fqF/3P7CLK/Q9ZNO1Dy4yVEyQaZzO9tlwxXXf/lvX2+h
        dnTbEy7xsnmPqlSv3WlMSCw90OJzpMnkWommrgrDszs7Hj/YcXqKhd7OwNvup47MdF6yYZHW
        zc0XrZmuBdx4r9BZJR11KTY10F/O3LOtwaLJdTqz1Z3r7fqbX/p7Bzb8O8K4fsOPC1kaJwVm
        T7JSYinOSDTUYi4qTgQAzrgXF20DAAA=
X-CMS-MailID: 20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75
References: <20220601103922.1338320-1-hsinyi@chromium.org>
        <20220601103922.1338320-4-hsinyi@chromium.org>
        <CGME20220603125421eucas1p17da286a3e7f2d4759aa4c7639dd62f75@eucas1p1.samsung.com>
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01.06.2022 12:39, Hsin-Yi Wang wrote:
> Implement readahead callback for squashfs. It will read datablocks
> which cover pages in readahead request. For a few cases it will
> not mark page as uptodate, including:
> - file end is 0.
> - zero filled blocks.
> - current batch of pages isn't in the same datablock or not enough in a
>    datablock.
> - decompressor error.
> Otherwise pages will be marked as uptodate. The unhandled pages will be
> updated by readpage later.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> ---

This patch landed recently in linux-next as commit 95f7a26191de 
("squashfs: implement readahead"). I've noticed that it causes serious 
issues on my test systems (various ARM 32bit and 64bit based boards). 
The easiest way to observe is udev timeout 'waiting for /dev to be fully 
populated' and prolonged booting time. I'm using squashfs for deploying 
kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on 
top of the next-20220603 fixes the issue.

Let me know how I can help debugging this issue. There is no hurry 
though, because the next week I will be on holidays.

> v3->v4: Fix a few variable type and their locations.
> v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.org/
> v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium.org/
> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium.org/
> ---
>   fs/squashfs/file.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index a8e495d8eb86..df7ad4b3e99c 100644
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
> @@ -495,7 +496,101 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>   	return 0;
>   }
>   
> +static void squashfs_readahead(struct readahead_control *ractl)
> +{
> +	struct inode *inode = ractl->mapping->host;
> +	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> +	size_t mask = (1UL << msblk->block_log) - 1;
> +	unsigned short shift = msblk->block_log - PAGE_SHIFT;
> +	loff_t start = readahead_pos(ractl) &~ mask;
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
> +			for (i = 0; i < nr_pages; i++)
> +				SetPageUptodate(pages[i]);
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

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

