Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2244843B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiADOuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiADOub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:50:31 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C262C06179E;
        Tue,  4 Jan 2022 06:50:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z9so79543532edm.10;
        Tue, 04 Jan 2022 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBlU5YfS0xh/NPjUje9YpdMH2Kee00xn/sh6RC8/tns=;
        b=CvzbQN7sP7+PrwMOFFdMqetLq8SV0XFxp+YSiR5zGaA1xexANnnRvIhpO6d6YNj9Rs
         inXjl6u81KcWZyB/d0zOy+iNdJpOW4h17htfJYMoh+sO1/XafjGllOfrJrc81za34XRr
         IhRMz7u9mC8aVJlO4LKWY8+MS0W8sU/II6pQeO2ophysH926eWrAQXUHkY9wZCStNvky
         U/uH3tztNruWwWIrh6pUBFvnVHaZArdD058Qs35DWo4EtNtx6PZXUJyMHgAuyhmPjif8
         sKB0bRDrrfxEGBFd6MX3GhRV7jQtfhurgFQr2OxiERoC8r+cE/pqcuTrMgFKNoljm+RN
         1w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBlU5YfS0xh/NPjUje9YpdMH2Kee00xn/sh6RC8/tns=;
        b=N3ph/nYkgARAPbhyYyQNpki9R7tGiSVluqVD2FHR/vEek1WwRF4JFiXc3xnnuiP4Z/
         nO8hqqZB4/WjbowrvoxnKhuTaRa5+nuH4UtqrNTNFcQM1noVPU0LgCK8QNyYX6wIIfxc
         yYjSCWemBzwESAx4ZTDq+YBH6SVe86CSruG2y6KqhpmTg+E1chE8Rg/nZ7pjdyY+4xk5
         MkmNpMGLJaeWF3QTSXxF0pCCoznzhCf54NQbSVtlELsFrYOUV1L95FVFR7jjB3BB2lGC
         snf8sUhlCvXr5mQgZuidBHti/23wF+sFrY25l3gcUDb+uf9OkDG8yacqcb99OF5TLU+A
         Qwzg==
X-Gm-Message-State: AOAM531bLTBr1Z3hunLZGIF6y669QTwdCxMJ9kzyVEpA9Rmez9fxrPEH
        rYOgJ9U+AS2Bz/86NALfZx1hkjXpBainvxzixiQ=
X-Google-Smtp-Source: ABdhPJyvYiypqLb98BWYXbcv2yFLdiRi0HyuYXn9J8TIppLhHHsZQlLvBENhmSOKVtwg/VCtCrEPVDr9eV+8luSf210=
X-Received: by 2002:a17:907:6d8d:: with SMTP id sb13mr40133790ejc.132.1641307826780;
 Tue, 04 Jan 2022 06:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20220104134512.18498-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220104134512.18498-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Jan 2022 16:48:35 +0200
Message-ID: <CAHp75Vcx1Ey-SHBCgBh1RM=PTBRcncGOwAx9_6PL+sDJtzezvw@mail.gmail.com>
Subject: Re: [PATCH v4] soc: ti: smartreflex: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 3:45 PM Lad Prabhakar
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
> +       if (ret < 0 && ret != -ENXIO) {

> +               dev_err_probe(&pdev->dev, ret, "%s: failed to get IRQ resource\n", __func__);
> +               return ret;

return dev_err_probe(...); ?

> +       }

-- 
With Best Regards,
Andy Shevchenko
