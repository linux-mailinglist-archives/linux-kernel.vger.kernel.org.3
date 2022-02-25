Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7010D4C3A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiBYALz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiBYALw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:11:52 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1167214F9F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:11:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id m11so3321478pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=In77i2k/Dlw4li92tNBJEcVDYHwHTC77CKejZqvuXbc=;
        b=OlRKKTR2+t3jjPbjPhpIQm/vd2ONEs1sAry0xgT22OV+Y7gNyQe3hHhtKwb/23SJYn
         otuK2obTOnX+F82zXfT84xyVq8e1zZs2E2wA37gZ51HqOlZSDflMFgYD2VazECVTCYpv
         SNLGFyH+3SnsPMGkm5hA7PgUEQEfRdd5r7HqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=In77i2k/Dlw4li92tNBJEcVDYHwHTC77CKejZqvuXbc=;
        b=bO13rRj+8s++Z/iBj7CE7ClLhnOrhvCUHKizK/RKzzTBho206dAXWlMRLDmuIOu8Ov
         V2TxqnUTH/hVoRhRSExytZUryfYivYIf/R4af7GvUpvpZEtXgj8iTE2roaO48TrCxxsn
         +R5imM5FtU5CMcvi3PFmrVkr25zrdAbYo3vznDrgD0oFGke/6BOqCQlqsAYeCBXZ+jBK
         W4Zq+AAoxiX6+9MgPN+tilD9lC/SgsIjjgqgq5VWZT/h67PbjQFgk1IEuCU2Pn3zzc7R
         0ib4KLGeD/xUzT0+w96s79uNR3JpcTikpu2uOaH+hVMXKjFncr/jd2E5m4lFmdmac56G
         mocA==
X-Gm-Message-State: AOAM5334QTeB+/YMDAuPkpornvFHBKrIlo+Xl+NJsQghrgwUvIDhLo6U
        +8QzQZX5PmkzneiuKiQ0qwb+Ac6jvOk/dw==
X-Google-Smtp-Source: ABdhPJw0dQBRMsviBRsNqTIih90cTEDQO/hW5pKY58bUeKwoX86mCcTbmYvgJu7mJccn1eYsyXnrWg==
X-Received: by 2002:a17:902:7207:b0:14d:938e:a88e with SMTP id ba7-20020a170902720700b0014d938ea88emr5095030plb.42.1645747881053;
        Thu, 24 Feb 2022 16:11:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5-20020a63fa45000000b0037407b6ffdasm606419pgk.5.2022.02.24.16.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:11:20 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:11:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 01/39] kbuild: Fix clang build
Message-ID: <202202241543.B1B6C77C@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.072632223@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.072632223@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nit: Subject maybe could be something more specific like:
"kbuild: Detect and apply clang version suffix to defaults"

On Thu, Feb 24, 2022 at 03:51:39PM +0100, Peter Zijlstra wrote:
> Debian (and derived) distros ship their compilers as -$ver suffixed
> binaries. For gcc it is sufficent to use:
> 
>  $ make CC=gcc-12
> 
> However, clang builds (esp. clang-lto) need a whole array of tools to be
> exactly right, leading to unweildy stuff like:

Yeah, I have had this problem with gcc versions too (when trying to
select older compilers when cross compiling).

> [...]
> which is, quite franktly, totally insane and unusable. Instead make
> the CC variable DTRT, enabling one such as myself to use:
> 
>  $ make CC=clang-13

This form is intended to mix clang and binutils, as there is a long tail
of (usually architecture-specific) issues with ld.lld and Clang's
assembler. It's only relatively recently that clang + ld.lld works
happily on x86_64. Growing a way to split that logic by architecture
might be interesting, but also confusing...

> This also lets one quickly test different clang versions.
> Additionally, also support path based LLVM suites like:
> 
>  $ make CC=/opt/llvm/bin/clang
> 
> This changes the default to LLVM=1 when CC is clang, mixing toolchains
> is still possible by explicitly adding LLVM=0.

I do like the path idea -- this is much cleaner in Clang's case than the
gcc/binutils mixture where a versioned binutils might not even exist in
a given environment. I've been fighting versioned cross compilers with
gcc and ld.bfd. It's almost worse. ;)

> [...]
> --- a/Makefile
> +++ b/Makefile
> @@ -423,9 +423,29 @@ HOST_LFS_CFLAGS := $(shell getconf LFS_C
>  HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
>  HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
>  
> -ifneq ($(LLVM),)
> -HOSTCC	= clang
> -HOSTCXX	= clang++
> +# powerpc and s390 don't yet work with LLVM as a whole

Er, this, uh, doesn't really capture the matrix. ;) See
https://clangbuiltlinux.github.io/

> +ifeq ($(ARCH),powerpc)
> +LLVM = 0
> +endif
> +ifeq ($(ARCH),s390)
> +LLVM = 0
> +endif
> +
> +# otherwise, if CC=clang, default to using LLVM to enable LTO

I find this comment confusing: using LLVM=1 lets LTO be possible,
strictly speaking, it doesn't enable it.

> +CC_BASE := $(shell echo $(CC) | sed 's/.*\///')

I would expect $(shell basename $(CC)) (or similarly "dirname") for
these sorts of path manipulations, but I'll bet there's some Makefile
string syntax to do this too, to avoid $(shell) entirely...

> +CC_NAME := $(shell echo $(CC_BASE) | cut -b "1-5")

O_o  cut -d- -f1

> +ifeq ($(shell test "$(CC_NAME)" = "clang"; echo $$?),0)
> +LLVM ?= 1
> +LLVM_PFX := $(shell echo $(CC) | sed 's/\(.*\/\)\?.*/\1/')

dirname

> +LLVM_SFX := $(shell echo $(CC_BASE) | cut -b "6-")

cut -d- -f2-

> +endif

This versioned suffix logic I'm fine with, though I'd prefer we gain
this for both Clang and GCC, as I've needed it there too, specifically
with the handling of CROSS_COMPILE:

$ make CROSS_COMPILE=/path/to/abi- CC=/path/to/abi-gcc-10 LD=/path/to/abi-ld-binutilsversion

Anyway, I guess that could be a separate patch.

> +# if not set by now, do not use LLVM
> +LLVM ?= 0

I think, however, the LLVM state needs to stay default=0. The "how to
build with Clang" already details the "how" on this:
https://www.kernel.org/doc/html/latest/kbuild/llvm.html

But I do agree: extracting the version suffix would make things much
easier.

Regardless, even if LLVM=1 is made the default, I think that should be
separate from the path and suffix logic.

Also, please CC the "CLANG/LLVM BUILD SUPPORT" maintainers in the
future:
M:      Nathan Chancellor <nathan@kernel.org>
M:      Nick Desaulniers <ndesaulniers@google.com>
L:      llvm@lists.linux.dev
S:      Supported
W:      https://clangbuiltlinux.github.io/
B:      https://github.com/ClangBuiltLinux/linux/issues
C:      irc://irc.libera.chat/clangbuiltlinux
F:      Documentation/kbuild/llvm.rst
F:      include/linux/compiler-clang.h
F:      scripts/Makefile.clang
F:      scripts/clang-tools/
K:      \b(?i:clang|llvm)\b

-- 
Kees Cook
