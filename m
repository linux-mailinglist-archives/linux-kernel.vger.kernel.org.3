Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF64F8AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiDHAlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiDHAls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:41:48 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13002200
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:39:47 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 125so6374464pgc.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 17:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Xk1+fs4EReZHznvydunkPsq1TyAFPHWXf8m9Tth19E=;
        b=fI5tUm7ynALpjJ8wDQj5vFRDAYLzHnU5gAS4asSzYXKeN+XyPXfKmi0RYelE/q26jB
         EkU4Y/N0mLVwh80d7bDmgjTPdfkCB6q55thNrgVNZYe/ubEKN9eBDHUZMwNGQgvhx5eu
         0UG2Dy4QaAqaFvqlBjKnppf2blRCdWXSdMZY8MLQPQzEKTLpdzg5EKZ/N8L+Y9oncsp4
         rqogK0z8jTcHm6dwUhecbFJ5wHUvhizjH0Di0Ru/hg4/RtTSYBIYiE9IUtobsAbiq1NW
         5gXORgUybpWIntDpO3ArreFtf/aylajof6TO1Zla5t0WTgNSOkxTKU1XYhCk4z7iAUNA
         teCw==
X-Gm-Message-State: AOAM5314Kfd+gpY0j07BgpnAtjaE3BxfP4rtVD+O0H34/hMQ/vouDQgB
        qJKKMt45d8OE28gffKsC9Ys=
X-Google-Smtp-Source: ABdhPJztJZ7L+/5PHv3zgM7cX3sQyQR4/FykBiwQshDvB8dL1MiwJOzEg2s1fSMTGpxDxXJwpGGhvg==
X-Received: by 2002:a05:6a00:3018:b0:4fa:d533:45e5 with SMTP id ay24-20020a056a00301800b004fad53345e5mr16703828pfb.13.1649378386475;
        Thu, 07 Apr 2022 17:39:46 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm23597254pfc.190.2022.04.07.17.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 17:39:46 -0700 (PDT)
Date:   Thu, 7 Apr 2022 17:39:43 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, tj@kernel.org, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, songmuchun@bytedance.com,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Message-ID: <Yk+ETwQ2aQmCgrfk@fedora>
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
 <20220407155752.769632b737f79b038cf83742@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407155752.769632b737f79b038cf83742@linux-foundation.org>
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

Hello,

On Thu, Apr 07, 2022 at 03:57:52PM -0700, Andrew Morton wrote:
> (cc Ming Lei)
> 
> On Thu,  7 Apr 2022 18:33:35 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
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
> 
> Thanks.  I'll grab this, but shall await input from others before doing
> anything else with it.
> 

Seems right to me. The percpu_ref protects the __percpu_ref_exit(), not
the waiters.

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis

> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
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
> >  }
> >  
> >  static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
> 
