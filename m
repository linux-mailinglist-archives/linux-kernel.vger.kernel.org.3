Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C91573852
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiGMOF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiGMOFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:05:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC9D32071
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C574B81FE6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D36C34114;
        Wed, 13 Jul 2022 14:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657721150;
        bh=NGDPlQrq/BQLIrW6IvHbNP3NAGZOaA8ULZXNZlFBgIE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SBr4/onXB/+LWE7e8WOsSaGkyzaSBOC+J8BKMs0ETQyvjxqTcPU1G16Kx5G7OXN4C
         cCHe3aGl9dCNHWaqBWwgANAL6Q8nfXwFm4PDeQoUau8C/JmSbqiLaXHW2+IIYBUb92
         JQIf2lDsWWvpeGCaS0gWLvFTRyQLo8qcGLdIgr0cnM+zusprL2zBwrc6hTWavmP4vx
         IFY97wl28h+fl5y3P8Q+UEe3kLXEy+9Ty4bYdsg1SZfgkYLSg6PKJCu1oCmHl99uVG
         3rMRky3wvjKwsO2hDKep078LoZZbUxepxWKb+qB4Xc7UfShIvKLF/A3nfU/gufzyYn
         4BLNB+rxEdSgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6AFC05C0134; Wed, 13 Jul 2022 07:05:50 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:05:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220713140550.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220711182918.338f000f@gandalf.local.home>
 <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220711205319.1aa0d875@gandalf.local.home>
 <20220712025701.GS1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712114954.GA3870114@paulmck-ThinkPad-P17-Gen-1>
 <20220712093940.45012e47@gandalf.local.home>
 <20220712134916.GT1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712105353.08358450@gandalf.local.home>
 <20220712151655.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220713112541.GB2737@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713112541.GB2737@pathway.suse.cz>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 01:25:41PM +0200, Petr Mladek wrote:
> On Tue 2022-07-12 08:16:55, Paul E. McKenney wrote:
> > On Tue, Jul 12, 2022 at 10:53:53AM -0400, Steven Rostedt wrote:
> > > On Tue, 12 Jul 2022 06:49:16 -0700
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > > I guess the question is, can we have printk() in such a place? Because this
> > > > > tracepoint is attached to printk and where ever printk is done so is this
> > > > > tracepoint.  
> > > > 
> > > > As I understand it, code in such a place should be labeled noinstr.
> > > > Then the call to printk() would be complained about as an illegal
> > > > noinstr-to-non-noinstr call.
> > > > 
> > > > But where exactly is that printk()?
> > > 
> > > Perhaps the fix is to remove the _rcuidle() from trace_console_rcuidle().
> > > If printk() can never be called from noinstr (aka RCU not watching).
> > 
> > Maybe printk() is supposed to be invoked from noinstr.  It might be a
> > special case in the tooling.  I have no idea.  ;-)
> 
> I think that it is ok to do _not_ support printk() in noinstr parts.
> 
> > However, the current SRCU read-side algorithm will tolerate being invoked
> > from noinstr as long as it is not also an NMI handler.  Much though
> > debugging tools might (or might not) complain.
> > 
> > Don't get me wrong, I can make SRCU tolerate being called while RCU is
> > not watching.  It is not even all that complicated.  The cost is that
> > architectures that have NMIs but do not have NMI-safe this_cpu*()
> > operations have an SRCU reader switch from explicit smp_mb() and
> > interrupt disabling to a cmpxchg() loop relying on the implicit barriers
> > in cmpxchg().
> > 
> > For arm64, this was reportedly a win.
> 
> IMHO, the tracepoint in printk() is not worth slowing down other
> important fast paths.
> 
> The tracepoint was moved into vprintk_store() in 5.19-rc1. It used
> to be in console_unlock() before. The previous location was not
> reliable by definition. Old messages might be overridden by new
> ones before they reach console. Also messages in NMI context
> used to be stored in per-CPU buffers. There was even bigger
> risk that they would not reach the console.

Fair enough, works for me!

							Thanx, Paul
