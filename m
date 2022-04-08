Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993A64F8C26
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiDHBnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiDHBnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23BE0AA027
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649382065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t9gnNFA0wDN5XfoET2ND9SZc9CvlqYkCyfw7UidpYlY=;
        b=iNXDe2IYu4o4WQeYiffu7DMFZMk/9xuEBlGzjOqKxSALGqI1kA1C0pOV5twEQ4Yi3z0Sum
        bhOLoznT2R4LbWHMvm+0ah4Jq2xU/9U4RffDRzkevvc3dpdHl0hLsU6rSHHrIucfY8Q1H1
        iNQj+RP5iaFJ7BWR7CjTzp3nRoJhK7Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-HIssGxB6OIm6H1aChm_HDA-1; Thu, 07 Apr 2022 21:41:02 -0400
X-MC-Unique: HIssGxB6OIm6H1aChm_HDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A12ED3C01C15;
        Fri,  8 Apr 2022 01:41:01 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A31DE1415136;
        Fri,  8 Apr 2022 01:40:54 +0000 (UTC)
Date:   Fri, 8 Apr 2022 09:40:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        songmuchun@bytedance.com
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Message-ID: <Yk+SoZrwUGnQ3cI4@T590>
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
 <20220407155752.769632b737f79b038cf83742@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407155752.769632b737f79b038cf83742@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Looks all current users expect the refcount is stable after percpu_ref_switch_to_atomic_sync
returns, even though the API itself doesn't mention the point explicitly.

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

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

