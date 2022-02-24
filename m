Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97D4C2910
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiBXKOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiBXKOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:14:47 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4658928B61E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:14:18 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id g23so2725466qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+KjkkeImUI9MYip2G2L/AqVkgEagftFFhyJYB4CQfXo=;
        b=lTInkOBH5DxMaG5Q3erZww/shegPeYy5E104sq/GOqx7XxJEYE6xNN3ZhkqHjQTPMi
         buH5n3cDcdkUMa4PQ+EysSjchxm1Ej1VognzrG0QmYnKMYSaVZz4GPd2SFNVwcGeHVKd
         ybP+w2nmuiHRYDf1OusAvMKe3mFmd8WRVxlorNQTbdI6FF45gzVhTZSwvp1lVdJGSP6+
         YoW1GP0LjmhcPDRm0wXYMDKdAYrwzONpdSVmcI0Lq8Xr9+GiRw01HKFo6g4gXAHwUFHZ
         20Fb435KxveXZwuAy7gvnuktmm93m2OBa22JSl+0T9d+sVGQtxSex59+vJFPTnQwGQvE
         rUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+KjkkeImUI9MYip2G2L/AqVkgEagftFFhyJYB4CQfXo=;
        b=byQ4rQtrn9LrxfhJX4AuKdQ9A/h3rvnlf77K7oCAwNxjGHvDWsqnb7eFl1ittgWxQm
         DiQNRy01pMcHZM0CV6QWw1mxpsi31kydP9BfKaJbBKkkN5yltQ+CwO4fYGMQURBeaJR7
         TTW2fvS8t8BWaSlu2s7S80sPeXS4mlKfl3fSZeeSIwWPk5HrFsp704/RewsCyXVzUNcz
         xCOTbVRI4p8tte7uKrSC3s+3uAoTjWnUEfNnVQ5emqYuYffWYE6ko2kxMinypHe1TIh2
         ZT6nh3D56giArW6JukxoAiuhmlZXOGfI0xowoOFofBT6QGfw7qt3pLjvuKvwdDerlgWb
         OPOg==
X-Gm-Message-State: AOAM532tKx/jDptrEAfnZatqxlYm2jeuiB9KRtKDXCneSvpNhm28FHUA
        vTvULJIT9eFBkhXuBJNWgIHun1twS74=
X-Google-Smtp-Source: ABdhPJxn5EUrDjaC+0i6CzkyXlS/H7T0XFdaclqtUnt/0iDSlHJ88SBRVaR38z6a25AFrEwxIYhh5w==
X-Received: by 2002:a05:6214:29cc:b0:42d:f63c:f3f4 with SMTP id gh12-20020a05621429cc00b0042df63cf3f4mr1238627qvb.87.1645697657388;
        Thu, 24 Feb 2022 02:14:17 -0800 (PST)
Received: from auth2-smtp.messagingengine.com ([66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i22sm1260647qtm.46.2022.02.24.02.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 02:14:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0420827C005B;
        Thu, 24 Feb 2022 05:14:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 24 Feb 2022 05:14:13 -0500
X-ME-Sender: <xms:c1oXYuxoNUj0LqdpHLVB3ZA92itS0t6q7isvO7c7RItT9lOh_UP-aA>
    <xme:c1oXYqTQh2T8S-7pfB5h52IoDnQwtp8Lc6dwLsVGUcyfPBoqNdQ4ZvDlkVwc4Lr2z
    lcjhVMBoiOrov2yTQ>
X-ME-Received: <xmr:c1oXYgWG11n95aYotYpnqa802d4i1gMQyOdMPiNPUkHy5aXPQElCJG2ptrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledvgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:c1oXYkj6qwoo8hEAuD1vfdWbeTSbEIFKZLAnXs8hAUy7uFNMNpeIYQ>
    <xmx:c1oXYgAFunQqA9ag0Igj84LJsXysiTzvA_mCAMKDrbmH0FDsAD-U3A>
    <xmx:c1oXYlK9mPANCJIMx1SM4cw0ZoxMzIK5OlmM8cnzOA8HTnaQBTTsMw>
    <xmx:dFoXYgs9VJObb6mTohVcM7DeLj6p1bS-ErDu0QXQkuJ7OpsIqKCD4F29s7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Feb 2022 05:14:11 -0500 (EST)
Date:   Thu, 24 Feb 2022 18:13:25 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Junru Shen <hhusjrsjr@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Put the fetching of the old value into the loop
 when doing atomic CAS
Message-ID: <YhdaRd1czxuBPuiU@boqun-archlinux>
References: <20220224082438.580191-1-hhusjrsjr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224082438.580191-1-hhusjrsjr@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 24, 2022 at 04:24:38PM +0800, Junru Shen wrote:
> Put the acquisition of the expected value inside the loop to prevent an infinite loop when it does not match.
> 

Is there a small test showing a infinite loop can really happen? If so,
have you tested it?

Note that arch_atomic64_try_cmpxchg() will refresh 'val' if the previous
value doesn't match the content of 'v'.

Regards,
Boqun

> Signed-off-by: Junru Shen <hhusjrsjr@gmail.com>
> ---
>  arch/x86/include/asm/atomic64_64.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
> index 7886d0578..3df04c44c 100644
> --- a/arch/x86/include/asm/atomic64_64.h
> +++ b/arch/x86/include/asm/atomic64_64.h
> @@ -207,9 +207,10 @@ static inline void arch_atomic64_and(s64 i, atomic64_t *v)
>  
>  static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
>  {
> -	s64 val = arch_atomic64_read(v);
> +	s64 val;
>  
>  	do {
> +		val = arch_atomic64_read(v);
>  	} while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
>  	return val;
>  }
> @@ -225,9 +226,10 @@ static inline void arch_atomic64_or(s64 i, atomic64_t *v)
>  
>  static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
>  {
> -	s64 val = arch_atomic64_read(v);
> +	s64 val;
>  
>  	do {
> +		val = arch_atomic64_read(v);
>  	} while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
>  	return val;
>  }
> @@ -243,9 +245,10 @@ static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
>  
>  static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
>  {
> -	s64 val = arch_atomic64_read(v);
> +	s64 val;
>  
>  	do {
> +		val = arch_atomic64_read(v);
>  	} while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
>  	return val;
>  }
> -- 
> 2.30.2
> 
