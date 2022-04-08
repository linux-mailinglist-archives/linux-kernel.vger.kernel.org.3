Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC54F98A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiDHOyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiDHOyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:54:38 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B52116B79
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:52:34 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e22so10837726ioe.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VRYQ19FRWWgFB7eclpNXP2B+Re0MnAnD9mT5UitObs=;
        b=K1wi6jy6dYdW+QpMSK3lfRGk4zGJJ8ogB8ZcDlfiGH3GEEOszOV9MxSDftrmkKhTz3
         szCu7VsuIjubs5IEfqfb/bfE8LOTX934fRkIGREGB0ChGz9X8hy5IXOCfkarC2fUJRVw
         Hu8rHgf0l2L0a8T1HtK35w2olAaeJfU7uETgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VRYQ19FRWWgFB7eclpNXP2B+Re0MnAnD9mT5UitObs=;
        b=28YrwvojKSIcVx5PrTjIMksihtNeiPOl1h2FXG5BRJ93k7P7gQAQKBc4nEIFbQpeWX
         DC2sKoSjzRzYvMLymR+mgzhPy0RJCy1ZmJko2ZLu8/f0ooGhN40vyv+9ECcIYZ25KFI7
         x5Hz/X/jLZLp0xdpZ1yEYUOf9IVKxy/hWmM1I2W7+FnepIoGSYCJa823uWhY0Y+3XHeg
         gn1os6npIC3+7LVVn/RMGiKS4gGPGAUGX8xMBiOMZhH/kufzE2p1W67VeIsBHVYNBR9l
         EPDiciKBxdFRvHUgdTuMjbBn6ywJON81MJGBZ8YbIeVgomtZ5U5OpTEzoifh0/Sl0sAv
         MoOA==
X-Gm-Message-State: AOAM530q55DVmw5bSAypowOsuVRKFKIFTZJ0N7GDX9/W+ZME08H9V+ED
        RlwI8mtxwA2FFTLSYToxkR+s5yufomBtu/MEXEeBbQ==
X-Google-Smtp-Source: ABdhPJz1dIbPRtI2UatBy2KD/GE6d9cFkS0wAFaLtoor9dgLbnw2qoyzh4xp7F/X2+FFjvYqH9TMgWjgexBcH1bqCCM=
X-Received: by 2002:a5e:8d15:0:b0:645:c856:e84a with SMTP id
 m21-20020a5e8d15000000b00645c856e84amr8616203ioj.84.1649429554195; Fri, 08
 Apr 2022 07:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220407210734.2548973-1-joel@joelfernandes.org> <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Apr 2022 10:52:21 -0400
Message-ID: <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
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

On Fri, Apr 8, 2022 at 10:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Apr 07, 2022 at 09:07:33PM +0000, Joel Fernandes wrote:
> > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > which ends up not offloading any CPU. This patch removes yet another
> > dependency from the bootloader having to know about RCU, about how many
> > CPUs the system has, and about how to provide the mask. Basically, I
> > think we should stop pretending that the user knows what they are doing :).
> > In other words, if NO_CB_CPU is enabled, lets make use of it.
> >
> > My goal is to make RCU as zero-config as possible with sane defaults. If
> > user wants to provide rcu_nocbs= or nohz_full= options, then those will
> > take precedence and this patch will have no effect.
> >
> > I tested providing rcu_nocbs= option, ensuring that is preferred over this.
>
> Unless something has changed, this would change behavior relied upon
> the enterprise distros.  Last I checked, they want to supply a single
> binary, as evidenced by the recent CONFIG_PREEMPT_DYNAMIC Kconfig option,
> and they also want the default to be non-offloaded.  That is, given a
> kernel built with CONFIG_RCU_NOCB_CPU=y and without either a nohz_full
> or a nocbs_cpu boot parameter, all of the CPUs must be non-offloaded.

Just curious, do you have information (like data, experiment results)
on why they want default non-offloaded? Or maybe they haven't tried
the recent work done in NOCB code?

Another option I think is to make it enforce NOCB if NR_CPUS <= 32 if
that makes sense.

> So for me to push this to mainline, I need an ack from someone from each
> of the enterprise distros, and each of those someones needs to understand
> the single-binary strategy used by the corresponding distro.

Ok.

> And is it really all -that- hard to specify an additional boot parameter
> across ChromeOS devices?  Android seems to manage it.  ;-)

That's not the hard part I think. The hard part is to make sure a
future Linux user who is not an RCU expert does not forget to turn it
on. ChromeOS is not the only OS that I've seen someone forget to do it
;-D. AFAIR, there were Android devices too in the past where I saw
this forgotten. I don't think we should rely on the users doing the
right thing (as much as possible).

The single kernel binary point makes sense but in this case, I think
the bigger question that I'd have is what is the default behavior and
what do *most* users of RCU want. So we can keep sane defaults for the
majority and reduce human errors related to configuration.

thanks,

-Joel
