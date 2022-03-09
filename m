Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB0B4D3BBE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbiCIVK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiCIVKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:10:53 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEB2BB38;
        Wed,  9 Mar 2022 13:09:53 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2dbc48104beso37582987b3.5;
        Wed, 09 Mar 2022 13:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHLpaCDabk6UVYQs8CpJ48dsCLpU1oWOF4RtdySvC5Q=;
        b=pFmS/RzST3I09Hy16iYpLdQMT/xbrr+WbU8JftfckdHtYSZVA46yxhvOzSwu7uDhYX
         Z9XDLUAIckIL81UHQz/RqmR0dGCWSSzHRRmmTbcE8ec7cCLMpMS8EyEqQHh40N1EK4AT
         7jtXhp+cBvwC3KHfxBK+GvAgDmVcTPOYRPGp+e3K9r52vFNGMcz+MWbTBLufabvuMFii
         a4ZtIbVZf/0rotQkVX3fKvIoVvKIeV5wiSqZyHS1VwOcawkEqMwUUdnIMsv4B1J9HL9P
         wfzoFTS1wC5ts34SGFkNTgDX1IRIFL665UQkAuxIW5Q2pr1V+oG5ZrP70kDDUgbrSPTP
         P6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHLpaCDabk6UVYQs8CpJ48dsCLpU1oWOF4RtdySvC5Q=;
        b=gAEe8aOcGqsN0vf1Xr2qc7e7QFk2moC03rVCWijWiQAcuI9+DN05/cUwru4mGG7c05
         Cgaal4ZUxJWv8wmN5HwAQTpcYVXJv5RP6f5nXv6a+Acf3uCGIEQ8TXf0rgToOicIa7bz
         YXxg6ki9RxqQiTZkdmpJ8NjMGg0UWopZiUOZiwIkmcQaqPleOlTnCY6sYIPEwAxtaWbD
         cHZqTcnu6bS0lJmeZTgypZeoNxlSW8CCXbzQY7QGDJGXqo4AlgR0t3lwhM9soNoGMhyM
         DxF2CNt40ktgvcb8qQa3lm98qtFakxxzpp7nGvUoJ+tRo0ar6Z/jwMoBXelzThVoMcXL
         NQpQ==
X-Gm-Message-State: AOAM533GTU2WIQujQRiQAK3RpOhUejD65VaLPylHqEvqvxqVn9L1sPu3
        GFTLzhRo+BlKj/nUQAo8UHeLAGi9Abf91hvvKR8=
X-Google-Smtp-Source: ABdhPJxa9s4dEQx/Nwr9xQ5VDC+dkpeL7n6faqVSZT+njfoqEtsE1h0LMcn8FD4WT7EeUb23m945VcgU0MOm1NOSCOY=
X-Received: by 2002:a0d:d80a:0:b0:2dc:1f1d:878d with SMTP id
 a10-20020a0dd80a000000b002dc1f1d878dmr1503559ywe.16.1646860192963; Wed, 09
 Mar 2022 13:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <d290850bf95f4bdf0c329f278db458c7@kernel.org> <CA+V-a8vUCXQa38NmYu9znakcq4A=Uedyn8w5+hXQ_WKf58oHRQ@mail.gmail.com>
 <875yry1316.wl-maz@kernel.org>
In-Reply-To: <875yry1316.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 9 Mar 2022 21:09:27 +0000
Message-ID: <CA+V-a8s-2VK-ibD683Pt1mAF-GT5Vo+DUWcQCOWVmkFoh-ffLQ@mail.gmail.com>
Subject: Re: [RFC PATCH] of: platform: Skip mapping of interrupts in of_device_alloc()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Dec 9, 2021 at 10:33 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 09 Dec 2021 10:00:44 +0000,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > > The root of the issue is that all the resource allocation is done
> > > upfront, way before we even have a driver that could potentially
> > > deal with this device. This is a potential waste of resource, and
> > > it triggers the issue you noticed.
> > >
> > > If you delay the resource allocation until there is an actual
> > > match with a driver, you could have a per-driver flag telling you
> > > whether the IRQ allocation should be performed before the probe()
> > > function is called.
> > >
> > As suggested by Rob, if we switch the drivers to use
> > platform_get_resource(pdev, IORESOURCE_IRQ, n) call with
> > platform_get_irq() this code should go away and with this switch the
> > resource allocation will happen demand. Is this approach OK?
>
> If you get rid of of_irq_to_resource_table() altogether, then yes,
> this has a fighting chance to work.
>
To clarify, did you mean to get rid of_irq_to_resource_table()
completely or just from the drivers/of/platform.c ([0])?

[0]  https://elixir.bootlin.com/linux/latest/source/drivers/of/platform.c#L143

Cheers,
Prabhakar
