Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BE049C116
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiAZCRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:17:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35868 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiAZCRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:17:05 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jk6lf0NnjzcckM;
        Wed, 26 Jan 2022 10:16:14 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 10:17:03 +0800
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 10:17:03 +0800
Message-ID: <fb0aa85d-c644-ae7a-de17-aed0638fccfb@huawei.com>
Date:   Wed, 26 Jan 2022 10:17:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] Revert "mm/page_isolation: unset migratetype directly for
 non Buddy page"
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <guillaume.tucker@collabora.com>
References: <20220117142712.3967624-1-chenwandun@huawei.com>
 <7d39763f-7fc6-a56f-4f1d-7bce42ff59d6@redhat.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <7d39763f-7fc6-a56f-4f1d-7bce42ff59d6@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/1/17 23:32, David Hildenbrand 写道:
> On 17.01.22 15:27, Chen Wandun wrote:
>> This reverts commit 075782149abff45ee22f27315eced44d02b96779.
>>
>> commit 075782149abf ("mm/page_isolation: unset migratetype directly for
>> non Buddy page") will result memory that should in buddy disappear by
>> mistake. move_freepages_block move all pages in pageblock instead of
>> pages indicated by input parameter, so if input pages is not in buddy
>> but other pages in pageblock is in buddy, it will result in page out of
>> control.
>>
> I was wondering about exactly that condition when skimming over the
> patch but didn't have time review in detail.
when the first valid page in pageblock is non-buddy page and the page order
is not equal pagblock_order,  unset_migratetype_isolate will missing 
move free
page in this pageblock.
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>> ---
>>   mm/page_isolation.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 6a0ddda6b3c5..f67c4c70f17f 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -115,7 +115,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>>   	 * onlining - just onlined memory won't immediately be considered for
>>   	 * allocation.
>>   	 */
>> -	if (!isolated_page && PageBuddy(page)) {
>> +	if (!isolated_page) {
>>   		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
>>   		__mod_zone_freepage_state(zone, nr_pages, migratetype);
>>   	}
>

