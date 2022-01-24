Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115D149A196
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386442AbiAXXhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1841661AbiAXW7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:59:42 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA0C09D301
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:13:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w190so11081170pfw.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f3UlEdUBM1gGXgQtpyjWqPmUgqNBHNEo7AYSujAnzt8=;
        b=ASZXLuYtwDROEgcIql1Nl9Ws1AgZNwkzQcx2Vd7Dl4Ja8wgqd2SCDYU1Lv3CfdNgcm
         RqcE161FTzk7PBk1wj71vYLCHXVPpQqbeLpwVkGqZRTyvO0mDvmpHZOGkIHe6ozDgD1m
         qsJiipP7bqHZuHdfgjBF9Lf+GTA9O6mD3RJcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3UlEdUBM1gGXgQtpyjWqPmUgqNBHNEo7AYSujAnzt8=;
        b=jN6KWKerBdbtSfZ54RjK1+4U46doIVc6U756SKxr55oaCgtv7MjpLvuHlWfkqQ1fSm
         qAcuGskEVkqFYTq0NQRvBAKKP3FXPwkjOB9dvHQB5dUcwc9RRqZLdjnxzjwxU5Ji4Tu5
         skrGyDJAOUdGHHopwx4u0exy8HXaPTiabzIB8/UdNbPVHNeZATogVxjMtifR68LEy5F4
         C0ode9rgsfihl+q7FtfCokVgkOE8SsomAb15VjjEiiw1eN4j4P0X+R7mUB2VY6gj7mST
         3Ft0Psy4cyTv0rhV2R6qeGbuGsOvtl/sjdoGL6948geGtHGWr8MqbkJ9J/H0MhjKWGY1
         zKAg==
X-Gm-Message-State: AOAM531d54hO4FTxjpmd5FTncBnEKoHplma5k/0/UOkKPKUzlvID8guR
        tcGkpJREHKpLs5tavlBKNWI3Bg==
X-Google-Smtp-Source: ABdhPJwNR8Srqfc5OKBWmgOPvjXN/k1hIU5fnLL8J2NRnIxMn/bXsovf8HYlGXqHUpXfdjm8l8a8uQ==
X-Received: by 2002:a63:9549:: with SMTP id t9mr13051175pgn.107.1643058801876;
        Mon, 24 Jan 2022 13:13:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p21sm2905353pfh.89.2022.01.24.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 13:13:21 -0800 (PST)
Date:   Mon, 24 Jan 2022 13:13:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Leon Romanovsky <leon@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Len Baker <len.baker@gmx.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] overflow: Implement size_t saturating arithmetic
 helpers
Message-ID: <202201241237.C82267B66C@keescook>
References: <20210920180853.1825195-1-keescook@chromium.org>
 <20210920180853.1825195-2-keescook@chromium.org>
 <aa42ebfa-03b8-93fa-e036-a7507397d0dc@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa42ebfa-03b8-93fa-e036-a7507397d0dc@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*thread necromancy*

On Tue, Sep 21, 2021 at 08:51:53AM +0200, Rasmus Villemoes wrote:
> Not that I can see that the __must_check matters much for these anyway;
> if anybody does
> 
>   size_mul(foo, bar);
> 
> that's just a statement with no side effects, so probably the compiler
> would warn anyway, or at least nobody can then go on to do anything
> "wrong". Unlike the check_*_overflow(), which have the (possibly
> wrapped) result in a output-pointer and the "did it overflow" as the
> return value, so you can do
> 
>   check_mul_overflow(a, b, &d);
>   do_stuff_with(d);
> 
> were it not for the __must_check wrapper.
> 
> [Reminder: __must_check is a bit of a misnomer, the attribute is really
> warn_unused_result, and there's no requirement that the result is part
> of the controlling expression of an if() or while() - just passing the
> result on directly to some other function counts as a "use", which is
> indeed what we do with the size wrappers.]

What I'd really like is a "store this in a size_t" check to catch dumb
storage size problems (or related overflows). In other words:

size_t big1 = 2147483647;
size_t big2 = 2147483647;

/* Doesn't overflow, but 4611686014132420609 becomes a 1 for int */
int size = size_mul(big1, big2);
...
ptr = kmalloc(size, GFP_KERNEL); /* Allocates a 1 instead... */

I could solve this but removing the assignment, but then I can't compose
calls:

static inline size_t __size_mul(size_t f1, size_t f2)
{
	size_t out;
	if (check_mul_overflow(f1, f2, &out))
		out = SIZE_MAX;
	return out;
}

#define size_mul(f1, f2, out) do { \
	BUILD_BUG_ON(!__same_type(out, size_t)); \
	out = __size_mul(f1, f2); \
} while (0)

i.e. now I can't do size_mul(size_add(...), size_add(...))

Better would be to build the entire kernel with -Wconversion. :)

-- 
Kees Cook
