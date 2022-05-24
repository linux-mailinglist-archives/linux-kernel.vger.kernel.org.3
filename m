Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE75325AA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiEXIy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiEXIy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:54:56 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13877356E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:54:51 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id x137so1299462ybg.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqZD+ogOM6DMMZNvJXo9UtOZIWjh9lX3b715CP395Rw=;
        b=YalnveRKXo/MmbpOdqU9xl8clAnBE9reOoViC11TCrupa/uAC8igoDuIf3X98aDlr0
         H9spduLwCrMws7VKbclVVDyvNS+SeJv/VSzmN3fB9isHzsz1ENnXF+krtD7RxE9bkxH8
         rOqQ5OdY/HBgvkzG9OMNS4P8S/HhS0cHV97ThG5d8PdMP9BWI3TLDafyp+g2WvGb2GMm
         BLEJQQoYT0B/gLoXkpOmoQZd3rra/n4iHf8wSinAaYNfaKkLSmKZiY2h/WjA1QgUezC0
         OIF5UOQRmY5VpKS441Rwybtwepuab+IatetBAcDmHu/W9nU8ORpJ6omFL1pw2NJ5gb1j
         gZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqZD+ogOM6DMMZNvJXo9UtOZIWjh9lX3b715CP395Rw=;
        b=JHk/zaqYB9QLBXvXxF1oSHd3ZjOe8YN58DFngSdA2/zPEsfhNEcrlLJhOL6KY3dQFP
         kMp3xhCqokLooMyXzAHjEGX3faqRYYO87lCCHcK4RN+fD6Yil/pXvBV/BDbS3tLr/MM1
         dNghZOHGjAh1QvZTqdYvjUk+8xDzaIoZ1MrE059qiaa6W17DbrW48rVKJ1sxASH+a1HY
         nuqxqNfmSX4n5KUygkfRqJWkHF0jety/mlCD7HiHF8LkUCcr6UAfqBbHPOnGdNprVy7q
         T7CHlVBWIcXL0PC3C2H/uSzf8ibYbLUv19bosg4LpWrx8hZ0vZkqdBge9SQ9QbrT8QDS
         HeiQ==
X-Gm-Message-State: AOAM533ddouiZKJtA3KLPRI8SGDZxyDtpKennfobwR+wCG7ItuvLf9Nk
        FNa0a6d6RaS4wLQLxB8cUkKbCKB7zbY2lNurcpuUzg==
X-Google-Smtp-Source: ABdhPJwmTZMv++iingNx6Cx2coJjp0zLQsy9Binu+PO+H9btH3fjaVRzSwcDgANvXo1lN7abVTZY0I5SNNywjxprtt8=
X-Received: by 2002:a25:2c82:0:b0:64d:62a1:850b with SMTP id
 s124-20020a252c82000000b0064d62a1850bmr25986931ybs.291.1653382490845; Tue, 24
 May 2022 01:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220523174238.28942-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220523174238.28942-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220523174238.28942-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 May 2022 10:54:39 +0200
Message-ID: <CACRpkdYaWmD9PTcGgeP5MTe9bXMgmf=tUSDBQ-4VxSfL4qkoeQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 7:43 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> Allow free() callback to be overridden from irq_domain_ops for
> hierarchical chips.
>
> This allows drivers to free up resources which are allocated during
> child_to_parent_hwirq()/populate_parent_alloc_arg() callbacks.
>
> On Renesas RZ/G2L platform a bitmap is maintained for TINT slots, a slot
> is allocated in child_to_parent_hwirq() callback which is freed up in free
> callback hence this override.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

So that function today looks like this:

static void gpiochip_hierarchy_setup_domain_ops(struct irq_domain_ops *ops)
{
        ops->activate = gpiochip_irq_domain_activate;
        ops->deactivate = gpiochip_irq_domain_deactivate;
        ops->alloc = gpiochip_hierarchy_irq_domain_alloc;
        ops->free = irq_domain_free_irqs_common;

        /*
         * We only allow overriding the translate() function for
         * hierarchical chips, and this should only be done if the user
         * really need something other than 1:1 translation.
         */
        if (!ops->translate)
                ops->translate = gpiochip_hierarchy_irq_domain_translate;
}

(...)
-       ops->free = irq_domain_free_irqs_common;
(...)
> +       if (!ops->free)
> +               ops->free = irq_domain_free_irqs_common;

Marc Z is working on cleaning up the way that gpiolib is (ab)using
irqchips. We definitely need his ACK if we do things like this.
This doesn't look like one of the big offenders to me, but I want
to make sure we don't create new problems while Marc is trying
to solve the old ones.

Yours,
Linus Walleij
