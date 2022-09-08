Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724D35B167E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiIHILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiIHIK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:10:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2086D9E9F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:10:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id nc14so36197324ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=j4bs3PwCf8LAGt65QBrJwkN23+x5pcdlnIufUSNJIIQ=;
        b=XlFrs6f1Ru6mfmrDHSloR2yePiVJ+BuOhZJkeSnSJ/SOiEPgkH7fc5Qh53N1oKwQvH
         +OoAiOMDe47PpbvHsnBhm6aYdjqjrlxYnSo7yiZbqsAzABr7z6IbsSFiYRJdU8C2FmM8
         5DH3vl93eI862Lj3YGNPcem5IKwqOFLfYUBV/2qlp66cAcJz+GK/kSoE2Nn6RNzXIdZ9
         oJUIG5tDSXTW/MSaMC7qK7mdrhaTxlGrLwOPowZ4WpaBUKmm7LiCFjVvj0ZXOF9c8KIJ
         SNp39mJEoQxBFUzec2wJzhGoK5rRNZ4WQVIZ8FGwGa0dLMi1y1WJKYonoLdQWd7mN1KK
         y6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=j4bs3PwCf8LAGt65QBrJwkN23+x5pcdlnIufUSNJIIQ=;
        b=O6YeX/9tU9bvebBbygWDU4Gd/rzaKnEs783C2zdV9vGM04OUA7dt0rh2C9+ilNq5Eh
         xb4CLfxY+sFh8L3cYpTcL0MhVjWO5hAY2LA+0/T7ZKU4N9yO2shERlcFZ/2714K1TieJ
         mQHgEHLSOsb6FUhmOirtAvMkTaiqe98n5La3qA9AtyA1MPDiNTYNviWbsEDXg/2F9Uej
         VUzK1tpGE8yU+DTKS6D5zWzyYI/zZNfT7AM+4BwtVajyizQKdznHVIYO8kC+v7yIGDD+
         HtgY2DmY+gz3Q3LmaUcql6xGYO6rJEIesj/EGoNdrBHLqIIGzCtcchtygTfY7EEQYlC3
         KPPQ==
X-Gm-Message-State: ACgBeo3Sw7F+IgRKcMtwyQvnmhOuzoBqhU66eagSmASlWBm1F/rxgDCW
        +kqcub3wohYm+8iZOaDIPa0rVRXJ4/neuOFYhMYGmA==
X-Google-Smtp-Source: AA6agR5SiTp1RzXd7QfGvIaagW9XneozTUfgGg71dHg/7zkzwgHHmEoyMH3isqJfBMUwPz7K/i/VjO5b2+tszIQ2lUg=
X-Received: by 2002:a17:907:1c89:b0:741:4453:75be with SMTP id
 nb9-20020a1709071c8900b00741445375bemr5269882ejc.208.1662624640469; Thu, 08
 Sep 2022 01:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-8-b29adfb27a6c@gmail.com>
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-8-b29adfb27a6c@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:10:29 +0200
Message-ID: <CACRpkdakswdcFTgEGX-+2fgOHZ+VsDsRe+yj8hnExKuugnO9xQ@mail.gmail.com>
Subject: Re: [PATCH v1 08/11] regulator: bd71815: switch to using devm_fwnode_gpiod_get()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 8:31 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
> so that gpiolib can be cleaned a bit, so let's switch to the generic
> fwnode property API.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
