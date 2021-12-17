Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B33478605
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 09:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhLQINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 03:13:11 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:41920 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhLQINJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:13:09 -0500
Received: by mail-ua1-f44.google.com with SMTP id p37so2891374uae.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 00:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgtAMHOQo6FlQN49DBmDxUupNyJjWQSnJrw0Zx/I+DM=;
        b=4DoSrXvuSt86WgdsOGKNR++xiYPAhSpc2clLI0iyHGHuAVI8rCcaIacO3pAIKN4+8j
         6KB6VHcRQZR+iDEF03HHJpJx+zhWHThBRZ8XzpM/8kgLNc5JS65gMV/HPxlv6hzGsgOP
         hCyIPLRlCoIiwpyCEJ1toMJzc6WpakGizicBRbOvkfqmCyE15Cqm51rOWIw5N35v7N8o
         W/tEvdkKMXS9Ayjxd5WGM1t0sXROvH7jhyalkyv/CQnHDKNJ/kFzFNhPJmms9/2HfTmf
         8zhST6+UCvDHYy6paJB+U2TWzCZ7ENUOabk5eF9Ds+mtgHt/AkpaXsnW3jZbOqwcXjXm
         OStQ==
X-Gm-Message-State: AOAM5328nWfRG5UH8q7Np7PMH1nAzKpaYr5zM3PZnD+Jxd0mwOg5KRRR
        B3F/Min7TKYRzLjDspJIab9ILrnxk8zHQg==
X-Google-Smtp-Source: ABdhPJwDKouBuz0qzU/waHAkS8jq/IS5bIkGcl76lLE3MHjPMKt4jjDWMee3JQYOlU3P/JHZTs6Ixg==
X-Received: by 2002:a67:c304:: with SMTP id r4mr645851vsj.2.1639728788863;
        Fri, 17 Dec 2021 00:13:08 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id k131sm416898vka.30.2021.12.17.00.13.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 00:13:08 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id b192so1026051vkf.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 00:13:08 -0800 (PST)
X-Received: by 2002:a05:6122:104f:: with SMTP id z15mr676593vkn.39.1639728788196;
 Fri, 17 Dec 2021 00:13:08 -0800 (PST)
MIME-Version: 1.0
References: <20211216182121.5323-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211216182121.5323-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211216182121.5323-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Dec 2021 09:12:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWKbWwoLc-yJigP-Ot_eFbRpOvXx3766=eAgEmdUVOc0Q@mail.gmail.com>
Message-ID: <CAMuHMdWKbWwoLc-yJigP-Ot_eFbRpOvXx3766=eAgEmdUVOc0Q@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/renesas-irqc: Use platform_get_irq_optional()
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
