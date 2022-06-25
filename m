Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D03A55A6A8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 05:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiFYDcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 23:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFYDcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 23:32:10 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8133EA9D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 20:32:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LVKKG1jXRzDsQD;
        Sat, 25 Jun 2022 11:31:30 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 11:32:05 +0800
Subject: Re: [PATCH 03/16] mm/huge_memory: fix comment of
 __pud_trans_huge_lock
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <shy828301@gmail.com>,
        <zokeefe@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-4-linmiaohe@huawei.com>
 <YrYI1Dxk7lhZqEVp@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d7bb994e-83b7-2fcf-af1d-e88190995400@huawei.com>
Date:   Sat, 25 Jun 2022 11:32:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YrYI1Dxk7lhZqEVp@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/25 2:56, Matthew Wilcox wrote:
> On Thu, Jun 23, 2022 at 01:06:14AM +0800, Miaohe Lin wrote:
>> __pud_trans_huge_lock returns page table lock pointer if a given pud maps
>> a thp instead of 'true' since introduced. Fix corresponding comments.
> 
> I think the comments here are rather wasted.  I think this comment
> should be moved to pud_trans_huge_lock() and turned into kernel-doc
> format.

Do you mean something like below? If so, __pmd_trans_huge_lock might need to do the
similar work?

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index ae3d8e2fd9e2..b73fe864de13 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -238,6 +238,12 @@ static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
        else
                return NULL;
 }
+/**
+ * Returns true if a given pud maps a thp, false otherwise.
+ *
+ * Note that if it returns true, this routine returns without unlocking page
+ * table lock. So callers must unlock it.
+ */
 static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
                struct vm_area_struct *vma)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb2e4ecb76aa..ae4c2116be07 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2006,12 +2006,6 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
        return NULL;
 }

-/*
- * Returns true if a given pud maps a thp, false otherwise.
- *
- * Note that if it returns true, this routine returns without unlocking page
- * table lock. So callers must unlock it.
- */
 spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
 {
        spinlock_t *ptl;

Thanks!
> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/huge_memory.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 83fb6c3442ff..a26580da8011 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1903,10 +1903,10 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
>>  }
>>  
>>  /*
>> - * Returns true if a given pud maps a thp, false otherwise.
>> + * Returns page table lock pointer if a given pud maps a thp, NULL otherwise.
>>   *
>> - * Note that if it returns true, this routine returns without unlocking page
>> - * table lock. So callers must unlock it.
>> + * Note that if it returns page table lock pointe, this routine returns without
>> + * unlocking page table lock. So callers must unlock it.
>>   */
>>  spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
>>  {
>> -- 
>> 2.23.0
>>
> 
> .
> 

