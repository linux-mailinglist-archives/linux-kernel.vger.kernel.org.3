Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66149F571
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiA1Ij5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:39:57 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:37823 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiA1Ij4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:39:56 -0500
Received: by mail-vs1-f53.google.com with SMTP id v62so2132485vsv.4;
        Fri, 28 Jan 2022 00:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngAtlyrBVFbX3g/GOrsusL4Ps8Vz8+ZUnXuzFFZeu+o=;
        b=kWrcNx2fMON3G6OgkmC07cEYTeNJcrUymj93bzAV27TKZT6nzh7+3hau2QL7qnnv5J
         7UKYHhH3VD2VJPOE3gUr4O5g97HwVWjuc2xKwenlCgKNTAGq8DNvqkAwLFS95CMU/p3k
         lyUWk8OpxeWcrVrujF1ZKKhS0an1WhDOvpI0a+lGWQ2O/WNe1o1TG7ld+/Ag6YFDIT9D
         IYKohEBbwhECiZjkFw7N7uX4IDhxRWqca08TuyB/hGO1IY0EMW4ACgnGkZ3gnQjuePjJ
         XbkUojXCypoU9PzdZcsQ56M3xYyn6Qnvifc6s25jqGbwuvr5f3VlukR+O9oJFArxrGYI
         ColA==
X-Gm-Message-State: AOAM531FemVw2GYmplgdyIhTZxn1mTwF0z1aFS6ox9oT+85I3dceWPl/
        I9b804htBP/xUorfwmNcx+ot4vTRu6TFOcmP
X-Google-Smtp-Source: ABdhPJx9oW3PhmGc3s5U2Xtedep0gT6i9YiWDDED+q/i2Fg2tcQ1AxM8O6RNKTM3ktpPcufYTfjU4Q==
X-Received: by 2002:a67:c802:: with SMTP id u2mr3292720vsk.3.1643359195940;
        Fri, 28 Jan 2022 00:39:55 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id w3sm1306654vkd.5.2022.01.28.00.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 00:39:54 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id b2so2117523vso.9;
        Fri, 28 Jan 2022 00:39:53 -0800 (PST)
X-Received: by 2002:a67:5f83:: with SMTP id t125mr3295923vsb.68.1643359193361;
 Fri, 28 Jan 2022 00:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
 <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com> <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
 <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
 <CAMuHMdXq7OQJL6H7=JRnDTR6p+AD0o2Ctjn806XZQZ9PYjvepg@mail.gmail.com>
 <CAOnJCU+AVS5Js4ZXmUubTqwU5Ye-9_z8onEE1mwhvCsOXchFBg@mail.gmail.com>
 <CAMuHMdWsX-Pg3B1=KRf9hz1JrPAbydBrANTXg4q5CFJCqHJAoA@mail.gmail.com> <CAOnJCU+U0xmw-_yTEUo9ZXO5pvoJ6VCGu+jjU-Sa2MnhcAha6Q@mail.gmail.com>
In-Reply-To: <CAOnJCU+U0xmw-_yTEUo9ZXO5pvoJ6VCGu+jjU-Sa2MnhcAha6Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Jan 2022 09:39:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXLjjgD7j_5cm8qdL63m1SoB90O9j7YMYYrpXaH79hwJQ@mail.gmail.com>
Message-ID: <CAMuHMdXLjjgD7j_5cm8qdL63m1SoB90O9j7YMYYrpXaH79hwJQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
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

Hi Atish,

On Fri, Jan 28, 2022 at 1:13 AM Atish Patra <atishp@atishpatra.org> wrote:
> On Thu, Jan 27, 2022 at 12:48 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, Jan 27, 2022 at 2:02 AM Atish Patra <atishp@atishpatra.org> wrote:
>> > On Wed, Jan 26, 2022 at 1:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > > On Wed, Jan 26, 2022 at 9:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > > > On Wed, Jan 26, 2022 at 3:21 AM Atish Patra <atishp@atishpatra.org> wrote:
>> > > > > On Tue, Jan 25, 2022 at 2:26 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>> > > > > > On 20 Jan 2022, at 09:09, Atish Patra <atishp@rivosinc.com> wrote:
>> > > > > > > Currently, SBI APIs accept a hartmask that is generated from struct
>> > > > > > > cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
>> > > > > > > is not the correct data structure for hartids as it can be higher
>> > > > > > > than NR_CPUs for platforms with sparse or discontguous hartids.
>> > > > > > >
>> > > > > > > Remove all association between hartid mask and struct cpumask.
>> > > > > > >
>> > > > > > > Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V changes)
>> > > > > > > Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
>> > > > > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> > > >
>> > > > > I am yet to reproduce it on my end.
>> > > > > @Geert Uytterhoeven: can you please try the below diff on your end.
>> > > >
>> > > > Unfortunately it doesn't fix the issue for me.
>> > > >
>> > > > /me debugging...
>> > >
>> > > Found it: after this commit, the SBI_EXT_RFENCE_REMOTE_FENCE_I and
>> > > SBI_EXT_RFENCE_REMOTE_SFENCE_VMA ecalls are now called with
>> > > hmask = 0x8000000000000001 and hbase = 1 instead of hmask = 3 and
>> > > hbase = 0.
>> > >
>> > > cpuid 1 maps to  hartid 0
>> > > cpuid 0 maps to hartid 1
>> > >
>> > >     __sbi_rfence_v02:364: cpuid 1 hartid 0
>> > >     __sbi_rfence_v02:377: hartid 0 hbase 1
>> > >     hmask |= 1UL << (hartid - hbase);
>> > >
>> > > oops
>> > >
>> > >     __sbi_rfence_v02_call:303: SBI_EXT_RFENCE_REMOTE_FENCE_I hmask
>> > > 8000000000000001 hbase 1
>> > >
>> >
>> > Ahh yes. hmask will be incorrect if the bootcpu(cpu 0) is a higher
>> > hartid and it is trying to do a remote tlb flush/IPI
>> > to lower the hartid. We should generate the hartid array before the loop.
>> >
>> > Can you try this diff ? It seems to work for me during multiple boot
>> > cycle on the unleashed.
>> >
>> > You can find the patch here as well
>> > https://github.com/atishp04/linux/commits/v5.17-rc1

>> > @@ -345,13 +368,21 @@ static int __sbi_rfence_v02(int fid, const
>> > struct cpumask *cpu_mask,
>> >       unsigned long arg4, unsigned long arg5)
>> >  {
>> >   unsigned long hartid, cpuid, hmask = 0, hbase = 0;
>> > - int result;
>> > + int result, index = 0, max_index = 0;
>> > + unsigned long hartid_arr[NR_CPUS] = {0};
>>
>> That's up to 256 bytes on the stack. And more if the maximum
>> number of cores is increased.
>>
>
> Yeah. We can switch to dynamic allocation using kmalloc based on
> the number of bits set in the cpumask.

Even more overhead...

>> > - if (!cpu_mask)
>> > + if (!cpu_mask || cpumask_empty(cpu_mask))
>> >   cpu_mask = cpu_online_mask;
>> >
>> >   for_each_cpu(cpuid, cpu_mask) {
>> >   hartid = cpuid_to_hartid_map(cpuid);
>> > + hartid_arr[index] = hartid;
>> > + index++;
>> > + }
>> > + max_index = index;
>> > + sort(hartid_arr, max_index, sizeof(unsigned long), cmp_ulong, NULL);
>> > + for (index = 0; index < max_index; index++) {
>> > + hartid = hartid_arr[index];
>>
>> That looks expensive to me.
>>
>> What about shifting hmask and adjusting hbase if a hartid is
>> lower than the current hbase?
>
> That will probably work for current systems but it will fail when we have hartid > 64.
> The below logic as it assumes that the hartids are in order. We can have a situation
> where a two consecutive cpuid belong to hartids that require two invocations of sbi call
> because the number of harts exceeds BITS_PER_LONG.

If the number of harts exceeds BITS_PER_LONG, you always need multiple
calls, right?

I think the below (gmail-whitespace-damaged diff) should work:

--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -249,7 +249,7 @@ static void __sbi_set_timer_v02(uint64_t stime_value)

 static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
 {
-       unsigned long hartid, cpuid, hmask = 0, hbase = 0;
+       unsigned long hartid, cpuid, hmask = 0, hbase = 0, htop = 0;
        struct sbiret ret = {0};
        int result;

@@ -258,16 +258,27 @@ static int __sbi_send_ipi_v02(const struct
cpumask *cpu_mask)

        for_each_cpu(cpuid, cpu_mask) {
                hartid = cpuid_to_hartid_map(cpuid);
-               if (hmask &&
-                   (hartid < hbase || hartid >= hbase + BITS_PER_LONG)) {
-                       ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
-                                       hmask, hbase, 0, 0, 0, 0);
-                       if (ret.error)
-                               goto ecall_failed;
-                       hmask = 0;
+               if (hmask) {
+                       if (hartid + BITS_PER_LONG <= htop ||
+                           hartid >= hbase + BITS_PER_LONG) {
+                               ret = sbi_ecall(SBI_EXT_IPI,
+                                               SBI_EXT_IPI_SEND_IPI, hmask,
+                                               hbase, 0, 0, 0, 0);
+                               if (ret.error)
+                                       goto ecall_failed;
+                               hmask = 0;
+                       } else if (hartid < hbase) {
+                               /* shift the mask to fit lower hartid */
+                               hmask <<= hbase - hartid;
+                               hbase = hartid;
+                       }
                }
-               if (!hmask)
+               if (!hmask) {
                        hbase = hartid & -BITS_PER_LONG;
+                       htop = hartid;
+               } else if (hartid > htop) {
+                       htop = hartid;
+               }
                hmask |= 1UL << (hartid - hbase);
        }

@@ -344,7 +355,7 @@ static int __sbi_rfence_v02(int fid, const struct
cpumask *cpu_mask,
                            unsigned long start, unsigned long size,
                            unsigned long arg4, unsigned long arg5)
 {
-       unsigned long hartid, cpuid, hmask = 0, hbase = 0;
+       unsigned long hartid, cpuid, hmask = 0, hbase = 0, htop = 0;
        int result;

        if (!cpu_mask || cpumask_empty(cpu_mask))
@@ -352,16 +363,26 @@ static int __sbi_rfence_v02(int fid, const
struct cpumask *cpu_mask,

        for_each_cpu(cpuid, cpu_mask) {
                hartid = cpuid_to_hartid_map(cpuid);
-               if (hmask &&
-                   (hartid < hbase || hartid >= hbase + BITS_PER_LONG)) {
-                       result = __sbi_rfence_v02_call(fid, hmask, hbase,
-                                                      start, size, arg4, arg5);
-                       if (result)
-                               return result;
-                       hmask = 0;
+               if (hmask) {
+                       if (hartid + BITS_PER_LONG <= htop ||
+                           hartid >= hbase + BITS_PER_LONG) {
+                               result = __sbi_rfence_v02_call(fid, hmask,
+                                               hbase, start, size, arg4, arg5);
+                               if (result)
+                                       return result;
+                               hmask = 0;
+                       } else if (hartid < hbase) {
+                               /* shift the mask to fit lower hartid */
+                               hmask <<= hbase - hartid;
+                               hbase = hartid;
+                       }
+               }
+               if (!hmask) {
+                       hbase = hartid;
+                       htop = hartid;
+               } else if (hartid > htop) {
+                       htop = hartid;
                }
-               if (!hmask)
-                       hbase = hartid & -BITS_PER_LONG;
                hmask |= 1UL << (hartid - hbase);
        }

Another simpler solution would be to just round hbase down to a
multiple of 32/64 (gmail-whitespace-damaged diff):

--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -258,16 +258,16 @@ static int __sbi_send_ipi_v02(const struct
cpumask *cpu_mask)

        for_each_cpu(cpuid, cpu_mask) {
                hartid = cpuid_to_hartid_map(cpuid);
-               if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
+               if (hmask &&
+                   (hartid < hbase || hartid >= hbase + BITS_PER_LONG)) {
                        ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
                                        hmask, hbase, 0, 0, 0, 0);
                        if (ret.error)
                                goto ecall_failed;
                        hmask = 0;
-                       hbase = 0;
                }
                if (!hmask)
-                       hbase = hartid;
+                       hbase = hartid & -BITS_PER_LONG;
                hmask |= 1UL << (hartid - hbase);
        }

@@ -352,16 +352,16 @@ static int __sbi_rfence_v02(int fid, const
struct cpumask *cpu_mask,

        for_each_cpu(cpuid, cpu_mask) {
                hartid = cpuid_to_hartid_map(cpuid);
-               if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
+               if (hmask &&
+                   (hartid < hbase || hartid >= hbase + BITS_PER_LONG)) {
                        result = __sbi_rfence_v02_call(fid, hmask, hbase,
                                                       start, size, arg4, arg5);
                        if (result)
                                return result;
                        hmask = 0;
-                       hbase = 0;
                }
                if (!hmask)
-                       hbase = hartid;
+                       hbase = hartid & -BITS_PER_LONG;
                hmask |= 1UL << (hartid - hbase);
        }

But that means multiple SBI calls if you have e.g. hartids 1-64.
The shifted mask solution doesn't suffer from that.
Both solutions don't sort the CPUs, so they are suboptimal in case of
hartid numberings like 0, 64, 1, 65, ...

What do you think?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
