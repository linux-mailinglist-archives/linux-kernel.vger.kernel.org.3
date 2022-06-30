Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2DE5618F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiF3LVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiF3LU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:20:57 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8C4F64E;
        Thu, 30 Jun 2022 04:20:56 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id b2so329036uaq.8;
        Thu, 30 Jun 2022 04:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3z5vFPzEHYOTQK4dAz/8T9O7wftcSUcZ/VZVshv+x8=;
        b=AGHLlGOGhO0C6LP/EywIiPK3kp69qKznp+IwV4eEgAbF7QdJCbcvAbBmWXWragOp8N
         /4t3JQ2nFEINqZT8Uo7vC6dJoxT0WQCTBqevJ/f1fUwPj3NpO0pDh8GZ7yBJ72jK24ei
         vroPJiiirxt6iCmJBo5HSm0TNZdTYfvfSKuid+Gic7ZUonJ62jzi3wIdgY/ka3AcNIss
         ajD9cRvqTOGgPXElDZnLNDd4hoWe+8ZalbX1iZMuHebkmD+hY5FScbVSj0pzFOWo1vZc
         jw1P4uLQJx3Ht4OQxLDjH0TqDcmA71bFxaf3ZzOxwGV14WlJ5d5c0G2/JC8MOtHBIOWz
         nMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3z5vFPzEHYOTQK4dAz/8T9O7wftcSUcZ/VZVshv+x8=;
        b=d/DReOV7tCKTHXgQUjFzkqF9/9+OEAyBVPWkL6+xKoF8yBTfuFHOZIMh2Cvn+FH8Vw
         iZVpjxM1nTuUB46YvT/bQ0f03AasNYb+2ey9pHtyqluetI9l8Cfmo5Ny3l3iWTnPAiHV
         SyWVO4sSq9T3SD/8oA0IpJOwvxcEyaYmp3aZA8dzsh00LVvwoWtBpm114zfE3TaHiMUw
         yjpfLY9SIvortxWCxFn7UAHeraGaLub6H3RCFB0RyRvgrpIxNhKxdPEdAc/GMB68iXhF
         T3qailow5fzPlFx+qTNoY6DmeNV9A1aUQwpaVkGG61dCWtsF5ki9fBs/mKcKK6IyUVOY
         PY7Q==
X-Gm-Message-State: AJIora/ZxVI9ZSu7U2exbxmdx2VNz/fPy9rNHimzu0TjpAci/TJepclw
        4tQGmPrz87sWpcsNEpcw5sgmzM78Rlyt/iz0qF8=
X-Google-Smtp-Source: AGRyM1tIHcDTCN5whYD6NPt9k1aTCwy2tAYvtJdMaKYpKf0k99F9BYlhWeftUKEisFw9Bns+iXrNMGbk7qv62HtofsQ=
X-Received: by 2002:ab0:2790:0:b0:37f:1d08:c2b8 with SMTP id
 t16-20020ab02790000000b0037f1d08c2b8mr4309598uap.107.1656588055298; Thu, 30
 Jun 2022 04:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220630103606.83261-1-tmaimon77@gmail.com> <20220630103606.83261-9-tmaimon77@gmail.com>
 <63f8d70ad9c657890669e9c32775632af4e36995.camel@pengutronix.de>
In-Reply-To: <63f8d70ad9c657890669e9c32775632af4e36995.camel@pengutronix.de>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 30 Jun 2022 14:20:44 +0300
Message-ID: <CAP6Zq1htXxpBR-=FW=8grzspGcLPDM5qiMUPNqh7wNiO=0=HAA@mail.gmail.com>
Subject: Re: [PATCH v6 08/17] reset: npcm: using syscon instead of device data
To:     Philipp Zabel <p.zabel@pengutronix.de>
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

Hi Philipp,

Thanks for your comment.

On Thu, 30 Jun 2022 at 13:59, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> Hi Tomer,
>
> On Do, 2022-06-30 at 13:35 +0300, Tomer Maimon wrote:
> Using syscon device tree property instead of device data to handle the
> NPCM general control registers.
>
> In case the syscon not found the code still search for nuvoton,npcm750-gcr
> to support DTS backward compatibility.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/reset/reset-npcm.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
> index 2ea4d3136e15..431ff2b602c5 100644
> --- a/drivers/reset/reset-npcm.c
> +++ b/drivers/reset/reset-npcm.c
> @@ -138,8 +138,7 @@ static int npcm_reset_xlate(struct reset_controller_dev *rcdev,
>  }
>
>
>  static const struct of_device_id npcm_rc_match[] = {
> -       { .compatible = "nuvoton,npcm750-reset",
> -               .data = (void *)"nuvoton,npcm750-gcr" },
> +       { .compatible = "nuvoton,npcm750-reset"},
>
> Add a space.                                  ^^
Will modify in V7
>
>         { }
>  };
>
>
> @@ -155,15 +154,15 @@ static int npcm_usb_reset(struct platform_device *pdev, struct npcm_rc_data *rc)
>         u32 ipsrst1_bits = 0;
>         u32 ipsrst2_bits = NPCM_IPSRST2_USB_HOST;
>         u32 ipsrst3_bits = 0;
> -       const char *gcr_dt;
>
>
> -       gcr_dt = (const char *)
> -       of_match_device(dev->driver->of_match_table, dev)->data;
> -
> -       gcr_regmap = syscon_regmap_lookup_by_compatible(gcr_dt);
> +       gcr_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "nuvoton,sysgcr");
>         if (IS_ERR(gcr_regmap)) {
> -               dev_err(&pdev->dev, "Failed to find %s\n", gcr_dt);
> -               return PTR_ERR(gcr_regmap);
> +               dev_warn(&pdev->dev, "Failed to find nuvoton,sysgcr search for nuvoton,npcm750-gcr for Poleg backward compatibility");
>
> Is this warning useful to the user? Maybe add suggestion like "please
> update the device tree". Also there is no further message if
> nuvoton,npcm750-gcr is found and all is well.

O.K.
I think about two options:

1. Modify the message "Failed to find nuvoton,sysgcr property, please
update the device tree\n Search for nuvoton,npcm750-gcr for Poleg
backward compatibility"

OR

2.
        if (IS_ERR(rc->gcr_regmap)) {
                dev_warn(&pdev->dev, "Failed to find nuvoton,sysgcr
please update the device tree");
                rc->gcr_regmap =
syscon_regmap_lookup_by_compatible("nuvoton,npcm750-gcr");
                if (IS_ERR(rc->gcr_regmap)) {
                        dev_err(&pdev->dev, "Failed to find
nuvoton,npcm750-gcr");
                        return PTR_ERR(rc->gcr_regmap);
                }
                 dev_info(&pdev->dev, "found nuvoton,npcm750-gcr for
Poleg backward compatibility");
        }

The only problem that I have with option 2 is if our customers will
use the latest reset driver and they will not update their device tree
they will see all the time the dev_info message.

What do you think?
>
> regards
> Philipp

Best regards,

Tomer
