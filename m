Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D261E58D89F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiHIMLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiHIMLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:11:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D562FCF
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:11:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 76B88372E8;
        Tue,  9 Aug 2022 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660047079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GdLGC6Kobyq/QbsvrksoB2ni8bDhZJiYGP6/6oP2jRQ=;
        b=XbFdEHUgjUG1UdhOc51XSeqtw68PS/r/XBzf9iF1XAE+1lXl/FmpyB+AN+//1moKp8azt6
        YKQYacRdGmlaAWKO3GyJ3/HeshUxsKULHC8gJLJNdvnDAP+3xQWDU4BUFuJoeMzVlhqUCm
        Y6vSIyjzvflNUyGolTOSLz6IRa36Ncs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5881013A9D;
        Tue,  9 Aug 2022 12:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6940E+dO8mJOCQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 09 Aug 2022 12:11:19 +0000
Date:   Tue, 9 Aug 2022 14:11:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: fix lock contention on mems_allowed
Message-ID: <YvJO5uX0pSAh6weA@dhcp22.suse.cz>
References: <20220809104927.44366-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809104927.44366-1-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-08-22 18:49:27, Abel Wu wrote:
> The mems_allowed field can be modified by other tasks, so it
> isn't safe to access it with alloc_lock unlocked even in the
> current process context.

It would be useful to describe the racing scenario and the effect it
would have. 78b132e9bae9 hasn't really explained thinking behind and why
it was considered safe to drop the lock. I assume it was based on the
fact that the operation happens on the current task but this is hard to
tell.

> Fixes: 78b132e9bae9 ("mm/mempolicy: remove or narrow the lock on current")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  mm/mempolicy.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index d39b01fd52fe..ae422e44affb 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -855,12 +855,14 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
>  		goto out;
>  	}
>  
> +	task_lock(current);
>  	ret = mpol_set_nodemask(new, nodes, scratch);
>  	if (ret) {
> +		task_unlock(current);
>  		mpol_put(new);
>  		goto out;
>  	}
> -	task_lock(current);
> +
>  	old = current->mempolicy;
>  	current->mempolicy = new;
>  	if (new && new->mode == MPOL_INTERLEAVE)
> @@ -1295,7 +1297,9 @@ static long do_mbind(unsigned long start, unsigned long len,
>  		NODEMASK_SCRATCH(scratch);
>  		if (scratch) {
>  			mmap_write_lock(mm);
> +			task_lock(current);
>  			err = mpol_set_nodemask(new, nmask, scratch);
> +			task_unlock(current);
>  			if (err)
>  				mmap_write_unlock(mm);
>  		} else
> -- 
> 2.31.1

-- 
Michal Hocko
SUSE Labs
