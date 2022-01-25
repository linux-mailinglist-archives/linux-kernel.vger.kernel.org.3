Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257AB49AD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445253AbiAYH1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444563AbiAYHWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:22:46 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831D3C06E039;
        Mon, 24 Jan 2022 22:27:47 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id b16so35536049uaq.4;
        Mon, 24 Jan 2022 22:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7OWhLsmJS1+uUOEexpDwoIKITm+x9XBIi30vSgK1xg=;
        b=hkWuAz/YuA6uirgqIr8pVE292nRVrNT1FRntEAbq6BSmuV1RjGikjVpCJ91lvOiWTI
         wsSfkTZlPqf02zgXbqLu59iYosJKmRfHg9UN4n4eofqmvQSx24qipIN2arr5JrhMgs2o
         UbVYyHuG3MrfZG3BR/VubSt4JsNDJWK1I5Q3IIaK9xATYai+n5SM0iOngkYc89ZUEinE
         ZCW8ujZ79F1WoVYy5wmQzUPcE54FTEkgU98Ngt+xWYhUmXJTsD6h2aQo5YR5fGPI3i9K
         dFfww1Uqm4jRM60BxU3/W42mUddMTt8OoHrM3+yYOWgNkrld2w4uraPYqsW3pkYsj1a2
         4skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7OWhLsmJS1+uUOEexpDwoIKITm+x9XBIi30vSgK1xg=;
        b=RPPkLZ43GCj5+OEhz+JlbqRVrKlui86EiARCri8cXjAspUj5HS5aGvSIJnIwVnnRJK
         M18yXyyWxs/tTiOBaRJB/Jw30ghuxhQEwtrtbqH1SV+ZSqXe5uMrAQetL76onlwPIpZ9
         oQ2C0QHqIS+3A8GeS4zmOVNZ7TlqP9wJ0vM7NmwGYvDebEZtOt36WeWMnED7LrAOpKks
         WupxLLHpw6RAEBD8eAtHvENyz+Q4sHKywvQbmWDPOX/KAFVUX64Wubm+6nNaxEpb9HJm
         BuVejrmTpgxupVuTNKeaYLpdm9CQwpRc4KdezQsHKxKyKIQjjwIk7H/HE867n1hLw1R+
         DwSQ==
X-Gm-Message-State: AOAM532AWL+2ue3rGgkizmkaqkbA9oMcHAJ5x5/1U5VUiZhOdrDBogYi
        ZCfbTrI8psC9kujGPZpkO9xJGEfGokZIDsfOAvaCutwQwyU=
X-Google-Smtp-Source: ABdhPJx+rYdRl8Z7+AGuvxfELBIQDGePT2oG2nEhInJMqyAa5hjsASHccpDLr9LNE0L1Vk3U7tCnise0rK2hMuuJdiI=
X-Received: by 2002:ab0:3caa:: with SMTP id a42mr296234uax.46.1643092066597;
 Mon, 24 Jan 2022 22:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20220110114930.1406665-1-sergio.paracuellos@gmail.com>
 <20220110114930.1406665-4-sergio.paracuellos@gmail.com> <20220125011429.93D9FC340E4@smtp.kernel.org>
In-Reply-To: <20220125011429.93D9FC340E4@smtp.kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 25 Jan 2022 07:27:35 +0100
Message-ID: <CAMhs-H9e4Ww2GNk4JqfkuRketb3ZR54UbrqaOx4qH+EJQiNakQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] clk: ralink: make system controller node a reset provider
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 2:14 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Sergio Paracuellos (2022-01-10 03:49:29)
> > MT7621 system controller node is already providing the clocks for the whole
> > system but must also serve as a reset provider. Hence, add reset controller
> > related code to the clock driver itself. To get resets properly ready for
> > the rest of the world we need to move platform driver initialization process
> > to 'arch_initcall'.
> >
> > CC: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/clk/ralink/clk-mt7621.c | 92 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/ralink/clk-mt7621.c b/drivers/clk/ralink/clk-mt7621.c
> > index a2c045390f00..99256659dd96 100644
> > --- a/drivers/clk/ralink/clk-mt7621.c
> > +++ b/drivers/clk/ralink/clk-mt7621.c
> > @@ -11,14 +11,17 @@
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> > +#include <linux/reset-controller.h>
> >  #include <linux/slab.h>
> >  #include <dt-bindings/clock/mt7621-clk.h>
> > +#include <dt-bindings/reset/mt7621-reset.h>
>
> I can't take this patch without taking the first patch. I suppose if
> Greg is OK I can take the staging patch #4 through clk tree too? Let me
> know.

Greg, can you Ack patch 4 of the series to get all applied through CLK tree?

Thanks!

Best regards,
    Sergio Paracuellos
