Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA4B462B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 04:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbhK3Dw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 22:52:27 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59228 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhK3DwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 22:52:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A0265CE172C;
        Tue, 30 Nov 2021 03:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64006C53FC7;
        Tue, 30 Nov 2021 03:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638244138;
        bh=lX7CHRRPfN7CMStsGAiNkNV/GrkU/3I3ljwHsS6tT+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktfQmUwq0n6sEyWfMOlKjaZrC0cdefVkfNhYh2gwlebUKMha/4IFguU/8p6DiA3iH
         1vcOeY+ac2cIIyXLz94QjfSV6KXOlDxOrNfQtJco/vYF1RU0WRWAlsS3fEQ42RIMLs
         GQ1RvMt3kL/yVgbpzYu/H6tLL7kySaCAgmg2auPBBrn6es5advzXjAoCA2+acrM2pl
         EYeDKMi8opFW6PUJikuWud15KO56QguPKcvHf/S1L0fZCa1rfNoB13FsMymw5JCkcV
         HMKIn238+chpWmhXyYWiUWXOlzZeEevbyPTzY2p4EaAdsmb1Brz83Fsap64e7m/Rwz
         bSl2pdWYgfR/Q==
Date:   Mon, 29 Nov 2021 19:48:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com
Subject: Re: [PATCH v3 11/15] crypto: x86/aes-kl - Support AES algorithm
 using Key Locker instructions
Message-ID: <YaWfKB+k66MzNtIi@sol.localdomain>
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
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> index ef6c0b9f69c6..f696b037faa5 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -50,6 +50,9 @@ obj-$(CONFIG_CRYPTO_AES_NI_INTEL) += aesni-intel.o
>  aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o aes-intel_glue.o
>  aesni-intel-$(CONFIG_64BIT) += aesni-intel_avx-x86_64.o aes_ctrby8_avx-x86_64.o
>  
> +obj-$(CONFIG_CRYPTO_AES_KL) += aeskl-intel.o
> +aeskl-intel-y := aeskl-intel_asm.o aesni-intel_asm.o aeskl-intel_glue.o aes-intel_glue.o

This makes the object files aesni-intel_asm.o and aes-intel_glue.o each be built
into two separate kernel modules.  My understanding is that duplicating code
like that is generally frowned upon.  These files should either be built into a
separate module, which both aesni-intel.ko and aeskl-intel.ko would depend on,
or aeskl-intel.ko should depend on aesni-intel.ko.

> diff --git a/arch/x86/crypto/aeskl-intel_asm.S b/arch/x86/crypto/aeskl-intel_asm.S
> new file mode 100644
> index 000000000000..d56ec8dd6644
> --- /dev/null
> +++ b/arch/x86/crypto/aeskl-intel_asm.S

This file gets very long after all the modes are added (> 1100 lines).  Is there
really no feasible way to share code between this and aesni-intel_asm.S, similar
to how the arm64 AES implementations work?  Surely most of the logic is the
same, and it's just the actual AES instructions that differ?

> +config CRYPTO_AES_KL
> +	tristate "AES cipher algorithms (AES-KL)"
> +	depends on (LD_VERSION >= 23600) || (LLD_VERSION >= 120000)
> +	depends on DM_CRYPT

'depends on DM_CRYPT' doesn't really make sense here, since there is no actual
dependency on dm-crypt in the code.

- Eric
