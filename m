Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EF84A514A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380041AbiAaVSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241083AbiAaVSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:18:31 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CF8C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:18:31 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c19so15832835ybf.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLrElREa9gDRrr3UXLFE3XuFDh6Kk9U69RG+VXKvGAY=;
        b=cK2gP/SNjAb/GGapc6aQslme4aLhccD5fifPcCE+Agf31/qOs58VZKrnIp3VBfGR0S
         pJCWjuso04ZRB+4ANK51tw64K1/528UomxxCxRvxJu0wR3lsJniHSM64V/Y+o3gopKaK
         WlRavGpcYXSbJpc1wxUgXicxidTT0CLR6Ms48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLrElREa9gDRrr3UXLFE3XuFDh6Kk9U69RG+VXKvGAY=;
        b=ljObTvxUgJLkzsOzI3oXrwUp/iwSfbZiYyZZJukC8dCfVvrbmu9iC38W413yVXPkjW
         rNfysKaThrXFEqTdA7fb4XiYBw9eBCt9ipGSJpiPOgd/NuXqiAHTf+JIIysiCZElFjt/
         W3JbigZb5BpOR0mt5CDNlwBiLwxnVUBYJ2mV6Myk78LzTNr8B9dTsF3uqw2zyZJFJ1Xj
         jgw2BKVu1xA/ZB4UBuafaPKyKF4iEuhf5chR3ZoEqjh+tXad78hLvFntTtVtWnVagRIB
         o0U2XRDqQsgDVQV+bn3N2rYQwgwnC2XtdA0ZBHhDYP314HhLv0ONSZVVXOCKICf+x4me
         ZGcg==
X-Gm-Message-State: AOAM532atrKEemhVRI1C368u2hHitFngfZJ7wooDWnGe20nBogpbywq5
        0k1ph9ULcLITqTQj7hzs+ylCSX/dvYuiYS65Pz3V
X-Google-Smtp-Source: ABdhPJxbbjH8EQvopZaSQLElFVMM94MroU6dmol4AZX5EYJ8t8s1wvX8PYVHbf8mXK3Z7I3vcl885DKJiCimKgMkttU=
X-Received: by 2002:a25:bd08:: with SMTP id f8mr24421228ybk.121.1643663910806;
 Mon, 31 Jan 2022 13:18:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643635156.git.geert@linux-m68k.org> <a45b0242160d97b312c64baec4f45d9f666cbed8.1643635156.git.geert@linux-m68k.org>
In-Reply-To: <a45b0242160d97b312c64baec4f45d9f666cbed8.1643635156.git.geert@linux-m68k.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 31 Jan 2022 13:18:20 -0800
Message-ID: <CAOnJCUJuOxNZvUQ0-Bg5STr=OzkqaS729RQevmQyfDMXNLG8ag@mail.gmail.com>
Subject: Re: [PATCH 3/3] RISC-V: Fix IPI/RFENCE hmask on non-monotonic hartid ordering
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
> If the boot CPU does not have the lowest hartid, "hartid - hbase" can
> become negative, leading to an incorrect hmask, causing userspace to
> crash with SEGV.  This is observed on e.g. Starlight Beta, where cpuid 1
> maps to hartid 0, and cpuid 0 maps to hartid 1.
>
> Fix this by detecting this case, and shifting the accumulated mask and
> updating hbase, if possible.
>
> Fixes: 26fb751ca37846c9 ("RISC-V: Do not use cpumask data structure for hartid bitmap")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/riscv/kernel/sbi.c | 57 ++++++++++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 22444cfcd56cc646..775d3322b422fe14 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -250,7 +250,7 @@ static void __sbi_set_timer_v02(uint64_t stime_value)
>
>  static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
>  {
> -       unsigned long hartid, cpuid, hmask = 0, hbase = 0;
> +       unsigned long hartid, cpuid, hmask = 0, hbase = 0, htop = 0;
>         struct sbiret ret = {0};
>         int result;
>
> @@ -259,16 +259,27 @@ static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
>
>         for_each_cpu(cpuid, cpu_mask) {
>                 hartid = cpuid_to_hartid_map(cpuid);
> -               if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
> -                       ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
> -                                       hmask, hbase, 0, 0, 0, 0);
> -                       if (ret.error)
> -                               goto ecall_failed;
> -                       hmask = 0;
> -                       hbase = 0;
> +               if (hmask) {
> +                       if (hartid + BITS_PER_LONG <= htop ||
> +                           hbase + BITS_PER_LONG <= hartid) {
> +                               ret = sbi_ecall(SBI_EXT_IPI,
> +                                               SBI_EXT_IPI_SEND_IPI, hmask,
> +                                               hbase, 0, 0, 0, 0);
> +                               if (ret.error)
> +                                       goto ecall_failed;
> +                               hmask = 0;
> +                       } else if (hartid < hbase) {
> +                               /* shift the mask to fit lower hartid */
> +                               hmask <<= hbase - hartid;
> +                               hbase = hartid;
> +                       }
>                 }
> -               if (!hmask)
> +               if (!hmask) {
>                         hbase = hartid;
> +                       htop = hartid;
> +               } else if (hartid > htop) {
> +                       htop = hartid;
> +               }
>                 hmask |= BIT(hartid - hbase);
>         }
>
> @@ -345,7 +356,7 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>                             unsigned long start, unsigned long size,
>                             unsigned long arg4, unsigned long arg5)
>  {
> -       unsigned long hartid, cpuid, hmask = 0, hbase = 0;
> +       unsigned long hartid, cpuid, hmask = 0, hbase = 0, htop = 0;
>         int result;
>
>         if (!cpu_mask || cpumask_empty(cpu_mask))
> @@ -353,16 +364,26 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
>
>         for_each_cpu(cpuid, cpu_mask) {
>                 hartid = cpuid_to_hartid_map(cpuid);
> -               if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
> -                       result = __sbi_rfence_v02_call(fid, hmask, hbase,
> -                                                      start, size, arg4, arg5);
> -                       if (result)
> -                               return result;
> -                       hmask = 0;
> -                       hbase = 0;
> +               if (hmask) {
> +                       if (hartid + BITS_PER_LONG <= htop ||
> +                           hbase + BITS_PER_LONG <= hartid) {
> +                               result = __sbi_rfence_v02_call(fid, hmask,
> +                                               hbase, start, size, arg4, arg5);
> +                               if (result)
> +                                       return result;
> +                               hmask = 0;
> +                       } else if (hartid < hbase) {
> +                               /* shift the mask to fit lower hartid */
> +                               hmask <<= hbase - hartid;
> +                               hbase = hartid;
> +                       }
>                 }
> -               if (!hmask)
> +               if (!hmask) {
>                         hbase = hartid;
> +                       htop = hartid;
> +               } else if (hartid > htop) {
> +                       htop = hartid;
> +               }
>                 hmask |= BIT(hartid - hbase);
>         }
>
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atishp@rivosinc.com>
Tested-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
