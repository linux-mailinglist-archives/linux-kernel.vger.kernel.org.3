Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705884FCCE4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbiDLDQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbiDLDQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:16:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074330F63
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:13:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KcrLB4tT3zBsCk;
        Tue, 12 Apr 2022 11:09:38 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 11:13:54 +0800
Subject: Re: [PATCH v2 4/9] mm/vmscan: save a bit of stack space in
 shrink_lruvec
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        <akpm@linux-foundation.org>
CC:     <songmuchun@bytedance.com>, <hch@infradead.org>,
        <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-5-linmiaohe@huawei.com>
 <512fce32b8967ebc49f6fc074db408c117b510f7.camel@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <84b6946b-01ed-bc40-9da5-f62bf2b6de90@huawei.com>
Date:   Tue, 12 Apr 2022 11:13:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <512fce32b8967ebc49f6fc074db408c117b510f7.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 8:57, ying.huang@intel.com wrote:
> On Sat, 2022-04-09 at 17:34 +0800, Miaohe Lin wrote:
>> LRU_UNEVICTABLE is not taken into account when shrink lruvec. So we can
>> save a bit of stack space by shrinking the array size of nr and targets
>> to NR_LRU_LISTS - 1. No functional change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 59b96320f481..0e5818970998 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2881,8 +2881,9 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
>>  
>>
>>  static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>>  {
>> -	unsigned long nr[NR_LRU_LISTS];
>> -	unsigned long targets[NR_LRU_LISTS];
>> +	/* LRU_UNEVICTABLE is not taken into account. */
>> +	unsigned long nr[NR_LRU_LISTS - 1];
>> +	unsigned long targets[NR_LRU_LISTS - 1];
>>  	unsigned long nr_to_scan;
>>  	enum lru_list lru;
>>  	unsigned long nr_reclaimed = 0;
> 
> As Christoph pointed out, this is hacky without much benefit.  Please
> drop this patch.

Will drop this patch. Thanks.

> 
> Best Regards,
> Huang, Ying
> 
> .
> 

