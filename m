Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA60E47F360
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhLYOUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhLYOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:20:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20F7C061401;
        Sat, 25 Dec 2021 06:20:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q14so35739023edi.3;
        Sat, 25 Dec 2021 06:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UsXJHC1uef9UNrnMagY0V1IAZ6G4dSU4+YNwVTURnEc=;
        b=V23NF4wRfjuYTLxsRU/rJ1L3WeqPOEIhYXZ3zSl8u/S+oFWmOeNVSoleRRb2CjQF5g
         8355xXybUzptDsi/YaW4EEIl1rtY0n2HyTRP5ql87lrkJ1+m5KlhFy/D6CL2gjuNKvZt
         RooPmBBWgNdrODRTocEkPksrhHS/cR+XDzmqn1sF5XMhet6PUkCwcPCo1ToDC/LitYgc
         S0Dfqky+qoqwyCsUL7gvMhTEEQ5LsrzyC+g3y9ZIA6xaY8QOTLxRp5fHE5tUkI08Fy6T
         7OQd9IXTzsql1BUQri0fVSk6g8iMq+civthdxZfLkF8g8XwEr4UjwwTAZp9H4IXtzvVI
         PhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsXJHC1uef9UNrnMagY0V1IAZ6G4dSU4+YNwVTURnEc=;
        b=f9bSwhFtYkJFeKU25c3s+Jo4NTsTSsG7ylAqg97vQ4ynj0Uz3l9ME92nPW+cpms4dN
         X8OYbGVNBUrAAWjFiapsC244KsRX84lEU9mXaFirfi7lDlZo2PZ55WWvCJKsZBkjEpj/
         J9ozp7YBN45R5pRtk3BL+BL6A9y+VK5U8qp3VZQVAceFSGO+Fu4jdzUIPhS4LIdXx4Cs
         nTJZevbXV8MAUEM4s0ExWMSm2ekN6VJ6TxFJgl4mXePbt5k6NEWx6GMV1pUhIwpoAlCt
         H8+I4gvgZ5ED4gNqt5ZJvzgd378XsEsAH2W3fAXqu/WQgV95XlMMqV92vRg1Ceij9dc4
         bRbA==
X-Gm-Message-State: AOAM531ZGaczdHMMw0/lMhn6Nudo59O1m4L9dSCAucXvO81y9f1GVK9B
        3ePgktSCsLPFiCgZ/OeftmzOIxFyyi2KEN+UVpI=
X-Google-Smtp-Source: ABdhPJyEZvLjTQTPKPL3vyPNMtFo6dnn30YYXanK7ujrAXckO9QD2QFtH1ljmRaBYIx6gG1J0iGfGZ5z/uk9QPv31w0=
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr8325021ejc.497.1640442041181;
 Sat, 25 Dec 2021 06:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20211225115509.94891-1-hdegoede@redhat.com> <20211225115509.94891-2-hdegoede@redhat.com>
In-Reply-To: <20211225115509.94891-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 16:20:04 +0200
Message-ID: <CAHp75VfLcCKPa1J5qG=iLhZRT1JKQFbBiaf7D23zmctS2ojFhQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mfd: intel_soc_pmic_crc: Sort cells by IRQ order
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 1:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The cells for the Crystal Cove PMIC are already mostly sorted by
> function / IRQ order. Move the ADC cell so that they are fully sorted.
>
> Also move some of the resource definitions so that their order matches
> the (new) order of the cells.


...

>  #define CRYSTAL_COVE_IRQ_GPIO          5


>         {

As Lee commented once in p2sb patch series I think it makes sense here
as well, i.e.

[CRYSTAL_COVE_IRQ_GPIO] = {

>                 .name = "crystal_cove_gpio",
>                 .num_resources = ARRAY_SIZE(gpio_resources),

What do you think?

-- 
With Best Regards,
Andy Shevchenko
