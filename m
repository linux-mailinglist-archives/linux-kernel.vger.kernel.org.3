Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F0547CB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbhLVCv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhLVCv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:51:26 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A635C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:51:26 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so359929oov.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNpM3IcKxG2MXbHsbsVC+EXGyw7wR90C4/4ffGO6YbY=;
        b=sS5lYPmE+RBCYDB1oQ9vVI2F9RYc4aNsqKTirSGQ2noAAi57YcXtJ447VXqEFYN/Sz
         bt+f6LyjuaDyVZFwfHELwmfi8+V2S17luyDnQs/xvlTXc6CIy+4ezcyXyE/wSof4L5vg
         K/kGrX2R39R1a5Ym62MpIvRPpCpTVvmcEW9oF2QQ8R8vACFu+hRHirl4PCyvQiPctf4Z
         Sx6rqCWS/fBnQ+GrNGiSdROdjKBZghFP6XK0QXySvR5g1G6/0q+jryEnbRnyZamzHTyq
         7Rw2VLatFC4sBfFjb8J3a2qEyd+J3hYoedxCVQNzg7VhzZLtfFdMRSKTh9ONyp1EOs0x
         om3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNpM3IcKxG2MXbHsbsVC+EXGyw7wR90C4/4ffGO6YbY=;
        b=OB0ALzZazPLTfGTEf9dWNkqNkpeOnXQ7MBDUMbv2Dxlmkdp7IHQtIv7kprOH64Lw/6
         tdfnCIDI2VSHj/mdzriHoAAwWjls9XHrJTAEub10TPIGlu2/iLerrlxQMkK+cfkdchVM
         9O/iH7n2lxs9h72xWAv5xX+MgqKGXJ2Pg2mAsT0hmbxLM/oyB9eHGZSw6B+OzJlU/r0v
         Eav2fu5LSB7aVU8KtFnVPklZXxgD5URnnldb5ZCAwpq3V+eS1Ujrfk5O3D4+R8yfVAbA
         O3qHvH7GAhtlaWaloZDVB/gHdo3D/d8vF3FCDryQA5h6tkNFvNrmUkVJWfOxUmMHCAPt
         vqtQ==
X-Gm-Message-State: AOAM532KEp43UyvLraTTvDhWJN2wn2s2IKf7l32BXANTwGMC9Bo2DBgH
        t8nrk9DYx6rmJ7vl2T5NbwfQL1nJpjVs+pVv/2NLdQ==
X-Google-Smtp-Source: ABdhPJwIKRxfN/SekKo12vk7umERvXcifdSXYUyXUX+ayzj93Y8UXp3+P70zoKxOloR58s+qQ9gFUgJa/qNTi6W4jgA=
X-Received: by 2002:a4a:8515:: with SMTP id k21mr704972ooh.71.1640141485833;
 Tue, 21 Dec 2021 18:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20211221213547.1553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211221213547.1553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Dec 2021 03:51:14 +0100
Message-ID: <CACRpkdZMp-UbE=D+mt8ns=ubPt3Rq-ciT-bEJ1zQDxuBa4N10g@mail.gmail.com>
Subject: Re: [PATCH] mfd: ab8500-core: Use platform_get_irq() to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:35 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
