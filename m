Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D247B28A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbhLTSED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:04:03 -0500
Received: from meesny.iki.fi ([195.140.195.201]:44240 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240361AbhLTSD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:03:58 -0500
Received: from [10.0.0.10] (87-100-201-184.bb.dnainternet.fi [87.100.201.184])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: jussi.kivilinna)
        by meesny.iki.fi (Postfix) with ESMTPSA id 44C932005D;
        Mon, 20 Dec 2021 20:03:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1640023428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wW83kui2hXf3Lo+4Yk8gj/d8EIV+rRJ4EwkVapYVfxc=;
        b=IMyVkQseKjGtgDsQ03AWveqmaK+W5R3h8165fdukxV0mHCMZeV/DgAgEBkobdd+FwbUyMn
        i2RDp14fEaqo4QvsDz7ufnV+Ywo5YHS5njNhlk6xphXSRlZTwyjiB9p2waRqQXoKnl5LZL
        /5akhVLjIIdjTTH7bvhZYzvSXgLMeCU=
Message-ID: <9e70bf33-bab5-83a3-1eb0-7cae442c2f64@iki.fi>
Date:   Mon, 20 Dec 2021 20:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211220082251.1445-1-tianjia.zhang@linux.alibaba.com>
 <20211220082251.1445-6-tianjia.zhang@linux.alibaba.com>
From:   Jussi Kivilinna <jussi.kivilinna@iki.fi>
Subject: Re: [PATCH 5/6] crypto: x86/sm3 - add AVX assembly implementation
In-Reply-To: <20211220082251.1445-6-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=jussi.kivilinna smtp.mailfrom=jussi.kivilinna@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1640023428; a=rsa-sha256; cv=none;
        b=da2nvPdHYu4MgAMlGpfMmzPiDl5gUxGRnpSPjVIWl+zJepXuTwmWU4vQXzSbRJZBOs93zI
        1EB93O8X/uSD2gM4Hz0VghF+ei0ivDzDaHfe3nFMwalLKs4fokzSjLSy9mCR9oO65Sd2JF
        a4tsA+y/ir0jo6D5I2Daiam48rMTatU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1640023428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wW83kui2hXf3Lo+4Yk8gj/d8EIV+rRJ4EwkVapYVfxc=;
        b=NuOqQuAbUXBFleWNfstTiT1cbyuHWx3sRdk0yigNUIzEwXN1ndB/rug5BGoLnQN4kJ8mVL
        J7+3BCgHEAo7XNSWw4c2W1rLTILUGxMtiplDHYPfyWzCRhF3/TGqryELTbJt7/XpCupW8a
        J3E9tBlc+i5tlps5QIoB75PE4+45uNA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.2021 10.22, Tianjia Zhang wrote:
> This patch adds AVX assembly accelerated implementation of SM3 secure
> hash algorithm. From the benchmark data, compared to pure software
> implementation sm3-generic, the performance increase is up to 38%.
> 
> The main algorithm implementation based on SM3 AES/BMI2 accelerated
> work by libgcrypt at:
> https://gnupg.org/software/libgcrypt/index.html
> 
> Benchmark on Intel i5-6200U 2.30GHz, performance data of two
> implementations, pure software sm3-generic and sm3-avx acceleration.
> The data comes from the 326 mode and 422 mode of tcrypt. The abscissas
> are different lengths of per update. The data is tabulated and the
> unit is Mb/s:
> 
> update-size |     16      64     256    1024    2048    4096    8192
> --------------------------------------------------------------------
> sm3-generic | 105.97  129.60  182.12  189.62  188.06  193.66  194.88
> sm3-avx     | 119.87  163.05  244.44  260.92  257.60  264.87  265.88
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>   arch/x86/crypto/Makefile         |   3 +
>   arch/x86/crypto/sm3-avx-asm_64.S | 521 +++++++++++++++++++++++++++++++
>   arch/x86/crypto/sm3_avx_glue.c   | 134 ++++++++
>   crypto/Kconfig                   |  13 +
>   4 files changed, 671 insertions(+)
>   create mode 100644 arch/x86/crypto/sm3-avx-asm_64.S
>   create mode 100644 arch/x86/crypto/sm3_avx_glue.c
> 
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> index f307c93fc90a..7cbe860f6201 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -88,6 +88,9 @@ nhpoly1305-avx2-y := nh-avx2-x86_64.o nhpoly1305-avx2-glue.o
>   
>   obj-$(CONFIG_CRYPTO_CURVE25519_X86) += curve25519-x86_64.o
>   
> +obj-$(CONFIG_CRYPTO_SM3_AVX_X86_64) += sm3-avx-x86_64.o
> +sm3-avx-x86_64-y := sm3-avx-asm_64.o sm3_avx_glue.o
> +
>   obj-$(CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64) += sm4-aesni-avx-x86_64.o
>   sm4-aesni-avx-x86_64-y := sm4-aesni-avx-asm_64.o sm4_aesni_avx_glue.o
>   
> diff --git a/arch/x86/crypto/sm3-avx-asm_64.S b/arch/x86/crypto/sm3-avx-asm_64.S
> new file mode 100644
> index 000000000000..e7a9a37f3609
> --- /dev/null
> +++ b/arch/x86/crypto/sm3-avx-asm_64.S
> @@ -0,0 +1,521 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * SM3 AVX accelerated transform.
> + * specified in: https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
> + *
> + * Copyright (C) 2021 Jussi Kivilinna <jussi.kivilinna@iki.fi>
> + * Copyright (C) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> + */
<snip>
> +
> +#define R(i, a, b, c, d, e, f, g, h, round, widx, wtype)                      \
> +	/* rol(a, 12) => t0 */                                                \
> +	roll3mov(12, a, t0); /* rorxl here would reduce perf by 6% on zen3 */ \
> +	/* rol (t0 + e + t), 7) => t1 */                                      \
> +	addl3(t0, e, t1);                                                     \
> +	addl $K##round, t1;                                                   \

It's better to use "leal K##round(t0, e, 1), t1;" here and fix K0-K63 macros
instead as I noted at libgcrypt mailing-list:
  https://lists.gnupg.org/pipermail/gcrypt-devel/2021-December/005209.html

-Jussi
