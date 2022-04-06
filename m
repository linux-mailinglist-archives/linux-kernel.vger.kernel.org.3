Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5F4F5F45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiDFNTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbiDFNRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:17:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DFE611C65
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:56:00 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4AB5C3F867
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1649238948;
        bh=Cr0zob3O2czZYqaT1XEpHfoL1utbHJLFt3/CqeQ40lk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=nme510sxHwdZSezl8onrgK9B/7LNYNoGv/cl889f2lRRqrTPwMRlWpxkqtgnNK/Nc
         W16tXGJlG9B7mqhQABwICMq5Pfz9NfZ4D48365/bmaGBd/SVWCu0wEkFFwgS3wcoTm
         OsRByCeYmQdzgYnde/xh1Y4UuQRsakODyPU9T+3ugfkoMy6hKolzxo9QnD9g5G7GiM
         lZ0Lhm7c043jBi/Z2q3ctio3ReAfEXcIh6FmpXJ/rZcttLx95ZvkLXzRHiDmdK0RXD
         WxysJwhyHjjlwD61J9D1D3lMM9b8AxtYnS6CIJmhwAaIylz5a7mCe24AsfjPTpQJro
         4UtAVP7+o6YsQ==
Received: by mail-ej1-f69.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso922659ejs.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 02:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cr0zob3O2czZYqaT1XEpHfoL1utbHJLFt3/CqeQ40lk=;
        b=YO+GXMJr2ORf8l3XX7VDKW1TmoO0YcJ3nlApIwryAAewa3MKAhQl5L9XEz/grp56io
         u0l5TiWheBskU3g+p+OxcxuqthVh8h1l5t2sjVCOwhQkNhDAUty9N2zMe6flLhCeSdCE
         4aMFZZZKGhx77WzPFm49h4uFZ9qzzXIMsHvf1tah+XmyT5DDpRtsjR93swUn7MKV7Pm2
         s5KC6GWjss1dzyiX/zyUC7NZUuxw4BCfhPu+plEIf2rpwMqtcN4XLgxb3SYeDe6fVu6O
         2C/ty/97clMGxxDS1JcBiFxqPnByPxRgpK4YWLLwco5sEicLOPZUHfMJY7H8Ep9zZgjJ
         TAxQ==
X-Gm-Message-State: AOAM530MkgTz744pWsl1rxkPAMc15VJQbfHihc/+FRf08vEVDVh/Cucl
        qzPL7RczBMGFpTkUtYJIf0KcZa6BChHyVmCZNdeZkhNA3/nLU1mf5cBkmzJW7UTyKiPXO7FMMIj
        MzKNUKkT+1JTk6emIiQ5KhtW+G4WSQcaVT4AnAkQ8Gg==
X-Received: by 2002:a17:907:7e96:b0:6da:f7ee:4a25 with SMTP id qb22-20020a1709077e9600b006daf7ee4a25mr7322194ejc.436.1649238945562;
        Wed, 06 Apr 2022 02:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp7atgtib6PHMj3QV9Py+Ljc5dGjtqXV9y+Mr0o7vdm5hiR1gMwYh9YCrNenxw7wazsURVVw==
X-Received: by 2002:a17:907:7e96:b0:6da:f7ee:4a25 with SMTP id qb22-20020a1709077e9600b006daf7ee4a25mr7322169ejc.436.1649238945248;
        Wed, 06 Apr 2022 02:55:45 -0700 (PDT)
Received: from [192.168.123.67] (ip-088-152-144-107.um26.pools.vodafone-ip.de. [88.152.144.107])
        by smtp.gmail.com with ESMTPSA id sa26-20020a1709076d1a00b006e6b23c8dafsm4774120ejc.164.2022.04.06.02.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 02:55:44 -0700 (PDT)
Message-ID: <cd8d6641-4a29-7deb-49ae-a80baab0344f@canonical.com>
Date:   Wed, 6 Apr 2022 11:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] RISC-V: Increase range and default value of NR_CPUS
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com
References: <mhng-9cbb2a46-8bcb-4bfe-b927-0ed469dbd3a6@palmer-mbp2014>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <mhng-9cbb2a46-8bcb-4bfe-b927-0ed469dbd3a6@palmer-mbp2014>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 21:42, Palmer Dabbelt wrote:
> On Sat, 19 Mar 2022 05:12:06 PDT (-0700), apatel@ventanamicro.com wrote:
>> Currently, the range and default value of NR_CPUS is too restrictive
>> for high-end RISC-V systems with large number of HARTs. The latest
>> QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
>> restrictive for QEMU as well. Other major architectures (such as
>> ARM64, x86_64, MIPS, etc) have a much higher range and default
>> value of NR_CPUS.
>>
>> This patch increases NR_CPUS range to 2-512 and default value to
>> XLEN (i.e. 32 for RV32 and 64 for RV64).
>>
>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>> ---
>> Changes since v1:
>>  - Updated NR_CPUS range to 2-512 which reflects maximum number of
>>    CPUs supported by QEMU virt machine.
>> ---
>>  arch/riscv/Kconfig | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 5adcbd9b5e88..423ac17f598c 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -274,10 +274,11 @@ config SMP
>>        If you don't know what to do here, say N.
>>
>>  config NR_CPUS
>> -    int "Maximum number of CPUs (2-32)"
>> -    range 2 32
>> +    int "Maximum number of CPUs (2-512)"
>> +    range 2 512

For SBI_V01=y there seems to be a hard constraint to XLEN bits.
See __sbi_v01_cpumask_to_hartmask() in rch/riscv/kernel/sbi.c.

So shouldn't this be something like:

range 2 512 !SBI_V01
range 2 32 SBI_V01 && 32BIT
range 2 64 SBI_V01 && 64BIT

>>      depends on SMP
>> -    default "8"
>> +    default "32" if 32BIT
>> +    default "64" if 64BIT
>>
>>  config HOTPLUG_CPU
>>      bool "Support for hot-pluggable CPUs"
> 
> I'm getting all sorts of boot issues with more than 32 CPUs, even on the 
> latest QEMU master.  I'm not opposed to increasing the CPU count in 
> theory, but if we're going to have a setting that goes up to a huge 
> number it needs to at least boot.  I've got 64 host threads, so it 
> shouldn't just be a scheduling thing.

Currently high performing hardware for RISC-V is missing. So it makes 
sense to build software via QEMU on x86_64 or arm64 with as many 
hardware threads as available (128 is not uncommon).

OpenSBI currently is limited to 128 threads:
include/sbi/sbi_hartmask.h:22:
#define SBI_HARTMASK_MAX_BITS 128
This is just an arbitrary value we can be modified.

U-Boot v2022.04 qemu-riscv64_smode_defconfig has a value of 
CONFIG_SYS_MALLOC_F_LEN that is to low. This leads to a boot failure for 
more than 16 harts. A patch to correct this is pending:
[PATCH v2 1/1] riscv: alloc space exhausted
https://lore.kernel.org/u-boot/CAN5B=eKt=tFLZ2z3aNHJqsnJzpdA0oikcrC2i1_=ZDD=f+M0jA@mail.gmail.com/T/#t

With QEMU 7.0 and the U-Boot fix booting into a 5.17 defconfig kernel 
with 64 virtual cores worked fine for me.

Best regards

Heinrich

> 
> If there was some hardware that actually boots on these I'd be happy to 
> take it, but given that it's just QEMU I'd prefer to sort out the bugs 
> first.  It's probably just latent bugs somewhere, but allowing users to 
> turn on configs we know don't work just seems like the wrong way to go.
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

