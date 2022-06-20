Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE87A551073
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbiFTGiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFTGiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:38:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6D52641
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:38:11 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LRKhL38b5zDsJM;
        Mon, 20 Jun 2022 14:37:38 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 14:38:09 +0800
Subject: Re: [PATCH] mm: stricter check on THP migration entry
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220618073243.9423-1-linmiaohe@huawei.com>
 <Yq/8NonqNmMGAeJ2@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bf2da75b-a392-ec8d-277c-33f741f2cb52@huawei.com>
Date:   Mon, 20 Jun 2022 14:38:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yq/8NonqNmMGAeJ2@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/6/20 12:48, Matthew Wilcox wrote:
> On Sat, Jun 18, 2022 at 03:32:43PM +0800, Miaohe Lin wrote:
>> When VM_BUG_ON check for THP migration entry, the existing code only check
>> thp_migration_supported case, but not for !thp_migration_supported case.
>> If !thp_migration_supported() and !pmd_present(), the original code may
>> dead loop in theory.  To make the VM_BUG_ON check more consistent, we need
>> to catch both cases.
> 
> This patch makes no sense to me.

Could you please explain it more? This patch is inspired by below commit indeed:
28b0ee3fb350 ("mm/gup.c: stricter check on THP migration entry during follow_pmd_mask").

Thanks.

> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index fee2884481f2..6a9a17c7f58a 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5043,10 +5043,9 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>>  
>>  		barrier();
>>  		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
>> -			VM_BUG_ON(thp_migration_supported() &&
>> -					  !is_pmd_migration_entry(vmf.orig_pmd));
>> -			if (is_pmd_migration_entry(vmf.orig_pmd))
>> -				pmd_migration_entry_wait(mm, vmf.pmd);
>> +			VM_BUG_ON(!thp_migration_supported() ||
>> +				  !is_pmd_migration_entry(vmf.orig_pmd));
>> +			pmd_migration_entry_wait(mm, vmf.pmd);
>>  			return 0;
>>  		}
>>  		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
>> -- 
>> 2.23.0
>>
>>
> 
> .
> 

