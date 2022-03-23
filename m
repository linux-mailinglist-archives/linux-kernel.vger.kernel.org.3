Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123FB4E4B00
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbiCWCoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241355AbiCWCoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:44:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF922674E0;
        Tue, 22 Mar 2022 19:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76E88B81DE2;
        Wed, 23 Mar 2022 02:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81818C340ED;
        Wed, 23 Mar 2022 02:42:38 +0000 (UTC)
Date:   Tue, 22 Mar 2022 22:42:36 -0400
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
Message-ID: <20220322224236.46f8c2f1@gandalf.local.home>
In-Reply-To: <20220323112323.65337d76d96836e487064a99@kernel.org>
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

On Wed, 23 Mar 2022 11:23:23 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> I see the __fexit__ is needed, but why __ftail__ is needed? I guess because
> func_B is notrace, in that case the __fexit__ will not be in the func_B.
> Am I correct?

I believe Peter and I agreed that the "best" solution so far, that has the
least amount of regressions (doesn't remove anything currently being
function graph traced, nor removes current tail calls) is:

> At that point giving us something like:
> 
> 1:
> 	pushsection __ftail_loc
> 	.long	1b - .
> 	popsection
> 
> 	jmp.d32	func_B
> 	call	__fexit__
> 	ret


Functions with a tail call will not have a __fexit__ and we can not rely on
the function that is the tail call to do the __fexit__ for the parent
function. Thus, the compromise is to add a label where the jmp to the
tail-call function is, and when we want to trace the return of that
function, we first have to patch the jmp into a call, which will then
return back to the call to __fexit__.

-- Steve
