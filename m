Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326A646C716
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242015AbhLGWLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbhLGWLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:11:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F799C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p2HVXIrwF23DFq4/7NiWJ9lVGEQY74Pg2xDdCxWPG8Y=; b=LGgYXZ/qd/ovlj7hYPn79Gwyr+
        Ji17rxXwSHQefPxCBGt6uKy08/w9OMnvtk3y2K87RFNxp2IA/thktCGNo8cbh1/7p9VErIYSKamj/
        Mhp+zwAuitJ9RShXUeXiU+gWbHtD0LOnRVimcn61Ks5Lq5lSiWSsy4fKendTyWJA8c/w0j5gRwH8f
        eAx34R8MmJMjT+HfsU5JMvo9VParjfMRYSVc4ERuK5ci6gTv8Qdb31Pw1JIyjPRfVVaY+vk9Ha0gO
        eW/OH4lhuAq7Rb+kVDLA2oCiBVCqEhgn45d2dhMZPBAHcSSH0XmZYVbTtRZ1rnJFXif6WO6F2YY9d
        FrY89R7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muicG-007oqq-2O; Tue, 07 Dec 2021 22:07:16 +0000
Date:   Tue, 7 Dec 2021 22:07:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/2] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
Message-ID: <Ya/bFLcnqyvlVzuO@casper.infradead.org>
References: <20211207215031.2251719-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207215031.2251719-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 01:50:30PM -0800, Suren Baghdasaryan wrote:
> - Added a comment for vm_operations_struct::close, documenting restriction for
> taking mmap_lock in the callback, per Michal Hocko and Matthew Wilcox

This should be a separate patch because it stands alone, but ...

>  struct vm_operations_struct {
>  	void (*open)(struct vm_area_struct * area);
> +    /*
> +     * Called with mmap_lock lock held for write from __split_vma and
> +     * remove_vma, therefore should never take that lock.
> +     */

Your whitespace indentation is weird.  And it'd be nice to make this a
kernel-doc comment (I know none of the others are, but that should be
fixed too).  And naming the functions that call it is wrong too.

	/**
	 * @close: Called when the VMA is being removed from the MM.
	 * Context: Caller holds mmap_lock.
	 */

