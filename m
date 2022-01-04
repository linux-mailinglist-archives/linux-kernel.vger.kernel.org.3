Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BBE48436C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiADOc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiADOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:32:58 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67466C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:32:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id jw3so31470690pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=YAM3+6FcklAaIzkc+ONdEfhaXNRmLi+403huzZNGN0fOwIdmd61HZQBr1o2txVgKyt
         siyEfxHArU8zWrkmf1/12qERxvfNG/vZ1jl8BXBdz3WEeUMmEJ+G78swMU44XEJhYIE9
         4063gFpjAJ17n/W8rjU6qUD9ZjReqSv4Nf1eju4FOdYhDsZ6+gYEu9I+xAFy9Asil+H4
         fwH9ForA8Y1C0ywU8cyltaK5QINyjXtJToHq1C409ad/9NTQHCywXAC90Mhhd9bmQy0Z
         o7vSLTrR0s4C638w7a2zpiWT6mPnjE2vga8/lHW/lIGKMs3M1vz180WSD26tiSOBiHPw
         qM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=HFP1dOXeBDG1Ukq7YGRY2A3hdFF3R2RCfcR7RE0tvpCpYO2TEnU7qkSuqou2hSv+Xg
         PJQibdlYrjSlJCUwc0+nYCwmcHmrG9XytMD12cj0xn1/zQVPBMOCzSA6rynxwIzdeQnc
         DucaF6OTq9HypXE2gRfqlUTCF7qS9D1CEos67NHa3k9YhYIo6SoxjNhTHIGWpnEMuE1H
         uG9plzmc7METEA1cyhiIre+7qsDcEOfOmfJb8kozuLe/oozqwqyKTamSdnbDKV8jo0QQ
         INfz2Ls7YL75z2J1n0lyQPBdku+YI0CUsdH7JAlOF9bQutN2+WLfYfOhqbBZUj8a4OFE
         qLWg==
X-Gm-Message-State: AOAM531ecjcfyW2lYnQD5KNS8Qpm70B5pUJSwXLEr/p7jyzEKaUowgc7
        6Csp/9LW1m6ynDBuIom0Q718zDl7YdRh4fg3AJvchA==
X-Google-Smtp-Source: ABdhPJyjz0JTTnXK42ND24drUizGJVy9nTKCt6Xn2fWRsbWsVUVA40D2jY5VU2owB/9x54wOo7wjRY1SJoVTueCCVAM=
X-Received: by 2002:a17:903:110c:b0:149:8018:e9d4 with SMTP id
 n12-20020a170903110c00b001498018e9d4mr36727254plh.117.1641306777954; Tue, 04
 Jan 2022 06:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20211222083350.18514-1-linmq006@gmail.com> <CAG3jFysrEDzYVbpwDVK2OJYMsEKRqpcBexK__m08A6vevm=ubw@mail.gmail.com>
In-Reply-To: <CAG3jFysrEDzYVbpwDVK2OJYMsEKRqpcBexK__m08A6vevm=ubw@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 15:32:46 +0100
Message-ID: <CAG3jFyuqY7LOZxLbrE+--ZxBoduOOnHw8n1XHGtt6=h+pdw=3g@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Fix null vs IS_ERR() checking in anx7625_register_i2c_dummy_clients
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, Sam Ravnborg <sam@ravnborg.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next
