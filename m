Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53C501E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347054AbiDNWja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiDNWj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BDEC6B54;
        Thu, 14 Apr 2022 15:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D66B620B1;
        Thu, 14 Apr 2022 22:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F1DC385A1;
        Thu, 14 Apr 2022 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649975821;
        bh=nZQEIAbV5ImpOLfoFMOS/d41QAE77juoAmcn5Yjj7tA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B/Hf6TyRY7JsgqhNQ3nTtIGf3lGpUXrfXJW678cB0qzeQLDuY9H2g2EcImCya6n3R
         hGHP4XHgAb4/CLP9O1kJDkKunKQlBlsu2Rdh/aRs/zDUwD1ZDrnFkqHHEj9g2q7ls7
         jFGvG6p106PbNw76zvltWV9HNgCgGg3leAcMof7J7tFGXSLijjmsNPPT/bIXmeWKbU
         aUoVz+eG27Zel9GOyAdtTi60sxVGkQ9pwgNO5zDPHPSqPmP3eWFQ8MGS8jRfgskDaS
         X/LJUcDIoJFtG/PcYd5IPFbBQH28crgO+fe0eZVdoBXROd+7ZoS8lC4dsXQYMLSEvT
         3dHw8s92/hbxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 158315C013A; Thu, 14 Apr 2022 15:37:01 -0700 (PDT)
Date:   Thu, 14 Apr 2022 15:37:01 -0700
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
Message-ID: <20220414223701.GD4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
 <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <Ylhz1LOIf+JyjH7n@google.com>
 <20220414194204.GU4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YS5b_51tqmdf27QqQHqsgJKbTys1V3h+Bek3XN4FjBmbw@mail.gmail.com>
 <20220414210933.GW4285@paulmck-ThinkPad-P17-Gen-1>
 <YliOnZC6gva5WZrG@google.com>
 <20220414213156.GZ4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YT0CDp7kqKVeqGRT8YfXiCYuL0ZgRwz05MQrmns2Yp+2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YT0CDp7kqKVeqGRT8YfXiCYuL0ZgRwz05MQrmns2Yp+2Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:38:08PM -0400, Joel Fernandes wrote:
> On Thu, Apr 14, 2022 at 5:31 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Apr 14, 2022 at 09:14:05PM +0000, Joel Fernandes wrote:
> > > On Thu, Apr 14, 2022 at 02:09:33PM -0700, Paul E. McKenney wrote:
> > > > On Thu, Apr 14, 2022 at 03:49:16PM -0400, Joel Fernandes wrote:
> > > > > On Thu, Apr 14, 2022 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Apr 14, 2022 at 07:19:48PM +0000, Joel Fernandes wrote:
> > > > > > > On Mon, Apr 11, 2022 at 08:41:09AM -0700, Paul E. McKenney wrote:
> > > > > > > [..]
> > > > > > > > > > [4]     All CPUs are offloaded at boot, and any CPU can be de-offloaded
> > > > > > > > > >         and offloaded at runtime.  This is the same behavior that
> > > > > > > > > >         you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> > > > > > > > > >         rcu_nocbs=0-N.
> > > > > > > > >
> > > > > > > > > Yes, this is the behavior I intend. So then there would not be a need
> > > > > > > > > to pass a mask (and I suspect for a large number of users, it
> > > > > > > > > simplifies boot params).
> > > > > > > >
> > > > > > > > Very good, and from what I can see, this should work for everyone.
> > > > > > >
> > > > > > > Just to clarify, what I am going to do is, if this new option =y, then
> > > > > > > rcu_nocbs effectively wont do anything. i.e. All CPUs are offloaded at boot.
> > > > > > > Let me know if we are not on the same page about it though. I do feel that is
> > > > > > > a sensible choice given =y. If we are on same page, please ignore my comment.
> > > > > >
> > > > > > I was assuming that the rcu_nocbs=??? for non-empty "???" would override
> > > > > > the CONFIG_RCU_NOCB_CPU_ALL=y.  If you choose not to do that, shouldn't
> > > > > > you at least issue some sort of diagnostic?  After all, the sysadmin
> > > > > > gave a kernel-boot parameter asking the code to do something and the
> > > > > > code is choosing not to do that something.
> > > > > >
> > > > > > Of course, such a sysadmin might want the CONFIG_RCU_NOCB_CPU_ALL=y
> > > > > > Kconfig option to affect only the default, that is, when no rcu_nocbs
> > > > > > kernel boot parameter is specified.  This would change the second "[4]"
> > > > > > in my original table to "[2]".
> > > > > >
> > > > > > Thoughts?
> > > > >
> > > > > I thought about that. I feel that since we are defaulting the new
> > > > > config option to =n , it is a conscious choice by the distro to set it
> > > > > to =y.  In such a case, they should be Ok with offloading all CPUs. If
> > > > > they decide to selectively offload some CPUs in the future, then they
> > > > > could revisit the config option at that time.
> > > > >
> > > > > I feel the kernel config should override the boot parameter behavior.
> > > > > It is the same effect as a sysadmin passing kernel parameter X
> > > > > assuming the kernel does something but the CONFIG option might not
> > > > > even build code corresponding to X.
> > > > >
> > > > > I feel to address your concern, we can document in kernel command line
> > > > > documentation that rcu_nocbs= does not have an effect if
> > > > > CONFIG_RCU_NOCB_CPU_ALL=y, would that work for you?
> > > >
> > > > Not me so much, because I would just set CONFIG_RCU_NOCB_CPU_ALL=n so
> > > > as to not worry about it.
> > > >
> > > > But I am not at all looking forward to complaints about rcu_nocbs not
> > > > working the way people expect.  So let's take some time to think more
> > > > carefully about this.
> > >
> > > That's a fair concern. But we are defaulting it to 'n' so I think if it is
> > > unconsciously enabled without someone reading documentation, then that's a
> > > slightly different issue.
> >
> > Suppose that one group decides to change to CONFIG_RCU_NOCB_CPU_ALL=y,
> > and some other group on some other continent happens to be using the
> > rcu_nocbs boot parameter (having read the documentation).  And suppose
> > that the level of communication between the two groups is typical,
> > that is to say, nonexistent.
> >
> > Sure, we can argue that groups should communicate, but our making that
> > argument won't necessarily prevent the group using rcu_nocbs from taking
> > us to task in the course of their debugging effort.
> >
> > > On the other hand, I can also make it such that if rcu_nocbs= is passed, then
> > > the CONFIG does not take effect. That's quite a bit weird/quirky IMHO.
> >
> > Not at all.  We can simply say that CONFIG_RCU_NOCB_CPU_ALL controls
> > only the default situation, that is, when rcu_nocbs is not specified.
> 
> Then it should be called: CONFIG_RCU_NOCB_CPU_DEFAULT_ALL , or
> something. Otherwise I can tell you that I will be the first one to be
> confused by menuconfig unless I also read the code :-D

I am OK with CONFIG_RCU_NOCB_CPU_DEFAULT_ALL.

							Thanx, Paul
