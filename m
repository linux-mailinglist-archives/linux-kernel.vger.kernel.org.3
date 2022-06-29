Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8925F55FB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiF2JDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiF2JDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:03:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6797E0DD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:03:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e40so21269874eda.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OQ2WMkG8qLYJJV0C5HMk4dgjYPugRu+GbhP5w4vvjic=;
        b=EdB8ANSbg+mWuoSRVZV6lr9LnnNYVKTgGfUKrCfmap9mRwKnvgiD3XqLBs/Og34ANA
         lCesVtTj5HLZNe2p26O/DOgLADPjN4owN7qoaJFbOejhqAWfY/CYuOi6P+Cl4Lx3aIwu
         DyXeCITYCXDXAiAFOENqJr8hoAZVsULyHAovswHOftt4FEKV9lN4nEvHvBff55/EwQuB
         YPC/Fx8PrPFEzIK8qaHLgQglWIKhHYrHWVlIe6IQFu/xdoyQiuyGrY7yCfmZftpgvDz3
         WiCAsFa4Brbganuf6drZtl/SGHVBNOg1xTlnFQ5fkpXW4PixJlA0K4HB7SWr9d+Y98TK
         Zgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OQ2WMkG8qLYJJV0C5HMk4dgjYPugRu+GbhP5w4vvjic=;
        b=2cA7fUsmi++uGCQE+LckCh1PrsuNgE6Erz9gJp/wN3+eI3rfa1f0y2U02E0hWiIWUP
         ovoLhn8Vu/gOavHz3LtC4nKVVA+tOAXeLMx9KpNzDVLhXyCvftc3GbB6XkIhq+eYO+5m
         ICp+E/vgDUpfr6gh1BhAoX7Wg8RMTR7ylpMcbuke/XV4w9+wsqnh7ax6CQ9T+GTGLTS0
         v62WddNj6LgQ4IrYaiisgxlIFRWMQ6Z4IeLe17Zo7Z8I1+p2C1bsD+NBdvguBYZ+7tzk
         fRvdSkw29aacxliouxga049Oyw8uYMkKdsGY/pNbuFAVkDVkfdI9uO12HLIQarsH9tcP
         fTnQ==
X-Gm-Message-State: AJIora8COnT3nyvfBOIPy77CsP72QsGt+FGUHQtZxxQSEJCo2NjDChCv
        u6tPHtecpS+Z322cv4u2khbpg7HM3YeQ9dEpxE0=
X-Google-Smtp-Source: AGRyM1s6NvfpuVf59YeExhpAq82uCzfN6TBh49uac0wvq2suVqnpKDcYOJ/0eVoirPcMNMr5Qg/mfAQcBO4JMHU92us=
X-Received: by 2002:a05:6402:698:b0:435:75d9:f94c with SMTP id
 f24-20020a056402069800b0043575d9f94cmr2869268edy.330.1656493388924; Wed, 29
 Jun 2022 02:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <1656466861-7737-1-git-send-email-u0084500@gmail.com> <618f0794-429c-705d-ab4c-84aace6aaaaa@collabora.com>
In-Reply-To: <618f0794-429c-705d-ab4c-84aace6aaaaa@collabora.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 29 Jun 2022 17:02:57 +0800
Message-ID: <CADiBU3-DO0tQhEC9f+p06kDFZsk8vDVu_H74PWKSLrBaW5zB5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: mt6370: Use 'fwnode_gpiod_get_index' to
 fix gpio parsing
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2022=E5=B9=B46=E6=9C=8829=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:2=
3=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 29/06/22 03:41, cy_huang ha scritto:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > From the common binding, 'enable-gpio' or 'enable-gpios' are all well
> > for external 'enable' gpio.
> >
> > 'gpiod_get_from_of_node' only parse the 'enable' property, it need to
> > add the gpio suffix. It's more convenient to use fwnode_gpiod_get_index=
.
> > Although fwnode parsing is not preferred, but 'of_parse_cb' already can
> > guarantee the callback will only be used by regulator of_node parsing.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >   drivers/regulator/mt6370-regulator.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/regulator/mt6370-regulator.c b/drivers/regulator/m=
t6370-regulator.c
> > index bc356b4..949b2c7 100644
> > --- a/drivers/regulator/mt6370-regulator.c
> > +++ b/drivers/regulator/mt6370-regulator.c
> > @@ -153,7 +153,8 @@ static int mt6370_of_parse_cb(struct device_node *n=
p,
> >       struct gpio_desc *enable_gpio;
> >       int ret;
> >
> > -     enable_gpio =3D gpiod_get_from_of_node(np, "enable", 0, GPIOD_OUT=
_HIGH |
> > +     enable_gpio =3D fwnode_gpiod_get_index(of_fwnode_handle(np), "ena=
ble", 0,
>
> Since this driver is never calling gpiod_put(), you can even fix that in =
one shot.
>
> Just use devm_fwnode_gpiod_get() here, as it's guaranteed that priv->dev =
is
> initialized at this time.
>
Refer to the regulator framework,it will take over the gpio_desc.
You cannot use devm version for 'gpiod_get'.
> Cheers,
> Angelo
>
>
