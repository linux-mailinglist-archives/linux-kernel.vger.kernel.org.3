Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72818583668
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiG1Bgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiG1Bgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:36:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AB013F2C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:36:51 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LtY8l3lpqzkY1V;
        Thu, 28 Jul 2022 09:34:15 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 09:36:49 +0800
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 09:36:48 +0800
Subject: Re: [PATCH] mm/folio-compact: fix potential NULL pointer in
 pagecache_get_page
To:     William Kucharski <william.kucharski@oracle.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>
References: <20220727064621.534528-1-liuyongqiang13@huawei.com>
 <B92F20D6-595A-4B7F-95CA-7C681C2AF79D@oracle.com>
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
Message-ID: <3e80debb-eb34-75ed-6c12-feb072e42546@huawei.com>
Date:   Thu, 28 Jul 2022 09:36:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <B92F20D6-595A-4B7F-95CA-7C681C2AF79D@oracle.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.155]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Understood, thanks for your explanation :)

ÔÚ 2022/7/27 19:40, William Kucharski Ð´µÀ:
> This isn't a NULL pointer dereference; returning &(0->page) is completely legal
> as was discussed regarding this exact code back in April:
>
> https://lore.kernel.org/lkml/YmfgqKcMmstgfz+0@casper.infradead.org/
>
>> On Jul 27, 2022, at 12:46 AM, Yongqiang Liu <liuyongqiang13@huawei.com> wrote:
>>
>> When __filemap_get_folio() failed and returned NULL, we would
>> get a NULL pointer dereference in pagecache_get_page.
>>
>> Fixes: 3f0c6a07fee6 ("mm/filemap: Add filemap_get_folio")
>> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> Cc: <stable@vger.kernel.org> # 5.16
>> ---
>> mm/folio-compat.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
>> index 20bc15b57d93..7b21393480e0 100644
>> --- a/mm/folio-compat.c
>> +++ b/mm/folio-compat.c
>> @@ -124,7 +124,9 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
>> struct folio *folio;
>>
>> folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
>> - if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
>> + if (!folio)
>> + return NULL;
>> + if ((fgp_flags & FGP_HEAD) || xa_is_value(folio))
>> return &folio->page;
>> return folio_file_page(folio, index);
>> }
>> -- 
>> 2.25.1
>>
>>
> .
