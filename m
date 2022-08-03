Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB24588807
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiHCHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiHCHgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:36:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EBA2BC9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:36:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60EF24007C;
        Wed,  3 Aug 2022 07:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659512202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Blhmz/bey4/9JiT5I8zzJO8Hj3s1hGffUTuW4GklLyY=;
        b=UW2+X6zsjhiz0t2S7DSu40G0eLakYa0UwLxql1l3jzK1ZZVvlThQ1evwDpKJWD2XF2yUWQ
        WLJo/StRFly5ftRc2uzbbU2ReksSQ7N4QeUp8+iD/T3n2NapG+ZX6XsTWvgNZt/GGbEd3D
        3sl5vuxIgOU1pMCpcotKGunse7hkN9E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F30E13AF2;
        Wed,  3 Aug 2022 07:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bHqUDIol6mJiUgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 03 Aug 2022 07:36:42 +0000
Date:   Wed, 3 Aug 2022 09:36:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <YuolieBmdaIzoS3t@dhcp22.suse.cz>
References: <20220801084207.39086-1-songmuchun@bytedance.com>
 <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
 <YuecP/RKXWz7QAs0@feng-skl>
 <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
 <Yui7hWZYMX31ktOr@feng-skl>
 <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
 <YujUyCIBjFj+FzX5@feng-skl>
 <YujoLQt09Js/sSQL@dhcp22.suse.cz>
 <YuoYkPk+YzdPNvmN@feng-snb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuoYkPk+YzdPNvmN@feng-snb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-08-22 14:41:20, Feng Tang wrote:
> On Tue, Aug 02, 2022 at 05:02:37PM +0800, Michal Hocko wrote:
> > Please make sure to CC Mike on hugetlb related changes.
> 
> OK.
> 
> > I didn't really get to grasp your proposed solution but it feels goind
> > sideways. The real issue is that hugetlb uses a dedicated allocation
> > scheme which is not fully MPOL_PREFERRED_MANY aware AFAICS. I do not
> > think we should be tricking that by providing some fake nodemasks and
> > what not.
> > 
> > The good news is that allocation from the pool is MPOL_PREFERRED_MANY
> > aware because it first tries to allocation from the preffered node mask
> > and then fall back to the full nodemask (dequeue_huge_page_vma).
> > If the existing pools cannot really satisfy that allocation then it
> > tries to allocate a new hugetlb page (alloc_fresh_huge_page) which also
> > performs 2 stage allocation with the node mask and no node masks. But
> > both of them might fail.
> > 
> > The bad news is that other allocation functions - including those that
> > allocate to the pool are not fully MPOL_PREFERRED_MANY aware. E.g.
> > __nr_hugepages_store_common paths which use the allocating process
> > policy to fill up the pool so the pool could be under provisioned if
> > that context is using MPOL_PREFERRED_MANY.
> 
> Thanks for the check!
> 
> So you mean if the prferred nodes don't have enough pages, we should
> also fallback to all like dequeue_huge_page_vma() does?
> 
> Or we can user a policy API which return nodemask for MPOL_BIND and 
> NULL for all other policies, like allowed_mems_nr() needs.
> 
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -158,6 +158,18 @@ static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
>  	return policy_nodemask(gfp, mpol);
>  }
>  
> +#ifdef CONFIG_HUGETLB_FS
> +static inline nodemask_t *strict_policy_nodemask_current(void)
> +{
> +	struct mempolicy *mpol = get_task_policy(current);
> +
> +	if (mpol->mode == MPOL_BIND)
> +		return &mpol->nodes;
> +
> +	return NULL;
> +}
> +#endif

Yes something like this, except that I would also move this into hugetlb
proper because this doesn't seem generally useful.
 
> > Wrt. allowed_mems_nr (i.e. hugetlb_acct_memory) this is a reservation
> > code and I have to admit I do not really remember details there. This is
> > a subtle code and my best guess would be that policy_nodemask_current
> > should be hugetlb specific and only care about MPOL_BIND.
> 
> The API needed by allowed_mem_nr() is a little different as it has gfp
> flag and cpuset config to consider.

Why would gfp mask matter? 
-- 
Michal Hocko
SUSE Labs
