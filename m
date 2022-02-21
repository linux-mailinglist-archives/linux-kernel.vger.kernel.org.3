Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F54C4BD72C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346221AbiBUHe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:34:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346293AbiBUHet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:34:49 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2C26310;
        Sun, 20 Feb 2022 23:34:12 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id c14so29934403qvl.12;
        Sun, 20 Feb 2022 23:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R4B6JGXR6mvZF1952Vke43JV0QR66SxjuMutQVOsFo8=;
        b=Z06LCpgN2MVimjjFUlm3IrOc0bB63t5ON0LGaE4naFFq5j3x0jb78evJj8rax3eWP/
         wgLsdIlXGADTXtwIZOPQPKaJFEYfYXwgtZ5UOBJuzO2T8WAjlN5DomYW9eZL93ICBZT8
         yimSlEUKhwEw4f1FPbp0zK/EwW0EF/4JAD5uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R4B6JGXR6mvZF1952Vke43JV0QR66SxjuMutQVOsFo8=;
        b=YmMEd+CHsdS0M5r5aMIe5Z8ScJKlFdbIFOKLqG52zRhQyW7ptqSoXd1fiajzxbl9sH
         l4L60kMO5C7KtaqsC1Fdyb9D8LMwkvfM9hepITVhgrdPLA+g/Of3vZouBZW/jwiLaeLn
         fV3qp+A+TLNljy3hZVBSTd5GGSwA7A2A84Fge+rmIUYhwj+WfVi5ifza+XdEpQVT2+LH
         41dCQZzG6lYTW64TablpGoo66LKFiUUXQdxKJ+9nKNjUYb5fZ75jOg9kJ7JxxJLEkr8s
         Q2XC2e48GPr2aaDPn1C3PUTbTGpqlvcqQKzx36YyQIuVUNXwfsnRYZ2QjDCqbjPcf6kU
         ZXxA==
X-Gm-Message-State: AOAM530Fwtu09ZEqAqW8L10A/Lk3K218yaytYQuYDF9aTW54vHLIR5/Y
        XhqY1NRbM+zHfpPhw/EUo2vgezzcJoraEtaVpjA=
X-Google-Smtp-Source: ABdhPJx2pPvLE2lY8PhsDFi43EexUA016GTtes5KYX0xv/HLHfxhIxLOM/pn0HF05x8GWnFK30iX+BejJZ2bFcsMSdI=
X-Received: by 2002:ac8:5b82:0:b0:2cf:232d:b1f8 with SMTP id
 a2-20020ac85b82000000b002cf232db1f8mr16728455qta.58.1645428851531; Sun, 20
 Feb 2022 23:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20210921043936.468001-1-andrew@aj.id.au> <d2b85ad7-aef7-6088-03f5-cbd6e0bcab5d@kaod.org>
In-Reply-To: <d2b85ad7-aef7-6088-03f5-cbd6e0bcab5d@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Feb 2022 07:33:59 +0000
Message-ID: <CACPK8Xdvns7PK9t1ZutAbkJqhb5eRcoWCDySQGsfbtLv+XMvqQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] leds: pca955x: Expose GPIOs for all pins
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        linux-leds@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,



On Fri, 24 Sept 2021 at 06:41, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 9/21/21 06:39, Andrew Jeffery wrote:
> > Without these patches the driver limits the number of pins exposed on
> > the gpiochip to the number of pins specified as GPIO in the devicetree,
> > but doesn't map between the GPIO and pin number spaces. The result is
> > that specifying offset or interleaved GPIOs in the devicetree gives
> > unexpected behaviour in userspace.
> >
> > By always exposing all pins as GPIOs the patches resolve the lack of
> > mapping between GPIO offsets and pins on the package in the driver by
> > ensuring we always have a 1-to-1 mapping.
> >
> > The issue is primarily addressed by patch 1/2. Patch 2/2 makes it
> > possible to not expose any pins as LEDs (and therefore make them all
> > accessible as GPIOs). This has a follow-on effect of allowing the drive=
r
> > to bind to a device instantiated at runtime without requiring a
> > description in the devicetree.
> >
> > I've tested the series under qemu to inspect the various interactions
> > between LEDs vs GPIOs as well as conflicting GPIO requests.

> > Please review!
>
> This is simpler than the 'ngpio' business we had before.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

I saw that you recently merged some LED patches. I was wondering if
you could consider this series for v5.18. It still applies cleanly,
and we've been running it for a while now, so it's very well tested.

Cheers,

Joel
