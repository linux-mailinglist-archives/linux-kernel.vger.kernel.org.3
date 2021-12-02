Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E4446647B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357992AbhLBNan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346690AbhLBNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:30:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1EC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 05:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N8VxYpGE+2Elyrz/sMTX7Mk/aRqmYqSy1LMlq3q5uls=; b=R1PZBTV6rorn2BRra37YZ8vc+j
        oR7AeNuq9scGaKUgNOxlHYZTbGzTYDWWv/RIRCYxJ5T8VUC83uIXH3yf3X4Mch79znEb2QEvPc3tZ
        R3lNK3b/bwElqKsnOX5uC3U+vVPrTo7URf6AJwSnSyKu8fb4WGnI1lnzt2YE99rnz1jRQIhUNv3o8
        fLDhOJ3GX0oJ4Zf7flF8nTUoRB7b4vMG441ZX1gQjZYowcvb6hUknerhR1t/TkLxzWyMfUDTZam3q
        bdr0Sjcwu+mkqzL8a+L19h7d4i4HKIHgi0W47OvwjjXBojbXNuNg2q3vhJcNObac1KqWQ8HrbWsmn
        Alq+vHjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msm77-0046py-K8; Thu, 02 Dec 2021 13:27:05 +0000
Date:   Thu, 2 Dec 2021 13:27:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Charan Teja Reddy <quic_charante@quicinc.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        rientjes@google.com, david@redhat.com, mhocko@suse.com,
        surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: Re: [PATCH v2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for
 shmem
Message-ID: <YajJqY2ByC8uwa46@casper.infradead.org>
References: <1638442253-1591-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638442253-1591-1-git-send-email-quic_charante@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:20:53PM +0530, Charan Teja Reddy wrote:
> +static int shmem_fadvise_willneed(struct address_space *mapping,
> +				 pgoff_t start, pgoff_t long end)
> +{
> +	XA_STATE(xas, &mapping->i_pages, start);
> +	struct page *page;
> +
> +	rcu_read_lock();
> +	page = xas_find(&xas, end);
> +	rcu_read_unlock();
> +
> +	while (page) {
> +		if (xa_is_value(page)) {
> +			page = shmem_read_mapping_page(mapping, xas.xa_index);
> +			if (!IS_ERR(page))
> +				put_page(page);
> +		}
> +
> +		if (need_resched()) {
> +			xas_pause(&xas);
> +			cond_resched();
> +		}
> +
> +		rcu_read_lock();
> +		page = xas_next_entry(&xas, end);
> +		rcu_read_unlock();
> +	}
> +
> +	return 0;
> +}

What part of the XArray documentation led you to believe that this is a
safe thing to do?  Because it needs to be rewritten immediately!
