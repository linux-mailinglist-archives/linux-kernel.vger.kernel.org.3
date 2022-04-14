Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F457501D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346804AbiDNVMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346799AbiDNVMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171CF62A3A;
        Thu, 14 Apr 2022 14:10:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A4261FBC;
        Thu, 14 Apr 2022 21:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC85C385A5;
        Thu, 14 Apr 2022 21:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649970605;
        bh=tfMsYagwtq0NhrnrtHFVy+YRVYRjNKvi4tiYz8ThGaE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nVJkAqFkX4dbAf73bYDGIeREZF4wDBTmOVAaIR/gAVlFPf29kjAFV4Nptx5wxdeZc
         /AXheP4y8t7tGcxSgdG6EBQen3zuMrgGKaPwCQoPh3mbBVnLPxcFAp6QuiNDV5Murs
         HqmgAtHMJjlrJhrflAsm3RkQw1FEqV6DwwgL3WRwukg013RrKxqoHDc1I1ixXtr7FN
         GbeiIRIVC28g0pS6HmZdf5+JDMwYm+GRsvJRGzBNGy7BiifaTJAhovoPWVBGmP6G/D
         +oEoSI2cuBzh5tI1J+C3tpsyje7Z2rhpcxgJOr1l3Bn/85X1KjF3THdV5ybPX+KoMl
         IaL2fQlVViTRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 998BA5C03A5; Thu, 14 Apr 2022 14:10:04 -0700 (PDT)
Date:   Thu, 14 Apr 2022 14:10:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <20220414211004.GX4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
 <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <Ylhz1LOIf+JyjH7n@google.com>
 <20220414194204.GU4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YS5b_51tqmdf27QqQHqsgJKbTys1V3h+Bek3XN4FjBmbw@mail.gmail.com>
 <CAEXW_YQPEoM0vhpjNHtPd6GRkosfzK95yGt4eB=-C2mC32LjmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQPEoM0vhpjNHtPd6GRkosfzK95yGt4eB=-C2mC32LjmQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:51:29PM -0400, Joel Fernandes wrote:
> On Thu, Apr 14, 2022 at 3:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, Apr 14, 2022 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Apr 14, 2022 at 07:19:48PM +0000, Joel Fernandes wrote:
> > > > On Mon, Apr 11, 2022 at 08:41:09AM -0700, Paul E. McKenney wrote:
> > > > [..]
> > > > > > > [4]     All CPUs are offloaded at boot, and any CPU can be de-offloaded
> > > > > > >         and offloaded at runtime.  This is the same behavior that
> > > > > > >         you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> > > > > > >         rcu_nocbs=0-N.
> > > > > >
> > > > > > Yes, this is the behavior I intend. So then there would not be a need
> > > > > > to pass a mask (and I suspect for a large number of users, it
> > > > > > simplifies boot params).
> > > > >
> > > > > Very good, and from what I can see, this should work for everyone.
> > > >
> > > > Just to clarify, what I am going to do is, if this new option =y, then
> > > > rcu_nocbs effectively wont do anything. i.e. All CPUs are offloaded at boot.
> > > > Let me know if we are not on the same page about it though. I do feel that is
> > > > a sensible choice given =y. If we are on same page, please ignore my comment.
> > >
> > > I was assuming that the rcu_nocbs=??? for non-empty "???" would override
> > > the CONFIG_RCU_NOCB_CPU_ALL=y.  If you choose not to do that, shouldn't
> > > you at least issue some sort of diagnostic?  After all, the sysadmin
> > > gave a kernel-boot parameter asking the code to do something and the
> > > code is choosing not to do that something.
> > >
> > > Of course, such a sysadmin might want the CONFIG_RCU_NOCB_CPU_ALL=y
> > > Kconfig option to affect only the default, that is, when no rcu_nocbs
> > > kernel boot parameter is specified.  This would change the second "[4]"
> > > in my original table to "[2]".
> > >
> > > Thoughts?
> >
> > I thought about that. I feel that since we are defaulting the new
> > config option to =n , it is a conscious choice by the distro to set it
> > to =y.  In such a case, they should be Ok with offloading all CPUs. If
> > they decide to selectively offload some CPUs in the future, then they
> > could revisit the config option at that time.
> >
> > I feel the kernel config should override the boot parameter behavior.
> > It is the same effect as a sysadmin passing kernel parameter X
> > assuming the kernel does something but the CONFIG option might not
> > even build code corresponding to X.
> >
> > I feel to address your concern, we can document in kernel command line
> > documentation that rcu_nocbs= does not have an effect if
> > CONFIG_RCU_NOCB_CPU_ALL=y, would that work for you?
> 
> Along with documentation, I like your idea of printing a diagnostic in
> such a situation. I will certainly do that.

Seriously.  Take some time.  Think carefully about it.

							Thanx, Paul

> Thanks,
> 
>  - Joel
> 
> >
> > Thanks,
> >
> > - Joel
> >
> > >
> > > > > > > I believe that Steve Rostedt's review would carry weight for ChromeOS,
> > > > > > > however, I am suffering a senior moment on the right person for Android.
> > > > > >
> > > > > > I think for Android, Kalesh Singh is in the kernel team and Tim Murray
> > > > > > is the performance lead. They could appropriately represent their RCU
> > > > > > needs.
> > > > >
> > > > > Sounds good!  Please collect a Reviewed-by from one or both of them.
> > > >
> > > > Ok.
> > >
> > >                                                         Thanx, Paul
