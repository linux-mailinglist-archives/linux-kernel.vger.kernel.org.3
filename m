Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1630F5507DF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 03:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiFSB01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 21:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSB00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 21:26:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7172E1056C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 18:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=euKIZ9IgbDaC+OfkObqzZINVrsFI0co0qLhenN8WQMM=; b=YmLpcdJFaQqpzF8D1nuv/08xLy
        YALZWykuWb1sZaPUCN80w+vc/2mh0iBq6Gy2mZh2qfq9qDYWbC4lta9zDFJeiDjPxUT7HvF4SrBC9
        sb0FqqDMyMEzcDf+wUTY+GdsJ+ih18q8v+KaQ1CrACU3GWdFI8pD0JW67Nt7Ep8qUm0jAq2VY5MFK
        aiot1RhxcBWRCav+IZWb7kbazwpK9D+XjK9Bnm4PRVZt8TaFHFRh6RCcEwtd7UgsmozsCkzCXI8H/
        N9v1UE6qNP8WtJ5wfo1biYnvKRJA5JXUHNhFf+6ItS+0V5xoaxt6TI2UHUmjGoVqEwTNjhAv5x7WG
        Sjlk74Ig==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2jhj-00954T-Sm; Sun, 19 Jun 2022 01:26:20 +0000
Message-ID: <3e720964-6f71-b325-8929-874e61666892@infradead.org>
Date:   Sat, 18 Jun 2022 18:26:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/5] rslib: Fix integer overflow on large fcr or prim
Content-Language: en-US
To:     Zhang Boyang <zhangboyang.id@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Ivan Djelic <ivan.djelic@parrot.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20220617144624.158973-1-zhangboyang.id@gmail.com>
 <20220617144624.158973-6-zhangboyang.id@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220617144624.158973-6-zhangboyang.id@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--


Somehow some of the kernel-doc notation in these files has been
entered incorrectly and you are propagating that mistake...
Please see below for more.


On 6/17/22 07:46, Zhang Boyang wrote:

> Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
> ---
>  include/linux/rslib.h           | 22 ++++++++++++
>  lib/reed_solomon/decode_rs.c    | 60 +++++++++++++++++++--------------
>  lib/reed_solomon/reed_solomon.c | 30 ++++++++++++-----
>  lib/reed_solomon/test_rslib.c   |  8 ++---
>  4 files changed, 82 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/rslib.h b/include/linux/rslib.h
> index 44ec7c6f24b2..29abfb2de257 100644
> --- a/include/linux/rslib.h
> +++ b/include/linux/rslib.h

> @@ -127,6 +129,26 @@ static inline int rs_modnn(struct rs_codec *rs, int x)
>  	return x;
>  }
>  
> +/** modulo replacement for galois field arithmetics

/**
 * rs_modnn_mul() - modulo replacement for galois field arithmetics

> + *
> + *  @rs:	Pointer to the RS codec
> + *  @a:		0 <= a <= nn ; a*b is the value to reduce
> + *  @b:		0 <= b <= nn ; a*b is the value to reduce
> + *
> + *  Same as rs_modnn(a*b), but avoid interger overflow when calculating a*b

                                        integer                            a * b


> +*/
> +static inline int rs_modnn_mul(struct rs_codec *rs, int a, int b)
> +{
> +	/* nn <= 0xFFFF, so (a * b) will not overflow uint32_t */
> +	uint32_t x = (uint32_t)a * (uint32_t)b;
> +	uint32_t nn = (uint32_t)rs->nn;
> +	while (x >= nn) {
> +		x -= nn;
> +		x = (x >> rs->mm) + (x & nn);
> +	}
> +	return (int)x;
> +}
> +
>  /** modulo replacement for galois field arithmetics

/**
 * rs_modnn() - modulo replacement for galois field arithmetics

>   *
>   *  @rs:	Pointer to the RS codec



-- 
~Randy
