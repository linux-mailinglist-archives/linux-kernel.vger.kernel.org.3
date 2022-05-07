Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C9C51E58B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446060AbiEGIW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359014AbiEGIW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:22:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9725799C
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 01:19:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so12767801pjv.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9+q9aUf4v+U7iVHZBR1QE50pR302JL/thuuN0VcLXWs=;
        b=RNO1Ht2exGBR01XTSFTebLKZDZjXwgSWHHGd+LPeYF3RRovohaT6tYTmTfrGLZ5C99
         E3jwG2za/RKzvPtASaPyjeW1AD8Sun0v388cYcY2FIQ9O2C9kVJ3G6rKz6KU+IVtK4tG
         zQjx02yOwIr7J2ZdDC3x+zTq1DvJTgk1ZFMS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9+q9aUf4v+U7iVHZBR1QE50pR302JL/thuuN0VcLXWs=;
        b=YrWkNJ+P5HRVnsdPMFSJEMR8OAN7wdfRsETjHz8bQodTqDUvYRGnhKJS+bqljjRv+t
         7P5TidxAvrHh6n+OWHRCNkwZXVDtZqx5jQtUdeyQKz7f/8BLU/mu/wTkTlIkmjgccVXl
         lrtmIblx9Qyu00JgoL5whGxuL/LMiHKAqec/jSnEFB+ArgIIzEwOhJ6gvLSKFCMxCXao
         7gsZ9Lf2M09At5Y8q+a1d5b564shLFu+X/PNaSB87SdQ/e/LPJSoTt2IRG8ifnWisrye
         +s/nQsmLP173FjqUmzdBK/cNAX+RflSXarhHL2Ru4vxRRpdA7pPoaOJ0i77d8Ee+fopq
         OD/A==
X-Gm-Message-State: AOAM530Mt6qOZbCmASfsTOB52avvJRW+GdtYeFQ8Bnqdi9LpBc0UgedH
        1omd5Z8IWCm274GRM19gpeWadw==
X-Google-Smtp-Source: ABdhPJwiBWrbI1UHs+bairbeRXhaalkvL3Kkwi8ViT3UUNE0Z/HiVP92KgqhQmep5bSePoh1c8CZ0w==
X-Received: by 2002:a17:903:32c9:b0:15e:a1b8:c1ef with SMTP id i9-20020a17090332c900b0015ea1b8c1efmr7660751plr.173.1651911549598;
        Sat, 07 May 2022 01:19:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0015e8d4eb1f2sm3153758plp.60.2022.05.07.01.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:19:09 -0700 (PDT)
Date:   Sat, 7 May 2022 01:19:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v6 14/23] vsprintf: add new `%pA` format specifier
Message-ID: <202205070117.28F31079@keescook>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-15-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507052451.12890-15-ojeda@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 07:24:12AM +0200, Miguel Ojeda wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> This patch adds a format specifier `%pA` to `vsprintf` which formats
> a pointer as `core::fmt::Arguments`. Doing so allows us to directly
> format to the internal buffer of `printf`, so we do not have to use
> a temporary buffer on the stack to pre-assemble the message on
> the Rust side.
> 
> This specifier is intended only to be used from Rust and not for C, so
> `checkpatch.pl` is intentionally unchanged to catch any misuse.

Maybe add a test to yell if pA is seen in a .c file (like the runtime
check in this patch).

But that can be separate from this patch.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
