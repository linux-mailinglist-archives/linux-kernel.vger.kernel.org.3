Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB247F3A6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 16:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhLYPfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 10:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhLYPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 10:35:08 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FDC061401;
        Sat, 25 Dec 2021 07:35:07 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o20so43878106eds.10;
        Sat, 25 Dec 2021 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwWnH1EnSh3qhn957NvdbdCF9PgHWAaScmOUyji2gkQ=;
        b=EPNgsB487pYyKh4iO5aOKcn6aA0Y8nPPIhZgWoaSPgnWxBBrHJh4GJdyZF5BafD1Oj
         EpSyBT4ZN0efi96hz4OpY6nw5IurBZaAH67jijDJZS7N5w6LJYkqiED7nTXYgpFygM/A
         7XIxBZe0MmfQwh/GbbwuI0HK0zn8vFpv+0WpJsCkX4ZvbBV+lGlKO22dHSmpeKjnNabI
         jDT9/6fJ6B0HCWPBRzF+O5D8vafqzzrBoVpjuA4cdxk1O94zDX6V5j1eYo9oiBFG7mbS
         wBxSZLcBadKIqa7ZrPbbZ2WO1TPraL0JrMuMiTa8Izn1dCPehE9Eji27ZW3u7/OYcrSL
         kG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwWnH1EnSh3qhn957NvdbdCF9PgHWAaScmOUyji2gkQ=;
        b=OpAKw86j35iwbSNuD7rKnt4Om4MfP9UGfKy+Y7ikN10+Q5MR/549k83lumejbDtJiO
         Zs1CaQeZ097ak6iVV4aI2teFOeizyDui5gXDfjbVZkCMS+84Mi6fax2MQ415MT8UINMT
         Vc6O+PFIuWvHR0cX6vmP3CxsEi824D1TN043sqxCjVnYu3JkXkIyzrc4OGi53Su2MwJ4
         6j3UNLhOEESJ5OmZolkhJGSPjPk29zef6bH+Dka+2AMnstjkMjhx+f7djXx3McB7p6AJ
         yCeCF/HLjBievBb7Uw69THkr0kY+JdDBZq1c4pvu4+I+F/G9GmQBEKLupfHFLt21rfZB
         6Lmw==
X-Gm-Message-State: AOAM5314D6O3kn3qwZTIeRrDnj97uivCD4tNuIo7tqGU8Bt9aqqmTaI0
        0Cmvg9mPl0JMWR2QQyORciydlUlTar2lHAOd9b8=
X-Google-Smtp-Source: ABdhPJzerhu6pktkMKMdH2AqWbHs7Twn3IOVJ59Ezh3yEGgMFSACBN4rZHZDYwK1ndf9kq5HP6IUiceq+DdDkvMmCGE=
X-Received: by 2002:a17:907:6d8d:: with SMTP id sb13mr8614464ejc.132.1640446506459;
 Sat, 25 Dec 2021 07:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20211224145748.18754-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211224145748.18754-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211224145748.18754-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 17:34:30 +0200
Message-ID: <CAHp75VdSBYGTqHUH6=ZW5_LUat3Rg_TW_jNDvbjkU5Q9R4YFig@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: samsung: Use platform_get_irq_optional() to
 get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 3:59 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().

> +       ret = platform_get_irq_optional(pdev, 0);
> +       if (ret < 0 && ret != -ENXIO)
> +               return ret;
> +       if (ret > 0)
> +               drvdata->irq = ret;

Yes, this is how platform_get_irq_optional() is expected to be used
right now. We are going to fix it a bit, so this code won't be
affected.

-- 
With Best Regards,
Andy Shevchenko
