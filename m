Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94C84D0156
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiCGOex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiCGOev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:34:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A04EA3E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:33:55 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w4so17663028edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+XALL1alS+FEu3fkIAo9R70z8bB6COUmfVlfGVppAY=;
        b=ReM5bztlsxSXLgfYaVI3yXxo8CxNvQpLXNma54gX7iLagqzDtMUrBbexeh2ck+kEfQ
         rflq3MIZV3EIwnGZlUJsrqsXdGaME2SP+ZwtfNCFZvwisH7pEoeQHKYTMhrS2DSs297D
         y1T9OwoBPZt0miCMIDlYFKBEo04ZfXNnUkcivZ2gfwFbZVVm5aZ3e7eHSDHuMenQsAsQ
         dMmExYLTc244fVdQvR2sdw4FpflWvCjl8fnS7i51k+diEfeWFItD4VvPrz/kopHr5xGw
         rBs/Hjtq7+3ZeF66H7O+78hiNeGeaPzQ2H33YA0bMLh3Fd4RQZE1mlGGTnVfkHV2qPzF
         89Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+XALL1alS+FEu3fkIAo9R70z8bB6COUmfVlfGVppAY=;
        b=Q53mbSLrqFen6b+D++CuBsVygU2L+xAh5IUWqZ7EnJ9oTYDhvS9C4nreGM9bPKqgtz
         0BOQnDOnuNEJ2K8JRXkmJCNdgHHe34K8i6RztdLvVujkF8SixsQ/m3lkPka5JG8cILCI
         TQJPYGodo2+5fGK6qorCshubOwUxlx/5iJpEMKMFqGpxW/+V9hSIYoEIQcw6EMc7F/lz
         A1YSLrKTmCNHHuz3waQWPEv+40UA0eqUz48R/lsTYWz/oOj1IZB0Ktmf4oZQSE69glul
         YTx0NlSSi2Erpg+n9QiU4p0f8EGdiSFE9aytgZB2kKN09jXAT3avnQzjEMOeSb6EQpE9
         50/w==
X-Gm-Message-State: AOAM530qNzQdenJfIsS+QVfjPdm/Rr/218eKLZVCC8Yh/tnJK68OQyvX
        XoXenaYb6Qs9kH9w4U4yXxHd3n3PrqKS+WJnx6kj3A==
X-Google-Smtp-Source: ABdhPJwmgyegI3NvOMY0wCmCLVBPSIB2uo/s/Rqay9LDREpbmXsCKeVho/SZQEYawDmhY5iV7FKM1UjF4GDiFlF55rA=
X-Received: by 2002:a05:6402:5cb:b0:415:e04a:5230 with SMTP id
 n11-20020a05640205cb00b00415e04a5230mr11426603edx.352.1646663634426; Mon, 07
 Mar 2022 06:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20220307115623.37492-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Md3_W49Wq5-zaxdNzELW87OogEN5wW6XQnF9aMpZrRvBA@mail.gmail.com> <YiYNPhUoXH8XakKO@smile.fi.intel.com>
In-Reply-To: <YiYNPhUoXH8XakKO@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Mar 2022 15:33:43 +0100
Message-ID: <CAMRc=Mcp5YeVYJn1FCK+0=72HhJ2haTU02wd9MK7O7fxgXyj4Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: acpi: Convert ACPI value of debounce to microseconds
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 2:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Mar 07, 2022 at 01:48:10PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Mar 7, 2022 at 12:56 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > It appears that GPIO ACPI library uses ACPI debounce values directly.
> > > However, the GPIO library APIs expect the debounce timeout to be in
> > > microseconds.
> > >
> > > Convert ACPI value of debounce to microseconds.
> > >
> > > While at it, document this detail where it is appropriate.
>
> > Do you have some more stuff coming up for fixes
>
> I don't think so.
>
> > or do you want me to queue it directly?
>
> Yes, please take it directly, thanks!
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Applied, thanks!

Bart
