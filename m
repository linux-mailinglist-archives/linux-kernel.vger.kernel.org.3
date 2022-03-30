Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B51A4EB815
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbiC3CBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbiC3CBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:01:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3C76A438
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 18:59:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KSqPL4pB3z1GD5x;
        Wed, 30 Mar 2022 09:59:34 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 09:59:51 +0800
Subject: Re: [PATCH 4/8] mm/vmscan: save a bit of stack space in shrink_lruvec
To:     Christoph Hellwig <hch@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220329132619.18689-1-linmiaohe@huawei.com>
 <20220329132619.18689-5-linmiaohe@huawei.com>
 <YkMRFaRwS6dadsQ0@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cfbd21f9-afbe-cabc-b7e7-057d8ad58e37@huawei.com>
Date:   Wed, 30 Mar 2022 09:59:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YkMRFaRwS6dadsQ0@infradead.org>
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

On 2022/3/29 22:00, Christoph Hellwig wrote:
> On Tue, Mar 29, 2022 at 09:26:15PM +0800, Miaohe Lin wrote:
>> LRU_UNEVICTABLE is not taken into account when shrink lruvec. So we can
>> save a bit of stack space by shrinking the array size of nr and targets
>> to NR_LRU_LISTS - 1. No functional change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index a6e60c78d058..ebd8ffb63673 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -2862,8 +2862,9 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
>>  
>>  static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>>  {
>> -	unsigned long nr[NR_LRU_LISTS];
>> -	unsigned long targets[NR_LRU_LISTS];
>> +	/* LRU_UNEVICTABLE is not taken into account. */
>> +	unsigned long nr[NR_LRU_LISTS - 1];
>> +	unsigned long targets[NR_LRU_LISTS - 1];
> 
> This looks like a problem waiting to happen..

IIUC, I am changing the array size to what it exactly uses now. And LRU_UNEVICTABLE won't be
used anyway. Could you please tell me what kind of problem is waiting to happen ? If this
will result in actual risk, I will drop this patch.

Thanks.

> 
> .
> 

