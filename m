Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AC54BBD99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbiBRQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:34:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiBRQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:34:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721032ABD1D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:34:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BDC261F65
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005E3C340E9;
        Fri, 18 Feb 2022 16:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645202066;
        bh=3mfSjeFg5UvPQyM+d6QjT4buHJvJkQj1rCBa6ArkwLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZuRn1OerTeB+bGjnhGoQE/AGo69mdoiz0E94CWlv2O8qyXt8tljx3FyIj8RrliyvM
         WGRoGjBmzmAvbayY/2fINCHlio9C9JYdxFIpqVQcRbhxfyj+EWFZgDIB/645q83692
         ZcePfNUtvxSL+MD8fic+EX/SikK+JkWHZBPBjvj1V2YEswppYXOCxRdcjhPnYx8U1r
         d0/ViUsO9e0tFx6SuBL9yhMRwlJwPPRCFMxcQRDikG1o69g2DygDes4CUt66T+xAtt
         g1wjcbQ3cLNEJEbcsYE97yvpt8ezTQO6pjTQRdDdiAJkdvjWpRDNAFsqB3MoF1yoHq
         YjXANXrPgSL0A==
Date:   Fri, 18 Feb 2022 09:34:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] arm64 module: remove (NOLOAD)
Message-ID: <Yg/KjpHOZ7HwZq9f@dev-arch.archlinux-ax161>
References: <20220218081209.354383-1-maskray@google.com>
 <CAMj1kXGZuOWOPEHv0YSM4GseG2PnTgS8mSLXQ+imo-TN7MmvaQ@mail.gmail.com>
 <20220218085016.jv4qcfaxav5fxhrs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218085016.jv4qcfaxav5fxhrs@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 12:50:16AM -0800, Fangrui Song wrote:
> On 2022-02-18, Ard Biesheuvel wrote:
> > On Fri, 18 Feb 2022 at 09:12, Fangrui Song <maskray@google.com> wrote:
> > > 
> > > On ELF, (NOLOAD) sets the section type to SHT_NOBITS[1]. It is conceptually
> > > inappropriate for .plt and .text.* sections which are always
> > > SHT_PROGBITS.
> > > 
> > > In GNU ld, if PLT entries are needed, .plt will be SHT_PROGBITS anyway
> > > and (NOLOAD) will be essentially ignored. In ld.lld, since
> > > https://reviews.llvm.org/D118840 ("[ELF] Support (TYPE=<value>) to
> > > customize the output section type"), ld.lld will report a `section type
> > > mismatch` error. Just remove (NOLOAD) to fix the error.
> > > 
> > > [1] https://lld.llvm.org/ELF/linker_script.html As of today, "The
> > > section should be marked as not loadable" on
> > > https://sourceware.org/binutils/docs/ld/Output-Section-Type.html is
> > > outdated for ELF.
> > 
> > This patch lacks a SOB line.
> > 
> > With one added,
> > 
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Ah, yes. Sorry, I haven't sent a kernel patch for a while...
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

I am assuming this patch is the solution we want, as opposed to Ard's
suggestion of renaming these sections at
https://reviews.llvm.org/D118840 (unless that was a tangential
suggestion).

I have verified that modules still load. Additionally, this needs to go
to stable so that groups who upgrade their toolchain to a revision that
include the LLD patch don't get broken as well.

Cc: stable@vger.kernel.org
Tested-by: Nathan Chancellor <nathan@kernel.org>


> > > ---
> > >  arch/arm64/include/asm/module.lds.h | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
> > > index a11ccadd47d2..094701ec5500 100644
> > > --- a/arch/arm64/include/asm/module.lds.h
> > > +++ b/arch/arm64/include/asm/module.lds.h
> > > @@ -1,8 +1,8 @@
> > >  SECTIONS {
> > >  #ifdef CONFIG_ARM64_MODULE_PLTS
> > > -       .plt 0 (NOLOAD) : { BYTE(0) }
> > > -       .init.plt 0 (NOLOAD) : { BYTE(0) }
> > > -       .text.ftrace_trampoline 0 (NOLOAD) : { BYTE(0) }
> > > +       .plt 0 : { BYTE(0) }
> > > +       .init.plt 0 : { BYTE(0) }
> > > +       .text.ftrace_trampoline 0 : { BYTE(0) }
> > >  #endif
> > > 
> > >  #ifdef CONFIG_KASAN_SW_TAGS
> > > --
> > > 2.35.1.265.g69c8d7142f-goog
> > > 
> 
