Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B24553E65
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiFUWRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiFUWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:17:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6CE30F7C;
        Tue, 21 Jun 2022 15:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB1346171B;
        Tue, 21 Jun 2022 22:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352DFC3411D;
        Tue, 21 Jun 2022 22:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655849821;
        bh=eAPR7iWjyiUmY6H0O4buVVeyi0I34ruyb5/gJDTQtF4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QzywVmsIkAfi9LCySImCB4DJuCT3LX1op3hFQ1G1ZIIPtEmg711bI8Js7ZtUbkXIa
         2KqxT5A8db3Ba2DNZVj7zsTURpM/1vdVkIWAsd/JwHLoDcU41ON0zubG3qkC5Nxm2s
         o79aj8Yd5d+XXKkQ1qx4AHWAe/RbCHqdkN4cpclkkT9LQO6aNf2MK5uaJs869ctcQi
         Yq5SqgBYfukVR2sRRT9xOzED1oUi1Hnv7QOOyiCwLLGLWQsfbx7p3slup12GhuHb+Z
         F/YXtVPgyNhcjSK72GqLt6cJllg5T78dIZvv0UqxRCY7CmqR8B4/yPLIlDZ74Dl1g6
         /XEVWA5AFyC5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D849E5C0AE0; Tue, 21 Jun 2022 15:17:00 -0700 (PDT)
Date:   Tue, 21 Jun 2022 15:17:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Johannes Berg <johannes.berg@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH rcu 07/12] rcu: tiny: Record kvfree_call_rcu() call stack
 for KASAN
Message-ID: <20220621221700.GP1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-7-paulmck@kernel.org>
 <00f3eb47-2529-a493-ee67-c0c0219937a3@quicinc.com>
 <20220621193135.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNOBD6B_hY-rGCtdk2+fFox6DhsLE_bp9Q8sU=AQZs9ySQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOBD6B_hY-rGCtdk2+fFox6DhsLE_bp9Q8sU=AQZs9ySQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:14:04PM +0200, Marco Elver wrote:
> On Tue, 21 Jun 2022 at 21:31, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Jun 21, 2022 at 12:01:29PM +0530, Neeraj Upadhyay wrote:
> > >
> > >
> > > On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
> > > > From: Johannes Berg <johannes.berg@intel.com>
> > > >
> > > > When running KASAN with Tiny RCU (e.g. under ARCH=um, where
> > > > a working KASAN patch is now available), we don't get any
> > > > information on the original kfree_rcu() (or similar) caller
> > > > when a problem is reported, as Tiny RCU doesn't record this.
> > > >
> > > > Add the recording, which required pulling kvfree_call_rcu()
> > > > out of line for the KASAN case since the recording function
> > > > (kasan_record_aux_stack_noalloc) is neither exported, nor
> > > > can we include kasan.h into rcutiny.h.
> > > >
> > > > without KASAN, the patch has no size impact (ARCH=um kernel):
> > > >      text       data         bss         dec        hex    filename
> > > >   6151515    4423154    33148520    43723189    29b29b5    linux
> > > >   6151515    4423154    33148520    43723189    29b29b5    linux + patch
> > > >
> > > > with KASAN, the impact on my build was minimal:
> > > >      text       data         bss         dec        hex    filename
> > > > 13915539    7388050    33282304    54585893    340ea25    linux
> > > > 13911266    7392114    33282304    54585684    340e954    linux + patch
> > > >     -4273      +4064         +-0        -209
> > > >
> > > > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> > > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >   include/linux/rcutiny.h | 11 ++++++++++-
> > > >   kernel/rcu/tiny.c       | 14 ++++++++++++++
> > > >   2 files changed, 24 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > > > index 5fed476f977f6..d84e13f2c3848 100644
> > > > --- a/include/linux/rcutiny.h
> > > > +++ b/include/linux/rcutiny.h
> > > > @@ -38,7 +38,7 @@ static inline void synchronize_rcu_expedited(void)
> > > >    */
> > > >   extern void kvfree(const void *addr);
> > > > -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > +static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >   {
> > > >     if (head) {
> > > >             call_rcu(head, func);
> > > > @@ -51,6 +51,15 @@ static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >     kvfree((void *) func);
> > > >   }
> > > > +#ifdef CONFIG_KASAN_GENERIC
> > > > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> > > > +#else
> > > > +static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > +{
> > > > +   __kvfree_call_rcu(head, func);
> > > > +}
> > > > +#endif
> > > > +
> > > >   void rcu_qs(void);
> > > >   static inline void rcu_softirq_qs(void)
> > > > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > > > index 340b3f8b090d4..58ff3721d975c 100644
> > > > --- a/kernel/rcu/tiny.c
> > > > +++ b/kernel/rcu/tiny.c
> > > > @@ -217,6 +217,20 @@ bool poll_state_synchronize_rcu(unsigned long oldstate)
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
> > > > +#ifdef CONFIG_KASAN_GENERIC
> > > > +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > +{
> > > > +   if (head) {
> > > > +           void *ptr = (void *) head - (unsigned long) func;
> > > > +
> > > > +           kasan_record_aux_stack_noalloc(ptr);
> > > > +   }
> > >
> > > For the !head case; similar to Tree RCU's kvfree_call_rcu() implementation,
> > > we do not need to record 'ptr' (which will be 'func')?
> >
> > My understanding is that we do not need to record in that case
> > because __kvfree_call_rcu() will simply invoke the almost-zero-cost
> > synchronize_rcu() and then invoke kfree().
> >
> > Johannes, Dmitry, Marco, anything that I am missing?
> 
> As-is looks sensible - doing kasan_record_aux_stack_noalloc() only
> makes sense if the actual kfree() is not done with a callstack that
> will point at the kvfree_call_rcu() caller. Otherwise we're doing
> redundant work and just polluting the aux stack storage slots. So in
> the case where kvfree_call_rcu() does synchronize_rcu() and kfree()
> the kvfree_call_rcu() caller is in the callstack, and would be shown
> on use-after-free bugs.

Thank you for checking and for confirmation!

							Thanx, Paul
