Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981AD57FAD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiGYIEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiGYIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:04:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628FA5FEF;
        Mon, 25 Jul 2022 01:04:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j22so19126473ejs.2;
        Mon, 25 Jul 2022 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9oGiDsxiFpBH+3rbxjYFk4fKS6kxjytRyEJ438nM14=;
        b=CJb2GrDqw5wptQkMGvGnlEHmNqNpBTz+oVejWM8vbDuV20ZOTC6BJ/xAOcSduhufTS
         CtY8s0Ob07oaPbu/f4yqfvkHz/xDY1O6vs2/oftm3gv1Uc+ykJC+fUd1S21cXIv8VjyW
         kSXeGTgiv3k4SaU7t5pXcn2tjl5/OFjnaZJ8Uu0DxeB/9Oof1BN5BOo2rRbXDmOoY1Oc
         CAj9lT0OP1cy+XTY99JtA98O+TDOotsScJIH1YM0dQeqD+8VHoEVugkGshM79Qhx2IYY
         Qmh4+CVjG1cahmKQrRaUHy+VKbjtu21T43SHNPAsr2ti4ofng6x5uib9AjGL5NY7lM5l
         yEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9oGiDsxiFpBH+3rbxjYFk4fKS6kxjytRyEJ438nM14=;
        b=qZNUDlfWV1gfKJrxcTaZGJJhKHsk86f362lbhhUtJH+39QG18dOLO63N1sHxgCRE1H
         hXm6eU6V0zn4Ngv/zQjWMXrfZCkvsMO/VMSSToZETMcw0REBy9BmK+P9YJfC+nZgw5cT
         F+qDNuwoySwOch2p8/iJA5ylWFoyf0v7tFAwEeaH0uWrL6+ZZT4aBARFcbEv55R4JkOu
         2wncweioY2IspB39VCmTaBJU8caqKqXBd+e1p9oyen/hPiOj5FQVl/1Y+O0e0bEuHsCf
         KjK7sJb4BxeEWWf1jzEqXuorh3Ov6obUdVU+bbyYUqQ67tauI+GTcAOFluXaORzYiWvf
         Zysg==
X-Gm-Message-State: AJIora8TqEE87kbc31MTqzf5aii+SPJ4mSYWqmMxH1ccYAQZK7hV2fAY
        /mR9EM6czKo4CmxzsJ13XvQCrJJhJsU0MZbEpVU=
X-Google-Smtp-Source: AGRyM1slRdGOzS2afMezkzisSa07VKYBk0S3NkjvREARPdSLLPsbko0C4F61HAPbqNjfvUDyrYKyJb1xX+GfnwkFVZU=
X-Received: by 2002:a17:906:8a4a:b0:72b:5b23:3065 with SMTP id
 gx10-20020a1709068a4a00b0072b5b233065mr9334315ejc.557.1658736256789; Mon, 25
 Jul 2022 01:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-9-peterwu.pub@gmail.com>
In-Reply-To: <20220722102407.2205-9-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 10:03:40 +0200
Message-ID: <CAHp75VessBZMBA6wNWhhXhPshDCghgkV8EkEUUqOeLqn-5pmpA@mail.gmail.com>
Subject: Re: [PATCH v6 08/13] usb: typec: tcpci_mt6370: Add MediaTek MT6370
 tcpci driver
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 12:25 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>
> Add support for the Type-C & Power Delivery controller in
> MediaTek MT6370 IC.

...

> +static int mt6370_tcpc_set_vconn(struct tcpci *tcpci, struct tcpci_data *data,
> +                                bool enable)
> +{
> +       return regmap_update_bits(data->regmap, MT6370_REG_SYSCTRL8,
> +                                 MT6370_AUTOIDLE_MASK,
> +                                 !enable ? MT6370_AUTOIDLE_MASK : 0);

Why not positive conditional?

  enable ? 0 : mask

> +}

...

> +       ret = devm_add_action_or_reset(dev, mt6370_unregister_tcpci_port,
> +                                      priv->tcpci);

I believe nothing bad will happen if you put it on one line.

-- 
With Best Regards,
Andy Shevchenko
