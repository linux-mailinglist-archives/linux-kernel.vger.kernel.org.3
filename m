Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB10B54E8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiFPRuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243248AbiFPRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC93C4CD54
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE507618E8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497A1C34114;
        Thu, 16 Jun 2022 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655401779;
        bh=jp1i6DksrsdnGuY6hAh7dLb7WYttM9+yqrIKrAy/6uE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pfDQHgzmtWaBJKpDvwlmP1yzyxM5SWS61HqtJm3N3UJpsz67Tj9NYlEsuiXWCAUY9
         nAv9iSGsY3Duygyt2kbPm/womtj8NXdaeaepILarnRrSfKIC6RFUnP3XuGG9ZbS7u+
         gWG1eb1TJ9v9jXCLLnCPeIz/HR+6CFbjiunK5rFraJcFqORYiwTlpumQDnttPM05ds
         G3mX9xDcZA2UEoG80sC1FKyC9doKe/MkSNFi8T2V3wE8b3Q/KTeMDovBJoivL71LiD
         XQN3f+LdlQnniIp3wmAEKu1hmHS8ysa3Fg0+ASs5LTKSBYE3A4tHDS8aq+FckhI63Z
         yJm3Te9ouN4eg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AFB135C0531; Thu, 16 Jun 2022 10:49:38 -0700 (PDT)
Date:   Thu, 16 Jun 2022 10:49:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/pmladek.2022.06.15a
 133/140] vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to
 __kasan_check_read() leaves .noinstr.text section
Message-ID: <20220616174938.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202206160411.v3iL3YC0-lkp@intel.com>
 <20220615204039.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220615211717.GA972937@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNMswUJhqfttxZGbkfN7X5d5FLiS1yPXzzGDivLtWDB9=g@mail.gmail.com>
 <20220616134021.GP1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220616164416.GA2130702@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNPhfGnO8qebvPd2pEqO37qTAa8pUAOTy2MXqT4R+iZ8QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPhfGnO8qebvPd2pEqO37qTAa8pUAOTy2MXqT4R+iZ8QA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 07:32:14PM +0200, Marco Elver wrote:
> On Thu, 16 Jun 2022 at 18:44, Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > > > > > >> vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read() leaves .noinstr.text section
> > > > > > > >> vmlinux.o: warning: objtool: __ct_user_enter+0x7f: call to __kasan_check_read() leaves .noinstr.text section
> [...]
> > > > It's due to the atomic_read()s within the noinstr function. Within
> > > > noinstr you can use arch_atomic_read() to avoid the instrumentation.
> > >
> > > Thank you, will fix!
> >
> > And please see below for an alleged fix.
> 
> Looks good, if this made the above warnings go away.

Here is hoping!  I will see if I can reproduce locally.  ;-)

> Btw, it's not just KASAN, but arch_atomic_read() also disables KCSAN
> checking. A similar warning would have been generated in a KCSAN
> config.

Good to know, thank you!  Additional local-reproduce opportunities.

> Reviewed-by: Marco Elver <elver@google.com>

Applied, thank you!

                                                         Thanx, Paul

> > ------------------------------------------------------------------------
> >
> > commit 81e24ca26ee9933bcacf67a61e3f6ae41a025442
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Jun 16 09:30:37 2022 -0700
> >
> >     context_tracking: Use arch_atomic_read() in __ct_state for KASAN
> >
> >     Context tracking's __ct_state() function can be invoked from noinstr state
> >     where RCU is not watching.  This means that its use of atomic_read()
> >     causes KASAN to invoke the non-noinstr __kasan_check_read() function
> >     from the noinstr function __ct_state().  This is problematic because
> >     someone tracing the __kasan_check_read() function could get a nasty
> >     surprise because of RCU not watching.
> >
> >     This commit therefore replaces the __ct_state() function's use of
> >     atomic_read() with arch_atomic_read(), which KASAN does not attempt to
> >     add instrumention to.
> >
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Cc: Frederic Weisbecker <frederic@kernel.org>
> >     Cc: Marco Elver <elver@google.com>
> >
> > diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> > index 0aecc07fb4f50..81c51e5f03143 100644
> > --- a/include/linux/context_tracking_state.h
> > +++ b/include/linux/context_tracking_state.h
> > @@ -49,7 +49,7 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
> >
> >  static __always_inline int __ct_state(void)
> >  {
> > -       return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
> > +       return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
> >  }
> >  #endif
> >
