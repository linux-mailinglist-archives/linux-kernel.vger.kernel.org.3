Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527B25507E0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 03:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiFSB3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 21:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSB3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 21:29:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4C2BF68
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wJvLT1c8CzvaCbjAqSrrU8ZMfJVjFlEKkFEGB+jSVpA=; b=NspeGK5dueUIwd4z2ejduabl/v
        v0f9FSbrGqdt6x1vMdJq4YkaQexvMJz/9aZ7XVZ7PgfAMpe0K8Nr6Qq8y3t1y9bW2sd7MiRpZ4Xgf
        YItaK/P952nj6pufKSeyAO0GH4DN7eGXFcqOFjteJX0moip2Rptqbfxtjtt0Z2ghCUt0V+77rRRaG
        DHcodaMaXOL9AdL5jqLnSrO3Vc3WV3CqLlo/7gig5bLgbz69GB5mhBMk5s5Sg2ceYXQgHbPom1vMD
        sdzi5wsnDdppqi8Nt+l6xCEdO0jnMKyyuEavWm8/zRtjVDy2jurebOwTpXtS230lzgP8idNfXy+G9
        uBiwNt2A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2jki-00956s-Dz; Sun, 19 Jun 2022 01:29:24 +0000
Message-ID: <a31155a7-d7f4-2825-1e84-bb8a51815edd@infradead.org>
Date:   Sat, 18 Jun 2022 18:29:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/5] rslib: Improve the performance of encode_rs.c
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
 <20220617144624.158973-5-zhangboyang.id@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220617144624.158973-5-zhangboyang.id@gmail.com>
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

On 6/17/22 07:46, Zhang Boyang wrote:
> Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
> ---
>  include/linux/rslib.h        | 14 +++++++++++++-
>  lib/reed_solomon/encode_rs.c | 21 ++++++++++-----------
>  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/rslib.h b/include/linux/rslib.h
> index cd0b5a7a5698..44ec7c6f24b2 100644
> --- a/include/linux/rslib.h
> +++ b/include/linux/rslib.h
> @@ -110,7 +110,7 @@ void free_rs(struct rs_control *rs);
>  /** modulo replacement for galois field arithmetics
>   *
>   *  @rs:	Pointer to the RS codec
> - *  @x:		the value to reduce
> + *  @x:		x >= 0 ; the value to reduce
>   *
>   *  where
>   *  rs->mm = number of bits per symbol
> @@ -127,4 +127,16 @@ static inline int rs_modnn(struct rs_codec *rs, int x)
>  	return x;
>  }
>  
> +/** modulo replacement for galois field arithmetics

/**
 * rs_modnn_fast() - modulo replacement for galois field arithmetics

> + *
> + *  @rs:	Pointer to the RS codec
> + *  @x:		0 <= x < 2*nn ; the value to reduce
> + *
> + *  Same as rs_modnn(x), but faster, at the cost of limited value range of @x
> +*/
> +static inline int rs_modnn_fast(struct rs_codec *rs, int x)
> +{
> +	return x - rs->nn < 0 ? x : x - rs->nn;
> +}
> +
>  #endif

-- 
~Randy
