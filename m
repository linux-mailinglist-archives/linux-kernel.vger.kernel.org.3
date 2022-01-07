Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D848713A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbiAGD3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:29:48 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:59072 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344897AbiAGD3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:29:46 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n5fvx-00076K-TH; Fri, 07 Jan 2022 14:28:55 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Jan 2022 14:28:53 +1100
Date:   Fri, 7 Jan 2022 14:28:53 +1100
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
Subject: Re: [PATCH v3 2/6] crypto: arm64/sm3-ce - make dependent on sm3
 library
Message-ID: <YdezdZQHZT2+iYV3@gondor.apana.org.au>
References: <20211223043547.32297-1-tianjia.zhang@linux.alibaba.com>
 <20211223043547.32297-3-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211223043547.32297-3-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 12:35:43PM +0800, Tianjia Zhang wrote:
> SM3 generic library is stand-alone implementation, sm3-ce can depend
> on the SM3 library instead of sm3-generic.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  arch/arm64/crypto/Kconfig       |  2 +-
>  arch/arm64/crypto/sm3-ce-glue.c | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)

This doesn't compile cleanly with C=1 W=1:

  CC [M]  arch/arm64/crypto/sm3-ce-glue.o
  AS [M]  arch/arm64/crypto/sm3-ce-core.o
  CC [M]  arch/arm64/crypto/sm4-ce-glue.o
  CHECK   ../arch/arm64/crypto/sha3-ce-glue.c
../arch/arm64/crypto/sm3-ce-glue.c: In function ‘sm3_ce_update’:
../arch/arm64/crypto/sm3-ce-glue.c:30:10: error: void value not ignored as it ought to be
   30 |   return sm3_update(shash_desc_ctx(desc), data, len);
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../arch/arm64/crypto/sm3-ce-glue.c: In function ‘sm3_ce_final’:
../arch/arm64/crypto/sm3-ce-glue.c:42:10: error: void value not ignored as it ought to be
   42 |   return sm3_final(shash_desc_ctx(desc), out);
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [../scripts/Makefile.build:287: arch/arm64/crypto/sm3-ce-glue.o] Error 1
make[3]: *** Waiting for unfinished jobs....

Please make sure everything builds cleanly with C=1 W=1 *before*
you submit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
