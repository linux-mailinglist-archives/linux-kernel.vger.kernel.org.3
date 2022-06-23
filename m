Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16DA557F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiFWQOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiFWQOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:14:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17692F649;
        Thu, 23 Jun 2022 09:14:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j22so17277869ljg.0;
        Thu, 23 Jun 2022 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chAW9yXxTwtCayPDN2K4p2x7rb0AVI/k5FO9A88UkBY=;
        b=iepp750f1IXDFnBvhK4HM5vyqZCuV/H9B+98+C6wYTafYO5h+NkfZkl1dxzQEBVmyB
         FaXWPAUHYp0NuDlM31aN6KreHiZ5gKyAy3tRZV2MFtpveYk+Oyx+vkg15GoG1gVj6KLx
         /KJ44R/NvwfBg2J5gU5GX4FpHFF9uXWXRHyqFCNZTsxPysn+bxGy/2mPl5tyyRF4zCu6
         uqSQEG4NhhADABXUy98hg/xetXQgQpEUqCXYuMCXt4WyceOTcq0tbov8gMPr693Jn5iR
         blCa5AUgMxBXUYv/UZb2N01ZjcT2fZjVJ4UmLn2GN5EYcUftX2R+0QcFvlZ6fwjUq+DT
         p5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chAW9yXxTwtCayPDN2K4p2x7rb0AVI/k5FO9A88UkBY=;
        b=vQdMuy7cK+2sdsC9KyrQn6vUNKHHdbd+4fJzJQ0zgJL9aQfutlJc3A8UIxeerQw28M
         xSOvVqM+JS7n1xnQbnV0A6/AOKtzUbZHHk2o/xR0cN2Vemx4xqJafODw81b5eiXXj/OZ
         52SQUuSo3iWoz35LLzvNU/BOUQrB83HeQJSKP6wo48lGzKgUuxuAcku8Rk/AnLgwXaYH
         BZMZvkh+Ug4M+zJowoaGHyIrWi0tuLCwXUuhNxQmbAzxpS8Url3c+pYCixIqGV8TmNA9
         yHKssm57mgJG1u5pVzsful3VYcOaSOIy0V1aRvHkEjIDCHikJlASY6WcrB0eJekfmsqc
         wb5Q==
X-Gm-Message-State: AJIora8x57NoP+N48YCVL0BWi1VR0NT/UY2FqDr6kREzx6c9lTBs3lVz
        oyeGmgTes+o4pFaUvcN/C2x4Ol0U0meAeBxfVmA=
X-Google-Smtp-Source: AGRyM1uaOZs3XcqnApOZWDYeXACNwy3jox6uESty97oe5gc4bwE/M1cCoRJ23ADElhT0XKwR5RsMcZQXTxqHpm4Pvco=
X-Received: by 2002:a2e:990:0:b0:25a:7c03:eb70 with SMTP id
 138-20020a2e0990000000b0025a7c03eb70mr4983157ljj.350.1656000887671; Thu, 23
 Jun 2022 09:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220609150851.23084-1-max.oss.09@gmail.com> <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
In-Reply-To: <CACRpkdZ0=8poNcFaCYSmMyg1GBfkHLAr3QvvzFKweLPr3UM2vg@mail.gmail.com>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Thu, 23 Jun 2022 18:14:36 +0200
Message-ID: <CAEHkU3Wya0nRhaBDisAQBm5kf=2YcdJYzz2jKiL___mZQzL_Sw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
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
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi all

On Thu, Jun 16, 2022 at 2:51 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Jun 9, 2022 at 5:10 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> > This series adds a PM domain provider driver which enables/disables
> > a regulator to control its power state.
>
> Actually, we did this on the U8500 in 2011.
>
> IIRC this led to problems because we had to invent "atomic regulators"
> because regulators use kernel abstractions that assume slowpath
> (process context) and power domains does not, i.e. they execute in
> fastpath, such as an interrupt handler.
>
> The atomic regulator was a subset of regulator that only handled
> regulators that would result in something like an atomic register write.
>
> In the end it was not worth trying to upstream this approach, and
> as I remember it, Ulf Hansson intended to let the power domains poke
> these registers directly, which was easier. (It's on Ulfs TODO list to
> actually implement this, hehe.)
>
> Yours,
> Linus Walleij

Thanks for all the feedback.

The approach taken with the patchset seems to be architecturally wrong
and as Linus pointed out has additionally the flaw that the regulator
would need to be controllable in atomic context which depending on
the regulator driver / configuration may not be fulfilled.

So our plan is to explicitly handle a (shared) regulator in every
driver involved, adding that regulator capability for drivers not
already having one.


The question which remains is on how one would model functionality
which by itself does not need a driver but would need regulator
support to switch its supply on in run state and off in suspend
states and poweroff, like for example a simple level shifter.
Any suggestions on this topic? Thanks.

Cheers
Max
