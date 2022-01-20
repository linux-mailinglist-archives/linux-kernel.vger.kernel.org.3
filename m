Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4CE494A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbiATJMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbiATJMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:12:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A76FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z+hrGHd2PH766bmL4VHMjzgrJYc+sxstWyvPap6zHJA=; b=wKti/GUKfRupgC0O/4WzY1lX57
        +RXOD/ZxxhgGsWlM0jFQlxrMUX7qEIQf199YDPvkKaD5bN0rpm71YbxIJeyRvbEIIHhaFNLJqIRyx
        agmZ5WBmkqRiC+w0m8r5jTeiHc48vP84ai2KXrYRJlnIMwj0616Et6y8PTvJN0oY3hud2/+GBw3AF
        bKQkstnMa5E3ipZ0fl9WPkn3pnk2DILGSxsO5g0KlCXGx+uLnc9brpdxZkGxL+W/mGucVnzSVRCgA
        6JOUKZmSWZxkbc570UGs1aMS+56RPvbwvabOJvInmWI4RAhgofmXsFRxKpNkO3MW2iUZ+q+WXB/wl
        RmZV5kAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nATUb-00A7F4-7N; Thu, 20 Jan 2022 09:12:29 +0000
Date:   Thu, 20 Jan 2022 01:12:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] mm/vmalloc: Move draining areas out of caller context
Message-ID: <YeknfRnxaxcVxEjF@infradead.org>
References: <20220119143540.601149-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119143540.601149-1-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 03:35:38PM +0100, Uladzislau Rezki (Sony) wrote:
> +static void drain_vmap_area(struct work_struct *work)

Nit, but I prefer to have a _work postix for workers just to keep
it easy to ready.

>  	/* After this point, we may free va at any time */
>  	if (unlikely(nr_lazy > lazy_max_pages()))
> -		try_purge_vmap_area_lazy();
> +		if (!atomic_xchg(&drain_vmap_area_work_in_progress, 1))
> +			schedule_work(&drain_vmap_area_work);

Work items are defined to be single threaded, so I don't think we need
the drain_vmap_area_work_in_progress hack.

>  
>  /*
> -- 
> 2.30.2
> 
> 
---end quoted text---
