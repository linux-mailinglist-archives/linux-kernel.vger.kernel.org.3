Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B92462036
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379571AbhK2TVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:21:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38564 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379986AbhK2TTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:19:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2139CCE13D7;
        Mon, 29 Nov 2021 19:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B937C56747;
        Mon, 29 Nov 2021 19:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638213341;
        bh=cLhYyBrRQB0hosyW0QLWVWX5+KjE/2DBhOlOgR7mdHQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Map4DPFeMsIUQeTWUbOeEdLYgg0yO4qF0WENTpDU6TCi7PM/eOEM9IFVS4k1m7RfH
         s7zoxAdRrM4bk8hn0MqPatFqQB3teES8TIxFT1IiQJgM6RU1BlAoZ6s/8zl+Aj6Frj
         HLBuB8whQU8kYRLsPKtQ/bIHQXl0DcOE1hG+bXO87OA4cMxmX5NPiMF17NUQQiz54G
         cofvPCnGlqiqKA8C7dm0BB8npJznDSGpln/SjYKI3MF+jWbUBru+5m6u7GGfSCoWUc
         ll8+cLKcs8gM0OKkWLONAZ4w9rhRqWom+mmwQsSj1Hj15AHmmNCbKWn7sIMONVzz7F
         lQd8mCMBB5ULg==
Received: by mail-ed1-f50.google.com with SMTP id t5so76644161edd.0;
        Mon, 29 Nov 2021 11:15:41 -0800 (PST)
X-Gm-Message-State: AOAM53245HNAk6Ko3BidHovxCRY9MuSdXzAimwjcojAeNPWtO8q2lri5
        urKepIiKDyVxBxtq01duZZZcWxjZ+O2rhK21ZQ==
X-Google-Smtp-Source: ABdhPJyvru20wY8xt2ie70EKFB9XTG0m0lH+wkh3jUIK9Cc16B0RusdG7G9m4gWaOzujb+4DF8VdS8Z4ZXGe8Xd4SDA=
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr78883533eda.22.1638213339312;
 Mon, 29 Nov 2021 11:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20211122103032.517923-1-maz@kernel.org>
In-Reply-To: <20211122103032.517923-1-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 29 Nov 2021 13:15:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+kLK-277FOSvOCVDdw8_j-6xL-SnHs15Zj4MddsxZqNw@mail.gmail.com>
Message-ID: <CAL_Jsq+kLK-277FOSvOCVDdw8_j-6xL-SnHs15Zj4MddsxZqNw@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
To:     Marc Zyngier <maz@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        John Crispin <john@phrozen.org>, Biwen Li <biwen.li@nxp.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 4:30 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
> to an interrupt controller"), a handful of interrupt controllers have
> stopped working correctly. This is due to the DT exposing a non-sensical
> interrupt-map property, and their drivers relying on the kernel ignoring
> this property.
>
> Since we cannot realistically fix this terrible behaviour, add a quirk
> for the limited set of devices that have implemented this monster,
> and document that this is a pretty bad practice.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: John Crispin <john@phrozen.org>
> Cc: Biwen Li <biwen.li@nxp.com>
> Cc: Chris Brandt <chris.brandt@renesas.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/irq.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index b10f015b2e37..27a5173c813c 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -76,6 +76,36 @@ struct device_node *of_irq_find_parent(struct device_node *child)
>  }
>  EXPORT_SYMBOL_GPL(of_irq_find_parent);
>
> +/*
> + * These interrupt controllers abuse interrupt-map for unspeakable
> + * reasons and rely on the core code to *ignore* it (the drivers do
> + * their own parsing of the property).
> + *
> + * If you think of adding to the list for something *new*, think
> + * again. There is a high chance that you will be sent back to the
> + * drawing board.
> + */
> +static const char * const of_irq_imap_abusers[] = {
> +       "CBEA,platform-spider-pic",
> +       "sti,platform-spider-pic",
> +       "realtek,rtl-intc",
> +       "fsl,ls1021a-extirq",
> +       "fsl,ls1043a-extirq",
> +       "fsl,ls1088a-extirq",
> +       "renesas,rza1-irqc",
> +};

I guess this list was obtained by with a: git grep '"interrupt-map"'

I suppose that should be sufficient to find all the cases. I'd like to
be able to identify this case just from a DT file, but it's not really
clear

Perhaps a simpler solution to all this is only handle interrupt-map
with interrupt-controller if it points to its own node. That works for
Apple and I don't see a need beyond that case.


> +static bool of_irq_abuses_interrupt_map(struct device_node *np)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(of_irq_imap_abusers); i++)
> +               if (of_device_is_compatible(np, of_irq_imap_abusers[i]))
> +                       return true;
> +
> +       return false;

With a NULL terminated list, you can use of_device_compatible_match() instead .

Rob
