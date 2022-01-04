Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0795F48413E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiADL5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiADL5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:57:03 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AC3C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 03:57:02 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s1so31004975pga.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 03:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qz4IOP4tQz6MVqNRs763jv/JpxIVCzSerIqjO9KVko=;
        b=akyWELdrqaMAzl+2u09k1siH03kmBuljuWevsTKn1MKWsv4RxLbC91yNXgeVnihFLy
         BZl9MxSdEKAJb61U47jRSZil0FvHd0Us300+yNsKCroJ0s7xApGir6uFNjmBed8Lrs0W
         nSTHtffY1vSOjK92/eysLhB+fiFm2KITapxdhIscazqv61h7luzo1YtcOE2Xrdmjq6vo
         ZnBIE7IUodgKn/aSLdvM0aZQNCtU9eKq1m9pbzTyDMdviSDcY+bCXwgKsoxbuBs5NpyF
         /fYOrJIatvWrwMi+hdohh2rQ6Sdy94B3O4hEpIl/GJXO6q3cKcEq0bF/dOfHGe5TpayW
         XzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qz4IOP4tQz6MVqNRs763jv/JpxIVCzSerIqjO9KVko=;
        b=Pzm/r9f+DpnoH0/sQuKVaoLl4JWzI8gEw5DJY/3k0A9oZY97Xn2RI05gd9ROsUPYII
         F8P5xsR7ZS54ic19xpWyQr3C6Gt8DMt4huvoJLpWgfDqZfExpUM52BnSCJSZVKOcF7af
         GjXu4xoEimNQJx/IY6snTF9We7dHN3uzFmHnuANX6wTU4nUoaVLFd61vLrvistBC6mwd
         4RcfBevGY3Z2x/+hYehp1bathXNZGnX8gJU0x56aMvrtWErsacPclWZR3qVDAKYszxRK
         5/vB4CPSC+a4CqLWrWcCucR2NckIxuJtLUdgVGf1kTf00YYwY7UQPqmvOafvuvdbhAAp
         q5/A==
X-Gm-Message-State: AOAM533fxBRXes93wwyCJvPw8Jpo7vOx0xaI90gDwL7Lzs21LLUZtLHt
        jkq5hh+KGCRKs8GLV7Hms9D0upEbk8WjqqX+ya7auA==
X-Google-Smtp-Source: ABdhPJzMeT/jerydzvJxQ9/6wchNhHmZXkPXPOHChg26wvS1FiPbEWYjw7SN+cUnWOvaq/P4AkteJjt6VgH0XBpaArQ=
X-Received: by 2002:aa7:8f37:0:b0:4bb:a19:d3aa with SMTP id
 y23-20020aa78f37000000b004bb0a19d3aamr50952958pfr.1.1641297422211; Tue, 04
 Jan 2022 03:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20211218215055.212421-1-antonio.borneo@foss.st.com> <20c77dc1-7e7e-ec0e-f545-593d1cfeb3b3@foss.st.com>
In-Reply-To: <20c77dc1-7e7e-ec0e-f545-593d1cfeb3b3@foss.st.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 12:56:51 +0100
Message-ID: <CAG3jFyu-btTaP+6YFTzPi13jD3RyqAWQq1QJUk3A_dVKjT4T4w@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/stm: dsi: move lane capability detection in probe()
To:     Philippe CORNU <philippe.cornu@foss.st.com>
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 at 11:47, Philippe CORNU <philippe.cornu@foss.st.com> wrote:
>
>
>
> On 12/18/21 10:50 PM, Antonio Borneo wrote:
> > There is no need to re-compute the dsi lane capability because it
> > only depends on dsi hw version.
> > Since dsi hw version is detected at probe(), move there also the
> > assignment of dsi lane capability.
> >
> > Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> > ---
> > To: David Airlie <airlied@linux.ie>
> > To: Daniel Vetter <daniel@ffwll.ch>
> > To: Andrzej Hajda <a.hajda@samsung.com>
> > To: Neil Armstrong <narmstrong@baylibre.com>
> > To: Robert Foss <robert.foss@linaro.org>
> > To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > To: Jonas Karlman <jonas@kwiboo.se>
> > To: Jernej Skrabec <jernej.skrabec@gmail.com>
> > To: Yannick Fertre <yannick.fertre@foss.st.com>
> > To: Philippe Cornu <philippe.cornu@foss.st.com>
> > To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > To: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > To: Philipp Zabel <p.zabel@pengutronix.de>
> > To: dri-devel@lists.freedesktop.org
> > To: linux-stm32@st-md-mailman.stormreply.com
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
>
> Hi Antonio,
> many thanks for your patch.
> Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
> Reviewed-by: Philippe Cornu <philippe.cornu@foss.st.com>
> Philippe :-)

Thanks for the series and the Acks.

Applied series to drm-misc-next
