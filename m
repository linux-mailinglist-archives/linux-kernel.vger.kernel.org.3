Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5351ACE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376572AbiEDSfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376885AbiEDSfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:35:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC191A3BD;
        Wed,  4 May 2022 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fYp0BOiD+C24TtJjB9MQVKfavo5e/DtHm95cJy4DbxU=; b=jktudGa0GlSGUnEIdc7B/i3nRo
        aTaP/+FLn4ejbVko9j1F73n/pcrF4T6ASSPXNGzVgzFykrvCNuwponWSaSqcVi3g+hBUAUo38I/X8
        Q/dbf/KBrXuoJxgDMHgmbzeZL9tDa7t/LmNnIXkyCfU73Yw/pvfBinNEsn2Vw6K6489LC7LtC1h8E
        Nq0fSQCkMAgGI2rl2yRZ1t6gdj9OFN1XObV1o65leiDFiYRWwtFCss9Zpx+ZVw1bo5BTJVhFy35zg
        TU03FSjwdoE6QVIEzkT9P4A6R3RuJc/TG+NsWAoLd7DN0RoTthchU7hU8ey1JVsrE9c1e9EtiG6Er
        bFlGUjSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmJYa-00B8Vh-Jx; Wed, 04 May 2022 18:17:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F22D03003AA;
        Wed,  4 May 2022 20:16:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF03A20277373; Wed,  4 May 2022 20:16:57 +0200 (CEST)
Date:   Wed, 4 May 2022 20:16:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
Message-ID: <YnLDGcJGKfqi5+8w@hirez.programming.kicks-ass.net>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
 <20220429013704.4n4lmadpstdioe7a@treble>
 <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com>
 <20220503220244.vyz5flk3gg3y6rbw@treble>
 <YnJTYzralOhGGmED@hirez.programming.kicks-ass.net>
 <YnKx5a9WvJ1UhWPm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnKx5a9WvJ1UhWPm@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 10:04:02AM -0700, Peter Collingbourne wrote:
> On Wed, May 04, 2022 at 12:20:19PM +0200, Peter Zijlstra wrote:
> > On Tue, May 03, 2022 at 03:02:44PM -0700, Josh Poimboeuf wrote:
> > 
> > > I'm not really qualified to comment on this too directly since I haven't
> > > looked very much at the variations on FineIBT/CFI/KCFI, and what the
> > > protections and drawbacks are for each approach, and when it might even
> > > make sense to combine them for a "paranoid user".
> > > 
> > > Since we have multiple similar and possibly competing technologies being
> > > discussed, one thing I do want to warn against is that we as kernel
> > > developers tend to err on the side of giving people too many choices and
> > > combinations which *never* get used.
> > 
> > So I don't think there's going to be a user choice here. If there's
> > hardware support, FineIBT makes more sense. That also means that kCFI no
> > longer needs to worry about IBT.
> > 
> > If we do something like:
> > 
> > 
> >         kCFI                                            FineIBT
> > 
> > __cfi_\sym:                                     __cfi_\sym:
> >         endbr                           # 4             endbr                   # 4
> >         sub $hash, %r10                 # 7             sub $hash, %r10         # 7
> >         je \sym                         # 2             je \sym                 # 2
> >         ud2                             # 2             ud2                     # 2
> > \sym:                                           \sym:
> > 
> > 
> > caller:                                         caller:
> >         cmpl $hash, -8(%r11)            # 8             movl $hash, %r10d       # 6
> >         je 1f                           # 2             sub 15, %r11            # 4
> >         ud2                             # 2             call *%r11              # 3
> > 1:      call __x86_indirect_thunk_r11   # 5             .nop 4                  # 4 (could even fix up r11 again)
> > 
> > 
> > Then, all that's required is a slight tweak to apply_retpolines() to
> > rewrite a little more text.
> > 
> > Note that this also does away with having to fix up the linker, since
> > all direct call will already point at \sym. It's just the IBT indirect
> > calls that need to frob the pointer in order to hit the ENDBR.
> > 
> > On top of that, we no longer have to special case the objtool
> > instruction decoder, the prelude are proper instructions now.
> 
> For kCFI this brings back the gadget problem that I mentioned here:
> https://lore.kernel.org/all/Yh7fLRYl8KgMcOe5@google.com/
> 
> because the hash at the call site is 8 bytes before the call
> instruction.

Damn, I forgot about that. Too subtle :-/

So Joao had another crazy idea, lemme diagram that to see if it works.

(sorry I inverted the order by accident)


	FineIBT						kCFI

__fineibt_\hash:
	xor	\hash, %r10	# 7
	jz	1f		# 2
	ud2			# 2
1:	ret			# 1
	int3			# 1


__cfi_\sym:					__cfi_\sym:
							int3; int3				# 2
	endbr			# 4			mov	\hash, %eax			# 5
	call	__fineibt_\hash	# 5			int3; int3				# 2
\sym:						\sym:
	...						...


caller:						caller:
	movl	\hash, %r10d	# 6			cmpl	\hash, -6(%r11)			# 8
	sub	$9, %r11	# 4			je	1f				# 2
	call	*%r11		# 3			ud2					# 2
	.nop 4			# 4 (or fixup r11)	call	__x86_indirect_thunk_r11	# 5


This way we also need to patch the __cfi_\sym contents, but we get a
little extra room to place the constant for kCFI in a suitable location.

It seems to preserve the properties of the last one in that direct calls
will already be correct and we don't need linker fixups, and objtool can
simply parse the preamble as regular instructions without needing
further help.
