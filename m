Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07D74B979A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiBQESI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:18:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiBQESG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:18:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7CC2172E7E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:17:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46B7C12FC;
        Wed, 16 Feb 2022 20:17:52 -0800 (PST)
Received: from [10.163.47.200] (unknown [10.163.47.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAACC3F66F;
        Wed, 16 Feb 2022 20:17:50 -0800 (PST)
Subject: Re: [PATCH V2] arm64/hugetlb: Define __hugetlb_valid_size()
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
References: <1644491770-16108-1-git-send-email-anshuman.khandual@arm.com>
 <20220215164851.GD8458@willie-the-truck>
 <e60802f2-dfb4-3824-9b85-7770c8fede96@arm.com>
 <20220216123048.GA9949@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9fdb1c70-3676-6454-d990-e430f2c61010@arm.com>
Date:   Thu, 17 Feb 2022 09:47:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220216123048.GA9949@willie-the-truck>
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



On 2/16/22 6:00 PM, Will Deacon wrote:
> On Wed, Feb 16, 2022 at 05:09:12AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 2/15/22 10:18 PM, Will Deacon wrote:
>>> On Thu, Feb 10, 2022 at 04:46:10PM +0530, Anshuman Khandual wrote:
>>>> arch_hugetlb_valid_size() can be just factored out to create another helper
>>>> to be used in arch_hugetlb_migration_supported() as well. This just defines
>>>> __hugetlb_valid_size() for that purpose.
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> This applies on v5.17-rc3
>>>>
>>>> Changes in V2:
>>>>
>>>> - s/arm64_hugetlb_valid_size/__hugetlb_valid_size per Catalin
>>>> - Restored back warning in arch_hugetlb_migration_supported() per Catalin
>>>> - Updated the commit message subject line as required
>>>>
>>>> Changes in V1:
>>>>
>>>> https://lore.kernel.org/all/1644197468-26755-1-git-send-email-anshuman.khandual@arm.com/
>>>>
>>>>  arch/arm64/mm/hugetlbpage.c | 26 +++++++++++++-------------
>>>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>>> index ffb9c229610a..72ed07fe2c84 100644
>>>> --- a/arch/arm64/mm/hugetlbpage.c
>>>> +++ b/arch/arm64/mm/hugetlbpage.c
>>>> @@ -56,24 +56,19 @@ void __init arm64_hugetlb_cma_reserve(void)
>>>>  }
>>>>  #endif /* CONFIG_CMA */
>>>>  
>>>> +static bool __hugetlb_valid_size(unsigned long size);
>>>
>>> Why not reorder the code to avoid this forward declaration?
>>
>> That will create more code churn, which I tried to avoid.
> 
> Isn't it just moving a handful of lines further up in the file? What's
> the problem with that?

No problem as such, will change and resend.
