Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D286749DE90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiA0J4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:56:21 -0500
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:52966 "EHLO
        progateway7-pub.mail.pro1.eigbox.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238445AbiA0J4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:56:18 -0500
Received: from cmgw12.mail.unifiedlayer.com (unknown [10.0.90.127])
        by progateway7.mail.pro1.eigbox.com (Postfix) with ESMTP id 125D810048704
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:56:16 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id D1Vnn7WjXXOyfD1Vnn5SEr; Thu, 27 Jan 2022 09:56:16 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=Ot6Kdwzt c=1 sm=1 tr=0 ts=61f26c40
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=DghFqjY3_ZEA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=tBb2bbeoAAAA:8
 a=eFWqtd3rAAAA:8 a=j6bprNooAAAA:8 a=h0uksLzaAAAA:8 a=W-_n0kkjAAAA:8
 a=NEAV23lmAAAA:8 a=HaFmDPmJAAAA:8 a=05S-CNwmhPcMlrApu-0A:9
 a=QEXdDO2ut3YA:10:nop_charset_2 a=NWVoK91CQyQA:10:nop_rescan
 a=Oj-tNtZlA1e06AYgeCfH:22 a=OmE4rGSwGH90ucjH_eFs:22 a=fS_Hu1hw59wj44055X5l:22
 a=MSi_79tMYmZZG2gvAgS0:22 a=qeNa2pbTr82C0GpJEZFS:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gZaw0aENOxZlikybDyc9C3E+mc4RSN0avqmBxmCVeRI=; b=DzG1SetqSB6t6h/87HCitFhpOj
        7Lr6oFiMS4XICOmummWrL2RY8wcbLSJk7odpoDngEWRLbwAjtF+mSIDOmFkT/hI5qJLmBrC37qs40
        4JcCfSI34je+PZh+Hj3zHB5tm;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:51794 helo=[10.0.1.23])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <re@w6rz.net>)
        id 1nD1Vm-003JVr-R2; Thu, 27 Jan 2022 02:56:14 -0700
Message-ID: <e865941f-8394-2a0a-3831-ab40714ab494@w6rz.net>
Date:   Thu, 27 Jan 2022 01:56:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
Content-Language: en-US
To:     Atish Patra <atishp@atishpatra.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
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
References: <20220120090918.2646626-1-atishp@rivosinc.com>
 <20220120090918.2646626-7-atishp@rivosinc.com>
 <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com>
 <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
 <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
 <CAMuHMdXq7OQJL6H7=JRnDTR6p+AD0o2Ctjn806XZQZ9PYjvepg@mail.gmail.com>
 <CAOnJCU+AVS5Js4ZXmUubTqwU5Ye-9_z8onEE1mwhvCsOXchFBg@mail.gmail.com>
From:   Ron Economos <re@w6rz.net>
In-Reply-To: <CAOnJCU+AVS5Js4ZXmUubTqwU5Ye-9_z8onEE1mwhvCsOXchFBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1nD1Vm-003JVr-R2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.23]) [73.162.232.9]:51794
X-Source-Auth: re@w6rz.net
X-Email-Count: 11
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 17:01, Atish Patra wrote:
> On Wed, Jan 26, 2022 at 1:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Hi Atish,
>>
>> On Wed, Jan 26, 2022 at 9:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> On Wed, Jan 26, 2022 at 3:21 AM Atish Patra <atishp@atishpatra.org> wrote:
>>>> On Tue, Jan 25, 2022 at 2:26 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>>>>> On 20 Jan 2022, at 09:09, Atish Patra <atishp@rivosinc.com> wrote:
>>>>>> Currently, SBI APIs accept a hartmask that is generated from struct
>>>>>> cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
>>>>>> is not the correct data structure for hartids as it can be higher
>>>>>> than NR_CPUs for platforms with sparse or discontguous hartids.
>>>>>>
>>>>>> Remove all association between hartid mask and struct cpumask.
>>>>>>
>>>>>> Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V changes)
>>>>>> Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
>>>>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>>> I am yet to reproduce it on my end.
>>>> @Geert Uytterhoeven: can you please try the below diff on your end.
>>> Unfortunately it doesn't fix the issue for me.
>>>
>>> /me debugging...
>> Found it: after this commit, the SBI_EXT_RFENCE_REMOTE_FENCE_I and
>> SBI_EXT_RFENCE_REMOTE_SFENCE_VMA ecalls are now called with
>> hmask = 0x8000000000000001 and hbase = 1 instead of hmask = 3 and
>> hbase = 0.
>>
>> cpuid 1 maps to  hartid 0
>> cpuid 0 maps to hartid 1
>>
>>      __sbi_rfence_v02:364: cpuid 1 hartid 0
>>      __sbi_rfence_v02:377: hartid 0 hbase 1
>>      hmask |= 1UL << (hartid - hbase);
>>
>> oops
>>
>>      __sbi_rfence_v02_call:303: SBI_EXT_RFENCE_REMOTE_FENCE_I hmask
>> 8000000000000001 hbase 1
>>
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
>   #include <linux/init.h>
>   #include <linux/pm.h>
>   #include <linux/reboot.h>
> +#include <linux/sort.h>
> +
>   #include <asm/sbi.h>
>   #include <asm/smp.h>
>
> @@ -85,7 +87,7 @@ static unsigned long
> __sbi_v01_cpumask_to_hartmask(const struct cpumask *cpu_mas
>    pr_warn("Unable to send any request to hartid > BITS_PER_LONG for
> SBI v0.1\n");
>    break;
>    }
> - hmask |= 1 << hartid;
> + hmask |= 1UL << hartid;
>    }
>
>    return hmask;
> @@ -160,7 +162,7 @@ static int __sbi_send_ipi_v01(const struct cpumask
> *cpu_mask)
>   {
>    unsigned long hart_mask;
>
> - if (!cpu_mask)
> + if (!cpu_mask || cpumask_empty(cpu_mask))
>    cpu_mask = cpu_online_mask;
>    hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
>
> @@ -176,7 +178,7 @@ static int __sbi_rfence_v01(int fid, const struct
> cpumask *cpu_mask,
>    int result = 0;
>    unsigned long hart_mask;
>
> - if (!cpu_mask)
> + if (!cpu_mask || cpumask_empty(cpu_mask))
>    cpu_mask = cpu_online_mask;
>    hart_mask = __sbi_v01_cpumask_to_hartmask(cpu_mask);
>
> @@ -236,6 +238,18 @@ static int __sbi_rfence_v01(int fid, const struct
> cpumask *cpu_mask,
>   static void sbi_set_power_off(void) {}
>   #endif /* CONFIG_RISCV_SBI_V01 */
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
>   static void __sbi_set_timer_v02(uint64_t stime_value)
>   {
>   #if __riscv_xlen == 32
> @@ -251,13 +265,22 @@ static int __sbi_send_ipi_v02(const struct
> cpumask *cpu_mask)
>   {
>    unsigned long hartid, cpuid, hmask = 0, hbase = 0;
>    struct sbiret ret = {0};
> - int result;
> + int result, index = 0, max_index = 0;
> + unsigned long hartid_arr[NR_CPUS] = {0};
>
> - if (!cpu_mask)
> + if (!cpu_mask || cpumask_empty(cpu_mask))
>    cpu_mask = cpu_online_mask;
>
>    for_each_cpu(cpuid, cpu_mask) {
>    hartid = cpuid_to_hartid_map(cpuid);
> + hartid_arr[index] = hartid;
> + index++;
> + }
> +
> + max_index = index;
> + sort(hartid_arr, max_index, sizeof(unsigned long), cmp_ulong, NULL);
> + for (index = 0; index < max_index; index++) {
> + hartid = hartid_arr[index];
>    if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
>    ret = sbi_ecall(SBI_EXT_IPI, SBI_EXT_IPI_SEND_IPI,
>    hmask, hbase, 0, 0, 0, 0);
> @@ -345,13 +368,21 @@ static int __sbi_rfence_v02(int fid, const
> struct cpumask *cpu_mask,
>        unsigned long arg4, unsigned long arg5)
>   {
>    unsigned long hartid, cpuid, hmask = 0, hbase = 0;
> - int result;
> + int result, index = 0, max_index = 0;
> + unsigned long hartid_arr[NR_CPUS] = {0};
>
> - if (!cpu_mask)
> + if (!cpu_mask || cpumask_empty(cpu_mask))
>    cpu_mask = cpu_online_mask;
>
>    for_each_cpu(cpuid, cpu_mask) {
>    hartid = cpuid_to_hartid_map(cpuid);
> + hartid_arr[index] = hartid;
> + index++;
> + }
> + max_index = index;
> + sort(hartid_arr, max_index, sizeof(unsigned long), cmp_ulong, NULL);
> + for (index = 0; index < max_index; index++) {
> + hartid = hartid_arr[index];
>    if (hmask && ((hbase + BITS_PER_LONG) <= hartid)) {
>    result = __sbi_rfence_v02_call(fid, hmask, hbase,
>           start, size, arg4, arg5);
>
> --------------------------------------------------------------------------------------------------------------------------------

Works good here. No systemd segfaults on Unmatched.

Tested-by: Ron Economos <re@w6rz.net>

