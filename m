Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB454E118
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiFPMvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiFPMvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:51:02 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B4A1DA5B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:51:02 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-30fdbe7467cso12979137b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqcQdECaLEMeu798gUkn+FpUYyFy1DJMsUqQZAiS20E=;
        b=C4NbgkxvHPJh/aON7dBiPaprkR0AMp9bAaEZoqp2vri2dF8a738FS26t+ENTGKgqXv
         271c7Q2E1es212I5u2fiRQ+Me0VjTprhPhG6+U+0nWZDNVkL5H+LUBq8+qxfHB9hpoAt
         4cuvdcmf/FZL/Vkn/okI3dQ+v66vK32Y7ROAZcOu9qtkBVSfjE3mRF/OwRgU/7CaxFQG
         QZpStfNZjhkrXxSrBssNmFjAPFpBt7wRWfHDaP32lP5KU0Y7l1nvbKT1rChwUBXzi838
         sp2fUvW2+7Xg3xKuaI81TQPaB4j9a555XhkVtv/rnk9CTbCh6MHZDyFsimq42v075hAF
         7Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqcQdECaLEMeu798gUkn+FpUYyFy1DJMsUqQZAiS20E=;
        b=f2XIeczqY55nsNCMNgMwtcHsxZ01ganDsr6T6teW7Rd78Mnj6Rt4p7xDPHJH8ipQuc
         7lPu9/JaTfWXBuSvOgFO7a4rD8De+0HRRTR1uFJQztDiLzuiDAsEZsgBZMYgvQx4TGy5
         FcidEYkNnqxFJmHG3eKRWc+7NeKlFK62u/Grq7KFiEtOmpd6xpQSTG0gG7M/4xkzP9x0
         s8dnyzXkPUe5d7rlIfl2FR6PqKxm2+lGXuNx7Z4VCxC/Cj/12xP+jAg7Pcm186yyjB9D
         TqDzWkRJ9W8cU4AtgAnngxBKbsiVmB2R6IIa9mfRXArsv6VRy3A0EUJsPJ1jjRUiUuoP
         z29Q==
X-Gm-Message-State: AJIora8SbVlTwmjCbWEbokmAw/+8yDaDm1heFf9jMPpAkUmsfm6zPZ9k
        iaUs7tU85ws/s+ierf9jgwmxsWdPO7RVjhwsrwmLSg==
X-Google-Smtp-Source: AGRyM1sEXuGD1MkxQDndknFUJmjARkkpTgwaVKIO0Ag/GmRSrXKMYSNgjpE6bf4U9IKfhpzp9x6XeHiOpAZohIdUHsQ=
X-Received: by 2002:a0d:cc54:0:b0:317:752c:bcf3 with SMTP id
 o81-20020a0dcc54000000b00317752cbcf3mr1901735ywd.437.1655383861386; Thu, 16
 Jun 2022 05:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com>
In-Reply-To: <20220609150851.23084-1-max.oss.09@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jun 2022 14:50:49 +0200
Message-ID: <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     max.krummenacher@toradex.com, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-pm@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 5:10 PM Max Krummenacher <max.oss.09@gmail.com> wrote:

> This series adds a PM domain provider driver which enables/disables
> a regulator to control its power state.

Actually, we did this on the U8500 in 2011.

IIRC this led to problems because we had to invent "atomic regulators"
because regulators use kernel abstractions that assume slowpath
(process context) and power domains does not, i.e. they execute in
fastpath, such as an interrupt handler.

The atomic regulator was a subset of regulator that only handled
regulators that would result in something like an atomic register write.

In the end it was not worth trying to upstream this approach, and
as I remember it, Ulf Hansson intended to let the power domains poke
these registers directly, which was easier. (It's on Ulfs TODO list to
actually implement this, hehe.)

Yours,
Linus Walleij
