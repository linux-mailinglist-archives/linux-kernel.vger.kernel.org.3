Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4435647A7BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhLTKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:25:53 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:33286 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhLTKZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:25:52 -0500
Received: by mail-ua1-f48.google.com with SMTP id a14so16859514uak.0;
        Mon, 20 Dec 2021 02:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2smqINfKA19iYQ44Bhl9wK+mvghDg0/7q+uBVmH7jA=;
        b=go53PH3sry0r6BWnC7C1yOtxWzGVXVob4/5nEXqvoiWbZzeUvOa3HG1/zUCi8rujsP
         6TKl4UlcC4CvC0T7ITwivKBXnzQf7Mz/ps3nX0nwRy3fRLfD1r6volrpoZOSGQt/GXNv
         /JE9gqjpg2Cox3tq9Yqt5f1VFFyq1fFBihttS1V/MX3XCnta2UOLAFuPLuoAlINBe8X1
         UKxs5YVJ0ZFeE3VkRVSz2pHEH777RTuBUcNm/qaOlQrunsS482Hbjdsfb8quG1Ro2gMX
         mRXTrZU4nhGTRRy53jQX0PFNNtXB3tDvfsr66Q8K6cZdCifjmq6yROQ/2SFE0TsoHMlm
         w5lw==
X-Gm-Message-State: AOAM5339tCSOcnz3H00GSGOOuL9Me0/pCT2cvSe8nSvxknuHsR9ghezF
        cIu9IyVlyr5puXClRR+vHrSYj8rFItxZwQ==
X-Google-Smtp-Source: ABdhPJwK25uF9eY+lek9CiyjkR061l7RamrBXMGhfohfhof3lNbJaG8hKDo917JDbgIFLnrZXmD+DQ==
X-Received: by 2002:a05:6102:3f04:: with SMTP id k4mr4605188vsv.3.1639995951052;
        Mon, 20 Dec 2021 02:25:51 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id u18sm1625313vsi.3.2021.12.20.02.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 02:25:50 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id 70so5795391vkx.7;
        Mon, 20 Dec 2021 02:25:49 -0800 (PST)
X-Received: by 2002:a1f:2196:: with SMTP id h144mr5442171vkh.7.1639995949603;
 Mon, 20 Dec 2021 02:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20211220010411.12075-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211220010411.12075-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211220010411.12075-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Dec 2021 11:25:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUYagDwtzqZv3WdxM4SXsUqmmQmt_S61taY5nAxLQ4sBA@mail.gmail.com>
Message-ID: <CAMuHMdUYagDwtzqZv3WdxM4SXsUqmmQmt_S61taY5nAxLQ4sBA@mail.gmail.com>
Subject: Re: [PATCH 4/6] usb: isp1760: Use platform_get_irq() to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Bin Liu <b-liu@ti.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:18 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq(). Also use irq_get_trigger_type to get the
> IRQ trigger flags.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
