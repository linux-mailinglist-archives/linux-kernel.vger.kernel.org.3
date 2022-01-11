Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D4C48A6F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiAKFBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:01:30 -0500
Received: from foss.arm.com ([217.140.110.172]:41870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbiAKFBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:01:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D173D1FB;
        Mon, 10 Jan 2022 21:01:19 -0800 (PST)
Received: from [10.163.72.245] (unknown [10.163.72.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDB923F774;
        Mon, 10 Jan 2022 21:01:16 -0800 (PST)
Subject: Re: [PATCH] mm/migration: Add trace events for THP migrations
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
References: <1641531575-28524-1-git-send-email-anshuman.khandual@arm.com>
 <20220111015822.GA799985@u2004>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ee99799c-4e88-a7f5-0ec2-64cd710051e5@arm.com>
Date:   Tue, 11 Jan 2022 10:31:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220111015822.GA799985@u2004>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/22 7:28 AM, Naoya Horiguchi wrote:
> Hi Anshuman,
> 
> On Fri, Jan 07, 2022 at 10:29:35AM +0530, Anshuman Khandual wrote:
>> This adds two trace events for PMD based THP migration without split. These
>> events closely follow the implementation details like setting and removing
>> of PMD migration entries, which are essential operations for THP migration.
> 
> I often want to check which individual pages are migrated to which places
> (or not migrated) for testing, so these new tracepoints could help me.
> Maybe these can be much greater if they can handle other types of page
> migration for raw pages and hugetlb pages.  Is it hard to cover all such
> page migration events?

Are you suggesting to cover all migration entry transitions for normal
and HugeTLB pages as well ?

migrate_pages()
	unmap_and_move_huge_page()
		try_to_migrate()
			make_writable_migration_entry() <---
			make_readable_migration_entry() <---
		remove_migration_ptes() <---
	unmap_and_move()
		__unmap_and_move()
			try_to_migrate()
				make_writable_migration_entry() <---
				make_readable_migration_entry() <---
			remove_migration_ptes() <---
> 
> Thanks,
> Naoya Horiguchi
> 
