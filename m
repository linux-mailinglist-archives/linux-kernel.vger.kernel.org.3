Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F0356D12D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 22:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGJUBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 16:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGJUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 16:01:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B91401C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 13:01:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so5651569lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7YoqndOtMglUB1n+cldYQvjAktJGnYNQ0BT097QYxpE=;
        b=plb/bxUPIzTn+FPkMvWABI9QRSZUmTGIdxbyluYnExAhrOmTy/KW6uPS4jX7TsFAvA
         /LNn3WxSRTF0xWxmCALfUvkU9bO85Jccy0abz9xo3aJLuS0X8QLeUzr4vyktl5bU1P99
         cUIGd++UKB4Tni9eKwWqKaPa3zWPVBzbPfDqW8DAK9K+ef/uHjUw50Y9FeH06NrBsFoA
         tgTLMavB7ILBQ5EPEQhAYU3SUVgGwvHm5pJwDhL/pItUU47Q4z82l5MKcEGyw+JUWekV
         lQvFuOddFhqyWy+gK1442y1FzIVwDsReySO7HQrw7BgHGFPf865PRyJmWqLQmO30s3ex
         S/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7YoqndOtMglUB1n+cldYQvjAktJGnYNQ0BT097QYxpE=;
        b=J5OZe3BV7OPbjAoS6NNJkkh/hCLDsnoxlco4Gfv3cmeuVNRpqf79HhNbRQCuYIMfKf
         XuEkbZjlcmTo2ARWdQvSRgqAtIv0NNX+8b+Dy6qbWOKXqXN9s7mWVyfSUeYFOIlxU5LK
         r2sLzJU0GGK23uq2QB5xoqg0AGmrOYpExCSzE/8EN/pRvtwVxPtGSad17MBxywePLdfo
         XzwvcSHbCX2hZFnfFD9ifvhrFfKSLAC1peIQ39KITVR59mVMI7Cqn3YXGBvPnfIdBkJK
         CCw/U6WUy9m89EsbFapenzouP0PaFxgbwcF0RxBXQN1JemlXSN0yQiAnb8r/b0gJncsT
         zHxw==
X-Gm-Message-State: AJIora+6mR5z3Mi62ioxGKdVigVUjrC90owNG7FgTRj5J7UIkLFS6HIp
        kTR7qk0/sq+zkOtSXrtCxSs=
X-Google-Smtp-Source: AGRyM1uv1FauIGSKS25sHcVQGBnR2tSLCGqfcxlJYG27esaZiy3Cy5Chqzv6tDz9Pq9gbMumXXYa8w==
X-Received: by 2002:a19:6754:0:b0:489:c7ff:10e1 with SMTP id e20-20020a196754000000b00489c7ff10e1mr6685737lfj.585.1657483267391;
        Sun, 10 Jul 2022 13:01:07 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-32-106-30.ip.moscow.rt.ru. [188.32.106.30])
        by smtp.gmail.com with ESMTPSA id a18-20020ac25e72000000b00489d18e39bfsm669481lfr.288.2022.07.10.13.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 13:01:06 -0700 (PDT)
Message-ID: <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
Date:   Sun, 10 Jul 2022 23:01:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
Content-Language: en-US
To:     Yu-Jen Chang <arthurchang09@gmail.com>, andy@kernel.org,
        akinobu.mita@gmail.com
Cc:     jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com>
From:   Andrey Semashev <andrey.semashev@gmail.com>
In-Reply-To: <20220710142822.52539-3-arthurchang09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 17:28, Yu-Jen Chang wrote:
> The original version of memchr() is implemented with the byte-wise
> comparing technique, which does not fully use 64-bits or 32-bits
> registers in CPU. We use word-wide comparing so that 8 characters
> can be compared at the same time on CPU. This code is base on
> David Laight's implementation.
> 
> We create two files to measure the performance. The first file
> contains on average 10 characters ahead the target character.
> The second file contains at least 1000 characters ahead the
> target character. Our implementation of “memchr()” is slightly
> better in the first test and nearly 4x faster than the orginal
> implementation in the second test.
> 
> Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
> Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> ---
>  lib/string.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/lib/string.c b/lib/string.c
> index 80469e6c3..8ca965431 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -905,21 +905,35 @@ EXPORT_SYMBOL(strnstr);
>  #ifndef __HAVE_ARCH_MEMCHR
>  /**
>   * memchr - Find a character in an area of memory.
> - * @s: The memory area
> + * @p: The memory area
>   * @c: The byte to search for
> - * @n: The size of the area.
> + * @length: The size of the area.
>   *
>   * returns the address of the first occurrence of @c, or %NULL
>   * if @c is not found
>   */
> -void *memchr(const void *s, int c, size_t n)
> +void *memchr(const void *p, int c, unsigned long length)
>  {
> -	const unsigned char *p = s;
> -	while (n-- != 0) {
> -        	if ((unsigned char)c == *p++) {
> -			return (void *)(p - 1);
> +	u64 mask, val;
> +	const void *end = p + length;
> +
> +	c &= 0xff;
> +	if (p <= end - 8) {
> +		mask = c;
> +		MEMCHR_MASK_GEN(mask);
> +
> +		for (; p <= end - 8; p += 8) {
> +			val = *(u64 *)p ^ mask;

What if p is not aligned to 8 (or 4 on 32-bit targets) bytes? Not all
targets support (efficient) unaligned loads, do they?

> +			if ((val + 0xfefefefefefefeffu) &
> +			    (~val & 0x8080808080808080u))
> +				break;
>  		}
>  	}
> +
> +	for (; p < end; p++)
> +		if (*(unsigned char *)p == c)
> +			return (void *)p;
> +
>  	return NULL;
>  }
>  EXPORT_SYMBOL(memchr);

