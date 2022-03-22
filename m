Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8BE4E3F70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiCVNYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiCVNY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055A13B2A3;
        Tue, 22 Mar 2022 06:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B09E61571;
        Tue, 22 Mar 2022 13:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D396FC340EE;
        Tue, 22 Mar 2022 13:22:56 +0000 (UTC)
Date:   Tue, 22 Mar 2022 09:22:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ast@kernel.org, hjl.tools@gmail.com, rick.p.edgecombe@intel.com,
        rppt@kernel.org, linux-toolchains@vger.kernel.org,
        Andrew.Cooper3@citrix.com, ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20220322092255.2c23e414@gandalf.local.home>
In-Reply-To: <20220322214629.2bf40306e3beba23d88d509f@kernel.org>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <YjisdqdofbDIYj2U@hirez.programming.kicks-ass.net>
        <20220322143136.0e78366c3521b54b7b9385b8@kernel.org>
        <Yjm+TmKyO+HDOBgN@hirez.programming.kicks-ass.net>
        <20220322214629.2bf40306e3beba23d88d509f@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 21:46:29 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > Indeed. I would like to replace the trampoline code of kretprobe with
> > > rethook, eventually. There is no reason why we keep the clone.
> > > (But I need more arch maintainers help for that, there are too many
> > >  archs implemented kretprobes)  
> > 
> > CONFIG_KPROBE_ON_RETHOOK - and then implement archs one by one?  
> 
> Sounds good! Maybe we will see different data structure fields
> which depends on that config, but those are internal fields, so
> user will not access it.

Which is basically what I do for ftrace. Which is why we have all these:

        select HAVE_DYNAMIC_FTRACE
        select HAVE_DYNAMIC_FTRACE_WITH_REGS
        select HAVE_DYNAMIC_FTRACE_WITH_ARGS
        select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
        select HAVE_SAMPLE_FTRACE_DIRECT
        select HAVE_SAMPLE_FTRACE_DIRECT_MULTI

in the architecture Kconfigs.

-- Steve

