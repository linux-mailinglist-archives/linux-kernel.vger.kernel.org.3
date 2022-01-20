Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A78E49543C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347200AbiATSdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiATSdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:33:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DCAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:33:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a18so32471117edj.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKUPvYgb/xwsTq6T7e89Z6kjzAJSxkrEuwSzEueenMc=;
        b=g0plarazHPwI4qlq/iLNZg6VCNmjr7t39qqS/R7UXrPsoagw0roK4Oxy1FcqigzWVD
         5qzEWL3uPnCjplkdgeow3xuV+Wl+XkoCQT8Bzf0+deLaZeo5j/ueuLPszaRkRnEzFPyd
         L7MEhwee3mTd1zxtK1EYURmQ5DVeqXVW89Vbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKUPvYgb/xwsTq6T7e89Z6kjzAJSxkrEuwSzEueenMc=;
        b=6breSL3AS8L8EUF7zusAP1XTyZBUAA+VIzkftkbNijMNmTYo7dFkZzKHeNo+CYVZWh
         jVohZRaqQCqH95ykvWEEHciCbrSelSsOUkz/mLfizFDTxBDm/k9nCGw+zWmrWQJdEsS9
         sCYezoHJbKTkqrDe5wzVVM15uQWk6uh9/WQfcGnkcyPM40UAAQOjB9TOo9deHh3xAxMr
         bmGazuTxE1B7L2KS++zzf20L5bPQrdFVieyoh6Yz1nWVowr6obsguCbqvKAnCYhmxKEe
         UMTgaCab022vAx4w3BmaF0NMyLLvq498t0Q8Khg/RgkSZPzFLh/8z+x9SURKm93kJ5wP
         3IZQ==
X-Gm-Message-State: AOAM532SjUgC2f/7TaMU5PgTHVpiCHW3brfn4oUFWRWAStABCLANCfSx
        vBcGUgHc4Lns2vYFuvHqsSvjpXEcJlKl4D6mIPlU4w==
X-Google-Smtp-Source: ABdhPJwt+XAMRl17Scsp8wwhWEmsO7vFjwY7BNMmq+eFOWefHMWaw75EXBzrtVVz8ykqngqnRTHQUYrvu2B/OHbFdOU=
X-Received: by 2002:a17:907:3e23:: with SMTP id hp35mr157023ejc.760.1642703602005;
 Thu, 20 Jan 2022 10:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20220120083357.1541262-1-narmstrong@baylibre.com> <20220120083357.1541262-7-narmstrong@baylibre.com>
In-Reply-To: <20220120083357.1541262-7-narmstrong@baylibre.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 21 Jan 2022 00:03:10 +0530
Message-ID: <CAMty3ZBdzW++6mCaqCLuL0QWwY7ve1vmLSPhaS8QqYji_jDXSg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/meson: add support for MIPI-DSI transceiver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org,
        martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 2:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic G12A/G12B/SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
> Glue on other Amlogic SoCs.
>
> This adds support for the Glue managing the transceiver, mimicing the init flow provided
> by Amlogic to setup the ENCL encoder, the glue, the transceiver, the digital D-PHY and the
> Analog PHY in the proper way.
>
> An optional "MEAS" clock can be enabled to measure the delay between each vsync feeding the
> DW-MIPI-DSI transceiver.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
