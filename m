Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83207533F89
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244853AbiEYOtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbiEYOs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:48:58 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7BAE269
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:48:56 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j6so17577268qkp.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EC3qSzV90yIEpJPSb9gAka294lEXNvP+jK/k6V2VkwY=;
        b=sP6nIiJRj1gRoaVX7vHfBXwVVy5eYYU++U485svk6SpXKrAg619n1A96DqCaV5FkTy
         w5w3iKKMFkLE4auXFj/aXfZJ5LPy5up3GbiHdOpKNiIE2VFqSozTMNo8Z5JrGnlrPSxr
         FGBkY22R8Ok4K4xbXLOtAw+5WpvMIZnnDRImsKSd8fZ6krbHAwyGN5O/1zXBg7t2iiKd
         6QUp7DCaIcUgitzRn19UEloMeMIf222lzADnzLtWyvg1k1G6/IvzHz7fDWDjcRMCUJh4
         XmmmhpgKWvFtDkJT7EDuBJkZ21628wMOPAE7wtEyiNB5/GOfFuje3Xy9mAPkwzShrjmb
         xE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EC3qSzV90yIEpJPSb9gAka294lEXNvP+jK/k6V2VkwY=;
        b=OYILWvoRmanIKkVY6ugpc9vtFyOxgH3P7gBrljwTKNp/tRqXgNiiR1RVdam8A1ZEij
         fvAVmIG5RdZv3XvEAkZYqxdsh1VsQIeb77QKzrGWKP/tfp/n9EvCROBAzzX6C7NLiBQe
         PSbjq8hwGfA3eY1eqM/qR7AJxM9h77lWELgam2Aph1k7fHnDVgirAvNWWqO1c26Nc+2e
         qJKFdGhIGDjZWR2NZ00B3kpgzAJHy7ZJJvunwaVS3BbwkNfRKQhFsOsIyxjeZzCGwJZL
         xEhRD3+vHlcPosrw8yOGcOOQss8u4qbJ/AxKTkguUadFbHSgY7udput4P6bLS/H0ZnFT
         xH4w==
X-Gm-Message-State: AOAM5303EyHLWJr8M3MMbMwk8eNjBXmzhG0pquZHVBb0Uo9R72dWKAXX
        vZHuhd+GObfrM/ZIsn9qJJTYLw==
X-Google-Smtp-Source: ABdhPJxvS5UW3uut5wpR0Ev8PQCVzxaIKMBquTJCK5MdIQkK4XdIeIg7BeodNwxRYmzmYLQIXoHEsw==
X-Received: by 2002:a05:620a:4154:b0:6a5:7577:3e1b with SMTP id k20-20020a05620a415400b006a575773e1bmr5859679qko.694.1653490135896;
        Wed, 25 May 2022 07:48:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id a3-20020ac85b83000000b002f9303ce545sm1666015qta.39.2022.05.25.07.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:48:55 -0700 (PDT)
Date:   Wed, 25 May 2022 10:48:54 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 03/11] mm: memcontrol: make lruvec lock safe when LRU
 pages are reparented
Message-ID: <Yo5B1tLcYPUoaACS@cmpxchg.org>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-4-songmuchun@bytedance.com>
 <Yo0xmKOkBkhRy+bq@cmpxchg.org>
 <Yo38mlkMBFz2h+yP@FVFYT0MHHV2J.googleapis.com>
 <Yo4hVw7B+bUlMzLX@cmpxchg.org>
 <Yo4pPw+IHPBZvZUv@FVFYT0MHHV2J.googleapis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo4pPw+IHPBZvZUv@FVFYT0MHHV2J.googleapis.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:03:59PM +0800, Muchun Song wrote:
> On Wed, May 25, 2022 at 08:30:15AM -0400, Johannes Weiner wrote:
> > On Wed, May 25, 2022 at 05:53:30PM +0800, Muchun Song wrote:
> > > On Tue, May 24, 2022 at 03:27:20PM -0400, Johannes Weiner wrote:
> > > > On Tue, May 24, 2022 at 02:05:43PM +0800, Muchun Song wrote:
> > > > > @@ -1230,10 +1213,23 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct folio *folio)
> > > > >   */
> > > > >  struct lruvec *folio_lruvec_lock(struct folio *folio)
> > > > >  {
> > > > > -	struct lruvec *lruvec = folio_lruvec(folio);
> > > > > +	struct lruvec *lruvec;
> > > > >  
> > > > > +	rcu_read_lock();
> > > > > +retry:
> > > > > +	lruvec = folio_lruvec(folio);
> > > > >  	spin_lock(&lruvec->lru_lock);
> > > > > -	lruvec_memcg_debug(lruvec, folio);
> > > > > +
> > > > > +	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
> > > > > +		spin_unlock(&lruvec->lru_lock);
> > > > > +		goto retry;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * Preemption is disabled in the internal of spin_lock, which can serve
> > > > > +	 * as RCU read-side critical sections.
> > > > > +	 */
> > > > > +	rcu_read_unlock();
> > > > 
> > > > The code looks right to me, but I don't understand the comment: why do
> > > > we care that the rcu read-side continues? With the lru_lock held,
> > > > reparenting is on hold and the lruvec cannot be rcu-freed anyway, no?
> > > >
> > > 
> > > Right. We could hold rcu read lock until end of reparting.  So you mean
> > > we do rcu_read_unlock in folio_lruvec_lock()?
> > 
> > The comment seems to suggest that disabling preemption is what keeps
> > the lruvec alive. But it's the lru_lock that keeps it alive. The
> > cgroup destruction path tries to take the lru_lock long before it even
> > gets to synchronize_rcu(). Once you hold the lru_lock, having an
> > implied read-side critical section as well doesn't seem to matter.
> >
> 
> Well, I thought that spinlocks have implicit read-side critical sections
> because it disables preemption (I learned from the comments above
> synchronize_rcu() that says interrupts, preemption, or softirqs have been
> disabled also serve as RCU read-side critical sections).  So I have a
> question: is it still true in a PREEMPT_RT kernel (I am not familiar with
> this)?

Yes, but you're missing my point.

> > Should the comment be deleted?
> 
> I think we could remove the comments. If the above question is false, seems
> like we should continue holding rcu read lock.

It's true.

But assume it's false for a second. Why would you need to continue
holding it? What would it protect? The lruvec would be pinned by the
spinlock even if it DIDN'T imply an RCU lock, right?

So I don't understand the point of the comment. If the implied RCU
lock is protecting something not covered by the bare spinlock itself,
it should be added to the comment. Otherwise, the comment should go.
