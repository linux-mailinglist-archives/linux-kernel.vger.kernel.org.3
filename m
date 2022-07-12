Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F56D5715E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiGLJis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGLJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:38:05 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D543666ACE;
        Tue, 12 Jul 2022 02:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657618653; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=XOK5i+BNpDgcX1BYMZe2LaCKoK0yyKdgVeb0O1DjcKKiddv3nOBUXD6X8d2jH/haPjYm+zOFbgFTa8gSlybnnE3jsvf7w4zMNGPwMJ9EUB45DEnfa4y5NNQalHlhbNacI5/9hbZ2T2nyzZcB4vaP+iPNZb3ZUvjmeEhkWhKd92c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657618653; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+8NaXtyVZremBRcm+Cxpd7Fd0peEWVZxSFKa1EJngXk=; 
        b=mHbW9OMt/4UEU28Cd4c9GOK9Asqyy1CyAcuJW42NCvKXWSTLXwdZejIGSHhBDImLNwheR10dC55pq69xeRVhrUwZ6vxNPbWoD8mJGatqDFVf4zwqSj6RjX40RD1ft56FTQdfR7+ZW76ltuqUEEI3Qp2mUc4iNcSkv3+U720/Pso=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657618653;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=+8NaXtyVZremBRcm+Cxpd7Fd0peEWVZxSFKa1EJngXk=;
        b=H5IGUqO4IVFVuUCjLMknbc3MO6YG+adVYmsFVqcDTH0JMmZ7OyXW14ekFNhJLhVh
        BMUA0g+QzWyPoCJQ2KtjdBA8YOLwZDgiQBZEM8MPJzYMlz7qr7ahAElKSdq11iCOMp3
        2dmkFOe7wvRbLO9DCYXlP0Cr+Nmr4fybEsATpjmw=
Received: from edelgard.icenowy.me (59.41.160.3 [59.41.160.3]) by mx.zohomail.com
        with SMTPS id 1657618651670659.3452916221531; Tue, 12 Jul 2022 02:37:31 -0700 (PDT)
Message-ID: <7a947683de71e68a0925cfd4cab80238c3a03205.camel@icenowy.me>
Subject: Re: [PATCH v2 2/3] pinctrl: sunxi: add support for R329 CPUX pin
 controller
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 12 Jul 2022 17:37:14 +0800
In-Reply-To: <CAHp75Vdso_PGUomjmKaF1ytdUe4qLeAbpwkNmcRng9aNHs7g8w@mail.gmail.com>
References: <20220710081853.1699028-1-uwu@icenowy.me>
         <20220710081853.1699028-3-uwu@icenowy.me>
         <CAHp75Vdso_PGUomjmKaF1ytdUe4qLeAbpwkNmcRng9aNHs7g8w@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-07-10=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 21:06 +0200=EF=BC=
=8CAndy Shevchenko=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, Jul 10, 2022 at 10:22 AM Icenowy Zheng <uwu@icenowy.me>
> wrote:
> >=20
> > Allwinner R329 SoC has two pin controllers similar to ones on
> > previous
> > SoCs, one in CPUX power domain and another in CPUS.
> >=20
> > This patch adds support for the CPUX domain pin controller.
>=20
> ...
>=20
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
>=20
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
>=20
> No use of these.
>=20
> > +#include <linux/pinctrl/pinctrl.h>
>=20
> Missed headers:
> mod_devicetable.h

Thanks for these.

In addition, how to decide what header should be included? The code
works properly because of_device.h includes mod_devicetable.h.

>=20
> > +#include "pinctrl-sunxi.h"
>=20


