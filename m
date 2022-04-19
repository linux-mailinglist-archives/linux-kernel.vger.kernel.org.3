Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD498507C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358148AbiDSWCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiDSWCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:02:49 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CEB22B0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:00:04 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id m132so33556250ybm.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WaRzQ4klN9ADXoVL2/N/GdSyXHSUMyLkroRcRJGiyVo=;
        b=dsrvHvVw5CVTuYDjOZ4qvSA0xlGQ9a7GqFzdPXMtEddMQ65wpQPzZqOX/JbXwhprLR
         hPqkmxoXvBpkzvae2A5VxtWBiv9VY9kRWmXJ+gNgfr/J936VxV0clghSDI22NmxKt6B1
         HK7/ftdE06eNgpBj5leo1XsK8IIFCdSEa9VpY+wehnw1M5Hh1AqCZmlTGeEQwdiqRty+
         cW2dboQNQeR+KAybRGfQl22NikK/qMzaLhJ2IIcrKITmvBaledZvlBC39xLZDPSZ9+KJ
         JjPkH3I8poggbgEpZNVssMvzVQGwXLljvU6Em9lqaRW44S5WXiNBK0t6/gH/HIxRaWbv
         LmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WaRzQ4klN9ADXoVL2/N/GdSyXHSUMyLkroRcRJGiyVo=;
        b=2DozSxqnYGlQhSoRTiGy7cWBTJlO3JG/IyQ4dIMO4cspR3N8cPBKFY9YDTRSqg/0eQ
         kyQecxci5S5ZPKF1UCYAq+gMxsYeCW6cmaZyBkl2kHijW3Re8DXEM/7/aTCNu33UvlDQ
         hAURfs4hmMEZqYGockYbMIpjjeu1Q0Ora5dsBfKPJiaVC/WFF2yMvY8XTase0wiVz7VO
         nOd/Y2Q1k1LdHfB4RZYCI7aNRfCMxy6H6mY5gfDSKBRxVdpPlwvx18O7gLtgHNzF8NKl
         a73IDt9LyL+VgB9YZ+mucPpzcc50a0khpE85icBWnemR6KVUX1d0EZDEDYV24rBlPLam
         863Q==
X-Gm-Message-State: AOAM531GRsoTxCHIgXj7d3SAqT1zy6kw+XvC825giaxo9kZGoZx8czVC
        ei1yIXO0F9iE0K5Ix/07dvo9YU86tHs8yMfOkWbq7Q==
X-Google-Smtp-Source: ABdhPJyCOTK/Tp48a1k8AcfN/cTDyqQzbuqieOsXlmrpfSjjG6eK1W8C3AEqhU8MKnqaFQHcd0hbJwfVrHu5J84iAjY=
X-Received: by 2002:a25:a12a:0:b0:644:e94e:5844 with SMTP id
 z39-20020a25a12a000000b00644e94e5844mr12511065ybh.492.1650405602771; Tue, 19
 Apr 2022 15:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220414025705.598-1-mario.limonciello@amd.com>
In-Reply-To: <20220414025705.598-1-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:59:51 +0200
Message-ID: <CACRpkdZsv1u7Df=PLC8E_ZS5GAdW3PfEYjctfSJJuAev8mu9=w@mail.gmail.com>
Subject: Re: [PATCH] gpio: Request interrupts after IRQ is initialized
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Natikar@amd.com, Richard.Gong@amd.com,
        stable@vger.kernel.org
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

On Thu, Apr 14, 2022 at 4:57 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> commit 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members before
> initialization") attempted to fix a race condition that lead to a NULL
> pointer, but in the process caused a regression for _AEI/_EVT declared
> GPIOs. This manifests in messages showing deferred probing while trying
> to allocate IRQs like so:
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
> The code for walking _AEI doesn't handle deferred probing and so this leads
> to non-functional GPIO interrupts.
>
> Fix this issue by moving the call to `acpi_gpiochip_request_interrupts` to
> occur after gc->irc.initialized is set.
>
> Cc: Shreeya Patel <shreeya.patel@collabora.com>
> Cc: stable@vger.kernel.org
> Fixes: 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members before initialization")
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Link: https://lore.kernel.org/linux-gpio/BL1PR12MB51577A77F000A008AA694675E2EF9@BL1PR12MB5157.namprd12.prod.outlook.com/T/#u
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
