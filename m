Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C84501DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiDNWA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiDNWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:00:24 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64358CCEE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:57:58 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ec42eae76bso68784847b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsin3xkK44iZ/qdD21FUQJPdHT0HFQkrGw2fsGwg7ms=;
        b=Fx+wBrg0udj7V8qsRt6sJ5Bps8Yp0dGjBLfXzuh+s3TkHChpp8vNZyGjPhDGwr1mxG
         vSseSmOyws4GDv+9/TSdgNvGdZABBj+g6/ocQmZvUNv0gGaL8KdvORRqCi6jjmL3JTn6
         x4rvYVgxqi5aUEsuNoB9b641YB6eNbuxz13P0qexeEDBsprPntCA/9dgHm7Z0kzCfzNn
         BOrGk16+u3x2oB3pkoS8suYo38YWcbvA1ggduHPZqk7kztOCewBM4IoheyWtaX/QRszs
         QUesrNs30oyy7zeGmb4h66ast3XMAuCrLcD4CYDE4Bg6gVgRuutohBBusShFgZ0e6SEu
         rz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsin3xkK44iZ/qdD21FUQJPdHT0HFQkrGw2fsGwg7ms=;
        b=G4RRoEsCZlX+RU89LRpiop7ZHaIxsWSRCTr2233C/tql4bjH2+ncy7Q0MIYtgIjAFb
         1qVi0SmyUoJN/ANKjxZNW2jb5aSUEh0Tv4nJz+4/ejbY1wlYyHs17JBtFf17sB2IFXQ9
         kBlIA1MjJzjiKl9PGthGEas/Bs+r9Um9k4lyrbfBJ6/hL6o4em+ihINO8cC0/Pca9xiS
         JhOpf8ORnxM4ui9jLoFHjkvEc1s0LMvkOHSnRpwLWKJkA4MSBL+RlVAQTO7dfvswZj/1
         zDDY3GMl7Eif3YITf3r3E5/Fr3Uc94HObITIKdpUDM+0nbr8YavmSX74Dlo4BntLkR57
         ELXQ==
X-Gm-Message-State: AOAM531UehFADIfGTAYsFl6E5HBVxfrvVuu9uZmjnrI6P/YIwuZ5u0Vn
        3bm3lHgMHjUo+GUmADRymXp8/BgmY5F8iJ9rDlkYlg==
X-Google-Smtp-Source: ABdhPJy94pMyVUWaHtuuOiozyvhJNoNPqEcPdxJjkrS/TlOaUr0bmu/ZOHdwC9+nMFw/p+X5TTa4LbPn59cNv+BwmWc=
X-Received: by 2002:a81:5dc5:0:b0:2eb:3feb:686c with SMTP id
 r188-20020a815dc5000000b002eb3feb686cmr3803902ywb.268.1649973478181; Thu, 14
 Apr 2022 14:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <BL1PR12MB51577A77F000A008AA694675E2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51577A77F000A008AA694675E2EF9@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Apr 2022 23:57:46 +0200
Message-ID: <CACRpkdbjkC6r4Npg_DJSDD9JOZ0R4aWBc5qQYnQThqYTt2KniQ@mail.gmail.com>
Subject: Re: Broken GPIO IRQ mappings in 5.18-rc2
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>
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

On Thu, Apr 14, 2022 at 3:21 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:

> [Public]
>
> Hi,
>
> I noticed on a variety of machines that power button wasn't working anymore starting with 5.18-rc2.
> In digging deeper, I notice that a new error is introduced as well during bootup:
>
> [    0.688318] amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x0000 to IRQ, err -517
> [    0.688337] amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x002C to IRQ, err -517
> [    0.688348] amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x003D to IRQ, err -517
> [    0.688359] amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x003E to IRQ, err -517
> [    0.688369] amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x003A to IRQ, err -517
> [    0.688379] amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x003B to IRQ, err -517
> [    0.688389] amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x0002 to IRQ, err -517
> [    0.688399] amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x0011 to IRQ, err -517
> [    0.688410] amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x0012 to IRQ, err -517
> [    0.688420] amd_gpio AMDI0030:00: Failed to translate GPIO pin 0x0007 to IRQ, err -517
>
> It looks like IRQs aren't getting assigned to the GPIO pins anymore and instead showing this deferred probing message in 5.18-rc2.
> I bisected and confirmed it's caused by
> commit 5467801f1fcbdc46bc7298a84dbf3ca1ff2a7320 ("gpio: Restrict usage of GPIO chip irq members before initialization")
>
> I don't see that probing ever gets a chance to run again though as it just shows the dev_err and returns AE_OK for the
> function that walks _AEI (acpi_gpiochip_alloc_event).
>
> FYI - I'm CC'ing stable because this commit went to stable too.

Paging Marc Zyngier as IRQ maintainer. He might have suggestions.

Torvalds already pointedly complained about the semantics in this patch,
should it simply be reverted?

Yours,
Linus Walleij
