Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC34E39F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiCVH4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiCVH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:56:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDFB59A40;
        Tue, 22 Mar 2022 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BUf3kZEhqxCYRgicSzuUVNrLLp1FfVYato9rwoVBC/A=; b=O+Zv4B0vlsCDbWFJ84XG3F5o8D
        RT+3EoQ0TsekqJC3795MFOV9qhuOcNyw/s+L+MUEPHWKVdBjzh5beSxy5HP13T2ne05fzJTnHs/0b
        cg/yf8IXB4SVIiGrruz6sNPtvOVSDtNXuOycVdAPDmNXCR5NXR4Kt3mKwojOboE7Bgx7+1cT2oZXF
        udfX7pfRZHsJGg5nQN30gL58gKSoP/XvtLDzApstF11bM3W0shVP6JhLYRUVIAL687pJulOT1S9m/
        WF7vA/WpJcjg+UodjUaEQLoqGSKkTUj3yEuzSKq18XBO82ftaIp0hYJFUY2/WpZ7EyEkV6R7yC7HL
        vZXmYnkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWZM0-00BOBw-5g; Tue, 22 Mar 2022 07:54:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C61F3001CD;
        Tue, 22 Mar 2022 08:54:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 746922015B283; Tue, 22 Mar 2022 08:54:55 +0100 (CET)
Date:   Tue, 22 Mar 2022 08:54:55 +0100
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
Message-ID: <YjmAz0MbdW4Q1Cnv@hirez.programming.kicks-ass.net>
References: <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
 <20220321112805.1393f9b9@gandalf.local.home>
 <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
 <20220321121209.3b95e406@gandalf.local.home>
 <20220321121549.1c8588c5@gandalf.local.home>
 <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
 <20220321124551.3d73660b@gandalf.local.home>
 <Yjis6hJKUj/WrSwK@hirez.programming.kicks-ass.net>
 <20220321125419.0a20415c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321125419.0a20415c@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 12:54:19PM -0400, Steven Rostedt wrote:
> On Mon, 21 Mar 2022 17:50:50 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > This also assumes that we need to trace everything that is marked. I
> > > mentioned in another email, what do we do if we only trace funcA?  
> > 
> > Like I said later on; if we inhibit tail-calls to notrace, this goes
> > away.
> 
> Please no. The number of "notrace" functions is increasing to the point
> that it's starting to make function tracing useless in a lot of
> circumstances. I've already lost my ability to see when user space goes
> into the kernel (which I have to hack up custom coding to enable again).

I really can't follow the argument there, nor on IRC.

Suppose:

notrace func_B()
{
	...
}

func_A()
{
	...
	return func_B();
}

then inhibiting tail calls would end up looking like:

func_A:
	call __fentry__
	...
	call func_B
	call __fexit__
	ret

Then A is fully traced, B is invisible, as per spec. What is the
problem?

The problem you initially had, of doing a tail-call into a notrace, was
that the __fexit__ call went missing, because notrace will obviously not
have that. But that's avoided by inhibiting all tail-calls between
notrace and !notrace functions (note that notrace must also not
tail-call !notrace).

Your worry seems to stem about loosing visiblilty of !notrace functions,
but AFAICT that doesn't happen.

