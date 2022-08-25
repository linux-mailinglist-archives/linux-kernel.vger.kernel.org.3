Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483BC5A1B08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbiHYV1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiHYV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:27:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF22BD098
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:27:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso3156435wmr.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gVyA5Z8on1cy579HoV3noOGIo3WqfSZOmskPQryMgtM=;
        b=eh/92dgXe0iyyY3sIgffq4zQH1CFGZMuz44bFe8eqZHrFui9w/sE6IF5yB6Fdl31m9
         q/giSA6K9TF82r9Z7/3a4lVAFzW09wfSy/165AHuuX16K0vRUPKCGD88QxiQrmNNKFx/
         PNqEaEBMyUErAL98l5VkqMECNhnqLIbgF9x4D6cHJgp36/cUymxzMzQQUJrrxSPR1sbt
         tHiJVRpf39VhrJtrS58T4jfliailuywTFaV0Thv6p9mpo8wn9z+7N1sXsoBeOU89UV5s
         QbzmqMrzJx9P96pqjjVEkAMxG/vEgHLJT3Oq/CqKdjvYxbHH4kMnlj0pz7TUi/E6SNFj
         m1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gVyA5Z8on1cy579HoV3noOGIo3WqfSZOmskPQryMgtM=;
        b=DJRfXUqoOreKP5RSUgQdZcFSm7mx5RSaZ13LQU/fZlyYTMAtgTeWwOY9honflrGI2G
         FTGr9YhI8mlj9dSdn40WCeV5LbKxjcyu7tgyyA14wYcqqxhU4OW1mGyXv/89qpU6tmPn
         ubhfaDib/90dOgOvlmRD7qBvdukK59P34Au/ifR9y1Z0UZeXc2BzOzWppe6fjh/X0e/g
         R36ChkwUouc2JdfFiWB6fRbgaLtuahZ9Wnn0sSxudOmCd35c7gGV57yvymFxeDk2B41N
         OnoTpa3Fp+Q+NS8qyAriHCYuUajtANwLgSU/KU5ibireiYahnBT/yq+++IEMauvuWtMp
         UVwQ==
X-Gm-Message-State: ACgBeo0BbLTnZLh4VoNY0CFXLTsu2ZUlRLlLxJtOXD9hk49RWCbTLXfo
        3gQT5VIjOWnQiwuXPNlrYC2UhVoyNrHUEw==
X-Google-Smtp-Source: AA6agR6cucYg/Du4YLrUO/NU1z88fXBAfmGuIRfE4Qrrqd+tO0lSZk3dovhgHxZZ4bK1jgQbd4MAWw==
X-Received: by 2002:a05:600c:198e:b0:3a5:d4a2:8896 with SMTP id t14-20020a05600c198e00b003a5d4a28896mr8967780wmq.140.1661462851646;
        Thu, 25 Aug 2022 14:27:31 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6e81000000b0021e8d205705sm242110wrz.51.2022.08.25.14.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:27:31 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Russell King <linux@armlinux.org.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] gpu: move from strlcpy with unused retval to strscpy
Date:   Thu, 25 Aug 2022 23:27:29 +0200
Message-ID: <22761203.6Emhk5qWAg@kista>
In-Reply-To: <20220818210008.6721-1-wsa+renesas@sang-engineering.com>
References: <20220818210008.6721-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 18. avgust 2022 ob 23:00:07 CEST je Wolfram Sang napisal(=
a):
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
>=20
> Link:
> https://lore.kernel.org/r/CAHk-=3DwgfRnXz0W3D37d01q3JFkr_i_uTL=3DV6A6G1oU=
Zcprmk
> nw@mail.gmail.com/ Signed-off-by: Wolfram Sang
> <wsa+renesas@sang-engineering.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c                   | 2 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c      | 2 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 6 +++---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c           | 2 +-
>  drivers/gpu/drm/display/drm_dp_helper.c             | 2 +-
>  drivers/gpu/drm/display/drm_dp_mst_topology.c       | 2 +-
>  drivers/gpu/drm/drm_mipi_dsi.c                      | 2 +-
>  drivers/gpu/drm/i2c/tda998x_drv.c                   | 2 +-
>  drivers/gpu/drm/i915/selftests/i915_perf.c          | 2 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c             | 2 +-
>  drivers/gpu/drm/radeon/radeon_atombios.c            | 4 ++--
>  drivers/gpu/drm/radeon/radeon_combios.c             | 4 ++--
>  drivers/gpu/drm/rockchip/inno_hdmi.c                | 2 +-
>  drivers/gpu/drm/rockchip/rk3066_hdmi.c              | 2 +-
>  drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c              | 2 +-
>  15 files changed, 19 insertions(+), 19 deletions(-)



