Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329DB59FC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiHXN5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbiHXNyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:54:53 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C25185AA1;
        Wed, 24 Aug 2022 06:53:25 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l23so5457538lji.1;
        Wed, 24 Aug 2022 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+00v8/E5qk1yIDkZWdbSORfSXrpxHk75ngoT4usDJks=;
        b=glXo7h1wsPI13hRWOMz20kLzJTYz7GZS3cDQv1yW2PT6lIxGH1geTSHQM0kQOdOxgM
         WQmBfcxvUIAqg1XbeVw5/0FyXGfS4DCU/s7gJhuDoXLRXbhEqAgAdy076KEMq7JS3EDq
         yYuykppwoRJEmIPaKMjX9LucwxbuZK2wwu+9qw7ruP6t3bgfHe3GezbX2fLONAMZ/1l5
         ZjWKHvbtljDOkl7fol0JThcRbPHFuKX8L/rg/okhpB5/HpTYnQzWNEPyXZQ8C7Z1crUD
         a0shqzhTMlaxmi4n7C88Hi6eMvg9QJOVrW4S27SyeZ7LGJy+vAEFKUmq2IpNl06nhpbz
         FxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+00v8/E5qk1yIDkZWdbSORfSXrpxHk75ngoT4usDJks=;
        b=wFLVXx6+y3v/heJizzB4x9EGsdlN7furFpc2DGrM1jbVKh+LXuyvBOpc+NN3aSvMCe
         6xzmpBbLgueFRBscMGE2yYMPiU6ThPg5GVMVrjteu1Z+YJEhbZ18g54Tw/dpJtvoIJq6
         9SGSqdqd04uMfiiVovLH2DIGMb+yMzCG1gQbzGRxP9sjkh88+nsNHOW1MLT0Hicg6IFr
         pBLsWwIYoa4sBVwtMDZ307ys45Ud8QyD4Ema2TL9nL8dzi2yxINYjwkTEs/3oxi7QZcA
         coBr5Z6DuQVbvstHISPSsxsjx6X5+jYOT/N7cEYflkPw+0X2yrlxGtSWOpyQXcuZJ7IZ
         m5nw==
X-Gm-Message-State: ACgBeo3P39ol28iDYzNm8eUALjGroUd5En0su45gPjcA9EZTA8f8nHYl
        XRrPc63YWCRVk4qt25ZTiRJSTvLS9Uvi66ZzdQ==
X-Google-Smtp-Source: AA6agR796Vc7t3+Eq4HsjuvtQEqpwVsDpz0JZ7uhhfRDt19W8t8FnNDynkT3KJj7m42/JlX/ty0HVA+4ivKYqw1QnFc=
X-Received: by 2002:a2e:8250:0:b0:261:e2db:f6a5 with SMTP id
 j16-20020a2e8250000000b00261e2dbf6a5mr718381ljh.261.1661349202581; Wed, 24
 Aug 2022 06:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220822021520.6996-1-kernelfans@gmail.com> <20220822021520.6996-7-kernelfans@gmail.com>
 <20220822024528.GC6159@paulmck-ThinkPad-P17-Gen-1> <YwQygLBtzqwxuMIJ@piliu.users.ipa.redhat.com>
 <20220823030125.GJ6159@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220823030125.GJ6159@paulmck-ThinkPad-P17-Gen-1>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 24 Aug 2022 21:53:11 +0800
Message-ID: <CAFgQCTup0uTqnKi79Tu+5Q0POYVdcE4UkGes8KfHXBd6VR552A@mail.gmail.com>
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, boqun.feng@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 11:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Aug 23, 2022 at 09:50:56AM +0800, Pingfan Liu wrote:
> > On Sun, Aug 21, 2022 at 07:45:28PM -0700, Paul E. McKenney wrote:
> > > On Mon, Aug 22, 2022 at 10:15:16AM +0800, Pingfan Liu wrote:
> > > > In order to support parallel, rcu_state.n_online_cpus should be
> > > > atomic_dec()
> > > >
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > >
> > > I have to ask...  What testing have you subjected this patch to?
> > >
> >
> > This patch subjects to [1]. The series aims to enable kexec-reboot in
> > parallel on all cpu. As a result, the involved RCU part is expected to
> > support parallel.
>
> I understand (and even sympathize with) the expectation.  But results
> sometimes diverge from expectations.  There have been implicit assumptions
> in RCU about only one CPU going offline at a time, and I am not sure
> that all of them have been addressed.  Concurrent CPU onlining has
> been looked at recently here:
>
> https://docs.google.com/document/d/1jymsaCPQ1PUDcfjIKm0UIbVdrJAaGX-6cXrmcfm0PRU/edit?usp=sharing
>
> You did us atomic_dec() to make rcu_state.n_online_cpus decrementing be
> atomic, which is good.  Did you look through the rest of RCU's CPU-offline
> code paths and related code paths?
>

I went through those codes at a shallow level, especially at each
cpuhp_step hook in the RCU system.

But as you pointed out, there are implicit assumptions about only one
CPU going offline at a time, I will chew the google doc which you
share.  Then I can come to a final result.

> > [1]: https://lore.kernel.org/linux-arm-kernel/20220822021520.6996-3-kernelfans@gmail.com/T/#mf62352138d7b040fdb583ba66f8cd0ed1e145feb
>
> Perhaps I am more blind than usual today, but I am not seeing anything
> in this patch describing the testing.  At this point, I am thinking in
> terms of making rcutorture test concurrent CPU offlining parallel
>

Yes, testing results are more convincing in this area.

After making clear the implicit assumptions, I will write some code to
bridge my code and rcutorture test. Since the series is a little
different from parallel cpu offlining. It happens after all devices
are torn down, and there is no way to rollback.

> Thoughts?
>

Need a deeper dive into this field. Hope to bring out something soon.


Thanks,

    Pingfan
