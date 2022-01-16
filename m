Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5DE48FC82
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiAPMHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiAPMHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:07:46 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5ADC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:07:46 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s9so19342727oib.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNXnIX6RDJdtlZPD9+1UW8TCX7PYSU+tj75Zl+vyUO4=;
        b=DBLiHXCLxN1uq/uKSNR3y1nJSqPKpE2i5uNfleicUU8F6GQf1QGbCLk2W/wMZvLUB8
         I1UevA001hhXsayZHUXVT4z6jlO5ULWJEAZZmFF9nZYl9kQll4hNM0x8AXMEIeevPrm1
         KEmYUFirkHg2Toi5bBoqpqzOBVMAOS2DPQQryXOgsZcVf39BSx4hZvi+Ue8wWfPTwcES
         vgjyLjCVSxXj19NrwR8SviXhlP/el7rDt5QLZIOJ+v5PlqbCFfYD+6y5Ptu8KwIwgVbE
         YCjXzDNpEP/N8iSM0nGIMSFZrPfA31Gkpg9ZjThATQ6LQ2kz5pxUTtxFt4H16b3HtpST
         Pvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNXnIX6RDJdtlZPD9+1UW8TCX7PYSU+tj75Zl+vyUO4=;
        b=xCxtmLOiK5HdEZFLYHkWkXaRL6dHvtve1gNzTfmOa0sp3z0UxLAEkyV0VG4FIoRjQb
         nW79YVrNj8xbz/+qk3uVIo+xiDVqcab8wBG8D5gLbI5qHhQyHh26DDjeNi29oAeWF9YC
         ImwjQ3OPTYY81RIdmoxOkvOdkIzoER3wjiJE0KCxJFK2qVXP7IYtJpVrro5OBZa0f9th
         v14rCV8NMfsIQGg2AxwEKGd+X8x6N+cW5GCimDuiRdxThmM7VKU4I5ZZPC0t2MVFEanM
         QNxvZ2v1sAGAMGv5MrwD08nDru/w/ZYx7vyTjJP7LfETKO+fbXWGIC7bz63BMaDQokro
         Ea/A==
X-Gm-Message-State: AOAM531AjOd6/dvNv8Dqhp4GfBrThOJYKC6atpkbJLVFdo9GzGhO3iYg
        jaFT8icWiZTnK1JssiRSYVK2p5Afm42tbCNO3vM31A==
X-Google-Smtp-Source: ABdhPJz3c7i1nWVvOnru4irBp0CN9UCIjC4v/gQ2WmRYxXxAzL7nI+jCT0NKiIxoq70CnTa+JgsYI6a/CP+caVcn7fg=
X-Received: by 2002:a05:6808:2097:: with SMTP id s23mr9512934oiw.132.1642334866142;
 Sun, 16 Jan 2022 04:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20220114065125.21208-1-linmq006@gmail.com>
In-Reply-To: <20220114065125.21208-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 13:07:34 +0100
Message-ID: <CACRpkdYSmgziDQuMU7McW2QQ_M7S16gPb6TgzRX2UkNzt2QdaA@mail.gmail.com>
Subject: Re: [PATCH] gpio: idt3243x: Fix IRQ check in idt_gpio_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 7:51 AM Miaoqian Lin <linmq006@gmail.com> wrote:

> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
>
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
>
> Fix the check of return value to catch errors correctly.
>
> Fixes: 4195926aedca ("gpio: Add support for IDT 79RC3243x GPIO controller")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
