Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19534A651C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiBATnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBATnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:43:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A72C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:43:12 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu18so36053871lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zz0Xmt+zBtk7CUu8XqSyog1XhQotf3FMA2GYjydlfL0=;
        b=Htw1wDOLdqMNCyrnaaITsbOvlAbxwjaEwcX4XYqlgm3Z1LbJ3RYWnOO2iaVRV9G1DI
         jpWXX/sIE5H39nMTY5p0razkshDoBz/F6McO6YAl4cwVeBGrzqrKxlpCylg0X1daUYGM
         pN1+7jnIfqpzP1w/68gLZUxAYx6q5/epW6c8ZzbqTYLBdgBSYEuSIbf4RTYvtgOQqKhn
         6hVoaVpvltyP6VYnAqlza4uDqz2I8UVPlLlizImeDbsYw9ZdcKTRrWPMDYiVd4LnvIfl
         bLMUat+d1svMKOEcMMktaoHDYaIAxYouw3HK/LdxvxHdRjoGqvxMk1UmJZ5DI4v2Q+k6
         /e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zz0Xmt+zBtk7CUu8XqSyog1XhQotf3FMA2GYjydlfL0=;
        b=qyVFDeLWtmTk7/l6oHSmnzgxViZZmVI6idJZgL6ntqp+6b4otMMb9gstxQpofbaT8I
         U5zGDhCRt/pJyrG5cZllg80WnKq/EexLV2fWcJUG4ukYwKUbsgNJzmok6jS8Xvmzw1QM
         UzwiQcD1N/WbSKyut3mUmhckdOuVksR91F5NJ1Y2YToX38lVIJrcxxVL5U+SQRmDMc/r
         a88caGzpiXCtfaapTALXTPJOJwQYNA1v+KcG1BHvXVa7VdBw9p8cUcm0EWyckaR4cBlK
         7GMej/J7FnDPPC+8uHxoemsEEBwd3lnYbDRsD4RwwndxE2M4bvurmTNn6SnttoHpgqs3
         ErGw==
X-Gm-Message-State: AOAM532QX6NUNPStNmj37vXlBm+aCCn00S/pjUnecc6Bj9vTUCGkvx7m
        MtjOInMb1v5vVPDdacgXCH/FZw3AT1AcFFiSVs94NQ==
X-Google-Smtp-Source: ABdhPJzBJdDca+G7ILqunsKdkfH03kHFBWuIxCxfb5qUaZqVHDaeZa+DmsszEC1qJYB5VVzT0+wAjJ7b2e5N+kgFJto=
X-Received: by 2002:a05:6512:3ba5:: with SMTP id g37mr20511313lfv.651.1643744591095;
 Tue, 01 Feb 2022 11:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20220201013257.17926-1-changbin.du@gmail.com>
In-Reply-To: <20220201013257.17926-1-changbin.du@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Feb 2022 11:42:59 -0800
Message-ID: <CAKwvOd=fCCjSfz6tW3514ifZOMw2PT4AZiFExq1qqG1rxf5fEg@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: ignore all local labels prefixed by '.L'
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 5:33 PM Changbin Du <changbin.du@gmail.com> wrote:

Make sure to mark the version of your patches (this is v2, IIUC). `git
format-patch -v2 HEAD~`

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> The llvm compiler can generate lots of local labels ('.LBB', '.Ltmpxxx',
> '.L__unnamed_xx', etc.). These symbols usually are useless for debugging.
> And they might overlap with handwritten symbols.
>
> Before this change, a dumpstack shows a local symbol for epc:
> [    0.040341][    T0] Hardware name: riscv-virtio,qemu (DT)
> [    0.040376][    T0] epc : .LBB6_14+0x22/0x6a
> [    0.040452][    T0]  ra : restore_all+0x12/0x6e
>
> The simple solution is that we can ignore all local labels prefixed by '.L'.
> For handwritten symbols which need to be preserved should drop the '.L'
> prefix.
>
> After this change, the C defined symbol is shown so we can locate the
> problematical code immediately:
> [    0.035795][    T0] Hardware name: riscv-virtio,qemu (DT)
> [    0.036332][    T0] epc : trace_hardirqs_on+0x54/0x13c
> [    0.036567][    T0]  ra : restore_all+0x12/0x6e
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  scripts/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 54ad86d13784..8caabddf817c 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -108,7 +108,7 @@ static bool is_ignored_symbol(const char *name, char type)
>         /* Symbol names that begin with the following are ignored.*/
>         static const char * const ignored_prefixes[] = {
>                 "$",                    /* local symbols for ARM, MIPS, etc. */
> -               ".LASANPC",             /* s390 kasan local symbols */
> +               ".L",                   /* local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
>                 "__crc_",               /* modversions */
>                 "__efistub_",           /* arm64 EFI stub namespace */
>                 "__kvm_nvhe_",          /* arm64 non-VHE KVM namespace */
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
