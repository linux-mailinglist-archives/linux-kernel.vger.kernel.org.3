Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0463478604
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhLQIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:12:47 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:35702 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhLQIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:12:46 -0500
Received: by mail-ua1-f48.google.com with SMTP id y22so2941434uap.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 00:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgtAMHOQo6FlQN49DBmDxUupNyJjWQSnJrw0Zx/I+DM=;
        b=bp7bh9TsEqvR9UnD1UrC+s6ohgAmnyVX5OrOQWAzA5NkhbvF0S/Jkh4WADpJwWBKOp
         6EZkUwudpQuogr39TYwTAbxndu3/qwNXjYaePmYH+aTpG9kUhbHwFBLSG9K/dbVaXXhv
         rIt5RPlvvpAwxegu2is81HxhOJj8t1BB6BCCeTjqbS+APcdJeM+1P6INDSdDdWSGSOf6
         GQFfhT61LThkU6xIvtS0a/ibjjkKTPRFFsEzvQ3iT8CBLc2wF2lT+o0nxUFR0+FND5Xl
         DSXwHfod7z1TG8jZCYk6E1RVAhlAYwcpP4nu2I3H20qkb8LfZD63Lrpvayrax3DDSI6c
         Eiuw==
X-Gm-Message-State: AOAM532zXsfDr364AwbAvp0bTXuzipYMmw5HXTWd0VfEvcz0c4xQzaeA
        HdGJtsZFXrJWlFiwCS6ksI0N4g4uZdbhUQ==
X-Google-Smtp-Source: ABdhPJyo2UeSbRmuYENxHBm6qVbT7hYn/FoSU6yw9bfsPqR35H0vPvPcQZuLodSbsJkjRrNGMnNWcA==
X-Received: by 2002:ab0:6c44:: with SMTP id q4mr620317uas.127.1639728765624;
        Fri, 17 Dec 2021 00:12:45 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id i123sm555938vkb.20.2021.12.17.00.12.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 00:12:45 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id n7so2820267uaq.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 00:12:45 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr564325vsj.77.1639728764888;
 Fri, 17 Dec 2021 00:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Dec 2021 09:12:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVx=_zyQ6rpPEGLjuTLhdUpNC82=F1HA58F2nrD5RLHWA@mail.gmail.com>
Message-ID: <CAMuHMdVx=_zyQ6rpPEGLjuTLhdUpNC82=F1HA58F2nrD5RLHWA@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/renesas-intc-irqpin: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 7:21 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Check for -ENXIO in case of missing interrupt resource

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
