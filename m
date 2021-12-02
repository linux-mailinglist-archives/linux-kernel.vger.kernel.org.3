Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4BC466606
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358867AbhLBPCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358855AbhLBPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:02:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D726EC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 06:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1WNphMcAdkombOiw6dCsK+mjT7LQ9r9fCcLFCWswvmw=; b=hTuoMrOrhLyKDQayep1q0F5rek
        C5JwNz+NZwKw6i1pLN4Ok1sIv+c08e1wPj5MhVGEl/r34iJ3ZMwGHciRdJc8W31/MPwY8dQEBED3x
        yN30wAcCmvPAtkWgUnCBdChyrUpeBvwGZRGmGvMtYuenZgRFnjqVHjB6fHblzqmskcKCBXoZovbM2
        1uKI+XlWsNJRJA9rMsCMUC+OlHA3ePN+80aUEBwmYjH600A8WDLzxyfsk7y8MjqBRTnyWeWkJ+pot
        xigg4nd5c6IQC2YKzY3xGLUL5cWEmEJGhgi74GiuszZtRGNIzMXebTt4W3QX6imH+r0byeBXR1F26
        k7C+lw1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msnYI-004PSA-Oa; Thu, 02 Dec 2021 14:59:14 +0000
Date:   Thu, 2 Dec 2021 14:59:14 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Charan Teja Reddy <quic_charante@quicinc.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        rientjes@google.com, david@redhat.com, mhocko@suse.com,
        surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: Re: [PATCH v2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for
 shmem
Message-ID: <YajfQiEHYA6E5CeY@casper.infradead.org>
References: <1638442253-1591-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638442253-1591-1-git-send-email-quic_charante@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:20:53PM +0530, Charan Teja Reddy wrote:
> +static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
> +				loff_t end, struct list_head *list)
> +{
> +	XA_STATE(xas, &mapping->i_pages, start);
> +	struct page *page;
> +
> +	rcu_read_lock();
> +	xas_for_each(&xas, page, end) {
> +		if (xas_retry(&xas, page))
> +			continue;
> +		if (xa_is_value(page))
> +			continue;
> +		if (!get_page_unless_zero(page))
> +			continue;
> +		if (isolate_lru_page(page))
> +			continue;
> +
> +		list_add(&page->lru, list);
> +		inc_node_page_state(page, NR_ISOLATED_ANON +
> +						page_is_file_lru(page));

... what if the page is a THP?
