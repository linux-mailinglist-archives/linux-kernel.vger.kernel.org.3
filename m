Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823FB4A548A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiBABOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:14:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43482 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiBABOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:14:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0E36B82CD0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 01:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919CAC340EC;
        Tue,  1 Feb 2022 01:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643678076;
        bh=iDZ+K89IPcIeDF2+KSlI8ytWO8Ygxgu09Pw+Zwf1JDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oSO9eAErVKISl9lFXT7Y6DX6NTzAX76VfwBTdjHjefW0x52T8Suv9AAlzX3jlgArX
         1AA4Gx0j4h3uXhg9NvAUYxU1SXFWURyt0fWQy2LA7SM3YCbK4DF5Z2zbjYL6kMFz+n
         kb+85H0UUhtMzSraRMLKk6GGeVMHQ77zW89WOj94=
Date:   Mon, 31 Jan 2022 17:14:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 00/35] Speculative page faults
Message-Id: <20220131171434.89870a8f1ae294912e7ff19e@linux-foundation.org>
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 05:09:31 -0800 Michel Lespinasse <michel@lespinasse.org> wrote:

> Patchset summary:
> 
> Classical page fault processing takes the mmap read lock in order to
> prevent races with mmap writers. In contrast, speculative fault
> processing does not take the mmap read lock, and instead verifies,
> when the results of the page fault are about to get committed and
> become visible to other threads, that no mmap writers have been
> running concurrently with the page fault. If the check fails,
> speculative updates do not get committed and the fault is retried
> in the usual, non-speculative way (with the mmap read lock held).
> 
> The concurrency check is implemented using a per-mm mmap sequence count.
> The counter is incremented at the beginning and end of each mmap write
> operation. If the counter is initially observed to have an even value,
> and has the same value later on, the observer can deduce that no mmap
> writers have been running concurrently with it between those two times.
> This is similar to a seqlock, except that readers never spin on the
> counter value (they would instead revert to taking the mmap read lock),
> and writers are allowed to sleep. One benefit of this approach is that
> it requires no writer side changes, just some hooks in the mmap write
> lock APIs that writers already use.
> 
> The first step of a speculative page fault is to look up the vma and
> read its contents (currently by making a copy of the vma, though in
> principle it would be sufficient to only read the vma attributes that
> are used in page faults). The mmap sequence count is used to verify
> that there were no mmap writers concurrent to the lookup and copy steps.
> Note that walking rbtrees while there may potentially be concurrent
> writers is not an entirely new idea in linux, as latched rbtrees
> are already doing this. This is safe as long as the lookup is
> followed by a sequence check to verify that concurrency did not
> actually occur (and abort the speculative fault if it did).

I'm surprised that descending the rbtree locklessly doesn't flat-out
oops the kernel.  How are we assured that every pointer which is
encountered actually points at the right thing?  Against things
which tear that tree down?

> The next step is to walk down the existing page table tree to find the
> current pte entry. This is done with interrupts disabled to avoid
> races with munmap().

Sebastian, could you please comment on this from the CONFIG_PREEMPT_RT
point of view?

> Again, not an entirely new idea, as this repeats
> a pattern already present in fast GUP. Similar precautions are also
> taken when taking the page table lock.
> 
> Breaking COW on an existing mapping may require firing MMU notifiers.
> Some care is required to avoid racing with registering new notifiers.
> This patchset adds a new per-cpu rwsem to handle this situation.

