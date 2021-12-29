Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD94813ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbhL2OPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:15:41 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40996
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233713AbhL2OPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:15:35 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DDB7F3F1A5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640787332;
        bh=UlJjLAfS40qt5leudPWhfuRwJJRufaBrjQlrhE6JqdI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Vy+vDGGDzJadxRsS1cmIE92XTYtBDxx8fDGVxztgSEoli/GVGXpDRripHLuwkLlz8
         AzfRAeoJv+m7a64RorcrfC31M+eZ2VdbG+MsefIgSqtdg6tG4b4Nj2Ra+UIyHbRvTg
         Fx5tz+0KHWtvmHL3sxHb1a5yZoB6PtuTUMKX460wNyietiaLOfvy6G6sscdBgwUJVE
         CpTErbOqFyOcTxSUJV/x6/umO/BT1jvIiUi1pY01mxJZ/5CVMyfoUwF4nAIiqG3UGd
         7FFKlNpuUc2zL2MEyICBiZB5zKu8+SfKlKQopUnxoK4htwrCH+uZxiZ7OlZ/LeL/FZ
         U63UUtvoR2PEQ==
Received: by mail-lj1-f199.google.com with SMTP id s11-20020a05651c048b00b0022d8722e7b5so1745676ljc.23
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 06:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlJjLAfS40qt5leudPWhfuRwJJRufaBrjQlrhE6JqdI=;
        b=obmr7yw/sVizJhx4hYjKj2b3WEXYr1iJ9xm0YXkwzDyghPbPOH/tPygoAQXxHIMyyD
         AFxQWfs52czS6gLeSe/FikWbXsAbTyDVPAqtk/b2LKQv8e2lCmPDFkhaE5f5sgDlK016
         EfiprDn95HN2rZdXI7W9H3RiayUnJiar64yYQ/SYaUhdrY36Tow3qTa4eFbXvb8Ej29/
         BmftknCXJGMXC7bWHiKpzMjwbwlqnL4IzXbdaVUyhBosfjFgw6VCsNBLjVdbEQXvanN3
         KIImu6EBog3DQx7fcII82Kraow/23iHVbF1OtqzjSwc/AaiEk8bzI2uRRx/wUDeXVpUS
         ekNQ==
X-Gm-Message-State: AOAM530J4TAlh0NCFqNNHXag2K4LptbZO63YT81xZpYsN0QDFv//gzUT
        zzREzf73bUzlVqr3N2o7OqBC1+w9MlvvBH4WMNYziYvARxLSofKDfacvocAzAh8d7woaBvMN26G
        VH/1lLeYhUVQ5+ZF+0YsBKyNSQcM6A0LmGfKao6dDTw==
X-Received: by 2002:a05:651c:ba8:: with SMTP id bg40mr18007301ljb.276.1640787332070;
        Wed, 29 Dec 2021 06:15:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5TtuMxYfpkf1FSMtnQIraHesCWHTbGXlzooBflaELIyumSIPdU/aIFK3/MPK4jIGTN5L8Vw==
X-Received: by 2002:a05:651c:ba8:: with SMTP id bg40mr18007281ljb.276.1640787331900;
        Wed, 29 Dec 2021 06:15:31 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a16sm1316164ljm.98.2021.12.29.06.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 06:15:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/4] mfd/power/regulators: dt-bindings: max14577: convert to dtschema
Date:   Wed, 29 Dec 2021 15:15:20 +0100
Message-Id: <20211229141524.34174-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dependencies:
1. DTS patch 1/4: nothing depends on it, sending here so Rob's automatic
   checker won't complain about DTS.
   I will take it via Samsung SoC tree.

2. Final MFD patch (4/4) depends on regulator and power, so the last
   patches (2+3+4) should go via same tree.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  ARM: dts: exynos: Align MAX77836 nodes with dtschema on Monk and
    Rinato
  dt-bindings: power: supply: maxim,max14577: convert to dtschema
  regulator: dt-bindings: maxim,max14577: convert to dtschema
  dt-bindings: mfd: maxim,max14577: convert to dtschema

 .../devicetree/bindings/mfd/max14577.txt      | 147 -------------
 .../bindings/mfd/maxim,max14577.yaml          | 195 ++++++++++++++++++
 .../bindings/power/supply/maxim,max14577.yaml |  84 ++++++++
 .../bindings/regulator/maxim,max14577.yaml    |  81 ++++++++
 MAINTAINERS                                   |   3 +-
 arch/arm/boot/dts/exynos3250-monk.dts         |   2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts       |   2 +-
 7 files changed, 364 insertions(+), 150 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max14577.yaml

-- 
2.32.0

