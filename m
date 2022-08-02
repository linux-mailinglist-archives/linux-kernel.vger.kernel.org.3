Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF5587609
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiHBDnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiHBDm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:42:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094AF1CB0D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:42:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso7111333pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=KJxuIb+FvWHlHrYgvDT8WOgL3C6VVylvpOvbAr0onVs=;
        b=5dhI05Ua0LfWPG4hwhI0FJOGPXb3H6lRbM8R3NXqkI1kYApGSZLULohK0IjJArtt8e
         LUFO7egf+mCm5nKEDxQ25yHmwwj/Zw6lriuWgF05/4a4AF3esBdhLkt9zm53wJ26rD7P
         RBVP8h4ubR9TL3qrWeyAHPHYVAsmd7M2wcwVPEVZHlQexefQBL4+MBLjry1LJVaY7wff
         fbOGCSRLwRlYUFpu3z6dzlThHZEPn4Nf3WcW8Mj3FJCKbdhx8qNUbX/N4h4oeReligS/
         eBf75Qc5Qgr0+jQ0px+pZ3e9vVp/PMsNG60wI8SMQqAQAAEYfnn4JssW6Xb6ur895sKu
         heGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KJxuIb+FvWHlHrYgvDT8WOgL3C6VVylvpOvbAr0onVs=;
        b=KBdp5Za7GQ8HECCT9fXZgN7CUcW9CltraBRFfJ9Ir6/nZJHeteahg2YVsD1SP7LFH6
         DZmWRWWNqYAa3VUmymz72j1K8zYz7yD2JtvDlW88zdhE0nIHjdf2uw2vP16lOG1MLghr
         p6BKedd5ZRDPsBAbh8KOUhgQRT6PCpWblRg3BdgexKF1rVr/txNIt1kJVfJDHL9ypm5H
         oLgaADHJ9mbgpYx3iziYaVTUtCUMY0Z/zhww/61u28nziGBULdUjNsq4SRPUNkLhgSVe
         LrYjFHvP1u+K63UimBill1NwThw4UoZPx5jHt+f7EFeTvb8T8r5geNwEP891VoSmWOFR
         qUHw==
X-Gm-Message-State: ACgBeo2nd7Nsu7WdteSyMKk81qPkhGllb99JK2iRUZnhUVM3H+1jukgy
        Mge6AceRWVcZKULbUsa8fg5D4w==
X-Google-Smtp-Source: AA6agR4H+BzoFmhRfPdcu5yxoYuwlVlavAWMsxSDrvOQFvQpX7wNxhlU7dRAGin/2LZz+iGVNeSP+Q==
X-Received: by 2002:a17:902:aa98:b0:16c:d74d:fe6c with SMTP id d24-20020a170902aa9800b0016cd74dfe6cmr20044603plr.134.1659411777534;
        Mon, 01 Aug 2022 20:42:57 -0700 (PDT)
Received: from localhost ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b0016d3d907146sm5638827pln.191.2022.08.01.20.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 20:42:56 -0700 (PDT)
Date:   Tue, 2 Aug 2022 11:42:52 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
References: <20220801084207.39086-1-songmuchun@bytedance.com>
 <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
 <YuecP/RKXWz7QAs0@feng-skl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuecP/RKXWz7QAs0@feng-skl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 05:26:23PM +0800, Feng Tang wrote:
> On Mon, Aug 01, 2022 at 05:06:14PM +0800, Michal Hocko wrote:
> > On Mon 01-08-22 16:42:07, Muchun Song wrote:
> > > policy_nodemask() is supposed to be returned a nodemask representing a mempolicy
> > > for filtering nodes for page allocation, which is a hard restriction (see the user
> > > of allowed_mems_nr() in hugetlb.c).  However, MPOL_PREFERRED_MANY is a preferred
> > > mode not a hard restriction.  Now it breaks the user of HugeTLB.  Remove it from
> > > policy_nodemask() to fix it, which will not affect current users of policy_nodemask()
> > > since all of the users already have handled the case of MPOL_PREFERRED_MANY before
> > > calling it.  BTW, it is found by code inspection.
> > 
> > I am not sure this is the right fix. It is quite true that
> > policy_nodemask is a tricky function to use. It pretends to have a
> > higher level logic but all existing users are expected to be policy
> > aware and they special case allocation for each policy. That would mean
> > that hugetlb should do the same.
> 
> Yes, when I worked on the MPOL_PREFERRED_MANY patches, I was also
> confused about policy_nodemask(), as it is never a 'strict' one as
> the old code is:
> 
> 	if (unlikely(mode == MPOL_BIND) &&
> 		apply_policy_zone(policy, gfp_zone(gfp)) &&
> 		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> 		return &policy->nodes;
> 
> 	return NULL
> 
> Even when the MPOL_BIND's nodes is not allowed by cpuset, it will 
> still return NULL (equals all nodes).
>

Well, I agree policy_nodemask() is really confusing because of the
shortage of comments and the weird logic.

> From the semantics of allowed_mems_nr(), I think it does get changed
> a little by b27abaccf8e8. And to enforce the 'strict' semantic for
> 'allowed', we may need a more strict nodemask API for it.
>

Maybe this is a good idea to fix this, e.g. introducing a new helper
to return the strict allowed nodemask.

> > I haven't checked the actual behavior implications for hugetlb here. Is
> > MPOL_PREFERRED_MANY even supported for hugetlb? Does this change make it
> > work? From a quick look this just ignores MPOL_PREFERRED_MANY
> > completely.
> 
> IIRC, the hugetlb will hornor MPOL_PREFERRED_MANY. And I can double
> check and report back if otherwise.
>
> > > Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/mempolicy.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index 6c27acb6cd63..4deec7e598c6 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -1845,9 +1845,6 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> > >  		cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> > >  		return &policy->nodes;
> > >  
> > > -	if (mode == MPOL_PREFERRED_MANY)
> > > -		return &policy->nodes;
> 
> I think it will make MPOL_PREFERRED_MANY not usable.
>

Sorry, I didn't got what you mean here. Could you explain more details
about why it is not usable?

Thanks.

> Thanks,
> Feng
> 
> > > -
> > >  	return NULL;
> > >  }
> > >  
> > > -- 
> > > 2.11.0
> > 
> > -- 
> > Michal Hocko
> > SUSE Labs
> 
