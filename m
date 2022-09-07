Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6410D5B0A08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIGQ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiIGQ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAABB74DF3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662568036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BFu6DTdfMv1CjKJBOTW+XgKZmFlp1inU8f+7PFR51xQ=;
        b=Xxm0nM/P0WZ1gAz65sfeMGF0u4uVEJ7ijYHVy5wiezczI1qe7e7MJf2RrRbjU8YkP/aJu4
        iHQq4cKVILS2UBxrhBDCaNgkr4Vdgjp7KtswTXSPTMGS/3MiOQ4w8qUkJ8pelRndSRishG
        x53VmjhOn1tJZOtpEKpT1qLe6A9FVBw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-520-w01bq9WBMHO07WKWWupXEw-1; Wed, 07 Sep 2022 12:27:14 -0400
X-MC-Unique: w01bq9WBMHO07WKWWupXEw-1
Received: by mail-wm1-f69.google.com with SMTP id j22-20020a05600c485600b003a5e4420552so10462515wmo.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=BFu6DTdfMv1CjKJBOTW+XgKZmFlp1inU8f+7PFR51xQ=;
        b=UspDssBHwNCzDcOB5CFy3+JOezH+Z60XgluW7lmaSeQLkumE8K70+0Fyu/1Q27SJpf
         vRn+6+aUp6xcA/5BW7pDDwDjWHdi8u7szoSy1eBef4FQH1JInwmyWuB5Sw2kATtqgiJj
         P4C3Baq7mOBITPJCi6a425TbrdyBAujRhEYhKf+jqhvHlgbReAk+WF/dMKyP0lKbhyTB
         zROQqyNxKV0S9cWY0lprYKH0M/84Rs2SYOAwn5fJOz1TAf6fL8SMsnWgjtGpj9/s2Xjb
         BcCtbZ7ya3ePgJTNDAaw7S9HgWjJX+lVAIijq5GaX5bCQciCnyYRvX/qSmXkQamool2D
         B8nA==
X-Gm-Message-State: ACgBeo1YUt9DugVhOzbazMjZKwDb93BXc/l4oCD3BgCbQT0CW/B21PpC
        LHVML4Bht0SgRPMZW7J634ZiPU+NLsCjh/NoGlHjSf1/nsLvm1smJiRfQgvZvXcC5qnkqlz/sPm
        ci6T9el5b4R4OvaUA9W+G0vs+
X-Received: by 2002:a5d:6c62:0:b0:222:c8cd:26f with SMTP id r2-20020a5d6c62000000b00222c8cd026fmr2660055wrz.393.1662568033754;
        Wed, 07 Sep 2022 09:27:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6VLl5PWL5bBBvM1hJQeEpH4ZGE9QTiQIIhTWlhIiA3jVFHC2480Z1kdNgMXLVbblZSnLVaig==
X-Received: by 2002:a5d:6c62:0:b0:222:c8cd:26f with SMTP id r2-20020a5d6c62000000b00222c8cd026fmr2660035wrz.393.1662568033539;
        Wed, 07 Sep 2022 09:27:13 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b0021e4829d359sm18030720wrs.39.2022.09.07.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:27:13 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 2/4] lib/find_bit: create find_first_zero_bit_le()
In-Reply-To: <20220827175807.4017673-3-yury.norov@gmail.com>
References: <20220827175807.4017673-1-yury.norov@gmail.com>
 <20220827175807.4017673-3-yury.norov@gmail.com>
Date:   Wed, 07 Sep 2022 17:27:12 +0100
Message-ID: <xhsmhedwnb15r.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/22 10:58, Yury Norov wrote:
> find_first_zero_bit_le() is an alias to find_next_zero_bit_le(),
> despite that 'next' is known to be slower than 'first' version.
>
> Now that we have common FIND_FIRST_BIT() macro helper, it's trivial
> to implement find_first_zero_bit_le() as a real function.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Declaration ordering nit below, otherwise:
Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  include/linux/find.h | 23 ++++++++++++++++++-----
>  lib/find_bit.c       | 14 ++++++++++++++
>  2 files changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/find.h b/include/linux/find.h
> index 424ef67d4a42..a1861d0ba533 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -17,6 +17,10 @@ extern unsigned long _find_first_and_bit(const unsigned long *addr1,
>  extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
>  extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long size);
>  
> +#ifdef __BIG_ENDIAN
> +unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size);
> +#endif
> +
>  #ifndef find_next_bit
>  /**
>   * find_next_bit - find the next set bit in a memory region
> @@ -251,6 +255,20 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
>  }
>  #endif
>  
> +#ifndef find_first_zero_bit_le
> +static inline
> +unsigned long find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
> +{
> +	if (small_const_nbits(size)) {
> +		unsigned long val = swab(*addr) | ~GENMASK(size - 1, 0);
> +
> +		return val == ~0UL ? size : ffz(val);
> +	}
> +
> +	return _find_first_zero_bit_le(addr, size);
> +}
> +#endif
> +

Nit: this should be placed after the declaration of find_next_bit_le() to
match the __LITTLE_ENDIAN declaration order above.

>  #ifndef find_next_bit_le
>  static inline
>  unsigned long find_next_bit_le(const void *addr, unsigned
> @@ -270,11 +288,6 @@ unsigned long find_next_bit_le(const void *addr, unsigned
>  }
>  #endif
>  
> -#ifndef find_first_zero_bit_le
> -#define find_first_zero_bit_le(addr, size) \
> -	find_next_zero_bit_le((addr), (size), 0)
> -#endif
> -
>  #else
>  #error "Please fix <asm/byteorder.h>"
>  #endif
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 894b656f6836..f4d9b9684811 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -160,3 +160,17 @@ unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
>  	return offset;
>  }
>  EXPORT_SYMBOL(find_next_clump8);
> +
> +#ifdef __BIG_ENDIAN
> +#ifndef find_first_zero_bit_le
> +/*
> + * Find the first cleared bit in an LE memory region.
> + */
> +unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
> +{
> +	return FIND_FIRST_BIT(~addr[idx], swab, size);
> +}
> +EXPORT_SYMBOL(_find_first_zero_bit_le);
> +#endif
> +
> +#endif /* __BIG_ENDIAN */
> -- 
> 2.34.1

