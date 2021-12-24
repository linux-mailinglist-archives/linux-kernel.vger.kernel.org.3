Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203C747EFB3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343840AbhLXOsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343849AbhLXOsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:48:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081F4C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 06:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h6TSfmTuL7ftgtvLoRTjxtkYWFFbSSFkXY0fzO/SUDY=; b=m2TYgIu4yzYXx0XYdpBiRwbNdt
        P4mOpo74aj/PPHaO1zHmqggesyBIVDuMVzHS7swl6OJIXgvhcATBwM0MmXjRNqIatHfqXSu54jivG
        0yLIDXg9lRzqsVv1YAFdomGOrb402lCbWPRhQ+IboMWkR25LacY5FOAHrmFV9Tnt0PPc1Coh+E/yA
        BtHg8IBNlbKO05KweDFxYCUWUv248FEvJJsNZLa4I11x6SCVt5yb/Fmw+zQWqMCXnJv9uXhWEmR8p
        XanKG7dICCGO/XtareJpHGUv/V/XhKwKmBD62XBQY6UQvOiFsSM0SIURxMlFB0XHBegEnrMcX15Ra
        TfZwyiNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0lry-005ARv-Nn; Fri, 24 Dec 2021 14:48:30 +0000
Date:   Fri, 24 Dec 2021 14:48:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/migration: Add trace events for THP migrations
Message-ID: <YcXdvnLC5SyiSZTc@casper.infradead.org>
References: <1640328398-20698-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640328398-20698-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 12:16:38PM +0530, Anshuman Khandual wrote:
> This adds two trace events for PMD based THP migration without split. These
> events closely follow the implementation details like setting and removing
> of PMD migration entries, which are essential operations for THP migration.

Why are you printing the address of a struct page?  What useful
information does this supply?  Same question for the struct mm.
And the pmdp, for that matter.

You haven't said _why_ you want these tracepoints.  So it's impossible
to suggest what you _should_ be doing, because what you _are_ doing
is obviously wrong.

> +	TP_printk("mm=%p, address=%lx, pmdp=%p, page=%p pmdval=%lx",
> +		__entry->mm,
> +		__entry->address,
> +		__entry->pmdp,
> +		__entry->page,
> +		__entry->pmdval)
> +);
