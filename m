Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D524F9AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiDHQkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiDHQkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:40:39 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1480125293
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:38:34 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AAA483F6C5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1649435911;
        bh=nXDQ4+U1y/1X02pstYtY+T5JvuMLQteVX86AoZ8nbyo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Ea5rKWqeJYuQlrS9SPPOxKNaFTkTIbK9zEk3YrgPouP4HBHoU/CvhxogNQ6Fk9Cfy
         EIar2E/rPfMaJLBhhqNYjBtnVsZepFT/+F9hoqEFNxttnnifS/AKkaaTC9fxj6nN8G
         eaizLTLbbjwhLXcMieqaKKrayR4CSj/bnFrEmwIfxcq+Kg4GsB32r8JPmiEAf1XtUq
         9n2AJxzFjv6TjP/ZmmW/Vv7z5IOBh7zSPE/lUvKx1C8AK/f2WDrOxtoXX56MFMjGPh
         aabkAo/9Xepqy44FMNos8u49/h47lDE0MuUnnE5wN7TuEced4gFlQnSLZgTNBumk34
         KYRXfVNKKqJFA==
Received: by mail-ej1-f71.google.com with SMTP id qw30-20020a1709066a1e00b006e7f3de1be3so5148128ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 09:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nXDQ4+U1y/1X02pstYtY+T5JvuMLQteVX86AoZ8nbyo=;
        b=FRr44MGD5/wNfMfi9YeSCPIROferr3ul1joFgL3FNh0ZJ2hMl1+TsX6gZJOtBCrkxu
         CcNnchAryDeg5/wfpdpXvUfxZstdutJpI6EK3m2O2Y1p00RydA2uGNrY7gmBhVF94wAP
         9piNnnrRs8v7fax/d3fBNnL7+62M5zd/F5wRNvfkmurFJw6vjj9vSVvQcE3bAiCyik+l
         oH9GyUxhJ0QF3zuzfsTKmhOKSQslynKOu3iHfV38yTPIntUxDHKVveu015aOOM9RtRi9
         uY3AZq+fS91X0raYDWOLWXVK5Scwn4umoBSXGe8ymTZY47ERVgrzRy8CFjHYG5qVcg3/
         o1ZA==
X-Gm-Message-State: AOAM533z7w0oqL5nh+sLm6eBRlyRg7vza22AYM9qOM8TWhpKmpi/EqLe
        BkOAV6R3djLJYUipGenpJOxwM9TZ7ni6qVfPyUQ5qX0jMIeKZwGI2b9X66u56TLE6yaBJfZ2d7x
        gREWMqhLOgmME0L+EETpQEOgt/weeqN+Tm4+zSzt3Sw==
X-Received: by 2002:aa7:d0cc:0:b0:41c:b59c:c461 with SMTP id u12-20020aa7d0cc000000b0041cb59cc461mr20537331edo.285.1649435911336;
        Fri, 08 Apr 2022 09:38:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAVaEvhpVIrCHh76h8+cLSClNVU5W13TGQsrrGkmSI818f1L0PAMUi5goJ9tKQiVf9unxrsw==
X-Received: by 2002:aa7:d0cc:0:b0:41c:b59c:c461 with SMTP id u12-20020aa7d0cc000000b0041cb59cc461mr20537306edo.285.1649435911072;
        Fri, 08 Apr 2022 09:38:31 -0700 (PDT)
Received: from [192.168.123.67] (ip-088-152-144-107.um26.pools.vodafone-ip.de. [88.152.144.107])
        by smtp.gmail.com with ESMTPSA id gk15-20020a17090790cf00b006e843ce7996sm1215659ejb.153.2022.04.08.09.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 09:38:30 -0700 (PDT)
Message-ID: <b907f6c8-968b-7e1e-bc83-1d54c7e0b448@canonical.com>
Date:   Fri, 8 Apr 2022 18:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] RISC-V: Increase range and default value of NR_CPUS
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <mhng-9cbb2a46-8bcb-4bfe-b927-0ed469dbd3a6@palmer-mbp2014>
 <cd8d6641-4a29-7deb-49ae-a80baab0344f@canonical.com>
 <CAK9=C2Xh_DQ3ybj7nAE-LNrSc9sPy0H8jq_FU09io+wE_yypRg@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAK9=C2Xh_DQ3ybj7nAE-LNrSc9sPy0H8jq_FU09io+wE_yypRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 12:10, Anup Patel wrote:
> On Wed, Apr 6, 2022 at 3:25 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 3/31/22 21:42, Palmer Dabbelt wrote:
>>> On Sat, 19 Mar 2022 05:12:06 PDT (-0700), apatel@ventanamicro.com wrote:
>>>> Currently, the range and default value of NR_CPUS is too restrictive
>>>> for high-end RISC-V systems with large number of HARTs. The latest
>>>> QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
>>>> restrictive for QEMU as well. Other major architectures (such as
>>>> ARM64, x86_64, MIPS, etc) have a much higher range and default
>>>> value of NR_CPUS.
>>>>
>>>> This patch increases NR_CPUS range to 2-512 and default value to
>>>> XLEN (i.e. 32 for RV32 and 64 for RV64).
>>>>
>>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>>> ---
>>>> Changes since v1:
>>>>   - Updated NR_CPUS range to 2-512 which reflects maximum number of
>>>>     CPUs supported by QEMU virt machine.
>>>> ---
>>>>   arch/riscv/Kconfig | 7 ++++---
>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>>> index 5adcbd9b5e88..423ac17f598c 100644
>>>> --- a/arch/riscv/Kconfig
>>>> +++ b/arch/riscv/Kconfig
>>>> @@ -274,10 +274,11 @@ config SMP
>>>>         If you don't know what to do here, say N.
>>>>
>>>>   config NR_CPUS
>>>> -    int "Maximum number of CPUs (2-32)"
>>>> -    range 2 32
>>>> +    int "Maximum number of CPUs (2-512)"
>>>> +    range 2 512
>>
>> For SBI_V01=y there seems to be a hard constraint to XLEN bits.
>> See __sbi_v01_cpumask_to_hartmask() in rch/riscv/kernel/sbi.c.
>>
>> So shouldn't this be something like:
>>
>> range 2 512 !SBI_V01
>> range 2 32 SBI_V01 && 32BIT
>> range 2 64 SBI_V01 && 64BIT
> 
> This is just making it unnecessarily complicated for supporting
> SBI v0.1
> 
> How about removing SBI v0.1 support and the spin-wait CPU
> operations from arch/riscv ?

The SBI v0.1 specification was only a draft. Only the v1.0 version has 
ever been ratified.

It would be good to remove this legacy code from Linux and U-Boot.

By the way, why does upstream OpenSBI claim to be conformant to SBI v0.3 
and not to v1.0?

include/sbi/sbi_ecall.h:16:

#define SBI_ECALL_VERSION_MAJOR 0
#define SBI_ECALL_VERSION_MINOR 3

Best regards

Heinrich

> 
>>
>>>>       depends on SMP
>>>> -    default "8"
>>>> +    default "32" if 32BIT
>>>> +    default "64" if 64BIT
>>>>
>>>>   config HOTPLUG_CPU
>>>>       bool "Support for hot-pluggable CPUs"
>>>
>>> I'm getting all sorts of boot issues with more than 32 CPUs, even on the
>>> latest QEMU master.  I'm not opposed to increasing the CPU count in
>>> theory, but if we're going to have a setting that goes up to a huge
>>> number it needs to at least boot.  I've got 64 host threads, so it
>>> shouldn't just be a scheduling thing.
>>
>> Currently high performing hardware for RISC-V is missing. So it makes
>> sense to build software via QEMU on x86_64 or arm64 with as many
>> hardware threads as available (128 is not uncommon).
>>
>> OpenSBI currently is limited to 128 threads:
>> include/sbi/sbi_hartmask.h:22:
>> #define SBI_HARTMASK_MAX_BITS 128
>> This is just an arbitrary value we can be modified.
> 
> Yes, this limit will be gradually increased with some improvements
> to optimize runtime memory used by OpenSBI.
> 
>>
>> U-Boot v2022.04 qemu-riscv64_smode_defconfig has a value of
>> CONFIG_SYS_MALLOC_F_LEN that is to low. This leads to a boot failure for
>> more than 16 harts. A patch to correct this is pending:
>> [PATCH v2 1/1] riscv: alloc space exhausted
>> https://lore.kernel.org/u-boot/CAN5B=eKt=tFLZ2z3aNHJqsnJzpdA0oikcrC2i1_=ZDD=f+M0jA@mail.gmail.com/T/#t
>>
>> With QEMU 7.0 and the U-Boot fix booting into a 5.17 defconfig kernel
>> with 64 virtual cores worked fine for me.
> 
> Thanks for trying this patch.
> 
> Regards,
> Anup
> 
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> If there was some hardware that actually boots on these I'd be happy to
>>> take it, but given that it's just QEMU I'd prefer to sort out the bugs
>>> first.  It's probably just latent bugs somewhere, but allowing users to
>>> turn on configs we know don't work just seems like the wrong way to go.
>>>
