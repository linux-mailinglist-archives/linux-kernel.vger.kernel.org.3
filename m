Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8914FF4F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiDMKmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiDMKmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:42:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14DAB515B5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:39:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C37471570;
        Wed, 13 Apr 2022 03:39:52 -0700 (PDT)
Received: from [10.57.41.233] (unknown [10.57.41.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113D03F73B;
        Wed, 13 Apr 2022 03:39:50 -0700 (PDT)
Message-ID: <64d4288e-7776-a3fd-5ee4-70486dfd0394@arm.com>
Date:   Wed, 13 Apr 2022 11:39:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] arm64: mm: fix pmd_leaf()
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, lengxujun2007@126.com, arnd@arndb.de,
        smuchun@gmail.com, duanxiongchun@bytedance.com,
        quic_qiancai@quicinc.com, aneesh.kumar@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220411122653.40284-1-songmuchun@bytedance.com>
 <20220413101929.GA1229@willie-the-truck>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220413101929.GA1229@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 11:19, Will Deacon wrote:
> On Mon, Apr 11, 2022 at 08:26:53PM +0800, Muchun Song wrote:
>> The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
>> the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
>> caused by this was reported by Qian Cai.
>>
>> Link: https://patchwork.kernel.org/comment/24798260/ [1]
>> Fixes: 8aa82df3c123 ("arm64: mm: add p?d_leaf() definitions")
>> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> v2:
>> - Replace pmd_present() with pmd_val() since we expect pmd_leaf() works
>>   well on non-present pmd case.
>>
>>  arch/arm64/include/asm/pgtable.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index ad9b221963d4..00cdd2d895d3 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -551,7 +551,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>>  				 PMD_TYPE_TABLE)
>>  #define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
>>  				 PMD_TYPE_SECT)
>> -#define pmd_leaf(pmd)		pmd_sect(pmd)
>> +#define pmd_leaf(pmd)		(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
>>  #define pmd_bad(pmd)		(!pmd_table(pmd))
> 
> I'm still trying to get my head around the desired semantics here.
> 
> If we want to fix the original report, then we need to take PROT_NONE
> entries into account. The easiest way to do that is, as you originally
> suggested, by using pmd_present():
> 
> #define pmd_leaf(pmd)	(pmd_present(pmd) && !pmd_table(pmd))
> 
> But now you seem to be saying that !pmd_present() entries should also be
> considered as pmd_leaf() -- is there a real need for that?
> 
> If so, then I think this simply becomes:
> 
> #define pmd_leaf(pmd)	(!pmd_table(pmd))
> 
> which is, amusingly, identical to pmd_bad().
> 
> The documentation/comment that Steven referred to also desperately needs
> clarifying as it currently states:
> 
>   "Only meaningful when called on a valid entry."
> 
> whatever that means.

The intention at the time is that this had the same meaning as
pmd_huge() (when CONFIG_HUGETLB_PAGE is defined), which would then match
this patch. This is referred in the comment, albeit in a rather weak way:

>  * This differs from p?d_huge() by the fact that they are always available (if
>  * the architecture supports large pages at the appropriate level) even
>  * if CONFIG_HUGETLB_PAGE is not defined.

However, the real issue here is that the definition of pmd_leaf() isn't
clear. I know what the original uses of it needed but since then it's
been used in other areas, and I'm afraid my 'documentation' isn't
precise enough to actually be useful.

At the time I wrote that comment I think I meant "valid" in the AArch64
sense (i.e. the LSB of the entry). PROT_NONE isn't 'valid' by that
definition (and I hadn't considered it). But of course that definition
of 'valid' is pretty meaningless in the cross-architecture case.

So I think we also need updated documentation which describes the
required semantics in an architecture-agnostic way.

Steve

> Finally, if this has implications beyond PROT_NONE (as I think you're
> suggesting in your v2) then pud_leaf() probably needs similar treatment.
> And we can remove pmd_sect() altogether if we no longer need it.
> 
> Will

