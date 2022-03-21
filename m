Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113824E2E85
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351421AbiCUQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347786AbiCUQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:52:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55720171EC9;
        Mon, 21 Mar 2022 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GpBLN45XHdgrYM0mJnm8SxpRBseWTjkv46KwP4WkL8w=; b=FibBNvtHtcELnmPR5kl0+HSRDL
        QVY6FftHfgU2nVmUOl5r51wh1rRPtldp+pwhaAluwv+hOk2obN7pWZjVGXTC+11RP2Wr/6X3n2Kog
        IQ4PzWU+Pmq7uPMmhIzecCioopS/QAy6WF4b1wTrHkY2rvTmN8cA6+eSaoGuHAv9m0MO7AcZrDcb/
        DaiIjnPzhwk/SL7Cug1ymDJM3AwmHYvp+qSm5mTmCfK2vb9mGXYDy4NwPMnVCWRS2yXnYNX+kF+au
        EajY2HEWiFAcV+c7e2JSoZWZUlOyzPSXrabJM2hRYGvLaOoCMNTLIoR/YJr3ssoi9P0zh4Ykba4Mf
        mbYbo4tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWLF5-00AlK4-4g; Mon, 21 Mar 2022 16:50:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9632D30031D;
        Mon, 21 Mar 2022 17:50:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EC432DB94824; Mon, 21 Mar 2022 17:50:50 +0100 (CET)
Date:   Mon, 21 Mar 2022 17:50:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhiramat@kernel.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <Yjis6hJKUj/WrSwK@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
 <20220321112805.1393f9b9@gandalf.local.home>
 <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
 <20220321121209.3b95e406@gandalf.local.home>
 <20220321121549.1c8588c5@gandalf.local.home>
 <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
 <20220321124551.3d73660b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321124551.3d73660b@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 12:45:51PM -0400, Steven Rostedt wrote:
> On Mon, 21 Mar 2022 17:40:32 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > func_B:
> > 	call __fentry__	/* push func_B */
> > 	...
> > 	call __fexit__	/* pop 1 + tails */
> > 	ret
> > 
> > func_A:
> > 	call __fentry__ /* push func_A */
> > 	...
> > 	call __ftail__  /* mark func_A tail */
> > 	jmp func_B
> > 
> > func_C:
> > 	call __fentry__ /* push func_C */
> > 	call func_A;
> > 	...
> > 	call __fexit__  /* pop 1 + tails */
> > 	ret;
> 
> This also assumes that we need to trace everything that is marked. I
> mentioned in another email, what do we do if we only trace funcA?

Like I said later on; if we inhibit tail-calls to notrace, this goes
away.
