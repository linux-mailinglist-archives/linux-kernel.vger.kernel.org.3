Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC31C485052
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiAEJrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiAEJrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:47:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256D3C061761;
        Wed,  5 Jan 2022 01:47:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o6so159667591edc.4;
        Wed, 05 Jan 2022 01:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGgV9HOe1eHxafvPTz2hwuCui50Fondk/Z+tJBrwCXY=;
        b=ZfQ0H+mzXfFzwLJEWKz47HI36ciejJ99qg71vvKDDrEuSoPfvjC7/is5k8N5cudsPf
         ri0DNaRXsaCrzi8tP9ncvG8SqrMRZrnHfyFGnIMjVPgUdHWxbBvMtNcnaZJlVnp2WGfd
         GDJYEwDgS03Ly7qL7J9nf0kZNFLsjTP5DUL8I+rnJCPbtoNGih1FinFdXeBS6T9ejmk1
         +BjejejVC606sx5pGTnP0oEP5XvzwuieUxRkWltb1yZcxt6QcKKdyWmBQ2FiQlMUKtCP
         pgUllj1CxVJox+Gd4ic9Ja7kViGVdCP0M6mpkV5jVTHQTZm96E+VYBogx5coPDFtfnJN
         K11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGgV9HOe1eHxafvPTz2hwuCui50Fondk/Z+tJBrwCXY=;
        b=V1BCZ/cEt1183yd+9jt9BwXUNft6sXE5Fy6z9SVaI/TPxNlbMoVJaSdTAocWePW9RG
         lpLIu6luolkAjiODfmBJVMH9wdsydzU/LZrq4/F16ltkzzErEa25/LrH/V6O7VLVV3va
         G3CkiuDh1Ng3MuRpvHrZiHyGkEXhmy0uUIwhnVPnHXND8YHcpWXb2flr9KFe97BGg1/1
         O5GOA/fcaR6Wu40DYaLSAg2wqJI1GmOjKNYF0rggAMjR8Ty2qK/SmXM028cSCuZDCbva
         nDKJ2Bt1WchseRdNj0PRovta3xpXC43eHuGKxr5+F3ULuj6KfRRfPBJ7otr0CUKXlLEs
         CW0w==
X-Gm-Message-State: AOAM533ywTF4vGg5WmiejfqppaSmxN6r8OlIRYBg3vvnHm1BrfNzer7h
        xKxM6+BiEfkCOlSGTCkiMpbEQJ1VA9/wL36ympc=
X-Google-Smtp-Source: ABdhPJyWP+r+Hl6nvMg68q/i6OYDhYdeVKwOgFVPlEUkA2nMCMSgM1qbJiLpo7bG3M6VR9QEm9Ct8IJCSJUfta1+a2E=
X-Received: by 2002:a17:907:6d8d:: with SMTP id sb13mr42802906ejc.132.1641376023662;
 Wed, 05 Jan 2022 01:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20220104164504.24707-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220104164504.24707-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jan 2022 11:46:27 +0200
Message-ID: <CAHp75Ve+0VmfU7GhC=AjZ3J1J6KtGko2YAenA9mXCSCVrcuX5w@mail.gmail.com>
Subject: Re: [PATCH v5] soc: ti: smartreflex: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 6:45 PM Lad Prabhakar
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
>
> While at it return 0 instead of returning ret in the probe success path.

...

> +       ret = platform_get_irq_optional(pdev, 0);
> +       if (ret < 0 && ret != -ENXIO)
> +               return dev_err_probe(&pdev->dev, ret, "%s: failed to get IRQ resource\n", __func__);

Sorry, I haven't noticed that you are using __func__ in the message.
Please don't. It shows either that the message is not unique (so make
the message unique enough in this driver) or the redundancy of the
__func__ (it doesn't add any value, but noise).

> +       if (ret > 0)
> +               sr_info->irq = ret;


-- 
With Best Regards,
Andy Shevchenko
