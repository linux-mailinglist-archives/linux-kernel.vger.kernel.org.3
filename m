Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED38523476
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbiEKNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbiEKNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:40:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D46B1D7341;
        Wed, 11 May 2022 06:40:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w19so3604258lfu.11;
        Wed, 11 May 2022 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NoAC1uKh1fP80FhMwvvGoVXu863+vZrNjnh223XA2iI=;
        b=Dhr06uf6hoFNALMaa0NX3XVynPQRiNCGPE9Hptj+SvPkGuDz4wFD1d1Ew3hOMmQ00q
         fSlezFUryYYF11AH714es6awPtulKuRJSls2jAP61dQEMrUIrt4cVYUPqGkVROsznEzF
         l6+Piz+0yvAKpZCHukvXo+7s/nAqmowIKscHQqHvBae8fcnhPMXilTMl+cMqvOQA9lwr
         qC+pZ+9gCk1UGz9xz/IWuzLaryZe6XA5zmdUR3DpeOCFyQBWMgIjEXswgjru1yufM7aM
         STomhR1fdZrfa65fRvF1XoQlRVpqcBaU6Jl2Y0QDctnkLXNm8Qyq1V/KBZTglEIqXjbO
         yMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NoAC1uKh1fP80FhMwvvGoVXu863+vZrNjnh223XA2iI=;
        b=O7N5c5rd3gQzjivif2kIhZVu/LTkDnVz3oqrYSrwsskk71t+2sc8nDHdZO2sW9oi2N
         TlsNxYD4le8IalQzaLDY/9vYnGOh+iyVngNH3mg5WfR2ATpN59jZsE69xT65fK+O1+gW
         +W55dsxn263q0VKTym3wMA4RdHEExCeJaDNuJEGL/r7MbUF9FUIKJpDYoFxHTyeaLhii
         J9T2SnH306JOkBmwJ7P6hxx1WieBkhZvWuBl1NHY6noKmobE6H1UkQKBooSheTTxgJn1
         uGPmGW0MXfWxly8XPI8z/2Jfm3UVaXfpGWfO0GtzERMDDCrj35I4PqI4b2VdSmxcd4Cy
         AALQ==
X-Gm-Message-State: AOAM531cBpn/TE1ipSw/Mk9GldYRUZIRO12p9qQgwjfUHfPfa3EGc8/b
        +mQavyTU7Y0V1Z3XcCqZv9k=
X-Google-Smtp-Source: ABdhPJysrEJZW6lwm48T9rb6/b92Xp6zISJVh1wdUO6Zr7dx4R1c+ZhjI13pyvq6A2hLgGsb0yqZbw==
X-Received: by 2002:a05:6512:1109:b0:473:e582:a60c with SMTP id l9-20020a056512110900b00473e582a60cmr20277756lfg.150.1652276400325;
        Wed, 11 May 2022 06:40:00 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id s15-20020a19770f000000b0047255d211edsm286330lfc.284.2022.05.11.06.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:39:58 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 11 May 2022 15:39:56 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <Ynu8rM42aSyGN7li@pc638.lan>
References: <YnY33nq5jl6FLFOu@pc638.lan>
 <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
 <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
 <20220509033740.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
 <20220509181417.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnldSkaWu40cVimj@pc638.lan>
 <20220510100135.62a4f7df@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510100135.62a4f7df@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 9 May 2022 20:28:26 +0200
> Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > I see that Paul would like to keep it for CONFIG_PREEMPT_RT, because it
> > was mainly designed for that kind of kernels. So we can align with Alison
> > patch and her decision, so i do not see any issues. So far RT folk seems
> > does not mind in having "callback-kthreads" as SCHED_FIFO :)
> 
> That's because RT folks set the threads they care about to a higher RT
> priority than the kthreads. ;-)
> 
That explains many things :)

I have one question, it is partly related to the topic that is in question
and to this thread also. I was tracing a "long" duration of the offloading
kthreads which actually invoke them one by one. And the picture was like
below from ftrace point of view:

<snip>
 rcuop/6-54  [000] .N..  183.753018: rcu_invoke_callback:  rcu_preempt rhp=0xffffff88ffd440b0 func=__d_free.cfi_jt
 rcuop/6-54  [000] .N..  183.753020: rcu_invoke_callback:  rcu_preempt rhp=0xffffff892ffd8400 func=inode_free_by_rcu.cfi_jt
 rcuop/6-54  [000] .N..  183.753021: rcu_invoke_callback:  rcu_preempt rhp=0xffffff89327cd708 func=i_callback.cfi_jt
 ... 
 rcuop/6-54  [000] .N..  183.755941: rcu_invoke_callback:  rcu_preempt rhp=0xffffff8993c5a968 func=i_callback.cfi_jt
 rcuop/6-54  [000] .N..  183.755942: rcu_invoke_callback:  rcu_preempt rhp=0xffffff8993c4bd20 func=__d_free.cfi_jt
 rcuop/6-54  [000] dN..  183.755944: rcu_batch_end:        rcu_preempt CBs-invoked=2112 idle=>c<>c<>c<>c<
 rcuop/6-54  [000] dN..  183.755946: rcu_utilization:      Start context switch
 rcuop/6-54  [000] dN..  183.755946: rcu_utilization:      End context switch
<snip>

i spent some time in order to understand why the context was not switched,
even though the "rcuop" kthread was marked as TIF_NEED_RESCHED and an IPI
was sent to the CPU_0 to reschedule. The last "." in latency field shows
that a context has not disabled any preemption. So everything should be fine.

An explanation is that a local_bh_disable() modifies the current_thread_info()->preempt.count
so a task becomes non preemtable but the ftrace does not provide any signal about
it. So i was fooled for some time by my tracer logs.

Do you have any thoughts about it? Should it be solved or signaled
somehow that a task in fact is not preemtable if a counter > 0?

Thanks!

--
Uladzislau Rezki
