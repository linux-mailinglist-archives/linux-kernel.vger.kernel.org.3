Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41FF57DA2C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiGVGTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGVGTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:19:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186B0664D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 23:19:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lpzgm01rmz926f;
        Fri, 22 Jul 2022 14:15:15 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 14:19:05 +0800
Subject: Re: [PATCH 4/5] hugetlbfs: cleanup some comments in inode.c
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-5-linmiaohe@huawei.com> <YtngA886kRoFslmS@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c2ad2512-5cf9-b2df-0d71-89bca364afe5@huawei.com>
Date:   Fri, 22 Jul 2022 14:19:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YtngA886kRoFslmS@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/22 7:23, Mike Kravetz wrote:
> On 07/21/22 21:16, Miaohe Lin wrote:
>> The function generic_file_buffered_read has been renamed to filemap_read
>> since commit 87fa0f3eb267 ("mm/filemap: rename generic_file_buffered_read
>> to filemap_read"). Update the corresponding comment. And duplicated taken
>> in hugetlbfs_fill_super is removed.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  fs/hugetlbfs/inode.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index aa7a5b8fc724..19fc62a9c2fe 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -313,8 +313,8 @@ hugetlbfs_read_actor(struct page *page, unsigned long offset,
>>  
>>  /*
>>   * Support for read() - Find the page attached to f_mapping and copy out the
>> - * data. Its *very* similar to generic_file_buffered_read(), we can't use that
>> - * since it has PAGE_SIZE assumptions.
>> + * data. Its *very* similar to filemap_read(), we can't use that since it has
>> + * PAGE_SIZE assumptions.
> 
> Since you are changing the comment, I would just say this provides
> functionality similar to filemap_read().  filemap_read is now operating
> on folios which may remove any PAGE_SIZE assumptions.  One day when
> hugetlb is converted to folios it may end up using filemap_read instead
> of hugetlbfs_read_actor.

Sounds reasonable.

> 

Do you mean changing the comment of hugetlbfs_read_iter like below ?

/*
 * Support for read() - Find the page attached to f_mapping and copy out the
 * data. This provides functionality similar to filemap_read().
 */
static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)

Thanks.
