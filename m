Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308FC4766C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhLOXwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLOXws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:52:48 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D028C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:52:48 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id x32so59671252ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 15:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KweSx4vEToJo38w+0X+XyYiTHycESdLG197MQj3znUY=;
        b=p/H9WTYGoH4RA6GKtDjZEacYmd65ZxyK6PQRgaR/m9eg4/aol8x8W3xzriRENrM//p
         61ivYop9wOvJv3S9pBuES2S+ug/VfYtuXK/EkqrJsKuT09l8PKqvg2arFxOQNL2zDj3h
         PopTjl5hnXjK9drpLm7mZYwjPZwpDBlAIwUUXZ3S+fYKo1ZcvrYtLyM2OekajbmRG7w7
         QoB/N4HqGSaiSFFUbcSOlbNTwqVx11paoiGUQ6Rd9nZhT6GH4B7eBB8/bIeGVL5GAaJU
         bIY1vhMgjxeMmTny0QrHup8DXUx4RYqOlX3EVjSic2qbvMRB/xg4idmp35STmjjgA4CP
         Kwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KweSx4vEToJo38w+0X+XyYiTHycESdLG197MQj3znUY=;
        b=8MB76hJcQI3RT4lpU6zSEm/CTSiWcTdyzTkWmJxcqpc0VSEGE7oFY8Xc1E1Du00+MT
         K1K/m1VULjef96CAheYVAP7mBiy6eWGSCuNFq7mJl6fJiP91K6zeAbgUb5/+z7YpEvZU
         Bn7LV/8jVKw6xBy5nTZOZQqAyL+3rD21aZLD6ELDGNkfikJ9hRxK+w6QGeBYUod/mrXx
         5AKOPnb66970Gbf/HK3lwCrabZTOOiVIgJUp2zZ4jhv+vR8S7+H+Hkf50qFF+Ro7JTKV
         QJG7kNVA8jJfXEe5cutKdEs6K2MVGaro2NdSLlJR0GEMUW/RxTuy9JX9ozZKZzapj/d0
         WNhw==
X-Gm-Message-State: AOAM532cqeENUGfZQt64FP+c8hjWDZHcCQ9gueoSUbkRfKxurAGehDF1
        +HRCp1OYldlg/0fNXj7FmPZ+xBZyVztJbDCDtbT9icyFLBY=
X-Google-Smtp-Source: ABdhPJwmELBb+qECdrTPwEwqCp63tTuTaBE8smGp17R2dUN8Jz9CwrBI3ug4PJUwLycHafN7OfUUsCXgH5rnUrSg8h8=
X-Received: by 2002:a25:ad01:: with SMTP id y1mr10326063ybi.696.1639612367496;
 Wed, 15 Dec 2021 15:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20211215213300.4778-1-linux@fw-web.de> <20211215213300.4778-2-linux@fw-web.de>
 <1933509.XRPO5POFnR@archbook>
In-Reply-To: <1933509.XRPO5POFnR@archbook>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 15 Dec 2021 18:52:36 -0500
Message-ID: <CAMdYzYrpYoGY0HvSUgsgOBkhfwrqt0UfQtt1MQ7tZGbzY6pUnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: rk808: add reboot support to rk808 pmic
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Wunderlich <linux@fw-web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 6:07 PM Nicolas Frattaroli
<frattaroli.nicolas@gmail.com> wrote:
>
> On Mittwoch, 15. Dezember 2021 22:32:59 CET Frank Wunderlich wrote:
> > From: Peter Geis <pgwipeout@gmail.com>
> >
> > This adds reboot support to the rk808 pmic. This only enables if the
> > rockchip,system-power-controller flag is set.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  drivers/mfd/rk808.c       | 48 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/rk808.h |  2 ++
> >  2 files changed, 50 insertions(+)
> >
>
> Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>
> Tested with a RK817, using a Quartz64 Model A with the patch applied
> on top of v5.16-rc5. Poweroff works, reboot works.
>
>

As a note, this has come up due to rk356x having unreliable psci reboot.
Until we have mainline atf sources so we can fix the problem this is
the only way to reliably reset these devices.
