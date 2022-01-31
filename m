Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A24A3CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 04:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357500AbiAaDZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 22:25:21 -0500
Received: from foss.arm.com ([217.140.110.172]:53890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236781AbiAaDZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 22:25:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92B49ED1;
        Sun, 30 Jan 2022 19:25:18 -0800 (PST)
Received: from [10.163.44.9] (unknown [10.163.44.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 303A33F774;
        Sun, 30 Jan 2022 19:25:15 -0800 (PST)
Subject: Re: [RFC V1 02/31] mm/mmap: Clarify protection_map[] indices
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <1643029028-12710-3-git-send-email-anshuman.khandual@arm.com>
 <YfKSn6u3YsErB/Ky@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <904f9623-0f02-9530-1d66-017baa082349@arm.com>
Date:   Mon, 31 Jan 2022 08:55:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfKSn6u3YsErB/Ky@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/22 6:09 PM, Mike Rapoport wrote:
> On Mon, Jan 24, 2022 at 06:26:39PM +0530, Anshuman Khandual wrote:
>> protection_map[] maps vm_flags access combinations into page protection
>> value as defined by the platform via __PXXX and __SXXX macros. The array
>> indices in protection_map[], represents vm_flags access combinations but
>> it's not very intuitive to derive. This makes it clear and explicit.
> 
> The protection_map is going to be removed in one of the next patches, why
> bother with this patch at all?
This makes the transition from protection_map[] into __vm_get_page_prot()
more intuitive, where protection_map[] gets dropped. This helps platforms
(first ones subscribing ARCH_HAS_VM_GET_PAGE_PROT before this drop) create
/formulate the required switch case elements in their vm_get_page_prot().

The existing protection_map[] is not clear in demonstrating how exactly
the vm_flags combination is mapped into page protection map. This helps
clarify the underlying switch before we move on defining it on platforms.

>  
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
>>  };
>>  
>>  #ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
>> -- 
>> 2.25.1
>>
>>
> 
