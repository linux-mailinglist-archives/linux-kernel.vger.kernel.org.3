Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA654A5141
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379706AbiAaVRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiAaVRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:17:06 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49ACC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:17:05 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id j2so31386879ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oE1YmZoSx/nWIRjEIBPwgNw6U3IPmomCkQFroxME2e0=;
        b=V+ftJE9mj5wwBvEQpQsLqauQoF0wWGdfdpcMkv8T2la3XBRSFMcv8w8dnnHhnUaCB5
         3ojC0xP6TrnU27Sc2qKY4DbqCNKiJrm4jW/GehbOx12GBIY+WMMpO8S26rJFRe624VfR
         7BH45NDDgnlxdDynfnrKUg6PdwT1TAckp6R5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oE1YmZoSx/nWIRjEIBPwgNw6U3IPmomCkQFroxME2e0=;
        b=QbkxAQRIKx4V+v0O4nFrEZbYNwqqNO9EH75OKt5z8GFePDCMP9JYmmGmUsaADLxLi/
         RwED/LhLtVpWm82KOxIUvX4J8z+EGSRwf2q+M5D1E4aLOzGK8edUz+Sh8XUpyR/gfr03
         OTvGDfAOP1RZ3EeR7EAZ2qn5G3EoW4uPubZOXXA6yUqOZRCdkNl9kUd+QreplR8fv8sj
         sXwyuxNklyXQxc4dEB12If/wVkkSHw8ehtpNxlY8llVeG86H9o9Ai3QIC+CwsDp/B8S4
         d8Ox1DHhl27DOS7ICWT5CfHsjmKrS3m2Qwb9c5bCefKXphjlpmcUIJvvKcvjhQp8Wfc4
         pn3w==
X-Gm-Message-State: AOAM531d2vr5O/Fd5iSnn3uStT2KFawsqk7macfasZeoh53cGI9ArymA
        tt3MQrNDlQ8pM6nwSPV3BwHUAZqlihKC6J/6kDzHMjSUI0x4
X-Google-Smtp-Source: ABdhPJyobHoVTaYvZPuG5ukRPdncvn3ScCVvPWllSJaJ3m2s7Px6ynK2uGfLdn+Yx1gIy4RJSQxM+49wTVK18fahP6Y=
X-Received: by 2002:a5b:44:: with SMTP id e4mr33205228ybp.713.1643663824956;
 Mon, 31 Jan 2022 13:17:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643635156.git.geert@linux-m68k.org> <35936f19a9727b14e4fdb7f5fadfabfa29d53d96.1643635156.git.geert@linux-m68k.org>
In-Reply-To: <35936f19a9727b14e4fdb7f5fadfabfa29d53d96.1643635156.git.geert@linux-m68k.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 31 Jan 2022 13:16:54 -0800
Message-ID: <CAOnJCUKXOMgn=RmMDGBSS_Zy4J4Ng7EHwWnS5PnRKPTntDHk0Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] RISC-V: Fix handling of empty cpu masks
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 5:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> The cpumask rework slightly changed the behavior of the code.  Fix this
> by treating an empty cpumask as meaning all online CPUs.
>
> Extracted from a patch by Atish Patra <atishp@rivosinc.com>.
>
> Reported-by: Jessica Clarke <jrtc27@jrtc27.com>
> Fixes: 26fb751ca37846c9 ("RISC-V: Do not use cpumask data structure for hartid bitmap")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/riscv/kernel/sbi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index f93bc75f2bc43c8e..22444cfcd56cc646 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -161,7 +161,7 @@ static int __sbi_send_ipi_v01(const struct cpumask *cpu_mask)
>  {
>         unsigned long hart_mask;
>
> -       if (!cpu_mask)
> +       if (!cpu_mask || cpumask_empty(cpu_mask))
>                 cpu_mask = cpu_online_mask;
>         hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
>
> @@ -177,7 +177,7 @@ static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
>         int result = 0;
>         unsigned long hart_mask;
>
> -       if (!cpu_mask)
> +       if (!cpu_mask || cpumask_empty(cpu_mask))
>                 cpu_mask = cpu_online_mask;
>         hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
>
> @@ -254,7 +254,7 @@ static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
>         struct sbiret ret = {0};
>         int result;
>
> -       if (!cpu_mask)
> +       if (!cpu_mask || cpumask_empty(cpu_mask))
>                 cpu_mask = cpu_online_mask;
>
>         for_each_cpu(cpuid, cpu_mask) {
> @@ -348,7 +348,7 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>         unsigned long hartid, cpuid, hmask = 0, hbase = 0;
>         int result;
>
> -       if (!cpu_mask)
> +       if (!cpu_mask || cpumask_empty(cpu_mask))
>                 cpu_mask = cpu_online_mask;
>
>         for_each_cpu(cpuid, cpu_mask) {
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atishp@rivosinc.com>


-- 
Regards,
Atish
