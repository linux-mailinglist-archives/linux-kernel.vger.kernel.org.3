Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC7F573552
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbiGMLZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiGMLZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:25:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F91014AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:25:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 457D520021;
        Wed, 13 Jul 2022 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657711542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2hCUwWlyM97iRIwu5t9bviH/71g+A0D69fnhpOcSMiY=;
        b=BDyRyl3OUksILIGlSSVz+Rb34SY1wq1zsplYzhIIXijI5jBY+N3G1ZCRQ3Ah/Strt8gqCD
        7oSaaopLIkiXnbpon5aQ7OdhK9bkxnfIcBeNN/z30+YUdn/tncux7+xjx+i6yingPHFLGf
        Vwk72Csx3gXowEOm77YhMTC3J9A87q0=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AA0532C145;
        Wed, 13 Jul 2022 11:25:41 +0000 (UTC)
Date:   Wed, 13 Jul 2022 13:25:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20220713112541.GB2737@pathway.suse.cz>
References: <20220503073844.4148944-1-elver@google.com>
 <20220711182918.338f000f@gandalf.local.home>
 <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220711205319.1aa0d875@gandalf.local.home>
 <20220712025701.GS1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712114954.GA3870114@paulmck-ThinkPad-P17-Gen-1>
 <20220712093940.45012e47@gandalf.local.home>
 <20220712134916.GT1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712105353.08358450@gandalf.local.home>
 <20220712151655.GU1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712151655.GU1790663@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-07-12 08:16:55, Paul E. McKenney wrote:
> On Tue, Jul 12, 2022 at 10:53:53AM -0400, Steven Rostedt wrote:
> > On Tue, 12 Jul 2022 06:49:16 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > > I guess the question is, can we have printk() in such a place? Because this
> > > > tracepoint is attached to printk and where ever printk is done so is this
> > > > tracepoint.  
> > > 
> > > As I understand it, code in such a place should be labeled noinstr.
> > > Then the call to printk() would be complained about as an illegal
> > > noinstr-to-non-noinstr call.
> > > 
> > > But where exactly is that printk()?
> > 
> > Perhaps the fix is to remove the _rcuidle() from trace_console_rcuidle().
> > If printk() can never be called from noinstr (aka RCU not watching).
> 
> Maybe printk() is supposed to be invoked from noinstr.  It might be a
> special case in the tooling.  I have no idea.  ;-)

I think that it is ok to do _not_ support printk() in noinstr parts.

> However, the current SRCU read-side algorithm will tolerate being invoked
> from noinstr as long as it is not also an NMI handler.  Much though
> debugging tools might (or might not) complain.
> 
> Don't get me wrong, I can make SRCU tolerate being called while RCU is
> not watching.  It is not even all that complicated.  The cost is that
> architectures that have NMIs but do not have NMI-safe this_cpu*()
> operations have an SRCU reader switch from explicit smp_mb() and
> interrupt disabling to a cmpxchg() loop relying on the implicit barriers
> in cmpxchg().
> 
> For arm64, this was reportedly a win.

IMHO, the tracepoint in printk() is not worth slowing down other
important fast paths.

The tracepoint was moved into vprintk_store() in 5.19-rc1. It used
to be in console_unlock() before. The previous location was not
reliable by definition. Old messages might be overridden by new
ones before they reach console. Also messages in NMI context
used to be stored in per-CPU buffers. There was even bigger
risk that they would not reach the console.

Best Regards,
Petr
