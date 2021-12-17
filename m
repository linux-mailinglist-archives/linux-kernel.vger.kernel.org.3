Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6B6478C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhLQNqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhLQNqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:46:02 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1B8C061574;
        Fri, 17 Dec 2021 05:46:02 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id 15so1656236ilq.2;
        Fri, 17 Dec 2021 05:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=qgrS7E3XcHULU38AeYS0xaGxT73tcnKL3TyYG3y9bqg=;
        b=AjgEcYcYzS/Y0zJiLkYbI8OQ3xtN2kU8UMjn4pL8IBMjr5giVKImFN38yAphQEWl1s
         w4ZwNF5nK53TawZCO3PfAwFPjzFkQCvb4vW7GD/Z89VJt2FgI2kHJXHmEMrsZ2iFPuTC
         PiP7jvRcfL87jAQ6eawnMYTpkaGdZAtUaWeOgujdmL+g9SFMU4YxP3ad86SFeDJep0cN
         v6WTHiB/3zfzJ/vZjSeQ4IarLUBfk/Hx85KQHOzXRcfukqanNiBW53D6578qtSO5BiTS
         s9WthGa0TAk+vBDffjfXqPZ7BrPdjkgFrV0qi31IBLVSqos2jLuPEJTR07NEaQzUXcjI
         IyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qgrS7E3XcHULU38AeYS0xaGxT73tcnKL3TyYG3y9bqg=;
        b=iZfsVS6VwTjiWoWPTzTt5mYUDotUCX+/17FkDVcTaovgTgOwoD/9D6almrMscoaDPr
         3q7oRZ/pKbnVKJpRWiRQylfGEmNKEdmZQaNhG0pbbBD1iEOU9xNxkyFSyC2QqQlvNdCg
         Sl/I99Vufy7KSqqH9YoWpWuvE7OiT5B+nfPCSvIx0c2PpZnmBNsoUTw5grMZQ+DW8kTM
         y8wFlpw1pRdjTsqjkgZk0uG01BCupC6lKkbaAQe2lhqzDGY9Yqssx8Qn0CkX4hsTzTfc
         egMdhIDlWtljxiYObmDapilPtJDUqPQb469YOEXruzR9eIJN/ug4rYotIY3Z6rOSRNHd
         /K/Q==
X-Gm-Message-State: AOAM530YqZ/fmF7yb2CR1m2zsRILYN+2PXIh+UxGhYWJFSOr3RQ0sgZi
        UyBSfvrGT5I7DdfEH4W3myr3Wkqi8BErAwMoW5M=
X-Google-Smtp-Source: ABdhPJy1MmQ+5IWglVnvLfoOYwlga+ZOFvXoxLDo1e1fWucF4PdPYNbSlZy6qJ0ahti+hIsBRaxhJhMltupU1JSeDOM=
X-Received: by 2002:a05:6e02:1889:: with SMTP id o9mr1599950ilu.4.1639748761970;
 Fri, 17 Dec 2021 05:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20211124153105.155739-1-alex_y_xu.ref@yahoo.ca> <20211124153105.155739-1-alex_y_xu@yahoo.ca>
In-Reply-To: <20211124153105.155739-1-alex_y_xu@yahoo.ca>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Dec 2021 14:45:25 +0100
Message-ID: <CA+icZUWKPG_iaeSiE0Xb3Z2+F4NxPG-Kg=pdLkaCPFkJ6Fo3OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: use perl instead of shell to get file size
To:     alex_y_xu@yahoo.ca
Cc:     Michael Forney <forney@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 4:30 PM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> This makes it easier to get the size of multiple files. Perl is already
> a requirement for all builds to do header checks, so this is not an
> additional dependency.

$ egrep -B1 -A4 'file-size.pl' build-log_5.15.9-1-amd64-clang13-lto.txt
49219-+ clang -nostdinc -I./arch/x86/include
-I./arch/x86/include/generated -I./include -I./arch/x86/include/uapi
-I./arch/x86/include/generated/uapi -I./include/uapi
-I./include/generated/uapi -include ./include/linux/compiler-version.h
-include ./include/linux/kconfig.h -D__KERNEL__ -Qunused-arguments
-fmacro-prefix-map=./= -D__AS
SEMBLY__ -fno-PIE --target=x86_64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-m64 -DCC_USING_NOP_MCOUNT -DCC_USING_
FENTRY -fno-lto -c -o .tmp_vmlinux.kallsyms2.o .tmp_vmlinux.kallsyms2.S
49220:+ perl ./scripts/file-size.pl .tmp_vmlinux.kallsyms1.o
49221-+ size1=1932072
49222:+ perl ./scripts/file-size.pl .tmp_vmlinux.kallsyms2.o
49223-+ size2=1932072
49224-+ [ 1932072 -ne 1932072 ]
49225-+ [ -n  ]
49226-+ vmlinux_link vmlinux .tmp_vmlinux.kallsyms2.o .btf.vmlinux.bin.o

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
>  arch/arm/boot/deflate_xip_data.sh | 2 +-
>  arch/powerpc/boot/wrapper         | 2 +-
>  scripts/Makefile.lib              | 9 ++-------
>  scripts/file-size.pl              | 8 ++++++++
>  scripts/file-size.sh              | 4 ----
>  scripts/link-vmlinux.sh           | 4 ++--
>  6 files changed, 14 insertions(+), 15 deletions(-)
>  create mode 100755 scripts/file-size.pl
>  delete mode 100755 scripts/file-size.sh
>
> diff --git a/arch/arm/boot/deflate_xip_data.sh b/arch/arm/boot/deflate_xip_data.sh
> index 304495c3c2c5..14cfa2babb93 100755
> --- a/arch/arm/boot/deflate_xip_data.sh
> +++ b/arch/arm/boot/deflate_xip_data.sh
> @@ -43,7 +43,7 @@ data_start=$(($__data_loc - $base_offset))
>  data_end=$(($_edata_loc - $base_offset))
>
>  # Make sure data occupies the last part of the file.
> -file_end=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" "$XIPIMAGE")
> +file_end=$(${PERL} "${srctree}/scripts/file-size.pl" "$XIPIMAGE")
>  if [ "$file_end" != "$data_end" ]; then
>         printf "end of xipImage doesn't match with _edata_loc (%#x vs %#x)\n" \
>                $(($file_end + $base_offset)) $_edata_loc 1>&2
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 9184eda780fd..9f9ee8613432 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -380,7 +380,7 @@ vmz="$tmpdir/`basename \"$kernel\"`.$ext"
>
>  # Calculate the vmlinux.strip size
>  ${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
> -strip_size=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" "$vmz.$$")
> +strip_size=$(${PERL} "${srctree}/scripts/file-size.pl" "$vmz.$$")
>
>  if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel" ]; then
>      # recompress the image if we need to
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index d1f865b8c0cb..ca901814986a 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -379,13 +379,8 @@ dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
>
>  # Bzip2 and LZMA do not include size in file... so we have to fake that;
>  # append the size as a 32-bit littleendian number as gzip does.
> -size_append = printf $(shell                                           \
> -dec_size=0;                                                            \
> -for F in $(real-prereqs); do                                   \
> -       fsize=$$($(CONFIG_SHELL) $(srctree)/scripts/file-size.sh $$F);  \
> -       dec_size=$$(expr $$dec_size + $$fsize);                         \
> -done;                                                                  \
> -printf "%08x\n" $$dec_size |                                           \
> +total_size = $(shell $(PERL) $(srctree)/scripts/file-size.pl $(real-prereqs))
> +size_append = printf $(shell printf "%08x\n" $(total_size) |           \
>         sed 's/\(..\)/\1 /g' | {                                        \
>                 read ch0 ch1 ch2 ch3;                                   \
>                 for ch in $$ch3 $$ch2 $$ch1 $$ch0; do                   \
> diff --git a/scripts/file-size.pl b/scripts/file-size.pl
> new file mode 100755
> index 000000000000..170bb6d048fa
> --- /dev/null
> +++ b/scripts/file-size.pl
> @@ -0,0 +1,8 @@
> +#!/usr/bin/perl -w
> +# SPDX-License-Identifier: GPL-2.0
> +my $total = 0;
> +foreach (@ARGV) {
> +    @stat = stat $_ or die "$_: $!";
> +    $total += $stat[7];
> +}
> +print "$total\n";
> diff --git a/scripts/file-size.sh b/scripts/file-size.sh
> deleted file mode 100755
> index 7eb7423416b5..000000000000
> --- a/scripts/file-size.sh
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -set -- $(ls -dn "$1")
> -printf '%s\n' "$5"
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 5cdd9bc5c385..c3fa38bd18ab 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -384,8 +384,8 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
>         kallsyms_step 2
>
>         # step 3
> -       size1=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso_prev})
> -       size2=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
> +       size1=$(${PERL} "${srctree}/scripts/file-size.pl" ${kallsymso_prev})
> +       size2=$(${PERL} "${srctree}/scripts/file-size.pl" ${kallsymso})
>
>         if [ $size1 -ne $size2 ] || [ -n "${KALLSYMS_EXTRA_PASS}" ]; then
>                 kallsyms_step 3
> --
> 2.34.0
>
