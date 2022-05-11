Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC874523632
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245127AbiEKOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiEKOvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:51:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D635BAC061;
        Wed, 11 May 2022 07:51:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h29so4046146lfj.2;
        Wed, 11 May 2022 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aaocLKEhVrgGEk7ab2JMyksMiZhFBp6/WjQurYu/Fv4=;
        b=O8oA1+ByEU3XK736sKVGXGrzgKtsn5HyrrosgpWE6RnrCR9I2TfKptA0D1gnu1DetV
         RWk1Ln2qrbaMKbmzStSs/SvBcbp/9kmFIYFp6tnmCxE96R+pcJbepJBWoZBn8tI1zs1s
         mstuGRSEBh34MiOtw/5nBbwTiliOvMpNvE4idpTxQVtyW1nA0OfmMx/20l1bahBfc9MX
         DPz5pXT3frdPQ6uYudP5LnMEQR6mgxvb3SgssDQIf5+YzkFBNwnNozq31A96CvgsNtRJ
         q06zRFEQ4T2l5YJi0pZiEvO0O3s8uYi3dc0gbrNJZsTgPpKmWRJTcquDHoMUsximZQ8h
         K/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aaocLKEhVrgGEk7ab2JMyksMiZhFBp6/WjQurYu/Fv4=;
        b=BZCmlg2rZ1imQ9TD3a2OaO3rKESbIVIfCzNU6Ohf2kxZ8bnR4W/AzM1H02NUqQw+D+
         Mm/TgWO2de0Wk++goxRemse0fhX6th7qevAoDsAsRAHOg2NGhuIwtHnozPLVwA32se2A
         nhLNIfOJse197rkZgKs89OIKqAM+zjZbrExytJAWV/1kwbSRDiy+uArWanrF8nZViX1w
         iJKNfVgzBX+p7BzWhf8WpCKLeIsIxkchNNRyLH+2e2dKVMEXR4n7EEU+AS4ahkGSrp+g
         0G6ETGayWkMu2PQ5O5on9bxwq4ybovpH0/ig4GGKhMB2c/+qx0xMQEnl47mldkv/n7sg
         7G8Q==
X-Gm-Message-State: AOAM53316fSiLq+adX5yoMqD1VMwjeI4Wwx1E/Iqv7vzAPFoTEVPgeaC
        FmkHBXXM8vymaDhZ6CnELck=
X-Google-Smtp-Source: ABdhPJzRSxKXbLvdBJSJnE3C/fdWtQIO0idd7CxI6U+uLHgUyf2F601HMxomlifhgtdJ5v5NZMBP5Q==
X-Received: by 2002:a05:6512:2386:b0:473:a4e3:d4aa with SMTP id c6-20020a056512238600b00473a4e3d4aamr20081049lfv.448.1652280687957;
        Wed, 11 May 2022 07:51:27 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id i33-20020a0565123e2100b0047255d211e9sm310120lfv.280.2022.05.11.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:51:27 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 11 May 2022 16:51:25 +0200
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
Message-ID: <YnvNbRcd3KRfQW3C@pc638.lan>
References: <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
 <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
 <20220509033740.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
 <20220509181417.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnldSkaWu40cVimj@pc638.lan>
 <20220510100135.62a4f7df@gandalf.local.home>
 <Ynu8rM42aSyGN7li@pc638.lan>
 <20220511102957.56bd582b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511102957.56bd582b@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:29:57AM -0400, Steven Rostedt wrote:
> On Wed, 11 May 2022 15:39:56 +0200
> Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > <snip>
> >  rcuop/6-54  [000] .N..  183.753018: rcu_invoke_callback:  rcu_preempt rhp=0xffffff88ffd440b0 func=__d_free.cfi_jt
> >  rcuop/6-54  [000] .N..  183.753020: rcu_invoke_callback:  rcu_preempt rhp=0xffffff892ffd8400 func=inode_free_by_rcu.cfi_jt
> >  rcuop/6-54  [000] .N..  183.753021: rcu_invoke_callback:  rcu_preempt rhp=0xffffff89327cd708 func=i_callback.cfi_jt
> >  ... 
> >  rcuop/6-54  [000] .N..  183.755941: rcu_invoke_callback:  rcu_preempt rhp=0xffffff8993c5a968 func=i_callback.cfi_jt
> >  rcuop/6-54  [000] .N..  183.755942: rcu_invoke_callback:  rcu_preempt rhp=0xffffff8993c4bd20 func=__d_free.cfi_jt
> >  rcuop/6-54  [000] dN..  183.755944: rcu_batch_end:        rcu_preempt CBs-invoked=2112 idle=>c<>c<>c<>c<
> >  rcuop/6-54  [000] dN..  183.755946: rcu_utilization:      Start context switch
> >  rcuop/6-54  [000] dN..  183.755946: rcu_utilization:      End context switch
> > <snip>
> > 
> > i spent some time in order to understand why the context was not switched,
> > even though the "rcuop" kthread was marked as TIF_NEED_RESCHED and an IPI
> > was sent to the CPU_0 to reschedule. The last "." in latency field shows
> > that a context has not disabled any preemption. So everything should be fine.
> > 
> > An explanation is that a local_bh_disable() modifies the current_thread_info()->preempt.count
> > so a task becomes non preemtable but the ftrace does not provide any signal about
> > it. So i was fooled for some time by my tracer logs.
> > 
> > Do you have any thoughts about it? Should it be solved or signaled
> > somehow that a task in fact is not preemtable if a counter > 0?
> 
> Hmm, it should show it in the first part (where the 'd' is). Is this a
> snapshot from the kernel or from trace-cmd?
> 
I do both and the behavior is the same. But the above one looks like a
kernel trace output, the trace-cmd snapshot looks differently. So you
mean "s" has to be there then?

<snip>
	entry->preempt_count		= pc & 0xff;
	entry->pid			= (tsk) ? tsk->pid : 0;
	entry->type			= type;
	entry->flags =
#ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
		(irqs_disabled_flags(flags) ? TRACE_FLAG_IRQS_OFF : 0) |
#else
		TRACE_FLAG_IRQS_NOSUPPORT |
#endif
		((pc & NMI_MASK    ) ? TRACE_FLAG_NMI     : 0) |
		((pc & HARDIRQ_MASK) ? TRACE_FLAG_HARDIRQ : 0) |
		((pc & SOFTIRQ_OFFSET) ? TRACE_FLAG_SOFTIRQ : 0) |
		(tif_need_resched() ? TRACE_FLAG_NEED_RESCHED : 0) |
		(test_preempt_need_resched() ? TRACE_FLAG_PREEMPT_RESCHED : 0);
<snip>

BTW, i am not the 5.10 kernel. I have not checked the latest kernel
and what ftrace reports under holding local_bh_disable().

--
Uladzislau Rezki
