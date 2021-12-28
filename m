Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAEA480CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 20:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbhL1TEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 14:04:35 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:38488 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbhL1TEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 14:04:32 -0500
Received: by mail-ua1-f53.google.com with SMTP id o63so33616897uao.5;
        Tue, 28 Dec 2021 11:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iLnJvy5CdBFGKMs8Wqcc6DvYOhV2czBQtSnUVteMjY=;
        b=TpR9knhPK2vbtGwrZ7a0QBHN7sbws3q9AO3Tqgojvk66Zu99h7IKr2U8wDPcdnAAt3
         9EdtrqeG1gmIkNf4fFz7cI+sOgX1Ss2YisVCbTTNKtbrN39dHDY90OVMq3KwlDWVGSPq
         OSyS4gokc+VrBKmUbuJpt7aDSyeSKLOAkke/aOPfFbuJdaEy7YoAmvOaaIE7oshUfzln
         imbOouh9R3CuXDHzTM2eoJ7QJPZ6GfzUrGn36AOz+rjERDwGofUxVW6UcrUZrUyEqsJ9
         K2MW7L40K2KJtR0f6NqkpcX/wiqLaTJQnFMuVVEtKipGrJnd/Ly7uPruKwt21FGOy+zh
         22uA==
X-Gm-Message-State: AOAM532gAzsRIVYN1I2Bg8RVHRoKR7czkNvBZFjhPP3AL/8vbGMcEZcy
        YyjBX01QhcL+0gcLhizPu8HyYTxrZ6KDrg==
X-Google-Smtp-Source: ABdhPJxsdb1N9pH6/fAsnvNDze09pefWON9fGMC9WMYphT8RkQztNCS73Vgshp7vlOBcFQRWgdhTiA==
X-Received: by 2002:a67:cd13:: with SMTP id u19mr6469570vsl.69.1640718271732;
        Tue, 28 Dec 2021 11:04:31 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id s22sm3701898vks.26.2021.12.28.11.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 11:04:31 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id i6so33344420uae.6;
        Tue, 28 Dec 2021 11:04:31 -0800 (PST)
X-Received: by 2002:a05:6102:2155:: with SMTP id h21mr6615025vsg.68.1640718271049;
 Tue, 28 Dec 2021 11:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20211228165642.2514766-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20211228165642.2514766-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 20:04:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWbqi_ac2wVUooO_mukG++y=ZjOwSir87fu+NLXYEKUqg@mail.gmail.com>
Message-ID: <CAMuHMdWbqi_ac2wVUooO_mukG++y=ZjOwSir87fu+NLXYEKUqg@mail.gmail.com>
Subject: Re: [PATCH/RFC] drivers/irqchip: add irq-inverter
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Tue, Dec 28, 2021 at 6:23 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> Interrupt trigger type is typically used to configure interrupt
> controller to properly interpret interrupt signal sent from a device.
>
> However, some devices have configureable interrupt outputs, and drivers
> tend to use interrupt trigger type also to configure device interrupt
> output.
>
> This works well when device interrupt output is connected directly to
> interrupt controller input. However, this is not always the case.
> Sometimes the interrupt signal gets inverted between the device
> producing it and the controller consuming it. Combined with both sides
> using the same interrupt trigger type to configure the signal, this
> results into non-working setup regardless of what interrupt trigger type
> is configured.
>
> Irq-inverer is a solution for this case. It is a virtual irqchip that
> provides additional virq number that behaves exactly as existing one,
> but with inverted trigger type reported via irq_get_trigger_type() API.
>
> Usage example, for Kingfisher extension board for Renesas Gen-3 Soc,
> that has WiFi interrupt delivered over inverting level-shifter:
>
> / {
>         wlcore_interrupt: inverter {
>                 compatible = "linux,irq-inverter";
>                 interrupts-extended = <&gpio1 25 IRQ_TYPE_EDGE_RISING>;
>                 interrupt-controller;
>                 #interrupt-cells = <0>;
>         };
> };
>
> &wlcore {
>         interrupts-extended = <&wlcore_interrupt>;
> };
>
> Then, wl18xx driver gets IRQ_TYPE_EDGE_FALLING return from
> irq_get_trigger_type() call, and configures interrupt output for that.
> Then the signal is delivered inverted to the GPIO module, and handled
> correctly, because GPIO is configured for IRQ_TYPE_EDGE_RISING.
>
> Implementation notes:
>
> - why platform_driver and not IRQCHIP_DECLARE()?
> - because IRQCHIP_DECLARE() does not process EPROBE_DEFER properly
>
> - why not using hierarchial irq_domain?
> - because with hierarchial irq_domain, same interrupt gets the same virq
>   number at all levels, and trigger type is tied to virq number, so need
>   different virq numbers for reporting different trigger types
>
> - why using request_irq() for parent irq, instead of setting up chained
>   interrupt in irqchips?
> - because this way code is much simpler, and shall work for all cases
>   (such as normal/threaded parent irq, normal/threaded child irq,
>   different parent interrupt chips, etc)
>
> - why just not introducing separate API for consumer-side and
>   produced-side trigger type?
> - because with the chosen approach, no changes are needed to any cases
>   that don't suffer from inverted interrupt routing
>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Thanks for your patch!

FTR, here's a link to the previous discussion about this topic:
https://lore.kernel.org/all/20190607172958.20745-1-erosca@de.adit-jv.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
