Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F344B4AE87C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbiBIEMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346302AbiBIDXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:23:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4568FC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:23:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0CC2ED1;
        Tue,  8 Feb 2022 19:23:49 -0800 (PST)
Received: from [10.163.46.128] (unknown [10.163.46.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 512343F73B;
        Tue,  8 Feb 2022 19:23:46 -0800 (PST)
Subject: Re: [RFC V1 02/31] mm/mmap: Clarify protection_map[] indices
To:     Firo Yang <firogm@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-3-git-send-email-anshuman.khandual@arm.com>
 <20220205091048.g3fk4eaw7p7itgil@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <83958cb9-cca7-1e48-f0c8-0d101dbeebc8@arm.com>
Date:   Wed, 9 Feb 2022 08:53:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220205091048.g3fk4eaw7p7itgil@gmail.com>
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



On 2/5/22 2:40 PM, Firo Yang wrote:
> The 01/24/2022 18:26, Anshuman Khandual wrote:
>> protection_map[] maps vm_flags access combinations into page protection
>> value as defined by the platform via __PXXX and __SXXX macros. The array
>> indices in protection_map[], represents vm_flags access combinations but
>> it's not very intuitive to derive. This makes it clear and explicit.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  mm/mmap.c | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 1e8fdb0b51ed..254d716220df 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -102,8 +102,22 @@ static void unmap_region(struct mm_struct *mm,
>>   *								x: (yes) yes
>>   */
>>  pgprot_t protection_map[16] __ro_after_init = {
>> -	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>> -	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>> +	[VM_NONE]				= __P000,
>> +	[VM_READ]				= __P001,
>> +	[VM_WRITE]				= __P010,
>> +	[VM_READ|VM_WRITE]			= __P011,
>> +	[VM_EXEC]				= __P100,
>> +	[VM_EXEC|VM_READ]			= __P101,
>> +	[VM_EXEC|VM_WRITE]			= __P110,
>> +	[VM_EXEC|VM_READ|VM_WRITE]		= __P111,
>> +	[VM_SHARED]				= __S000,
>> +	[VM_SHARED|VM_READ]			= __S001,
>> +	[VM_SHARED|VM_WRITE]			= __S010,
>> +	[VM_SHARED|VM_READ|VM_WRITE]		= __S011,
>> +	[VM_SHARED|VM_EXEC]			= __S100,
>> +	[VM_SHARED|VM_READ|VM_EXEC]		= __S101,
>> +	[VM_SHARED|VM_WRITE|VM_EXEC]		= __S110,
>> +	[VM_SHARED|VM_READ|VM_WRITE|VM_EXEC]	= __S111
> 
> Just a little bit picky:)
> Would you mind rearranging vm_flags access commbination in the order as
> the access bits appear in __SXXX or __PXXX? For example, change the following:
> 
> 	[VM_SHARED|VM_READ|VM_WRITE|VM_EXEC]    = __S111
> to
> 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __S111
> 
> I think it's would be more clear for looking.

So the vm_flags combination set here (and like in the platforms)
should be like the following ..

[VM_NONE]
[VM_READ]
[VM_WRITE]
[VM_WRITE | VM_READ]
[VM_EXEC]	
[VM_EXEC|VM_READ]
[VM_EXEC|VM_WRITE]
[VM_EXEC|VM_WRITE | VM_READ]
[VM_SHARED]
[VM_SHARED|VM_READ]
[VM_SHARED|VM_WRITE]
[VM_SHARED|VM_WRITE | VM_READ]
[VM_SHARED|VM_EXEC]
[VM_SHARED|VM_EXEC | VM_READ]
[VM_SHARED|VM_EXEC | VM_WRITE]
[VM_SHARED|VM_EXEC | VM_WRITE | VM_READ]

Implying the relative position for these flags among each other.
 
[VM_SHARED] [VM_EXEC]  [VM_WRITE] [VM_WRITE]

This makes sense, will change the series accordingly.

- Anshuman
