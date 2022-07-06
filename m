Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32D0568960
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiGFN1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiGFN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:27:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0C5193C0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:27:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g1so11650854edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VAoTYvqtCGzGoHx8PH7beT1Zf6846EDzggUtK1ftd2Q=;
        b=vGbQcro1TYNGE7MExrnv/MlDFRVV0IXZ2Jy9LsMcYNBQi2F0t3KNJ3VsPSKX4tVy/G
         w2TwOFSmBmjYfBy+nMZ3xjYyeK2Px3YJza4NS/MMPZBQPUAhKKOw4S/L55LaYWOWn+8R
         LrkjnwYS7pSwUdJ7Ry9v3RbB+pHFN7BpmoFKQHb67ywFaHAsPMNwTK66yb2wSrMxXHlp
         VsYiT9a95MbVqYVn/eROOkWwdR8UVNqqlRf+wtmKL29UPSxX/+X6K2bpYeCt1VqlOQRD
         ML9U7+xSLHgO4pYsUaQEkq727dc2IA+RAEYpdhSdTjJyPMJbNVUEpBqOakOLG7TwhVM7
         4LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAoTYvqtCGzGoHx8PH7beT1Zf6846EDzggUtK1ftd2Q=;
        b=1wBz6KNlIAH+xiyWpqamR23WcbHYdBp9gKpIbV1RtoMbbmAPA8Ni3GfojqbhZG0pl2
         a+wEhokdpw4zA6h2ixfVPmDnWT2sZqHcvsrhMc0kCpvHQgCf1SoEL9WCWa+p1o4yOk6a
         KocMvxdm+T99GBK3ODmMIJaRWnf0GKM0u3Jon2RobRXQjU61wVShiHc4xKaO8pogyUj8
         6v0kmuvaktSCk6LmNnbYuTe2/OqSPLcH4nH3GTCwEaY+r9qwZRURFZxsCjAFZvgtMZZH
         niSNqilRwFGFNTCUOOlG3dZ6eUy1INDR+5dcj8NzJzEYCU3cxtJn9lmfLXIF4QQFV2h/
         BEOQ==
X-Gm-Message-State: AJIora+2EU5YDLGGpPm3wZg+qA/jTxX23TjZTkdA2yZox5+JZiUAbiSy
        cr5p8Du3pQJxV4/DGgAcYC35s+oZ0GP3pl2brLyVug==
X-Google-Smtp-Source: AGRyM1vskFTZF4O+wMm1zEX9P3+2rr/5OchnqP4tR+YTAB8khuncXQa7GbdaxEgG8xneGNRXKppyB7z/4iXwxeYfhcI=
X-Received: by 2002:a05:6402:248c:b0:437:afe7:818b with SMTP id
 q12-20020a056402248c00b00437afe7818bmr53505217eda.239.1657114056472; Wed, 06
 Jul 2022 06:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220706125254.2474095-1-hsinyi@chromium.org>
In-Reply-To: <20220706125254.2474095-1-hsinyi@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 6 Jul 2022 15:27:24 +0200
Message-ID: <CAG3jFytve9yrhfwiG-PTcq-KFPN1Hb52DPZM4nWpd5pQ9mx5Cw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] anx7625: Cleanup, fixes, and implement wait_hpd_asserted
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 at 14:53, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> This series contains:
> Cleanup:
> - Convert to use devm_i2c_new_dummy_device()
> - Use pm_runtime_force_suspend(resume)
> Fixes:
> - Fix NULL pointer crash when using edp-panel
> and Impelment wait_hpd_asserted() callback.
>
> The patches are not related to each other, but they are all
> anx7625 patches so they are all stacked in this series.
>
> Hsin-Yi Wang (4):
>   drm/bridge: anx7625: Convert to devm_i2c_new_dummy_device()
>   drm/bridge: anx7625: use pm_runtime_force_suspend(resume)
>   drm/bridge: anx7625: Fix NULL pointer crash when using edp-panel
>   drm/bridge: anx7625: Add wait_hpd_asserted() callback
>
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 179 ++++++++--------------
>  1 file changed, 65 insertions(+), 114 deletions(-)
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>

Applied to drm-misc-next
