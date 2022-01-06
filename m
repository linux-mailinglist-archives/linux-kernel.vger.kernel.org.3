Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BC6486A3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbiAFTCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiAFTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:02:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBC8C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 11:02:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9261261DC6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 19:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C613FC36AE3;
        Thu,  6 Jan 2022 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641495750;
        bh=IqP7QXUL9LFG3ia0D8c1Aev+d0u20cfMfNFsFYRSzQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOYl83ayf1ArpqJd6tWq+dd4SxlCR8MknGbybO9QqyYWlZsWoL4RH/uQioNbWcsEf
         pQ+FJGyV9s0IxBOoGAjHS29qc5t05qPTb/VbWIUPu1ph+Mhqv7BAeb9ju4PUqOyRV+
         KUysHm9TD0ci2bscMiu+VF5mXdmGAyiai1tGQ2+njzzGs8mt2pScTz6utsX4bsbkcb
         i2DEI5ODuDc3DWUxEBKHeQV+xoYNYd08I/bn+GDIhAWsImM0JewoW0gGcFGYtDAJ9D
         lVb/0DNuB03fr8k9KUUH3zvGOXHMAz1xicVapMhzeJOYudv6e+CkQXO+ZjJisjl7mj
         A10S2F0qHgFRA==
Date:   Thu, 6 Jan 2022 12:02:25 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Samuel Zeter <samuelzeter@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/2] *** Fix reformat_objdump.awk ***
Message-ID: <Ydc8wUjX4hnHg7ZE@archlinux-ax161>
References: <20220106023606.283953-1-samuelzeter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106023606.283953-1-samuelzeter@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 01:36:03PM +1100, Samuel Zeter wrote:
> These are two small patches which originally dealt with
> the problem found at:
> 
> https://github.com/ClangBuiltLinux/linux/issues/1364
> 
> The original steps to reproduce were:
> $ make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 defconfig
> $ scripts/config -e X86_DECODER_SELFTEST
> $ make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 olddefconfig bzImage
> 
> Which resulted in the error:
> arch/x86/tools/insn_decoder_test: warning: objdump says 0 bytes, but
> insn_get_length() says 2
> 
> Upon inspection it turned out llvm-objdump was formatting its
> output differently, which caused objdump_reformat.awk to incorrectly
> output its values.
> 
> After fixing that bug, a second one was seen where the instruction
> "wait" was incorrectly matched with "fwait", which again caused
> insn_decoder_test to fail.

Thanks a lot for sending these fixes!

I can confirm with this series and the removal of chkobjdump.awk [1] on
top of v5.16-rc8, the insn_decoder_test now passes with LLVM 11 through
14.

Tested-by: Nathan Chancellor <nathan@kernel.org>

For the future, I recommend putting the maintainers in the "To" field,
rather than "Cc", to ensure they actually see it. Additionally, I see
some small nits in the commit message that the tip maintainers might
comment on, see

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

for some more info.

Masami Hiramatsu originally wrote this file and has a few fixes to it
since, adding him now for review. The original thread is available at:

https://lore.kernel.org/r/20220106023606.283953-1-samuelzeter@gmail.com/

[1]: https://git.kernel.org/nathan/c/2f137c324b21f1c21b8830d8896cb9957009f969

Cheers,
Nathan
