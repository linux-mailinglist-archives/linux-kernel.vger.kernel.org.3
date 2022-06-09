Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1952545793
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbiFIWnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345786AbiFIWm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:42:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA5925A82A;
        Thu,  9 Jun 2022 15:42:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a2so34047035lfg.5;
        Thu, 09 Jun 2022 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBqjJZZ0M+7Q/xVRLShZPGqqDGt9J93+4pKuC2SGml0=;
        b=UNrAa2wkcgxy22e4V2fpziz5kwLT8g5bDgzeWx2lZHm7Ts2YAjqF2gn6eYyuQEmC2Y
         nIc1AaLG9N8a2eP0KogTlMQD0N0D+3QN3ZvLEJfn0La4yC4AFw6HT0Q10hymcLhmUsG0
         4X1mixRHlnny/4TsKlD9WIYKDQmKsLU0SK/fJMWD66OqpoGwnj4gXCGk3+2V20YLXPcI
         VvWsRkTtpSZ4Dyl0H6WZ63pKI7ROMcLhKTuZgGF5XPlkM3YWT88UWZGrzCgGQmgys2bL
         swXJd8N0IUyLGGlcCXNzqA5AHyq15l2AB1+/LqN9keS8KD96M9cAj7an90eW5KXVKb7y
         l5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBqjJZZ0M+7Q/xVRLShZPGqqDGt9J93+4pKuC2SGml0=;
        b=0dFxBv+GT5OMGJeOtH/FcpFvK162g9dQHAcIuSaCEkm8Z3OmJ6ZKgznEq1H8bWo3Nc
         DI8XVyMoYYbb0kDnCZdcoKom1QxzUt+zXdm5H937XYChaT/yxhngjhB1639ji1Cosc10
         5LF1pZBwfbNHNR1QuIpoKMRngiO0UJmLyXwCXmD2H0xKVqH2CGVurLW+19C6xKd3w9mq
         h+FtpzTXHWJjAWsmnEV34X3/LV+ASpQ2AASM9M+lwchrKfeJJo0u3wMypV0kWT5p3bmL
         cJefdZv6JLKcCBJZnfOowIRrRcXyhAGL1KC7qtrs+48s13EItymfe42aSEbcXoNTAy+Y
         AiwQ==
X-Gm-Message-State: AOAM5307TuhHjQ0sk16qZyRaCLkBWyE7Je3K4JF3wLnRD3NiQN+KB2oP
        W9IUpIBm2AxN3qeGwuYHcSqq8ktyDcbz7cf6JGY=
X-Google-Smtp-Source: ABdhPJyOI7btd4GLsQI0ynE+1WP/Zkc4k6P0AL6BWPLkL5+YXG0gRcy8024baT//Y2tbKmYLubYKiii4RTxwufnYJv4=
X-Received: by 2002:a05:6512:10c5:b0:479:2de0:561c with SMTP id
 k5-20020a05651210c500b004792de0561cmr17131263lfg.536.1654814573393; Thu, 09
 Jun 2022 15:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-8-tmaimon77@gmail.com>
 <20220609221433.B8990C34114@smtp.kernel.org>
In-Reply-To: <20220609221433.B8990C34114@smtp.kernel.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Fri, 10 Jun 2022 01:42:42 +0300
Message-ID: <CAP6Zq1j2+NciZqgYoDZ5DXNs_2NvfErQkKhW5CoePbrC7CQQkQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/20] clk: npcm8xx: add clock controller
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nancy Yuen <yuenn@google.com>,
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

Hi Stephen,

Thanks for your comment, it will be addressed next patch set

On Fri, 10 Jun 2022 at 01:14, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2022-06-08 02:56:10)
> > diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> > new file mode 100644
> > index 000000000000..40340c3611b5
> > --- /dev/null
> > +++ b/drivers/clk/clk-npcm8xx.c
> > @@ -0,0 +1,756 @@
> [...]
> > +
> > +#define PLLCON_LOKI    BIT(31)
> > +#define PLLCON_LOKS    BIT(30)
> > +#define PLLCON_FBDV    GENMASK(27, 16)
> > +#define PLLCON_OTDV2   GENMASK(15, 13)
> > +#define PLLCON_PWDEN   BIT(12)
> > +#define PLLCON_OTDV1   GENMASK(10, 8)
> > +#define PLLCON_INDV    GENMASK(5, 0)
> > +
> > +static unsigned long npcm8xx_clk_pll_recalc_rate(struct clk_hw *hw,
> > +                                                unsigned long parent_rate)
> > +{
> > +       struct npcm8xx_clk_pll *pll = to_npcm8xx_clk_pll(hw);
> > +       unsigned long fbdv, indv, otdv1, otdv2;
> > +       unsigned int val;
> > +       u64 ret;
> > +
> > +       if (parent_rate == 0) {
> > +               pr_debug("%s: parent rate is zero", __func__);
>
> Missing newline.
>
> > +               return 0;
> > +       }
> > +
> > +       val = readl_relaxed(pll->pllcon);
> > +
> > +       indv = FIELD_GET(PLLCON_INDV, val);

Best regards,

Tomer
