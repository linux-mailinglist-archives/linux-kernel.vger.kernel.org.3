Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18AF4E4350
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiCVPuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiCVPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:50:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C083766AF9;
        Tue, 22 Mar 2022 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GWmTPAsKiygAsKe/gYrXQNAX5phOsYXBOkLRg3HAuqE=; b=R51TeMWpKxJIfUBzyk+ZVdxyhp
        rJPi2hg+Rmz3n0kkNiO4Q/xcXcffftpXUeoUprxh05yGHiJtqe/VfA6M/sIgygYBGzwlSBKBAX9OG
        zIXPa+VmyYr1YCtLpPRq62/9alhSpCERrpIfFUSrMp4q+pF9eEm7V+qDscZZXg7i9r00yCsVFMsmx
        b4LlLs2WeJDvNu5G2UEZHptQZRDlo4JWBK/fc+z8QjbKz1aU7rfQ21nbv0K3AoSXROh4w3983N2+A
        W7vwCUPgvZCIFNNgz43c7O54jGEK4af9QIn6MfRGqw9azSOQAZY6fo7WK9C2CxriToYQWblD257d5
        PxABj9Gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgjs-00Bj5T-PQ; Tue, 22 Mar 2022 15:48:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 451553001CD;
        Tue, 22 Mar 2022 16:48:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B77A52D6E78DD; Tue, 22 Mar 2022 16:48:02 +0100 (CET)
Date:   Tue, 22 Mar 2022 16:48:02 +0100
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
Message-ID: <Yjnvsrp8253bxWPA@hirez.programming.kicks-ass.net>
References: <20220321121209.3b95e406@gandalf.local.home>
 <20220321121549.1c8588c5@gandalf.local.home>
 <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
 <20220321124551.3d73660b@gandalf.local.home>
 <Yjis6hJKUj/WrSwK@hirez.programming.kicks-ass.net>
 <20220321125419.0a20415c@gandalf.local.home>
 <YjmAz0MbdW4Q1Cnv@hirez.programming.kicks-ass.net>
 <20220322091242.1ad0206b@gandalf.local.home>
 <Yjneyn8o06svJkY4@hirez.programming.kicks-ass.net>
 <20220322110438.25c2a760@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322110438.25c2a760@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:04:38AM -0400, Steven Rostedt wrote:

> > In recap:
> > 
> > 	__fentry__ -- push on trace-stack
> > 	__ftail__  -- mark top-most entry complete
> > 	__fexit__  -- mark top-most entry complete;
> > 	              pop all completed entries
> 
> Again, this would require that the tail-calls are also being traced.

Which is why we should inhibit tail-calls if the function is notrace.

> > inhibit tail-calls to notrace.
> 
> Just inhibiting tail-calls to notrace would work without any of the above.

I'm lost again; what? Without any of the above you got nothing because
return-trampoline will not work.

> But my fear is that will cause a noticeable performance impact.

Most code isn't in fact notrace, and call+ret aren't *that* expensive.

> > It's function graph tracing, kretprobes and whatever else this rethook
> > stuff is about that needs this because return trampolines will stop
> > working somewhere in the not too distant future.
> 
> Another crazy solution is to have:
> 
> func_A:
> 	call __fentry__
> 	...
> tail:	jmp 1f 
> 	call 1f
	
> 	call __fexit__
> 	ret
> 1:	jmp func_B
> 
> 
> where the compiler tells us about "tail:" and that we know that func_A ends
> with a tail call, and if we want to trace the end of func_A we convert that
> jmp 1f into a nop. And then we call the func_B and it's return comes back
> to where we call __fexit__ and then return normally.

At that point giving us something like:

1:
	pushsection __ftail_loc
	.long	1b - .
	popsection

	jmp.d32	func_B
	call	__fexit__
	ret

is smaller and simpler, we can patch the jmp.d32 to call when tracing.
The only problem is SLS, that might wants an int3 after jmp too
( https://www.amd.com/en/corporate/product-security/bulletin/amd-sb-1026 ).

That does avoid the need for __ftail__ I suppose.
