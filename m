Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5361E47B21E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhLTRaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhLTRaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:30:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0609C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:30:09 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so2661646pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PUvbLVkiRS1LwgpEtlQV/91YudJQ+iPDO7eUaVDQjzw=;
        b=kwoHClqLNDIw4H+HOOMjAlMsUJCnVmcw9nCRsc2EHa2IXPkHbHUFaBMVEWIZmC+Bv/
         fePaIhQa6UEMcACrtrRB3155SGtCTETnqT+lkcMdYFO7BRDbTrt7IFUPty4dF2/S063b
         P9+VuGZzIrgjievAOba6xTeJjGm5N9ErzDUtcT+O4LeSreTD+KkYHID34REEO9UaPNSf
         K7WljHjHNckWaHtgDii1GD51GxtN8EAZwiTZlmyyzU8xPhxOJgBqdb8M790TAbJdKoQs
         c/h6/C6K/a0OqBo36K4R0Yvb3KL5tiAi1fM9eYapGYttRJd/jfZ8G1gtMcH8YymKF9eg
         1j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PUvbLVkiRS1LwgpEtlQV/91YudJQ+iPDO7eUaVDQjzw=;
        b=f5euORJhr+2mJ8mnS/eqGYqaPh/GowYJISaPDn0a7rWmMBBwu6s33RuILnj5/FYyGw
         XrKshzcv2FyCBTDQI3QNCguNKtS4aj0B7M6Rno7SUr/RhufMwpf8tQWzK8hDF5L8G0J/
         3nPyjBE0c3Ir+nF91odptJwXNIldNbk7qpRyMGk3mYUctJp//QA868uYWY39WNZnaPCt
         3SIOTw5q9NbNAvR4S2a3e+oliAnylXn1XqxRBNz3nSlKyVBKLl15k/vybL1MrsmN2Lmj
         kloL+g7etpVQsqrhHK7bpijVkGjDV2zJ2gUdWdyq8lJ/cIx7Jd7uJSQLUSc1UG/DPM5Y
         n7fA==
X-Gm-Message-State: AOAM530lX62hUtXqrGh5USnLsUFzt/6X/fAmqFz4zgLEvL3y6Cv/OchY
        z3non4zhNUslYGRm2iTJoiMimw==
X-Google-Smtp-Source: ABdhPJy6SqTyF4Pt5wVxkgzmhWljIXhVFmMl1x6hZGrqlTmbnIfz3KAUWi0YG/+Em8ou+Kk/OeyuVQ==
X-Received: by 2002:a17:902:f702:b0:148:a2e8:2775 with SMTP id h2-20020a170902f70200b00148a2e82775mr17732317plo.124.1640021409118;
        Mon, 20 Dec 2021 09:30:09 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x2sm8512158pgo.2.2021.12.20.09.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 09:30:08 -0800 (PST)
Date:   Mon, 20 Dec 2021 17:30:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC][PATCH 2/3] x86/uaccess: Implement unsafe_try_cmpxchg_user()
Message-ID: <YcC9nSbknJuODqq9@google.com>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.643980924@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214205358.643980924@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021, Peter Zijlstra wrote:
> Do try_cmpxchg() loops on userspace addresses.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> @@ -501,6 +543,21 @@ do {										\
>  } while (0)
>  #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>  
> +extern void __try_cmpxchg_user_wrong_size(void);
> +
> +#define unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label) ({		\
> +	__typeof__(*(_ptr)) __ret;					\
> +	switch (sizeof(__ret)) {					\
> +	case 4:	__ret = __try_cmpxchg_user_asm("l", (_ptr), (_oldp),	\
> +					       (_nval), _label);	\
> +		break;							\
> +	case 8:	__ret = __try_cmpxchg_user_asm("q", (_ptr), (_oldp),	\
> +					       (_nval), _label);	\
> +		break;							\

Can we add support for 1-byte and 2-byte cmpxchg, and for using cmpxchg8b to handle
8-byte operations in 32-bit mode?  Support for all the flavors (except 16-byte)
would allow KVM to use this in an emulator path that currently kmaps the target.
I'd be more than happy to help test the result.

Thanks!

> +	default: __try_cmpxchg_user_wrong_size();			\
> +	}								\
> +	__ret;						})
> +
>  /*
>   * We want the unsafe accessors to always be inlined and use
>   * the error labels - thus the macro games.
> 
> 
