Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ABC48F9D5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 01:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiAPABH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 19:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiAPABG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 19:01:06 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6EFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:01:06 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id g205so17998663oif.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kADQFhR2AfzvIpqsJVy4t8n1qBnT7lu/EvJZU+85jgQ=;
        b=LLg16acyV9ssxzPynuDwH/S0CSc9tMRmrCIGdfwdrK7w85YRVu4Npgj+M//L/tDr1j
         +PEhJUymrMgWTts01augIl92yJZf1aVBfKdzBN9nHzipXIpTkLbTuWuUO9Uaf3zjE32h
         TbZXMS7sGGEK/1YkGFWy3HamgZZrEUuWJst5u7mTLybjcK/qWzghX8gcX2xy4yr1WtuH
         zjcFNZc24bkMehhg9rtL3RhaxpLOxleTi9rtFlTtXdLzs5UGZ1ewf1hRQ7kfSme0TB85
         mwuZXvIwGlvIKbSgTXEMEFRziLFU8E2p6X4JtqhoNSQACmTiaVnaWfw1qzfwemqMO32X
         v6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kADQFhR2AfzvIpqsJVy4t8n1qBnT7lu/EvJZU+85jgQ=;
        b=LSovqjwwKx2IY6uzn+vOnD3/UAWz6Ssq+GVBDhAS12uEfXaJv7j3009PaaFU5kQ4WE
         GueayJP8uign5U34o6MiqZ2Lg6Qi8VHga+6bpyAcIEi319BIoB2mhoCGNFjd8bn7dBV1
         SHYJnn868mOpC8wWuViyX2Jbmrjtc6raHnJd/v2QnFoc6TX3+wYrIt3VdvJ7MiVh+RCi
         hdEfofXXa92wCNzsdehz/ZhM27okYG5744fEA4pZyIhUs9oEMJTP6uO0oRO1GWAMNOaU
         bKnPlNp0+yUYd2K4yvnMennX2LmMS9ymR328WLL+JjpGVsgxluAnQmFlS+BA6HMDMckP
         gW7A==
X-Gm-Message-State: AOAM531Yj6cQQZDj+KjWxI0pawWXA3EeGbTLK79AZJopIDbAaBq2QByw
        LO4DaOZCO1aLds1snjQucIAotgXQyIkXfRJOfZGFKQ==
X-Google-Smtp-Source: ABdhPJytr9O5BgJJKKvmhJe6nwvjD4EG7WvnlzXNK+Ha+gaYYY8i+iU7YPfleFA4yPpF/1UCw+73EDGmS+2gySZs2Gs=
X-Received: by 2002:a05:6808:2097:: with SMTP id s23mr8244855oiw.132.1642291264587;
 Sat, 15 Jan 2022 16:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20220104140913.29699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220104140913.29699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 01:00:53 +0100
Message-ID: <CACRpkdaPVQ4jph5mWca9-ubAZjV6tpSpUfjJrsK+0+Si6yqtwQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: at91-pio4: Use platform_get_irq() to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 3:10 PM Lad Prabhakar
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
> While at it, replace the dev_err() with dev_dbg() as platform_get_irq()
> prints an error message upon error.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Switched using platform_get_irq()
> * Replaced dev_err() with dev_dbg()

Looks good to me but I'd like some ACK from a Microchip person
before I merge this (for v5.18).

Yours,
Linus Walleij
