Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6744ADF2A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352708AbiBHRTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiBHRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:19:13 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B565C061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:19:12 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 21E7F3FFDA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644340751;
        bh=FcBirewgG5GspHM+XiPFPnNhDyGu6MCNBPG4nrU1bUg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=pifFX9AmJ3B4OewK8O2GazzFCutjvzKZaYYfrjXu/sMEWGB4EI+L6UpjDfII+7s/S
         EIkWCGJPiY8C/hGzC05RJ8NrlYiBrPGQpDOXXf8fOzFj4KE02otIyggL9rhHwMJH4N
         uTnADkTWzPqH7SfiUsLcWo7hvQ/ULV55QmGEXCaSDQE//sXFcfp9jMQO0Fs0ZiZa4m
         lBKyuHX0JX9LqV8V9dgUDqklO/Q0/4l7aczUPh9jDqzgll2l2FkZY3qXgF8RNLxnAb
         DCB8kDiZNYVVB0cCi67jj+zs0/RwE/tbiwIdkZTgYlj6iBcOrlFV7jQe/uYSCz/0RF
         iTj++jJsYm6IQ==
Received: by mail-ed1-f71.google.com with SMTP id ee7-20020a056402290700b0040f680071c9so4002632edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FcBirewgG5GspHM+XiPFPnNhDyGu6MCNBPG4nrU1bUg=;
        b=NRT/em8R+Ln5/nRlenK6dZ/PMJCIsEgIthui4qPTeqwLJ2DgwbpInXX9Vm541hA6m2
         WH8QVAbeCQxFC0XT29Q9IIAbaR++C6PitaE49vUbb3RZ/aYpIP+w7XwfhmuNbOIL3H9J
         mgSTlV0aMz2Z7l7BshAA9QGuNpx4jS/T1TyHsClfu/P0crXJUocNI9cbjSIivn9GjY3R
         m5UxS1j1QJRud31Mma0lGKu8HpYQU4xEdowIzAtP/43waCU1FQfwoAjYZmswm+CphD2c
         UMr7+wsbGWcj+xcWxau1XXQfzeF6m3UV+G6I9L39mSr5QRmSDqm6W0K4Nrpvw26U3dDK
         twfQ==
X-Gm-Message-State: AOAM530hwo7qrFMldzNcG7+W3sQDtHQgCho3Wgx2CBxGYgPyI9AIC4Zv
        AkhUmq6yWa/HwK4ixhjaEr79Bqi6EXBA5Lstxq85mVcTZQl1A23cX15xmyU/a8mUVzMhd0ISJe2
        +py+01VhrXb+ZbZ0+80o5II3G9EFEyXVIUUkqvYRXUw==
X-Received: by 2002:a17:907:2d94:: with SMTP id gt20mr4673995ejc.501.1644340750446;
        Tue, 08 Feb 2022 09:19:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr5UsCRspXa4NCGOuZM5Ba8debNWt45uxZ8oMQLV+xoDrSe58nTit31OQ9lQldNaQthBGDVw==
X-Received: by 2002:a17:907:2d94:: with SMTP id gt20mr4673973ejc.501.1644340750270;
        Tue, 08 Feb 2022 09:19:10 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r10sm5125550ejy.148.2022.02.08.09.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:19:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 00/10] drm: dt-bindings: exynos: convert to dtschema
Date:   Tue,  8 Feb 2022 18:18:13 +0100
Message-Id: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Convert most of the Exynos DRM/Display bindings to DT schema and put
them under "samsung" directory instead of "exynos". The FIMD is used also
on S3C and S5P, so exynos is too specific.  Also most of other Samsung
SoC bindings and drivers are organized in directories by company name,
not by SoC name.

I used Exynos DRM maintainers and myself as bindings maintainers, but
feel free to propose different approach.

Dependencies
============
None. I will take the DTS patches via Samsung SoC tree.

Best regards,
Krzysztof

Krzysztof Kozlowski (10):
  ARM: dts: exynos: add missing HDMI supplies on SMDK5250
  ARM: dts: exynos: add missing HDMI supplies on SMDK5420
  dt-bindings: phy: samsung,exynos-hdmi-phy: convert to dtschema
  dt-bindings: display: samsung,exynos5433-decon: convert to dtschema
  dt-bindings: display: samsung,exynos7-decon: convert to dtschema
  dt-bindings: display: samsung,exynos-hdmi-ddc: convert to dtschema
  dt-bindings: display: samsung,exynos-mixer: convert to dtschema
  dt-bindings: display: samsung,exynos-hdmi: convert to dtschema
  dt-bindings: display: samsung,exynos5433-mic: convert to dtschema
  dt-bindings: display: samsung,exynos-fimd: convert to dtschema

 .../bindings/display/exynos/exynos-mic.txt    |  51 ----
 .../display/exynos/exynos5433-decon.txt       |  60 -----
 .../bindings/display/exynos/exynos7-decon.txt |  65 -----
 .../bindings/display/exynos/exynos_hdmi.txt   |  64 -----
 .../display/exynos/exynos_hdmiddc.txt         |  15 --
 .../display/exynos/exynos_hdmiphy.txt         |  15 --
 .../bindings/display/exynos/exynos_mixer.txt  |  26 --
 .../bindings/display/exynos/samsung-fimd.txt  | 107 ---------
 .../samsung/samsung,exynos-hdmi-ddc.yaml      |  42 ++++
 .../display/samsung/samsung,exynos-hdmi.yaml  | 227 ++++++++++++++++++
 .../display/samsung/samsung,exynos-mixer.yaml | 143 +++++++++++
 .../samsung/samsung,exynos5433-decon.yaml     | 148 ++++++++++++
 .../samsung/samsung,exynos5433-mic.yaml       |  95 ++++++++
 .../samsung/samsung,exynos7-decon.yaml        | 120 +++++++++
 .../display/samsung/samsung,fimd.yaml         | 198 +++++++++++++++
 .../bindings/phy/samsung,exynos-hdmi-phy.yaml |  44 ++++
 MAINTAINERS                                   |   1 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts     |   3 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts     |   3 +
 19 files changed, 1024 insertions(+), 403 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos-mic.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos5433-decon.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos7-decon.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmiddc.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmiphy.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_mixer.txt
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos-hdmi-ddc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos-hdmi.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos-mixer.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-decon.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos5433-mic.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos7-decon.yaml
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-hdmi-phy.yaml

-- 
2.32.0

