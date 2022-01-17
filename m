Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A62490571
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbiAQJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:52:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42344 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiAQJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:52:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 345E41F398;
        Mon, 17 Jan 2022 09:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642413119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QssX3qy45EBop2wt4yRjxi92IzoJivyohNdN3f5hNiw=;
        b=kOhALxsMoJnaaXNJF63lQgEXwc4lNu56pgVFV5TAN+m6lg13Dq4yYHTkHckIvdaA6Ya5Vf
        NJm/iD5oNpr+X9PIVlVDU6pDNPHGXY6T5vryFcfBmsRxVKYWK/SFIQ3ssrnwBYiMzSB00h
        LnRSsgtEhcwrLCLdNULQWIV+mhyDwhg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ACA58A3B83;
        Mon, 17 Jan 2022 09:51:58 +0000 (UTC)
Date:   Mon, 17 Jan 2022 10:51:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] lib/string_helpers: Use the given gfp flag when
 allocating memory
Message-ID: <YeU8PhtvvXIWtTk/@dhcp22.suse.cz>
References: <30a0c2011f8034378639883339fa7d7c55e034a5.1642337349.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a0c2011f8034378639883339fa7d7c55e034a5.1642337349.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 16-01-22 13:49:22, Christophe JAILLET wrote:
> kstrdup_quotable_cmdline() is given a gfp flag that is passed and used for
> memory allocation in kstrdup_quotable() just a few lines below.
> 
> It looks reasonable to use this gfp value for the buffer allocated and
> freed in kstrdup_quotable_cmdline() as well.
> 
> Fixes: 0ee931c4e31a ("mm: treewide: remove GFP_TEMPORARY allocation flag")

I do not think this commit is changing much here. It just replaces
GFP_TEMPORARY with GFP_KERNEL so the code has ignored the gfp mask even
before that change.

All existing callers of kstrdup_quotable_cmdline use GFP_KERNEL so would
it make more sense to simply drop the gfp argument altogether and use
GFP_KERNEL internally?

Normally it is better to have a full control of the allocation mask but
if we have any non-GFP_KERNEL caller then I would rather have the
argument added and the function checked whether all internal paths are
gfp mask aware.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> According to what I've found in 5.16, all callers use GFP_KERNEL, so this
> patch should be a no-op.
> But who knows how it will be used in the future. Better safe than sorry.
> ---
>  lib/string_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 90f9f1b7afec..7aceeb40dfd7 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -624,7 +624,7 @@ char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
>  	char *buffer, *quoted;
>  	int i, res;
>  
> -	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	buffer = kmalloc(PAGE_SIZE, gfp);
>  	if (!buffer)
>  		return NULL;
>  
> -- 
> 2.32.0

-- 
Michal Hocko
SUSE Labs
