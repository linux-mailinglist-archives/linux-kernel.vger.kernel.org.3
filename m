Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A363447F3EE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhLYQ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhLYQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:57:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084A0C061401;
        Sat, 25 Dec 2021 08:57:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w16so44451357edc.11;
        Sat, 25 Dec 2021 08:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrE1MK1yTZcPfNFWv4O/JTmXCOBbMQyBOpNAcv66KpY=;
        b=DtkG7Ra9kjyiHmuC8Og17831P4xxD8SaBGAtOco3jb2gdEm9yZYhZRb7SfWzNKcldX
         n2MEmCzQhjC8mDCWugVlwmXErU4gGMtMwr7OJbaetNMaJk5er+UmUUB+2YHxlW0F7Oqg
         ywb5+Aclh95ReHeVq6C7HfTUEpd93cUaqNUNG3Fl1p+87FWjaERIYKrNKyop3x9hY5pC
         ZAalOJJSEElIA8H2VI2Ol3ky6f709f+gZK2+/O3/7H3NrwQWCSSSMi92flWx0AD1KSw7
         ImTjy2mFbC4VVRx9KjoE9eq6iMEHYAM2No4C0Lra4waazfSqcTmc5LV/7w4mNto1ojt8
         59wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrE1MK1yTZcPfNFWv4O/JTmXCOBbMQyBOpNAcv66KpY=;
        b=B9ddJRdMslUDAcLmCv0ZivueVg8bufnXo767XG8KPt9Y+qwbs2YUL8908Bq8KUWTmt
         iPGQ0Xn98VwKv2UP9vg5yAKLzlzflC4jvaMPW6qyYsia3/dS6nunqK5OSXvEjSh4qnAu
         1Hm1bIP979Njfav7zaAyGUzO1c2pWOM/K1FvcG8UT8NF6AYsRZwFHDVR87bH0mJs5MrA
         3LsjjjZE40qw3HzoOCDkexTjAtXYtR8ajSLUqIoIi0v35gXXXNTey1JCO0TVF90GR3IO
         F+N74N2rZJrqojQMAfz21J2UZhFTP7nsuQ+Gt24ASELFondXSFZh8Qil1QKxWhD22y+O
         Upaw==
X-Gm-Message-State: AOAM5333Zf8X8ix6klkCs0UBDcaDMongqzZxGNi3SFns1KBAEZmawUNS
        h8wdKAEF6AA6qVjglcwEhV5Jcl55jaKn0YMLkV4=
X-Google-Smtp-Source: ABdhPJyk5ykIGlXqpPvrC/E5RjVXw1CPOu5Fhi0C14aud/dguuCWMZfYUrqivLm5x8YxSJwjqZNUiNH9V4UcO2e7bkg=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr9822072edx.218.1640451418582;
 Sat, 25 Dec 2021 08:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20211224202231.31130-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211224202231.31130-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 18:56:22 +0200
Message-ID: <CAHp75Vda7LTR=8eUki3yXEk5ia8va2Ma6Pqgj-4v6nSphNZjow@mail.gmail.com>
Subject: Re: [PATCH v3] soc: ti: smartreflex: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 4:08 AM Lad Prabhakar
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

...

> +       ret = platform_get_irq_optional(pdev, 0);
> +       if (ret < 0 && ret != -ENXIO) {

> +               dev_err(&pdev->dev, "%s: failed to get IRQ resource\n", __func__);
> +               return ret;

Almost fine, but you should exclude this from the deferred probe, so switch to

  return dev_err_probe(...);

> +       }
> +       if (ret > 0)
> +               sr_info->irq = ret;

...

> +       ret = 0;

I do not see the context, is it really necessary?

-- 
With Best Regards,
Andy Shevchenko
