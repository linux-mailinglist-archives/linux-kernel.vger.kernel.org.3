Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50244515C86
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbiD3Lrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 07:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbiD3Lr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 07:47:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B060AB6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QjtbkDPft5gG0EhMGwH7CoQcPBdnWeFvylZ+csB/A4c=; b=uSvYhDeRVB7jF9rWVyMoU7WAU6
        YRs6y0y7cI6FAs3I+fSEtRXdv4T39eDO8aIC+DaI6wRzSV1On3tmw9+tecL0CHhw/Ilj0KAKJ67yt
        F13UIkSQN3/IKJhtHSHi8poKsCPG3cZCQo2L01JFj6IvJiov4UZxFqQzUTD1u0sNsIgJ4a+GR5GaH
        F5KDuL+yLkZ2hgBXj78haFu22a0cHh4IujeHw4N0GY7RqRibJqwmjvRwgutX2vaoX/3RfxD4SWl/l
        Qigl5IESeecLJXY8j6srhmtW7VScmfHlzfRX6l38wYsUgtr4EaLE+TVvXpTTq+N6Re/9VDi6zyuQu
        2dEWOJzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nklW6-00DIlm-Q6; Sat, 30 Apr 2022 11:44:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA20A3001EA;
        Sat, 30 Apr 2022 13:44:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF7F32028EFE6; Sat, 30 Apr 2022 13:44:00 +0200 (CEST)
Date:   Sat, 30 Apr 2022 13:44:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Message-ID: <Ym0hAA66vijBo7iF@hirez.programming.kicks-ass.net>
References: <20220429092024.GT2731@worktop.programming.kicks-ass.net>
 <YmvTbN966XmLSZk+@hirez.programming.kicks-ass.net>
 <20220429225636.6qm2orq4uwnl33ii@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429225636.6qm2orq4uwnl33ii@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:56:36PM -0700, Josh Poimboeuf wrote:
> On Fri, Apr 29, 2022 at 02:00:44PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 29, 2022 at 11:20:24AM +0200, Peter Zijlstra wrote:
> > > 
> > > STACK_FRAME_NON_STANDARD results in inconsistent relocation types
> > > depending on .c or .S usage:
> > > 
> > >   Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x3c01090 contains 5 entries:
> > >   Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
> > >   0000000000000000  00020c2200000002 R_X86_64_PC32          0000000000047b40 do_suspend_lowlevel + 0
> > >   0000000000000008  0002461e00000001 R_X86_64_64            00000000000480a0 machine_real_restart + 0
> > >   0000000000000010  0000001400000001 R_X86_64_64            0000000000000000 .rodata + b3d4
> > >   0000000000000018  0002444600000002 R_X86_64_PC32          00000000000678a0 __efi64_thunk + 0
> > >   0000000000000020  0002659d00000001 R_X86_64_64            0000000000113160 __crash_kexec + 0
> > 
> > So that weird .rodata entry is optprobe_template_func.
> > 
> > It being in .rodata also means it's not validated and there is no ORC
> > data generated, is that all intentional? The changelog for:
> > 
> >   877b145f0f47 ("x86/kprobes: Move trampoline code into RODATA")
> > 
> > doesn't really say anything useful about any of that :/
> > 
> > I also don't see any kprobe/optprobe hooks in unwind.h, so what happens
> > if we hit an optprobe?
> 
> Same as for any other generated code, the unwinder will try to fall back
> to frame pointers, and if that doesn't work, the unwind stops.
> 
> That commit didn't change anything since it was already not being
> directly executed anyway, but rather used to generate code on the fly.
> 
> And before that commit it was being ignored by ORC anyway, thanks to
> STACK_FRAME_NON_STANDARD.  Which can now be removed since this code is
> now data and objtool will no longer try to understand it.

Right; but I suppose I'm wondering if we should fix this. It seems a
rather sub-optimal state of affairs.
