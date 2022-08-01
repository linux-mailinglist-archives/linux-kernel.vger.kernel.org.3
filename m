Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BD45866B1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiHAJGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiHAJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:06:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B09B255BE
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:06:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2C7C161058;
        Mon,  1 Aug 2022 09:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659344775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4t5FS/Ddvx7aCW3ILaNh8gtZfbccK8EChN8c9861jBc=;
        b=fUwRp6L0M0aa9LCEIZqXo1N+WO84MIDjhZZ9CbWDwsV/gQu75ZXS2d+W4lTFA6NKaRrHDr
        9P+OWOwC47ntmhq48jJLMlimlzGWUX7q0TTEhGkIBuLtZ6e8gLt66FzLFTiAlwaJvp7Ug3
        F/N3FPv8eVipcNxLgQ010G8aBPyyy+4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06DC213A72;
        Mon,  1 Aug 2022 09:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eOYfOoaX52K9PQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 01 Aug 2022 09:06:14 +0000
Date:   Mon, 1 Aug 2022 11:06:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, bwidawsk@kernel.org,
        dave.hansen@linux.intel.com, feng.tang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
References: <20220801084207.39086-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801084207.39086-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-08-22 16:42:07, Muchun Song wrote:
> policy_nodemask() is supposed to be returned a nodemask representing a mempolicy
> for filtering nodes for page allocation, which is a hard restriction (see the user
> of allowed_mems_nr() in hugetlb.c).  However, MPOL_PREFERRED_MANY is a preferred
> mode not a hard restriction.  Now it breaks the user of HugeTLB.  Remove it from
> policy_nodemask() to fix it, which will not affect current users of policy_nodemask()
> since all of the users already have handled the case of MPOL_PREFERRED_MANY before
> calling it.  BTW, it is found by code inspection.

I am not sure this is the right fix. It is quite true that
policy_nodemask is a tricky function to use. It pretends to have a
higher level logic but all existing users are expected to be policy
aware and they special case allocation for each policy. That would mean
that hugetlb should do the same.

I haven't checked the actual behavior implications for hugetlb here. Is
MPOL_PREFERRED_MANY even supported for hugetlb? Does this change make it
work? From a quick look this just ignores MPOL_PREFERRED_MANY
completely.
 
> Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/mempolicy.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 6c27acb6cd63..4deec7e598c6 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1845,9 +1845,6 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
>  		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
>  		return &policy->nodes;
>  
> -	if (mode == MPOL_PREFERRED_MANY)
> -		return &policy->nodes;
> -
>  	return NULL;
>  }
>  
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
