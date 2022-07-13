Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB85573CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiGMSts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiGMStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:49:45 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71DE22BD4;
        Wed, 13 Jul 2022 11:49:44 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x17so9288339qkh.11;
        Wed, 13 Jul 2022 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ac/zHorwJ1M3lUZTiNG0DQYXnRmLn4IPfR2BYRJ5PjE=;
        b=imphX0xJW2c42aqSs9a/4kjeQ6+NKwMHBuSLWuusfH/ZuT+loYPGkDEydesS8+HMgi
         v5WQEPHBxB8y/BFWyMR3lrHYw2QGnqlkVKwzMSoqXUktMdJk4W+BSn9C5oS9c81dZvlj
         lhTihtftmbMLiV2Dwj92he6RrIwuvzXUXI0lZzYe3cS/M6PQ7FEoFCAoXn4Nw3HTlZCJ
         fM90kVJJAZei5XGwHOBu84J1veCNvTxUx8+tTISxTBqtyMozAHCP4goTuMeK5lhUS7Ua
         lzvNOS4lDqeTCPLOXLmVBuO0+BoNBBtzWrrRhphJzdv1X+5TFWCxrqIW25YuC6TMVEuu
         6qxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ac/zHorwJ1M3lUZTiNG0DQYXnRmLn4IPfR2BYRJ5PjE=;
        b=iOFUYhxmwvSNS1xDIKhz9/PWc4ykuEzKKSrzOiPNjUsLE8WQOxrKtz1plndpctj+uA
         IZoBPknBw6Y6vI4xcc6PNh07aBgHqWTXMbdlL5EDAwZQzPXg2VSO+mNVSAP+/m6dQ9RE
         5+ni0Bb/UEstP6kF6UQV9g73C3hcXSzrytOiuzEoMJeBVdmqMLO0h4roUmdTH4yijQtW
         gbYyBCDKl0PAABG4w5KPHsAI/PJTBdo7NayT1Awfyh1ARxM/yRScq+0UAlNY5Xp1TbLS
         l8uYvskPg8h2EndPRrTWFA3m4bdX8/c8uN+lms809ub3neL3XUSR4DC1+SwKyy5pao8O
         CJOw==
X-Gm-Message-State: AJIora8DedXVKr/0J+lcymR0PYDg7CZQNUmQVJhk6RnzkEBQ3CtLo7xD
        pFyqkxbvpgT/utBmjnxxvv8=
X-Google-Smtp-Source: AGRyM1uuMUkSEhOm9nsb7u1Dmf4UoquKHjmYlPE6PjGpviT9D2ecZrPKkPp/kNmSOW4seT0hGsJMVA==
X-Received: by 2002:a05:620a:258a:b0:6a7:9479:655e with SMTP id x10-20020a05620a258a00b006a79479655emr3179792qko.681.1657738183706;
        Wed, 13 Jul 2022 11:49:43 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:7360:5d5d:6684:e04b])
        by smtp.gmail.com with ESMTPSA id x26-20020a05620a0b5a00b006b57ef4dd92sm9450731qkg.54.2022.07.13.11.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 11:49:43 -0700 (PDT)
Date:   Wed, 13 Jul 2022 11:49:42 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     linux-media@vger.kernel.org, jernej.skrabec@gmail.com,
        knaerzche@gmail.com, kernel@collabora.com,
        bob.beckett@collabora.com, ezequiel@vanguardiasur.com.ar,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, nicolas.dufresne@collabora.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/6] bitops: bitmap helper to set variable length values
Message-ID: <Ys8Txuq9/u/EL6sj@yury-laptop>
References: <20220713163201.136202-1-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713163201.136202-1-sebastian.fricke@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 06:31:59PM +0200, Sebastian Fricke wrote:
> Add a new helper to set variable length values within a bitmap, that can
> overflow the borders of a single BITS_PER_LONG container.
> This function makes it easier to write values to hardware memory blobs that
> do not require alignment.
> 
> Add tests to the lib/test_bitmap.c kselftest module to verify proper function.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  include/linux/bitmap.h | 40 +++++++++++++++++++++++++++++++++++
>  lib/test_bitmap.c      | 48 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 2e6cd5681040..9f8d635b70a9 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -76,6 +76,7 @@ struct device;
>   *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
>   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
>   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> + *  bitmap_set_value(map, value, start, nbits)  Set a variable length value to map at start
>   *
>   * Note, bitmap_zero() and bitmap_fill() operate over the region of
>   * unsigned longs, that is, bits behind bitmap till the unsigned long
> @@ -573,6 +574,45 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
>  	map[index] |= value << offset;
>  }
>  
> +/**
> + * bitmap_set_value - set a variable length value within a memory region
> + * @map: address to the bitmap memory region
> + * @value: the variable length value
> + * @start: bit offset of the value
> + * @length: Length of the value

There's no such thing like a length of value. Data structures and
types have size, and arrays have length.

> + */
> +static inline void bitmap_set_value(unsigned long *map, unsigned long value,
> +				    unsigned long start, unsigned char length)
> +{
> +	size_t index = BIT_WORD(start);
> +	unsigned long offset = start % BITS_PER_LONG;
> +	int diff_to_max = 0;
> +
> +	if (!length)
> +		return;
> +
> +

2nd empty line is not needed. Actually, all this chunk is not needed
because 'while (length > 0)' will do the work.

> +	if (length < BITS_PER_LONG)
> +		value &= (BIT(length) - 1);
> +
> +	while (length > 0) {
> +		diff_to_max = BITS_PER_LONG - offset;
> +		map[index] &= ~((BIT(length) - 1) << offset);
> +		if (length > diff_to_max) {
> +			unsigned long tmp = value & (BIT(diff_to_max) - 1);

We have GENMASK() for this.

> +
> +			map[index] |= tmp << offset;
> +			value >>= diff_to_max;
> +			length -= diff_to_max;
> +			index += 1;
> +			offset = 0;
> +		} else {
> +			map[index] |= value << offset;
> +			length = 0;
> +		}
> +	}

I have a strong feeling that this can be written much simpler...

But anyways, this is not suitable for generic bitmaps because this
bitmap_set_value() is limited with a single words. All bitmap functions
that copy data to/from bitmap are able to work with bigger chunks. (With
the exception of bitmap_{set,get}_value8, which doesn't allow unaligned
accesses.)

What you want is to copy bits to the dst bitmap starting from the offset,
right? It's very similar to what bitmap_set() does, except that it always
'copies' ~0UL.

I'd suggest you to try implementing
        bitmap_copy_from(dst, src, dst_off, len) 
or even
        bitmap_copy_from(dst, dst_off, src, src_off, len) 
if you expect that you'll need more flexibility in the future.

This bitmap_copy_from() may be based, for example, on extended version
of __bitmap_set():
void __bitmap_set(unsigned long *dst, unsigned long *src, unsigned int start, int len)

Thanks,
Yury

> +}
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* __LINUX_BITMAP_H */
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index d5923a640457..509317ad2f72 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -869,6 +869,53 @@ static void __init test_bitmap_print_buf(void)
>  	}
>  }
>  
> +struct test_bitmap_set_value_sample {
> +	unsigned long value[2];
> +	unsigned char length[2];
> +	unsigned int offset[2];
> +	unsigned long expected[2][2];
> +	int amount;
> +};
> +
> +static const struct test_bitmap_set_value_sample test_set[] __initconst = {
> +	/* Check that multiple values can be chained up */
> +	{ {10, 20}, {4, 5}, {0, 4}, {{10, 330}}, 2 },
> +	/* Check that a value can be set across two BITS_PER_LONG chunks */
> +	{ {10, 6}, {4, 3}, {0, 63}, {{10, 10}, {0, 3}}, 2 },
> +	/* Set a value with length shorter than the given length */
> +	{ {3, 6}, {4, 10}, {0, 4}, {{3, 99}}, 1 },
> +	/* Set a value with length longer than the given length */
> +	{ {15}, {2}, {0}, {{3}}, 1 },
> +	/* Check that values are properly overwritten */
> +	{ {15, 12}, {4, 4}, {0, 2}, {{15, 51}}, 2 },
> +	/* Check that a set without a length doesn't change anything */
> +	{ {10}, {0}, {0}, {{0}}, 1 },
> +};
> +
> +static void __init test_bitmap_set_value(void)
> +{
> +	int i, j, k;
> +	int correct_tests = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(test_set); i++) {
> +		const struct test_bitmap_set_value_sample *t = &test_set[i];
> +		int test_correct = 1;
> +		DECLARE_BITMAP(map, BITS_PER_LONG * 2);
> +
> +		bitmap_zero(map, BITS_PER_LONG * 2);
> +		for (j = 0; j < t->amount; j++) {
> +			bitmap_set_value(map, t->value[j], t->offset[j], t->length[j]);
> +			for (k = 0; k < 2; k++) {
> +				if (expect_eq_uint(map[k], t->expected[k][j]))
> +					test_correct = 0;
> +			}
> +		}
> +		if (test_correct)
> +			correct_tests += 1;
> +	}
> +	pr_err("set_value: %d/%ld tests correct\n", correct_tests, ARRAY_SIZE(test_set));
> +}
> +
>  static void __init selftest(void)
>  {
>  	test_zero_clear();
> @@ -884,6 +931,7 @@ static void __init selftest(void)
>  	test_for_each_set_clump8();
>  	test_bitmap_cut();
>  	test_bitmap_print_buf();
> +	test_bitmap_set_value();
>  }
>  
>  KSTM_MODULE_LOADERS(test_bitmap);
> -- 
> 2.25.1
