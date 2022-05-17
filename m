Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FE45299E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiEQGuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbiEQGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:50:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452FA46B39
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:49:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j4so29599673lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 23:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tXf1VE+oJvTEiIT6svF00qzJ8evEqS/nvgKEwiauDqU=;
        b=CpNzr4CKHE7AFz6MuTLkdaUf+VlP16Vc1AyqZu0fTWG3XRb23SA1eol3Q+64Q3u6sG
         txtfVWEG1G+Nfwfl35rCOcV3q2eTrggOec5JN+4lWlvXJjc2Pultie40krbj9eKAZFFo
         x/xgI+Q9mQKB0XNjIS4B0ttKF0F39qg84+1YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tXf1VE+oJvTEiIT6svF00qzJ8evEqS/nvgKEwiauDqU=;
        b=wZ8ul5TnXeDpWHaXVOeAH4ksJfoGRBHajO3qWf8e2ZdXm9ppETDM6dmxO254WjHJ6R
         yduYimaJEZvPCO8mI6OFxyI3Rnd/o4a/I86CMGr9+Xxe3RPYlURGfKwySU6vCt24TR3H
         UXXy6ugSvaV7HsTz4HnLKkkDGi0BNoqsIpNsbva5SwBlcsy0Yugyq1osFpOPS9h0J9/l
         U4vUQ0QAZ+iFZfi78MhuN3cMOcNitcHDFasw7ehaL75YCnycB9RZt+5JX5Dw5F2Il775
         1adP/pLtCn71oVZQgRb0fi2UbD7Zx/dJFgphoPtP4GT7fWkhRAjsD1LsY00oIaOqEquf
         4Dgw==
X-Gm-Message-State: AOAM53267aWxUh7SGRrs2+hBzzuPCzCPxRqNsXr5m1lwxhWrydbZ2dZS
        tJ+uWwJtAFZk7PIk7pvoZGWo0A==
X-Google-Smtp-Source: ABdhPJzCa92KXp5gbI9JVDR6zFpKydftORWSJbKKVpPjiqlmWmtND/Jrbsga7ENjAW0aatVQThIKUg==
X-Received: by 2002:a05:6512:553:b0:472:205b:97ba with SMTP id h19-20020a056512055300b00472205b97bamr15773999lfl.314.1652770180562;
        Mon, 16 May 2022 23:49:40 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w7-20020ac25987000000b0047426f59b33sm1493260lfn.252.2022.05.16.23.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 23:49:39 -0700 (PDT)
Message-ID: <b443e5d7-0803-cfa4-89ab-dec1637953bf@rasmusvillemoes.dk>
Date:   Tue, 17 May 2022 08:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] bitmap: Fix return values to be unsigned
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220517035411.31144-1-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220517035411.31144-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 05.54, Kees Cook wrote:
> Both nodemask and bitmap routines had mixed return values that provided
> potentially signed results that could never happen. This was leading to
> the compiler getting confusing about the range of possible return values
> (it was thinking things could be negative where they could not be). Fix
> all the nodemask and bitmap routines that should be returning unsigned
> (or bool) values. Silences GCC 12 warnings:

So, for the bitmap functions themselves, makes sense, and then also for
the nodemask functions which are merely wrappers around the bitmap
functions (or wrappers around wrappers ...). But see below.

>  
>  #define first_node(src) __first_node(&(src))
> -static inline int __first_node(const nodemask_t *srcp)
> +static inline unsigned int __first_node(const nodemask_t *srcp)
>  {
> -	return min_t(int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
> +	return min_t(unsigned int, MAX_NUMNODES, find_first_bit(srcp->bits, MAX_NUMNODES));
>  }

Unrelated to the type change, but what's that min() doing there in the
first place? Doesn't find_first_bit() already return the nbits argument
if no "first bit" exists (i.e., the bitmap is empty)?

>  #define next_node(n, src) __next_node((n), &(src))
> -static inline int __next_node(int n, const nodemask_t *srcp)
> +static inline unsigned int __next_node(int n, const nodemask_t *srcp)
>  {
> -	return min_t(int,MAX_NUMNODES,find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
> +	return min_t(unsigned int, MAX_NUMNODES, find_next_bit(srcp->bits, MAX_NUMNODES, n+1));
>  }

Same here and a few more places.

It seems to go all the way back to pre-git. Hm. Could be cleaned up
separately I guess.

>  
>  #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
> -extern int node_random(const nodemask_t *maskp);
> +extern unsigned int node_random(const nodemask_t *maskp);

So this one I'm not convinced about. It has a documented return value of
NUMA_NO_NODE aka -1 if the mask is empty. And since it's not a wrapper
around a corresponding bitmap_random() (which would presumably, did it
exist, use the "return nbits if empty" convention), there's no
compelling reason to make its return type unsigned.

>  
> @@ -18,9 +18,9 @@ EXPORT_SYMBOL(__next_node_in);
>   * Return the bit number of a random bit set in the nodemask.
>   * (returns NUMA_NO_NODE if nodemask is empty)
>   */
> -int node_random(const nodemask_t *maskp)
> +unsigned int node_random(const nodemask_t *maskp)
>  {
> -	int w, bit = NUMA_NO_NODE;
> +	unsigned int w, bit = NUMA_NO_NODE;
>  
>  	w = nodes_weight(*maskp);
>  	if (w)

Rasmus
