Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD6571F08
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiGLPZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiGLPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:25:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4A6559D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:25:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C2C0F20376;
        Tue, 12 Jul 2022 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657639537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qcyer2EH2yI36zcPfaFnFi1V+ng6GsSBGVzj7hzaLxc=;
        b=mymcslXCFrN4gh6OovUMdzpLtxOBGs4AibdjOzh/Pz4CWKWbTZvGSRDswQOBzk4YLGmuCa
        fF8j66U0T+AZrRiDNU9E8Lw+P+/cSKxoUAfBgh3X86QhdfFPzkM8IYSDTbgfW3JCMAVr1I
        nd1HD2AuULDddg3p2hTDx7ovXMvkLRg=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64EAD2C141;
        Tue, 12 Jul 2022 15:25:37 +0000 (UTC)
Date:   Tue, 12 Jul 2022 17:25:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220712152536.GA2737@pathway.suse.cz>
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

On Tue 2022-07-12 10:53:53, Steven Rostedt wrote:
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

Good point!

My understanding is that printk() should not get called when rcu
is not watching. But it might need to reduce the scope of the code
when rcu is not watching.

PeterZ actually removed _rcuidle() in this trace a patchset,
see https://lore.kernel.org/r/20220608144517.444659212@infradead.org.

Adding Peter into Cc.

Best Regards,
Petr
