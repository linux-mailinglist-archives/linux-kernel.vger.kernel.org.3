Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71434FCCD9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 05:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiDLDJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 23:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiDLDJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 23:09:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A5A1E3F8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 20:07:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KcrBn0K8nzBsBk;
        Tue, 12 Apr 2022 11:03:13 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 11:07:29 +0800
Subject: Re: [PATCH v2 1/9] mm/vmscan: add a comment about MADV_FREE pages
 check in folio_check_dirty_writeback
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     <songmuchun@bytedance.com>, <hch@infradead.org>,
        <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-2-linmiaohe@huawei.com>
 <4b7923585e07b0238545ebb997af92eeadcdaf78.camel@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2a97ce77-42c8-15ea-50c4-fc18fd7fe693@huawei.com>
Date:   Tue, 12 Apr 2022 11:07:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4b7923585e07b0238545ebb997af92eeadcdaf78.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/4/11 19:50, ying.huang@intel.com wrote:
> On Sat, 2022-04-09 at 17:34 +0800, Miaohe Lin wrote:
>> The MADV_FREE pages check in folio_check_dirty_writeback is a bit hard to
>> follow. Add a comment to make the code clear.
>>
>> Suggested-by: Huang, Ying <ying.huang@intel.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index c77d5052f230..4a76be47bed1 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1436,6 +1436,9 @@ static void folio_check_dirty_writeback(struct folio
>> *folio,
>>         /*
>>          * Anonymous pages are not handled by flushers and must be written
>>          * from reclaim context. Do not stall reclaim based on them
>> +        * MADV_FREE anonymous pages are put into inactive file list too.
>> +        * They could be mistakenly treated as file lru. So further anon
>> +        * test is needed.
>>          */
> 
> How about something as follows,
> 
> 	/*
>          * Anonymous pages (including MADV_FREE ones) are not handled
> by	 * flushers and must be written from reclaim context. Do not stall
> 	 * reclaim based on them
> 	 */.
> 

This comment looks good but it seems it doesn't explain the MADV_FREE check logic.
Is this already enough? If so, will change to use this. Thanks!

> Best Regards,
> Huang, Ying
> 
>>         if (!folio_is_file_lru(folio) ||
>>             (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
> 
> 
> .
> 

