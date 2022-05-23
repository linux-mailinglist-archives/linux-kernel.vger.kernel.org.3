Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C859D5310F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbiEWMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiEWMdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:33:37 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55B5427E6;
        Mon, 23 May 2022 05:33:35 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f189b07f57so18261933fac.1;
        Mon, 23 May 2022 05:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=X6MWkN+MXwESjJ8VLjim2DGGoViFUAGh9+IlVSr0qvY=;
        b=lTYTKrd59F3XMUkGhFGu6dqpa12J3prJhB+I2m1W0jfYN+Siw8vIuaJJ9J1vl5dMl1
         cuORjXTXinh07cWEJsQPU5pIHnIyCTK64LCGVlMsrJ8dLJCKZVTg1BVJl6Ojk2tgvzj4
         q1hOFqkqAUAXZ6mbBbWu1SNjxuEV8NDEgOcxVdYhSv/XwBBrh3S9Bj7HqjNa0ydLWDo7
         8xq1v7ya4+L4MXwDdoPzGIfeURJGkV+buXR+vMjfoU//v/WHIW5GdS5IU5CsZvlEcjld
         QQWBGJtxFpI8eyptHm8T5FfYqOcKRnyAbyajhAIdw69kk2maD2kEIMpLHjRUHcHgbA9P
         koHA==
X-Gm-Message-State: AOAM530Ub5Kx/Bnwr5YN/fi9qK39VywlgypCZHwnI8BIGbZHzTUu4FUm
        Q7uD4xOOij14b4SRSBnYRg==
X-Google-Smtp-Source: ABdhPJwOO+O7zT8r+lLhmyii8LgBtwlqTtnM90LxBsJkZOoKNqifzuh0NKNv8CMKNI9UWvO60BSKmA==
X-Received: by 2002:a05:6870:d581:b0:f1:82de:958c with SMTP id u1-20020a056870d58100b000f182de958cmr12298708oao.27.1653309214834;
        Mon, 23 May 2022 05:33:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z1-20020a9d7a41000000b0060603221264sm3898554otm.52.2022.05.23.05.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 05:33:34 -0700 (PDT)
Received: (nullmailer pid 1378078 invoked by uid 1000);
        Mon, 23 May 2022 12:33:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Jitao shi <jitao.shi@mediatek.com>,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220523104758.29531-2-granquet@baylibre.com>
References: <20220523104758.29531-1-granquet@baylibre.com> <20220523104758.29531-2-granquet@baylibre.com>
Subject: Re: [PATCH v10 01/21] dt-bindings: mediatek,dpi: Add DPINTF compatible
Date:   Mon, 23 May 2022 07:33:31 -0500
Message-Id: <1653309211.141261.1378077.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 12:47:34 +0200, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> DPINTF is similar to DPI but does not have the exact same feature set
> or register layouts.
> 
> DPINTF is the sink of the display pipeline that is connected to the
> DisplayPort controller and encoder unit. It takes the same clocks as
> DPI.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.yaml     | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


dpi@14014000: Additional properties are not allowed ('ports' was unexpected)
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

dpi@14014000: clock-names: ['pixel', 'engine', 'pll'] is too short
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

dpi@14014000: clocks: [[59, 26], [59, 27], [3, 6]] is too short
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb

dpi@14014000: clocks: [[61, 26], [61, 27], [3, 6]] is too short
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

dpi@14014000: compatible: ['mediatek,mt7623-dpi', 'mediatek,mt2701-dpi'] is too long
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

dpi@14014000: 'port' is a required property
	arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dtb
	arch/arm/boot/dts/mt7623n-rfb-emmc.dtb

dpi@1401d000: Additional properties are not allowed ('power-domains' was unexpected)
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

dpi@1401d000: clock-names: ['pixel', 'engine', 'pll'] is too short
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

dpi@1401d000: clocks: [[57, 40], [57, 41], [8, 8]] is too short
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

dpi@1401d000: clocks: [[68, 40], [68, 41], [8, 8]] is too short
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb

