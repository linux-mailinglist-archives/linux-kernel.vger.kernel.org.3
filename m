Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A37553DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356184AbiFUVYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355330AbiFUVXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:23:22 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666431DED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:14:41 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ef5380669cso143709247b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yIAX+lvUymbsHNaxAK41tFZmVKTSKJvlAJCa+4ex74=;
        b=q5+E1Sv9MjbRWtturKPoAKfEX/02xyKHHxLlMI16QCcjbn/vbTaM+jSpXdcPMl7Zh4
         f06Em9zkIGDmH4vsFpnMjLiLXpraHO1baQqUIflQaz838HNFKS4rJ7QvSoXoo5/3sHf3
         KotpIVA0JKxrurXUIIG/hPsVWtLaFTn6I4s52cGQ+mkeRSZfcVIYI/nV6V2dDGyfDL1f
         a88GmtuYXclahZxvb37ko3fSr90W6AodE4XB/SCVAW0qGN43PDZkZE0pixeSblHSWt65
         TU26DwjL5KFq8M1XH1mHGr+hnkv9sEo2F6Pr6D3pNEhhTAmovWtaSzNI57K+6sGdk+ap
         lung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yIAX+lvUymbsHNaxAK41tFZmVKTSKJvlAJCa+4ex74=;
        b=1E+DWUAQGgDXRFDRF83HtUApUECaiPDwIGr/UYLei0ecJTkwUPAtyd40c++WrQsXwF
         sKyot2E89c9h0MT1tShWrJ0ZEbp6erhunHfoppNatCBwLj6TFU43AqSXnSEMzF99jHk8
         dX5E/dmPZ0Poyp1Hboch0sBNIGjVir2pp8E4C/pso/7Q3a8w8UyVAYFjqhMmHCDgz+x7
         DJxveJQ2zAkHs3wUpVlaV6Y3cKXjV58DwRzMBrba7zcUbmxuFudHJuQIDlJSFHK+tI4k
         Pyamw9CAhDBqpKggIu/QSytXGEkyyFN5EH3dfgj8y1vRg9X1Mde5nYxdeMmTB39DbHZs
         /ZoQ==
X-Gm-Message-State: AJIora9XFQqpXHkHwrMC8/x2637AieeskyQqmt7/o0ZYWD+PRzOCwpuz
        KUlhJCsdO2+LHaqvcAPKLHWP74qg46pDnKp5D9BscG9eKDA=
X-Google-Smtp-Source: AGRyM1vJwyNgsXsZrcOlfsc2unXvK/3Pu1Iq0DNUgKATO0iF5eMLh5HQK7cALY8mwHq9w1ZZG1g5ZXfzwoVP8ZsuA+I=
X-Received: by 2002:a81:488f:0:b0:317:7514:ecd0 with SMTP id
 v137-20020a81488f000000b003177514ecd0mr166210ywa.412.1655846080010; Tue, 21
 Jun 2022 14:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-7-paulmck@kernel.org> <00f3eb47-2529-a493-ee67-c0c0219937a3@quicinc.com>
 <20220621193135.GM1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220621193135.GM1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jun 2022 23:14:04 +0200
Message-ID: <CANpmjNOBD6B_hY-rGCtdk2+fFox6DhsLE_bp9Q8sU=AQZs9ySQ@mail.gmail.com>
Subject: Re: [PATCH rcu 07/12] rcu: tiny: Record kvfree_call_rcu() call stack
 for KASAN
To:     paulmck@kernel.org
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Johannes Berg <johannes.berg@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 21:31, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jun 21, 2022 at 12:01:29PM +0530, Neeraj Upadhyay wrote:
> >
> >
> > On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > >
> > > When running KASAN with Tiny RCU (e.g. under ARCH=um, where
> > > a working KASAN patch is now available), we don't get any
> > > information on the original kfree_rcu() (or similar) caller
> > > when a problem is reported, as Tiny RCU doesn't record this.
> > >
> > > Add the recording, which required pulling kvfree_call_rcu()
> > > out of line for the KASAN case since the recording function
> > > (kasan_record_aux_stack_noalloc) is neither exported, nor
> > > can we include kasan.h into rcutiny.h.
> > >
> > > without KASAN, the patch has no size impact (ARCH=um kernel):
> > >      text       data         bss         dec        hex    filename
> > >   6151515    4423154    33148520    43723189    29b29b5    linux
> > >   6151515    4423154    33148520    43723189    29b29b5    linux + patch
> > >
> > > with KASAN, the impact on my build was minimal:
> > >      text       data         bss         dec        hex    filename
> > > 13915539    7388050    33282304    54585893    340ea25    linux
> > > 13911266    7392114    33282304    54585684    340e954    linux + patch
> > >     -4273      +4064         +-0        -209
> > >
> > > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >   include/linux/rcutiny.h | 11 ++++++++++-
> > >   kernel/rcu/tiny.c       | 14 ++++++++++++++
> > >   2 files changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > > index 5fed476f977f6..d84e13f2c3848 100644
> > > --- a/include/linux/rcutiny.h
> > > +++ b/include/linux/rcutiny.h
> > > @@ -38,7 +38,7 @@ static inline void synchronize_rcu_expedited(void)
> > >    */
> > >   extern void kvfree(const void *addr);
> > > -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >   {
> > >     if (head) {
> > >             call_rcu(head, func);
> > > @@ -51,6 +51,15 @@ static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >     kvfree((void *) func);
> > >   }
> > > +#ifdef CONFIG_KASAN_GENERIC
> > > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> > > +#else
> > > +static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +{
> > > +   __kvfree_call_rcu(head, func);
> > > +}
> > > +#endif
> > > +
> > >   void rcu_qs(void);
> > >   static inline void rcu_softirq_qs(void)
> > > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > > index 340b3f8b090d4..58ff3721d975c 100644
> > > --- a/kernel/rcu/tiny.c
> > > +++ b/kernel/rcu/tiny.c
> > > @@ -217,6 +217,20 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
> > >   }
> > >   EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
> > > +#ifdef CONFIG_KASAN_GENERIC
> > > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > +{
> > > +   if (head) {
> > > +           void *ptr = (void *) head - (unsigned long) func;
> > > +
> > > +           kasan_record_aux_stack_noalloc(ptr);
> > > +   }
> >
> > For the !head case; similar to Tree RCU's kvfree_call_rcu() implementation,
> > we do not need to record 'ptr' (which will be 'func')?
>
> My understanding is that we do not need to record in that case
> because __kvfree_call_rcu() will simply invoke the almost-zero-cost
> synchronize_rcu() and then invoke kfree().
>
> Johannes, Dmitry, Marco, anything that I am missing?

As-is looks sensible - doing kasan_record_aux_stack_noalloc() only
makes sense if the actual kfree() is not done with a callstack that
will point at the kvfree_call_rcu() caller. Otherwise we're doing
redundant work and just polluting the aux stack storage slots. So in
the case where kvfree_call_rcu() does synchronize_rcu() and kfree()
the kvfree_call_rcu() caller is in the callstack, and would be shown
on use-after-free bugs.

Thanks,
-- Marco
