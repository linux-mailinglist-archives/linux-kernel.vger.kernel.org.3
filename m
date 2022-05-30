Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8609B537816
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiE3IyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiE3IyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 652A717E32
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653900796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RhvgJCFXfv5RG+0oVTAct7gmCCzDguggkQSBJ+VAo/A=;
        b=jUyl4v1DIWAxH3aJqAMDe2eFcp+t5N+xnWazHJK9G1SJ6M8wapKhb4q4FdgAQ0PviY4tkj
        WnE+rhJtp8eg828swerCQeZw0nvX2gZf5/nkLk155V5kMHGm6wU7wBibSYFWU/E+rFnjw2
        rWQ8Q2z93dAej3YQ5T55T3HFtgWP5Qk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-E0UPC6KvP5OcBrk5WPgHhw-1; Mon, 30 May 2022 04:53:14 -0400
X-MC-Unique: E0UPC6KvP5OcBrk5WPgHhw-1
Received: by mail-ej1-f72.google.com with SMTP id lf18-20020a170906ae5200b006fec8de9f0cso3836105ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RhvgJCFXfv5RG+0oVTAct7gmCCzDguggkQSBJ+VAo/A=;
        b=Lv2WFTOs6H/YCLHAQWCfO1xQP+VaB8bstaWqzeyeOJgGhgFbOTH6zprZM7ye8JThiO
         YL8kl0bU0bc0f9a5Y9qhIaB0BijMbPSS4M6SmkzKaRhWTbqc1tt/RoN9bBeIq2tRu9XD
         nwnj57dizzU2EgSGVmD3gP8LLckAQPVu9StIdqP2o4xyCGBAmyMrd5ym1EnyUS8lVum2
         yHATUpZ7+vHlyI0dMIxF9p6XxEVao3FHCgIqCuYIyF1Ti7HHR7VqY1GAEU3Z6ul/UVaH
         zXWWbVZgk29tWBjSJM1JkTjHQBGfLjDsmpRkMxavbj0+sNmhNGkUmNu4RvZ7EKPUZtuZ
         lQEg==
X-Gm-Message-State: AOAM532pDolVJN3nqHEk9P2/p1Wac9CbpMXWxjg/FmBvf5v0uvZrPNj9
        rEGTzHIQg9cMpsB4hXmkR/0tS3QXkI3f5H7GlxAnBmaG0qV5zukOKoHfRs2Syix+5mK/AtSxslO
        QoCAbFZeRQMVY/GiVa3FDp7Mi
X-Received: by 2002:a17:907:6e20:b0:6ff:1541:8d34 with SMTP id sd32-20020a1709076e2000b006ff15418d34mr20498818ejc.447.1653900793067;
        Mon, 30 May 2022 01:53:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLS9X1+J2YlCZd50xUKza5F2TAaKjqsoBWgZZta9P6P5hLJgXAWFm13+BAHE9yuTPrdLSHXw==
X-Received: by 2002:a17:907:6e20:b0:6ff:1541:8d34 with SMTP id sd32-20020a1709076e2000b006ff15418d34mr20498786ejc.447.1653900792873;
        Mon, 30 May 2022 01:53:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id v16-20020a1709062f1000b006fea2705d18sm3807438eji.210.2022.05.30.01.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 01:53:12 -0700 (PDT)
Message-ID: <a8d1fe13-e747-016a-2d45-bfb50f23f2d9@redhat.com>
Date:   Mon, 30 May 2022 10:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 0/4] Separate panel orientation property creating and
 value setting
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Simon Ser <contact@emersion.fr>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
References: <20220530081910.3947168-1-hsinyi@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220530081910.3947168-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/30/22 10:19, Hsin-Yi Wang wrote:
> Some drivers, eg. mtk_drm and msm_drm, rely on the panel to set the
> orientation. Panel calls drm_connector_set_panel_orientation() to create
> orientation property and sets the value. However, connector properties
> can't be created after drm_dev_register() is called. The goal is to
> separate the orientation property creation, so drm drivers can create it
> earlier before drm_dev_register().

Sorry for jumping in pretty late in the discussion (based on the v10
I seem to have missed this before).

This sounds to me like the real issue here is that drm_dev_register()
is getting called too early?

To me it seems sensible to delay calling drm_dev_register() and
thus allowing userspace to start detecting available displays +
features until after the panel has been probed.

I see a devicetree patch in this series, so I guess that the panel
is described in devicetree. Especially in the case of devicetree
I would expect the kernel to have enough info to do the right
thing and make sure the panel is probed before calling
drm_dev_register() ?

Regards,

Hans




> 
> After this series, drm_connector_set_panel_orientation() works like
> before. It won't affect existing callers of
> drm_connector_set_panel_orientation(). The only difference is that
> some drm drivers can call drm_connector_init_panel_orientation_property()
> earlier.
> 
> Hsin-Yi Wang (4):
>   gpu: drm: separate panel orientation property creating and value
>     setting
>   drm/mediatek: init panel orientation property
>   drm/msm: init panel orientation property
>   arm64: dts: mt8183: Add panel rotation
> 
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  1 +
>  drivers/gpu/drm/drm_connector.c               | 58 ++++++++++++++-----
>  drivers/gpu/drm/mediatek/mtk_dsi.c            |  7 +++
>  drivers/gpu/drm/msm/dsi/dsi_manager.c         |  4 ++
>  include/drm/drm_connector.h                   |  2 +
>  5 files changed, 59 insertions(+), 13 deletions(-)
> 

