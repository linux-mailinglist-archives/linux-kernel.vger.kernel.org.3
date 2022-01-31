Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67EA4A3EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbiAaIfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiAaIfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:35:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3089C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 00:35:16 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e2so23887196wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 00:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i63MXT8FfcAJ6NKG0kmSh3EqNn5Sgi3xKtTOMUOf0b8=;
        b=8BTsbIb/tYnrYst6bOnHmle4MB6tOwZdVXAd/HEobWHHPPyMmFCq8Xrtcnwt1G3PJG
         naXw6vhziX8PMyZ26p5O5cB3/eGYaNbJpouhWc8DjCukDk31EaIK9QJIsN5aWqLuFjfU
         T6qH7fRLmUAAUHGRYAMvlHJ/A+rP+hHuC0i59J9PteKh34T/LST9QHtMGrzsO0bPfRje
         Ena36cjlZa0mreR6Bdi+w5AUqi2qXJCsJO+puzx8Po3wfZSR855SBBws0ZOtFyvteI3c
         Mud5Kntpu+4c8VHwP9WZxrSB2elGHSgZN/vIT34j+O0I5mNik9rewhQ92qOxaT9fBYuk
         j7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i63MXT8FfcAJ6NKG0kmSh3EqNn5Sgi3xKtTOMUOf0b8=;
        b=7jODICHZmtNpp+u5209W1RRDVGc++cszoA2DzuW306Uruv7+pr7rCJAcMGlQ1fb+3d
         q4L+XDLIgQvrtU94Y/Ue2pCu9Z9UevP6lYQrJ0EETVAiGzdBhPjoxhiwMeyZNJQAOov3
         w3U5UVbmIg6jfIAKbmBOn10s9bsy2xdV2h+AfT6JlOAJBecOqZXiYIVNB5f5lxQNrMfM
         o3XPTZ9fNP1MrlqONIlibqNHLzdembyGqipn/EknKNw8ykkVrmU1N2Dpy7xQBkQGiPsl
         1BQaLXn1qU5fANoLmrrw/CrWr5ALRSG8+pvXQ22BVtDQsJZCwVVRz+bzONI1aI2aM7/h
         QCCg==
X-Gm-Message-State: AOAM532N3F6aoIrhyeMPFWQwUMmNODRv15uE9NN8EuKCdkC6Y9nDA2hJ
        dVDtcR9LwfDBeFaHH8Qk9rml06796hciRljEs4GTYw==
X-Google-Smtp-Source: ABdhPJxZjDSjPhM8Aa28/VdMsIxXGIdE93x88AbHsBquCCnQFmYELzxLajhwCebr5aBSerDS8NXN8gSyPXz2bweM/PE=
X-Received: by 2002:a05:6000:387:: with SMTP id u7mr16640039wrf.214.1643618115301;
 Mon, 31 Jan 2022 00:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
 <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com> <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
 <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
 <CAMuHMdXq7OQJL6H7=JRnDTR6p+AD0o2Ctjn806XZQZ9PYjvepg@mail.gmail.com> <CAOnJCU+AVS5Js4ZXmUubTqwU5Ye-9_z8onEE1mwhvCsOXchFBg@mail.gmail.com>
In-Reply-To: <CAOnJCU+AVS5Js4ZXmUubTqwU5Ye-9_z8onEE1mwhvCsOXchFBg@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 31 Jan 2022 14:05:03 +0530
Message-ID: <CAAhSdy2jy87ZBY6zh00EQwzG5wX59EfUeN-Kc92O7VQJmxZboQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 6:32 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Jan 26, 2022 at 1:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Atish,
> >
> > On Wed, Jan 26, 2022 at 9:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Jan 26, 2022 at 3:21 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > > On Tue, Jan 25, 2022 at 2:26 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> > > > > On 20 Jan 2022, at 09:09, Atish Patra <atishp@rivosinc.com> wrote:
> > > > > > Currently, SBI APIs accept a hartmask that is generated from struct
> > > > > > cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
> > > > > > is not the correct data structure for hartids as it can be higher
> > > > > > than NR_CPUs for platforms with sparse or discontguous hartids.
> > > > > >
> > > > > > Remove all association between hartid mask and struct cpumask.
> > > > > >
> > > > > > Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V changes)
> > > > > > Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
> > > > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > >
> > > > I am yet to reproduce it on my end.
> > > > @Geert Uytterhoeven: can you please try the below diff on your end.
> > >
> > > Unfortunately it doesn't fix the issue for me.
> > >
> > > /me debugging...
> >
> > Found it: after this commit, the SBI_EXT_RFENCE_REMOTE_FENCE_I and
> > SBI_EXT_RFENCE_REMOTE_SFENCE_VMA ecalls are now called with
> > hmask = 0x8000000000000001 and hbase = 1 instead of hmask = 3 and
> > hbase = 0.
> >
> > cpuid 1 maps to  hartid 0
> > cpuid 0 maps to hartid 1
> >
> >     __sbi_rfence_v02:364: cpuid 1 hartid 0
> >     __sbi_rfence_v02:377: hartid 0 hbase 1
> >     hmask |= 1UL << (hartid - hbase);
> >
> > oops
> >
> >     __sbi_rfence_v02_call:303: SBI_EXT_RFENCE_REMOTE_FENCE_I hmask
> > 8000000000000001 hbase 1
> >
>
> Ahh yes. hmask will be incorrect if the bootcpu(cpu 0) is a higher
> hartid and it is trying to do a remote tlb flush/IPI
> to lower the hartid. We should generate the hartid array before the loop.
>
> Can you try this diff ? It seems to work for me during multiple boot
> cycle on the unleashed.
>
> You can find the patch here as well
> https://github.com/atishp04/linux/commits/v5.17-rc1
>
> --------------------------------------------------------------------------------------------------------------------------------
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index f72527fcb347..4ebeb5813edc 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -8,6 +8,8 @@
>  #include <linux/init.h>
>  #include <linux/pm.h>
>  #include <linux/reboot.h>
> +#include <linux/sort.h>
> +
>  #include <asm/sbi.h>
>  #include <asm/smp.h>
>
> @@ -85,7 +87,7 @@ static unsigned long
> __sbi_v01_cpumask_to_hartmask(const struct cpumask *cpu_mas
>   pr_warn("Unable to send any request to hartid > BITS_PER_LONG for
> SBI v0.1\n");
>   break;
>   }
> - hmask |= 1 << hartid;
> + hmask |= 1UL << hartid;
>   }
>
>   return hmask;
> @@ -160,7 +162,7 @@ static int __sbi_send_ipi_v01(const struct cpumask
> *cpu_mask)
>  {
>   unsigned long hart_mask;
>
> - if (!cpu_mask)
> + if (!cpu_mask || cpumask_empty(cpu_mask))
>   cpu_mask = cpu_online_mask;
>   hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
>
> @@ -176,7 +178,7 @@ static int __sbi_rfence_v01(int fid, const struct
> cpumask *cpu_mask,
>   int result = 0;
>   unsigned long hart_mask;
>
> - if (!cpu_mask)
> + if (!cpu_mask || cpumask_empty(cpu_mask))
>   cpu_mask = cpu_online_mask;
>   hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
>
> @@ -236,6 +238,18 @@ static int __sbi_rfence_v01(int fid, const struct
> cpumask *cpu_mask,
>  static void sbi_set_power_off(void) {}
>  #endif /* CONFIG_RISCV_SBI_V01 */
>
> +static int cmp_ulong(const void *A, const void *B)
> +{
> + const unsigned long *a = A, *b = B;
> +
> + if (*a < *b)
> + return -1;
> + else if (*a > *b)
> + return 1;
> + else
> + return 0;
> +}
> +
>  static void __sbi_set_timer_v02(uint64_t stime_value)
>  {
>  #if __riscv_xlen == 32
> @@ -251,13 +265,22 @@ static int __sbi_send_ipi_v02(const struct
> cpumask *cpu_mask)
>  {
>   unsigned long hartid, cpuid, hmask = 0, hbase = 0;
>   struct sbiret ret = {0};
> - int result;
> + int result, index = 0, max_index = 0;
> + unsigned long hartid_arr[NR_CPUS] = {0};

No need to clear the hartid_arr[] because you have "index" and
"max_index" telling us number of enteries.

>
> - if (!cpu_mask)
> + if (!cpu_mask || cpumask_empty(cpu_mask))
>   cpu_mask = cpu_online_mask;
>
>   for_each_cpu(cpuid, cpu_mask) {
>   hartid = cpuid_to_hartid_map(cpuid);
> + hartid_arr[index] = hartid;

You can create a sorted array on the fly instead of calling sort()

> + index++;
> + }
> +
> + max_index = index;
> + sort(hartid_arr, max_index, sizeof(unsigned long), cmp_ulong, NULL);
> + for (index = 0; index < max_index; index++) {
> + hartid = hartid_arr[index];
>   if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
>   ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
>   hmask, hbase, 0, 0, 0, 0);
> @@ -345,13 +368,21 @@ static int __sbi_rfence_v02(int fid, const
> struct cpumask *cpu_mask,
>       unsigned long arg4, unsigned long arg5)
>  {
>   unsigned long hartid, cpuid, hmask = 0, hbase = 0;
> - int result;
> + int result, index = 0, max_index = 0;
> + unsigned long hartid_arr[NR_CPUS] = {0};
>
> - if (!cpu_mask)
> + if (!cpu_mask || cpumask_empty(cpu_mask))
>   cpu_mask = cpu_online_mask;
>
>   for_each_cpu(cpuid, cpu_mask) {
>   hartid = cpuid_to_hartid_map(cpuid);
> + hartid_arr[index] = hartid;
> + index++;
> + }
> + max_index = index;
> + sort(hartid_arr, max_index, sizeof(unsigned long), cmp_ulong, NULL);
> + for (index = 0; index < max_index; index++) {
> + hartid = hartid_arr[index];
>   if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
>   result = __sbi_rfence_v02_call(fid, hmask, hbase,
>          start, size, arg4, arg5);
>
> --------------------------------------------------------------------------------------------------------------------------------
>
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
>
>
>
> --
> Regards,
> Atish

My main concern is the sizeof hartid_arr[] on stack. Using kmalloc()
will only further slow it down.

Further, for small systems with fewer HARTs, this sorting
business will be a unnecessary overhead.

Regards,
Anup
