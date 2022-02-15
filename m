Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6BB4B7B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244847AbiBOXsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:48:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbiBOXsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:48:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A865BBF505;
        Tue, 15 Feb 2022 15:48:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4852BB81D4B;
        Tue, 15 Feb 2022 23:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA4EC340EB;
        Tue, 15 Feb 2022 23:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644968889;
        bh=ntRkLDJdszNp74lJFVe+EQz4Z27rNENIOTdR2SU+7VU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/SX0Swt8Tie4u76t8Z0xXSmx1fzLK7JoCvPUyRiuVFh1LSRgFO0q2dOOzLt7Bn0s
         0gVJLDZOjGnBBGMrmEqMfJ67WnbtmRdW7/yOgxSUaZQ7tvZVwNHk3jO3h19zkQFSuf
         58mfZNMbB8hEGDeSuGMKB7umTk1la9ufDJEJxrtZT9j56kec1tSDrgSdZdaNciWRx6
         aH0zR+swH7M+ZZBCGydDFoeqpYmxZ4qVrccNGJD8u4q5wfbea+sth8aVqhGYds2FH2
         U06eeZ3pRAswO8RIn4RwagyApfOUBrGioY1Uar/kY9QJiAHnX/OQjvxIl1tUKfN4am
         u3Tn7iHF3oYiw==
Date:   Tue, 15 Feb 2022 16:48:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Yujie Liu <yujie.liu@intel.com>,
        Philip Li <philip.li@intel.com>, julie.du@intel.com,
        Michal Marek <michal.lkml@markovi.net>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/llvm: refresh docs for LLVM=1
Message-ID: <Ygw7s5XRokaPP1J5@dev-arch.archlinux-ax161>
References: <20220215204947.1719516-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215204947.1719516-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 12:49:47PM -0800, Nick Desaulniers wrote:
> Refresh the docs for 2022:
> * add link to Chimera Linux.
> * add Quick Start section pointing out that LLVM=1 is the simple
>   recommended method.
> * Re-order the sections on Clang and Cross Compiling to come after the
>   section on LLVM utilities. I think the documentation flows better this
>   way.
> * Add note about LLVM=1 to Omitting CROSS_COMPILE section.
> * Change note in Supported Architectures from discussing CC=clang vs.
>   LLVM=1 to discussion LLVM=1 vs. LLVM_IAS=0.
> * Update make command column of support architecture table; we now
>   support LLVM=1 everywhere; just some more work to get ARCH=s390
>   assembling with clang.
> * Word wrap a few columns over 80 lines.

This patch is doing a lot, it might make sense to split it up. Reviewing
documentation changes is not the easiest as it is.

Comments inline, thanks for the patch!

> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  Documentation/kbuild/llvm.rst | 82 +++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> index d32616891dcf..7f52cde70bc7 100644
> --- a/Documentation/kbuild/llvm.rst
> +++ b/Documentation/kbuild/llvm.rst
> @@ -15,36 +15,27 @@ such as GCC and binutils. Ongoing work has allowed for `Clang
>  <https://clang.llvm.org/>`_ and `LLVM <https://llvm.org/>`_ utilities to be
>  used as viable substitutes. Distributions such as `Android
>  <https://www.android.com/>`_, `ChromeOS
> -<https://www.chromium.org/chromium-os>`_, and `OpenMandriva
> -<https://www.openmandriva.org/>`_ use Clang built kernels.  `LLVM is a
> +<https://www.chromium.org/chromium-os>`_, `OpenMandriva
> +<https://www.openmandriva.org/>`_, and `Chimera Linux
> +<https://chimera-linux.org/>`_ use Clang built kernels.  `LLVM is a
>  collection of toolchain components implemented in terms of C++ objects
>  <https://www.aosabook.org/en/llvm.html>`_. Clang is a front-end to LLVM that
>  supports C and the GNU C extensions required by the kernel, and is pronounced
>  "klang," not "see-lang."
>  
> -Clang
> ------
> +Quick Start
> +-----------
> +::
>  
> -The compiler used can be swapped out via ``CC=`` command line argument to ``make``.
> -``CC=`` should be set when selecting a config and during a build. ::
> +	make LLVM=1
>  
> -	make CC=clang defconfig
> +for native builds or
>  
> -	make CC=clang
> +or ::
>  
> -Cross Compiling
> ----------------
> +	ARCH=arm64 make LLVM=1

make ARCH=arm64 LLVM=1

is used throughout the rest of the document and I think it is more
consistent to keep all the variables on the right side of make.

Compare:

$ rg "make .*=" Documentation

vs.

$ rg "=.* make" Documentation

>  
> -A single Clang compiler binary will typically contain all supported backends,
> -which can help simplify cross compiling. ::
> -
> -	make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu-
> -
> -``CROSS_COMPILE`` is not used to prefix the Clang compiler binary, instead
> -``CROSS_COMPILE`` is used to set a command line flag: ``--target=<triple>``. For
> -example: ::
> -
> -	clang --target=aarch64-linux-gnu foo.c
> +for cross compiling.
>  
>  LLVM Utilities
>  --------------
> @@ -63,6 +54,32 @@ They can be enabled individually. The full list of the parameters: ::
>  The integrated assembler is enabled by default. You can pass ``LLVM_IAS=0`` to
>  disable it.
>  
> +Clang
> +-----
> +
> +The compiler used can be swapped out via ``CC=`` command line argument to

... via the ``CC=``... ?

> +``make``.  ``CC=`` should be set when selecting a config and during a build.

I think

``CC=`` should be set when generating a config and building a kernel.

might read a little bit better?

> +``CC=clang`` is implied by ``LLVM=1``, but if it's desired to simply use clang
> +as the compiler for the target, then ``CC=`` is a quick substitute. ::
> +
> +	make CC=clang defconfig
> +
> +	make CC=clang
> +
> +Cross Compiling
> +---------------
> +
> +A single Clang compiler binary will typically contain all supported backends,
> +which can help simplify cross compiling. ::
> +
> +	make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu-
> +
> +``CROSS_COMPILE`` is not used to prefix the Clang compiler binary, instead
> +``CROSS_COMPILE`` is used to set a command line flag: ``--target=<triple>``.
> +For example: ::
> +
> +	clang --target=aarch64-linux-gnu foo.c
> +
>  Omitting CROSS_COMPILE
>  ----------------------
>  
> @@ -71,7 +88,8 @@ As explained above, ``CROSS_COMPILE`` is used to set ``--target=<triple>``.
>  If ``CROSS_COMPILE`` is not specified, the ``--target=<triple>`` is inferred
>  from ``ARCH``.
>  
> -That means if you use only LLVM tools, ``CROSS_COMPILE`` becomes unnecessary.
> +That means if you use only LLVM tools via ``LLVM=1``, ``CROSS_COMPILE`` becomes
> +unnecessary.
>  
>  For example, to cross-compile the arm64 kernel::
>  
> @@ -88,13 +106,13 @@ Supported Architectures
>  LLVM does not target all of the architectures that Linux supports and
>  just because a target is supported in LLVM does not mean that the kernel
>  will build or work without any issues. Below is a general summary of
> -architectures that currently work with ``CC=clang`` or ``LLVM=1``. Level
> -of support corresponds to "S" values in the MAINTAINERS files. If an
> -architecture is not present, it either means that LLVM does not target
> -it or there are known issues. Using the latest stable version of LLVM or
> -even the development tree will generally yield the best results.
> -An architecture's ``defconfig`` is generally expected to work well,
> -certain configurations may have problems that have not been uncovered
> +architectures that currently work with ``LLVM=1`` but may need the integrated
> +assembler disabled via ``LLVM_IAS=0``. Level of support corresponds to "S"
> +values in the MAINTAINERS files. If an architecture is not present, it either
> +means that LLVM does not target it or there are known issues. Using the latest
> +stable version of LLVM or even the development tree will generally yield the
> +best results.  An architecture's ``defconfig`` is generally expected to work
> +well, certain configurations may have problems that have not been uncovered
>  yet. Bug reports are always welcome at the issue tracker below!
>  
>  .. list-table::
> @@ -112,16 +130,16 @@ yet. Bug reports are always welcome at the issue tracker below!
>       - ``LLVM=1``
>     * - mips
>       - Maintained
> -     - ``CC=clang``
> +     - ``LLVM=1``
>     * - powerpc
>       - Maintained
> -     - ``CC=clang``
> +     - ``LLVM=1``

Are we ready for this yet?

https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BARCH%5D+powerpc%22+label%3A%22%5BTOOL%5D+integrated-as%22

I think we could potentially say LLVM=1 LLVM_IAS=0 but pseries_defconfig
does not build with ld.lld:

https://github.com/ClangBuiltLinux/linux/issues/602

Maybe it is worth breaking up powerpc into powerpc32, powerpc64, and
powerpc64le?

>     * - riscv
>       - Maintained
> -     - ``CC=clang``
> +     - ``LLVM=1``
>     * - s390
>       - Maintained
> -     - ``CC=clang``
> +     - ``LLVM=1 LLVM_IAS=0``

I don't think s390 is ready for this claim. ld.lld and llvm-objcopy do
not support s390, which are both used in a defconfig build, as far as I
am aware.

https://github.com/ClangBuiltLinux/linux/issues/1524
https://github.com/ClangBuiltLinux/linux/issues/1530

>     * - x86
>       - Supported
>       - ``LLVM=1``
> 
> base-commit: c5d9ae265b105d9a67575fb67bd4650a6fc08e25
> -- 
> 2.35.1.265.g69c8d7142f-goog
> 

The rest of the changes look good to me.

Cheers,
Nathan
