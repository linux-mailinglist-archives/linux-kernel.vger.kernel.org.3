Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1F546AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbiFJQh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349797AbiFJQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:37:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCC059957
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:37:40 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id h18so18952284qvj.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l035eZ/XND4LkeE/0rb+BaCGJ69LjeSCzpLD7E1nar4=;
        b=tWnFa1f9RqnIXyNkw9tEkdYFRwIr/j3Pn+mWG/fbYKXNYLyz6F0qgS9NwJ3Q0t335K
         WbK8SsXExbpIQq9wHUwNLEEXYmzLzGvtrXm3gMUcd6EVynr+9l3rQ87Np3uKyxTxwDZ3
         8wI+WHw1E6YfMK0UkVpq7180PrktraZTrAjW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l035eZ/XND4LkeE/0rb+BaCGJ69LjeSCzpLD7E1nar4=;
        b=T+3+2vaTHKYtA9HvbQwVUU/pStGL68jDaFCeobu0o4euPBVaxeGwcHc7LSUe0ICeR2
         fCR4egNcRiapaP7GeMN7UQ00P74cIoX74RYpTf7vN0nfHdF2LCjknSaP32sP9gs9QKS2
         jxi/1nY25TKmq2tlbMIJ/MoB3TflS9ihZg1ucFZy2WxAmrBuVRvf5dFhqEUp+oP5NUhi
         n4Xf7NExS3fJ7t8bwVJjQf27WbQ+R2XJP36zcAJZ91MlTK9Y53DQPZvpu1uTurePtRT9
         dWaesJyNtjVZYyXpKkY7cO1369UaRJubviG1H5ElULwr3d3rF/RamgJrLrB0Z52fTq9X
         C8RA==
X-Gm-Message-State: AOAM530Y2rAPJUtP7kYEdiZP/rJGwTtOD04MHj6ogwP1+pDU6uDPJLP4
        KdH5/UYr+tiVPN3k2gu2BV95uw==
X-Google-Smtp-Source: ABdhPJyW2ewd5LdFtq8oxipdId0RNoZcgXX6ZpQKBvORIiKwtAfDFWYKAcO6WZpd1/+0CNHE+LiN6w==
X-Received: by 2002:ad4:5ba3:0:b0:467:dc64:cf9a with SMTP id 3-20020ad45ba3000000b00467dc64cf9amr30324849qvq.73.1654879059954;
        Fri, 10 Jun 2022 09:37:39 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ay33-20020a05620a17a100b006a6f68c8a87sm8412785qkb.126.2022.06.10.09.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 09:37:39 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:37:39 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, urezki@gmail.com
Subject: Re: [PATCH] rcu/tree: Add comment to describe GP done condition in
 fqs loop
Message-ID: <YqNzUwfII/gJoP52@google.com>
References: <20220609071340.30375-1-quic_neeraju@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609071340.30375-1-quic_neeraju@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:43:40PM +0530, Neeraj Upadhyay wrote:
> Add a comment to explain why !rcu_preempt_blocked_readers_cgp() condition
> is required on root rnp node, for GP completion check in rcu_gp_fqs_loop().
> 
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> ---
>  kernel/rcu/tree.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a93c5f4d7e09..9cd1ba512fdc 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2083,7 +2083,17 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
>  		rcu_gp_torture_wait();
>  		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
>  		/* Locking provides needed memory barriers. */
> -		/* If grace period done, leave loop. */
> +		/*
> +		 * If grace period done, leave loop. rcu_preempt_blocked_readers_cgp(rnp)
> +		 * check is required for the case where we only have single node in the
> +		 * rcu_node tree; so, root rcu node is also the leaf node, where readers
> +		 * blocking current gp are queued. For multi-node tree, checking ->qsmask
> +		 * on the root node is sufficient, as root rcu node's ->qsmask is only
> +		 * cleared, when all leaf rcu nodes have propagated their quiescent
> +		 * state to their parent node, which happens only after both ->qsmask
> +		 * and rcu_preempt_blocked_readers_cgp(rnp_leaf) are cleared for those
> +		 * leaf nodes.
> +		 */
>  		if (!READ_ONCE(rnp->qsmask) &&
>  		    !rcu_preempt_blocked_readers_cgp(rnp))
>  			break;

Paul's wording changes are OK with me.

For the patch:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

