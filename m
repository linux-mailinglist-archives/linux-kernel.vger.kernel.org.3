Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36224FBFBC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347586AbiDKPBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347580AbiDKPBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:01:41 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6A221E06;
        Mon, 11 Apr 2022 07:59:27 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id b33so10825289qkp.13;
        Mon, 11 Apr 2022 07:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUq/l2eFC4o7PuogV4g6ysQ8qWlSny+TA+UhI++mHfU=;
        b=E7Oydqafp1Ye+7rSEheT3Vk8E2s7P4xfcCMvF6l3vwuMytFrvtmifUva0C35539irM
         Fict1Oe6lNXZgadclQFLxjSj1afwS2WC+vkUeL5yUaAbZsN/TIS3s4k2jREpb/U0wILm
         Y2iZSGBzR9UPZos/Q5DcoWv+CEnZgObdhUhT5TOpJt2YYEOkUFd71h7E24UqOW8sFAqq
         qxNoFl9Ga3vYzC6Fyh5Ig8Cl5F1qm3pdzmR38hIQgbalWXSDZ2CzmuFUu6KdGnlU03tc
         Iw6gIjLj4hiEVXudZvTq8ymnVhQqXr4ZQn1+yKqoH//FFVFoCad/gHpH0YrGzveo4GIW
         k9NA==
X-Gm-Message-State: AOAM533eA1ubrQ5IYBKfA8ETn+LDp5FWcN+CluMV1nKUpjuEYiHDwNej
        CELkE+tk9H1B8yvxwhLUSOkcqHeeGYkI4g==
X-Google-Smtp-Source: ABdhPJwXXobat+RR5zXQ9srHJH7D9PuWKPe705W1XxLfwdseXxqXdskAH/9lU59ySFm5QRhp9togFQ==
X-Received: by 2002:a05:620a:a57:b0:69c:2bc2:6579 with SMTP id j23-20020a05620a0a5700b0069c2bc26579mr1916343qka.455.1649689165887;
        Mon, 11 Apr 2022 07:59:25 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87d04000000b002e06b4674a1sm25478505qtb.61.2022.04.11.07.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 07:59:25 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2db2add4516so168862767b3.1;
        Mon, 11 Apr 2022 07:59:25 -0700 (PDT)
X-Received: by 2002:a81:3d81:0:b0:2eb:8069:5132 with SMTP id
 k123-20020a813d81000000b002eb80695132mr26323646ywa.438.1649689164877; Mon, 11
 Apr 2022 07:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220408122636.505737-1-valentin.caron@foss.st.com> <20220408122636.505737-4-valentin.caron@foss.st.com>
In-Reply-To: <20220408122636.505737-4-valentin.caron@foss.st.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 16:59:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWD8fxeqPUaT_CwnYdq02aaTsnQM_G-YyOGWooS5epCeQ@mail.gmail.com>
Message-ID: <CAMuHMdWD8fxeqPUaT_CwnYdq02aaTsnQM_G-YyOGWooS5epCeQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] serial: stm32: add earlycon support
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Fri, Apr 8, 2022 at 3:14 PM Valentin Caron
<valentin.caron@foss.st.com> wrote:
> Add early console support in stm32 uart driver.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>

Thanks for your patch!

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1264,6 +1264,12 @@
>                         address must be provided, and the serial port must
>                         already be setup and configured.
>
> +               stm32,<addr>
> +                       Use early console provided by ST Microelectronics
> +                       serial driver for STM32 SoCs. A valid base address
> +                       must be provided, and the serial port must already
> +                       be setup and configured.

Why do you need this parameter?

Given this driver uses DT, can't it figure out the serial port address
from chosen/stdout-path?

+OF_EARLYCON_DECLARE(stm32, "st,stm32h7-uart", early_stm32_h7_serial_setup);
+OF_EARLYCON_DECLARE(stm32, "st,stm32f7-uart", early_stm32_f7_serial_setup);
+OF_EARLYCON_DECLARE(stm32, "st,stm32-uart", early_stm32_f4_serial_setup);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
