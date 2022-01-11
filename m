Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC3E48A807
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348367AbiAKG6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbiAKG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:58:08 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF57BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 22:58:07 -0800 (PST)
Date:   Tue, 11 Jan 2022 15:57:56 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641884285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWv0f5f+fPdDGe3k1xHWjG81ExIIKRuEoGoQtrB/3SI=;
        b=vvfPxJwWak84H/tM+eJWeI6hGtEjOgXqwK+Z0G1lvxct/n/ZXjZgWTazzHW6Mt98LnNvWo
        cyYcq2iwyuCO3XgRH/N7IdUTeY3xyplPKF6B3GHZW37RJcK7t6kmT1LUdQp6lVphnX1b1s
        fvMffVZcgT/erW1ffzUxVE1yrZSgWQw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migration: Add trace events for THP migrations
Message-ID: <20220111065756.GA808887@u2004>
References: <1641531575-28524-1-git-send-email-anshuman.khandual@arm.com>
 <20220111015822.GA799985@u2004>
 <ee99799c-4e88-a7f5-0ec2-64cd710051e5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee99799c-4e88-a7f5-0ec2-64cd710051e5@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:31:21AM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/11/22 7:28 AM, Naoya Horiguchi wrote:
> > Hi Anshuman,
> > 
> > On Fri, Jan 07, 2022 at 10:29:35AM +0530, Anshuman Khandual wrote:
> >> This adds two trace events for PMD based THP migration without split. These
> >> events closely follow the implementation details like setting and removing
> >> of PMD migration entries, which are essential operations for THP migration.
> > 
> > I often want to check which individual pages are migrated to which places
> > (or not migrated) for testing, so these new tracepoints could help me.
> > Maybe these can be much greater if they can handle other types of page
> > migration for raw pages and hugetlb pages.  Is it hard to cover all such
> > page migration events?
> 
> Are you suggesting to cover all migration entry transitions for normal
> and HugeTLB pages as well ?

Yes if you like the idea. I think that some events listed below can be grouped
into one tracepoint event with showing args like pgsize or read/write flags
(or implementation detail is up to you).

> 
> migrate_pages()
> 	unmap_and_move_huge_page()
> 		try_to_migrate()
> 			make_writable_migration_entry() <---
> 			make_readable_migration_entry() <---
> 		remove_migration_ptes() <---
> 	unmap_and_move()
> 		__unmap_and_move()
> 			try_to_migrate()
> 				make_writable_migration_entry() <---
> 				make_readable_migration_entry() <---
> 			remove_migration_ptes() <---

Thanks,
Naoya Horiguchi
