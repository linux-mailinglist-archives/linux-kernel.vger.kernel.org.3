Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB384B049F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiBJErd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:47:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiBJErW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:47:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6DA521A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 20:47:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCB09ED1;
        Wed,  9 Feb 2022 20:47:18 -0800 (PST)
Received: from [10.163.46.244] (unknown [10.163.46.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 682623F718;
        Wed,  9 Feb 2022 20:47:17 -0800 (PST)
Subject: Re: [PATCH] arm64/migration: Define arm64_hugetlb_valid_size()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <1644197468-26755-1-git-send-email-anshuman.khandual@arm.com>
 <YgQJPVUWMruiq74O@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <88ebbd30-2fcf-fef3-077c-1b8163cb7409@arm.com>
Date:   Thu, 10 Feb 2022 10:17:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YgQJPVUWMruiq74O@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/22 12:04 AM, Catalin Marinas wrote:
> On Mon, Feb 07, 2022 at 07:01:08AM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index ffb9c229610a..dcdc4c0c3bd8 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -56,24 +56,12 @@ void __init arm64_hugetlb_cma_reserve(void)
>>  }
>>  #endif /* CONFIG_CMA */
>>  
>> +static bool arm64_hugetlb_valid_size(unsigned long size);
>> +
>>  #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>>  bool arch_hugetlb_migration_supported(struct hstate *h)
>>  {
>> -	size_t pagesize = huge_page_size(h);
>> -
>> -	switch (pagesize) {
>> -#ifndef __PAGETABLE_PMD_FOLDED
>> -	case PUD_SIZE:
>> -		return pud_sect_supported();
>> -#endif
>> -	case PMD_SIZE:
>> -	case CONT_PMD_SIZE:
>> -	case CONT_PTE_SIZE:
>> -		return true;
>> -	}
>> -	pr_warn("%s: unrecognized huge page size 0x%lx\n",
>> -			__func__, pagesize);
>> -	return false;
>> +	return arm64_hugetlb_valid_size(huge_page_size(h));
>>  }
>>  #endif
>>  
>> @@ -504,7 +492,7 @@ static int __init hugetlbpage_init(void)
>>  }
>>  arch_initcall(hugetlbpage_init);
>>  
>> -bool __init arch_hugetlb_valid_size(unsigned long size)
>> +static bool arm64_hugetlb_valid_size(unsigned long size)
>>  {
>>  	switch (size) {
>>  #ifndef __PAGETABLE_PMD_FOLDED
>> @@ -517,5 +505,12 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
>>  		return true;
>>  	}
>>  
>> +	pr_warn("%s: unrecognized huge page size 0x%lx\n",
>> +		__func__, size);
>>  	return false;
>>  }
> 
> We already have the warnings in the caller of arch_hugetlb_valid_size(),
> I wouldn't add another here. You can keep it in
> arch_hugetlb_migration_supported() though.

Sure, make sense. Will change it to something like this.

bool arch_hugetlb_migration_supported(struct hstate *h)
{
        size_t pagesize = huge_page_size(h);

        if (!arm64_hugetlb_valid_size(pagesize)) {
                pr_warn("%s: unrecognized huge page size 0x%lx\n",
                        __func__, pagesize);
                return false;
        }
        return true;
}

> 
>> +
>> +bool __init arch_hugetlb_valid_size(unsigned long size)
>> +{
>> +	return arm64_hugetlb_valid_size(size);
>> +}
> 
> What's wrong with keeping the arch_hugetlb_valid_size() name and just
> removing __init?
> 

When arch_hugetlb_migration_supported() calls arch_hugetlb_valid_size(),

With __init for arch_hugetlb_valid_size(), there is a build problem.

WARNING: modpost: vmlinux.o(.text.unlikely+0xf18): Section mismatch in
reference from the function arch_hugetlb_migration_supported() to the
function .init.text:arch_hugetlb_valid_size()
The function arch_hugetlb_migration_supported() references
the function __init arch_hugetlb_valid_size().
This is often because arch_hugetlb_migration_supported lacks a __init 
annotation or the annotation of arch_hugetlb_valid_size is wrong.

Without __init for arch_hugetlb_valid_size(), there is the same problem.

WARNING: modpost: vmlinux.o(.text.unlikely+0xf18): Section mismatch in
reference from the function arch_hugetlb_migration_supported() to the
function .init.text:arch_hugetlb_valid_size()
The function arch_hugetlb_migration_supported() references
the function __init arch_hugetlb_valid_size().
This is often because arch_hugetlb_migration_supported lacks a __init 
annotation or the annotation of arch_hugetlb_valid_size is wrong.

This might be because generic prototype for arch_hugetlb_valid_size() has
__init attribute, which arch_hugetlb_migration_supported() does not have.

Hence a local static helper arm64_hugetlb_valid_size() which both these
generic functions can call into, looked appropriate.
