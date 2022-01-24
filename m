Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CA149AB32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1325932AbiAYEoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1324828AbiAYDeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:34:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660AAC06E03F;
        Mon, 24 Jan 2022 15:10:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF71960AF3;
        Mon, 24 Jan 2022 23:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5FDC340E4;
        Mon, 24 Jan 2022 23:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643065804;
        bh=Lp6rBZeoWYvUHuCD14f8+11LQt9Mi2Dm69IzD6JEQwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtSnnOhfsoXPMxEJjZG7HGc6V+LawAvTVXbLHtmGw2He8RRaBlm7GvLST2N1SIRAz
         ZGUbrG2gw+cQqnxVUvqvmC3J9cAgZnTwWTki1Mi1uhqYJ6nu/SEIdFSprNwxokuvAP
         bAsqBG110QGX08TnQ1gNARwRPApJWWd1JuFVXVguoBFe47T7W16iSRbbOhmjM4Ye1N
         IVipSpAqAz3bahs7SQ5+nj2KHRmBwLMKgQcTNDTMxZDQW89fivr9wM0nI39Lu8xfS8
         beWcsbplzHpWed31o1KGbE+4TOLDUkeVr7D+W12zN10XakzIHrnIkfDiSK1hzMb9a4
         zxjHu+ZELkrAA==
Date:   Mon, 24 Jan 2022 16:09:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] MIPS: Loongson64: Wrap -mno-branch-likely with
 cc-option
Message-ID: <Ye8xx5/44wQCt+dS@dev-arch.archlinux-ax161>
References: <20220120214001.1879469-1-nathan@kernel.org>
 <20220120214001.1879469-2-nathan@kernel.org>
 <CAKwvOdmTBUcre5+=kopcyAv3q=55=Z5O65QHmvy3Ra2JqgLNHw@mail.gmail.com>
 <Ye8qOloosgFyY8v8@archlinux-ax161>
 <CAKwvOdmri9H_yCkN=Rr26UqZgFoXoGPM+41gBS15X1=zGSg_3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmri9H_yCkN=Rr26UqZgFoXoGPM+41gBS15X1=zGSg_3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 02:49:29PM -0800, Nick Desaulniers wrote:
> On Mon, Jan 24, 2022 at 2:37 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Mon, Jan 24, 2022 at 12:40:58PM -0800, Nick Desaulniers wrote:
> > > On Thu, Jan 20, 2022 at 1:40 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > This flag is not supported by clang, which results in a warning:
> > > >
> > > >   clang-14: warning: argument unused during compilation: '-mno-branch-likely' [-Wunused-command-line-argument]
> > > >
> > > > This breaks cc-option, which adds -Werror to make this warning fatal and
> > > > catch flags that are not supported. Wrap the flag in cc-option so that
> > > > it does not cause cc-option to fail, which can cause randconfigs to be
> > > > really noisy.
> > > >
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > >
> > > We should convert more of these tests to Kconfig checks that run once
> > > per configuration, rather than multiple times for a build. IIRC Linus
> > > mentioned this somewhere...yeah, the -Wimplicit-fallthrough patches.
> > > See
> > > dee2b702bcf06 ("kconfig: Add support for -Wimplicit-fallthrough")
> > >
> > > I wonder if we can check ARCH or SUBARCH in Kconfig to limit invoking
> > > the tool under test for certain arch specific command line flags?
> > >
> > > I'll take this patch over such a larger change, but I think towards
> > > the goal of speeding up already configured builds, we eventually want
> > > to be migrating cc-option and ld-option checks to Kconfig.
> > >
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Something like this appears to work, if that is more preferrable?
> >
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 058446f01487..a27a3ade810e 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -3232,3 +3232,9 @@ endmenu
> >  source "arch/mips/kvm/Kconfig"
> >
> >  source "arch/mips/vdso/Kconfig"
> > +
> > +config CC_MNO_BRANCH_LIKELY
> > +       string
> > +       default "-mno-branch-likely"
> > +       depends on MACH_LOONGSON64 || MACH_LOONGSON2EF
> > +       depends on $(cc-option,-mno-branch-likely)
> > diff --git a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform
> > index 50e659aca543..66ed09581417 100644
> > --- a/arch/mips/loongson2ef/Platform
> > +++ b/arch/mips/loongson2ef/Platform
> > @@ -41,6 +41,6 @@ cflags-y += $(call cc-option,-mno-loongson-mmi)
> >  # Loongson Machines' Support
> >  #
> >
> > -cflags-$(CONFIG_MACH_LOONGSON2EF) += -I$(srctree)/arch/mips/include/asm/mach-loongson2ef -mno-branch-likely
> > +cflags-$(CONFIG_MACH_LOONGSON2EF) += -I$(srctree)/arch/mips/include/asm/mach-loongson2ef $(CONFIG_CC_MNO_BRANCH_LIKELY)
> 
> Does that allow someone to modify the value for CC_MNO_BRANCH_LIKELY
> in menuconfig?

No because it is a hidden symbol; in other words:

config ...
    string

rather than

config ...
    string "..."

> If so, I'd rather the Makefiles have:
> 
> cflags-$(CONFIG_CC_MNO_BRANCH_LIKELY) += -mno-branch-likely
> 
> and CONFIG_CC_MNO_BRANCH_LIKELY be a bool rather than an editable
> string.  I think that makes the Makefile more readable; you don't have
> to see what CONFIG_CC_MNO_BRANCH_LIKELY expands to in a different
> file.
> 
> See also CC_HAS_ASM_GOTO and CC_HAS_ASM_GOTO_OUTPUT in init/Kconfig.

Regardless, your suggestion is simpler. I can send that as v2 if this is
preferrable.

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 058446f01487..4f83fb5610cb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3232,3 +3232,7 @@ endmenu
 source "arch/mips/kvm/Kconfig"
 
 source "arch/mips/vdso/Kconfig"
+
+config CC_HAS_MNO_BRANCH_LIKELY
+	def_bool y
+	depends on $(cc-option,-mno-branch-likely)
diff --git a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform
index 50e659aca543..eebabf9df6ac 100644
--- a/arch/mips/loongson2ef/Platform
+++ b/arch/mips/loongson2ef/Platform
@@ -41,6 +41,7 @@ cflags-y += $(call cc-option,-mno-loongson-mmi)
 # Loongson Machines' Support
 #
 
-cflags-$(CONFIG_MACH_LOONGSON2EF) += -I$(srctree)/arch/mips/include/asm/mach-loongson2ef -mno-branch-likely
+cflags-$(CONFIG_MACH_LOONGSON2EF) += -I$(srctree)/arch/mips/include/asm/mach-loongson2ef
+cflags-$(CONFIG_CC_HAS_MNO_BRANCH_LIKELY) += -mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
 load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 3e660d6d3c2b..2fd9dc218a68 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -33,5 +33,6 @@ cflags-y += $(call cc-option,-mno-loongson-mmi)
 # Loongson Machines' Support
 #
 
-cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64 -mno-branch-likely
+cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64
+cflags-$(CONFIG_CC_HAS_MNO_BRANCH_LIKELY) += -mno-branch-likely
 load-$(CONFIG_CPU_LOONGSON64) += 0xffffffff80200000

> >  load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
> >  load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
> > diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
> > index 3e660d6d3c2b..88fbdfe9ffcc 100644
> > --- a/arch/mips/loongson64/Platform
> > +++ b/arch/mips/loongson64/Platform
> > @@ -33,5 +33,5 @@ cflags-y += $(call cc-option,-mno-loongson-mmi)
> >  # Loongson Machines' Support
> >  #
> >
> > -cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64 -mno-branch-likely
> > +cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64 $(CONFIG_CC_MNO_BRANCH_LIKELY)
> >  load-$(CONFIG_CPU_LOONGSON64) += 0xffffffff80200000
> >
> > > > ---
> > > >  arch/mips/loongson64/Platform | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
> > > > index 981d3abc150e..acf9edc9b15d 100644
> > > > --- a/arch/mips/loongson64/Platform
> > > > +++ b/arch/mips/loongson64/Platform
> > > > @@ -26,5 +26,6 @@ cflags-y += $(call cc-option,-mno-loongson-mmi)
> > > >  # Loongson Machines' Support
> > > >  #
> > > >
> > > > -cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64 -mno-branch-likely
> > > > +cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64
> > > > +cflags-$(CONFIG_MACH_LOONGSON64) += $(call cc-option,-mno-branch-likely)
> > > >  load-$(CONFIG_CPU_LOONGSON64) += 0xffffffff80200000
> > > > --
> > > > 2.34.1
> > > >
> > > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
