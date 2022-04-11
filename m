Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D174FB252
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbiDKD27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244539AbiDKD2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:28:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CFF2CE10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:26:40 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KcDgM3p7zzBsCY;
        Mon, 11 Apr 2022 11:22:23 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 11:26:38 +0800
Subject: Re: [PATCH v2 3/9] mm/vmscan: introduce helper function
 reclaim_page_list()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <ying.huang@intel.com>,
        <songmuchun@bytedance.com>, <hch@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-4-linmiaohe@huawei.com>
 <YlGNvn3cu2TftNRN@casper.infradead.org>
 <18ac3908-d162-f1ea-e91f-1da203272b74@huawei.com>
 <YlOd1Lvw6ia1vul2@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b9578dbf-f393-6eed-789a-267da296a413@huawei.com>
Date:   Mon, 11 Apr 2022 11:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YlOd1Lvw6ia1vul2@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/11 11:17, Matthew Wilcox wrote:
> On Mon, Apr 11, 2022 at 09:53:15AM +0800, Miaohe Lin wrote:
>> On 2022/4/9 21:44, Matthew Wilcox wrote:
>>> On Sat, Apr 09, 2022 at 05:34:54PM +0800, Miaohe Lin wrote:
>>>> +	nr_reclaimed = shrink_page_list(page_list, pgdat, &sc, &dummy_stat, false);
>>>> +	while (!list_empty(page_list)) {
>>>> +		folio = lru_to_folio(page_list);
>>>> +		list_del(&folio->lru);
>>>> +		putback_lru_page(&folio->page);
>>>
>>> folio_putback_lru()
>>
>> I thought folio_putback_lru is deliberately not to use because there is no caller of folio_putback_lru now.
>> But it seems I was wrong. Will do it in next version.
> 
> Looks like all of the uses of it that I mooted during the last merge
> window ended up going away.
> 
> https://lore.kernel.org/all/20220204195852.1751729-47-willy@infradead.org/
> was obsoleted by commit b109b87050df
> 
> https://lore.kernel.org/all/20220204195852.1751729-48-willy@infradead.org/
> and
> https://lore.kernel.org/all/20220204195852.1751729-50-willy@infradead.org/
> were also obsoleted by Hugh's mlock changes
> 
> I also sent
> https://lore.kernel.org/all/YjJJIrENYb1qFHzl@casper.infradead.org/
> 
> but never quite got it up to submittable quality.

I see. This is really a pity. Many thanks for clarifying. :)

> 
> .
> 

