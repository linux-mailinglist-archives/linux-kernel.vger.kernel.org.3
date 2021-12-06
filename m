Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E622246AA23
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhLFVXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351197AbhLFVXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:23:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F15C061746;
        Mon,  6 Dec 2021 13:19:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so48444645edd.0;
        Mon, 06 Dec 2021 13:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npVIllIrzbanEnSWMWYv86vweK4sS4wEJk4Mwyduuyo=;
        b=Pn4keIE7pu0NvrTG9cm2WG8BpLD9VfYMriDuW+LBng1Fo/8YfSzQtIfgbKV+yP6DP+
         0pGx9agAGyWkdecELWKTMsuI2HKt/C3nOQdL9nfUmMgjTuiXaSfjKEyVx9es4lPdq3qh
         QvYEckGJzBjJDfH74z3nQSmZwNkRsCCfoqrzoSDeF57OCWZfjTjhDCxbBH3gtLH7+CR4
         vWckSMzRbY10P9wEyXEY46OpX4n+2jZUYwKTpWfiCyuLLgvMCb689QCJ/e/sqhdpWGra
         oTvK13K0/WfUl4zUIkhquYp96GKzwsHevBs/YUMiOph2CbbbuHoMp128iWwDOpU1MIbE
         NLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npVIllIrzbanEnSWMWYv86vweK4sS4wEJk4Mwyduuyo=;
        b=dEo7p7tEa7PDaSlNFxFj+1MyeWYOErVDWnxSPznDcObCrbu2w11r2tzIx0YlRJYX6e
         3vb4n2vd03EX2PY6wJwgj9c/rHdtVZHOS0QHosaeKSTtEcpWJXT8owUmeniPUKRzZow1
         P6HyvQSPEaLDjpeKbUDKXJhwtvBCycAWqkzFvpyH9Xq00maVTK0AIMefgXVTMp/8CGEd
         158a+8FamagBJXh7MrTm93O+T5hn3VEnsCBfezrlDFMklIxeCmS2fk+7cxz7VbwwSMzi
         imp1bTWeoiL2Q9agloVow+V3s3KRpYiXDb5ryHql72SQVfL3hZlJUIpJlounMPIBAfmB
         D7WQ==
X-Gm-Message-State: AOAM533Jyhd0D18NisoTPr5Qn4w+vNcPQeM00LkIgfh1P9zOwD2aczTh
        d5+m97mytB3lK64OcbV2i9X2hLbzUE7q2sG8E/U=
X-Google-Smtp-Source: ABdhPJzg5usv5f0RaSqWg9mf7QzcFnAMff1LKR1fQBgsK2p4lTLH5w1ZlTVKL6A8Jz5Sj2CrhyAHKuW6LzqUDQ6MGIA=
X-Received: by 2002:a17:906:229b:: with SMTP id p27mr48499254eja.264.1638825594626;
 Mon, 06 Dec 2021 13:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20211205215846.153703-1-aouledameur@baylibre.com> <20211205215846.153703-2-aouledameur@baylibre.com>
In-Reply-To: <20211205215846.153703-2-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Dec 2021 22:19:43 +0100
Message-ID: <CAFBinCDZ2nTg2V_6qxok_y+wXHTVJ6XyyvON59TLJZ9B3fKY3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared reset
 controller use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        p.zabel@pengutronix.de
Cc:     khilman@baylibre.com, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

On Sun, Dec 5, 2021 at 10:59 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Use reset_control_rearm() call if an error occurs in case
> phy_meson_gxl_usb2_init() fails after reset() has been called ; or in case
> phy_meson_gxl_usb2_exit() is called i.e the resource is no longer used
> and the reset line may be triggered again by other devices.
>
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework. Therefore, use of reset_control_reset() on shared reset line
> should be balanced with reset_control_rearm().
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> changes since v3:
> - Remove unnecessary reset_control_rearm() after reset_control_reset()
> failure.
I double-checked your patch in v3 and Philipp was right:
reset_control_rearm() should not be right after reset_control_reset().
However, I think reset_control_rearm() is still needed
phy_meson_gxl_usb2_init() whenever clk_prepare_enable() fails.

So my suggestion is to add reset_control_rearm() in
phy_meson_gxl_usb2_init() if clk_prepare_enable() fails so we are
resetting the ref-count for the reset line (just like
phy_meson_gxl_usb2_exit() does).
The difference compared to the previous version is that the
reset_control_rearm() call needs to be placed a few lines down.


Thank you!
Martin
