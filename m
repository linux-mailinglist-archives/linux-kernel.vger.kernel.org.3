Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399EE509863
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiDUHH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385553AbiDUHHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:07:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5FB2AF3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:04:58 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A4BEA3F1AE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650524697;
        bh=6HdSC5MBPOMufV6HBiKEeWBhFc9GPRC0t6FN09g0Ni0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Cw2hKVUc6XGwBB+Gjih/0VWVNIVc7Dp0qKge0i9JpzERau/+WbW88f6qq58S2RJlD
         3qjXktxUjy4B2y60soDW/Kkm1I8bU2kHWTAYO0F69gAIN3Mk44KWa/kF5CVwulr1Et
         FJfPUQ/jqGSBAqCj8ClZAzT9Ln3uI8qBQ8JMRWCIrKOY6q3aw0VNcnWOI7mwC767/J
         JdnC0xjrZxEgeQedGIW3bEULykCJBPFYsPSxCeJ0Y/MdUg0RcKSit9bSuufsNWSh4H
         jl9EtmHZKmzej+6HXTvx6dW8k3iDYXkOIIsYltEM2o8RBXqKjgCBsoHyGyuvtltfaA
         p6krUlgwd9e5w==
Received: by mail-ej1-f72.google.com with SMTP id gn13-20020a1709070d0d00b006efe23342c7so304941ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6HdSC5MBPOMufV6HBiKEeWBhFc9GPRC0t6FN09g0Ni0=;
        b=MvX+qNYVEGIP5lZPYPkXArVKjB9yJoH56q0/JCp6ES873JLosTJ5iAD6SMimYzXm1e
         X1wdVVjl1nGxVIOo7Zk3l+MZ4odTC23e8MSqI9AujPBsOoI6FXZNXq57rAmuxHVlF+YP
         fHg5PYq1/FH388/2tL4WaDu6tNGLpy3vNmINI7NL+TlKkOibU+JI3WQ2NWGPMG+X9mjb
         NIOS3RlrIn1tH1Za4LgFfPKVS1o7liifD2Uc2+LYGS/Bw935VQa11wB/qcKM8oWpqddQ
         u42ESeue8i/hydY4xHgoiA9ADh8cWtFU+T0ttt2w9JCHD66ge3zmNe0LYNthwDZfZyct
         wnvg==
X-Gm-Message-State: AOAM532T5rI0w8ny1Lp2TmkRM007EqlW2WvSoEYH/JJzpIEg0KBMZC+9
        BbAPJ+GDqMED/K6AFP28VjiiK2yqgnUSv4pEkacI968aa+za4M7gh1yATxZvVmdV40lDnh2imPd
        ekRpc3fqZLtbC4eTnatSCxpOsa37wI3OZMq3sDVCIFQ==
X-Received: by 2002:a17:906:5d04:b0:6db:7262:570e with SMTP id g4-20020a1709065d0400b006db7262570emr21773808ejt.8.1650524697233;
        Thu, 21 Apr 2022 00:04:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynJjrtS0hF16SVmG5l/ZQENi4TBpgJyFKjQc4HjrAuWcJ+5tpAdnARz6DxwRaPkxDgvSHyjw==
X-Received: by 2002:a17:906:5d04:b0:6db:7262:570e with SMTP id g4-20020a1709065d0400b006db7262570emr21773783ejt.8.1650524697000;
        Thu, 21 Apr 2022 00:04:57 -0700 (PDT)
Received: from [192.168.123.94] (ip-088-152-144-107.um26.pools.vodafone-ip.de. [88.152.144.107])
        by smtp.gmail.com with ESMTPSA id kb28-20020a1709070f9c00b006d5d8bf1b72sm7465162ejc.78.2022.04.21.00.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:04:56 -0700 (PDT)
Message-ID: <3fa5215b-84c3-5e4c-cb53-6c05d05e4350@canonical.com>
Date:   Thu, 21 Apr 2022 09:04:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] RISC-V: Increase range and default value of NR_CPUS
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220420112408.155561-1-apatel@ventanamicro.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220420112408.155561-1-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/22 13:24, Anup Patel wrote:
> Currently, the range and default value of NR_CPUS is too restrictive
> for high-end RISC-V systems with large number of HARTs. The latest
> QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> restrictive for QEMU as well. Other major architectures (such as
> ARM64, x86_64, MIPS, etc) have a much higher range and default
> value of NR_CPUS.
> 
> This patch increases NR_CPUS range to 2-512 and default value to
> XLEN (i.e. 32 for RV32 and 64 for RV64).
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
> Changes since v2:
>   - Rebased on Linux-5.18-rc3
>   - Use a different range when SBI v0.1 is enabled
> Changes since v1:
>   - Updated NR_CPUS range to 2-512 which reflects maximum number of
>     CPUs supported by QEMU virt machine.
> ---
>   arch/riscv/Kconfig | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 00fd9c548f26..1823f281069f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -275,10 +275,13 @@ config SMP
>   	  If you don't know what to do here, say N.
>   
>   config NR_CPUS
> -	int "Maximum number of CPUs (2-32)"
> -	range 2 32
> +	int "Maximum number of CPUs (2-512)"
>   	depends on SMP
> -	default "8"
> +	range 2 512 if !SBI_V01
> +	range 2 32 if SBI_V01 && 32BIT
> +	range 2 64 if SBI_V01 && 64BIT
> +	default "32" if 32BIT
> +	default "64" if 64BIT
>   
>   config HOTPLUG_CPU
>   	bool "Support for hot-pluggable CPUs"
