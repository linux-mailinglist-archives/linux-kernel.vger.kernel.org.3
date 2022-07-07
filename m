Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A6A569B7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiGGHZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGGHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:25:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E52214D1D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:25:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o7so511995lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 00:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=OeQUC2I7iJCMWcjTw5dbLAg4/W1Mty4WbVZ/J03hEOc=;
        b=LGNeE5ha4E4AzZNyOe9qYxZoAqDpmosEjj4z+pAZkVqOInemEKk12Bd9qN6T0enAfC
         nwzbECORkzo+dLXDCOjKjjQ4r9x561e29cy8R+xMpkUQNhwCtetqVXTE92LgWYlqM9fl
         GOB4hyP1leiLdCvOJYeB5wKjoDgm9iC+7AAfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OeQUC2I7iJCMWcjTw5dbLAg4/W1Mty4WbVZ/J03hEOc=;
        b=I7pwctnwnVGRj6jNvIIhfoiHZfCHxxQ8XJBvAoc4GbTXAFcxIKZ6OywGgldzGynLH7
         hm4Md0Vq2G7L9VZds2d2fuKpELcrgdLd9eHFX8+yWM+z1uZDHGYtjcw+34xTJj2JMGvu
         b+FqLq+ZeTuFUBzy7fEZS4wG20vXzY1/rNzn2yATdP87ykUt8Jf0zjesgmyxdMqrz+ES
         oMGsbKt8jZs8b2jkF78vHjdclgybFpUV1OY4r2am0f7ix4E/xVQuGmXpkmCFroCwgY09
         yVnvDd+UZ9O+NJ0T3n95HQfyLX0LiTWnqm2RLIe8vRwDZO6OLPFqJesE6lC5C0XcMGXh
         anDA==
X-Gm-Message-State: AJIora8Jzo06cH++1W6y3KQLDrbDYXFLbcLFRSgsmDdiKxPV8ohFfCs5
        zEXthcD/x1msDanYGETNv/+kTg==
X-Google-Smtp-Source: AGRyM1tgJOURuGijHWR+4rnJoab36+sEZz5x1CoTLQEi95gfkGiixqZ74vFWWkMjAU65xtPa8FvMWQ==
X-Received: by 2002:a05:6512:3ca1:b0:47f:6fe5:8bcc with SMTP id h33-20020a0565123ca100b0047f6fe58bccmr27582166lfv.505.1657178709922;
        Thu, 07 Jul 2022 00:25:09 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 23-20020a2e1557000000b0025d4d4b4edbsm300588ljv.34.2022.07.07.00.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 00:25:09 -0700 (PDT)
Message-ID: <423c4368-0a1c-792c-2637-768532fc7782@rasmusvillemoes.dk>
Date:   Thu, 7 Jul 2022 09:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/5] lib: add find_nth(,and,andnot)_bit()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20220706182300.70862-1-yury.norov@gmail.com>
 <20220706182300.70862-2-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220706182300.70862-2-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 20.22, Yury Norov wrote:
> Kernel lacks for a function that searches for Nth bit in a bitmap.
> Usually people do it like this:
> 	for_each_set_bit(bit, mask, size)
> 		if (--n == 0)
> 			return bit;
> 
> We can do it more efficiently, if we:
> 1. find a word containing Nth bit, using hweight(); and
> 2. find the bit, using a helper fns(), that works similarly to
>    __ffs() and ffz().
> 
> fns() is implemented as a simple loop. For x86_64, there's PDEP instruction
> to do that: ret = clz(pdep(1 << idx, num)). However, for large bitmaps the
> most of improvement comes from using hweight(), so I kept fns() simple.
> 
> New find_nth_bit() is ~70 times faster on x86_64/kvm:
> for_each_bit:                  7154190 ns,  16411 iterations
> find_nth_bit:                505493126 ns,  16315 iterations

Eh, have you interchanged these somehow, otherwise this reads as
find_nth_bit being ~70 times _slower_?

> With all that, a family of 3 new functions is added, and used where
> appropriate in the following patches.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/bitops.h | 19 ++++++++++
>  include/linux/find.h   | 79 ++++++++++++++++++++++++++++++++++++++++++
>  lib/find_bit.c         | 20 +++++++++++
>  3 files changed, 118 insertions(+)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 7aaed501f768..86072cfcbe17 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -196,6 +196,25 @@ static inline unsigned long __ffs64(u64 word)
>  	return __ffs((unsigned long)word);
>  }
>  
> +/**
> + * fns - find N'th set bit in a 64 bit word
> + * @word: The 64 bit word
> + * @n: Bit to find
> + */
> +static inline unsigned long fns(unsigned long word, unsigned int n)
> +{
> +	unsigned int bit;
> +
> +	while (word) {
> +		bit = __ffs(word);
> +		if (--n == 0)
> +			return bit;
> +		__clear_bit(bit, &word);
> +	}
> +
> +	return BITS_PER_LONG;
> +}

Urgh.  "unsigned long" is not necessarily a 64 bit word. And I don't
like that the index is apparently 1-based (and that surprising API isn't
spelled out anywhere). This is also way too big to be inline IMO.

>  #ifndef find_first_and_bit
>  /**
>   * find_first_and_bit - find the first set bit in both memory regions
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 1b8e4b2a9cba..7b8ad12c8cc7 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -89,6 +89,26 @@ unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
>  EXPORT_SYMBOL(_find_first_bit);
>  #endif
>  
> +unsigned long _find_nth_bit(const unsigned long *addr1, const unsigned long *addr2,
> +				unsigned long size, unsigned long n, bool not)
> +{
> +	unsigned long val, idx, w;
> +
> +	for (idx = 0; idx * BITS_PER_LONG < size; idx++, n -= w) {
> +		val = addr1[idx];
> +		if (addr2)
> +			val &= not ? ~addr2[idx] : addr2[idx];

Maybe this could be microoptimized by doing

unsigned long addr2mask = not ? ~0UL : 0UL;
...

  val &= (addr2[idx] ^ addr2mask);

but I don't think it'll make a difference.

Rasmus
