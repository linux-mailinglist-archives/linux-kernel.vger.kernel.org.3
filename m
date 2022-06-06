Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E1553E057
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 06:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiFFDyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiFFDyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:54:40 -0400
Received: from p3plwbeout11-01.prod.phx3.secureserver.net (p3plsmtp11-01-2.prod.phx3.secureserver.net [173.201.192.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDD32DDE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:54:32 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id y3p1ny2NwFwhBy3p1nMQe4; Sun, 05 Jun 2022 20:54:32 -0700
X-CMAE-Analysis: v=2.4 cv=R9/GpfdX c=1 sm=1 tr=0 ts=629d7a78
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=hD80L64hAAAA:8
 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8 a=FXvPX3liAAAA:8 a=t7CeM3EgAAAA:8
 a=chwQjfZ6gPOV06gMw64A:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=xmb-EsYY8bH0VWELuYED:22 a=UObqyxdv-6Yh2QiB9mM_:22 a=FdTzh2GWekK77mhwV6Dw:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  y3p1ny2NwFwhB
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp01.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1ny3oy-0005XP-LE; Mon, 06 Jun 2022 04:54:30 +0100
Message-ID: <0e84fe64-c993-7f43-ca52-8fee735b0372@squashfs.org.uk>
Date:   Mon, 6 Jun 2022 04:54:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/3] squashfs: implement readahead
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Xiongwei Song <Xiongwei.Song@windriver.com>,
        Zheng Liang <zhengliang6@huawei.com>,
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
 <YpoFnROxAwdSScuV@casper.infradead.org>
 <90b228ea-1b0e-d2e8-62be-9ad5802dcce7@samsung.com>
 <CAJMQK-jDwchHokDZw7k24rGdy7OeUmiVWUCfxBiu1E1dZwuy2Q@mail.gmail.com>
 <Ypoo4WrVx5/YvaXx@casper.infradead.org>
 <aa54b4cb-e8ee-8c1a-c826-8016f42a5da1@samsung.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <aa54b4cb-e8ee-8c1a-c826-8016f42a5da1@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfHrfCVynvhoFKFBKE3hsNk6v0tDWR/gHMSFvwKJAg7zVyccQTIhqQdC/FZibcSWyku69W+w/F6xCsffOvOW6QR2gosNUn3uFdquLWwgTE4WL6RcEtLfg
 RbvlJzg4ijg2hMnhK7/YtqLnCXE1is4Z8EEcQOqOf9nvq8O0UH5rnxqW9X9nLlJmptCORtmvFPyzEKdnLZs5MbXGSBFqfoNR+SY=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 16:58, Marek Szyprowski wrote:
> Hi Matthew,
> 
> On 03.06.2022 17:29, Matthew Wilcox wrote:
>> On Fri, Jun 03, 2022 at 10:55:01PM +0800, Hsin-Yi Wang wrote:
>>> On Fri, Jun 3, 2022 at 10:10 PM Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>> Hi Matthew,
>>>>
>>>> On 03.06.2022 14:59, Matthew Wilcox wrote:
>>>>> On Fri, Jun 03, 2022 at 02:54:21PM +0200, Marek Szyprowski wrote:
>>>>>> On 01.06.2022 12:39, Hsin-Yi Wang wrote:
>>>>>>> Implement readahead callback for squashfs. It will read datablocks
>>>>>>> which cover pages in readahead request. For a few cases it will
>>>>>>> not mark page as uptodate, including:
>>>>>>> - file end is 0.
>>>>>>> - zero filled blocks.
>>>>>>> - current batch of pages isn't in the same datablock or not enough in a
>>>>>>>       datablock.
>>>>>>> - decompressor error.
>>>>>>> Otherwise pages will be marked as uptodate. The unhandled pages will be
>>>>>>> updated by readpage later.
>>>>>>>
>>>>>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>>>>>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>>>>>> Reported-by: Matthew Wilcox <willy@infradead.org>
>>>>>>> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
>>>>>>> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
>>>>>>> ---
>>>>>> This patch landed recently in linux-next as commit 95f7a26191de
>>>>>> ("squashfs: implement readahead"). I've noticed that it causes serious
>>>>>> issues on my test systems (various ARM 32bit and 64bit based boards).
>>>>>> The easiest way to observe is udev timeout 'waiting for /dev to be fully
>>>>>> populated' and prolonged booting time. I'm using squashfs for deploying
>>>>>> kernel modules via initrd. Reverting aeefca9dfae7 & 95f7a26191deon on
>>>>>> top of the next-20220603 fixes the issue.
>>>>> How large are these files?  Just a few kilobytes?
>>>> Yes, they are small, most of them are smaller than 16KB, some about
>>>> 128KB and a few about 256KB. I've sent a detailed list in private mail.
>>>>
>>> Hi Marek,
>>>
>>> Are there any obvious squashfs errors in dmesg? Did you enable
>>> CONFIG_SQUASHFS_FILE_DIRECT or CONFIG_SQUASHFS_FILE_CACHE?
>> I don't think it's an error problem.  I think it's a short file problem.
>>
>> As I understand the current code (and apologies for not keeping up
>> to date with how the patch is progressing), if the file is less than
>> msblk->block_size bytes, we'll leave all the pages as !uptodate, leaving
>> them to be brough uptodate by squashfs_read_folio().  So Marek is hitting
>> the worst case scenario where we re-read the entire block for each page
>> in it.  I think we have to handle this tail case in ->readahead().
> 
> I'm not sure if this is related to reading of small files. There are
> only 50 modules being loaded from squashfs volume. I did a quick test of
> reading the files.
> 
> Simple file read with this patch:
> 
> root@target:~# time find /initrd/ -type f | while read f; do cat $f
>   >/dev/null; done
> 
> real    0m5.865s
> user    0m2.362s
> sys     0m3.844s
> 
> Without:
> 
> root@target:~# time find /initrd/ -type f | while read f; do cat $f
>   >/dev/null; done
> 
> real    0m6.619s
> user    0m2.112s
> sys     0m4.827s
> 

It has been a four day holiday in the UK (Queen's Platinum Jubilee),
hence the delay in responding.

The above read use-case is sequential (only one thread/process),
whereas the use-case where the slow-down is observed may be
parallel (multiple threads/processes entering Squashfs).

The above sequential use-case if the small files are held in
fragments, will be exhibiting caching behaviour that will
ameliorate the case where the same block is being repeatedly
re-read for each page in it.  Because each time
Squashfs is re-entered handling only a single page, the
decompressed block will be found in the fragment
cache, eliminating a block decompression for each page.

In a parallel use-case the decompressed fragment block
may be being eliminated from the cache (by other reading
processes), hence forcing the block to be repeatedly
decompressed.

Hence the slow-down will be much more noticable with a
parallel use-case than a sequential use-case.  It also may
be why this slipped through testing, if the test cases
are purely sequential in nature.

So Matthew's previous comment is still the most likely
explanation for the slow-down.

Phillip

> Best regards

