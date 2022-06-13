Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCF4548048
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiFMHPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiFMHPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:15:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC891A3B4;
        Mon, 13 Jun 2022 00:15:30 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id g25so5207942ljm.2;
        Mon, 13 Jun 2022 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kDMrKjn7SCHPQD491sQRcFVfX76w23aBw8JLkLjVRw=;
        b=Srj6D23H2EK6Wly58iQ/6pMCI5jMFeUy0YYc6wNBAJ1DayAFQ+5HvraX4qfPNpjsIu
         GBoggQwERhEbqrl28la62ywOc2RiJGmAMuldFhf3r9387hgpCbOyv/BZz2Fy3GQFjFxf
         yqKAUX4SMlnsqjiFTHGmpBu0ZuYnW7nt9ZeCN4cIxs+LRus8sZ48hE0o2avpuyr30gHk
         vML4jOcS/dCzSiqfjAB+JSXgdPn7AmOohUjoGs9lgFekvEs9t3sJYDn+fDsIQG02LFKT
         gRKci10Ty9tbl9o+ISKT8DErQ80qQ8EPVYdXGFR9TUEdbFMQ/fUlkuyJwlRFv6Q1DpNC
         cSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kDMrKjn7SCHPQD491sQRcFVfX76w23aBw8JLkLjVRw=;
        b=cCF9hPDDuorcj2KfYpIayRjkYfWuPE8kKeDMV4tNVUEZ+dKPcxAIegRVPyI/1qJFmT
         d/1+rsNUfrzREdaYDHvsW7jIRO/FaxK2ydG9549rAFRVYxsazaZxjs8cGtlFZOCQgDzZ
         RMiiiCaUfaOtjTesdjlcr65qFOZqLnml7kGwTCw2o4Thd3O75ZQ+k7AIu6YiM2dMATLB
         07Gk83/R+29xnhT+Fpkq9ivwCudj8wR1EcoRFdUaGbxuaaOvZv5POs3RUJwvJ7vw1Su+
         QJzoNN19L4wJgSQC4Y/+cLaaE5/dDg62xTIy1gYOr8Z4FyeQyvrrmnn4WVnhoXekec5y
         3Tkg==
X-Gm-Message-State: AOAM533tpYR7P6RFV35Pi3sUYkEs7ZrycEI8Sdkf+jobONZz73w5Ak7I
        E/wOvyBqa34QPJoBQ/2ivpSj2l4sRhMX9Xzn3X0=
X-Google-Smtp-Source: ABdhPJxMeAPZdjsh21T3CQmhRApXL+7ZnGLDleQGDR/hSUYszbzLKYdlJuCY6SHZXqdQTIYtuyFXaeFXeSI+aIcq30g=
X-Received: by 2002:a2e:bf27:0:b0:246:7ed6:33b0 with SMTP id
 c39-20020a2ebf27000000b002467ed633b0mr69455983ljr.167.1655104528727; Mon, 13
 Jun 2022 00:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-11-tmaimon77@gmail.com>
 <3aa70c91-d6d7-e2eb-9c45-a1fb0a5751ca@linaro.org> <CAP6Zq1iCJO3AzHnG7RSQ1pyVwayxs+X3iVM4U=6j2k0EgR7psg@mail.gmail.com>
 <80f9c2d5-52d9-b03d-c272-ac475ae8c69e@linaro.org>
In-Reply-To: <80f9c2d5-52d9-b03d-c272-ac475ae8c69e@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 13 Jun 2022 10:15:17 +0300
Message-ID: <CAP6Zq1g40QFSehUiTevaf6pw-Ti+Q-GU3z5pM_tn9X7eChU-hA@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] ARM: dts: nuvoton: add reset syscon property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the clarifications, will update the next version.

Best regards,

Tomer

On Fri, 10 Jun 2022 at 12:51, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/06/2022 23:30, Tomer Maimon wrote:
> > Hi Krzysztof,
> >
> > Thanks for your comments
> >
> > On Wed, 8 Jun 2022 at 13:07, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 08/06/2022 11:56, Tomer Maimon wrote:
> >>> Add nuvoton,sysgcr syscon property to the reset
> >>> node to handle the general control registers.
> >>
> >> Wrong wrapping.
> > it will be very helpful if you could point me what wrong wrapped in
> > the commit message, is it the explanation or the header? or something
> > else?
>
> I pointed you last time. I pointed the exact line, exact rule you need
> to follow. I pointed it three times already and three times I said
> wrapping is wrong:
> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586
>
> "The body of the explanation, line wrapped at 75 columns, which will be
> copied to the permanent changelog to describe this patch."
>
> Your wrapping is not at 75 columns and it causes the commit to be less
> readable, without any reason. Please follow Linux kernel coding style/rules.
>
>
> Best regards,
> Krzysztof
