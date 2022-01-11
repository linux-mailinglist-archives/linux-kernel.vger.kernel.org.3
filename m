Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EDB48A6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347416AbiAKEH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:07:29 -0500
Received: from foss.arm.com ([217.140.110.172]:41626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232625AbiAKEHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:07:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E2921FB;
        Mon, 10 Jan 2022 20:07:23 -0800 (PST)
Received: from [10.163.72.245] (unknown [10.163.72.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 563423F774;
        Mon, 10 Jan 2022 20:07:20 -0800 (PST)
Subject: Re: [PATCH] mm/migration: Add trace events for THP migrations
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
References: <1641531575-28524-1-git-send-email-anshuman.khandual@arm.com>
 <20220110120351.44e60aed@gandalf.local.home>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <389876c9-dc71-ccf8-1c8a-8e30b55f1b0a@arm.com>
Date:   Tue, 11 Jan 2022 09:37:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220110120351.44e60aed@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/22 10:33 PM, Steven Rostedt wrote:
> On Fri,  7 Jan 2022 10:29:35 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> This adds two trace events for PMD based THP migration without split. These
>> events closely follow the implementation details like setting and removing
>> of PMD migration entries, which are essential operations for THP migration.
>>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v5.16-rc8
>>
>> Changes in V1:
>>
>> - Dropped mm, pmdp, page arguments from trace
>> - Updated trace argument names and output format
>>
>> Changes in RFC:
>>
>> https://lore.kernel.org/all/1640328398-20698-1-git-send-email-anshuman.khandual@arm.com/
>>
>>  include/trace/events/thp.h | 37 +++++++++++++++++++++++++++++++++++++
>>  mm/huge_memory.c           |  5 +++++
>>  2 files changed, 42 insertions(+)
>>
>> diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
>> index d7fbbe551841..193a555aa2ea 100644
>> --- a/include/trace/events/thp.h
>> +++ b/include/trace/events/thp.h
>> @@ -83,6 +83,43 @@ TRACE_EVENT(hugepage_splitting,
>>  		      __entry->addr, __entry->pte)
>>  );
>>  
>> +TRACE_EVENT(set_migration_pmd,
>> +
>> +	TP_PROTO(unsigned long addr, unsigned long pmd),
>> +
>> +	TP_ARGS(addr, pmd),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, addr)
>> +		__field(unsigned long, pmd)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->addr = addr;
>> +		__entry->pmd = pmd;
>> +	),
>> +
>> +	TP_printk("create pmd migration entry addr=%lx, pmd=%lx", __entry->addr, __entry->pmd)
>> +);
>> +
>> +TRACE_EVENT(remove_migration_pmd,
>> +
>> +	TP_PROTO(unsigned long addr, unsigned long pmd),
>> +
>> +	TP_ARGS(addr, pmd),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, addr)
>> +		__field(unsigned long, pmd)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->addr = addr;
>> +		__entry->pmd = pmd;
>> +	),
>> +
>> +	TP_printk("remove pmd migration entry addr=%lx, val=%lx", __entry->addr, __entry->pmd)
> 
> The two above are pretty much identical, except the first one has "pmd=%lx"
> for the pmd, and the second has "val=%lx" for the pmd. I'd suggest they
> both be the same, and then you could save memory by combining the two into

Right, both can be the same 'pmd=%lx'.

> DECLARE_EVENT_CLASS() / DEFINE_EVENT() macros:
> 
> DECLARE_EVENT_CLASS(migration_pmd,
> 
> 	TP_PROTO(unsigned long addr, unsigned long pmd),
> 
> 	TP_ARGS(addr, pmd),
> 
> 	TP_STRUCT__entry(
> 		__field(unsigned long, addr)
> 		__field(unsigned long, pmd)
> 	),
> 
> 	TP_fast_assign(
> 		__entry->addr = addr;
> 		__entry->pmd = pmd;
> 	),
> 
> 	TP_printk("create pmd migration entry addr=%lx, pmd=%lx", __entry->addr, __entry->pmd)
> );
> 
> DEFINE_EVENT(migration_pmd, set_migration_pmd,
> 	TP_PROTO(unsigned long addr, unsigned long pmd),
> 	TP_ARGS(addr, pmd)
> );
> 
> DEFINE_EVENT(migration_pmd, remove_migration_pmd,
> 	TP_PROTO(unsigned long addr, unsigned long pmd),
> 	TP_ARGS(addr, pmd)
> );
> 
> And then you have the same thing, but it combines the code which saves both
> data and text.

But both need to print different messages. Hence I am wondering whether
a (const char *) based message can be passed down here as well.

create pmd migration entry addr=%lx, pmd=%lx
remove pmd migration entry addr=%lx, pmd=%lx

> 
> -- Steve
> 
>> +);
>>  #endif /* _TRACE_THP_H */
>>  
>>  /* This part must be outside protection */
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index e5483347291c..d0adc019afe0 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -39,6 +39,9 @@
>>  #include <asm/pgalloc.h>
>>  #include "internal.h"
>>  
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/thp.h>
>> +
>>  /*
>>   * By default, transparent hugepage support is disabled in order to avoid
>>   * risking an increased memory footprint for applications that are not
>> @@ -3173,6 +3176,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>>  	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
>>  	page_remove_rmap(page, true);
>>  	put_page(page);
>> +	trace_set_migration_pmd(address, pmd_val(pmdswp));
>>  }
>>  
>>  void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>> @@ -3206,5 +3210,6 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
>>  	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
>>  		mlock_vma_page(new);
>>  	update_mmu_cache_pmd(vma, address, pvmw->pmd);
>> +	trace_remove_migration_pmd(address, pmd_val(pmde));
>>  }
>>  #endif
> 
