Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800F449F380
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbiA1GXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:23:13 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60592 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346401AbiA1GXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:23:10 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nDKeL-0000t1-Us; Fri, 28 Jan 2022 17:22:23 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jan 2022 17:22:21 +1100
Date:   Fri, 28 Jan 2022 17:22:21 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-crypto@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Introduce x86 assembly accelerated implementation
 for SM3 algorithm
Message-ID: <YfOLnacTQffp3tO9@gondor.apana.org.au>
References: <20220107120700.730-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107120700.730-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 08:06:54PM +0800, Tianjia Zhang wrote:
> This series of patches creates an stand-alone library for SM3 hash
> algorithm in the lib/crypto directory, and makes the implementations
> that originally depended on sm3-generic depend on the stand-alone SM3
> library, which also includes sm3-generic itself.
> 
> On this basis, the AVX assembly acceleration implementation of SM3
> algorithm is introduced, the main algorithm implementation based on
> SM3 AES/BMI2 accelerated work by libgcrypt at:
> https://gnupg.org/software/libgcrypt/index.html
> 
> >From the performance benchmark data, the performance improvement of
> SM3 algorithm after AVX optimization can reach up to 38%.
> 
> ---
> v4 changes:
>  - Rebase on latest cryptodev-2.6/master
>  - Fix the compilation error of arm64/sm3
> 
> v3 changes:
>  - update git commit message for patch 01
> 
> v2 changes:
>  - x86/sm3: Change K macros to signed decimal and use LEA and 32-bit offset
> 
> Tianjia Zhang (6):
>   crypto: sm3 - create SM3 stand-alone library
>   crypto: arm64/sm3-ce - make dependent on sm3 library
>   crypto: sm2 - make dependent on sm3 library
>   crypto: sm3 - make dependent on sm3 library
>   crypto: x86/sm3 - add AVX assembly implementation
>   crypto: tcrypt - add asynchronous speed test for SM3
> 
>  arch/arm64/crypto/Kconfig        |   2 +-
>  arch/arm64/crypto/sm3-ce-glue.c  |  28 +-
>  arch/x86/crypto/Makefile         |   3 +
>  arch/x86/crypto/sm3-avx-asm_64.S | 517 +++++++++++++++++++++++++++++++
>  arch/x86/crypto/sm3_avx_glue.c   | 134 ++++++++
>  crypto/Kconfig                   |  16 +-
>  crypto/sm2.c                     |  38 +--
>  crypto/sm3_generic.c             | 142 +--------
>  crypto/tcrypt.c                  |  14 +-
>  include/crypto/sm3.h             |  34 +-
>  lib/crypto/Kconfig               |   3 +
>  lib/crypto/Makefile              |   3 +
>  lib/crypto/sm3.c                 | 246 +++++++++++++++
>  13 files changed, 1013 insertions(+), 167 deletions(-)
>  create mode 100644 arch/x86/crypto/sm3-avx-asm_64.S
>  create mode 100644 arch/x86/crypto/sm3_avx_glue.c
>  create mode 100644 lib/crypto/sm3.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
