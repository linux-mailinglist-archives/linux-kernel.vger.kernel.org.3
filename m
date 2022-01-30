Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89604A32C4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353534AbiA3ARs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbiA3ARp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:17:45 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCD8C061714;
        Sat, 29 Jan 2022 16:17:44 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id p63so11472666iod.11;
        Sat, 29 Jan 2022 16:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rANV6nEu2e4bxIniTc4cVrydOQZuaQWRhvzW9XFD3+A=;
        b=a73qC0JlDQTpWjpvXPlCOcZg7ltvcmoMlMsnPiXEOmWh9FbypkAJLwph+Rx6QFoskH
         ervZZFAHAYYtbOYzQKbm21NTzuU0dE0BKAZmADO0ZSb4GsIGaWfIwbRW59ik88nKHKlK
         yuMqC/+ZNtKFas3SZXQvm/zY/UrswHOb+pbAmgO6h8f+maAb2SwT6eyzeu2fKJmBEwQ5
         Hs1db3dDG8nkncCqL5a18fYSVZfUF6L8R+rCFqb5ac7TcvpUWuDy+hRlT9Rm+vDI0G8T
         FE5eXmho2mORpMuFGxT5ybvwrL+8YsW7DZeydzqy8yYxi0o7GP6f3iL9Iy+L1Ci4nbv/
         v/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rANV6nEu2e4bxIniTc4cVrydOQZuaQWRhvzW9XFD3+A=;
        b=KMhlAQk8+i0ux14poXcSQZvAjhN9tvM9LPpzRd/HPu1as1XqvsFKxdxkXnS5r0s7GJ
         QbBEJEBIbsmjILwTxFhCUFr2FdhQPmSnrFkObLKUCp/eKH7plVmJ2vM4jy2YSFch3Vln
         CacwmT04fUzBnxg2yJusEzBYt0saREodPAGxMK0UkSo3gnlpICOA3lv1ba5WI96UvU4i
         yDBrUnYwEX/uXRr9i41p2Xg++W9bCtIXafpORocoajtiaAVtjBmRbfu0jZ55OfQmFOD5
         HWxnweqxRNglqeAxIwWkJCy58ThitmkYFnC0mcE9wT7Qy054uPKPB6NUgDqPPmzeeZJs
         XEiQ==
X-Gm-Message-State: AOAM5313tmaVPpUmUI9PzR2oFJIjJYMvOC9FRVkstJEK3cUDXszmtWeF
        TyVHQ7zQJhZ+qsDVdYiRTnOyfPC83IoF0MMYmHU=
X-Google-Smtp-Source: ABdhPJwI/rc7H9WwBjrNLup8fE45Vvo6eUPM9DtKYduoCZpu+T4kB4o6Ns/8HOw6vOSBVKbd+aRh3F/WTmlJCApUIM4=
X-Received: by 2002:a05:6602:2d95:: with SMTP id k21mr8723691iow.107.1643501863887;
 Sat, 29 Jan 2022 16:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20220104062547.2103016-1-peng.fan@oss.nxp.com> <DU0PR04MB941793A918C5E08C9A48BCAC88209@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB941793A918C5E08C9A48BCAC88209@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 29 Jan 2022 18:17:33 -0600
Message-ID: <CABb+yY2tFtwFvWGh5OtHYwfvkjv3z51CD3cyemq=4Vd-YnY6aQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] mailbox: imx: misc fix and SECO MU support
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:28 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH 0/7] mailbox: imx: misc fix and SECO MU support
>
> Ping..
>
This adds new features, so it will go in the next release.
Meanwhile you may want to fix the issue in 3/7 reported by lkp test bot.

thanks.




> Thanks,
> Peng.
>
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > This patchset includes a few fixes for low power and i.MX8 SECO MU support
> >
> > Franck LENORMAND (1):
> >   mailbox: imx: add i.MX8 SECO MU support
> >
> > Peng Fan (2):
> >   dt-bindings: mailbox: imx-mu: add i.MX8 SECO MU support
> >   mailbox: imx: introduce rxdb callback
> >
> > Ranjani Vaidyanathan (2):
> >   mailbox: imx: Add support for identifying SCU wakeup source from sysfs
> >   mailbox: imx: enlarge timeout while reading/writing messages to SCFW
> >
> > Robin Gong (2):
> >   mailbox: imx: fix wakeup failure from freeze mode
> >   mailbox: imx: fix crash in resume on i.mx8ulp
> >
> >  .../devicetree/bindings/mailbox/fsl,mu.yaml   |   1 +
> >  drivers/mailbox/imx-mailbox.c                 | 249
> > +++++++++++++++++-
> >  2 files changed, 243 insertions(+), 7 deletions(-)
> >
> > --
> > 2.25.1
>
