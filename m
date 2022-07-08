Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D36956C220
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbiGHSnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbiGHSnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:43:23 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3FD22BFB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:43:22 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r2so7986321qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NyAfEdgyfDS13KGoTvFen8Sgl/zG5Xi7yUQsRBHwTWo=;
        b=MaaN+lTYvmKjLSSpCMSxVPaNVgb+DAVCPpCsf0PlCSiXpizh3ljoF0Sme8F8Bbh7/i
         7QNUevJw2NDRGOdwo3qzn6eON28BdfksTvvbdmxNruecoSUTUCJnqlcFBNA85ld4onDi
         aWqVW59ZWBPCICx5dt1ilSYpx3qJCS2CS0kfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyAfEdgyfDS13KGoTvFen8Sgl/zG5Xi7yUQsRBHwTWo=;
        b=zq4Fa6HkYR4sepdRlaPXFAMRXAUETJRR2XE20fzjJuMgKv0DcUBSgi29+BZ9ka1/u8
         SHX+wgRSGTgk6aHab81ZCdS4wQJ/vZSP8EqqU8yJnPfnJKNZmHIiqgXjFBi0k9p2e5qe
         p0B4Ena5tC0s4Mq4j447qlIwdRVVSv9+EQxzBqeXZMzgdansza0HZwC2H2FQ+tOv890E
         Kka3xPfJAwcXPErdBMll92FeEdR3tYWROlrK7BqiigwKPSbZCGcJu99/NpqW4ozVZTFy
         jEtFjCzcoCwEGldQvEqCWhrTdfY5z/UTOs0kANN3C8+CesKyKwbhsDaOUTMtgJwFnMiS
         EVsg==
X-Gm-Message-State: AJIora8gjPMrISBWNhNd/7IeUBHgR+cr3n4CLA8cAqNV19allcx/XgMn
        WMN0CkBdJ5F3ARopaY4b9U0/HA==
X-Google-Smtp-Source: AGRyM1sKnJi7pzK+L/1EnLnFFCgOngj3otmL4YHPOlRz8DTB3WHuCA9K3yt5hfzvk/YwARkg0kjzYg==
X-Received: by 2002:a0c:a9d2:0:b0:472:f1c5:f309 with SMTP id c18-20020a0ca9d2000000b00472f1c5f309mr4033604qvb.35.1657305801941;
        Fri, 08 Jul 2022 11:43:21 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b006b559189660sm4012425qki.32.2022.07.08.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:43:21 -0700 (PDT)
Date:   Fri, 8 Jul 2022 18:43:21 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Message-ID: <Ysh6yWThHu6GAfJM@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220626040019.GK1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626040019.GK1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 09:00:19PM -0700, Paul E. McKenney wrote:
> On Wed, Jun 22, 2022 at 10:50:55PM +0000, Joel Fernandes (Google) wrote:
> > Implement timer-based RCU lazy callback batching. The batch is flushed
> > whenever a certain amount of time has passed, or the batch on a
> > particular CPU grows too big. Also memory pressure will flush it in a
> > future patch.
> > 
> > To handle several corner cases automagically (such as rcu_barrier() and
> > hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
> > length has the lazy CB length included in it. A separate lazy CB length
> > counter is also introduced to keep track of the number of lazy CBs.
> > 
> > Suggested-by: Paul McKenney <paulmck@kernel.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Not bad, but some questions and comments below.

Thanks a lot for these, real helpful and I replied below:

> > diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> > index 659d13a7ddaa..9a992707917b 100644
> > --- a/include/linux/rcu_segcblist.h
> > +++ b/include/linux/rcu_segcblist.h
> > @@ -22,6 +22,7 @@ struct rcu_cblist {
> >  	struct rcu_head *head;
> >  	struct rcu_head **tail;
> >  	long len;
> > +	long lazy_len;
> >  };
> >  
> >  #define RCU_CBLIST_INITIALIZER(n) { .head = NULL, .tail = &n.head }
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 1a32036c918c..9191a3d88087 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -82,6 +82,12 @@ static inline int rcu_preempt_depth(void)
> >  
> >  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> >  
> > +#ifdef CONFIG_RCU_LAZY
> > +void call_rcu_lazy(struct rcu_head *head, rcu_callback_t func);
> > +#else
> > +#define call_rcu_lazy(head, func) call_rcu(head, func)
> > +#endif
> > +
> >  /* Internal to kernel */
> >  void rcu_init(void);
> >  extern int rcu_scheduler_active;
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 27aab870ae4c..0bffa992fdc4 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -293,4 +293,12 @@ config TASKS_TRACE_RCU_READ_MB
> >  	  Say N here if you hate read-side memory barriers.
> >  	  Take the default if you are unsure.
> >  
> > +config RCU_LAZY
> > +	bool "RCU callback lazy invocation functionality"
> > +	depends on RCU_NOCB_CPU
> > +	default n
> > +	help
> > +	  To save power, batch RCU callbacks and flush after delay, memory
> > +          pressure or callback list growing too big.
> 
> Spaces vs. tabs.

Fixed, thanks.

> The checkpatch warning is unhelpful ("please write a help paragraph that
> fully describes the config symbol")

Good old checkpatch :D

> >  endmenu # "RCU Subsystem"
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index c54ea2b6a36b..627a3218a372 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -20,6 +20,7 @@ void rcu_cblist_init(struct rcu_cblist *rclp)
> >  	rclp->head = NULL;
> >  	rclp->tail = &rclp->head;
> >  	rclp->len = 0;
> > +	rclp->lazy_len = 0;
> >  }
> >  
> >  /*
> > @@ -32,6 +33,15 @@ void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp)
> >  	WRITE_ONCE(rclp->len, rclp->len + 1);
> >  }
> >  
> > +/*
> > + * Enqueue an rcu_head structure onto the specified callback list.
> 
> Please also note the fact that it is enqueuing lazily.

Sorry, done.

> > + */
> > +void rcu_cblist_enqueue_lazy(struct rcu_cblist *rclp, struct rcu_head *rhp)
> > +{
> > +	rcu_cblist_enqueue(rclp, rhp);
> > +	WRITE_ONCE(rclp->lazy_len, rclp->lazy_len + 1);
> 
> Except...  Why not just add a "lazy" parameter to rcu_cblist_enqueue()?
> IS_ENABLED() can make it fast.

Yeah good idea, it simplifies the code too. Thank you!

So you mean I should add in this function so that the branch gets optimized:
if (lazy && IS_ENABLE(CONFIG_RCU_LAZY)) {
  ...
}

That makes total sense considering the compiler may otherwise not be able to
optimize the function viewing just the individual translation unit. I fixed
it.

The 6 month old baby and wife are calling my attention now. I will continue
to reply to the other parts of this and other emails this evening and thanks
for your help!

thanks,

 - Joel

