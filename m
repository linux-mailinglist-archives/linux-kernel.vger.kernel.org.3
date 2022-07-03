Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FE156491A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiGCS2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiGCS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:28:17 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CBACF4;
        Sun,  3 Jul 2022 11:28:16 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id d145so9971514ybh.1;
        Sun, 03 Jul 2022 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjZR/70PHdM2PN7TkWB0TtRfSwOaskYmscGVtZ9BAyE=;
        b=a29l4TY5Uu+UsD/SBXw0sFjO1CW+IN2+uhmdCHwpsBPF0osshMBITJ5hDe1KBAeDZa
         KJGZdCzp9eonNqcoi+nIi3fhaWALWPShC6m/bRxS2uuLHkr2hZiQX1r08aXHEnqmH9pi
         mFWjFxe18nTC9aaIP+e3fsfTA97ayA3T8UN4laAbY0iMAltd4vco0URiFm24wDoRvE84
         TsZj/T9YsPrvbd7ss4jMm1oZXCQjpq34z3+SZ1ifr4jL9A/qSCvqUJ9f12RWwS8+hO2t
         rOS73dEP1Ai7R2jsgrCOq47pWsod3KRceFnaGulT1wn51B4VeyMk2p6sRaWzwFlkzIMr
         r9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjZR/70PHdM2PN7TkWB0TtRfSwOaskYmscGVtZ9BAyE=;
        b=6hXC89otPg45Mx6C2JrzihlOFVZF5dZjfHb2j9Pe17xCM/w+A2pSMob2I4UX+FzOXj
         AF5nc2hvASRz79KqF1u0cd1fhi6gGbplnDCcA6paUqcVnjJG2XTdCX9kpcOQ0a3nl/FP
         /TalQjJGI41RYpnro/iIM8FwpxCvajx34XO9/RGohzYGeFD9+akOXKnrnGgyK7Xv/RBh
         jfcWqTR+/p4dAv+RxVqhHv1I4h7JEKzyDZPwahOg/uXwzbTXCl2kIsmKoCKuvab6O5e4
         gt1H1P264VMdLN3ENjtpYd552k5WPkyT4fLaSDV3nZgt9Ig8M+OFRfv6fhJHr4B5HWeS
         Q3wA==
X-Gm-Message-State: AJIora+JJl1Nmtm0VAtnR0LuR6Cee8k8wxO+ptjvLQTfj3C9EOvFFx7x
        mMyDcGx3C/g30NyJ4UWSiAjWRgrw8XnvMZ6j6Rw=
X-Google-Smtp-Source: AGRyM1s3IcdAbvbL68QwHWAcHy5wnzv9v0dtbhrfomjH0uKcNBKUV4HH5ulNe6arGwBQNEnX23Qbv6HOtUoonzDrN40=
X-Received: by 2002:a05:6902:1549:b0:66d:5f76:27ba with SMTP id
 r9-20020a056902154900b0066d5f7627bamr26444320ybu.385.1656872895607; Sun, 03
 Jul 2022 11:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de> <20220703170039.2058202-2-LinoSanfilippo@gmx.de>
In-Reply-To: <20220703170039.2058202-2-LinoSanfilippo@gmx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 20:27:39 +0200
Message-ID: <CAHp75VcU-gLQBvuesoYp-G91SjzeYB7PNCN17PGL7u139VZY2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] serial: core: only get RS485 termination GPIO if supported
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
> In uart_get_rs485_mode() only try to get a termination GPIO if RS485 bus
> termination is supported by the driver. This prevents from allocating
> and holding a GPIO descriptor for the drivers lifetimg that will never be

lifetiming

> used.

...

>         port->rs485_term_gpio = devm_gpiod_get_optional(dev, "rs485-term",
>                                                         GPIOD_OUT_LOW);
> +
> +       if (port->rs485_term_gpio &&

This check is incorrect. Either you need to move that after error
checking (that's what I personally prefer), or use !IS_ERR_OR_NULL().

> +           !(port->rs485_supported->flags & SER_RS485_TERMINATE_BUS)) {
> +               dev_warn(port->dev,
> +                       "%s (%d): RS485 termination gpio not supported by driver\n",
> +                       port->name, port->line);
> +               devm_gpiod_put(dev, port->rs485_term_gpio);
> +               port->rs485_term_gpio = NULL;
> +       }
> +
>         if (IS_ERR(port->rs485_term_gpio)) {
>                 ret = PTR_ERR(port->rs485_term_gpio);
>                 port->rs485_term_gpio = NULL;


-- 
With Best Regards,
Andy Shevchenko
