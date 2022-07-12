Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3000D571ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiGLPVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiGLPUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:20:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B15BF552
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DC1AB819C7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22461C3411C;
        Tue, 12 Jul 2022 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657639016;
        bh=41M/1xyigBamd/Ge+Sya+a9o0MeM5kiHExwugSqfco4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WTFrV4ErUN0GWHNGG3vCSb5tJi6uBQEc4Xfd8vqc0cZf0M/YqDYwy/Hse3ApDdWbu
         Su8z9Z3YE19WikYbdF7U8O0bBMcHdHJMPaouLrfH+BjsMpvohqpLWywmZ3twN226NO
         mARl72IU7VXMeyi7DQIM2sc0ISs8ggZa4jbrQmuc2OfbkVAE/vAFTD5rq7LbOZpQta
         FvDWSMsfC7zlH1QE5cHEoGSjNaMSge9y8Cvcu4LvmaM54MAtffH5PepljRCy++YCDT
         7SzuQHP/RtRZ/+oOLO5/AcfW0MaO0WXV8qXt/n6nOWdli6XQ2GSjxBDE+2WumGhNkL
         kywaOaKVsioOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A917D5C0516; Tue, 12 Jul 2022 08:16:55 -0700 (PDT)
Date:   Tue, 12 Jul 2022 08:16:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220712151655.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220503073844.4148944-1-elver@google.com>
 <20220711182918.338f000f@gandalf.local.home>
 <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220711205319.1aa0d875@gandalf.local.home>
 <20220712025701.GS1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712114954.GA3870114@paulmck-ThinkPad-P17-Gen-1>
 <20220712093940.45012e47@gandalf.local.home>
 <20220712134916.GT1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712105353.08358450@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712105353.08358450@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 10:53:53AM -0400, Steven Rostedt wrote:
> On Tue, 12 Jul 2022 06:49:16 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > I guess the question is, can we have printk() in such a place? Because this
> > > tracepoint is attached to printk and where ever printk is done so is this
> > > tracepoint.  
> > 
> > As I understand it, code in such a place should be labeled noinstr.
> > Then the call to printk() would be complained about as an illegal
> > noinstr-to-non-noinstr call.
> > 
> > But where exactly is that printk()?
> 
> Perhaps the fix is to remove the _rcuidle() from trace_console_rcuidle().
> If printk() can never be called from noinstr (aka RCU not watching).

Maybe printk() is supposed to be invoked from noinstr.  It might be a
special case in the tooling.  I have no idea.  ;-)

However, the current SRCU read-side algorithm will tolerate being invoked
from noinstr as long as it is not also an NMI handler.  Much though
debugging tools might (or might not) complain.

Don't get me wrong, I can make SRCU tolerate being called while RCU is
not watching.  It is not even all that complicated.  The cost is that
architectures that have NMIs but do not have NMI-safe this_cpu*()
operations have an SRCU reader switch from explicit smp_mb() and
interrupt disabling to a cmpxchg() loop relying on the implicit barriers
in cmpxchg().

For arm64, this was reportedly a win.

If it turns out that we need SRCU readers to be invoked from NMI handlers
in locations where RCU is not watching, are there people who would be
willing to play with a modified SRCU on the systems in question?

-ENOHARDWARE at this end.

							Thanx, Paul
