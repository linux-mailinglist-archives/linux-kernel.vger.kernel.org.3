Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB64587725
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiHBGkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiHBGkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:40:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8101E8F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:40:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o3so12588424ple.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 23:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=wUGqIvgtVcDWxzjz/d8Dldte2zUIUWVuAUjRKRevA5c=;
        b=CGzfWvfjfMBz1r6a/zGfmZHY8idAPKPrpacRnP2wgvBHLK/dFFCdpEUrG2WDcvcdAe
         Mv3NoUT8+4kY18ZzAcgArd/KbySeQsVPnADcrbqZ+le2LJbRBo03lvgnkqrlLjq5RniY
         wLeokzNG/xRKOFdqk3/g34zCCtL4eTr5se20c1X6a6+044U7mLdb+7XX/Dw6zlDT8p24
         zLc9hi7ZNULcstEjqzNdEbpTAVy8Txf/oZg4Wy8CznCV7K8e0MRn54gid2Ve27WRhNdi
         /QhMXoYvapPM58dL6K+c6u+4z+1y6u+x/EHezQCZ6W+sPulZrljsajliFs1ZGgl2PF8G
         5lOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wUGqIvgtVcDWxzjz/d8Dldte2zUIUWVuAUjRKRevA5c=;
        b=15akbpYJpzZS/6v1iZHlO3g5/5+VmyUpzh1Nej4QLU6bu8So5gMgv2zw32Ls6q9XFj
         XADZ5zCznaZEiuhgHHhjb2nkq97+V8uG1atedKrZNykhIcKn4/HxPJkvzS5J1h1M2BkD
         OxwYhLn6rXS1X6FYRyCCzISdIXRsQYt3whPELWsZfV03E8tGT0QLPcNZZOUkqOlLg8ov
         HDp5C9+d4mH+Oz2oIh979nRMnYlzV2tk0xB7WRJDInJIz3y1/DXd7vSzLDFz1d5yOJkM
         e3oF9XJsloR+1hB/CmO074v7kELEVkfWup3rW2rkx+fvqJwi/ygy5P1PKqbESO53HfbU
         SOyQ==
X-Gm-Message-State: ACgBeo2aBhP2z9yICTJn0WtCENQnurWo+zAmXKElmWVflzuHTLeVcHWF
        jEdzwSEEulxR9NV3Gu/fa2XCfw==
X-Google-Smtp-Source: AA6agR6tSaIxCAX0D9/F0bPa8vj9UvzHwyPEvKMAjcghwOMEs0b14UWs5jVZ4ZsUC4CMuxXAueFuag==
X-Received: by 2002:a17:902:ec88:b0:16d:cf9b:cdf8 with SMTP id x8-20020a170902ec8800b0016dcf9bcdf8mr20025808plg.128.1659422418094;
        Mon, 01 Aug 2022 23:40:18 -0700 (PDT)
Received: from localhost ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t21-20020a170902b21500b0016be596c8afsm8822226plr.282.2022.08.01.23.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 23:40:17 -0700 (PDT)
Date:   Tue, 2 Aug 2022 14:40:11 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Hocko, Michal" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
References: <20220801084207.39086-1-songmuchun@bytedance.com>
 <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
 <YuecP/RKXWz7QAs0@feng-skl>
 <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
 <Yui7hWZYMX31ktOr@feng-skl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yui7hWZYMX31ktOr@feng-skl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 01:52:05PM +0800, Feng Tang wrote:
> On Tue, Aug 02, 2022 at 11:42:52AM +0800, Muchun Song wrote:
> > On Mon, Aug 01, 2022 at 05:26:23PM +0800, Feng Tang wrote:
> > > On Mon, Aug 01, 2022 at 05:06:14PM +0800, Michal Hocko wrote:
> > > > On Mon 01-08-22 16:42:07, Muchun Song wrote:
> > > > > policy_nodemask() is supposed to be returned a nodemask representing a mempolicy
> > > > > for filtering nodes for page allocation, which is a hard restriction (see the user
> > > > > of allowed_mems_nr() in hugetlb.c).  However, MPOL_PREFERRED_MANY is a preferred
> > > > > mode not a hard restriction.  Now it breaks the user of HugeTLB.  Remove it from
> > > > > policy_nodemask() to fix it, which will not affect current users of policy_nodemask()
> > > > > since all of the users already have handled the case of MPOL_PREFERRED_MANY before
> > > > > calling it.  BTW, it is found by code inspection.
> > > > 
> > > > I am not sure this is the right fix. It is quite true that
> > > > policy_nodemask is a tricky function to use. It pretends to have a
> > > > higher level logic but all existing users are expected to be policy
> > > > aware and they special case allocation for each policy. That would mean
> > > > that hugetlb should do the same.
> > > 
> > > Yes, when I worked on the MPOL_PREFERRED_MANY patches, I was also
> > > confused about policy_nodemask(), as it is never a 'strict' one as
> > > the old code is:
> > > 
> > > 	if (unlikely(mode == MPOL_BIND) &&
> > > 		apply_policy_zone(policy, gfp_zone(gfp)) &&
> > > 		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> > > 		return &policy->nodes;
> > > 
> > > 	return NULL
> > > 
> > > Even when the MPOL_BIND's nodes is not allowed by cpuset, it will 
> > > still return NULL (equals all nodes).
> > >
> > 
> > Well, I agree policy_nodemask() is really confusing because of the
> > shortage of comments and the weird logic.
> > 
> > > From the semantics of allowed_mems_nr(), I think it does get changed
> > > a little by b27abaccf8e8. And to enforce the 'strict' semantic for
> > > 'allowed', we may need a more strict nodemask API for it.
> > >
> > 
> > Maybe this is a good idea to fix this, e.g. introducing a new helper
> > to return the strict allowed nodemask.
> 
> Yep. 
> 
> I had another thought to add one global all-zero nodemask, for API like
> policy_nodemask(), it has 2 types of return value:
> * a nodemask with some bits set
> * NULL (means all nodes)
> 
> Here a new type of zero nodemask (a gloabl variable)can be created to
> indicate no qualified node.
>

I know why you want to introduce a gloable zero nidemask. Since we already
have a glable nodemask array, namely node_states, instead of returning NULL
for the case of all nodes, how about returing node_states[N_ONLINE] for it?
And make it return NULL for the case where no nodes are allowed. Any thought?
 
> > > > I haven't checked the actual behavior implications for hugetlb here. Is
> > > > MPOL_PREFERRED_MANY even supported for hugetlb? Does this change make it
> > > > work? From a quick look this just ignores MPOL_PREFERRED_MANY
> > > > completely.
> > > 
> > > IIRC, the hugetlb will hornor MPOL_PREFERRED_MANY. And I can double
> > > check and report back if otherwise.
> > >
> > > > > Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
> > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > ---
> > > > >  mm/mempolicy.c | 3 ---
> > > > >  1 file changed, 3 deletions(-)
> > > > > 
> > > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > > index 6c27acb6cd63..4deec7e598c6 100644
> > > > > --- a/mm/mempolicy.c
> > > > > +++ b/mm/mempolicy.c
> > > > > @@ -1845,9 +1845,6 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> > > > >  		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> > > > >  		return &policy->nodes;
> > > > >  
> > > > > -	if (mode == MPOL_PREFERRED_MANY)
> > > > > -		return &policy->nodes;
> > > 
> > > I think it will make MPOL_PREFERRED_MANY not usable.
> > >
> > 
> > Sorry, I didn't got what you mean here. Could you explain more details
> > about why it is not usable?
>  
> I thought alloc_pages() will rely on policy_nodemask(), which was wrong
> as I forgot the MPOL_PREFERRED_MANY has a dedicated function
> alloc_pages_preferred_many() to handle it. Sorry for the confusion.
> 
> Thanks,
> Feng
> 
> > Thanks.
> > 
> > > Thanks,
> > > Feng
> > > 
> > > > > -
> > > > >  	return NULL;
> > > > >  }
> > > > >  
> > > > > -- 
> > > > > 2.11.0
> > > > 
> > > > -- 
> > > > Michal Hocko
> > > > SUSE Labs
> > > 
> > 
> 
