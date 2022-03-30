Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9034EBDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbiC3J2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiC3J2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:28:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104E9262D73
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:26:21 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KT1Gx3BzczgY8Q;
        Wed, 30 Mar 2022 17:24:41 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 17:26:19 +0800
Subject: Re: [PATCH 1/8] mm/vmscan: remove redundant folio_test_swapbacked
 check when folio is file lru
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-2-linmiaohe@huawei.com>
 <CAMZfGtUPQvgaxG_6A0n6HwD9VjqbQUbnF99Ei9WpMZbTbnz4zg@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ea6e1a59-3de8-5568-82e3-511fcac620ca@huawei.com>
Date:   Wed, 30 Mar 2022 17:26:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtUPQvgaxG_6A0n6HwD9VjqbQUbnF99Ei9WpMZbTbnz4zg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/3/30 16:13, Muchun Song wrote:
> On Tue, Mar 29, 2022 at 9:26 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> When folio is file lru, folio_test_swapbacked is guaranteed to be true. So
>> it's unnecessary to check it here again. No functional change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 1678802e03e7..7c1a9713bfc9 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1434,8 +1434,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
>>          * Anonymous pages are not handled by flushers and must be written
>>          * from reclaim context. Do not stall reclaim based on them
>>          */
>> -       if (!folio_is_file_lru(folio) ||
>> -           (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
>> +       if (!folio_is_file_lru(folio) || folio_test_anon(folio)) {
> 
> At least your login is no problem since folio_is_file_lru() is equal to
> !folio_test_swapbacked().  But the new code is not clear to me.
> The old code is easy to understand, e.g. folio_test_anon(folio) &&
> !folio_test_swapbacked(folio) tells us that the anon pages which
> do not need to be swapped should be skipped. So I'm neutral on
> the patch.

Thanks for your comment. The previous one might look more common:
folio_test_anon(folio) && !folio_test_swapbacked(folio) means folio
is MADV_FREE and can be freed without swapping out. And I remove the
unneeded !folio_test_swapbacked(folio) check at the expense of losing
minor readability. If it is not worth doing this, I will drop this
patch.

Thanks.

> 
> .
> 
