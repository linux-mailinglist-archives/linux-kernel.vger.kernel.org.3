Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195765718C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiGLLmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiGLLlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:41:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7067B4BCE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:41:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dn9so13786360ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G865YbNx20BZkjR4fVd4kJWWHs5OBlEN22PuFcwTI70=;
        b=xS0p3TbW6qB5G+rF58Pzn58QHvvGxqeukiC7ytefdRZi3x/WiyLE7AekQ/Z81dKdRh
         krDTOLCEgAjb70DfQbBz7dlogONxZRG7lQDe1zW/S/YJpiOeooJUiasdFpf2u1Ot6j3g
         +ETNf8ePvN94JFaNj1Ce/g6zynRTtjcOCWU9uQhfSIEWsWjuOQwvAXV4Bp/AAr1jyxJO
         KL41rmkGRE/CYneqobvJzFNzpwbwSrUpy9UPRT8c/XIJgMFF1C+khc1yvh/DBJLiOEYv
         YyZaJxD0dw58EcBlexZb+/QaQH7ZVg+E3QMe6HMgJWpZjHkfVQ9JhlA4rb5z7Afvrtv4
         JKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G865YbNx20BZkjR4fVd4kJWWHs5OBlEN22PuFcwTI70=;
        b=gJus/FY9yBiDCM48swm5aMBp3KJ3699bU6BIvKN/0Dxmt4nCpp82u9W1uzM1NiAwKE
         Ha+D7jQknuD8wRnhp7QvWB0o3Rq6gPLLnSkbK1H7vfjJqqKg7tEXgvGao1RXwXNyqqEX
         pWzmZO7vVE3qC8wqu+PsZ5V4ZoZ/gcEzr+f0GnPPVwknJKLZgOM+P3mYPok4/vEl85EL
         YexNfksGlz1N5B3/y+q2qu8fm6izlf+VrDyHTPQRmnVm8L072rqVspMRVLVzrTKzcXXu
         jm/ztZjTj19VSKXGu7XiXr9Aip4dIWI1ZS1QdT2Agu5L98JbGVnUHnnoz+uH29XaJ39E
         Pzxw==
X-Gm-Message-State: AJIora9cfQxuOkKhOnagAJSasuzH0vIGVoyXCQML0RMdgCsjBH9gj6g3
        mhUowyhHwn1wTJK8PiagY+9u7/itMRFtddqOqhnWnQ==
X-Google-Smtp-Source: AGRyM1tPoCRVNLi/vKZkjzMjHGE4trmUgPn4uVHCdPAmJMenLxiAuaIw5BaWUfYm9G0ZWCGyFGfRO4ct9QJK16FFOz8=
X-Received: by 2002:a17:907:1b16:b0:72b:8c16:dac0 with SMTP id
 mp22-20020a1709071b1600b0072b8c16dac0mr472913ejc.286.1657626086253; Tue, 12
 Jul 2022 04:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220711081257.132901-1-maz@kernel.org> <CAMRc=Mf-FEKu_HrZvsL7+H2NTnME6mVV4AjMmZkEOn0Ch+4yMQ@mail.gmail.com>
 <6bb9c85796d248fdde3a6b060497b064@kernel.org>
In-Reply-To: <6bb9c85796d248fdde3a6b060497b064@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Jul 2022 13:41:15 +0200
Message-ID: <CAMRc=MeVs_+moCz4So5nmjDmE791x=G3BmvuF06SrN9rKzQVvw@mail.gmail.com>
Subject: Re: [PATCH] gpio: thunderx: Don't directly include asm-generic/msi.h
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:38 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-07-12 11:22, Bartosz Golaszewski wrote:
> > On Mon, Jul 11, 2022 at 10:13 AM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On architectures that require it, asm-generic/msi.h is already
> >> dragged in by the higher level include files, and is commonly
> >> refered to as 'asm/msi.h'.
> >>
> >> It is also architecture specific, and breaks compilation in
> >> a pretty bad way now that linux/gpio/driver.h includes asm/msi.h
> >> (which drags a conflicting but nonetheless correct version
> >> of msi_alloc_info_t on x86).
> >>
> >> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >> Signed-off-by: Marc Zyngier <maz@kernel.org>
> >> Link:
> >> https://lore.kernel.org/r/20220711154252.4b88a601@canb.auug.org.au
> >> Fixes: 91a29af413de ("gpio: Remove dynamic allocation from
> >> populate_parent_alloc_arg()")
> >> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> >> Cc: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> >>  drivers/gpio/gpio-thunderx.c | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/gpio/gpio-thunderx.c
> >> b/drivers/gpio/gpio-thunderx.c
> >> index e1dedbca0c85..cc62c6e64103 100644
> >> --- a/drivers/gpio/gpio-thunderx.c
> >> +++ b/drivers/gpio/gpio-thunderx.c
> >> @@ -15,8 +15,6 @@
> >>  #include <linux/module.h>
> >>  #include <linux/pci.h>
> >>  #include <linux/spinlock.h>
> >> -#include <asm-generic/msi.h>
> >> -
> >>
> >>  #define GPIO_RX_DAT    0x0
> >>  #define GPIO_TX_SET    0x8
> >> --
> >> 2.34.1
> >>
> >
> > Applied for fixes, thanks!
>
> I'm not sure this is correct on its own without the original
> patch mentioned in the Fixes: tag...
>

Fair enough, in that case backing it out and:

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
