Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9F94857C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242633AbiAER4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242677AbiAER4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:56:32 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DFC06118A;
        Wed,  5 Jan 2022 09:55:59 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id d1so131999ybh.6;
        Wed, 05 Jan 2022 09:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ixWsWTEdona6bvKg11lphGXvz/Decueq8W21LGFdhs=;
        b=KKM3BAmFM+tHN4vn5vqP1PLVKsTD9IlGClPJN9mbEkF+ta1gUVKNfBWxIs9x3lhrD8
         h+tVZUX2aBYOo5IIpVAJ8rApUelOZFBzxnOWyAGjMoR9141xQZoXrMWWLF6i4Zx+Ojvt
         xn8MqaeAeBMjxZqUVex45JZCqtjeonHljcs7hCmL5qU2/9ERkCBW50/zCZH8UfSL843g
         SzLBiR3EgOShy4wVU7D6lOWfUyRfC7+WoyJcIIs43LxMWbzQ/NZJhljaJiOUVXqRHmZa
         XJYDMuiDoVd19QrYk6hs2bfi1H10dvsZgfKYZJJuLGi20NiFxFrBY/KN795xGkxYD2Es
         lSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ixWsWTEdona6bvKg11lphGXvz/Decueq8W21LGFdhs=;
        b=H/RJAZbLfx7tlXNWiAgxz98QwdUmLKXLAe0du/64zoH/LiRvYGfweH2WD2IDbs3ELG
         NZWUcFyT4TQQ9BFD00ZOoh6dsZ+eveWBX0qVW0eYe7/lZDrHfeUTC2x/8W8KU4Zd3Pf6
         50NpcRA8Qx9FvkOyLvNv/b0aYLImhuP/MCYaCgXd/Mz3R0vGVUlzeZfl1EkMDPpsq7SC
         NR94ZXwHHOXSVySITLCWRm2H7qU1T0wMMgCxcvl4l+qjMdQHCz1MuybNpuzY/mH49jkF
         lZp6P1it3FVuqD0TtfreOe819lzcKzjk6U3URI44jFyRtfAxV7t5WTo84EXkR9/nCWVy
         UBow==
X-Gm-Message-State: AOAM533G+87l3v23BRAGr0X6CPCBOkq94DXVdWBDeuCNeD90CkTqDPXp
        a1DQMbo4YR4XP0YC3io0s7Lw+gKOtaaXCbn6DztQK8Ttsrs=
X-Google-Smtp-Source: ABdhPJwwVk3W31NyU77htA6VxNyyefySsdT7yUay9eB3zD3W26ECURL+gGQz2slV1QAVMysFLHMJwqkFOG2XcChy4l0=
X-Received: by 2002:a25:98c4:: with SMTP id m4mr70112189ybo.613.1641405358698;
 Wed, 05 Jan 2022 09:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20220104164504.24707-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75Ve+0VmfU7GhC=AjZ3J1J6KtGko2YAenA9mXCSCVrcuX5w@mail.gmail.com>
In-Reply-To: <CAHp75Ve+0VmfU7GhC=AjZ3J1J6KtGko2YAenA9mXCSCVrcuX5w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 5 Jan 2022 17:55:32 +0000
Message-ID: <CA+V-a8uvuuk_t43COPVnaf2cFOhMxuPkK1Bj5OO9DtygTpy1ag@mail.gmail.com>
Subject: Re: [PATCH v5] soc: ti: smartreflex: Use platform_get_irq_optional()
 to get the interrupt
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the review.

On Wed, Jan 5, 2022 at 9:47 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jan 4, 2022 at 6:45 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq_optional().
> >
> > While at it return 0 instead of returning ret in the probe success path.
>
> ...
>
> > +       ret = platform_get_irq_optional(pdev, 0);
> > +       if (ret < 0 && ret != -ENXIO)
> > +               return dev_err_probe(&pdev->dev, ret, "%s: failed to get IRQ resource\n", __func__);
>
> Sorry, I haven't noticed that you are using __func__ in the message.
> Please don't. It shows either that the message is not unique (so make
> the message unique enough in this driver) or the redundancy of the
> __func__ (it doesn't add any value, but noise).
>
Thanks for the pointer, I was just keeping the messages in-sync with the driver.

Cheers,
Prabhakar
