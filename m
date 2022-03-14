Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DF64D8A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiCNQrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbiCNQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:47:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B227B34
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:45:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3F0BA1F380;
        Mon, 14 Mar 2022 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647276270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkdkWeTfnrxk7PSRlTAb8ziBqg3aEua4BuwGBMwv+gs=;
        b=mvPZHussDiFs3o5zYNp+zaxs5Pbe7Txeip5Z5UhiQ6fnLlvVv6kllMq1N/WPEzDeK1xU5p
        WjtQX1NPdIlAt7iajos8ZVvOKkpbjx8bUiI8dALoMk/hUG+cGFadp+F8jqrN5RQlCvGwAc
        TcnnQrNm099GSsNqPuOnnAgGLHteJG4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 23CD6A3B88;
        Mon, 14 Mar 2022 16:44:30 +0000 (UTC)
Date:   Mon, 14 Mar 2022 17:44:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com,
        mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: fix potential mpol_new leak in
 shared_policy_replace
Message-ID: <Yi9w7TCYbj+OLGXJ@dhcp22.suse.cz>
References: <20220311093624.39546-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311093624.39546-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-03-22 17:36:24, Miaohe Lin wrote:
> If mpol_new is allocated but not used in restart loop, mpol_new will be
> freed via mpol_put before returning to the caller. But refcnt is not
> initialized yet, so mpol_put could not do the right things and might
> leak the unused mpol_new.

The code is really hideous but is there really any bug there? AFAICS the
new policy is only allocated in if (n->end > end) branch and that one
will set the reference count on the retry. Or am I missing something?

> Fixes: 42288fe366c4 ("mm: mempolicy: Convert shared_policy mutex to spinlock")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/mempolicy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 34d2b29c96ad..f19f19d3558b 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2733,6 +2733,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>  	mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>  	if (!mpol_new)
>  		goto err_out;
> +	refcount_set(&mpol_new->refcnt, 1);
>  	goto restart;
>  }
>  
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
