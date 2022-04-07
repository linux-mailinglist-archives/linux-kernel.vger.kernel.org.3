Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF4B4F8ABD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiDGXAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiDGW77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:59:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E781D08D3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53F50CE29E0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC31C385AA;
        Thu,  7 Apr 2022 22:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649372273;
        bh=RN5h09BMy0SrcZOTMv0e9oxWP9f+jFVQ8ak4khF7YuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wH+dPDwBvjM0YnQ/2yhFHLCsG2BViIutMpxZxwmpr0OiltKgRl+uEb5oStc255nm6
         OhV/xRj/1T1LKg5CsfXEsSX3RbpNDKDx13xhQusGjII6ktc24soGHxmb3LXUdwNTt6
         J7tsSTXqajNdgqZQ0nI+Y1zk9dGRrWqQ/vTldneU=
Date:   Thu, 7 Apr 2022 15:57:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Message-Id: <20220407155752.769632b737f79b038cf83742@linux-foundation.org>
In-Reply-To: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc Ming Lei)

On Thu,  7 Apr 2022 18:33:35 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

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

Thanks.  I'll grab this, but shall await input from others before doing
anything else with it.

> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
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
>  }
>  
>  static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)

