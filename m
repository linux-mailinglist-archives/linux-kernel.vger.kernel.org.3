Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC0E47A39B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 03:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhLTCUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 21:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhLTCUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 21:20:09 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA7CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 18:20:08 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id r18-20020a4a7252000000b002c5f52d1834so2674057ooe.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 18:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9OlAzuehaJkEmXyc0qc+RfNaOK0y6SRe2OzA7I9NCpQ=;
        b=xFUWj5pZPYKunbfcPHm0EAPz3/uwkp4JMV+DUiATXgdEBau8LWzGzgSMAqaAz54cok
         KF0VdCnxUv9P+8pkx+UHo0LWu+DFBAI1QaULxpOsOJqSKieiivk3wpDGDZz8sNF0Tybw
         18SXJ4sJ+ruASixNeoCcPy103ENz2c6IucfUPyLQtE2v9VoPd8UZ31sjA9qYG0M2UFAx
         qWUKf9rc2CrFXAKJZ4cibqs6cfogDTQyqMnG46tRL+WCkRQcI8n6vBqMVej0HvWT4YJp
         6ZOrX5MVHE2dbmn34R06GenJ29aqBh84pOSWNdLiT6vGPc59Gtj8BK6BZbo6cGjAh67B
         544w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9OlAzuehaJkEmXyc0qc+RfNaOK0y6SRe2OzA7I9NCpQ=;
        b=V+1KtI8KCjzpV28aOLW1Sy40jqq5kaHnCT7swKeGNDk1uM/ikxLJBLmn1L4y+wEOkz
         +FUrQ/7DOSYQ2H8t4ZkUi+PlRTyKP3a3Tc05KmnvlUwK/RobSsycXSNz4D4TPkMh0pex
         oBibGO1aJHpE54a0/HDq+Q/1dSRTwmOOLoDmy7XAsvL85kEhfqFZjV1P4CL30cfuxs1C
         BFt/0RlducJBrAnJ5S5Vjq37IwvGim7vO6Nbi50tpvylImo2gJeonqv2FXdvQu2E2l35
         PrI+FP1bQ3Y+P6WfCuw3s4/s+LER2C2+fpNP949l4lNTQirZIjnMA+Hy9TOjmYxSKfHQ
         vW/A==
X-Gm-Message-State: AOAM530uVncH9A7BJLVSdFvF6vdvbNu9wEo8U6j0AcwACWt6Xwby4mRW
        VjR6HDE7BJKUhGY7OF95mzhU222vWyked9KdT56lNw==
X-Google-Smtp-Source: ABdhPJz46gDzq9fEZIApuV9z9olhe0Na55+ylzmGSsNUqesQhV0g0vvgjob+bHStpoUZ/WdOi1gpvzKAm7MhvrS6gWQ=
X-Received: by 2002:a4a:8515:: with SMTP id k21mr8803903ooh.71.1639966804416;
 Sun, 19 Dec 2021 18:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20211220011524.17206-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211220011524.17206-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Dec 2021 03:19:52 +0100
Message-ID: <CACRpkdbdr+MNp1iK7-snmr7iQ9cTey4iCjnoGGkQrqVwKdTy6w@mail.gmail.com>
Subject: Re: [PATCH] rtc: ftrtc010: Use platform_get_irq() to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 2:15 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
