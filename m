Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC519482DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 04:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiACDyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 22:54:39 -0500
Received: from foss.arm.com ([217.140.110.172]:60756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbiACDyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 22:54:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3984B1FB;
        Sun,  2 Jan 2022 19:54:38 -0800 (PST)
Received: from [10.163.71.229] (unknown [10.163.71.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9BC33F66F;
        Sun,  2 Jan 2022 19:54:35 -0800 (PST)
Subject: Re: [RFC] mm/migration: Add trace events for THP migrations
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <1640328398-20698-1-git-send-email-anshuman.khandual@arm.com>
 <YcXdvnLC5SyiSZTc@casper.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <96524032-cf0f-42df-975a-00a0ea6ba227@arm.com>
Date:   Mon, 3 Jan 2022 09:24:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YcXdvnLC5SyiSZTc@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthew,

On 12/24/21 8:18 PM, Matthew Wilcox wrote:
> On Fri, Dec 24, 2021 at 12:16:38PM +0530, Anshuman Khandual wrote:
>> This adds two trace events for PMD based THP migration without split. These
>> events closely follow the implementation details like setting and removing
>> of PMD migration entries, which are essential operations for THP migration.
> 
> Why are you printing the address of a struct page?  What useful
> information does this supply?  Same question for the struct mm.
> And the pmdp, for that matter.

Just to make individual trace records comprehensive enough to capture
which (and where) the PMD entries went through migration entry state.
But is there any particular concern here capturing mm, page and pmdp ?

> 
> You haven't said _why_ you want these tracepoints.  So it's impossible
> to suggest what you _should_ be doing, because what you _are_ doing
> is obviously wrong.

Just for debug purpose. To see which (and where) PMD entries are being
migrated as is without a split, via PMD migration entries. Wondering if
you are suggesting just to capture addr, pmdval and just drop others ?

> 
>> +	TP_printk("mm=%p, address=%lx, pmdp=%p, page=%p pmdval=%lx",
>> +		__entry->mm,
>> +		__entry->address,
>> +		__entry->pmdp,
>> +		__entry->page,
>> +		__entry->pmdval)
>> +);
> 

- Anshuman
