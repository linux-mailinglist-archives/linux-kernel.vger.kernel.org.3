Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D00492FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349528AbiARVUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiARVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:20:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5752EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:20:42 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i17so494220pfk.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1XFeP6RNPzLCJfqoUd76H+t40KtDQUNh5VVtLJcfmgc=;
        b=juf7aPxwbqkK8/wuz96AC4A0W28SqhpeNYDqxYbiBbaCuRGzw/TBmB1qm6vp5AD29q
         lxE9BbV0e1nZzGeJ5Vkz6TuDMKG+2yOvphO7bGYFn3KIe1LD/IqOGMQgQhcdt3RYpdMe
         mCZD2WHIGDjr2qfKff1r0Mb5+Dj9+kvt3m9fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1XFeP6RNPzLCJfqoUd76H+t40KtDQUNh5VVtLJcfmgc=;
        b=dMq33es5BebKhdGJ5ayslgmtKKFuqbVsrYfsQ/FSAu/rvnxUxTQex2g804tiG1Lb6/
         yG+ZVxNCW+OfPGg0FJfXqJ1PsDZnHUXK8Q2KOMhNTI5LVaFbmPJD+UjTnSqDK5ePSyOT
         uVHwkz4583Q382zTPAt9chsEMIjwqC6IsYC+Yr0khmQDzgF/4J0TvE1OzP6Hc/sbhQb9
         9pzuQbTUUKgy9dsoy4DFlkHZCBZHG/iYH6tC3Lcxt30AxNwlHGLd7I9Gqk3pH3YzyX41
         AUb60c2MLC9LIygZBRHGujY8sKbCtu8Zj20/APiJkTPoZ4z/sp5wxrBzZHgZIN09Ir6Z
         ZiUg==
X-Gm-Message-State: AOAM532oBA3jZfUzaLuK5+6yqbWcKjraH9UG78JrtvWbst5DJ0B2xAEy
        LbpFwVIFTIaRfdDYbL/xWPk/ie5G6kqCaA==
X-Google-Smtp-Source: ABdhPJxj+QSfdAHHN0VP1WhOiT2/VnJC+AhAou/jI85HXTaB9Qu4NMHkHAdZM4jHGj/R76eqkD4hrQ==
X-Received: by 2002:a05:6a00:16c7:b0:4a4:edfe:4625 with SMTP id l7-20020a056a0016c700b004a4edfe4625mr27409471pfc.58.1642540841797;
        Tue, 18 Jan 2022 13:20:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m14sm12363450pfh.129.2022.01.18.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 13:20:41 -0800 (PST)
Date:   Tue, 18 Jan 2022 13:20:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jann Horn <jannh@google.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tpm: vtpm_proxy: Double-check to avoid buffer overflow
Message-ID: <202201181255.DB5D38F6AA@keescook>
References: <20220118183650.3386989-1-keescook@chromium.org>
 <CAG48ez00FFW-n_Pi=+ya1xY5QuB3q2mPr8++scVe3h3ROeF_mg@mail.gmail.com>
 <20220118193931.GH8034@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118193931.GH8034@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 03:39:31PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 18, 2022 at 08:32:43PM +0100, Jann Horn wrote:
> > On Tue, Jan 18, 2022 at 7:37 PM Kees Cook <keescook@chromium.org> wrote:
> > > When building with -Warray-bounds, this warning was emitted:
> > >
> > > In function 'memset',
> > >     inlined from 'vtpm_proxy_fops_read' at drivers/char/tpm/tpm_vtpm_proxy.c:102:2:
> > > ./include/linux/fortify-string.h:43:33: warning: '__builtin_memset' pointer overflow between offset 164 and size [2147483648, 4294967295]
> > > [-Warray-bounds]
> > >    43 | #define __underlying_memset     __builtin_memset
> > >       |                                 ^
> > 
> > Can you explain what that compiler warning actually means, and which
> > compiler it is from? Is this from a 32-bit or a 64-bit architecture?

This is from ARCH=i386

> > 
> > It sounds like the compiler (GCC?) is hallucinating a codepath on

Yes, GCC 11.2.

> > which "len" is guaranteed to be >=2147483648, right? Why is it doing
> > that? Is this some kinda side effect from the fortify code?

Right; I don't know what triggered it. I assume the "count" comparison.
The warning is generated with or without CONFIG_FORTIFY_SOURCE. It is
from adding -Warray-bounds. This is one of the last places in the kernel
where a warning is being thrown for this option, and it has found a lot
of real bugs, so Gustavo and I have been working to get the build
warning-clean so we can enable it globally.

> I agree, this looks bogus, or at least the commit message neeeds alot
> more explaining.
> 
> static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
> 
>         if (count > sizeof(proxy_dev->buffer))
>             [...]
>         proxy_dev->req_len = count;
> 
> Not clear how req_len can be larger than sizeof(buffer)?

Given the current code, I agree: it's not possible.

As for the cause of the warning, my assumption is that since the compiler
only has visibility into vtpm_proxy_fops_read(), and sees size_t len set
from ((struct proxy_dev *)filp->private_data)->req_len, and it performs
range checking perhaps triggered by the "count" comparison:


static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
                                    size_t count, loff_t *off)
{
        struct proxy_dev *proxy_dev = filp->private_data;
        size_t len;
	...
        len = proxy_dev->req_len;

        if (count < len) {
		...
                return -EIO;
        }

        rc = copy_to_user(buf, proxy_dev->buffer, len);
        memset(proxy_dev->buffer, 0, len);


I haven't been able to reproduce the specific cause of why GCC decided to
do the bounds checking, but it's not an unreasonable thing to check for,
just for robustness.

-- 
Kees Cook
