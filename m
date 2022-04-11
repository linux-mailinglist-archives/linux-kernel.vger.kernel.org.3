Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BF4FC038
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347734AbiDKPT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238081AbiDKPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:19:29 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5232987
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:17:12 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 125so19025952iov.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bOnxhvyFu1KFDIwI6ndnAclb7ZxIr/6CV1yYpf1Bes=;
        b=GB26TYrSINxhGazbfecUKbKOvRBG2h7WaiDZsuS7zDIBqERDKFCdOm/nTh5hpQtnkX
         jpDRGuYn80BIPZ8F/X+Hke7RrUGztKcufbIvpVXV5dJPiqUGFkpRxHuAPyMcPXjsRk2c
         g9Kiqhu5xUG10VFg4fa8ydlaiMVfRgY/cLEFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bOnxhvyFu1KFDIwI6ndnAclb7ZxIr/6CV1yYpf1Bes=;
        b=JkjQgk8dQ4vYvGa5ZKNYnnqjtXu4dbqxtTubeKisLZIZLqpjr1MbHTNkmWw96Q1sOO
         fAyvqlIRmOdx2kiX4HGyt+A95BJwaHOLH+D7WJg/XmWBmvt0n/catgsTecR9MsK5vWwv
         Tto6FrS6rFPKoKlpr8Y1UcLoxZ+qvK792+S6JMJv+pYTmvfhwB0nOgEoxOjaf5dd+OT+
         FsqnE7pPubxbp28r/OxyNvMeHmvDIbBc3BUeoc2un2p2gdy0SY874aqROyf9ltm0i/fK
         eneJb+nKSvWcWXYHaEvXkheQlTcG2RXhPO80WI5gRJXQZbwW1ZfPeW12rz3m/pptZ6nK
         ULBg==
X-Gm-Message-State: AOAM531vO2G47NQ8+fdF0Z6BBW8cccEfP7KbsIj8yVr7wiBcVD0IXA7F
        mhqz25OVcOGGNmwTt057XHE71U92hhvTZzbjle8qHQ==
X-Google-Smtp-Source: ABdhPJy0DqaAuttOjotWWhPp+/kBCx+bazwIR8MyLpsKNTDtTZJBe7IV/TwFnX3pG7W7nr5rDgRfY64SOudznpSE1lI=
X-Received: by 2002:a05:6638:240b:b0:326:bd5:8a6f with SMTP id
 z11-20020a056638240b00b003260bd58a6fmr5484217jat.52.1649690231585; Mon, 11
 Apr 2022 08:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220407210734.2548973-1-joel@joelfernandes.org>
 <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com> <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 11 Apr 2022 11:17:02 -0400
Message-ID: <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for RCU_NOCB_CPU=y
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Apr 8, 2022 at 4:54 PM Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > > > > > > > And is it really all -that- hard to specify an additional boot parameter
> > > > > > > > across ChromeOS devices?  Android seems to manage it.  ;-)
> > > > > > >
> > > > > > > That's not the hard part I think. The hard part is to make sure a
> > > > > > > future Linux user who is not an RCU expert does not forget to turn it
> > > > > > > on. ChromeOS is not the only OS that I've seen someone forget to do it
> > > > > > > ;-D. AFAIR, there were Android devices too in the past where I saw
> > > > > > > this forgotten. I don't think we should rely on the users doing the
> > > > > > > right thing (as much as possible).
> > > > > > >
> > > > > > > The single kernel binary point makes sense but in this case, I think
> > > > > > > the bigger question that I'd have is what is the default behavior and
> > > > > > > what do *most* users of RCU want. So we can keep sane defaults for the
> > > > > > > majority and reduce human errors related to configuration.
> > > > > >
> > > > > > If both the ChromeOS and Android guys need it, I could reinstate the
> > > > > > old RCU_NOCB_CPU_ALL Kconfig option.  This was removed due to complaints
> > > > > > about RCU Kconfig complexity, but I believe that Reviewed-by from ChromeOS
> > > > > > and Android movers and shakers would overcome lingering objections.
> > > > > >
> > > > > > Would that help?
> > > > >
> > > > > Yes, I think I would love for such a change. I am planning to add a
> > > > > test to ChromeOS to check whether config options were correctly set
> > > > > up. So I can test for both the RCU_NOCB_CPU options.
> > > >
> > > > Very good!
> > > >
> > > > Do you love such a change enough to create the patch and to collect
> > > > convincing Reviewed-by tags?
> > >
> > > Yes sure, just so I understand - basically I have to make the code in
> > > my patch run when RCU_NOCB_CPU_ALL option is passed (and keep the
> > > option default disabled), but otherwise default to the current
> > > behavior, right?
> >
> > Sorry rephrasing, "make the code in my patch run when the new
> > CONFIG_RCU_NOCB_CPU_ALL is enabled".
>
> Here is what I believe you are proposing:
>
>
>                                 ---     rcu_nocbs       rcu_nocbs=???
>
> CONFIG_RCU_NOCB_CPU_ALL=n       [1]     [2]             [3]
>
> CONFIG_RCU_NOCB_CPU_ALL=y       [4]     [4]             [3]

It is always a pleasure to read your well thought out emails ;-)

>
> [1]     No CPUs are offloaded at boot.  CPUs cannot be offloaded at
>         runtime.
>
> [2]     No CPUs are offloaded at boot, but any CPU can be offloaded
>         (and later de-offloaded) at runtime.
>
> [3]     The set of CPUs that are offloaded at boot are specified by the
>         mask, represented above with "???".  The CPUs that are offloaded
>         at boot can be de-offloaded and offloaded at runtime.  The CPUs
>         not offloaded at boot cannot be offloaded at runtime.

Hmm, in other words you are saying that in current code, if only
select CPUs are offloaded at boot - then only those can be toggled,
but the others are deemed not offload-able? I am happy to leave that
quirk/behavior alone as I don't care much right now (for our use
cases) for runtime toggling.

> [4]     All CPUs are offloaded at boot, and any CPU can be de-offloaded
>         and offloaded at runtime.  This is the same behavior that
>         you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
>         rcu_nocbs=0-N.

Yes, this is the behavior I intend. So then there would not be a need
to pass a mask (and I suspect for a large number of users, it
simplifies boot params).

> I believe that Steve Rostedt's review would carry weight for ChromeOS,
> however, I am suffering a senior moment on the right person for Android.

I think for Android, Kalesh Singh is in the kernel team and Tim Murray
is the performance lead. They could appropriately represent their RCU
needs.

Thanks,

 - Joel
