Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDF4876DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347271AbiAGLxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbiAGLxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:53:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443CBC061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 03:53:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCFD360AB6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD17C36AE5;
        Fri,  7 Jan 2022 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641556385;
        bh=kGoHdE1Wj8WtjSJazDojfeiiHBy4qOQlGDZqw0KXhC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZWdH02fXJmMCI8eDJtQ5AcxwUaCqMbgd4BPFS8vcD6k9WUGc9KfHgeR5rR0YxRJ93
         GhzNO0+kTuIT2qHd35eyDdvaOvfdLda7D4My1sx9X58djvHQ2yg0Q+JrpFGCgwPQfX
         cBBInBjMSjUwoOs7v822ucOFh2qSfE5fPys+PQ1SZOmxhiyRbXTe8yMaIOt+Y2t0SE
         8b53QAAXrVM4NnXzkckdH2QVtOTAjwgo9dtq6OK97fbdrubsj8FOOL37pCKojItHOs
         CW58of9OUtq887I7+myWwAcDvATJemDhxajt1rbd3nSLHwq2uw8rnIRpIYP4pNenoU
         uNZ2SI9T1vX0w==
Date:   Fri, 7 Jan 2022 20:52:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Samuel Zeter <samuelzeter@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/2] *** Fix reformat_objdump.awk ***
Message-Id: <20220107205259.e66ff1bd90ac218611bf1178@kernel.org>
In-Reply-To: <Ydc8wUjX4hnHg7ZE@archlinux-ax161>
References: <20220106023606.283953-1-samuelzeter@gmail.com>
        <Ydc8wUjX4hnHg7ZE@archlinux-ax161>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel and Nathan,

Thanks for working on this issue. I didn't noticed that the llvm has
this difference. Anyway both patches look good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

for this series.

And if you resend it, please add "x86@kernel.org" to Cc.

Thank you!

On Thu, 6 Jan 2022 12:02:25 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Thu, Jan 06, 2022 at 01:36:03PM +1100, Samuel Zeter wrote:
> > These are two small patches which originally dealt with
> > the problem found at:
> > 
> > https://github.com/ClangBuiltLinux/linux/issues/1364
> > 
> > The original steps to reproduce were:
> > $ make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 defconfig
> > $ scripts/config -e X86_DECODER_SELFTEST
> > $ make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 olddefconfig bzImage
> > 
> > Which resulted in the error:
> > arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but
> > insn_get_length() says 2
> > 
> > Upon inspection it turned out llvm-objdump was formatting its
> > output differently, which caused objdump_reformat.awk to incorrectly
> > output its values.
> > 
> > After fixing that bug, a second one was seen where the instruction
> > "wait" was incorrectly matched with "fwait", which again caused
> > insn_decoder_test to fail.
> 
> Thanks a lot for sending these fixes!
> 
> I can confirm with this series and the removal of chkobjdump.awk [1] on
> top of v5.16-rc8, the insn_decoder_test now passes with LLVM 11 through
> 14.
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> For the future, I recommend putting the maintainers in the "To" field,
> rather than "Cc", to ensure they actually see it. Additionally, I see
> some small nits in the commit message that the tip maintainers might
> comment on, see
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
> 
> for some more info.
> 
> Masami Hiramatsu originally wrote this file and has a few fixes to it
> since, adding him now for review. The original thread is available at:
> 
> https://lore.kernel.org/r/20220106023606.283953-1-samuelzeter@gmail.com/
> 
> [1]: https://git.kernel.org/nathan/c/2f137c324b21f1c21b8830d8896cb9957009f969
> 
> Cheers,
> Nathan


-- 
Masami Hiramatsu <mhiramat@kernel.org>
