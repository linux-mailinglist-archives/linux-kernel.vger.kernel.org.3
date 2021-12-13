Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90018472FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbhLMOvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbhLMOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:50:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11B9C061574;
        Mon, 13 Dec 2021 06:50:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B791DB81113;
        Mon, 13 Dec 2021 14:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71299C34606;
        Mon, 13 Dec 2021 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639407054;
        bh=rB04KlTnYTjNvX6bGvzpbKOreiTVBbB8v7GBGdsXRH4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pktXTE5Dw95b9A79kaUwiU6MqWyw8ifotpglfAa9bgn63TFdUcsS+rd+uMS3dLgjG
         2iq43Q7SJpYQerWm5GFeHpscTZ0QobFancv22tl427cf+CVSU1BxvPQTWGPA+CAaMQ
         vV0jw2C4/bSwi2CiE1dJlRaGWaMOwkPLNkGX/w5f4difTaoiBsiLMZ9QFJOxpP1p8w
         vd5a1b1hoG0CtqweBvwim5LL4kAUCz0uO99nQOzFDEVRcrwHzb2+2VT9NPOVxhMekj
         ZUjptU2Kx3WfAUrwQDpHKyRSY/yewsdn3pYmsSs3hXf0MlnlJEamb7Ca8yY4IR8zGM
         Gx19otXO5oQXQ==
Received: by mail-ed1-f49.google.com with SMTP id z5so53574321edd.3;
        Mon, 13 Dec 2021 06:50:54 -0800 (PST)
X-Gm-Message-State: AOAM532rMssiMQIzUxuaUiyQo4qnttrIm5xx78c+lX8t7yZAizVf4FRE
        ssBYbSsYyOQgeBv8MX+KLDEGDrVnq7+44SuUNQ==
X-Google-Smtp-Source: ABdhPJxuMWm3S7JoggtMzbpLVFQySOBI3xqLHwXO9iPRtHwEd/Xvusq53GXxW9i8hDwfKj8uU5iKsme2fJ01l2MfwJg=
X-Received: by 2002:a17:907:75f0:: with SMTP id jz16mr45909802ejc.77.1639407048498;
 Mon, 13 Dec 2021 06:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20211212062407.138309-1-marcan@marcan.st> <20211212062407.138309-2-marcan@marcan.st>
 <CAL_Jsq+0=3V7noGbK2-h+yXeCPZ4QMXVroWvTTL5u7i22ibc6w@mail.gmail.com> <251204bb-18f6-36cb-377a-557135633318@suse.de>
In-Reply-To: <251204bb-18f6-36cb-377a-557135633318@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Dec 2021 08:50:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLpRgtZyzw4zT=vvcepd=0piJeSJUob=dLWujpO4m7O4g@mail.gmail.com>
Message-ID: <CAL_JsqLpRgtZyzw4zT=vvcepd=0piJeSJUob=dLWujpO4m7O4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] of: Move simple-framebuffer device handling from
 simplefb to of
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 2:16 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 12.12.21 um 22:29 schrieb Rob Herring:
> > On Sun, Dec 12, 2021 at 12:24 AM Hector Martin <marcan@marcan.st> wrote:
> >>
> >> This code is required for both simplefb and simpledrm, so let's move it
> >> into the OF core instead of having it as an ad-hoc initcall in the
> >> drivers.
> >>
> >> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Signed-off-by: Hector Martin <marcan@marcan.st>
> >> ---
> >>   drivers/of/platform.c          |  4 ++++
> >>   drivers/video/fbdev/simplefb.c | 21 +--------------------
> >>   2 files changed, 5 insertions(+), 20 deletions(-)
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >
>
> Can I merge this patch through DRM trees?

Yes.

Rob
