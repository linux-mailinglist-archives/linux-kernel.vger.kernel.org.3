Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6124F9CAC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiDHS03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbiDHS0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:26:06 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBD439B2BF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:23:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p21so11640088ioj.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 11:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4UDq4KbosOaxPvS03tXiVXG7FlwxtZR9/0UkPaDJ1U=;
        b=J8SdZK9WRAaPPjeS02Wv0Dq8aCYc2jgG4LT2CLk3VL5Szo8Pby2fc3eQYM3hwdEhpP
         mKM92xN6jm+/ymBEFwRCaoKYzgOhvYIwgt3N27gxR33D6jBAKskKQQNgHU+BiUvnASt9
         vGaIoyCvU3O7UXKqMIEtS3xOo1ImxyLUcakF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4UDq4KbosOaxPvS03tXiVXG7FlwxtZR9/0UkPaDJ1U=;
        b=vLLnunjw0NYMptoWGa2ZLQhLrBfRm0xRxs+xw4dErwXMpT4Z6fuP/xo279FkOoM3yi
         yf9VTtAaAKmnZfvaybHqUXhvCCNnGBZkaseS55VGgOlGZEOW+LvVCCGJFJ8ImN/XobmZ
         PXX2poNPX/3x+6+RYwDidE7memGg7gHm4Awlmu3o36AxKmI5pWWZLK6anz+apHe47+vy
         SdBmYruknMgqNkiOez7ujjgoifSCV2hX2aylsl0j8cXtiSeBufQGP2SugJqHavFr2YS0
         jqQO2QxR1y778/4PAEd6T3603c8pZhOxci0Bi6xBsHvQMxLDayKmdWiW+BWdvZeFJkHp
         ggEw==
X-Gm-Message-State: AOAM533C2XF0xEsQeiyVQe46dAUD7/VyErRHVoECwpdwPmKO+rmOKP7E
        gLCh+9Dj/GtTauobuRhCsYQKqDHGVjiaDQyM9uu7ZA==
X-Google-Smtp-Source: ABdhPJz/wZ8hIYidJlHsXsNQm/TTnzBO1vUQDoE1C0DcmOi9EQ7JPA2nh5xM1F87iX5K4LwKEqPinZ/P+AhD0kP4XoE=
X-Received: by 2002:a05:6638:3798:b0:321:4bf4:6899 with SMTP id
 w24-20020a056638379800b003214bf46899mr10002469jal.257.1649442226476; Fri, 08
 Apr 2022 11:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220407210734.2548973-1-joel@joelfernandes.org>
 <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
In-Reply-To: <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Apr 2022 14:23:34 -0400
Message-ID: <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for RCU_NOCB_CPU=y
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 2:22 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Apr 8, 2022 at 1:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Apr 08, 2022 at 01:20:02PM -0400, Joel Fernandes wrote:
> > > On Fri, Apr 8, 2022 at 11:50 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Fri, Apr 08, 2022 at 10:52:21AM -0400, Joel Fernandes wrote:
> > > > > On Fri, Apr 8, 2022 at 10:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Apr 07, 2022 at 09:07:33PM +0000, Joel Fernandes wrote:
> > > > > > > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > > > > > > which ends up not offloading any CPU. This patch removes yet another
> > > > > > > dependency from the bootloader having to know about RCU, about how many
> > > > > > > CPUs the system has, and about how to provide the mask. Basically, I
> > > > > > > think we should stop pretending that the user knows what they are doing :).
> > > > > > > In other words, if NO_CB_CPU is enabled, lets make use of it.
> > > > > > >
> > > > > > > My goal is to make RCU as zero-config as possible with sane defaults. If
> > > > > > > user wants to provide rcu_nocbs= or nohz_full= options, then those will
> > > > > > > take precedence and this patch will have no effect.
> > > > > > >
> > > > > > > I tested providing rcu_nocbs= option, ensuring that is preferred over this.
> > > > > >
> > > > > > Unless something has changed, this would change behavior relied upon
> > > > > > the enterprise distros.  Last I checked, they want to supply a single
> > > > > > binary, as evidenced by the recent CONFIG_PREEMPT_DYNAMIC Kconfig option,
> > > > > > and they also want the default to be non-offloaded.  That is, given a
> > > > > > kernel built with CONFIG_RCU_NOCB_CPU=y and without either a nohz_full
> > > > > > or a nocbs_cpu boot parameter, all of the CPUs must be non-offloaded.
> > > > >
> > > > > Just curious, do you have information (like data, experiment results)
> > > > > on why they want default non-offloaded? Or maybe they haven't tried
> > > > > the recent work done in NOCB code?
> > > >
> > > > I most definitely do.  When I first introduced callback offloading, I
> > > > made it completely replace softirq callback invocation.  There were some
> > > > important throughput-oriented workloads that got hit with significant
> > > > performance degradation due to this change.  Enterprise Java workloads
> > > > were the worst hit.
> > > >
> > > > Android does not run these workloads, and I am not aware of ChromeOS
> > > > running them, either.
> > >
> > > Thanks a lot for mentioning this, I was not aware and will make note
> > > of it :-). I wonder if the scheduler had something to do with the
> > > degradation.
> >
> > It is all too easy to blame the scheduler and all too easy to forget
> > that the scheduler has a hard job.  ;-)
> >
> > And in this case, the scheduler was just doing what it was told.
>
> No was just saying the scheduler has to do more work with NOCB because
> of the extra threads, so that likely degrades the workloads (context
> switch, wake ups, etc).
>
> > > > > > And is it really all -that- hard to specify an additional boot parameter
> > > > > > across ChromeOS devices?  Android seems to manage it.  ;-)
> > > > >
> > > > > That's not the hard part I think. The hard part is to make sure a
> > > > > future Linux user who is not an RCU expert does not forget to turn it
> > > > > on. ChromeOS is not the only OS that I've seen someone forget to do it
> > > > > ;-D. AFAIR, there were Android devices too in the past where I saw
> > > > > this forgotten. I don't think we should rely on the users doing the
> > > > > right thing (as much as possible).
> > > > >
> > > > > The single kernel binary point makes sense but in this case, I think
> > > > > the bigger question that I'd have is what is the default behavior and
> > > > > what do *most* users of RCU want. So we can keep sane defaults for the
> > > > > majority and reduce human errors related to configuration.
> > > >
> > > > If both the ChromeOS and Android guys need it, I could reinstate the
> > > > old RCU_NOCB_CPU_ALL Kconfig option.  This was removed due to complaints
> > > > about RCU Kconfig complexity, but I believe that Reviewed-by from ChromeOS
> > > > and Android movers and shakers would overcome lingering objections.
> > > >
> > > > Would that help?
> > >
> > > Yes, I think I would love for such a change. I am planning to add a
> > > test to ChromeOS to check whether config options were correctly set
> > > up. So I can test for both the RCU_NOCB_CPU options.
> >
> > Very good!
> >
> > Do you love such a change enough to create the patch and to collect
> > convincing Reviewed-by tags?
>
> Yes sure, just so I understand - basically I have to make the code in
> my patch run when RCU_NOCB_CPU_ALL option is passed (and keep the
> option default disabled), but otherwise default to the current
> behavior, right?

Sorry rephrasing, "make the code in my patch run when the new
CONFIG_RCU_NOCB_CPU_ALL is enabled".

thanks,

- Joel
