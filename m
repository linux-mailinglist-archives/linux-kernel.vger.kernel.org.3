Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3149DEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbiA0KRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:17:31 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:48350 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiA0KRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:17:30 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4JkxNL2R2pz1qxH2;
        Thu, 27 Jan 2022 11:17:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4JkxNL0XLCz1qqkB;
        Thu, 27 Jan 2022 11:17:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id tCDRGupXv8VQ; Thu, 27 Jan 2022 11:17:20 +0100 (CET)
X-Auth-Info: RfvJpsA84gliY7mSCZZqmbcpg6JZ542+98dB4R6X6KFoCqBa8BX5Iua3nl62Uv9n
Received: from igel.home (ppp-46-244-180-78.dynamic.mnet-online.de [46.244.180.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Jan 2022 11:17:20 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 8F3EA2C36D2; Thu, 27 Jan 2022 11:17:19 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
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
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
References: <20220120090918.2646626-1-atishp@rivosinc.com>
        <20220120090918.2646626-7-atishp@rivosinc.com>
        <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com>
        <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
        <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
        <CAMuHMdXq7OQJL6H7=JRnDTR6p+AD0o2Ctjn806XZQZ9PYjvepg@mail.gmail.com>
        <CAOnJCU+AVS5Js4ZXmUubTqwU5Ye-9_z8onEE1mwhvCsOXchFBg@mail.gmail.com>
        <CAMuHMdWsX-Pg3B1=KRf9hz1JrPAbydBrANTXg4q5CFJCqHJAoA@mail.gmail.com>
        <CAMuHMdXyjSrXNCAO8V8pajXW5ts29p==p2J1HnPPoo3-8osKbA@mail.gmail.com>
X-Yow:  Isn't this my STOP?!
Date:   Thu, 27 Jan 2022 11:17:19 +0100
In-Reply-To: <CAMuHMdXyjSrXNCAO8V8pajXW5ts29p==p2J1HnPPoo3-8osKbA@mail.gmail.com>
        (Geert Uytterhoeven's message of "Thu, 27 Jan 2022 11:03:08 +0100")
Message-ID: <87o83xtrdc.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 27 2022, Geert Uytterhoeven wrote:

> Hi Atish,
>
> On Thu, Jan 27, 2022 at 9:48 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, Jan 27, 2022 at 2:02 AM Atish Patra <atishp@atishpatra.org> wrote:
>  > Ahh yes. hmask will be incorrect if the bootcpu(cpu 0) is a higher
>> > hartid and it is trying to do a remote tlb flush/IPI
>> > to lower the hartid. We should generate the hartid array before the loop.
>> >
>> > Can you try this diff ? It seems to work for me during multiple boot
>> > cycle on the unleashed.
>> >
>> > You can find the patch here as well
>> > https://github.com/atishp04/linux/commits/v5.17-rc1
>>
>> Thanks, that fixes the issue for me.
>>
>> > --- a/arch/riscv/kernel/sbi.c
>> > +++ b/arch/riscv/kernel/sbi.c
>
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
>
> I.e. 4 KiB with the proposed increase to 256 CPUs, as mentioned in

And those 4K need to be cleared each time the function is called, even
if there is only a small number of cpus.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
