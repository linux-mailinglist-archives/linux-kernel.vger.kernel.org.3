Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF156CBD0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 00:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGIWnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 18:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGIWnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 18:43:10 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C468B12098
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 15:43:09 -0700 (PDT)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 269MgtuQ2280876
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 9 Jul 2022 15:42:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 269MgtuQ2280876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022070501; t=1657406576;
        bh=udIunIcx1Q/qtRW3dNxNLApGfVBM3yXCEcFBiFNLH84=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=h31lM0uLizR2v3NiLWb8OV3+CgLmR3XgAcWzVgfZh9FTLNUYsl1n6znJXcdLxxsTA
         Sr8iPcgAFCcKrtNQGxbbGf4UjasacSXH+AdiECQ157E2oWf6RP8Kgy2syBNgl2MEMg
         Txll8S7i5G4voz6smSYU6tVINZup7hAkse2faw3cDAnz2u3Y4gPNzI8a1lZEs9f5eE
         1OkkObn0Y2BDYFO1eOP9UvDMQgiRZpwSceJx4Hwr1mQ/mu2HdoWV8tD0cqv9pGKgF8
         vtvCQ12vs+4Z1Tsh0Z7c2hxZepNgfH0X08QBSplkLYQ3xlU8JszSfSBiSY3DxcwKq4
         wPSn21TfRMY/g==
Message-ID: <ec46a292-dcc1-c12b-25a0-491b522c2db8@zytor.com>
Date:   Sat, 9 Jul 2022 15:42:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH tip v9] x86/setup: Use rng seeds from setup_data
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <YslN1bo2jnnxl3E3@zx2c4.com>
 <20220709094853.1090735-1-Jason@zx2c4.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20220709094853.1090735-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/22 02:48, Jason A. Donenfeld wrote:
> Currently the only way x86 can get an early boot RNG seed is via EFI,
> which is generally always used now for physical machines, but is very
> rarely used in VMs, especially VMs that are optimized for starting
> "instantaneously", such as Firecracker's MicroVM. For tiny fast booting
> VMs, EFI is not something you generally need or want.
> 
> Rather, here we want the ability for the image loader or firmware to
> pass a single random seed, exactly as device tree platforms do with the
> "rng-seed" property. Additionally, this is something that bootloaders
> can append, with their own seed file management, which is something
> every other major OS ecosystem has that we do not (yet).
> 
> This patch adds SETUP_RNG_SEED, similar to the other seven setup_data
> entries that are parsed at boot. It also takes care to zero out the seed
> immediately after using, in order to retain forward secrecy. This all
> takes about 7 trivial lines of code.
> 
> Then, on kexec_file_load(), a new fresh seed is generated and passed to
> the next kernel, just as is done on device tree architectures when
> using kexec. And, importantly, I've tested that QEMU is able to properly
> pass SETUP_RNG_SEED as well, making this work for every step of the way.
> This code too is pretty straight forward.
> 
> Together these measures ensure that VMs and nested kexec()'d kernels
> always receive a proper boot time RNG seed at the earliest possible
> stage from their parents:
> 
>     - Host [already has strongly initialized RNG]
>       - QEMU [passes fresh seed in SETUP_RNG_SEED field]
>         - Linux [uses parent's seed and gathers entropy of its own]
>           - kexec [passes this in SETUP_RNG_SEED field]
>             - Linux [uses parent's seed and gathers entropy of its own]
>               - kexec [passes this in SETUP_RNG_SEED field]
>                 - Linux [uses parent's seed and gathers entropy of its own]
>                   - kexec [passes this in SETUP_RNG_SEED field]
> 		   - ...
> 
> I've verified in several scenarios that this works quite well from a
> host kernel to QEMU and down inwards, mixing and matching loaders, with
> every layer providing a seed to the next.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>

> ---
> Changes v8->v9:
> - [hpa] Update SETUP_TYPE_MAX and add SETUP_ENUM_MAX.
