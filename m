Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F79466924
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376274AbhLBRee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376333AbhLBRe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:34:29 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158CCC06174A;
        Thu,  2 Dec 2021 09:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P9ciscIKXRAxAw+4iBT/XYfUrd6b+KlvnMlD147Wp5A=; b=Jgdikhh31azCpOta9MwerTYVma
        5NbgV0oClwq8Qllp3OykfMWiKUF7dsoRr8zzXKNyWuh1kDKov+Zbw2Ux+0PVd9RdnlsBT3qsDnOiw
        ecYrJX3Iu1lHIxvK3iOQAeHkcoXvKi/mEJjkObvxUkxSlpV4548XQ+GjIHtLs63AftiRp0gDokQ6b
        QlseesdLEwARUtzVxA5cMpWYNqMWHZguyESIYKTkukos03LS7dnx5g10H8TqIz0xo2drSecdaPJMz
        MGBjLLs3R4Wmgzk558p6kbFXXI9bJd9Jq8P3INg6zGi6m9zEgHFyGx9pphyFu51+6HMRFm4oEXdIF
        AYarYHOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mspuw-001qkd-UE; Thu, 02 Dec 2021 17:30:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6407D300293;
        Thu,  2 Dec 2021 18:30:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8D972008DFBA; Thu,  2 Dec 2021 15:21:22 +0100 (CET)
Date:   Thu, 2 Dec 2021 15:21:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com
Subject: Re: [PATCH v3 11/15] crypto: x86/aes-kl - Support AES algorithm
 using Key Locker instructions
Message-ID: <YajWYuwFAy81VP5t@hirez.programming.kicks-ass.net>
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
 <20211124200700.15888-12-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124200700.15888-12-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 12:06:56PM -0800, Chang S. Bae wrote:
> +	encodekey256 %eax, %eax

So this thing uses the fancy new keylocker instructions, however:

> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 285f82647d2b..784a04433549 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1113,6 +1113,50 @@ config CRYPTO_AES_NI_INTEL
>  	  ECB, CBC, LRW, XTS. The 64 bit version has additional
>  	  acceleration for CTR.
>  
> +config CRYPTO_AES_KL
> +	tristate "AES cipher algorithms (AES-KL)"
> +	depends on (LD_VERSION >= 23600) || (LLD_VERSION >= 120000)
> +	depends on DM_CRYPT
> +	select X86_KEYLOCKER
> +	select CRYPTO_AES_NI_INTEL


There is no dependency on the compiler actually supporting them..

config AS_HAS_KEYLOCKER
	def_bool $(as-instr,encodekey256)

	depends on AS_HAS_KEYLOCKER

Hmm?


> +
> +	help
> +	  Key Locker provides AES SIMD instructions (AES-KL) for secure
> +	  data encryption and decryption. While this new instruction
> +	  set is analogous to AES-NI, AES-KL supports to encode an AES
> +	  key to an encoded form ('key handle') and uses it to transform
> +	  data instead of accessing the AES key.
> +
> +	  The setkey() transforms an AES key to a key handle, then the AES
> +	  key is no longer needed for data transformation. A user may
> +	  displace their keys from possible exposition.
> +
> +	  This key encryption is done by the CPU-internal wrapping key. The
> +	  x86 core code loads a new random key at every boot time and
> +	  restores it from deep sleep states. This wrapping key support is
> +	  provided with X86_KEYLOCKER.
> +
> +	  AES-KL supports 128-/256-bit keys only. While giving a 192-bit
> +	  key does not return an error, as AES-NI is chosen to process it,
> +	  the claimed security property is not available with that.
> +
> +	  GNU binutils version 2.36 or above and LLVM version 12 or above
> +	  are assemblers that support AES-KL instructions.
> +
> +	  Bare metal disk encryption is the preferred use case. Make it
> +	  depend on DM_CRYPT.
> +
> +	  This selection enables an alternative crypto cipher for
> +	  cryptsetup, e.g. "capi:xts-aes-aeskl-plain", to use with dm-crypt
> +	  volumes. It trades off raw performance for reduced clear-text key
> +	  exposure and has an additional failure mode compared to AES-NI.
> +	  See Documentation/x86/keylocker.rst for more details. Key Locker
> +	  usage requires explicit opt-in at cryptsetup time. So, select it
> +	  if unsure.
> +
> +	  See also the CRYPTO_AES_NI_INTEL description for more about the
> +	  AES cipher algorithm.
> +
>  config CRYPTO_AES_SPARC64
>  	tristate "AES cipher algorithms (SPARC64)"
>  	depends on SPARC64
> -- 
> 2.17.1
> 
