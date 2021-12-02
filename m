Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC2746662B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358882AbhLBPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:10:48 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:44027 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358838AbhLBPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:09:57 -0500
Received: by mail-vk1-f175.google.com with SMTP id f7so18646064vkf.10;
        Thu, 02 Dec 2021 07:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDGy4nIjCyVZtM7ybHd/kS5ZJEnbJoOoJ8VC1mdt39o=;
        b=ibz2MlndRe4OUQOUzYEMo1J5seLCI8M+5ZK+gNLbajo4TCN7/Ubmt95hME2VdQKPBd
         mKC3FEEIpk0Hp51YQZYlJhJp0Q9vmRvkzpKor7JlS2R2wbVqWwFdUoUaFuZdYxemNUwU
         nm2lH+p5SxYqg/oHxQSfvXjEzEDWH4pxFEL3j4SJOEpw6/q7CNlrwV5ff6SKSK8y6SC3
         hs5htODzTm4p/WW4zFxdykHmTfhgqASObl0dsBaQxjdUSxhpnkwg9pKcwxLAIknCuHcW
         B930kEk0ytpf/sh7ojTyWZWkm63hW0G6yCOE+u8yiGzt24BS0RbbFB3wzBhV/CcgWDPh
         Vb/g==
X-Gm-Message-State: AOAM5307EjN97ZQOWQOW/wUBwtL8BUnou9701zlPAfntxTSCh+pcZJqw
        n5A6f8tSMHNF8Yf95CEctEdIQll4BhDt/g==
X-Google-Smtp-Source: ABdhPJxb5Q05LMoQLTBYGcs/C3B6EDL+vEWBk/6eIzJPE92ui69/zxootIiG8778/i+ztvXDFJbYPA==
X-Received: by 2002:a05:6122:1796:: with SMTP id o22mr16176722vkf.23.1638457594230;
        Thu, 02 Dec 2021 07:06:34 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id r20sm21200vkq.15.2021.12.02.07.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 07:06:33 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id e27so18676745vkd.4;
        Thu, 02 Dec 2021 07:06:33 -0800 (PST)
X-Received: by 2002:a05:6122:920:: with SMTP id j32mr17225245vka.20.1638457593048;
 Thu, 02 Dec 2021 07:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20211201114102.13446-1-maz@kernel.org>
In-Reply-To: <20211201114102.13446-1-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Dec 2021 16:06:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com>
Message-ID: <CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com>
Subject: Re: [PATCH v2] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Rob Herring <robh@kernel.org>, John Crispin <john@phrozen.org>,
        Biwen Li <biwen.li@nxp.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sander Vanheule <sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Wed, Dec 1, 2021 at 12:41 PM Marc Zyngier <maz@kernel.org> wrote:
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
> Cc: Sander Vanheule <sander@svanheule.net>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>
> Notes:
>     v2: Switched over to of_device_compatible_match() as per Rob's
>         request.

Thanks for the update!

> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c

> @@ -159,12 +179,16 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>                 /*
>                  * Now check if cursor is an interrupt-controller and
>                  * if it is then we are done, unless there is an
> -                * interrupt-map which takes precedence.
> +                * interrupt-map which takes precedence if we're not
> +                * in presence of once of these broken platform that

one

> +                * want to parse interrupt-map themselves for $reason.
>                  */
>                 bool intc = of_property_read_bool(ipar, "interrupt-controller");
> +               bool imap_abuse;
>
>                 imap = of_get_property(ipar, "interrupt-map", &imaplen);
> -               if (imap == NULL && intc) {
> +               imap_abuse = imap && of_device_compatible_match(ipar, of_irq_imap_abusers);

... = intc && imap && of_device_compatible_match(...)

> +               if (intc && (imap == NULL || imap_abuse)) {
>                         pr_debug(" -> got it !\n");
>                         return 0;
>                 }

Still working fine on RZ/A1, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
