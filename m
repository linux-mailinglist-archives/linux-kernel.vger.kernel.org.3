Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B0470299
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbhLJOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhLJOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:22:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C3FC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 06:18:36 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D23A1EC056A;
        Fri, 10 Dec 2021 15:18:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639145911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tKt7mMycwMOOvxZMpKmIi9xM9KWzFzqLMhkW7gyShXI=;
        b=RrCdJYzGlAPc89UvmYPiN+y96GcY/exkB9EBYdejSS/kZKNR07cJ5/Pg4h+qw0WqTfuag2
        82ny2lZEhGgHtthkQH47wcPbf0ZkRgO0oR978Pu50eJuN7LZWNNvaYK7l++W0xpvbQZuaO
        pA8iW/MmZzKxAoY1NBEbxr+hYWDoQsM=
Date:   Fri, 10 Dec 2021 15:18:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 04/12] x86/mce: Remove noinstr annotation from
 mce_setup()
Message-ID: <YbNhuXeZm7x3bwcp@zn.tnic>
References: <20211208111343.8130-1-bp@alien8.de>
 <20211208111343.8130-5-bp@alien8.de>
 <YbHzuJmDXJ/ryWR6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbHzuJmDXJ/ryWR6@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 01:16:56PM +0100, Peter Zijlstra wrote:
> Yeah, that's what it does; but *why* is that correct?

Correct, shmorect - it is the #MC handler nasty.

> I'm thinking we're well past the exception entry code and are only
> using noinstr as a means to limit the amount of code in the MCE
> handler?

Well, one of the calls to mce_gather_info() happen in #MC context. That
one calls mce_setup() and that thing calls out to

# ./arch/x86/include/asm/paravirt.h:116:        PVOP_VCALL4(cpu.cpuid, eax, ebx, ecx, edx);
        cmpq    $0, pv_ops+176(%rip)    #, pv_ops.cpu.cpuid

and you get this:

vmlinux.o: warning: objtool: pv_ops[22]: xen_cpuid
vmlinux.o: warning: objtool: pv_ops[22]: native_cpuid
vmlinux.o: warning: objtool: mce_setup()+0xa0: call to pv_ops[22]() leaves .noinstr.text section

I think this is too much and too specific text to stick in the code as a
comment.

I can stick it in the commit message if you prefer that but frankly,
seeing those instrumentation_begin/_end() sandwiches are already hints
enough in my head to read "TODO" there...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
