Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A5C4B274B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350647AbiBKNiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:38:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiBKNiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:38:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED16E95
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YTO3lQZ9ulZigrat8ImU1xcidv81PGdKqOhNxbitprE=; b=bpRFNqDXrNG2aPA4RrOeuWdkGX
        WSqTYKmF8o5NsrP+zcWvfXFJVk8jFoZB3AARPxYSoXjFtf15ClaxgtmNfd8xmXidzygUJkj04I09J
        lS9g+MH4Vs5YJApbSKndfwvfioa2L1uSMPWbiwCYMePXh+GniLybkXsm6AUtJOcHihGphmc+6b2ud
        1t2fkPZWIObJ4veQHzWCOEWOe1LND/dnNygllvYcb6taaL0p/4S9znPaKosdnmDKTlVYJ+7wyCv7D
        zVADCI9Z2jRJGVuYn6jwTDIb2chXjb/n6xLy9wfcWchIU7KxEJlgVOx6Reri3FeYmJUgqr7Hxo6rT
        2S0rugRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIW7g-00ARTA-Tw; Fri, 11 Feb 2022 13:38:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B757D98630A; Fri, 11 Feb 2022 14:38:03 +0100 (CET)
Date:   Fri, 11 Feb 2022 14:38:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <20220211133803.GV23216@worktop.programming.kicks-ass.net>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:18:44PM -0800, Joao Moreira wrote:
> > Ah, excellent, thanks for the pointers. There's also this in the works:
> > https://reviews.llvm.org/D119296 (a new CFI mode, designed to play nice
> > to objtool, IBT, etc.)
> 
> Oh, great! Thanks for pointing it out. I guess I saw something with a
> similar name before ;) https://www.blackhat.com/docs/asia-17/materials/asia-17-Moreira-Drop-The-Rop-Fine-Grained-Control-Flow-Integrity-For-The-Linux-Kernel.pdf
> 
> Jokes aside (and perhaps questions more targeted to Sami), from a diagonal
> look it seems that this follows the good old tag approach proposed by
> PaX/grsecurity, right? If this is the case, should I assume it could also
> benefit from features like -mibt-seal? Also are you considering that perhaps
> we can use alternatives to flip different CFI instrumentation as suggested
> by PeterZ in another thread?

So, lets try and recap things from IRC yesterday. There's a whole bunch
of things intertwining making indirect branches 'interesting'. Most of
which I've not seen mentioned in Sami's KCFI proposal which makes it
rather pointless.

I think we'll end up with something related to KCFI, but with distinct
differences:

 - 32bit immediates for smaller code
 - __kcfi_check_fail() is out for smaller code
 - it must interact with IBT/BTI and retpolines
 - we must be very careful with speculation.

Right, so because !IBT-CFI needs the check at the call site, like:

caller:
	cmpl	$0xdeadbeef, -0x4(%rax)		# 7 bytes
	je	1f				# 2 bytes
	ud2					# 2 bytes
1:	call	__x86_indirect_thunk_rax	# 5 bytes


	.align 16
	.byte 0xef, 0xbe, 0xad, 0xde		# 4 bytes
func:
	...
	ret


While FineIBT has them at the landing site:

caller:
	movl	$0xdeadbeef, %r11d		# 6 bytes
	call	__x86_indirect_thunk_rax	# 5 bytes


	.align 16
func:
	endbr					# 4 bytes
	cmpl	$0xdeadbeef, %r11d		# 7 bytes
	je	1f				# 2 bytes
	ud2					# 2 bytes
1:	...
	ret


It seems to me that always doing the check at the call-site is simpler,
since it avoids code-bloat and patching work. That is, if we allow both
we'll effectivly blow up the code by 11 + 13 bytes (11 at the call site,
13 at function entry) as opposed to 11+4 or 6+13.

Which then yields:

caller:
	cmpl	$0xdeadbeef, -0x4(%rax)		# 7 bytes
	je	1f				# 2 bytes
	ud2					# 2 bytes
1:	call	__x86_indirect_thunk_rax	# 5 bytes


	.align 16
	.byte 0xef, 0xbe, 0xad, 0xde		# 4 bytes
func:
	endbr					# 4 bytes
	...
	ret

For a combined 11+8 bytes overhead :/

Now, this setup provides:

 - minimal size (please yell if there's a smaller option I missed;
   s/ud2/int3/ ?)
 - since the retpoline handles speculation from stuff before it, the
   load-miss induced speculation is covered.
 - the 'je' branch is binary, leading to either the retpoline or the
   ud2, both which are a speculation stop.
 - the ud2 is placed such that if the exception is non-fatal, code
   execution can recover
 - when IBT is present we can rewrite the thunk call to:

	lfence
	call *(%rax)

   and rely on the WAIT-FOR-ENDBR speculation stop (also 5 bytes).
 - can disable CFI by replacing the cmpl with:

	jmp	1f

   (or an 11 byte nop, which is just about possible). And since we
   already have all retpoline thunk callsites in a section, we can
   trivially find all CFI bits that are always in front it them.
 - function pointer sanity


Additionally, if we ensure all direct call are +4 and only indirect
calls hit the ENDBR -- as it optimal anyway, saves on decoding ENDBR. We
can replace those ENDBR instructions of functions that should never be
indirectly called with:

	ud1    0x0(%rax),%eax

which is a 4 byte #UD. This gives us the property that even on !IBT
hardware such a call will go *splat*.

Further, Andrew put in the request for __attribute__((cfi_seed(blah)))
to allow distinguishing indirect functions with otherwise identical
signature; eg. cookie = hash32(blah##signature).


Did I miss anything? Got anything wrong?

