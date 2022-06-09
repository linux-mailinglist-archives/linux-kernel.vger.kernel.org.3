Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043BC545690
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbiFIViI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241598AbiFIViE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:38:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C51E7373;
        Thu,  9 Jun 2022 14:38:01 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m25so24289287lji.11;
        Thu, 09 Jun 2022 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xuhZxHj/U/uyrGh0QRL2giIMCZ9xcES2xwt8P7yF6to=;
        b=JAkyByJksy+qoa6HbOhaGhB/7umKsKTTKRwcNWF42CdK388N8UhTbUlVshl1hbo75U
         2vG1b8kBfg43EPsLhebV6xvMcvfziFJyCUUScQZuF+5Nof4NGsK6cCKudmtaEdtK7xv6
         h8o1MYdfg8tYPc47QOgD9PtEIxKvN4sT804N0crGbBtDaMHhBAgW8RbcTBftPzROgRt3
         b5yGyLvcMCeaS5ERBw2UjCb+CyslfxvZplPLXK8+i48RqQ1O5/F/MwEEQgGqm+qyOuWT
         gqx92x39oXRUXwcXJnmoHJ2kpMq6fNg/xg6Ikshz+JeNMmsN0yKC/6w8txLih+QxAr0G
         03Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuhZxHj/U/uyrGh0QRL2giIMCZ9xcES2xwt8P7yF6to=;
        b=M1nGqr+/ywshoWvrFcGlwH1RMqiFnU7JadaeyNpNRQkdIAJARZvNtlJhRtBIcMnice
         F1UGAsuvdbBjbjsSW5LERJYvETG0jhVTkY8oXipmgLYwdU8VDCJ9y5CY/AEkYZeLQDEY
         wdaYWUSQjmdHmLGGiRTimJeWv++F9KrlyMwKNEH0utcTSOQalth1h9NpL1fVzUIv8jYd
         LQ8xvcRAlwVw7098d+X9X19OG3yn6tv0iLJWXvVakJyGNX0DzvLftYCTG9AXEZxxBh5N
         QtepbmkDFW+Q/z5lU77mZrL1Qd1yeEnqJL5zD6hIW0sK6CSZ4WTR1pag0sjFKeDF92Ik
         TXTg==
X-Gm-Message-State: AOAM533GRYb7IFO08rVDBCguYAdrcEbdKPQc1iQmIWyrnWeSuc2qcNlp
        WtgsSjLhq/iZorMZ5FBL+fcqN+KXslY/WmbMWL4=
X-Google-Smtp-Source: ABdhPJwUcamBCwOm6ERaUQOFsS9FH0jEHEp1L9m1V9Nk72MnEa1UzUuCExo1sqhaCb60aIqxKCobSgakC6CpKBCiUNk=
X-Received: by 2002:a05:651c:158c:b0:250:a23d:2701 with SMTP id
 h12-20020a05651c158c00b00250a23d2701mr60541188ljq.475.1654810679845; Thu, 09
 Jun 2022 14:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-12-tmaimon77@gmail.com>
 <91549b70-08fc-ed6f-c48e-5bcb70ea63d0@linaro.org>
In-Reply-To: <91549b70-08fc-ed6f-c48e-5bcb70ea63d0@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Fri, 10 Jun 2022 00:37:49 +0300
Message-ID: <CAP6Zq1j2VZno4w4w0QCYwHnRaVqiM=DnNSmND1vOGDs_wfi2zw@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] reset: npcm: using syscon instead of device data
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

Hi Krzysztof

Sorry but I didn't ignore your comment.

For not breaking exciting boards I add the following patch in V2
https://lore.kernel.org/linux-arm-kernel/20220608095623.22327-11-tmaimon77@gmail.com/

On Wed, 8 Jun 2022 at 13:08, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/06/2022 11:56, Tomer Maimon wrote:
> > Using syscon device tree property instead of
> > device data to handle the NPCM general control
> > registers.
> >
>
> Again ignored the comment.
>
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  drivers/reset/reset-npcm.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
> > index 2ea4d3136e15..312c3b594b8f 100644
> > --- a/drivers/reset/reset-npcm.c
> > +++ b/drivers/reset/reset-npcm.c
> > @@ -138,8 +138,7 @@ static int npcm_reset_xlate(struct reset_controller_dev *rcdev,
> >  }
> >
> >  static const struct of_device_id npcm_rc_match[] = {
> > -     { .compatible = "nuvoton,npcm750-reset",
> > -             .data = (void *)"nuvoton,npcm750-gcr" },
> > +     { .compatible = "nuvoton,npcm750-reset"},
> >       { }
> >  };
> >
> > @@ -155,14 +154,10 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
> >       u32 ipsrst1_bits = 0;
> >       u32 ipsrst2_bits = NPCM_IPSRST2_USB_HOST;
> >       u32 ipsrst3_bits = 0;
> > -     const char *gcr_dt;
> >
> > -     gcr_dt = (const char *)
> > -     of_match_device(dev->driver->of_match_table, dev)->data;
> > -
> > -     gcr_regmap = syscon_regmap_lookup_by_compatible(gcr_dt);
> > +     gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "nuvoton,sysgcr");
> >       if (IS_ERR(gcr_regmap)) {
> > -             dev_err(&pdev->dev, "Failed to find %s\n", gcr_dt);
> > +             dev_err(&pdev->dev, "Failed to find gcr syscon");
> >               return PTR_ERR(gcr_regmap);
>
> Comment still ignored.
>
> There is no point in this review if you keep ignoring what we ask to fix.
>
> If something is unclear, ask for clarification. Resending without
> implementing the comment means that you ignore the review which is waste
> of my time.
>
> I am sorry, but this is not acceptable.
>
> Best regards,
> Krzysztof

Best regards,

Tomer
