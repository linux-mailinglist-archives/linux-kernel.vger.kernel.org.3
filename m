Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD114B5D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiBNW02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:26:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiBNW0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:26:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A877145AC6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f/paFFi8ufHomtVkkIHsbIUzgUGS321z86EhHSKUzpg=; b=cSLyqezxlVj6YcVj8ksrGIfyRy
        zp+gEpDoF2+qY7IQYgoCKOeDftiDWPa4W4BYKCRZvDVqkTq1aorArhMEg5qFtB5cEfoH9pEQi48HC
        Ji5izZf2YdQ2a410McGgfqD8PxVE4GOVlH4En6N3PGDVxT54SWC+s+kez6rpO4QOxbK0OmJrRPBZp
        Hk2MyWkNXqoLNagbOCTZUH3wDIU/mFUKHeKHa4geZVxyagyEgaMeJr86Ai9EAKYdsrLBWArEv8ORL
        Xg+lU8o3Mk1g77XKka8HnrjQj6mQCf3iVyIlHIu2aABz6CWBysY0dQSPzqMzYiUaafj58Zriu9SoY
        RqreVo0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJjn6-00DJNQ-KX; Mon, 14 Feb 2022 22:25:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D00D998194C; Mon, 14 Feb 2022 23:25:50 +0100 (CET)
Date:   Mon, 14 Feb 2022 23:25:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Joao Moreira <joao@overdrivepizza.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        hjl.tools@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <20220214222550.GB23216@worktop.programming.kicks-ass.net>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <CABCJKuciRBnz4JxBDJC=+kuJn4pU2uBkWPBov7-VL2o2j0F4SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuciRBnz4JxBDJC=+kuJn4pU2uBkWPBov7-VL2o2j0F4SA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 01:38:18PM -0800, Sami Tolvanen wrote:
> On Fri, Feb 11, 2022 at 5:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > I think we'll end up with something related to KCFI, but with distinct
> > differences:
> >
> >  - 32bit immediates for smaller code
> 
> Sure, I don't see issues with that. Based on a quick test with
> defconfig, this reduces vmlinux size by 0.30%.
> 
> >  - __kcfi_check_fail() is out for smaller code
> 
> I'm fine with adding a trap mode that's used by default, but having
> more helpful diagnostics when something fails is useful even in
> production systems in my experience. This change results in a vmlinux
> that's another 0.92% smaller.

You can easily have the exception generate a nice warning, you can even
have it continue. You really don't need a call for that.

> > Which then yields:
> >
> > caller:
> >         cmpl    $0xdeadbeef, -0x4(%rax)         # 7 bytes
> >         je      1f                              # 2 bytes
> >         ud2                                     # 2 bytes
> > 1:      call    __x86_indirect_thunk_rax        # 5 bytes
> 
> Note that the compiler might not emit this *exact* sequence of
> instructions. For example, Clang generates this for events_sysfs_show
> with the modified KCFI patch:
> 
> 2274:       cmpl   $0x4d7bed9e,-0x4(%r11)
> 227c:       jne    22c0 <events_sysfs_show+0x6c>
> 227e:       call   2283 <events_sysfs_show+0x2f>
>                     227f: R_X86_64_PLT32    __x86_indirect_thunk_r11-0x4
> ...
> 22c0:       ud2
> 
> In this case the function has two indirect calls and Clang seems to
> prefer to emit just one ud2.

That will not allow you to recover from the exception. UD2 is not an
unconditional fail. It should have an out-going edge in this case too.

Heck, most of the WARN_ON() things are UD2 instructions.

Also, you really should add a CS prefix to the retpoline thunk call if
you insist on using r11 (or any of the higher regs).

> >         .align 16
> >         .byte 0xef, 0xbe, 0xad, 0xde            # 4 bytes
> > func:
> >         endbr                                   # 4 bytes
> 
> Here func is no longer aligned to 16 bytes, in case that's important.

The idea was to have the hash and the endbr in the same cacheline.

> > Did I miss anything? Got anything wrong?
> 
> How would you like to deal with the 4-byte hashes in objtool? We
> either need to annotate all function symbols in the kernel, or we need
> a way to distinguish the hashes from random instructions, so we can
> also have functions that don't have a type hash.

Easiest would be to create a special section with all the hash offsets
in I suppose. A bit like -mfentry-section=name.
