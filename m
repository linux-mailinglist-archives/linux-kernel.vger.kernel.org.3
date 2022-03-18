Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CFD4DE0A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbiCRSCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbiCRSCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:02:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936BC2A129C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:01:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a25so1909209lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1Ms63NIkd6E7s+RusloWQgZ7ue4LhJ4QsLqeHtSUJw=;
        b=UmJ7ZODw+NbFnzVmsyjuDdBgu4T/BwFBuS2/0+3MpNrwys8fTBTfkYBO1USQX87RCc
         GytlT2Sz0odsaeGpYDGyMwEBtfolTTfoXe/0/w8shAKFDO+IRj1la0blGBdQOVphsqY7
         M3IJWHcNUuY3XpphtwP3Ccs3F0vVtc7X4tupL6zeR1RE0r6kEUnLdV6sv6abGBSKuAvT
         qsz62NmNx+qchrEYSrn3OzEydIzwRraHZ8mwieJYb1vuVoLB/731mnpJMslLxnJ/Q8em
         PiirQtwAVuwulvHUk2tiS2Du+CYiHYNqBE/RFHLy24dEqp6UfqUw5Ii145O69Lw/vjea
         Ly/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1Ms63NIkd6E7s+RusloWQgZ7ue4LhJ4QsLqeHtSUJw=;
        b=Zi4BD0QehFhrYGzi0W6aNQD+S/wr67J4KreGXl/4nTu+xYf7SxF1E5QEtWAc834idt
         OEqROUnWliqJlN6MTVXcyKd8DDxVr3iugMoUx7TNbOttOKhXHYNUnY6rhcJfp9qNGFPY
         D4SRWnIT6uLqeMBjdqE5zAMpHNRLduDhFq9eweoMq4y0sHmEXoymE39VY5X/f/sSWJhk
         IuKBna4PTfNZEwfIaD2CFSAxL+pIX8PebVuPNXXWT+uA3K2AQWGlL3WcH2Ls8z8YdQtd
         oZvLzUVjrh3QnkRFPgju03pC8HpuYIXqi8ibcNZXoBUsNjsODIXYZgvRpUtJ/eaS5SLd
         24NA==
X-Gm-Message-State: AOAM532O61VPu68xRyePcYXvNdLWMxZixqlwewzDCb1iZaNoGpZaCRT/
        1NOFgyh1qV5OzNGJ1+LOJ1RZzbYX+h8/IfRuQ562XA==
X-Google-Smtp-Source: ABdhPJz6aj15Mk032FInyJsNGaIzC0VM6EnNcglPQg/SUnzZ2trHPqDTPq6Y0J4vC0VxLXeRF9Apc6TRZUmywwUSrg0=
X-Received: by 2002:a05:6512:b9e:b0:44a:10eb:9607 with SMTP id
 b30-20020a0565120b9e00b0044a10eb9607mr1382981lfv.626.1647626485133; Fri, 18
 Mar 2022 11:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
 <CAKwvOdkjb3uR+kqjfdKL5gqA8R+00c5=3E7uGGW+mGZ3QRsjqg@mail.gmail.com> <YjSROmYwwGhpsXMl@smile.fi.intel.com>
In-Reply-To: <YjSROmYwwGhpsXMl@smile.fi.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Mar 2022 11:01:13 -0700
Message-ID: <CAKwvOdkEjrPUL4HuO3UKaUZAzVw=XV1bEOSj6HR5R1WTUSSZ4w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use correct format characters
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bill Wendling <morbo@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 7:04 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 17, 2022 at 11:11:21AM -0700, Nick Desaulniers wrote:
> > Our goal is to enable -Wformat for CC=clang.  Please see also:
> > commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> > unnecessary %h[xudi] and %hh[xudi]")
>
> Not that I agree on that commit for %h[h]x
>
>         signed char ch = -1;
>         printf("%x\n", ch);
>         printf("%hhx\n", ch);

Will print:
ffffffff
ff

Maybe we should reconsider our recommendations for signed types?

It's probably worth adding `signed char` explicitly to
Documentation/core-api/printk-formats.rst, as it is a distinct type
from `char` in C.
-- 
Thanks,
~Nick Desaulniers
