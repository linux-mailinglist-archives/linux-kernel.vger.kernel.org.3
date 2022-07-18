Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC35782CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiGRMxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbiGRMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:53:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E6624F19
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:53:27 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ef5380669cso105625267b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MciSzTCOtmflGK3O6V8EjL//SfDdPFyhmPal7sipbA=;
        b=n/CalD3pebtHMEE4XFg+M1nbN+MOtmSjnuEG3JrhWlm62s1bWz28lRY1M8uQH71sfd
         6yHGU2HxO6hM4RSdOmIJTLneC3z6lPLe04VQV2xLysGiJhQQJXaHdHzjOfQmg7dEqOCs
         Q30Ff9kVo21aXpTaGGoTNV6F6Ezc6o+SxKqO053m0EFOKY0oI/zYfrvznvXOw1kTfRz3
         CA32KnET669fm+tnXm8ofLO4A6SZqRSTO1DM9eJBQZtY2gkyLlJSB4YB7ELkSkF1wojV
         ucLqOWHtqjkueqw8qo8WmvTqo1h9jC5KPtMn6tUU2rNU2s6IUkVRtCo4SWPdNhpTFABT
         frTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MciSzTCOtmflGK3O6V8EjL//SfDdPFyhmPal7sipbA=;
        b=mW9GpN32Mvfw3FGehyOQpUZu1IxIta0dZ2fs9jaHL5cA5hfrX68o5JN+F/h6BX0mEC
         A7ls+5YZH40If513H8YKaSSIBB6XP/pUKitFvdNShqKgzLDmtbwaSqHcoIrmVr9jPFxk
         TgwSSxfpbSunimJWN+NzR8I57xKFUguNtzUlxCAjEqTSngf+mN94wqfFKcG6vpwbvXlT
         iG3lizgBZYKP2COhE7R9n17uFW0tmTS/iicsDuwJVvPxXXlZvi8nxSowF1oQQeOhwU1o
         aNobXvxWyoyZ8/L3ASjg/gcK5a+MH8u+GvIuOjMUvBX6YkJOTpSAKzr9hLsK36H7hoeV
         Whyw==
X-Gm-Message-State: AJIora8XIwanzDpVulo3r5Ly5fY/0SOn68aTGvyF7TEitJtLRU2vDIsq
        X1lGOq6o8iokxYgFvqUVdMTHWIS3hzZaRCgWfLplWQ==
X-Google-Smtp-Source: AGRyM1uQyomyQn6nYh7R3jvbmkqtpn3J774uarHyggHy90akY/GOkBCNWH8VMYCCmueJEB4Ghowbu5zAJQDxuQn0fYg=
X-Received: by 2002:a81:7341:0:b0:31c:c547:ce02 with SMTP id
 o62-20020a817341000000b0031cc547ce02mr29828920ywc.108.1658148807043; Mon, 18
 Jul 2022 05:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220706203353.247633-1-f.fainelli@gmail.com> <33f4adff-03b0-3726-c4ba-98971ed46b85@gmail.com>
In-Reply-To: <33f4adff-03b0-3726-c4ba-98971ed46b85@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 14:53:15 +0200
Message-ID: <CACRpkdYBwi9biXA7efSLonQM36RALeUqj3p+Rv0EFEfVDC=N5w@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: Fix MAX_DMA_ADDRESS overflow
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        open list <linux-kernel@vger.kernel.org>, ssantosh@kernel.org,
        ardb@kernel.org, geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 1:28 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 7/6/22 13:33, Florian Fainelli wrote:
> > Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> > added a check to determine whether arm_dma_zone_size is exceeding the
> > amount of kernel virtual address space available between the upper 4GB
> > virtual address limit and PAGE_OFFSET in order to provide a suitable
> > definition of MAX_DMA_ADDRESS that should fit within the 32-bit virtual
> > address space. The quantity used for comparison was off by a missing
> > trailing 0, leading to MAX_DMA_ADDRESS to be overflowing a 32-bit
> > quantity.
> >
> > This was caught thanks to CONFIG_DEBUG_VIRTUAL on the bcm2711 platform
> > where we define a dma_zone_size of 1GB and we have a PAGE_OFFSET value
> > of 0xc000_0000 (CONFIG_VMSPLIT_3G) leading to MAX_DMA_ADDRESS being
> > 0x1_0000_0000 which overflows the unsigned long type used throughout
> > __pa() and then __virt_addr_valid(). Because the virtual address passed
> > to __virt_addr_valid() would now be 0, the function would loudly warn
> > and flood the kernel log, thus making the platform unable to boot
> > properly.
> >
> > Fixes: 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>
> Shall I send this to RMK's patch system?

I think so!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
