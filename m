Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EBF5701D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiGKMO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiGKMO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:14:56 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9228442AF7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:14:53 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f73so8344288yba.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25oBsdkdAhZtz9GpYFgK6+5YQgvPAX8qLWh1ZU1po2I=;
        b=rryNTuuDI09l9RX6nuyLLuKI9aby5BuW1ArYpALt6JzpgutKV26xB20URJo1blo8qd
         9TPX9LVJ01G89EUDFcKGKfEiMEIAc8c9Ppj0B177foG0iHgkSy7/5qDaQP25G228TtWx
         79okGJRrrO6YAlHRNRzJOaEJkjrDRXzvrysHUCNRAgw3Hh5QopAl+ehqvZYI45HqcTwD
         pXGmWkJbQJkCYU4n9XlEPlFHX79ZSy71rNblJMLZ2WUx+zpuKL/uFlRxl78QrX9Yb/Dj
         4d0Ou+Gr50R3MTbWQRJRHTu+IZz/cIzGHdeE1hwV1j6dnSJ5dE3cbCCC9dmR/xJQqkZP
         Lqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25oBsdkdAhZtz9GpYFgK6+5YQgvPAX8qLWh1ZU1po2I=;
        b=MZ7zzFDl7VV/iVvAKE3iq0m3vgSSsXsUj/CaufA9YVPbD+uVvBttBH/JmW6A1auL+e
         6VuNppwjOBUspGe/s+1giy4DTrIk4ylR+Cqtb2TGEYIsCGusMzW5AzG4EjsLIXUWs0Y2
         3x6s1VpZkvmcWMm3rL1VtvdXhQKr1AtkRDIjw90h1vnK5yL3L79QKyWbsp3eEEu1lQ2Q
         vAAUMuHej4WruXElGRu7Cm0B6raZzafXtYKgNYfYvyjUwzLCozdGWo2O4q8jKneayVTc
         eFQI276bK5D1g4mFS8P43LeT3XgZ6Nixu/p+WTi31ghxpIeucQtZns0vQ8ONrF07XrY2
         PJ2Q==
X-Gm-Message-State: AJIora9JjtofL8AyNtJXzV8ypJRqOgUUtX5GKA51V0fyFXJOgh6H+R/C
        t1qQJbbZQjo8mGLIhxlYZpwW94w4FPZ99Yiz8HovJw==
X-Google-Smtp-Source: AGRyM1s4NAdU2acv94PKdso6jNJwJHuRCd3fpy5rcGDdpnteBvstdkQCkNYCQcU0CtedC68k2uYpz+EZQ+Yok8e68QM=
X-Received: by 2002:a05:6902:150a:b0:66f:8a6:be47 with SMTP id
 q10-20020a056902150a00b0066f08a6be47mr9067019ybu.291.1657541692812; Mon, 11
 Jul 2022 05:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220706151553.1580790-1-michael@walle.cc> <87k08kko88.wl-maz@kernel.org>
In-Reply-To: <87k08kko88.wl-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 14:14:41 +0200
Message-ID: <CACRpkda1zjYCFcCwyQ6zsNGOLSGOappoBaF2U=cAk8J2=xiFow@mail.gmail.com>
Subject: Re: [PATCH 1/2] genirq: allow irq_set_chip_handler_name_locked() to
 take a const irq_chip
To:     Marc Zyngier <maz@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jul 11, 2022 at 11:11 AM Marc Zyngier <maz@kernel.org> wrote:
> On Wed, 06 Jul 2022 16:15:52 +0100,
> Michael Walle <michael@walle.cc> wrote:
> >
> > Similar to commit 393e1280f765 ("genirq: Allow irq_chip registration
> > functions to take a const irq_chip"), allow the
> > irq_set_chip_handler_name_locked() function to take a const irq_chip
> > argument.
> >
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> > Given this is the correct approach, can this go through the pinctrl tree?
> > Of not, do we need an immutable tag?
>
> I'd prefer this sort of change went into the IRQ tree, as it
> potentially has a wide ranging effect, and that the rest of these
> changes went via the IRQ tree too. It makes it easy to take the branch
> down if something goes wrong.
>
> Given that I already do carry a bunch of GPIO related patches, I'm
> happy to add that to the mix if Linus ack the second patch.

I ACKed it! Go ahead.

Yours,
Linus Walleij
