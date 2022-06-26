Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7946855B1A6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 14:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiFZMDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 08:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiFZMDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 08:03:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AADDF35
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 05:03:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e2so9454348edv.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YsABAicRvcChQL+dBsFsAqIQBSwYBfRLyHvxx/EjEAc=;
        b=RaoY3Z4G3hIju/NgnA1mb3Gn43W23OKW7Ox9ZCdiGyGO4nKI0D9FdPOicxxPgHYwXh
         EVM+7ckP5U9x/Ip4nLMrEKgpuiHqYApQJF9XmsB/PV8Qfk8oJ9nysoIBYdzyLE6FIzcv
         g1o8OJ61Xf/wzz4ZxOWEQGdKYvRNoA+sdYaq/yKL1rGdlCx0ck7sUq38nV678OPHR49X
         8Ku6I0Kd6oYfeEFQIo+wxWHY/HPxQmu53eyKRwQ/N8K3JURKmO/Iu6nz+EiKTRnoQXwO
         QAAHLLMQVLH+3YNQIMoH0uS8fhuiDmbmgHLxWLxKJuFfXUZJG6oR9NKCv8F/T+dEPNNq
         VOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YsABAicRvcChQL+dBsFsAqIQBSwYBfRLyHvxx/EjEAc=;
        b=y0GVUeazfNJndWpkKxwgOInNJLRa4pf8EMNNYZqrcxptKqtt4tqGrIUS40t1FJebDI
         igN5M0RAgToCFCa0au7nqotFOOc6KRwkOAA0btc3tUsIAgeS26zxAR8FoFbNaJaTyqRI
         DhOOQYrCa31gH/OUS0ey/jWvOR5Nygsjr9EkaNUCQuepZ2NMmRQoTzviaKFY4z6m1Ms6
         zCjLUszo95jSwvsg/dwVawwNY5PqitAeq4xe5FxMDO7Hd+BPLARM5Gtu2Qth+lM8Nk6r
         wsrb86yvdRXVkGyKmv5YUUsucDntrSh8N8QkVkkAxbbLyCH5phaZPb9eM8RrEgPOOhWi
         6J3Q==
X-Gm-Message-State: AJIora9NvvyKLvVa+viehy8qQhcRiaY+I0mzzVhJJmOgGxrbjCyxeoFA
        MxZpasNR77B5T1rAzl5j7bSD2w==
X-Google-Smtp-Source: AGRyM1vSiUGeDGrWoAfLuZEiBmbedMflmPiR4Vn8nuoypYTKzW3zgy4s6H+x5QfZVYILjBT9kOkBAg==
X-Received: by 2002:a05:6402:84a:b0:426:262d:967e with SMTP id b10-20020a056402084a00b00426262d967emr10327651edz.286.1656245025126;
        Sun, 26 Jun 2022 05:03:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906b29800b0072629374590sm3751585ejz.120.2022.06.26.05.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 05:03:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] mmc: dt-bindings: samsung,s3c6410-sdhci: convert to dtschema
Date:   Sun, 26 Jun 2022 14:03:37 +0200
Message-Id: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'll take DTS patches via Samsung SoC. The MMC bindings could go via MMC tree.

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  ARM: dts: exynos: align SDHCI node name with dtschema
  ARM: dts: s3c24xx: align SDHCI node name with dtschema
  ARM: dts: s3c64xx: align SDHCI node name with dtschema
  ARM: dts: s5pv210: align SDHCI node name with dtschema
  dt-bindings: mmc: samsung,s3c6410-sdhci: convert to dtschema

 .../bindings/mmc/samsung,s3c6410-sdhci.yaml   | 81 +++++++++++++++++++
 .../devicetree/bindings/mmc/samsung-sdhci.txt | 32 --------
 arch/arm/boot/dts/exynos4.dtsi                |  8 +-
 arch/arm/boot/dts/s3c2416.dtsi                |  4 +-
 arch/arm/boot/dts/s3c64xx.dtsi                |  6 +-
 arch/arm/boot/dts/s5pv210.dtsi                |  8 +-
 6 files changed, 94 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3c6410-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/samsung-sdhci.txt

-- 
2.34.1

