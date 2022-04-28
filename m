Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19CE512ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiD1FW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242945AbiD1FWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:22:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89B3E0DC;
        Wed, 27 Apr 2022 22:19:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KpkSn1qbkz4xbw;
        Thu, 28 Apr 2022 15:19:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1651123178;
        bh=T3xw8PkqnOjqmTSDDFwrwXQIvUMB4kShWDdGYGByBuM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ArKpHBv8jw7gBr9LkLJwp1cncxQuTqbX2E5hC3ujYwqdGP9BrrGIBw/8y8RhvZAMk
         egkEo1s0XTZhwduoAakDiITU2RTGx92HehKtFYdYvtwNDreLHlaC/vnVgmSeyHp6QW
         lUm4XoXmEs8f+U3mOaopk/o/jKKqTYVLXN004G3E9goxgtixCayk/Hf8N4R0t3oBpT
         9MLusDWqZnpIPUN0yS/JiYbCwCtBgsoJyzr9E/hrRkkX8I5sNGN5BvEyPy5Tn2caQ2
         raD+RD7ZQTR1HEIR9/b1G23xgrYlBKquNTJ7XOtYEZJkfPtzWqhsq0HPey9VJRvJNV
         24fb4FP6/fq7g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v6 05/17] powerpc: define get_cycles macro for
 arch-override
In-Reply-To: <20220423212623.1957011-6-Jason@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-6-Jason@zx2c4.com>
Date:   Thu, 28 Apr 2022 15:19:30 +1000
Message-ID: <87ilqtaiot.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> PowerPC defines a get_cycles() function, but it forgot to do the usual
> `#define get_cycles get_cycles` dance, making it impossible for generic
> code to see if an arch-specific function was defined.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/powerpc/include/asm/timex.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/include/asm/timex.h b/arch/powerpc/include/asm/timex.h
> index fa2e76e4093a..14b4489de52c 100644
> --- a/arch/powerpc/include/asm/timex.h
> +++ b/arch/powerpc/include/asm/timex.h
> @@ -19,6 +19,7 @@ static inline cycles_t get_cycles(void)
>  {
>  	return mftb();
>  }
> +#define get_cycles get_cycles
>  
>  #endif	/* __KERNEL__ */
>  #endif	/* _ASM_POWERPC_TIMEX_H */
> -- 
> 2.35.1
