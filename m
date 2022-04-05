Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE324F4FDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839775AbiDFBFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452834AbiDEPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4157CB18
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 598D061741
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB50C385A0;
        Tue,  5 Apr 2022 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649170648;
        bh=pgAEikqG7Zu0fteM7CcdkQX3ljjFVaexnnlWX6gjnYA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AszIqGU56P25oO/C4b4jSBYGtGn5jS0yTdm1BWO4z5e1pSiXELgYyNOxmElD2gb3s
         wtcSkC8x8vK1NLyn91vAKM5CmV/tNeFfZcUbZQSuKRPL7AHataWxC81cfSuSbCwHzm
         X1O4IKmwBZ1JtOlsnFY42yyY6xYkmAgC+Zw5C7dle3C1lqop1VgIq3J1PaFA89NKTN
         ZSLM7gN7i8A1mata5Qqf9TbS53+fac6APmsDf6wwzfOOzDTUlTMTSeeqpPmmfVn93e
         C9YfjvnXwzPNMfiXf3KejZrm17+LFXU1/IDuqdxp0H01uRprd/iMr5OWXuMdISgxQq
         0GVtUCKDTPkwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 616685C0245; Tue,  5 Apr 2022 07:57:28 -0700 (PDT)
Date:   Tue, 5 Apr 2022 07:57:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: Typical PREEMPT_RT .config?
Message-ID: <20220405145728.GG4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220404231654.GA3445712@paulmck-ThinkPad-P17-Gen-1>
 <20220405094048.30a75670@gandalf.local.home>
 <20220405094202.0823ce48@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405094202.0823ce48@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:42:02AM -0400, Steven Rostedt wrote:
> On Tue, 5 Apr 2022 09:40:48 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 4 Apr 2022 16:16:54 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > OK, now that PREEMPT_RT is mostly into mainline, I should probably create
> > > an rcutorture scenario more closely reflecting it.  The closest at the
> > > moment is probably tools/testing/selftests/rcutorture/configs/rcu/TREE03,
> > > but I figured that before beating on it I should check to see if you
> > > already have a PREEMPT_RT rcutorture scenario file.  
> > 
> > I don't have one.
> 
> And now reading the subject line and not just the body, are you asking
> about what configs are normally added? I had several I used for testing,
> but will have to go back and look at them.

That would be great!  I can easily add CONFIG_PREEMPT_RT=y.  Maybe I also
should add CONFIG_RT_DELAYED_SIGNALS, though rcutorture probably doesn't
care about this one.  Maybe threaded interrupts happen automatically?
Sleeping spinlocks?

If no advice is forthcoming, I will make something up based on my best
guesses, but I guarantee you that this will result in me missing important
bugs in my testing.  ;-)

So it would be great to have a list of the Kconfig options normally
selected when building CONFIG_PREEMPT_RT=y kernels.

							Thanx, Paul
