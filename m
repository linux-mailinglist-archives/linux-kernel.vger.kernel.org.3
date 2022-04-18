Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870B7504FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbiDRMNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiDRMNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:13:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B7DE9F;
        Mon, 18 Apr 2022 05:10:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y10so9082552ejw.8;
        Mon, 18 Apr 2022 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVPSPKy4jcGaphHDpx5hUle8QXu6cx0+LV1j9x5xpfQ=;
        b=oM3cZjIQfJ349ghEoRQ0l6lMtZe9XojDljdUCtZlm8iGM2LRBO3PaQ1pS2NybUGQDK
         ZEUEdWTPeXa1MxFSe1r/zn49QJ4OPeHinB2zgwQS/8d6+PNg8UFrfCRuvfQ5NPzyAMdZ
         WdFK/tjcPgai32HBrmAlUBEaQ1hB5ULWeRr7Z6qeluB4bO1AqBbFTs/YwKqpl9fGjtDn
         BEGlmWd7yKYIXzqK2sBEcvveVXiZW8JuEBwFj8NkAn8rwUyd75AqXJfivFk8Yn7MK061
         a2jv262dWtZuu4X776BS0Zi8v2q2b1M1TIICwDrLDJWhAGwWUN6Fi3GAvd82+OPDwKSS
         XjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVPSPKy4jcGaphHDpx5hUle8QXu6cx0+LV1j9x5xpfQ=;
        b=VmmbwU4n578z+3eV0BUqq/CotDG0hDsUhkHKo9jf6auUZwYF+Ly8egYpgdPCapBjIq
         ZenaIOeXefQQUUXGCfxQgdEh/n8Salq/d11IHObTqH5siOODb8dHBlGlbiiILd7wgQBl
         D47Jnp6+6HZnXuOepjQi8JhuNVGTGhgAHz5MdfS6hDnp1BCa2swOBf50Cn9amlbNYklj
         zpKVhSisUlZASk85XFKz05oJNW8Yqr6EVmLa4E+pp6vtLhJkBmOGfpGAJEQ47E8YfjV4
         gP3EjrXRhLWksGfwNQIoKNpJ4zC3CLP8myzjEA/lI74nyUH9DZQ3420q+5tgEbPZnVPn
         KRqA==
X-Gm-Message-State: AOAM532ZV61jRuEMl2Xtr/Zj8Pwrht0xUQ7CtaqyVwhWMrGGLjX8lPH6
        +oEsZtRqeGgYkeTzwWfv4b1ZvvS1FljM8tVUZxE=
X-Google-Smtp-Source: ABdhPJyNNskiSG4Dun0u/29PY0MPfeh8JQN+/nnHN7PsNrhegMi+99MqdnEN+kGgx3gyvXV6NAzYrzmCt56rzAp333Y=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr8858684ejc.636.1650283825241; Mon, 18
 Apr 2022 05:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220418053202.24528-1-yu.tu@amlogic.com> <20220418053202.24528-2-yu.tu@amlogic.com>
In-Reply-To: <20220418053202.24528-2-yu.tu@amlogic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Apr 2022 15:09:48 +0300
Message-ID: <CAHp75VeW65dV9jJu8-yUWME+XKnaxZBu5Zv8iEJxP2dizA=HUg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] tty: serial: meson: Add a 12MHz internal clock
 rate to calculate baud rate in order to meet the baud rate requirements of
 special BT modules
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

On Mon, Apr 18, 2022 at 8:50 AM Yu Tu <yu.tu@amlogic.com> wrote:
>
> A /2 divider over XTAL was introduced since G12A, and is preferred
> to be used over the still present /3 divider since it provides much
> closer frequencies vs the request baudrate.Especially the BT module

'e. E' (mind the space)

> uses 3Mhz baud rate. 8Mhz calculations can lead to baud rate bias,
> causing some problems.

...

> +struct meson_uart_data {
> +       bool has_xtal_div2;

I would prefer to see this as an unsigned int and with a less
particular name, e.g. xtal_div would suffice.

> +};

...

> +               unsigned int xtal_div = 3;

> +               if (private_data && private_data->has_xtal_div2) {
> +                       xtal_div = 2;

Better to define privata data always


> +                       val |= AML_UART_BAUD_XTAL_DIV2;
> +               }
> +               val |= DIV_ROUND_CLOSEST(port->uartclk / xtal_div, baud) - 1;


-- 
With Best Regards,
Andy Shevchenko
