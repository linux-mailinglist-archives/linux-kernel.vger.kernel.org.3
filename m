Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DDD509059
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381750AbiDTTZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353878AbiDTTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C36345AE6;
        Wed, 20 Apr 2022 12:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F7E6158D;
        Wed, 20 Apr 2022 19:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8643C385A1;
        Wed, 20 Apr 2022 19:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650482543;
        bh=uqSeZHlsX9bO4LKDN0r228trAMb2tfEVJkL22HWK+3s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MooMZPkBAOUl/Qu42XHijqjnn8kDmv/yfuzRO7ycT+RQy4wX7sJfiEDPRdksEcRbc
         BNFFRF8+3yCnZsh6vr6OImEdpKaPpQ4spXjHr7VqURYehMMbV88pXHZeHxcAaXL2Rt
         ndC4MVHT2DbQ2x1MOMCUH8OUHOxSVrORIMa9EtaN7MQJtoMP/+2sF/a+NH1bZD14fJ
         tqKY+2DowDGZ2ddkhb9qIRgTKhe7sGGepMpSD7gVhjW3fiUVDb1q7OOewqRwCe+B48
         7Sibs00uswNMJHtO9nX8yPl4G2AaOu/blwYUmjPTKPflLv2QBpyoBc1UU3GrPXSzuE
         WRVW2ug1cdsmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7BEBD5C0562; Wed, 20 Apr 2022 12:22:23 -0700 (PDT)
Date:   Wed, 20 Apr 2022 12:22:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH rcu 1/2] docs: Add documentation for rude and trace RCU
 flavors
Message-ID: <20220420192223.GK4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
 <20220418225033.3944860-1-paulmck@kernel.org>
 <20220420113231.6d3202e4@gandalf.local.home>
 <20220420161319.GD4285@paulmck-ThinkPad-P17-Gen-1>
 <20220420121906.13752d3e@gandalf.local.home>
 <20220420164847.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220420140226.32a10ece@gandalf.local.home>
 <20220420183726.GJ4285@paulmck-ThinkPad-P17-Gen-1>
 <20220420144309.69c6b8d1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420144309.69c6b8d1@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 02:43:09PM -0400, Steven Rostedt wrote:
> On Wed, 20 Apr 2022 11:37:26 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > The original purpose of RCU Tasks Rude was to deal with the idle tasks,
> > given that RCU Tasks dealt only with the non-idle tasks.
> > 
> > Or is there a trick that I missed?
> 
> It use to be that ftrace trampolines could be called from all sorts of
> locations until Peter introduced the "noinstr" annotation that causes
> objtool to fail to build when tracing happens there. If that prevents
> ftrace from happening in that idle case where RCU tasks can not handle it,
> then it may be that we can simply switch ftrace to the RCU tasks and get
> rid of rude. ?

The last time that I asked Peter about this, he sounded less confident
than I would like, but...

Once sufficient confidence is present, RCU Tasks could pay attention to
idle tasks, and declare a quiescent state for that idle task if RCU is
not currently watching its corresponding CPU.

This would get rid of all of the RCU Tasks Rude use cases that I know of.

The ones that I don't know of?  Who knows?  ;-)

							Thanx, Paul
