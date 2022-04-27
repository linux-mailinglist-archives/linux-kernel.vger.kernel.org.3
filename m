Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838945124AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiD0Vps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiD0Vpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:45:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9035DA16;
        Wed, 27 Apr 2022 14:42:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so2785035pjf.0;
        Wed, 27 Apr 2022 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=74tBYBfjUTcEu+cPUdN10nkHPL3FQx8M2KL24jTaIMg=;
        b=kUkNwlH/Cmf/BZTymS/svQM50m2sfFE+Oz9m1sc6Je8bacXe8JufW0ysw4JVdz22Sq
         ABxdlD86pv5YIlZniLya+MsTaR4G+Xk3BoCKP6rnc3A+jWNTYIiFCedQVZ9PboJ4Ca2L
         MH67JDauiDNyR4ukQv84hSzoR7IN+I4pq+j7TRREuuyfliRxTU17QaJb02vIL8ddJPV2
         7yoGPkmLop3ol4P9O3E1S9c21vTipLUgsfELvmbhd0mgPAgHtHruNf6M2Vw85iLhWKUJ
         XlhGUzEmS+2ALBgUNtwJoMmUVW2efQjbXcQ3sjXyHdOugqW6L+CBQw9INmLNe5OVNfkw
         lX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74tBYBfjUTcEu+cPUdN10nkHPL3FQx8M2KL24jTaIMg=;
        b=oFggIMRZE0s8atfm0KKOQBao2kCfbF+sjg/d2QATDK01niIamAt4RXvEFH2NX2NFKa
         WOFVXXlaqZcqqRDuWP3pzbTe4eKM7KMwaPy+WKgcFI4LEpx0KxVl1WatOoQ2Ml91cZTa
         /bgMnVPiejxpmxvcN5TSxGfpcagFjdDYbjOZmDf/zVdIA4xgBSoaYVQwBqWkpjBBGq5x
         FQohBX5N/Iq5prfOit0bPLsdKY9x1ZQWPpPREGoLkf8Eg4toCFHXfstv7P/Jm8RnD0Wq
         Cwrqgdl882dMagcf2By1A8K1vSKCylsh3jsicZFKyUdjGE40ExVqCAzydUxq1Rt+02FE
         /9UA==
X-Gm-Message-State: AOAM530RT52sNNgoz4YRjctQdrudI4sLqR83lwHswGZojpcAQrOVmLJN
        3jmfGDzlGoCdPwTrXqn17Pk=
X-Google-Smtp-Source: ABdhPJyW7pvEA8Y+vM8nCWPanwDnXSalol/rgku8knCNd6bKgD3DfIQlBH7m6kzPSX/xpp66STr8Yg==
X-Received: by 2002:a17:902:ab55:b0:15c:ecb:81ad with SMTP id ij21-20020a170902ab5500b0015c0ecb81admr29758872plb.50.1651095752994;
        Wed, 27 Apr 2022 14:42:32 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79113000000b00505d5d15d80sm20310724pfh.14.2022.04.27.14.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:42:32 -0700 (PDT)
Date:   Thu, 28 Apr 2022 06:42:30 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        tglx@linutronix.de, arnd@arndb.de, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: [PATCH v6 11/17] openrisc: use fallback for random_get_entropy()
 instead of zero
Message-ID: <Ymm4xhRDWjvWS+3X@antec>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-12-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423212623.1957011-12-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 11:26:17PM +0200, Jason A. Donenfeld wrote:
> In the event that random_get_entropy() can't access a cycle counter or
> similar, falling back to returning 0 is really not the best we can do.
> Instead, at least calling random_get_entropy_fallback() would be
> preferable, because that always needs to return _something_, even
> falling back to jiffies eventually. It's not as though
> random_get_entropy_fallback() is super high precision or guaranteed to
> be entropic, but basically anything that's not zero all the time is
> better than returning zero all the time.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/openrisc/include/asm/timex.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
> index d52b4e536e3f..115e89b336cd 100644
> --- a/arch/openrisc/include/asm/timex.h
> +++ b/arch/openrisc/include/asm/timex.h
> @@ -23,6 +23,9 @@ static inline cycles_t get_cycles(void)
>  {
>  	return mfspr(SPR_TTCR);
>  }
> +#define get_cycles get_cycles
> +
> +#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
>  
>  /* This isn't really used any more */
>  #define CLOCK_TICK_RATE 1000
> -- 
> 2.35.1

Hi Jason,

This looks OK, but I am wondering why we cannot add this to
"include/linux/timex.h" as the default implementation of random_get_entropy
if get_cycles is defined.  I see there are 2 cases:

   1. architectures that define get_cycles, and random_get_entropy is defined in
      include/linux/timex.h.
      (openrisc, sparc*, xtensa*, nios2, um*, arm)

   2. architectures that define random_get_entropy explicitly
      (mips, m68k, riscv, x86)

* Those marked with * just define get_cycles as 0.

I would think in "include/linux/timex.h" we could define.

    #ifndef random_get_entropy
    #ifdef get_cycles
    #define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
    #else
    #define random_get_entropy()   random_get_entropy_fallback()
    #endif
    #endif

For architectures that define get_cycles as 0, they can be cleaned up.

-Stafford
