Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E31658CE93
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbiHHTbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiHHTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:31:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E589D5596
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 826E1612D2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AA0C433C1;
        Mon,  8 Aug 2022 19:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659987099;
        bh=kSnUwQkOfKM1Mn7a8k4LcXzj5EZ15JQG3PnKK95YqMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNHI6WEGVoxktgaSc/WbQV8uhrfflJVSaOTFQJ8Psp4qOXqsb4/Vrdnvjk7GhjXfK
         1XPoqjqd5OVvcNyRG9zaUXjPivkvjtjZ9/047zhjV9TF8xQYZEnZaQaACDM9FxSv+U
         HmNLA/vBl0O1nUcz3P6386x+ZgVEZW4HIsCexuREEEUKOjy0qlmTTaX51kNfiS33sE
         KuxslEeSrVZ4szx/arm91N+c/7lW3cGuzTeI5o280XkwXlk7N1OMgRSlMalrp9ZDcf
         D/QuKwoGHfoztIMTFKGVKx0tTh4l4EPzT6xSt5Rdy1ui1mj7A/owFIythxOOoW72wi
         iQC3Vi7mfAwJw==
Date:   Mon, 8 Aug 2022 12:31:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nick Clifton <nickc@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicolas Schier <n.schier@avm.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86: assemble with -Wa,--noexecstack to avoid BFD 2.39
 warning
Message-ID: <YvFkmfHTUYGzeeQs@dev-arch.thelio-3990X>
References: <20220808192321.3490995-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808192321.3490995-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 12:23:05PM -0700, Nick Desaulniers wrote:
> Users of GNU ld (BFD) from binutils 2.39+ will observe multiple instance
> of a new warning when linking kernels in the form:
> 
>   ld: warning: arch/x86/realmode/rm/bioscall.o: missing .note.GNU-stack
>   section implies executable stack
>   ld: NOTE: This behaviour is deprecated and will be removed in a future
>   version of the linker
> 
> The object files producing these all happen to be out of line assembler
> sources (*.S files).
> 
> Generally, we would like to avoid the stack being executable. Because
> there could be a need for the stack to be executable, assembler sources
> have to opt-in to this security feature via explicit creation of the
> .note.GNU-stack feature (which compilers create by default) or command
> line flag --noexecstack.
> 
> Boot tested defconfig and i386_defconfig in QEMU. If any assembler
> sources do require executable stack, they can be built with
> -Wa,--execstack, though the linker warning would have to be disabled. We
> might need to extend this more generally to the top level Makefile for
> all architectures, but I'm not equipped to test the result of such a
> change.
> 
> LLVM's LLD linker defaults to -z noexecstack, so this flag isn't
> strictly necessary when linking with LLD, only BFD, but it doesn't hurt
> to be explicit here for all linkers IMO.
> 
> Link: https://lore.kernel.org/linux-block/3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk/
> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107
> Link: https://github.com/llvm/llvm-project/issues/57009
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

FWIW, this warning appears for other architectures, as I have seen it
with powerpc and s390 and there is also a patch for ARM:

https://lore.kernel.org/20220721204709.445216-1-ben-linux@fluff.org/

Perhaps this should be done for all architectures in the main Makefile?

> ---
>  arch/x86/Makefile                 | 2 ++
>  arch/x86/boot/Makefile            | 2 +-
>  arch/x86/boot/compressed/Makefile | 2 +-
>  arch/x86/realmode/rm/Makefile     | 2 +-
>  4 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 7854685c5f25..571546775725 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -159,6 +159,8 @@ else
>          KBUILD_CFLAGS += -mcmodel=kernel
>  endif
>  
> +KBUILD_AFLAGS	+= -Wa,--noexecstack
> +
>  #
>  # If the function graph tracer is used with mcount instead of fentry,
>  # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index b5aecb524a8a..d7f2130f2277 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -67,7 +67,7 @@ targets += cpustr.h
>  # ---------------------------------------------------------------------------
>  
>  KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
> -KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
> +KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__ -Wa,--noexecstack
>  KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
>  GCOV_PROFILE := n
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 19e1905dcbf6..1587a21a132d 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -57,7 +57,7 @@ KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
>  # that the compiler finds it even with out-of-tree builds (make O=/some/path).
>  CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
>  
> -KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> +KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__ -Wa,--noexecstack
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE :=n
>  
> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> index 83f1b6a56449..5f2fdafaa034 100644
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -73,7 +73,7 @@ $(obj)/realmode.relocs: $(obj)/realmode.elf FORCE
>  
>  KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
>  		   -I$(srctree)/arch/x86/boot
> -KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
> +KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__ -Wa,--noexecstack
>  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
> -- 
> 2.37.1.559.g78731f0fdb-goog
> 
