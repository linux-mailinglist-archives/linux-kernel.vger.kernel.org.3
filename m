Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F14D49A84B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1317597AbiAYDC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415365AbiAYBpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:45:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C65BC01D7C1;
        Mon, 24 Jan 2022 17:25:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9EE561212;
        Tue, 25 Jan 2022 01:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA3EC340E4;
        Tue, 25 Jan 2022 01:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643073943;
        bh=UqSazjT8UyPJQUEShMssyVrpCVBuSCCA0ELCO1ImzW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSPlo4OqUozVEIEmdVIKHI2ituuKy/T67z+vMSJCANyJDo1i9UEiHVgcXdaJoBb21
         +IC0jCGd4z2K5cmdJUAkNCvBoTKpcxOvRb+O123AGD3pN8xGq8H0a/DQyblEniCliv
         gtH/07yXTnvS1+f83chvkucTrBmANoikqXruRDY3xfeTXVa03CP9CIWD/RsawFtVpo
         CqX9i6NOSAl076Tuw/3zvh8I5Snjvr6YUoXlCJ2Qra2fUcDiAn0NPIu/l6xnbMLcC6
         JQWCGI2K9x6Y7d+/g8JDPyoXeHjCb3M4siP7I9HQ5el5tcKlyczpH+9l9gHSnduBps
         48S3SKGI/lWOQ==
Date:   Mon, 24 Jan 2022 18:25:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] MIPS: Loongson64: Clean up use of cc-ifversion
Message-ID: <Ye9Rk4y9Ck7Bg5pv@dev-arch.archlinux-ax161>
References: <20220120214001.1879469-1-nathan@kernel.org>
 <CAKwvOd=4QBW5uFLM7zbHfG+5499tT_zqBTaZQgzqegmuq_5+MQ@mail.gmail.com>
 <c88b0d87-b238-4889-b033-226bed85bb01@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c88b0d87-b238-4889-b033-226bed85bb01@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:03:32AM +0000, Jiaxun Yang wrote:
> 
> 
> 在2022年1月24日一月 下午8:31，Nick Desaulniers写道：
> > On Thu, Jan 20, 2022 at 1:40 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >>
> >> This Makefile checks that GCC is 4.9 or newer, which is redundant after
> >> commit 76ae847497bc ("Documentation: raise minimum supported version of
> >> GCC to 5.1"), so cc-option can be removed.
> >>
> >> Clang does not support -march=loongson3a so it needs to continue to use
> >> -march=mips64r2, along with binutils less than 2.25, so check that both
> >> GCC and binutils 2.25 or newer are being used before using
> >> -march=loongson3a. These flags do not need to be checked with cc-option
> >> anymore because all GCC versions support -march=loongson3a and
> >> -march=mips64r2 and all clang versions support -march=mips64r2.
> >>
> >> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Thanks for the patch. I wonder why `_MIPS_ISA` only seems to be set at
> > all for `-march=loongson3a` AFAICT, though that question is orthogonal
> > to this patch. Perhaps the Loongson or MIPS maintainers know more?
> > Otherwise seems like most uses of _MIPS_ISA can either be deleted or
> > simplified now.
> 
> This is because earlier GCC mistakenly set loongson3a to MIPS64 not MIPS64R2.
> 
> But given that it's earlier than the minimal requirement GCC of kernel today, I think it should be safe to just move the whole logic.
> 
> Thanks.

So something like this (completely untested)?

diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 3e660d6d3c2b..36ab2fe00835 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -5,24 +5,9 @@
 
 cflags-$(CONFIG_CPU_LOONGSON64)	+= -Wa,--trap
 
-#
-# binutils from v2.25 on and gcc starting from v4.9.0 treat -march=loongson3a
-# as MIPS64 R2; older versions as just R1.  This leaves the possibility open
-# that GCC might generate R2 code for -march=loongson3a which then is rejected
-# by GAS.  The cc-option can't probe for this behaviour so -march=loongson3a
-# can't easily be used safely within the kbuild framework.
-#
-ifeq ($(call cc-ifversion, -ge, 0409, y), y)
-  ifeq ($(call ld-ifversion, -ge, 22500, y), y)
-    cflags-$(CONFIG_CPU_LOONGSON64)  += \
-      $(call cc-option,-march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
-  else
-    cflags-$(CONFIG_CPU_LOONGSON64)  += \
-      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
-  endif
-else
-    cflags-$(CONFIG_CPU_LOONGSON64)  += \
-      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
+ifdef CONFIG_CPU_LOONGSON64
+cflags-$(CONFIG_CC_IS_CLANG) += -march=mips64r2
+cflags-$(CONFIG_CC_IS_GCC) += -march=loongson3a
 endif
 
 # Some -march= flags enable MMI instructions, and GCC complains about that

> >
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> >> ---
> >>  arch/mips/loongson64/Platform | 13 +++----------
> >>  1 file changed, 3 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
> >> index 3e660d6d3c2b..981d3abc150e 100644
> >> --- a/arch/mips/loongson64/Platform
> >> +++ b/arch/mips/loongson64/Platform
> >> @@ -12,17 +12,10 @@ cflags-$(CONFIG_CPU_LOONGSON64)     += -Wa,--trap
> >>  # by GAS.  The cc-option can't probe for this behaviour so -march=loongson3a
> >>  # can't easily be used safely within the kbuild framework.
> >>  #
> >> -ifeq ($(call cc-ifversion, -ge, 0409, y), y)
> >> -  ifeq ($(call ld-ifversion, -ge, 22500, y), y)
> >> -    cflags-$(CONFIG_CPU_LOONGSON64)  += \
> >> -      $(call cc-option,-march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
> >> -  else
> >> -    cflags-$(CONFIG_CPU_LOONGSON64)  += \
> >> -      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
> >> -  endif
> >> +ifeq ($(CONFIG_CC_IS_GCC)$(call ld-ifversion, -ge, 22500, y), yy)
> >> +  cflags-$(CONFIG_CPU_LOONGSON64) += -march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64
> >>  else
> >> -    cflags-$(CONFIG_CPU_LOONGSON64)  += \
> >> -      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
> >> +  cflags-$(CONFIG_CPU_LOONGSON64) += -march=mips64r2
> >>  endif
> >>
> >>  # Some -march= flags enable MMI instructions, and GCC complains about that
> >>
> >> base-commit: 2c271fe77d52a0555161926c232cd5bc07178b39
> >> --
> >> 2.34.1
> >>
> >
> >
> > -- 
> > Thanks,
> > ~Nick Desaulniers
> 
> -- 
> - Jiaxun
