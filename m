Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D049B47565C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbhLOK2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:28:48 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:34502 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhLOK2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:28:47 -0500
Received: by mail-ua1-f49.google.com with SMTP id u40so6890059uad.1;
        Wed, 15 Dec 2021 02:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KatagByVh+i+7U2cQTugmti3xcd82C2QfCSX1Fy8Jo=;
        b=ZdSXZmf2lY0qFDYqOx3eNuTs5WT7NOc6ukNoEOMkaxZ3NNhCpjouW0yF1pkoFljy1w
         HUSS2IR71ynLU9QlZ+vceOeosIVH98QKlmfMF5TFoWdN+FaaBnjoHI3XHLineo26rzcE
         L0vF8a6M1a/3QqyO1XXl4iReb6AAPWS7DIgPCyJaoblQI5jz5UDBrQcdx04SU9xZb2QR
         MFBHNN2oSD17oX/fLz0rbzVT3EJja1mF7+0PDVUu/W9NwV/tSFs+9tY2jW9oOO5uvmGl
         SkYAn5jV4i8X6jz7yD5oFr9YdifBUPl5Z5D5KHafq9jVlQD+ixm6j2IKe/edzR3LtK/z
         yIsg==
X-Gm-Message-State: AOAM532tZOoro+pWrwNdT0Nz9aGG95R0gzUD1kyUzFYnMOXK0zAR4e7z
        ZMLwwxQuMeH3sReVJfwW4BBtp5ETUY9i9w==
X-Google-Smtp-Source: ABdhPJwJk+bggskRQZYTIK19Vj5/gOsc8Xt4U6CwTBeOCMMcwolTZ42DFwnIN3oQ/01lOMVIoFXaHg==
X-Received: by 2002:a9f:2d8c:: with SMTP id v12mr9159217uaj.25.1639564126939;
        Wed, 15 Dec 2021 02:28:46 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id j192sm325337vkc.39.2021.12.15.02.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 02:28:46 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id q21so14325294vkn.2;
        Wed, 15 Dec 2021 02:28:45 -0800 (PST)
X-Received: by 2002:a05:6122:920:: with SMTP id j32mr2889520vka.20.1639564125403;
 Wed, 15 Dec 2021 02:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20211213163929.7509-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211213163929.7509-1-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Dec 2021 11:28:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW_CKcXwOSUAbCreHVM62E35yjiCfpXC_wM0zK-V43CnA@mail.gmail.com>
Message-ID: <CAMuHMdW_CKcXwOSUAbCreHVM62E35yjiCfpXC_wM0zK-V43CnA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] pinctrl: Get rid of duplicate of_node assignment
 in the drivers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Radim Pavlik <radim.pavlik@tbs-biometrics.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        - <patches@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linux-mediatek@lists.infradead.org, linux-oxnas@groups.io,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Sean Wang <sean.wang@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        arm-soc <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 5:40 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove these assignment all at once.
>
> For the details one may look into the of_gpio_dev_init() implementation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>  drivers/pinctrl/renesas/pinctrl-rza2.c     | 1 -

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
