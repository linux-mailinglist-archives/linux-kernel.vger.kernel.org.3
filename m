Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B0F49D22D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbiAZS7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiAZS7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:59:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F2EC06161C;
        Wed, 26 Jan 2022 10:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RpL+rxhAhlZQJ9/uSU/qLylpB6hdYn8xv5qg2QKDxL0=; b=i5kUzxOGZ4MkbrV0H9kNy8JeC8
        eJ6XSbef0LQFUFaxdLeZOeHLtOiEjMQCzGtWkMAj4YduJF7cxoOS6SgQqWDGgFlYgQGxliaQRKdvX
        TNkjIgZclQ6binDZ8OIBlI670KSAEglYme75yekdyiSm55Ws3NtiyRuUksSs4hR8Qgkx2qvxVetNd
        aBdU9f1IX4PAc2ymQNrJ8fnO7QTjA56nd3r9fN3BPP8hvnbImC9UpuKTWqVPd93JXWSLuEdvMwmW5
        PKIgMDv+UORATCAvgLBbZlZH/c7L3y06XHeyL+4WlWoCl8GEYmXP1liMmJ+DZXhdyYca5WCgl2JPr
        KAYLXe2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCnVf-004LUW-CH; Wed, 26 Jan 2022 18:59:11 +0000
Date:   Wed, 26 Jan 2022 18:59:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, anshuman.khandual@arm.com,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com, hughd@google.com
Subject: Re: [PATCH v3 1/9] mm: add overflow and underflow checks for
 page->_refcount
Message-ID: <YfGZ/0hhkqVeX04p@casper.infradead.org>
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
 <20220126183429.1840447-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126183429.1840447-2-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 06:34:21PM +0000, Pasha Tatashin wrote:
> The problems with page->_refcount are hard to debug, because usually
> when they are detected, the damage has occurred a long time ago. Yet,
> the problems with invalid page refcount may be catastrophic and lead to
> memory corruptions.
> 
> Reduce the scope of when the _refcount problems manifest themselves by
> adding checks for underflows and overflows into functions that modify
> _refcount.

If you're chasing a bug like this, presumably you turn on page
tracepoints.  So could we reduce the cost of this by putting the
VM_BUG_ON_PAGE parts into __page_ref_mod() et al?  Yes, we'd need to
change the arguments to those functions to pass in old & new, but that
should be a cheap change compared to embedding the VM_BUG_ON_PAGE.

>  static inline void page_ref_add(struct page *page, int nr)
>  {
> -	atomic_add(nr, &page->_refcount);
> +	int old_val = atomic_fetch_add(nr, &page->_refcount);
> +	int new_val = old_val + nr;
> +
> +	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
>  	if (page_ref_tracepoint_active(page_ref_mod))
>  		__page_ref_mod(page, nr);
>  }
