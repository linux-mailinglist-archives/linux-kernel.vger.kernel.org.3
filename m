Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341894B7B49
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbiBOXja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:39:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiBOXj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:39:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 837479A4FB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:39:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A94E1396;
        Tue, 15 Feb 2022 15:39:17 -0800 (PST)
Received: from [10.163.46.213] (unknown [10.163.46.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A86FB3F66F;
        Tue, 15 Feb 2022 15:39:15 -0800 (PST)
Subject: Re: [PATCH V2] arm64/hugetlb: Define __hugetlb_valid_size()
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
References: <1644491770-16108-1-git-send-email-anshuman.khandual@arm.com>
 <20220215164851.GD8458@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e60802f2-dfb4-3824-9b85-7770c8fede96@arm.com>
Date:   Wed, 16 Feb 2022 05:09:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220215164851.GD8458@willie-the-truck>
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



On 2/15/22 10:18 PM, Will Deacon wrote:
> On Thu, Feb 10, 2022 at 04:46:10PM +0530, Anshuman Khandual wrote:
>> arch_hugetlb_valid_size() can be just factored out to create another helper
>> to be used in arch_hugetlb_migration_supported() as well. This just defines
>> __hugetlb_valid_size() for that purpose.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v5.17-rc3
>>
>> Changes in V2:
>>
>> - s/arm64_hugetlb_valid_size/__hugetlb_valid_size per Catalin
>> - Restored back warning in arch_hugetlb_migration_supported() per Catalin
>> - Updated the commit message subject line as required
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/all/1644197468-26755-1-git-send-email-anshuman.khandual@arm.com/
>>
>>  arch/arm64/mm/hugetlbpage.c | 26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index ffb9c229610a..72ed07fe2c84 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -56,24 +56,19 @@ void __init arm64_hugetlb_cma_reserve(void)
>>  }
>>  #endif /* CONFIG_CMA */
>>  
>> +static bool __hugetlb_valid_size(unsigned long size);
> 
> Why not reorder the code to avoid this forward declaration?

That will create more code churn, which I tried to avoid.
