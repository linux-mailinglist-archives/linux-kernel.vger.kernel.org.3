Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6864D52D18C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiESLeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbiESLeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:34:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5472B41CB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:34:03 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L3nlW3JTrz1JCKN;
        Thu, 19 May 2022 19:32:39 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 19:34:01 +0800
Subject: Re: [PATCH 5/9] revert "mm/z3fold.c: allow __GFP_HIGHMEM in
 z3fold_alloc"
To:     Vitaly Wool <vitaly.wool@konsulko.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220429064051.61552-1-linmiaohe@huawei.com>
 <20220429064051.61552-6-linmiaohe@huawei.com>
 <CAM4kBBLC4Jo4TAC66XzJBgFZfF5ONgCNT5fPFQjwPJtug+5N8A@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a3179291-fe43-1004-c89c-3bcdad26306e@huawei.com>
Date:   Thu, 19 May 2022 19:34:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAM4kBBLC4Jo4TAC66XzJBgFZfF5ONgCNT5fPFQjwPJtug+5N8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/19 15:12, Vitaly Wool wrote:
> On Fri, Apr 29, 2022 at 8:41 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> Revert commit f1549cb5ab2b ("mm/z3fold.c: allow __GFP_HIGHMEM in
>> z3fold_alloc").
>>
>> z3fold can't support GFP_HIGHMEM page now. page_address is used
>> directly at all places. Moreover, z3fold_header is on per cpu
>> unbuddied list which could be access anytime. So we should rid
>> the support of GFP_HIGHMEM allocation for z3fold.
> 
> Could you please clarify how kmem_cache is affected here?

With this code changes, kmem_cache should be unaffected. HIGHMEM is still not supported for
kmem_cache just like before but caller ensures __GFP_HIGHMEM is not passed in now. The issue
I want to fix here is that if z3fold page is allocated from highmem, page_address can't be
used directly. Did I answer your question? Or don't I get your point?

Thanks!

> 
> Thanks,
> Vitaly

Many thanks for your time! :)

> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/z3fold.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/z3fold.c b/mm/z3fold.c
>> index b3b4e65c107f..5f5d5f1556be 100644
>> --- a/mm/z3fold.c
>> +++ b/mm/z3fold.c
>> @@ -212,10 +212,8 @@ static int size_to_chunks(size_t size)
>>  static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
>>                                                         gfp_t gfp)
>>  {
>> -       struct z3fold_buddy_slots *slots;
>> -
>> -       slots = kmem_cache_zalloc(pool->c_handle,
>> -                                (gfp & ~(__GFP_HIGHMEM | __GFP_MOVABLE)));
>> +       struct z3fold_buddy_slots *slots = kmem_cache_zalloc(pool->c_handle,
>> +                                                            gfp);
>>
>>         if (slots) {
>>                 /* It will be freed separately in free_handle(). */
>> @@ -1075,7 +1073,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>>         enum buddy bud;
>>         bool can_sleep = gfpflags_allow_blocking(gfp);
>>
>> -       if (!size)
>> +       if (!size || (gfp & __GFP_HIGHMEM))
>>                 return -EINVAL;
>>
>>         if (size > PAGE_SIZE)
>> --
>> 2.23.0
>>
> .
> 

