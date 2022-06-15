Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE08C54C0F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbiFOFCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiFOFCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:02:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B5E718350
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:02:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D00C175A;
        Tue, 14 Jun 2022 22:02:35 -0700 (PDT)
Received: from [10.163.41.27] (unknown [10.163.41.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B80373F66F;
        Tue, 14 Jun 2022 22:02:32 -0700 (PDT)
Message-ID: <7c363619-4159-8a21-d55a-535e21b5c8b4@arm.com>
Date:   Wed, 15 Jun 2022 10:32:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm/shmem.c: use helper transhuge_vma_enabled()
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220611022314.21593-1-linmiaohe@huawei.com>
 <8b34a515-e5fd-731a-4164-9080c275d4e9@google.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <8b34a515-e5fd-731a-4164-9080c275d4e9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/22 08:44, Hugh Dickins wrote:
> On Sat, 11 Jun 2022, Miaohe Lin wrote:
> 
>> Use helper transhuge_vma_enabled() to check whether transhuge is enable
>> on vma. Minor readability improvement.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> No thanks, that's a readability regression, forcing reader
> to go and look up what transhuge_vma_enabled() actually means.
> 
> What you call a helper, I call an obfuscator - as I implied in
> b9e2faaf6fa0 ("huge tmpfs: revert shmem's use of transhuge_vma_enabled()")

The same reasoning should also be applicable for other calls sites
for transhuge_vma_enabled(). Should not they be dropped as well ?

> 
> Hugh
> 
>> ---
>>  mm/shmem.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 133c67057d41..59cc2e980c95 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -480,8 +480,7 @@ bool shmem_is_huge(struct vm_area_struct *vma,
>>  		return false;
>>  	if (shmem_huge == SHMEM_HUGE_DENY)
>>  		return false;
>> -	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
>> -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
>> +	if (vma && !transhuge_vma_enabled(vma, vma->vm_flags))
>>  		return false;
>>  	if (shmem_huge == SHMEM_HUGE_FORCE)
>>  		return true;
>> -- 
>> 2.23.0
> 
