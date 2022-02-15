Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF084B67DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiBOJld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:41:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiBOJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:41:31 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCB0E4D07
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:41:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p9so10520333wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1wflCr1vStMilehgvIe0w5v3TJPtXNP/omwaXqFnbs=;
        b=X2ztBi1BvP5dZxfZSWhpEp86yS7NH+aFVQUGt8uylxVUHrTPgLxljm/I823I20QDAC
         myDO9b6pKdhXfxOflamUH9a0V56xRHIzRt+zobHm2aSQI9lX2AtyVbvDJ4b/hbAVMJwj
         O9vb1GNkZY2UcPTCqfIbCX+8y2sqNQNjI5x14V4+FrxOupZqMwREoOU7tUaRNhVammTS
         15HBCcV5/vHuri9+ncnfWaytYpmQXGl85VY7/QOaHfZV4ygqrf/US1M/Trp4pBEdNttY
         GmI4NuNrS9A1UQGLBpSYyXFp+7ZES8mph1JTwI5jnuKmU+GSd5GjMsnzQcXxqbHmEldG
         KnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1wflCr1vStMilehgvIe0w5v3TJPtXNP/omwaXqFnbs=;
        b=wyD84+PsfYNWD0W/tR42mRoHQZSL7LljoTMx6ynZHqCeX6SEEAJQTpaCH0n0M2VvEl
         SOMGB0mU7rjvIDVezYzQrnXj5ZTYCj2O0TYG5a5PX2OgKSzr/FZyDosYJePigWKBuj7W
         fJGrLtcJ3YALYCGZI4hvKHQ3jiRbRoYDf6Dfl5A2y40m4XHHluJuyP81uVLmPCfh5gsH
         ViOnWTDjM8sObQB12eV2g0DsFHAoCjZSdSHV+fNAIBddviIt8MxWxKq1Lkxmf4zOeujo
         2n7ixxNBcktEAIMhIoKnifpgRO6WqFFffuHn3XURc72YMyzFF/EUg6jq2LjRbC/VBhGf
         UG5g==
X-Gm-Message-State: AOAM531F7EpZDc7BAUqxbx46TpdWPtH3mHMAnarqCYXGm3DrCGEdo3IO
        KIOL0NRecM6ACiKBxqkVWCE3m9sUd4c+9wccl+g/vQ==
X-Google-Smtp-Source: ABdhPJycaBm0tTnyxaAYB2jLzb26nfkOtUFXqf8v+zAItEOizp7OLUjLiobN4Bd6P0OekZnQ3wsTWbSu3Eh+8hJtkd0=
X-Received: by 2002:a5d:4209:: with SMTP id n9mr2515369wrq.86.1644918078895;
 Tue, 15 Feb 2022 01:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20220215090211.911366-1-atishp@rivosinc.com> <20220215090211.911366-2-atishp@rivosinc.com>
In-Reply-To: <20220215090211.911366-2-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 15 Feb 2022 15:11:06 +0530
Message-ID: <CAAhSdy0+K+ADhO0oSoW7QUF582UvbaUbNPyAcBs5RMhUsm91Rw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] RISC-V: Correctly print supported extensions
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 2:32 PM Atish Patra <atishp@rivosinc.com> wrote:
>
> From: Tsukasa OI <research_trasio@irq.a4lg.com>
>
> This commit replaces BITS_PER_LONG with number of alphabet letters.
>
> Current ISA pretty-printing code expects extension 'a' (bit 0) through
> 'z' (bit 25).  Although bit 26 and higher is not currently used (thus never
> cause an issue in practice), it will be an annoying problem if we start to
> use those in the future.
>
> This commit disables printing high bits for now.
>
> Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/cpufeature.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index d959d207a40d..dd3d57eb4eea 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -13,6 +13,8 @@
>  #include <asm/smp.h>
>  #include <asm/switch_to.h>
>
> +#define NUM_ALPHA_EXTS ('z' - 'a' + 1)
> +
>  unsigned long elf_hwcap __read_mostly;
>
>  /* Host ISA bitmap */
> @@ -63,7 +65,7 @@ void __init riscv_fill_hwcap(void)
>  {
>         struct device_node *node;
>         const char *isa;
> -       char print_str[BITS_PER_LONG + 1];
> +       char print_str[NUM_ALPHA_EXTS + 1];
>         size_t i, j, isa_len;
>         static unsigned long isa2hwcap[256] = {0};
>
> @@ -133,13 +135,13 @@ void __init riscv_fill_hwcap(void)
>         }
>
>         memset(print_str, 0, sizeof(print_str));
> -       for (i = 0, j = 0; i < BITS_PER_LONG; i++)
> +       for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
>                 if (riscv_isa[0] & BIT_MASK(i))
>                         print_str[j++] = (char)('a' + i);
>         pr_info("riscv: ISA extensions %s\n", print_str);
>
>         memset(print_str, 0, sizeof(print_str));
> -       for (i = 0, j = 0; i < BITS_PER_LONG; i++)
> +       for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
>                 if (elf_hwcap & BIT_MASK(i))
>                         print_str[j++] = (char)('a' + i);
>         pr_info("riscv: ELF capabilities %s\n", print_str);
> --
> 2.30.2
>
