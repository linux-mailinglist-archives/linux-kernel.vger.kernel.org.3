Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5415A044F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiHXWyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiHXWyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:54:15 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BAD792D7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:54:14 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id x64so14634673iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YzSGn2dwYx9MaxeNT5wOgLOGOLdzT7ca2Get9KWngZY=;
        b=Hr3sPSxUonzow3KkSdGol2N/BWjIgts6D3nLpP2kKmImFaMw16jbrkb1YAKrPn0LMr
         dj8E6kU9LssBAhB1DwsfXXC3yEBem03+ikqOw+cqBBG5P2NMcD8pwg3sA1PILsrMBj9z
         AgP6Y+cPupOJkxApWu5pC39RwKCYRd7+ARvWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YzSGn2dwYx9MaxeNT5wOgLOGOLdzT7ca2Get9KWngZY=;
        b=IPCWLfP9lXRVko9o8mQcl/1THdKSiB/7Y9SsNdj40mBXasrYIlYcclHApznN7fM/jZ
         XLOflUqMyDaVPEp0bHDzgqauxfxfKgXZ/A3EC060v5isCEaGRBmamR8xssm3pbsA/io9
         4jvb/IY4xD2Hc7HIXU3vaAKOF6E5n6b+2swFmFxz4o0NHGvKO4YqNHI/VmJqlkv5fuLu
         U8Y2ikB0n9xEpd8sRQ4p6aVLinZwEx/BS4egMDSwU1PzcobQUqslp1fhX9YNSGlu2/45
         a+CdgspWFvWTjRCPPukXXWMEj0CcMWlP+c2V9tWRopPjjiH7ptqC3CK7tj3aJgyYppSr
         3yig==
X-Gm-Message-State: ACgBeo2PcM04aZXbZ2ag/ktEzNoA1o2XmpRvioDvhRhpN38mHC+xSHfk
        TRskfQqFzMWnWlrVhWJi16bKZzHhH8M8knTr8Dvysw==
X-Google-Smtp-Source: AA6agR4Njpnz6WV8+fJswTe7oOxwU4fZk9QCMPY12LpUBEQ7s9dtcLsSrsbXE9MLP9rt83FFku42HjvZfmFuGstJ2Ys=
X-Received: by 2002:a5d:9914:0:b0:67c:2039:caff with SMTP id
 x20-20020a5d9914000000b0067c2039caffmr467782iol.201.1661381653450; Wed, 24
 Aug 2022 15:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220822021520.6996-1-kernelfans@gmail.com> <20220822021520.6996-7-kernelfans@gmail.com>
 <20220822024528.GC6159@paulmck-ThinkPad-P17-Gen-1> <YwQygLBtzqwxuMIJ@piliu.users.ipa.redhat.com>
 <20220823030125.GJ6159@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTup0uTqnKi79Tu+5Q0POYVdcE4UkGes8KfHXBd6VR552A@mail.gmail.com>
 <20220824162050.GA6159@paulmck-ThinkPad-P17-Gen-1> <de70b840-df04-5a52-c36f-9eaed839aa7c@joelfernandes.org>
 <20220824192129.GE6159@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220824192129.GE6159@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 24 Aug 2022 18:54:01 -0400
Message-ID: <CAEXW_YTvbsrQAxx4Qdme-9T_pUAo00+ZM0qug1tk4puEPmYn4A@mail.gmail.com>
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 3:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Aug 24, 2022 at 01:26:01PM -0400, Joel Fernandes wrote:
> >
> >
> > On 8/24/2022 12:20 PM, Paul E. McKenney wrote:
> > > On Wed, Aug 24, 2022 at 09:53:11PM +0800, Pingfan Liu wrote:
> > >> On Tue, Aug 23, 2022 at 11:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >>>
> > >>> On Tue, Aug 23, 2022 at 09:50:56AM +0800, Pingfan Liu wrote:
> > >>>> On Sun, Aug 21, 2022 at 07:45:28PM -0700, Paul E. McKenney wrote:
> > >>>>> On Mon, Aug 22, 2022 at 10:15:16AM +0800, Pingfan Liu wrote:
> > >>>>>> In order to support parallel, rcu_state.n_online_cpus should be
> > >>>>>> atomic_dec()
> > >>>>>>
> > >>>>>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > >>>>>
> > >>>>> I have to ask...  What testing have you subjected this patch to?
> > >>>>>
> > >>>>
> > >>>> This patch subjects to [1]. The series aims to enable kexec-reboot in
> > >>>> parallel on all cpu. As a result, the involved RCU part is expected to
> > >>>> support parallel.
> > >>>
> > >>> I understand (and even sympathize with) the expectation.  But results
> > >>> sometimes diverge from expectations.  There have been implicit assumptions
> > >>> in RCU about only one CPU going offline at a time, and I am not sure
> > >>> that all of them have been addressed.  Concurrent CPU onlining has
> > >>> been looked at recently here:
> > >>>
> > >>> https://docs.google.com/document/d/1jymsaCPQ1PUDcfjIKm0UIbVdrJAaGX-6cXrmcfm0PRU/edit?usp=sharing
> > >>>
> > >>> You did us atomic_dec() to make rcu_state.n_online_cpus decrementing be
> > >>> atomic, which is good.  Did you look through the rest of RCU's CPU-offline
> > >>> code paths and related code paths?
> > >>
> > >> I went through those codes at a shallow level, especially at each
> > >> cpuhp_step hook in the RCU system.
> > >
> > > And that is fine, at least as a first step.
> > >
> > >> But as you pointed out, there are implicit assumptions about only one
> > >> CPU going offline at a time, I will chew the google doc which you
> > >> share.  Then I can come to a final result.
> > >
> > > Boqun Feng, Neeraj Upadhyay, Uladzislau Rezki, and I took a quick look,
> > > and rcu_boost_kthread_setaffinity() seems to need some help.  As it
> > > stands, it appears that concurrent invocations of this function from the
> > > CPU-offline path will cause all but the last outgoing CPU's bit to be
> > > (incorrectly) set in the cpumask_var_t passed to set_cpus_allowed_ptr().
> > >
> > > This should not be difficult to fix, for example, by maintaining a
> > > separate per-leaf-rcu_node-structure bitmask of the concurrently outgoing
> > > CPUs for that rcu_node structure.  (Similar in structure to the
> > > ->qsmask field.)
> > >
> > > There are probably more where that one came from.  ;-)
> >
> > Should rcutree_dying_cpu() access to rnp->qsmask have a READ_ONCE() ? I was
> > thinking grace period initialization or qs reporting paths racing with that. Its
> > just tracing, still :)
>
> Looks like it should be regardless of Pingfan's patches, given that
> the grace-period kthread might report a quiescent state concurrently.

Thanks for confirming, I'll queue it into my next revision of the series.

 - Joel
