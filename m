Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E894BEE01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbiBUXWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:22:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiBUXV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:21:59 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75F024BEB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:21:34 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2d310db3812so154787397b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fAz2iY/D/cZqbvbRIbhtRW6KqWkElxsNNM+Upljv8j8=;
        b=LpNdwLY0+XX45OIkTfPgMAkNKf7PUIg0ikiV54uqh5tS+jNAj8v3nUeh6aa+7vaVpR
         DEWShxwETuyGkR+9wL1MGmrmSwLFJ72AVbjUzmyumqlWAlEbyvL8a/+XaGU+i7BAePJz
         GpsvWorIp18VqOZfGMsIvPnx6684zMe+DdUiM9zck6d/l4jTVzh1Epmpt+XM1o4VmYTC
         vm9dHLzhFweDZc69QJoChOdUCYbqec9b23fHpMFh1CvXMIT/b4KYwfyTVvITZJjL1Z2E
         aK22ovU4Gb6jKAk07Qe4KnQo89ZGu/dcsFNA8hMDnBaFmUV9ReLakCQ2MDv3TvDpLAu0
         8AXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fAz2iY/D/cZqbvbRIbhtRW6KqWkElxsNNM+Upljv8j8=;
        b=O3ZS0qQG+MhOYKaOt5GH0JcRGP7p1xj9o9tyfCX8l3L8LXm6tZC0dstNV0deuKKSHK
         zDYHJSKpMpK7hVtnlvGOoItjlqRIVJMzfeSHXcZEni7AAKiK5b965QFUWhSoUBNIU9Kt
         oYPMf5VskvuLA76ZR3EaA4v3rSDR7WlkeLBSwCyAia7Y0Deu4kMn7MCl0AZq0p+t7Cx9
         nbFp6h5wW4nRmaEygEDJfHgILvzaNqL5l+QsmR6tg0qjRlYzJeJLRXRhFkOiorgNoQt4
         Xs3uQAe67PD3x6MGmVvWDq0k2Bz73tAlkQRCdy0C/QZqTPuQ1Rcm60A6j45hbfl20bsx
         wq7g==
X-Gm-Message-State: AOAM5335tUOjdP5J0dbRCI54r8U1h/8Sah+U5CwqDb9wsbfSXK9sT+d4
        AHoRR0B4SZeRvHNN4/8NCV/n+DjP77BI9wRMFTNTdg==
X-Google-Smtp-Source: ABdhPJzsW4ss5B7xVh6geOONvYuQHzSentMXLj552L88FxQEVUaKpHa4mz5QLqDIQin6TSrKuiLq+2RXgGJVxLkhsOs=
X-Received: by 2002:a81:3905:0:b0:2d7:2c5:9a7c with SMTP id
 g5-20020a813905000000b002d702c59a7cmr11126651ywa.140.1645485694181; Mon, 21
 Feb 2022 15:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20220221184631.252308-1-alvin@pqrs.dk> <20220221184631.252308-3-alvin@pqrs.dk>
In-Reply-To: <20220221184631.252308-3-alvin@pqrs.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Feb 2022 00:21:21 +0100
Message-ID: <CACRpkdaFgPfv3ybV8HZh7_WaL3AJ6PkUk8Op1D7O3frvpsxNWQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/2] net: dsa: realtek: rtl8365mb: serialize
 indirect PHY register access
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Michael Rasmussen <MIR@bang-olufsen.dk>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 7:46 PM Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:

> Realtek switches in the rtl8365mb family can access the PHY registers of
> the internal PHYs via the switch registers. This method is called
> indirect access. At a high level, the indirect PHY register access
> method involves reading and writing some special switch registers in a
> particular sequence. This works for both SMI and MDIO connected
> switches.

What I worry about is whether we need to do a similar patch to
rtl8366rb_phy_read() and rtl8366rb_phy_write() in
rtl8366rb.c?

And what about the upcoming rtl8367 driver?

> To fix this problem, one must guard against regmap access while the
> PHY indirect register read is executing. Fix this by using the newly
> introduced "nolock" regmap in all PHY-related functions, and by aquiring
> the regmap mutex at the top level of the PHY register access callbacks.
> Although no issue has been observed with PHY register _writes_, this
> change also serializes the indirect access method there. This is done
> purely as a matter of convenience and for reasons of symmetry.
>
> Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for =
RTL8365MB-VC")
> Link: https://lore.kernel.org/netdev/CAJq09z5FCgG-+jVT7uxh1a-0CiiFsoKoHYs=
AWJtiKwv7LXKofQ@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/871qzwjmtv.fsf@bang-olufsen.dk/
> Reported-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> Reported-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>

This is a beautiful patch. Excellent job.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
