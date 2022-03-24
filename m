Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423534E68FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352799AbiCXTDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352790AbiCXTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:03:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B13B823C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:02:16 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id g9so7685014ybf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7pJmiGijp8jJFqRgwCSs6BlHbeLZvlcaZccJVIDk8Y=;
        b=b2izQUy1PbtVDLRHv2DayiSpsYQAoT7y0tJkIBE71tP/Kk3OFX5rygsD3cIHuwIVJp
         eOy7NNYq8HjOSXa3TG3wcwMgO4jkG5J4UzP+takdexDuzOGe+T+gf05KyOZP7mifMji6
         SGG/tRd663FCxOnEbdY4J96E61ECoBjvzrhtFtvezpeNQ6BDvVtbrQoVm9QjR7c8s7lD
         Usa9Jk3DubcV4MJnVzhPGpHAfMo9GDwwfCodqgcxjlRQ41eM6M9arfAeVgBkcG2xL7dc
         rHTlEeawZh9zJAoNT1jnkWC0iJuZ/CXUitcr63fMCsc8PuR5ZzEFKxd3v+HICynnJ83Y
         ka/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7pJmiGijp8jJFqRgwCSs6BlHbeLZvlcaZccJVIDk8Y=;
        b=3kkoLAXR7CUrZ4Or9mhFqd5MCaQd6REiB0LaayAXmDti5N23CpOJ9uTHd0Gy13k/8N
         ztccA+xMAEEeclQ3BdRu4tEgrMovfVPJs2eSdbNQ8HZ+cCYTdOn4rlTPufYad78E4XJ0
         t57iohBaqCza2uRTBVN+VK/4gL6eX6qtdlYywmQelPB3XvI/5EpK7m2Xd+pOMZNdOoH5
         Mco6wRb1YmW6jeYmPQoX3wIySEU40csPO8t4Y7EjF8Cqwn+bSOuCGHBkmNFYPWfFlSu0
         8X/AITGgaiwjJQfrCO8hS4+2cQ69qW6KQRJJI05Z8nRsdmwf704APOrSBP9glsAzwSeB
         4FwQ==
X-Gm-Message-State: AOAM530uUoqT8DIY3uW4GYrNnIKxP4kWbEsZLsKWYD6bmeHoCYGJZheI
        vioWI7IRPl9QpXCkhZura/Jyc0or/fXVxIxkFMgxMw==
X-Google-Smtp-Source: ABdhPJxP+JYgzGDX7S8iklbzJOvINnVlCSkkCMCs9atnwSdyr8/UJuQa6LgHCx0qJ+BSb0E+G5vberJEhvSINWacT14=
X-Received: by 2002:a25:4e82:0:b0:633:68d7:b864 with SMTP id
 c124-20020a254e82000000b0063368d7b864mr6240404ybb.514.1648148535815; Thu, 24
 Mar 2022 12:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220324175417.1014562-1-f.fainelli@gmail.com> <20220324175417.1014562-2-f.fainelli@gmail.com>
In-Reply-To: <20220324175417.1014562-2-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Mar 2022 20:02:04 +0100
Message-ID: <CACRpkdbew3=6N9bp0dd4_URhEEipbysvHfpNh6QaYRdd6y1Mdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: Fix off by one in checking DMA zone size
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
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

On Thu, Mar 24, 2022 at 6:54 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> The maximum DMA address is PAGE_OFFSET + arm_dma_zone_size - 1, fix this
> by doing the appropriate subtraction.
>
> Fixes: 650320181a08 ("ARM: change ARM_DMA_ZONE_SIZE into a variable")
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
