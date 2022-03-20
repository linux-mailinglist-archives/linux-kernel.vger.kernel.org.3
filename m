Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB334E1B09
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 11:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiCTKfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 06:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbiCTKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 06:35:00 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768C2DD4D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:33:37 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 6CDB47E324
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647772416;
        bh=QhuOmEY/VCeKijDg6b0RqGpMGFruSC64r7vq9XAIaXI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BQVnZb1w9D5dwRtB8M9TO2yLt7M523VaFfJlntG020Xalbco6fhUJmzqoGH89yD2D
         yM/V/Dx6gXZ7CTzQRAu+jrfPWQuY9AUMQy7gbBjkz0K9ShwtkDZ2W4hRJ/yCbuZI0p
         iVfsTl3dYRyrSffFgX7sgYukQCqaVgPTma/TjcEStRK6JlL6w+qUYVvQadauXrkBkF
         Fu225SKpr8AJp7aejyf8UsDLEozo/Y2sZeaNAZfO1DTp0WGywMcCkriJ0cIgWCAIqO
         /lBFws3jnIdz+3/n6iTuWJZnVDhYfRles4YHHy1DS9yR/ChZHMJXNZr+ljuCXY+QVX
         Ffn6UjRkhnt+w==
Received: by mail-lj1-f169.google.com with SMTP id c15so16503559ljr.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:33:36 -0700 (PDT)
X-Gm-Message-State: AOAM532YeIrxiWbnPyrDVDxnvBX2TpX+xQBAsF/EFmrzDc4nUzP3Curk
        HWjArvG2SMUDRSp5c6+JNzvS16Ek+pVOR99y5l8=
X-Google-Smtp-Source: ABdhPJyikNNLLQCOkm2lKTku53utKCCvq/M1FiM18dqV50ZW8CdKHuyn/tKlkl1mSTXdy1umxy7NaqfoVFctZgPKcGI=
X-Received: by 2002:a2e:2d11:0:b0:246:3c3e:d544 with SMTP id
 t17-20020a2e2d11000000b002463c3ed544mr11789581ljt.518.1647772414468; Sun, 20
 Mar 2022 03:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org> <20220320093750.159991-4-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220320093750.159991-4-ammarfaizi2@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Sun, 20 Mar 2022 17:33:23 +0700
X-Gmail-Original-Message-ID: <CAOG64qO5b30GjyYxoRj9QLJpfaa-o40W1oYL0XuZ8C5QX17bww@mail.gmail.com>
Message-ID: <CAOG64qO5b30GjyYxoRj9QLJpfaa-o40W1oYL0XuZ8C5QX17bww@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/6] tools/nolibc: i386: Implement syscall with 6 arguments
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>, x86@kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 4:37 PM Ammar Faizi wrote:
> In i386, the 6th argument of syscall goes in %ebp. However, both Clang
> and GCC cannot use %ebp in the clobber list and in the "r" constraint
> without using -fomit-frame-pointer. To make it always available for any
> kind of compilation, the below workaround is implemented.
>
> For clang (the Assembly statement can't clobber %ebp):
>   1) Save the %ebp value to the redzone area -4(%esp).
>   2) Load the 6-th argument from memory to %ebp.
>   3) Subtract the %esp by 4.
>   4) Do the syscall (int $0x80).
>   5) Pop %ebp.

I don't think you can safely use redzone from inline Assembly. The
compiler may also use redzone for a leaf function. In case the syscall
is done at the same time, your %ebp saving will clobber the redzone
that the compiler uses.

> For GCC, fortunately it has a #pragma that can force a specific function
> to be compiled with -fomit-frame-pointer, so it can always use "r"(var)
> where `var` is a variable bound to %ebp.
>
> Cc: x86@kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
[...]
> +#if defined(__clang__)
> +static inline long ____do_syscall6(long eax, long ebx, long ecx, long edx,
> +                                  long esi, long edi, long ebp)
> +{
> +       __asm__ volatile (
> +               "movl   %%ebp, -4(%%esp)\n\t"
> +               "movl   %[arg6], %%ebp\n\t"
> +               "subl   $4, %%esp\n\t"
> +               "int    $0x80\n\t"
> +               "popl   %%ebp\n\t"
> +               : "=a"(eax)
> +               : "a"(eax), "b"(ebx), "c"(ecx), "d"(edx), "S"(esi), "D"(edi),
> +                 [arg6]"m"(ebp)
> +               : "memory", "cc"
> +       );
> +       return eax;
> +}
> +

-4(%esp) may be used by the compiler on a leaf call, you can't clobber that.

-- Viro
