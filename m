Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7278569704
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiGGAtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGGAtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:49:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAFD2CDDE;
        Wed,  6 Jul 2022 17:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eKVp5k3k/Mi0/qvMSWAz3I45APz4Z+f2neoyr3EBBk8=; b=y/l+gyEDKQLQwYx67C/tiLjSvj
        a0Rj2klHPOOnWB4ifiC8iV44uRyT6gMRDIJu8Dv2ER2oy4a08J4hLSVXwdwacPVzApHheuzw5jsPU
        ueZNNpL2ZmPny582FLFVGY50TKdBSBNSDRaSrzMtaoRVLEFaqTQAbNK/WSNJcEmYQ8h7wHmPjoU27
        DW3Xq13JSCqOCHS1BopLuVmKIN9Zf5Ji55U4mcFqLPOEZvp5H6i7+PNNKtDoLx+343HZnseieDEQT
        BOdpcJ4pvICvl35OyEvix4J3mkDlYJHSklNMqD9bLTfOsm1P8WTN1vBh8vTbVUZYeupio+esFxNHg
        YnMsYrjg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9FhM-00Ctk7-8V; Thu, 07 Jul 2022 00:48:52 +0000
Date:   Wed, 6 Jul 2022 17:48:52 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Helge Deller <deller@gmx.de>, Borislav Petkov <bp@alien8.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>, jeyu@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v2] modules: Ensure natural alignment for
 .altinstructions and __bug_table sections
Message-ID: <YsYtdMmsW2tHVx54@bombadil.infradead.org>
References: <Yr8/gr8e8I7tVX4d@p100>
 <Yr9l24rvCAPJvuJQ@bombadil.infradead.org>
 <040d5924-eb42-2ee4-d663-88ef393cd4ae@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040d5924-eb42-2ee4-d663-88ef393cd4ae@gmx.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 06:24:52PM +0200, Helge Deller wrote:
> Hi Luis,
> 
> On 7/1/22 23:23, Luis Chamberlain wrote:
> > On Fri, Jul 01, 2022 at 08:40:02PM +0200, Helge Deller wrote:
> >> In the kernel image vmlinux.lds.S linker scripts the .altinstructions
> >> and __bug_table sections are 32- or 64-bit aligned because they hold 32-
> >> and/or 64-bit values.
> >>
> >> But for modules the module.lds.S linker script doesn't define a default
> >> alignment yet, so the linker chooses the default byte alignment, which
> >> then leads to unnecessary unaligned memory accesses at runtime.
> >>
> >> Usually such unaligned accesses are unnoticed, because either the
> >> hardware (as on x86 CPUs) or in-kernel exception handlers (e.g. on hppa
> >> or sparc) emulate and fix them up at runtime.
> >>
> >> On hppa the 32-bit unalignment exception handler was temporarily broken
> >> due another bad commit, and as such wrong values were returned on
> >> unaligned accesses to the altinstructions table.
> >
> > OK so some bad commit broke something which caused bad alignment access
> > on altinstructions... But why on modules?!
> >
> > I am not aware of modules using alternatives, given that alternatives
> > are hacks to help with bootup. For modules we can use other things
> > like jump labels, static keys.
> 
> IMHO altinstructions isn't a hack.
> They are much simpler and easier to use for static replacements.
> jump labels and static keys are much more komplex, but of course they
> give the possibility to switch back and forth if you need it.
> But let's keep this discussion aside...

Yeah sure whatever.

> I checked a few other architectures, and here is what I found.
> I dropped unimportant sections/lines.
> 
> Linux amdahl 4.19.0-20-arm64 #1 SMP Debian 4.19.235-1 (2022-03-17) aarch64 GNU/Linux
> deller@amdahl:/lib/modules/4.19.0-19-arm64/kernel/block$ objdump -h bfq.ko
> bfq.ko:     file format elf64-littleaarch64
> Sections:
> Idx Name          Size      VMA               LMA               File off  Algn
>   6 .altinstructions 000000b4  0000000000000000  0000000000000000  000090a4  2**0
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>  13 __jump_table  00000018  0000000000000000  0000000000000000  0000d358  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>  15 __bug_table   00000018  0000000000000000  0000000000000000  0000dcf8  2**2
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
> 
> -> aarch64 uses altinstructions in modules as well.
> -> alignment of altinstructions is wrong (but offset suggests it gets address right).
> -> jump_table/bug_table -> Ok.
> 
> ----
> 
> Linux abel 4.19.0-20-armmp-lpae #1 SMP Debian 4.19.235-1 (2022-03-17) armv7l GNU/Linux
> deller@abel:/lib/modules/4.19.0-20-armmp-lpae/kernel/block$ objdump -h bfq.ko
> bfq.ko:     file format elf32-littlearm
> Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
>   9 __mcount_loc  000002ac  00000000  00000000  00009bf4  2**2
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>  11 __jump_table  0000000c  00000000  00000000  0000b320  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
> 
> -> arm looks good.
> 
> ----
> 
> Linux plummer 4.19.0-20-powerpc64le #1 SMP Debian 4.19.235-1 (2022-03-17) ppc64le GNU/Linux
> deller@plummer:/lib/modules/4.19.0-20-powerpc64le/kernel/block$ objdump -h bfq.ko
> bfq.ko:     file format elf64-powerpcle
> Sections:
> Idx Name          Size      VMA               LMA               File off  Algn
>   9 __mcount_loc  00000530  0000000000000000  0000000000000000  0000bc68  2**0
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>  12 __jump_table  00000018  0000000000000000  0000000000000000  000109d8  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>  16 __bug_table   00000030  0000000000000000  0000000000000000  000115a0  2**0
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
> 
> -> ppc64le has wrong alignment for mcount_loc and bug_table (but file offs suggests it's correct).
> 
> ----
> 
> Linux zelenka 4.19.0-20-s390x #1 SMP Debian 4.19.235-1 (2022-03-17) s390x GNU/Linux
> deller@zelenka:/lib/modules/4.19.0-20-s390x/kernel/block$ objdump -h bfq.ko
> bfq.ko:     file format elf64-s390
> Sections:
> Idx Name          Size      VMA               LMA               File off  Algn
>   3 .altinstr_replacement 00000038  0000000000000000  0000000000000000  0000a440  2**0
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>   8 .altinstructions 000000a8  0000000000000000  0000000000000000  0000b04e  2**0
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>  10 __mcount_loc  00000538  0000000000000000  0000000000000000  0000b1b0  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>  13 __jump_table  00000018  0000000000000000  0000000000000000  0000c8e0  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>  17 __bug_table   00000018  0000000000000000  0000000000000000  0000d280  2**0
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
> 
> -> s390x uses altinstructions in modules.
> -> alignment should be fixed for altinstructions and bug_table

Thanks for checking. I was wondering what uses cases openly used
alternatives in modules. It was surprising to see bfq using it for some
architectures.

The problem with this question is that there are quite a bit of uses
of ALTERNATIVE() on many calls on for example arch/arm64/include/.
So really it could land on any module.

> > So I don't understand still how this happened yet.
> 
> Happened what?
> Even on x86 there is a call to apply_alternatives() in module_finalize() in
> arch/x86/kernel/module.c.

> I didn't found alternatives in amd64 modules in kernel 4.19 though...

I do see one on bfq on 5.17:

objdump  /lib/modules/5.17.0-1-amd64/kernel/block/bfq.ko -h --section=.altinstructions --section=.altinstr_replacement 
objdump: Warning: Separate debug info file
/usr/lib/modules/5.17.0-1-amd64/kernel/block/bfq.ko found, but CRC does not match - ignoring

/lib/modules/5.17.0-1-amd64/kernel/block/bfq.ko:     file format
elf64-x86-64

Sections:
Idx Name          Size      VMA               LMA               File off
Algn
  3 .altinstr_replacement 0000001c  0000000000000000  0000000000000000  0000c500  2**0
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
  9 .altinstructions 00000054  0000000000000000 0000000000000000  0
                    CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA

I also them on even filesystems like xfs and so yeah, anywhere where a
primative the achitecture uses which a driver uses will peg an
alternative to a module.

> >> This then led to
> >> undefined behaviour because wrong kernel addresses were patched and we
> >> suddenly faced lots of unrelated bugs, as can be seen in this mail
> >> thread:
> >> https://lore.kernel.org/all/07d91863-dacc-a503-aa2b-05c3b92a1e39@bell.net/T/#mab602dfa32be5e229d5e192ab012af196d04d75d
> >>
> >> This patch adds the missing natural alignment for kernel modules to
> >> avoid unnecessary (hard- or software-based) fixups.
> >
> > Is it correct to infer that issue you found through a bad commit was
> > then through code inspection after the bad commit made the kernel do
> > something stupid with unaligned access to some module altinstructions
> > section ? Ie, that should not have happened.
> 
> Right. Without the bad commit I would not have noticed the problem.

OK please clarify this in your next spin of this patch.

> > I'd like to determine if this is a stable fix, a regression, etc. And
> > this is not yet clear.
> 
> I fully understand that it's a hard to decide if it should go to stable!

> It's not critical or required to go to stable series now.

I agree.

Given, as you noted, that "usually such unaligned accesses are unnoticed,
because either the hardware (as on x86 CPUs) or in-kernel exception handlers
emulate and fix them up at runtime", I'm inclined to say no. 

I'll let others chime in, in case I've missed some corner case.

> My suggestion:
> Add it to current head, wait for 1-2 releases, and *if required* we can
> push it backwards at any time later.

Yeah that sounds good. Can you re-work the commit log a bit more to make
the judgement call to move stable later a bit easier? If one doesn't
work with alternatives regularly there is some information that can
quickly be lost during patch review / commit log review. And these days
bots pick up patches for stable... so they might override in the end.

  Luis
> 
> Helge
> 
> 
> >   Luis
> >
> >>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >> ---
> >>  scripts/module.lds.S | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> --
> >> v2: updated commit message
> >>
> >> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> >> index 1d0e1e4dc3d2..3a3aa2354ed8 100644
> >> --- a/scripts/module.lds.S
> >> +++ b/scripts/module.lds.S
> >> @@ -27,6 +27,8 @@ SECTIONS {
> >>  	.ctors			0 : ALIGN(8) { *(SORT(.ctors.*)) *(.ctors) }
> >>  	.init_array		0 : ALIGN(8) { *(SORT(.init_array.*)) *(.init_array) }
> >>
> >> +	.altinstructions	0 : ALIGN(8) { KEEP(*(.altinstructions)) }
> >> +	__bug_table		0 : ALIGN(8) { KEEP(*(__bug_table)) }
> >>  	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
> >>
> >>  	__patchable_function_entries : { *(__patchable_function_entries) }
> 
