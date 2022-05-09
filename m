Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC751F78E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiEII6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiEII2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:28:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429221E0288
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:23:20 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxYW61wz5zGpcf;
        Mon,  9 May 2022 16:00:18 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 16:03:04 +0800
Subject: Re: [PATCH v2 3/4] mm/migration: return errno when isolate_huge_page
 failed
To:     David Hildenbrand <david@redhat.com>
CC:     <ying.huang@intel.com>, <hch@lst.de>, <dhowells@redhat.com>,
        <cl@linux.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <mike.kravetz@oracle.com>, <naoya.horiguchi@nec.com>
References: <20220425132723.34824-1-linmiaohe@huawei.com>
 <20220425132723.34824-4-linmiaohe@huawei.com>
 <f06e4a39-39e7-44de-dbc8-dc82ead37047@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a8c3707f-1e8b-5f1f-767b-5a47cd71d5ef@huawei.com>
Date:   Mon, 9 May 2022 16:03:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f06e4a39-39e7-44de-dbc8-dc82ead37047@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/29 18:08, David Hildenbrand wrote:
> On 25.04.22 15:27, Miaohe Lin wrote:
>> We might fail to isolate huge page due to e.g. the page is under migration
>> which cleared HPageMigratable. So we should return -EBUSY in this case
>> rather than always return 1 which could confuse the user. Also we make
>> the prototype of isolate_huge_page consistent with isolate_lru_page to
>> improve the readability.
>>
>> Fixes: e8db67eb0ded ("mm: migrate: move_pages() supports thp migration")
> 
> If this is a fix, what's the runtime effect of it?
> 
> You state "could confuse", which doesn't indicate an actual BUG to me.

The hugetlb page might not be migrated due to error while it's not reported in the __user *status.
So the caller might think all of the memory is migrated and thus does not retry to migrate the
hugetlb page in the next round. Is this too trival to bother adding a Fixes tag?

Thanks!

> 
> 

