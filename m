Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B59590C47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbiHLHHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiHLHH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:07:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1119B95AC3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 00:07:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6613A1FDD6;
        Fri, 12 Aug 2022 07:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660288045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpRoRt9oCsrbPdkhbPyBHdGh1078Vs1r57A/qJxLgf0=;
        b=bPs7EqTEuAvyrD9uNUdGHh+Plh9hCw+x7dR+jGW6GAA/3+tHiv5FsSacWYkZBX2MPccCRX
        KfklPk5FGdUVgoR57yrraWV/Oie5pNDW2mszEbLL+EWcs9PEeG+oLWhs6m0gEozOH2rcuv
        IG4J4Y8GbegPf/jjgc/+i9pvhMX3/QM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 455D013AAE;
        Fri, 12 Aug 2022 07:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ddq2Di389WLcfQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 12 Aug 2022 07:07:25 +0000
Date:   Fri, 12 Aug 2022 09:07:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v2] mm/mempolicy: fix lock contention on mems_allowed
Message-ID: <YvX8LB7WFBfAjeps@dhcp22.suse.cz>
References: <20220811124157.74888-1-wuyun.abel@bytedance.com>
 <YvUM7KaJaY+xnN2Y@dhcp22.suse.cz>
 <YvUOCTlk7HSgJkdY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvUOCTlk7HSgJkdY@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-08-22 16:11:23, Michal Hocko wrote:
> fix the lkml address (fat fingers, sorry)
> 
> On Thu 11-08-22 16:06:37, Michal Hocko wrote:
> > [Cc Wei Yang who is author of 78b132e9bae9]
> > 
> > On Thu 11-08-22 20:41:57, Abel Wu wrote:
> > > The mems_allowed field can be modified by other tasks, so it isn't
> > > safe to access it with alloc_lock unlocked even in the current
> > > process context.
> > > 
> > > Say there are two tasks: A from cpusetA is performing set_mempolicy(2),
> > > and B is changing cpusetA's cpuset.mems:
> > > 
> > >   A (set_mempolicy)		B (echo xx > cpuset.mems)
> > >   -------------------------------------------------------
> > >   pol = mpol_new();
> > > 				update_tasks_nodemask(cpusetA) {
> > > 				  foreach t in cpusetA {
> > > 				    cpuset_change_task_nodemask(t) {
> > >   mpol_set_nodemask(pol) {
> > > 				      task_lock(t); // t could be A
> > >     new = f(A->mems_allowed);
> > > 				      update t->mems_allowed;
> > >     pol.create(pol, new);
> > > 				      task_unlock(t);
> > >   }
> > > 				    }
> > > 				  }
> > > 				}
> > >   task_lock(A);
> > >   A->mempolicy = pol;
> > >   task_unlock(A);
> > > 
> > > In this case A's pol->nodes is computed by old mems_allowed, and could
> > > be inconsistent with A's new mems_allowed.
> > 
> > Just to clarify. With an unfortunate timing and those two nodemasks
> > overlap the end user effect could be a premature OOM because some nodes
> > wouldn't be considered, right?
> > 
> > > While it is different when replacing vmas' policy: the pol->nodes is
> > > gone wild only when current_cpuset_is_being_rebound():
> > > 
> > >   A (mbind)			B (echo xx > cpuset.mems)
> > >   -------------------------------------------------------
> > >   pol = mpol_new();
> > >   mmap_write_lock(A->mm);
> > > 				cpuset_being_rebound = cpusetA;
> > > 				update_tasks_nodemask(cpusetA) {
> > > 				  foreach t in cpusetA {
> > > 				    cpuset_change_task_nodemask(t) {
> > >   mpol_set_nodemask(pol) {
> > > 				      task_lock(t); // t could be A
> > >     mask = f(A->mems_allowed);
> > > 				      update t->mems_allowed;
> > >     pol.create(pol, mask);
> > > 				      task_unlock(t);
> > >   }
> > > 				    }
> > >   foreach v in A->mm {
> > >     if (cpuset_being_rebound == cpusetA)
> > >       pol.rebind(pol, cpuset.mems);
> > >     v->vma_policy = pol;
> > >   }
> > >   mmap_write_unlock(A->mm);
> > > 				    mmap_write_lock(t->mm);
> > > 				    mpol_rebind_mm(t->mm);
> > > 				    mmap_write_unlock(t->mm);
> > > 				  }
> > > 				}
> > > 				cpuset_being_rebound = NULL;
> > > 
> > > In this case, the cpuset.mems, which has already done updating, is
> > > finally used for calculating pol->nodes, rather than A->mems_allowed.
> > > So it is OK to call mpol_set_nodemask() with alloc_lock unlocked when
> > > doing mbind(2).
> > > 
> > > Fixes: 78b132e9bae9 ("mm/mempolicy: remove or narrow the lock on current")
> > > Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> > 
> > The fix looks correct.

Forgot
Acked-by: Michal Hocko <mhocko@suse.com>

> > 
> > > ---
> > >  mm/mempolicy.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index d39b01fd52fe..61e4e6f5cfe8 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -855,12 +855,14 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
> > >  		goto out;
> > >  	}
> > >  
> > > +	task_lock(current);
> > >  	ret = mpol_set_nodemask(new, nodes, scratch);
> > >  	if (ret) {
> > > +		task_unlock(current);
> > >  		mpol_put(new);
> > >  		goto out;
> > >  	}
> > > -	task_lock(current);
> > > +
> > >  	old = current->mempolicy;
> > >  	current->mempolicy = new;
> > >  	if (new && new->mode == MPOL_INTERLEAVE)
> > > -- 
> > > 2.31.1
> > 
> > -- 
> > Michal Hocko
> > SUSE Labs
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
