Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0904525B54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377193AbiEMGQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377350AbiEMGQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:16:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C16278
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:15:42 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kzyzk39pwzhYsP;
        Fri, 13 May 2022 14:14:58 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 14:15:38 +0800
Subject: Re: [PATCH 14/15] mm/swap: fix the comment of get_kernel_pages
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <surenb@google.com>,
        <peterx@redhat.com>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-15-linmiaohe@huawei.com>
 <3f9e663a-2045-81d1-509e-abbe0e1fa14e@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <639dfeab-d81b-3da1-1da4-52447c8a6b95@huawei.com>
Date:   Fri, 13 May 2022 14:15:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3f9e663a-2045-81d1-509e-abbe0e1fa14e@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 21:45, David Hildenbrand wrote:
> On 09.05.22 15:14, Miaohe Lin wrote:
>> If no pages were pinned, 0 is returned in fact. Fix the corresponding
>> comment.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/swap.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index 6d2c37f781f8..236b37663a1a 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -168,8 +168,8 @@ EXPORT_SYMBOL(put_pages_list);
>>   *
>>   * Returns number of pages pinned. This may be fewer than the number
>>   * requested. If nr_pages is 0 or negative, returns 0. If no pages
> 
> Ehm, there is only "nr_segs", no "nr_pages" :/ Want to fix that up in
> the same patch?

Will do.

> 
>> - * were pinned, returns -errno. Each page returned must be released
>> - * with a put_page() call when it is finished with.
>> + * were pinned, returns 0. Each page returned must be released with
>> + * a put_page() call when it is finished with.
>>   */
>>  int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
>>  		struct page **pages)
> 
> Apart from that
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Many thanks for review and comment!

> 

