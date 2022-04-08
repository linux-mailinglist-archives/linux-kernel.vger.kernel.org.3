Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2504F9D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbiDHTVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbiDHTVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:21:40 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14DC25C70
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:19:35 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id u14so9528263pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 12:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDKnd76iowiARu70hpPXTSfbM05bvUgBVtd1F6alPd8=;
        b=8J9ULcptVk5OE/KA9Ty3b8EvFEx13EcMoLzzojYJI73BwYITHJ26K2wDdqbLjmPt4F
         LPxF8Y3NWhTBIUg/nfNKBotfw9aAALyoaghxXEATugGKnan2OYn+EEv8H8dBobeO+mvz
         g9nsIkH4orzifvDbkNo8X8+OirkEZhq8WxRNz5nUAZHfZW453ht/8LpFvv8eYj+dqrfW
         01GouCO/TtG3n67GL86r0WQkOcdI67E96ONiDr4InG9fhmqihDmWMElT+oVPMU6veJpJ
         djwFEEPXluMWuEG9jQs8n/IG594bDwf4BFZX040r/rqL53hbzdMHQq5/4lP3iPGYmgWr
         2sqA==
X-Gm-Message-State: AOAM532E1+8gol0+8k66PkxydkPGgqDX+9jcTaU/gOOZrcB2ywc5ZKbd
        1WuE2pyhPT70KLd8YKYMDsU=
X-Google-Smtp-Source: ABdhPJwzh1zfo0olyhzYtdXafDW9fS/eYLXPQn5BiO7ZnSmz0n42s0aD7Uu1sR8Zqq6gRH/HTTm/+w==
X-Received: by 2002:a17:90b:352:b0:1c6:77e:a4f7 with SMTP id fh18-20020a17090b035200b001c6077ea4f7mr23215674pjb.77.1649445575118;
        Fri, 08 Apr 2022 12:19:35 -0700 (PDT)
Received: from fedora ([4.14.106.147])
        by smtp.gmail.com with ESMTPSA id y11-20020aa793cb000000b004fb597d85b2sm26515562pff.160.2022.04.08.12.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 12:19:34 -0700 (PDT)
Date:   Fri, 8 Apr 2022 12:19:32 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, cl@linux.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        songmuchun@bytedance.com
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Message-ID: <YlCKxBufsHgexguy@fedora>
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
 <YlBzsakUloG4nS7W@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlBzsakUloG4nS7W@slm.duckdns.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 07:41:05AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Apr 07, 2022 at 06:33:35PM +0800, Qi Zheng wrote:
> > In the percpu_ref_call_confirm_rcu(), we call the wake_up_all()
> > before calling percpu_ref_put(), which will cause the value of
> > percpu_ref to be unstable when percpu_ref_switch_to_atomic_sync()
> > returns.
> > 
> > 	CPU0				CPU1
> > 
> > percpu_ref_switch_to_atomic_sync(&ref)
> > --> percpu_ref_switch_to_atomic(&ref)
> >     --> percpu_ref_get(ref);	/* put after confirmation */
> > 	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
> > 
> > 					percpu_ref_switch_to_atomic_rcu
> > 					--> percpu_ref_call_confirm_rcu
> > 					    --> data->confirm_switch = NULL;
> > 						wake_up_all(&percpu_ref_switch_waitq);
> > 
> >     /* here waiting to wake up */
> >     wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
> > 						(A)percpu_ref_put(ref);
> > /* The value of &ref is unstable! */
> > percpu_ref_is_zero(&ref)
> > 						(B)percpu_ref_put(ref);
> > 
> > As shown above, assuming that the counts on each cpu add up to 0 before
> > calling percpu_ref_switch_to_atomic_sync(), we expect that after switching
> > to atomic mode, percpu_ref_is_zero() can return true. But actually it will
> > return different values in the two cases of A and B, which is not what
> > we expected.
> > 
> > Maybe the original purpose of percpu_ref_switch_to_atomic_sync() is
> > just to ensure that the conversion to atomic mode is completed, but it
> > should not return with an extra reference count.
> > 
> > Calling wake_up_all() after percpu_ref_put() ensures that the value of
> > percpu_ref is stable after percpu_ref_switch_to_atomic_sync() returns.
> > So just do it.
> > 
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > ---
> >  lib/percpu-refcount.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> > index af9302141bcf..b11b4152c8cd 100644
> > --- a/lib/percpu-refcount.c
> > +++ b/lib/percpu-refcount.c
> > @@ -154,13 +154,14 @@ static void percpu_ref_call_confirm_rcu(struct rcu_head *rcu)
> >  
> >  	data->confirm_switch(ref);
> >  	data->confirm_switch = NULL;
> > -	wake_up_all(&percpu_ref_switch_waitq);
> >  
> >  	if (!data->allow_reinit)
> >  		__percpu_ref_exit(ref);
> >  
> >  	/* drop ref from percpu_ref_switch_to_atomic() */
> >  	percpu_ref_put(ref);
> > +
> > +	wake_up_all(&percpu_ref_switch_waitq);
> 
> The interface, at least originally, doesn't give any guarantee over whether
> there's gonna be a residual reference on it or not. There's nothing
> necessarily wrong with guaranteeing that but it's rather unusual and given
> that putting the base ref in a percpu_ref is a special "kill" operation and
> a ref in percpu mode always returns %false on is_zero(), I'm not quite sure
> how such semantics would be useful. Do you care to explain the use case with
> concrete examples?

block/blk-pm.c has:
        percpu_ref_switch_to_atomic_sync(&q->q_usage_counter);
        if (percpu_ref_is_zero(&q->q_usage_counter))

> 
> Also, the proposed patch is racy. There's nothing preventing
> percpu_ref_switch_to_atomic_sync() from waking up early between
> confirm_switch clearing and the wake_up_all, so the above change doesn't
> guarantee what it tries to guarantee. For that, you'd have to move
> confirm_switch clearing *after* percpu_ref_put() but then, you'd be
> accessing the ref after its final ref is put which can lead to
> use-after-free.
> 

Sad that is my bad missing that.

> In fact, the whole premise seems wrong. The switching needs a reference to
> the percpu_ref because it is accessing it asynchronously. The switching side
> doesn't know when the ref is gonna go away once it puts its reference and
> thus can't signal that they're done after putting their reference.
> 

I read it as 2 usages of percpu_ref. 1 is as the tie a lifetime to an
object, the 2nd is just as a raw reference counter which md and
request_queue use.

In the first use case, I don't think it makes any sense to call
percpu_ref_switch_to_atomic_sync(). And if you did, wouldn't
percpu_ref_switch_to_atomic_sync() to percpu_ref_is_zero() either be
use-after-free or always false.

I feel like the 2nd use case is fair game though because if you're using
percpu_ref_switch_to_atomic_*(), the lifetime of percpu_ref has to be
guaranteed outside of the kill callback.

> We *can* make that work by putting the whole thing in its own critical
> section so that we can make confirm_switch clearing atomic with the possibly
> final put, but that's gonna add some complexity and begs the question why
> we'd need such a thing.
> 
> Andrew, I don't think the patch as proposed makes much sense. Maybe it'd be
> better to keep it out of the tree for the time being?
> 
> Thanks.
> 

Thanks,
Dennis
