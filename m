Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD0E526BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384338AbiEMUrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380512AbiEMUrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:47:18 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA5725B05C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:47:15 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id o130so1722384ybc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2r8LlMY/L/pVT9GNoIX6W6UvcdRsNWQcsMHoYfGNY60=;
        b=vFEdtZy/OcImmh0aLEoSN3eO0UzqIV3jtOiDPVIkJxdmXPcXeuQuh8REuqrhs6dCvo
         ZuVfSZl1qfGip70Vnoc+yWC5WRFyQWK+m50z4wox1sl4k9ExUn5Y0tAlWePJo+CgnyJl
         L+aZbjHq/NfJTXizYWwINpTjTXaOXy8zVAYgonfnChD3FAwIs9jepIiqX63YEOV9GJNb
         Rmwru2kgDh1oN86M5MnWF1fPclRz+cU+d+kiLuTUC4+acjTedG7VjzRQVtuWm5QffOXM
         ZPryuuwHnNj/dki+OMoD+haau/V+Yjpb6UJPuG2PlKSr4jeLFFRt9f4t+3/GUlrwWCm+
         7+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2r8LlMY/L/pVT9GNoIX6W6UvcdRsNWQcsMHoYfGNY60=;
        b=wBupu5XG9EL+8+HkN01+dtgNcdquVkVc0kLDfIWwAIys8/OvEiPp2KAgo8+4MKuOjY
         lJE9BRRR6GN9gPFRbQiTpfPalBH0HzlwsfYEHn2E9Y2bjLVoI3JLybAHU0yy6llniF3z
         HnBurg828D2iPkZTzwJk0LuO3PcQsgh6wEudq+TBiqyyMwW3+YEoBJL6sNosNo5P3sUS
         MB1sjXbt/9ctPQxkADNPWX7tEEP2nKmcBBsTUPdBQUDmmrh1ddnBcl12zVLmIXIAM3/l
         p25IXVJNBLbm9gVrCBE9ZMBot6sE3XolD8jtc42bj9kJLWGsGxreSNpSDgZywjXLKYHh
         63mA==
X-Gm-Message-State: AOAM532Yo/2YtvUnHSPxKo9KUBo3IxO1VU2Zs+TcyLL3I/6/XKrZXNXt
        HQVN+K4JbwxXsqZUQeXRbKUk8GJQRCDcyMSe6L4bmw==
X-Google-Smtp-Source: ABdhPJxYxnyE/ScIaueIcgyhWUucikQN+NYKGInyGJOHC9bQqhJHm/W0dHIKofGVzfnpUAaIF6GDIiRzCGtwro93RSk=
X-Received: by 2002:a25:e684:0:b0:645:d429:78e9 with SMTP id
 d126-20020a25e684000000b00645d42978e9mr6944743ybh.369.1652474835095; Fri, 13
 May 2022 13:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220511183210.5248-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511183210.5248-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 22:47:04 +0200
Message-ID: <CACRpkdYQAsam_v0XHm-A_trbyifj1pBQq5N+zc9KVw1vXVTYUw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] gpio: gpiolib: Add ngirq member to struct gpio_irq_chip
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> Supported GPIO IRQs by the chip is not always equal to the number of GPIO
> pins. For example on Renesas RZ/G2L SoC where it has GPIO0-122 pins but at
> a give point a maximum of only 32 GPIO pins can be used as IRQ lines in
> the IRQC domain.
>
> This patch adds ngirq member to struct gpio_irq_chip and passes this as a
> size to irq_domain_create_hierarchy()/irq_domain_create_simple() if it is
> being set in the driver otherwise fallbacks to using ngpio.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

As Geert says, I think you can just use .valid_mask for this,
what do you say?

Yours,
Linus Walleij
