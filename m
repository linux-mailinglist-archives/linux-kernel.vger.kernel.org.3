Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0049C4F9BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiDHRnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbiDHRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:43:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C75931AB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:41:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id md4so981449pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uHhwhZHM5Dko1XjkGmRnFAZVCpJzF3YTM6T4356j8fA=;
        b=P4AQT9kcscQucOkMp1qrxJ4mcn9K3SHjKvXbXck2DKWiGMU3OfNpafbzc4D+qh3vjs
         2h6cNQj+VfUZt98oua8wc2M4A/ogQXP8S60w7kBdiP9pJbswZlKJ7Z+9e1xeCTqr0w61
         diZ0gHW2sELAeBEyeErSxSzhSD9pZRDgOIzDw+1EphXhXua0XI0UGeJifl5F+NyzV92D
         ZM+2ulOElRHgGWofSTYx2de3at0USptjVbcAgSbj6lvE89frq1l4l+obsrH2MPhXoarM
         3QyDBXFyMq2RxRDcF8WU2SmzYx2PFu0gcgZdXQ9isJAqsMH6/XxR1OQ0TpOkjWmXNB4F
         qy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uHhwhZHM5Dko1XjkGmRnFAZVCpJzF3YTM6T4356j8fA=;
        b=cEp7vZxv71ge/dY/oeNBzFn1uKdGQtPIQ2zTBVdm4rSbuk0dEdImRlbY2HOsQ76ajI
         qPeVgqQqpeytjCVBgC4wVUktQgjtUAdGV+g7GxTarvde8vNwTdnZezvUJXAq9i/RPkpW
         yxabMUSKP7OGCQl84ziXjzaBumP0LUYwouq/l6oDHATkmI4PuNdPghEF6seSlTiNljFk
         1UvIX2HGZl7Q9gymdcdB7o5p8m/ixm8X1+kZOZRGcZF4IAkIBj4ra+FjDdZQQsIWXG2G
         zgVrqGsABVU4rtWvuGeD++WYs9EtJMj/JEH4WmZtHyHgzcHbTJrFcH8+Go3Fz8f5h0GN
         cgwA==
X-Gm-Message-State: AOAM530OoI/VzxzUuHShJoNolkTIi0pD0Nbp+yUrqe0lpYJ+FUkpspVg
        qSfkrZzwdNdl2PhpkiR50VI=
X-Google-Smtp-Source: ABdhPJwr1lcgmQLvMiUCF6R/cXqwWuAVUcJ4+FrnwKzKbUy+HPoSXMvgQ2jqxOYitP391OENT8fZGg==
X-Received: by 2002:a17:90b:4ad2:b0:1c7:cee:b126 with SMTP id mh18-20020a17090b4ad200b001c70ceeb126mr22778578pjb.219.1649439667498;
        Fri, 08 Apr 2022 10:41:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u15-20020a056a00098f00b004faa58d44eesm28951208pfg.145.2022.04.08.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 10:41:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 8 Apr 2022 07:41:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Message-ID: <YlBzsakUloG4nS7W@slm.duckdns.org>
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 07, 2022 at 06:33:35PM +0800, Qi Zheng wrote:
> In the percpu_ref_call_confirm_rcu(), we call the wake_up_all()
> before calling percpu_ref_put(), which will cause the value of
> percpu_ref to be unstable when percpu_ref_switch_to_atomic_sync()
> returns.
> 
> 	CPU0				CPU1
> 
> percpu_ref_switch_to_atomic_sync(&ref)
> --> percpu_ref_switch_to_atomic(&ref)
>     --> percpu_ref_get(ref);	/* put after confirmation */
> 	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
> 
> 					percpu_ref_switch_to_atomic_rcu
> 					--> percpu_ref_call_confirm_rcu
> 					    --> data->confirm_switch = NULL;
> 						wake_up_all(&percpu_ref_switch_waitq);
> 
>     /* here waiting to wake up */
>     wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
> 						(A)percpu_ref_put(ref);
> /* The value of &ref is unstable! */
> percpu_ref_is_zero(&ref)
> 						(B)percpu_ref_put(ref);
> 
> As shown above, assuming that the counts on each cpu add up to 0 before
> calling percpu_ref_switch_to_atomic_sync(), we expect that after switching
> to atomic mode, percpu_ref_is_zero() can return true. But actually it will
> return different values in the two cases of A and B, which is not what
> we expected.
> 
> Maybe the original purpose of percpu_ref_switch_to_atomic_sync() is
> just to ensure that the conversion to atomic mode is completed, but it
> should not return with an extra reference count.
> 
> Calling wake_up_all() after percpu_ref_put() ensures that the value of
> percpu_ref is stable after percpu_ref_switch_to_atomic_sync() returns.
> So just do it.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  lib/percpu-refcount.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> index af9302141bcf..b11b4152c8cd 100644
> --- a/lib/percpu-refcount.c
> +++ b/lib/percpu-refcount.c
> @@ -154,13 +154,14 @@ static void percpu_ref_call_confirm_rcu(struct rcu_head *rcu)
>  
>  	data->confirm_switch(ref);
>  	data->confirm_switch = NULL;
> -	wake_up_all(&percpu_ref_switch_waitq);
>  
>  	if (!data->allow_reinit)
>  		__percpu_ref_exit(ref);
>  
>  	/* drop ref from percpu_ref_switch_to_atomic() */
>  	percpu_ref_put(ref);
> +
> +	wake_up_all(&percpu_ref_switch_waitq);

The interface, at least originally, doesn't give any guarantee over whether
there's gonna be a residual reference on it or not. There's nothing
necessarily wrong with guaranteeing that but it's rather unusual and given
that putting the base ref in a percpu_ref is a special "kill" operation and
a ref in percpu mode always returns %false on is_zero(), I'm not quite sure
how such semantics would be useful. Do you care to explain the use case with
concrete examples?

Also, the proposed patch is racy. There's nothing preventing
percpu_ref_switch_to_atomic_sync() from waking up early between
confirm_switch clearing and the wake_up_all, so the above change doesn't
guarantee what it tries to guarantee. For that, you'd have to move
confirm_switch clearing *after* percpu_ref_put() but then, you'd be
accessing the ref after its final ref is put which can lead to
use-after-free.

In fact, the whole premise seems wrong. The switching needs a reference to
the percpu_ref because it is accessing it asynchronously. The switching side
doesn't know when the ref is gonna go away once it puts its reference and
thus can't signal that they're done after putting their reference.

We *can* make that work by putting the whole thing in its own critical
section so that we can make confirm_switch clearing atomic with the possibly
final put, but that's gonna add some complexity and begs the question why
we'd need such a thing.

Andrew, I don't think the patch as proposed makes much sense. Maybe it'd be
better to keep it out of the tree for the time being?

Thanks.

-- 
tejun
