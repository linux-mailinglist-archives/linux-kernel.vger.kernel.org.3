Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310285A55F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiH2VPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiH2VPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:15:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E211C26
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:15:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u6so11711047eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=c95gb6y0VFpG0AKV0K7SdSSrH1lyfJzEM7W94U2j5Hw=;
        b=PmSX3GHGOig78+8gw6wmGzzQiKP/whK3Vtn0Cr0cIDYHwTGl1sf3wZU3G110Q4bR9C
         3kZQAsDM1RehfkQubl7zYrgNLUW84PTXcma8ckW83wJMkzpaUrS3MkLBpbZie2IfpwPU
         KHs0RQctIkcsohVLiSQSyh8LYCeuTKW3dYV+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=c95gb6y0VFpG0AKV0K7SdSSrH1lyfJzEM7W94U2j5Hw=;
        b=Yueb5zAyZQ9VbOdpyI7qXvxRj3Cotcm9OoBmmSfzsB5kImdDCXe6NE5N6ASQ4sqrdn
         /wT3koTpUQ6ddnXEx9km0hmD40DFqZv4XBGPGMQMl55/G8cdfVUhPo5tnod6SW98hQen
         2Ftmy/R+5BS5idUU4+tqYu0CR4WlJi5cdIQ5dHA3526Kpvm4xjkl9VouBz4nT0mFpSaR
         craBGfX/nQlXR/InaM/31MKYys0PLQsuHXZx5gPm32zwVHXsi3VXUEOBBxgdHw9unGta
         2GAOpyOP5aR7cL3WRUyL6nbdsbk0y8x0JyAEGUIPummEnO6TEwlGofsqhhcprqt4qZa4
         QrHg==
X-Gm-Message-State: ACgBeo2aoFILceS+KyrZQ/DWrNk3L4RrDC8ulIF2BCHbgNX77Ekp42EY
        MtpErE5uP/uPBdpJfiK1WXyV9g==
X-Google-Smtp-Source: AA6agR5nhl6art1YTiXjA1XVl1eqh+H0E2p1WIOjqlw+Ylsgmo7ZspNTby3815vKiZ3QCp8UM5Ryiw==
X-Received: by 2002:a05:6402:551a:b0:446:1526:85ea with SMTP id fi26-20020a056402551a00b00446152685eamr18181664edb.188.1661807699459;
        Mon, 29 Aug 2022 14:14:59 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id n2-20020a170906088200b0073d678f50bfsm4870271eje.164.2022.08.29.14.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 14:14:58 -0700 (PDT)
Message-ID: <d325bf21-efa4-b3e9-a0d8-3662a9f7ab1a@rasmusvillemoes.dk>
Date:   Mon, 29 Aug 2022 23:14:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] overflow: Allow mixed type arguments
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel@vger.kernel.org
References: <20220829204729.3409270-1-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220829204729.3409270-1-keescook@chromium.org>
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

On 29/08/2022 22.47, Kees Cook wrote:
> When the check_[op]_overflow() helpers were introduced, all arguments were
> required to be the same type to make the fallback macros simpler. However,
> once the fallback macros were removed[1], it is fine to allow mixed
> types, which makes using the helpers much more useful, as they can be
> used to test for type-based overflows (e.g. adding two large ints but
> storing into a u8), as would be handy in the drm core[2].
> 
> Remove the restriction, and add additional self-tests that exercise some
> of the mixed-type overflow cases.

Makes sense. I'm a little worried about the implications for -stable
backports to kernels that can still be built with gcc < 5.1, but we
can't let that dictate what is done in mainline. And even people
building old kernels shouldn't be using ancient compilers.

>  
> -#define DEFINE_TEST_ARRAY(t)			\
> -	static const struct test_ ## t {	\
> -		t a, b;				\
> -		t sum, diff, prod;		\
> -		bool s_of, d_of, p_of;		\
> -	} t ## _tests[]
> +#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)		\
> +	static const struct test_ ## t1 ## t2 ## t {	\
> +		t1 a;					\
> +		t2 b;					\
> +		t sum, diff, prod;			\
> +		bool s_of, d_of, p_of;			\
> +	} t1 ## t2 ## t ## _tests[]

Can I get you to throw in some extra _, because this...

> +DEFINE_TEST_FUNC_TYPED(u32u32int, int, "%d");

...makes my eyes hurt a little. Maybe even make it u32_u32__int, so it's
emphasized that the order is [src op src -> tgt] and not [tgt = src op src].

Rasmus
