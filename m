Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABA44A2F52
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbiA2MYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:24:02 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:32850
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239212AbiA2MYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:24:00 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D20D33F1D9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643459039;
        bh=x4o0tadweuj23sLkh9uK/49Ckg22Ago7xB3yd+9McbM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=VZhSXu9vwBHUaIhkfD0+K9eABZ0anng0dYAXXKmyh+QfNaw6/DPM3ixAf4eK4Y/gE
         4IbsKPDMu5nE0hCUmt1HCMkyZuYGeikFGHpbFXgwBPan3gZBppbPBqEySwIwM8sK7/
         iJ7Z2aZy2alH+Db+HXbXaZtkCxvzT4GKzOy5L9cMV8C5ozKn2nm20Nl3J6XHAdNv/u
         vkDUOioNRQESfUvhPrCMB9+KgbiADRVQQtp9TjEYLRWWmt/2aeCI+ZoytzkMaT53Ny
         s/6dynzOlq6GWY0PejcdZbhAdoXVzSGkI/+Pc1ezIAz6+7PIWA2IVMG42aXw8N/43S
         jsMwbVA/KCGkA==
Received: by mail-wm1-f70.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so4707422wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 04:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x4o0tadweuj23sLkh9uK/49Ckg22Ago7xB3yd+9McbM=;
        b=FxYyprr04F1OVT7rxLcpHp0+PDncOMnopfMy2ACGPCEiSm4D3bR1TndhEHLJPeerk4
         mxQdqtsbQQkVDKsR43X2X5iLDvcIGz0za8YEmxnxtALGAcd6NdPNf59CImjoEypIoxBq
         2+mXL9u6cHEgPaBoXwOrONG7hpZMYZrDyZ2wXO571fCDSrzHYb0v0tpHeIz7kox98woO
         f5iEAXIt8RsZPNj2YxjOyWZXWb2PbN42bPrv8uhdhUFObIcAm7qQSpDZcnQxsYUh7Wvd
         mcQT5zl37cntUJ/pcPz48FDUw9nS4r83bWuU3WmRb4p54tSTdrIzjBN03Jcxk8BVlAg5
         gp8A==
X-Gm-Message-State: AOAM531hixMiLIT9+RoehLelOEzgTFnZzRZSf6+hsOsDxcOo7rbkO20x
        Cg483h/nu1DG5ZqSH9aigOEWORXE1mxMNmyuUyrt/FK6D2u3VyNXeB2EMv97H9yH3alHZHQkG9J
        E4v8xCoRABf1usWQjmsmB0ONdlLB3CnIqBz6fMsMr6w==
X-Received: by 2002:a05:6000:3ce:: with SMTP id b14mr11007119wrg.118.1643459039567;
        Sat, 29 Jan 2022 04:23:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygRY/OO3A1gLYNKDwc5YcDp9OYKQQJgKxWDSCXzN4Pa9hV5T3InC2pPxALeSJIge3bJVVrsw==
X-Received: by 2002:a05:6000:3ce:: with SMTP id b14mr11007100wrg.118.1643459039297;
        Sat, 29 Jan 2022 04:23:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id z13sm7901534wrm.90.2022.01.29.04.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 04:23:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] ASoC: dt-bindings: samsung: convert to dtschema
Date:   Sat, 29 Jan 2022 13:23:51 +0100
Message-Id: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patchset is based on Rob's sound-dai changes:
https://lore.kernel.org/all/20220126231427.1638089-1-robh@kernel.org/

Changes since v1:
1. Correct samsung,snow cpu/sound-dai.

Best regards,
Krzysztof

Krzysztof Kozlowski (6):
  ASoC: dt-bindings: samsung,aries-wm8994: require sound-dai property
  ASoC: dt-bindings: samsung,arndale: convert to dtschema
  ASoC: dt-bindings: samsung,arndale: document ALC5631
  ASoC: dt-bindings: samsung,smdk5250: convert to dtschema
  ASoC: dt-bindings: samsung,snow: convert to dtschema
  ASoC: dt-bindings: samsung,tm2: convert to dtschema

 .../devicetree/bindings/sound/arndale.txt     | 25 ------
 .../bindings/sound/samsung,aries-wm8994.yaml  |  4 +
 .../bindings/sound/samsung,arndale.yaml       | 45 +++++++++++
 .../bindings/sound/samsung,smdk-wm8994.txt    | 14 ----
 .../bindings/sound/samsung,smdk5250.yaml      | 38 +++++++++
 .../bindings/sound/samsung,snow.yaml          | 74 +++++++++++++++++
 .../bindings/sound/samsung,tm2-audio.txt      | 42 ----------
 .../bindings/sound/samsung,tm2.yaml           | 80 +++++++++++++++++++
 .../devicetree/bindings/sound/snow.txt        | 31 -------
 9 files changed, 241 insertions(+), 112 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/arndale.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,arndale.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk5250.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,snow.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/snow.txt

-- 
2.32.0

