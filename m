Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D063561E74
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiF3Oxv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Jun 2022 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiF3Oxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:53:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48241B798
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 07:53:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6vXc-0002Re-Vr; Thu, 30 Jun 2022 16:53:13 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6vXO-003bqn-HG; Thu, 30 Jun 2022 16:53:02 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1o6vXR-000AqK-Co; Thu, 30 Jun 2022 16:53:01 +0200
Message-ID: <c01103ae5582cda01708c25ddc3f9bb538c67ab0.camel@pengutronix.de>
Subject: Re: [PATCH v6 08/17] reset: npcm: using syscon instead of device
 data
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Tomer Maimon <tmaimon77@gmail.com>
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
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 30 Jun 2022 16:53:01 +0200
In-Reply-To: <CAP6Zq1htXxpBR-=FW=8grzspGcLPDM5qiMUPNqh7wNiO=0=HAA@mail.gmail.com>
References: <20220630103606.83261-1-tmaimon77@gmail.com>
         <20220630103606.83261-9-tmaimon77@gmail.com>
         <63f8d70ad9c657890669e9c32775632af4e36995.camel@pengutronix.de>
         <CAP6Zq1htXxpBR-=FW=8grzspGcLPDM5qiMUPNqh7wNiO=0=HAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2022-06-30 at 14:20 +0300, Tomer Maimon wrote:
> Hi Philipp,
> 
> Thanks for your comment.
> 
> On Thu, 30 Jun 2022 at 13:59, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > 
> > Hi Tomer,
> > 
> > On Do, 2022-06-30 at 13:35 +0300, Tomer Maimon wrote:
> > Using syscon device tree property instead of device data to handle the
> > NPCM general control registers.
> > 
> > In case the syscon not found the code still search for nuvoton,npcm750-gcr
> > to support DTS backward compatibility.
> > 
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  drivers/reset/reset-npcm.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
> > index 2ea4d3136e15..431ff2b602c5 100644
> > --- a/drivers/reset/reset-npcm.c
> > +++ b/drivers/reset/reset-npcm.c
> > @@ -138,8 +138,7 @@ static int npcm_reset_xlate(struct reset_controller_dev *rcdev,
> >  }
> > 
> > 
> >  static const struct of_device_id npcm_rc_match[] = {
> > -       { .compatible = "nuvoton,npcm750-reset",
> > -               .data = (void *)"nuvoton,npcm750-gcr" },
> > +       { .compatible = "nuvoton,npcm750-reset"},
> > 
> > Add a space.                                  ^^
> Will modify in V7
> > 
> >         { }
> >  };
> > 
> > 
> > @@ -155,15 +154,15 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
> >         u32 ipsrst1_bits = 0;
> >         u32 ipsrst2_bits = NPCM_IPSRST2_USB_HOST;
> >         u32 ipsrst3_bits = 0;
> > -       const char *gcr_dt;
> > 
> > 
> > -       gcr_dt = (const char *)
> > -       of_match_device(dev->driver->of_match_table, dev)->data;
> > -
> > -       gcr_regmap = syscon_regmap_lookup_by_compatible(gcr_dt);
> > +       gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "nuvoton,sysgcr");
> >         if (IS_ERR(gcr_regmap)) {
> > -               dev_err(&pdev->dev, "Failed to find %s\n", gcr_dt);
> > -               return PTR_ERR(gcr_regmap);
> > +               dev_warn(&pdev->dev, "Failed to find nuvoton,sysgcr search for nuvoton,npcm750-gcr for Poleg backward compatibility");
> > 
> > Is this warning useful to the user? Maybe add suggestion like "please
> > update the device tree". Also there is no further message if
> > nuvoton,npcm750-gcr is found and all is well.
> 
> O.K.
> I think about two options:
> 
> 1. Modify the message "Failed to find nuvoton,sysgcr property, please
> update the device tree\n Search for nuvoton,npcm750-gcr for Poleg
> backward compatibility"

I would replace "Search for" with "Using"
The second line probably should be dev_info() level.

> OR
> 
> 2.
>         if (IS_ERR(rc->gcr_regmap)) {
>                 dev_warn(&pdev->dev, "Failed to find nuvoton,sysgcr
> please update the device tree");
>                 rc->gcr_regmap =
> syscon_regmap_lookup_by_compatible("nuvoton,npcm750-gcr");
>                 if (IS_ERR(rc->gcr_regmap)) {
>                         dev_err(&pdev->dev, "Failed to find
> nuvoton,npcm750-gcr");
>                         return PTR_ERR(rc->gcr_regmap);
>                 }
>                  dev_info(&pdev->dev, "found nuvoton,npcm750-gcr for
> Poleg backward compatibility");
>         }
> 
> The only problem that I have with option 2 is if our customers will
> use the latest reset driver and they will not update their device tree
> they will see all the time the dev_info message.
> 
> What do you think?

I'm fine with either. With the "please update DT" prompt it's clear how
to get rid of the warning.

regards
Philipp
