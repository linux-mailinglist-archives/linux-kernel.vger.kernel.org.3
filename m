Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9129D597DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbiHRFHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbiHRFHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:07:09 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E12A1D68
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:07:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VMZPdun_1660799221;
Received: from 30.97.48.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMZPdun_1660799221)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 13:07:02 +0800
Message-ID: <ad3f36ca-5027-45a5-cd48-dc32bf968c9d@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 13:07:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/damon: Validate if the pmd entry is present before
 accessing
To:     Muchun Song <muchun.song@linux.dev>
Cc:     sj@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, Linux MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <2838b6737bc259cf575ff11fd1c4b7fdb340fa73.1660717122.git.baolin.wang@linux.alibaba.com>
 <5173E308-2403-4667-9162-865CF7F11838@linux.dev>
 <ceaa1e54-e79a-86c7-cf35-d4159088f0f3@linux.alibaba.com>
 <6F99AE03-3C74-4E5B-87E1-6F3232BEEBB5@linux.dev>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <6F99AE03-3C74-4E5B-87E1-6F3232BEEBB5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2022 11:39 AM, Muchun Song wrote:
> 
> 
>> On Aug 18, 2022, at 10:57, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 8/18/2022 10:41 AM, Muchun Song 写道:
>>>> On Aug 17, 2022, at 14:21, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>> The pmd_huge() is used to validate if the pmd entry is mapped by a huge
>>>> page, also including the case of non-present (migration or hwpoisoned)
>>>> pmd entry on arm64 or x86 architectures. Thus we should validate if it
>>>> is present before making the pmd entry old or getting young state,
>>>> otherwise we can not get the correct corresponding page.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>> mm/damon/vaddr.c | 10 ++++++++++
>>>> 1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
>>>> index 3c7b9d6..1d16c6c 100644
>>>> --- a/mm/damon/vaddr.c
>>>> +++ b/mm/damon/vaddr.c
>>>> @@ -304,6 +304,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>>>>
>>>> 	if (pmd_huge(*pmd)) {
>>>> 		ptl = pmd_lock(walk->mm, pmd);
>>>> +		if (!pmd_present(*pmd)) {
>>> Unluckily, we should use pte_present here. See commit c9d398fa23788. We can use
>>> huge_ptep_get() to get a hugetlb pte, so it’s better to put the check after
>>> pmd_huge.
>>
>> IMO this is not the case for hugetlb, and the hugetlb case will be handled by damon_mkold_hugetlb_entry(), which already used pte_present() for hugetlb case.
> 
> Well, I thought it is hugetlb related since I saw the usage of pmd_huge. If it is THP case, why
> not use pmd_trans_huge?

IIUC, it can not guarantee the pmd is present if pmd_trans_huge() 
returns true on all architectures, at least on X86, we still need 
pmd_present() validation. So changing to pmd_trans_huge() does not make 
code simpler from my side, and I prefer to keep this patch.

Maybe we can send another cleanup patch to replace pmd_huge() with 
pmd_trans_huge() for THP case to make code more readable? How do you 
think? Thanks.

>>
>>> Cc Mike to make sure I am not missing something.
>>> Muchun,
>>> Thanks.
>>>> +			spin_unlock(ptl);
>>>> +			return 0;
>>>> +		}
>>>> +
>>>> 		if (pmd_huge(*pmd)) {
>>>> 			damon_pmdp_mkold(pmd, walk->mm, addr);
>>>> 			spin_unlock(ptl);
>>>> @@ -431,6 +436,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>>>> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> 	if (pmd_huge(*pmd)) {
>>>> 		ptl = pmd_lock(walk->mm, pmd);
>>>> +		if (!pmd_present(*pmd)) {
>>>> +			spin_unlock(ptl);
>>>> +			return 0;
>>>> +		}
>>>> +
>>>> 		if (!pmd_huge(*pmd)) {
>>>> 			spin_unlock(ptl);
>>>> 			goto regular_page;
>>>> -- 
>>>> 1.8.3.1
