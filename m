Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F5254C245
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbiFOG5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245022AbiFOG5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:57:31 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90BD2B3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:57:28 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id y79so11712659iof.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGV/RSsW48AsjZJ+T8kv/eAUlGEm+TRsUG4lDlbmsqk=;
        b=Wr/xhbSFHpBhBKCQGohU7Ir6zyEXL0eaEIWJX4v8AKd25OP0py5J3erENj4JwsrdQ1
         2N9fcgU+gQUK8vvGYldetvPljG6M06F4OhMk0pD2ysayVqXo7I7bJwMo6X5mdKVSX7M1
         q7DHQMc9MTCxsxpwHW2DpcM47vlIUJ7FgOfvcxN/OTVdoOXPWp9QmTbnhK74lKrfB0Uf
         ILBLFbMB3la/TRFCUo/05z7Jl0ypRUfpSiipbPG3etUHitCONvc6P0VDh3yDNkzAJgdY
         noGTcSwLkazWeCN1kHgq4CHNea9FOH7LGIhzX6Hi04jUeTAYM2lQf7U08pwbk7uQj/DM
         mHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGV/RSsW48AsjZJ+T8kv/eAUlGEm+TRsUG4lDlbmsqk=;
        b=Y5QgL0927SF9+9eRUBcDgLsNK7m+5Ya24tN37JR+awZumfkppcxoZ30g7dYeFPQAXS
         M3goWc3onTh/8XWTDbvrJlZNPL1zRjokFhKbvfDGfEDrgnvbRGY7ixBQhqE4aCK470bN
         f0DC1HDAkqw1wD9IQPMm9jdy3SCALsDCS8PoTBOd2EvbiITtWEM/MV4zl43n/SAJ7O0U
         2ckeKJrJI8DK0jAhQDSnhAAR9LBI9/gCvhDClUjvg91FU+wTnc77NMIJHq9F1pQl07EU
         Wqk6SGaosXbkmTZ8DCfPNtsvbOLNiB5KCM0DhUP0QgdwGzY9M+a5TW+3q+39Nj7i3ZG5
         CWyA==
X-Gm-Message-State: AOAM531qJnmnhY7iHi7yWL8NxVp7PmUszskwXFEqi2rRuBuvLcwwop8N
        tBNd3/fLlEst7o6HCPb300pAPrwLg8HTKjt78CtJ/w==
X-Google-Smtp-Source: ABdhPJyD8OR4h38SidSmMjVnbp/1um7vqn55L2cNg0aXga03dACeaaVjTPV0GQtOovoASGMW8rvehTIk/csjpfkv2Dw=
X-Received: by 2002:a02:3448:0:b0:331:84bb:d66b with SMTP id
 z8-20020a023448000000b0033184bbd66bmr4893378jaz.292.1655276247855; Tue, 14
 Jun 2022 23:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <1655275079-17651-1-git-send-email-yangtiezhu@loongson.cn> <1655275079-17651-3-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1655275079-17651-3-git-send-email-yangtiezhu@loongson.cn>
From:   hev <r@hev.cc>
Date:   Wed, 15 Jun 2022 14:57:17 +0800
Message-ID: <CAHirt9g+0N6hJAf-xRrss-FRXiix4jE9=CGZC6+BDHO3dBunsg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] LoongArch: No need to call RESTORE_ALL_AND_RET
 for all syscalls
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 15, 2022 at 2:38 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> In handle_syscall, it is unnecessary to call RESTORE_ALL_AND_RET
> for all syscalls.
>
> (1) If syscall number is __NR_clone and __NR_clone3,
>     call RESTORE_STATIC_SOME_SP_AND_RET.
> (2) If syscall number is __NR_rt_sigreturn and __NR_rt_sigsuspend,
>     call RESTORE_TEMP_SOME_SP_AND_RET.
> (3) The other syscalls call RESTORE_SOME_SP_AND_RET.
>
> With this patch, it can reduce many load instructions.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/include/asm/stackframe.h | 17 +++++++++++++++++
>  arch/loongarch/kernel/entry.S           | 24 +++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
> index 4ca9530..52649a5f 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -216,4 +216,21 @@
>         RESTORE_SP_AND_RET \docfi
>         .endm
>
> +       .macro  RESTORE_SOME_SP_AND_RET docfi=0
> +       RESTORE_SOME \docfi
> +       RESTORE_SP_AND_RET \docfi
> +       .endm
> +
> +       .macro  RESTORE_STATIC_SOME_SP_AND_RET docfi=0
> +       RESTORE_STATIC \docfi
> +       RESTORE_SOME \docfi
> +       RESTORE_SP_AND_RET \docfi
> +       .endm
> +
> +       .macro  RESTORE_TEMP_SOME_SP_AND_RET docfi=0
> +       RESTORE_TEMP \docfi
> +       RESTORE_SOME \docfi
> +       RESTORE_SP_AND_RET \docfi
> +       .endm
> +
>  #endif /* _ASM_STACKFRAME_H */
> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
> index 53ce2cb..58fe507 100644
> --- a/arch/loongarch/kernel/entry.S
> +++ b/arch/loongarch/kernel/entry.S
> @@ -79,7 +79,29 @@ SYM_FUNC_START(handle_syscall)
>         move    a0, sp
>         bl      do_syscall
>
> -       RESTORE_ALL_AND_RET
> +       /*
> +        * Syscall number held in a7 which is stored in PT_R11.
> +        * If syscall number is __NR_clone and __NR_clone3,
> +        * call RESTORE_STATIC_SOME_SP_AND_RET.
> +        * If syscall number is __NR_rt_sigreturn and __NR_rt_sigsuspend,
> +        * call RESTORE_TEMP_SOME_SP_AND_RET.
> +        * The other syscalls call RESTORE_SOME_SP_AND_RET.
> +        */
> +       cfi_ld  t3, PT_R11

I think PT_R11 may be overwritten by the signal handler and the
syscall number is now lost.

> +       li.w    t4, __NR_clone
> +       beq     t3, t4, 3f
> +       li.w    t4, __NR_clone3
> +       beq     t3, t4, 3f
> +       li.w    t4, __NR_rt_sigreturn
> +       beq     t3, t4, 4f
> +       li.w    t4, __NR_rt_sigsuspend
> +       beq     t3, t4, 4f
> +
> +       RESTORE_SOME_SP_AND_RET
> +3:
> +       RESTORE_STATIC_SOME_SP_AND_RET
> +4:
> +       RESTORE_TEMP_SOME_SP_AND_RET
>  SYM_FUNC_END(handle_syscall)
>
>  SYM_CODE_START(ret_from_fork)
> --
> 2.1.0
>

Best regards,
hev
