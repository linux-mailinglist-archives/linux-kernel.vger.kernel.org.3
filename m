Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C49564939
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiGCScz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiGCScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:32:35 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3A36428;
        Sun,  3 Jul 2022 11:32:09 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31bf3656517so63797087b3.12;
        Sun, 03 Jul 2022 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSKYZbyn8mddhblAYs7qJYuusH9cifWViGiK0y7vJB8=;
        b=eyyN6g2obGmebx8pIteLaXpAfsiXUeO/yT0/0TR5Et6cKDlZP+3gzDre9S2PTYuXnL
         rujxYs467APMsocQUjftLdMRhgmBKskwZk1YOVdUZ2aU8K39UmgtM+nTg+rrg7z8BbLQ
         EJrpjitR1I1dHStWjY4ioi7SGqD52tlTGu4I74lIJ6xLhZnzwXd7j7cH5mEhXtFxybnD
         Gre4FNwegZSNyrnamdtOXXVCOjh01p7bdAK5loZ8y1aLrxGaX8M4p5dOtX3dMopTjLJV
         AtfSwPCEOypYT6rYh/dcLbW9RMJEoL3dnzKYT3Ij/Fh8mYmBG+jk5u3M/+ivlbILI7at
         9a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSKYZbyn8mddhblAYs7qJYuusH9cifWViGiK0y7vJB8=;
        b=vodvrTKjbyF2tWGM8AUsVU/HLVRniUthJmpufhwiRRp0RTchfsvKyiXMaxnSGn1gCj
         xk49FxJjdG37Hi0Rwh9Bd85p3gVz8uZ5mjmWw89RgTzoAbOnp9lHraAAEkXebod4jTtz
         OxEt6ekbEOg+KYmJiHYSx6MV9Oa48zfwV/mXZlZc6sFxazMifpi8O+IQqEucVqvHdQm4
         ZK4cZ5oTz6pwIE+RcRZY3ObEW8NNI4U+vZBK2HdEcyOXXZWEVI+vJiW5x2xE/D32tamC
         QeMp5bsIwyIL0+zQwOiZ6VW7qDf1U1PRc/QeNdFYtjdQaYKbbAA18E1VsCYyq913uPB+
         I/ew==
X-Gm-Message-State: AJIora/FNiJWsjw6bAsBz3Y4oU7mk9osNNdLUWd/xYHnA2ZS4MFzm+sB
        H1DC31zjcFqHtpso75oHVAmQKC3MrFqdC7pP6Mo=
X-Google-Smtp-Source: AGRyM1tviE/YFQDmKXbqmGko1a/kn1FgT/21vZOyNeJKXtiVlpsxpUDghv9QNJZ5Ym/vGwTT+ay3P/g0PooGrJ+ZZhE=
X-Received: by 2002:a81:2386:0:b0:317:6586:8901 with SMTP id
 j128-20020a812386000000b0031765868901mr28830981ywj.195.1656873128834; Sun, 03
 Jul 2022 11:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de> <20220703170039.2058202-3-LinoSanfilippo@gmx.de>
In-Reply-To: <20220703170039.2058202-3-LinoSanfilippo@gmx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 20:31:32 +0200
Message-ID: <CAHp75Vf7Lm9J3GONazY1OZdMLSWp3aa2iQNztsSVZOPWy3=cfA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] serial: core, 8250: set RS485 termination gpio in
 serial core
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
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

On Sun, Jul 3, 2022 at 7:02 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
>
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> In serial8250_em485_config() the termination GPIO is set with the uart_port
> spinlock held. This is an issue if setting the GPIO line can sleep (e.g.
> since the concerning GPIO expander is connected via SPI or I2C).
>
> Fix this by setting the termination line outside of the uart_port spinlock
> in the serial core and using gpiod_set_value_cansleep() which instead of
> gpiod_set_value() allows to sleep.

allows it to

> Beside fixing the termination GPIO line setting for the 8250 driver this
> change also makes setting the termination GPIO generic for all UART
> drivers.

...

> +static void uart_set_rs485_termination(struct uart_port *port,
> +                                      const struct serial_rs485 *rs485)
> +{

> +       if (!port->rs485_term_gpio

This duplicates the check the GPIO library does. Drop it.

> || !(rs485->flags & SER_RS485_ENABLED))
> +               return;
> +
> +       gpiod_set_value_cansleep(port->rs485_term_gpio,
> +                                !!(rs485->flags & SER_RS485_TERMINATE_BUS));
> +}

-- 
With Best Regards,
Andy Shevchenko
