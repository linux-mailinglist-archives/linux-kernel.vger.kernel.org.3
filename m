Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF752E281
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbiETCbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbiETCax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:30:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC366594
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:30:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L49fs4L2WzjX2s;
        Fri, 20 May 2022 10:29:57 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 10:30:49 +0800
Subject: Re: [PATCH 5/9] revert "mm/z3fold.c: allow __GFP_HIGHMEM in
 z3fold_alloc"
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220429064051.61552-1-linmiaohe@huawei.com>
 <20220429064051.61552-6-linmiaohe@huawei.com>
 <CAM4kBBLC4Jo4TAC66XzJBgFZfF5ONgCNT5fPFQjwPJtug+5N8A@mail.gmail.com>
 <a3179291-fe43-1004-c89c-3bcdad26306e@huawei.com>
 <20220519113112.7531614a96dc4852ba61fdbc@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3338d160-61e7-c099-0ea7-5c987d9c879d@huawei.com>
Date:   Fri, 20 May 2022 10:30:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220519113112.7531614a96dc4852ba61fdbc@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/5/20 2:31, Andrew Morton wrote:
> On Thu, 19 May 2022 19:34:01 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> On 2022/5/19 15:12, Vitaly Wool wrote:
>>> On Fri, Apr 29, 2022 at 8:41 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> Revert commit f1549cb5ab2b ("mm/z3fold.c: allow __GFP_HIGHMEM in
>>>> z3fold_alloc").
>>>>
>>>> z3fold can't support GFP_HIGHMEM page now. page_address is used
>>>> directly at all places. Moreover, z3fold_header is on per cpu
>>>> unbuddied list which could be access anytime. So we should rid
>>>> the support of GFP_HIGHMEM allocation for z3fold.
>>>
>>> Could you please clarify how kmem_cache is affected here?
>>
>> With this code changes, kmem_cache should be unaffected. HIGHMEM is still not supported for
>> kmem_cache just like before but caller ensures __GFP_HIGHMEM is not passed in now. The issue
>> I want to fix here is that if z3fold page is allocated from highmem, page_address can't be
>> used directly. Did I answer your question? Or don't I get your point?
>>
> 
> Yes, page_address() against a highmem page only works if that page has
> been mapped into pagetables with kmap() or kmap_atomic(), and z3fold
> doesn't appear to do that.

What's more, usually z3fold page is on the percpu unbuddied list and thus can be
accessed directly at any time when needed. So we can't do kunmap or kunmap_atomic
until z3fold page is taken off the list.

> 
> Given that other zpool_driver implementations do appear to support
> highmem pages, I expect that z3fold should be taught likewise.
> 

IMHO, it might be too cumbersome to support highmem pages due to above reason.

> 
> I didn't look very hard, but this particular patch is a bit worrisome. 
> As I understand it, zswap can enable highmem:
> 
> 	if (zpool_malloc_support_movable(entry->pool->zpool))
> 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
> 
> and z3fold will silently ignore the __GFP_HIGHMEM, which is OK.  But
> with this patch, z3fold will now return -EINVAL, so existing setups
> will start failing?

IIUC, malloc_support_movable is never set for z3fold_zpool_driver. So zpool_malloc_support_movable
will always return false, i.e. __GFP_HIGHMEM | __GFP_MOVABLE won't be set for z3fold page now
(otherwise page_address will return NULL for highmem pages and null-pointer dereferencing should be
witnessed already). Therefore existing setups will keep unaffected. Or am I miss something?

Thanks a lot!

> 
> .
> 

