Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57B6481440
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbhL2Oxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:53:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34978 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhL2Oxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:53:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB4E621109;
        Wed, 29 Dec 2021 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640789617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGrhUF/lzKRcwDX1Q/od0fjVGpbS2+6A5chATdaD0Xo=;
        b=V69ogZWOz8qlnop+B5C7pygFjg9p230q9LePR7BjnqgBQoWImLvLHyz5wm5ThBxIF8i3BF
        3qRlGONc3wzikXEl0LybXycYe3ok4cVYzOBwEOvD0onu89Dg3AYyei7k7FfYoG/Ra4bNJg
        2cskwNXiv5bkgefJCANWs6wcjDzi1AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640789617;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGrhUF/lzKRcwDX1Q/od0fjVGpbS2+6A5chATdaD0Xo=;
        b=nkrUSUjVX8YXSQXjtNesPIMxwQuMYxjZ11AVzoJj/pxorvpdb6wM+oTtbcn9TVw3pq38Py
        RtVLYH4c+3r8WYBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6927413BC1;
        Wed, 29 Dec 2021 14:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qaVvFnF2zGH6WwAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 29 Dec 2021 14:53:37 +0000
Date:   Wed, 29 Dec 2021 15:53:35 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH] mm/page_isolation: unset migratetype directly for non
 Buddy page
Message-ID: <Ycx2b8yla4VzeWWs@localhost.localdomain>
References: <20211229033649.2760586-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229033649.2760586-1-chenwandun@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 11:36:49AM +0800, Chen Wandun wrote:
> There is no need to try to move_freepages_block for pages that is not
> in buddy in function unset_migratetype_isolate, it can directly set
> migrate type.

The above could benefit from some rephrasing, someting along these lines
maybe?

"In unset_migratetype_isolate(), we can bypass the call to
move_freepages_block() for non-buddy pages"

> 
> It will save a few cpu cycles for some situations such as cma and
> hugetlb when allocating continue pages, in these situation function
> alloc_contig_pages will be called.
> 
> alloc_contig_pages
> 	__alloc_contig_migrate_range
> 	isolate_freepages_range ==> pages has been remove from buddy
> 	undo_isolate_page_range
> 		unset_migratetype_isolate ==> can directly set migratetype
> 
> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

I am ok with the "fix", but I don't think this deserves a Fixes tag.
Sure, it can spare some cpu cycles, but besides that, there is no harm
in the actual code unless I missed something.

Others might feel stronger about that.

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
