Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5F52D130
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbiESLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiESLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:10:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D2B042E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:10:04 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L3n7k23DmzCsmy;
        Thu, 19 May 2022 19:05:06 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 19:10:01 +0800
Subject: Re: [PATCH 4/9] mm/z3fold: throw warning on failure of trylock_page
 in z3fold_alloc
To:     Vitaly Wool <vitaly.wool@konsulko.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220429064051.61552-1-linmiaohe@huawei.com>
 <20220429064051.61552-5-linmiaohe@huawei.com>
 <CAM4kBB+SKzaFDCodVBZ4UbiFNrqJxAjEjaZCr=7FyW-rd4f39w@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <28ffb717-a9da-a85f-05a3-300376c3d036@huawei.com>
Date:   Thu, 19 May 2022 19:10:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAM4kBB+SKzaFDCodVBZ4UbiFNrqJxAjEjaZCr=7FyW-rd4f39w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/5/19 15:10, Vitaly Wool wrote:
> On Fri, Apr 29, 2022 at 8:40 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> If trylock_page fails, the page won't be non-lru movable page. When this
>> page is freed via free_z3fold_page, it will trigger bug on PageMovable
>> check in __ClearPageMovable. Throw warning on failure of trylock_page to
>> guard against such rare case just as what zsmalloc does.
> 
> I don't see how this is better than what we currently have. We can
> check if a page is movable before calling __ClearPageMovable instead.

Currently the z3fold page (unless headless page) is assumed to be non-lru movable.
We will always do __ClearPageMovable in free_z3fold_page which will trigger BUG_ON
!PageMovable now. And do you mean we should do something like below ?

diff --git a/mm/z3fold.c b/mm/z3fold.c
index f41f8b0d9e9a..a244bb5dcb34 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -417,9 +417,10 @@ static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 /* Resets the struct page fields and frees the page */
 static void free_z3fold_page(struct page *page, bool headless)
 {
-       if (!headless) {
+       if (likely(__PageMovable(page))) {
                lock_page(page);
-               __ClearPageMovable(page);
+               if (PageMovable(page))
+                       __ClearPageMovable(page);
                unlock_page(page);
        }
        __free_page(page);

Thanks!

> 
> ~Vitaly
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/z3fold.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/z3fold.c b/mm/z3fold.c
>> index 4e6814c5694f..b3b4e65c107f 100644
>> --- a/mm/z3fold.c
>> +++ b/mm/z3fold.c
>> @@ -1122,10 +1122,9 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>>                 __SetPageMovable(page, pool->inode->i_mapping);
>>                 unlock_page(page);
>>         } else {
>> -               if (trylock_page(page)) {
>> -                       __SetPageMovable(page, pool->inode->i_mapping);
>> -                       unlock_page(page);
>> -               }
>> +               WARN_ON(!trylock_page(page));
>> +               __SetPageMovable(page, pool->inode->i_mapping);
>> +               unlock_page(page);
>>         }
>>         z3fold_page_lock(zhdr);
>>
>> --
>> 2.23.0
>>
> .
> 

