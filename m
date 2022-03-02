Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862004CA010
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbiCBI5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiCBI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:57:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F021B5FF1E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:56:28 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K7nxn6Dtjzdfll;
        Wed,  2 Mar 2022 16:55:09 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 16:56:26 +0800
Subject: Re: [PATCH 9/9] mm/z3fold: remove unneeded return value of
 z3fold_compact_page()
To:     Vitaly Wool <vitaly.wool@konsulko.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220219092533.12596-1-linmiaohe@huawei.com>
 <20220219092533.12596-10-linmiaohe@huawei.com>
 <CAM4kBBK_a_2d5f7=OF2euGacnGoKM-8oVu0uQ86cTMvuAtPuPA@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2815e67d-3e14-9728-91b8-7fb7f655c3f3@huawei.com>
Date:   Wed, 2 Mar 2022 16:56:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAM4kBBK_a_2d5f7=OF2euGacnGoKM-8oVu0uQ86cTMvuAtPuPA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/2 16:40, Vitaly Wool wrote:
> On Sat, Feb 19, 2022 at 10:26 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> Remove the unneeded return value of z3fold_compact_page() as it's
>> never checked.
> 
> It was a sort of hook for gathering extended compaction statistics in
> future. Do you really gain a lot by removing this?

I see. So I shouldn't discard the return value though it looks unused.
This is just for cleanup purpose so let's just drop this patch.

Many thanks for your time and Reviewed-by tag in this series! :)

> 
> ~Vitaly
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/z3fold.c | 14 +++++---------
>>  1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/z3fold.c b/mm/z3fold.c
>> index 83b5a3514427..db41b4227ec7 100644
>> --- a/mm/z3fold.c
>> +++ b/mm/z3fold.c
>> @@ -746,18 +746,18 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
>>
>>  #define BIG_CHUNK_GAP  3
>>  /* Has to be called with lock held */
>> -static int z3fold_compact_page(struct z3fold_header *zhdr)
>> +static void z3fold_compact_page(struct z3fold_header *zhdr)
>>  {
>>         struct page *page = virt_to_page(zhdr);
>>
>>         if (test_bit(MIDDLE_CHUNK_MAPPED, &page->private))
>> -               return 0; /* can't move middle chunk, it's used */
>> +               return; /* can't move middle chunk, it's used */
>>
>>         if (unlikely(PageIsolated(page)))
>> -               return 0;
>> +               return;
>>
>>         if (zhdr->middle_chunks == 0)
>> -               return 0; /* nothing to compact */
>> +               return; /* nothing to compact */
>>
>>         if (zhdr->first_chunks == 0 && zhdr->last_chunks == 0) {
>>                 /* move to the beginning */
>> @@ -766,7 +766,7 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
>>                 zhdr->middle_chunks = 0;
>>                 zhdr->start_middle = 0;
>>                 zhdr->first_num++;
>> -               return 1;
>> +               return;
>>         }
>>
>>         /*
>> @@ -778,7 +778,6 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
>>                         BIG_CHUNK_GAP) {
>>                 mchunk_memmove(zhdr, zhdr->first_chunks + ZHDR_CHUNKS);
>>                 zhdr->start_middle = zhdr->first_chunks + ZHDR_CHUNKS;
>> -               return 1;
>>         } else if (zhdr->last_chunks != 0 && zhdr->first_chunks == 0 &&
>>                    TOTAL_CHUNKS - (zhdr->last_chunks + zhdr->start_middle
>>                                         + zhdr->middle_chunks) >=
>> @@ -787,10 +786,7 @@ static int z3fold_compact_page(struct z3fold_header *zhdr)
>>                         zhdr->middle_chunks;
>>                 mchunk_memmove(zhdr, new_start);
>>                 zhdr->start_middle = new_start;
>> -               return 1;
>>         }
>> -
>> -       return 0;
>>  }
>>
>>  static void do_compact_page(struct z3fold_header *zhdr, bool locked)
>> --
>> 2.23.0
>>
> .
> 

