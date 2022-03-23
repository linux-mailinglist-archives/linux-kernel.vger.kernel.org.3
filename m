Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB94E4CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiCWGaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCWGaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6C052B1B;
        Tue, 22 Mar 2022 23:28:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E82961618;
        Wed, 23 Mar 2022 06:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6D0C340E8;
        Wed, 23 Mar 2022 06:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648016926;
        bh=jcw//5QnXtIGt33tyaZpopiiPu5NKipd6vYgSxZStfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IoH2mGGDQsQV7jlg6cG+jF9Tqec2Qouozz6CisTnOobsPoAw+6dsrUe5etr+aSZAl
         jdVv6LtAr43rBdYfAcznAG6GY3dbVkUE4u8s4gTAvfOeL20mxqK/IGApOMs7JxT0q5
         RjY9uz0T9OYTUhvydYHPX4cw9GSJk0Qn8xm9r1Lgs5f8XiiCVUY+IhPeOP8TOfvWXG
         +TmhOJLFhIsDDawr7+2XnpKkVuLs2KjMQnQEIulvBz8cKkp46F1HQlcsyLI26d8ali
         48TKHi+pkc1JH71Tt5UmZ2l9xmgP5LgpKulx/dYp60J+4XPbS3uf4N1+f5FXNSI43a
         gaO0wHThbLKfQ==
Date:   Wed, 23 Mar 2022 15:28:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20220323152840.cb6295ec547f50d3ec34f02a@kernel.org>
In-Reply-To: <20220322224236.46f8c2f1@gandalf.local.home>
References: <20220321112805.1393f9b9@gandalf.local.home>
        <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
        <20220321121209.3b95e406@gandalf.local.home>
        <20220321121549.1c8588c5@gandalf.local.home>
        <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
        <20220321124551.3d73660b@gandalf.local.home>
        <Yjis6hJKUj/WrSwK@hirez.programming.kicks-ass.net>
        <20220321125419.0a20415c@gandalf.local.home>
        <YjmAz0MbdW4Q1Cnv@hirez.programming.kicks-ass.net>
        <20220322091242.1ad0206b@gandalf.local.home>
        <Yjneyn8o06svJkY4@hirez.programming.kicks-ass.net>
        <20220323112323.65337d76d96836e487064a99@kernel.org>
        <20220322224236.46f8c2f1@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 22:42:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 23 Mar 2022 11:23:23 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > I see the __fexit__ is needed, but why __ftail__ is needed? I guess because
> > func_B is notrace, in that case the __fexit__ will not be in the func_B.
> > Am I correct?
> 
> I believe Peter and I agreed that the "best" solution so far, that has the
> least amount of regressions (doesn't remove anything currently being
> function graph traced, nor removes current tail calls) is:
> 
> > At that point giving us something like:
> > 
> > 1:
> > 	pushsection __ftail_loc
> > 	.long	1b - .
> > 	popsection
> > 
> > 	jmp.d32	func_B
> > 	call	__fexit__
> > 	ret
> 
> 
> Functions with a tail call will not have a __fexit__ and we can not rely on
> the function that is the tail call to do the __fexit__ for the parent
> function. Thus, the compromise is to add a label where the jmp to the
> tail-call function is, and when we want to trace the return of that
> function, we first have to patch the jmp into a call, which will then
> return back to the call to __fexit__.

Got it. So the tail call "jump" will be replaced with a normal call when
we trace it.

That's a good idea :) 


> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
