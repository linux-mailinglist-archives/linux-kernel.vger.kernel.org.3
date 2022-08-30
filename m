Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E425A6DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiH3Tw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiH3Twz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:52:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E0B7F0BC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:52:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so24358160ejy.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Sy+n+bKGaBE42tMW22JXIKGEDRgNGzu/p2SD3vodKvA=;
        b=OFP2zrlps/N/cK0IIDLM5wHfe8i+ddoBQoask/MkYh/KTe97GaoHc7x7ozWyEDrR+Y
         IZ1aHXqfIznrYyqwb/+hC1gSF2Wxxhw1OE41eqvPYxgHCxnMb9XX/qPrv6GAMMgedT+o
         hk/RAwaKnzwqLNF1P2fJHwIdJLtOWdqfYGKeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Sy+n+bKGaBE42tMW22JXIKGEDRgNGzu/p2SD3vodKvA=;
        b=fY8x1iQ8D6OC/a9/7GsfzDBFsgFKT+s56vp/0n4ouXahZF4KE+TlVy62wfQclrgne8
         qWsfJEr9aDr5sw6Xu9sXYvprlffMit9NGa34b9V/xriE+CsQQplj8q+P+iDzoQ1+6LW4
         x9c74BDNjPO5HNInyjV5sMtbXTIZ04gswm/C/vq/Sf25YNvVWEfK3Zdp4FJo6rcXmc6O
         AILW6CLWkqdmABeyuKDJPGOk4Rdu90USlQ8n9Zn4U5EK/fHIKHHNrPL4K2EMr2JztwC7
         auNGWNY7h5JA+/fyOarQIWfRJNRY5C2pLaNaogwJZuov3TBsSFH2tnMCiDAfHQRowMBY
         8r5Q==
X-Gm-Message-State: ACgBeo094p4VKxaW8CbAZY6Q5xoNSPo8YSpkmdxUqSpMDYuGHU0fdcvu
        AxxnDi2kLO8tsXC4zuwFtzuDfg==
X-Google-Smtp-Source: AA6agR6bctVYI2ptYwu/JLk6xOmy1Vimmt+zKVBzKu5rUwZvA93ALpahpIQKzZLVpdwXnlpMWg5vsg==
X-Received: by 2002:a17:906:730d:b0:73d:c8a1:a8ee with SMTP id di13-20020a170906730d00b0073dc8a1a8eemr18232325ejc.661.1661889154071;
        Tue, 30 Aug 2022 12:52:34 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060cd100b0073d81b0882asm6166941ejh.7.2022.08.30.12.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 12:52:33 -0700 (PDT)
Message-ID: <787894a0-b1b7-43c2-c509-f246f94f58f7@rasmusvillemoes.dk>
Date:   Tue, 30 Aug 2022 21:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] overflow: Allow mixed type arguments
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
References: <20220830192147.47069-1-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220830192147.47069-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 21.21, Kees Cook wrote:
> When the check_[op]_overflow() helpers were introduced, all arguments were
> required to be the same type to make the fallback macros simpler. However,
> now that the fallback macros have been removed[1], it is fine to allow
> mixed types, which makes using the helpers much more useful, as they
> can be used to test for type-based overflows (e.g. adding two large ints
> but storing into a u8), as would be handy in the drm core[2].
> 
> Remove the restriction, and add additional self-tests that exercise some
> of the mixed-type overflow cases, and double-check for accidental macro
> side-effects.
> 

> -/*
> - * For simplicity and code hygiene, the fallback code below insists on
> - * a, b and *d having the same type (similar to the min() and max()
> - * macros), whereas gcc's type-generic overflow checkers accept
> - * different types. Hence we don't just make check_add_overflow an
> - * alias for __builtin_add_overflow, but add type checks similar to
> - * below.
> +/** check_add_overflow() - Calculate addition with overflow checking
> + *
> + * @a: first addend
> + * @b: second addend
> + * @d: pointer to store sum
> + *
> + * Returns 0 on success.
> + *
> + * *@d holds the results of the attempted addition, but is not considered
> + * "safe for use" on a non-zero return value, which indicates that the
> + * sum has overflowed or been truncated.

I don't like that wording. It makes it sound like there's some ambiguity
or (implementation|un)-definedness involved in what the destination
holds on overflow. The gcc documentation is perfectly clear that the
result is the infinite-precision result truncated to N bits, with N
being the bitwidth of d.

Rasmus
