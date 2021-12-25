Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0C047F38C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 15:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhLYOty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 09:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhLYOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 09:49:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A532BC061401;
        Sat, 25 Dec 2021 06:49:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m21so44854245edc.0;
        Sat, 25 Dec 2021 06:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alIXLBzGjy0nBMJbaTSbaDyGlh+xHYoVA5PvIV1PogM=;
        b=ED6fiGncb5lHcgLq/CfiFySLcp8BTDPwLg8SH5t7dGhBpQYCdlnnQ0zwTbTgOn3Jll
         MdwTtG6jrcsMeAQ4cDG6wnU1ImOPUSNy8QxqPybJZhwQAE3E5PaRmMN9260He9W5FsWn
         3juo90aGfda+xb4felmPcbjchYuLxqSlkrhUaV6kuD9tAvl1GhvMmachm4h/GuxBCHAa
         G+5VwsCU0pe06dVFW7eRHTBa2981LjfIvydXwL+tAs4wYo34M4CbUAZvyAkwQTyfnZL8
         sy7PRUHCPamxkJpiIVPYQFeisgEuPInfhoutpwOqwqA4b0Jglkm3NKQ1ugX0pWebNgXq
         q8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alIXLBzGjy0nBMJbaTSbaDyGlh+xHYoVA5PvIV1PogM=;
        b=xLbeUtWnxNW5Gtb5+U6b8e3Pc6qchTzOqvESLuSPwD593W8SyjsGlDhM2D2xjiTQCV
         uKfVYw7jEOTwsMzLVOqAPsI7YVxMpbPF6dyTFIdPdVN55rcKuXiEyGdw4TLNPgPuwgJQ
         irza0YBK++994cTNRQLxAQR8cmudWowgK1YE4s7hAk9teSXR4hXuRHbpsfEBYO0Ei0hr
         IpvAoeepT6R+oY1FIXK4hiJEwfDqaEBMgqv5mp6PhhQUgx8yLRCprvsvjC4ddbJusWXW
         aHMkXA7mQQWfqmauh9pjqyGzOhO2lAQD5OUvQB+Ej6WXQurAipWKi7S6+/w9lRp4sN3F
         Ki/g==
X-Gm-Message-State: AOAM531RSppVds6SHvtiLagQaTtQB0r8eayIYvuisTBV80sMOBhZQHli
        epvW15eVUb6lhf1BZTkRP2J+6lxwqeZhH+XrNVh2ivuA/NFT/A==
X-Google-Smtp-Source: ABdhPJxfjirmuroUjeQ9t9oyOGJ/dcoP4OhkTJK12itTY56Natdrc1qmXaQ/GJEM+1pLJ3MrcOUM7Rpmgpjq9zKrgTE=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr8146568ejj.636.1640443792230;
 Sat, 25 Dec 2021 06:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20211222171915.9053-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211222171915.9053-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211222171915.9053-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 16:49:16 +0200
Message-ID: <CAHp75VccFMoTxR=ws=Us4UW=-Qsr6hVWcKH+pgShJQMdPfKQ_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: rcar: Use platform_get_irq() to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 9:21 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().

...

> -       if (devm_request_irq(dev, irq->start, gpio_rcar_irq_handler,
> +       if (devm_request_irq(dev, p->irq_parent, gpio_rcar_irq_handler,
>                              IRQF_SHARED, name, p)) {
>                 dev_err(dev, "failed to request IRQ\n");
>                 ret = -ENOENT;

While at it, you may unshadow the error code
ret = devm_request_irq(...);
if (ret) {
  ...
}

-- 
With Best Regards,
Andy Shevchenko
