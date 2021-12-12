Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120FD471EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 00:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhLLX7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 18:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhLLX7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:59:30 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE79C06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 15:59:30 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso3798653ood.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 15:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nCJQZ4NdoPnJRrp+7v/Zp7eju3OzQc0nFNi60lhO5c=;
        b=cL7SRyzhmk8iIkOs+czrmLXPxz/aKd9A7Z3+BlSHdyHG99IebbqlJ5/KIxVyOJ4XeD
         0hOMcWOj/1+DE1BU4AzSEnIVdSgxF5rXEFNAn7yaf2X0mDJUrxEW0OisiBXmv49r1IkJ
         yhQLkcTymGKi9cTuPeu8yc/9LnBhvSC8jKcQxKIaPxzZoBDC0CeYS3W1aJv6/B9tX240
         iYhstsyJ2m0Hme857VLQTEpkdLex3FdudgL23bVivUvhHYECBdE3zVb+jlnCWYjHzddn
         wZs+LGJP0XCzznZrHwhcnl7hiNNazrdYrX/kK3mqDDvGayoJCBIHbCGqCRhg++Lm8yky
         qznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nCJQZ4NdoPnJRrp+7v/Zp7eju3OzQc0nFNi60lhO5c=;
        b=g2BZUcIq3+9wDNawMpkQCFBBj4hmlHuFK5t9oy7b7fioR/cawz+laxegjsnXd16vQS
         OUDnVw7cchj8YSQbyRV/kv/hYNMJFQeF9ckJ+Xb5Sd+JVgW5KLzV631kHiTPhMNfdRxq
         Xyp1Cmrb3nHy0VXB87BY1qdvx6iu3DDclpWBV1UIpbTfrJu7KsyGsKYfwwsEsCKhDbUu
         oVpdvX9inHficc4UuHzLh7jLYcfMTg6kn7bEOtpbJHszGReLlqOmZSKfq5+G9bnPRiAt
         2ZEb2tVqWyIB3lFXv1/eIEW2CIlht0qWOttpJtv2CN0iyEEQywpCMmST6wd8oiTF735K
         /vyA==
X-Gm-Message-State: AOAM531TR2Ez65cVgarlUhdk3DgaH3XWePQ2be0MmaIT+09q4R6v2mHU
        xOK1e8C41aGeX1rsqc41L8uw2SnMlERXIYedXRaezhMi6Eg=
X-Google-Smtp-Source: ABdhPJwYWqluWVTTnBrGK9rIXlAPt3HKcHPBjAM7BNrQO/myWssBRRNiaRxHJajk4CqKxUagt8pdNsLLjnUfXEMD1bU=
X-Received: by 2002:a4a:aa8f:: with SMTP id d15mr17503855oon.86.1639353570052;
 Sun, 12 Dec 2021 15:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20211212224007.10293-1-merlijn@wizzup.org> <20211212224007.10293-3-merlijn@wizzup.org>
In-Reply-To: <20211212224007.10293-3-merlijn@wizzup.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Dec 2021 00:59:18 +0100
Message-ID: <CACRpkdaW6UeEo7SWac9ibWKSb6w_2KDcoJGGi5qztyPjD1y2xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] leds: lp55xx: initialise output direction from dts
To:     Merlijn Wajer <merlijn@wizzup.org>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Doug Zobel <dougdev334@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 11:34 PM Merlijn Wajer <merlijn@wizzup.org> wrote:

> Commit a5d3d1adc95f ("leds: lp55xx: Initialize enable GPIO direction to
> output") attempts to fix this, but the fix did not work since at least
> for the Nokia N900 the value needs to be set to HIGH, per the device
> tree. So rather than hardcoding the value to a potentially invalid value
> for some devices, let's set direction in lp55xx_init_device.
>
> Fixes: a5d3d1adc95f ("leds: lp55xx: Initialize enable GPIO direction to output")
> Fixes: 92a81562e695 ("leds: lp55xx: Add multicolor framework support to lp55xx")
> Fixes: ac219bf3c9bd ("leds: lp55xx: Convert to use GPIO descriptors")
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing my mistakes!

Yours,
Linus Walleij
