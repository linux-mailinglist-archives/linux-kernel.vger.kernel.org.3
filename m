Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7D3507C96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358219AbiDSWgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358189AbiDSWgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:36:06 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91372C669
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:33:22 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ec05db3dfbso164977b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPwL7aoaZ2Tj5IbNCnFua5KEAaAGPpZL6+FzfhVJ9DU=;
        b=cppk+mUylJYCtCcjAdZD6my1QeB78RbGeqdSursZUtBQwAgnkzDQSyNxHh9jUrfO1/
         VcGN3c6MOgC0vv8hXaLxWUtzzLnU5txIxFDqJx0Az/dSn2JE+mF+8BWUn6Dm6NRcmGye
         uH9sM6+tReaXvghSDyxsnzzDW2JBNBjI130ZfjLy+Sq63vdWjZBf8U7lYXLu5ul38FRZ
         lnhqmAONa0USuN0S8HcQoJ4uy71e64Gp8pka1ow38wc/uon7Cy1o2bsDiK+56FiVhU2H
         guvG0T3lpuOqjHOOgfEUaAtnGTkrP9QRxQv58sqgQ3ikJD3W7TSs/0pyGLVsA5PMN273
         hhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPwL7aoaZ2Tj5IbNCnFua5KEAaAGPpZL6+FzfhVJ9DU=;
        b=e1i2Tfaaeg8dPkVISupOY1LIzjGkDxWOuKUZjjf1Jtxy+oBgX92naU7wgR+MtntLfD
         UhQJQKd1SLx/G9NCfTVNxEKV/dsYboe1VTbo5q+LxrfypOuBuk5UZ1iHXTEtQKCJTcLa
         4fooybgFd9J23t7GcmaVwofh+FuhJzcRfO14S0V1iCDJ3EWpFizlPJuWuEYUMCrwSBgO
         /87vJqY5FIepgWMtCUvMjReTP8r5dMqX9q9fhXUUokEkHqlUrdb4vaZ0XYmZ7XeeGEn7
         XQZQoJBvinK7BisDrcX52E2INMGrkD8KpP9IAF11VjrtzMp+HWizRjaoUCjCFXuRNNRQ
         eQ5g==
X-Gm-Message-State: AOAM5332dLSmgJvickJQLejaV7mH/V51USBHBQE6x3eiwEZl2bnXsRbq
        9AxkjiFffraWzqINiCMlDfIw81zY+lZkxg551nLE8Q==
X-Google-Smtp-Source: ABdhPJz+yFRgMHBw2zE3OHuucGEP8amS/hvIwE6uRi+tci2ORv8kQIih2dHhwvp5wJLJbquzoJV0llSzHo0T9RhKEsk=
X-Received: by 2002:a81:b50d:0:b0:2e5:b653:7e97 with SMTP id
 t13-20020a81b50d000000b002e5b6537e97mr19457673ywh.140.1650407602056; Tue, 19
 Apr 2022 15:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220319204628.1759635-1-michael@walle.cc> <20220319204628.1759635-7-michael@walle.cc>
 <CACRpkdbrw7Hjt9mB9pr_iNsGi71g_d8BGhpT_ih1RVgKJ5U0qQ@mail.gmail.com>
 <e02e22920ffe23b49237c0c1379e888b@walle.cc> <de9b0114-23b5-04b4-86b3-0d393441a267@kernel.org>
 <735863d6476605e4ff72032d8971ac0d@walle.cc>
In-Reply-To: <735863d6476605e4ff72032d8971ac0d@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 00:33:10 +0200
Message-ID: <CACRpkdbxmN+SWt95aGHjA2ZGnN61aWaA7c5S4PaG+WePAj=htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: pinctrl: convert ocelot-pinctrl to
 YAML format
To:     Michael Walle <michael@walle.cc>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
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

On Mon, Apr 18, 2022 at 2:04 PM Michael Walle <michael@walle.cc> wrote:
> Am 2022-04-18 13:13, schrieb Krzysztof Kozlowski:

> > I think you got all necessary acks for this pinctrl bindings change and
> > the dependency ("add reset property"), so both can go via Linus' tree.
> > That's preferred.
> >
> > DTS patches goes through your SoC maintainer tree.
>
> Ah, ok, I wasn't aware of that. Then yes, please go ahead and
> pick this and the first patch of [1] up, Linus.

I picked up this patch but:

> [1]
> https://lore.kernel.org/linux-gpio/20220313154640.63813-1-michael@walle.cc/

These patches don't apply to my tree. Please rebase on
the pinctrl "devel" branch and resend!
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Yours,
Linus Walleij
