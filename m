Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35DA4F040D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356568AbiDBOij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243878AbiDBOig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E973D181B13;
        Sat,  2 Apr 2022 07:36:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so7944183ejd.3;
        Sat, 02 Apr 2022 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RGNMGqDkFSJymA3pWafV2dnoGntv8svW3Mz+ef8XMI4=;
        b=n2YqOiNjdDyk26irDah8NTksunLZcPMNnL/oHlMuFo4PrHUpUvaNmuvvMXbAtD9NSG
         NRRD+yh311awcfb2sxa0t8zYyHoHPyy8PCd3riNnMuBfbIAWPY05JyQSdJTUsYXvBEc4
         LRVKdcGYubDE2BnQun3hiJgGax7RJ+mlyy31ONdDky5QofmY/danhSCq63ZCWR9RKYH9
         amr43JGdlguglwrUOKuF3jGmSpSS/BQ4UNInu5Ql7JRJMqXvFy4iY6MtjhUprrn91dqX
         iTB6+jeqUwsOu9BHBjHkQkVShY2D/gOb6zLT+XEk9oCL6MrNWvH5j7hKGb6NSZXztx3Y
         5kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RGNMGqDkFSJymA3pWafV2dnoGntv8svW3Mz+ef8XMI4=;
        b=DZFhTsgZjA4JhoEm5pnia9ZIoI3t0XjyZyDGEX31VT7vQQWRoqZg8XB59tpYSONrP6
         W85KWx7TtujUpdAxRTIPOQfFJvKqN5Ijzm1K2Hib+A1LWsOJ8NrfReeOdvEPD1I3CW1M
         10z/bDYyJfNT/mEvSiFRKCl//9IciwCFqL1DtDMYIykKiIz0X90h8vAXg5rHB1f7wS2R
         ugJJssTptHYU7hZc4TfZMQDk+B1IjvN14NNStEYYWpYshxwacBW7Ek63AtJ5A4nLdtWh
         8UZOJkjdzyNoG3bwuTRsZe2rvx8zLHx3+GXEc1BPd3BFtWSyig2DmPbu8Nai6WDEnBzs
         rS+w==
X-Gm-Message-State: AOAM533Uzt/JaOrcAkWA2esNsK9+jgY65MdfbXUaiUY2Pnqsp7SO9eMu
        dLdb3FwemIIvt+dDY/TK+5E=
X-Google-Smtp-Source: ABdhPJzTbd5ywK0ecrPLfPLSq2IDdTj6OVySRGrIJcFomjN8tElW6y5sFBxCeefFejSxTebo5V8Ecw==
X-Received: by 2002:a17:907:608c:b0:6e0:19fe:d689 with SMTP id ht12-20020a170907608c00b006e019fed689mr3995444ejc.164.1648910203449;
        Sat, 02 Apr 2022 07:36:43 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:42 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/16] Convert Rockchip clk
Date:   Sat,  2 Apr 2022 16:36:20 +0200
Message-Id: <20220402143636.15222-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combined serie of previously converted Rockchip clk bindings.

Changed V4:
  combine dts patches
  add more clocks
  add clocks to example
  add clocks requirement

Johan Jonker (16):
  dt-bindings: clock: convert rockchip,px30-cru.txt to YAML
  dt-bindings: clock: convert rockchip,rk3036-cru.txt to YAML
  dt-bindings: clock: convert rockchip,rk3188-cru.txt to YAML
  dt-bindings: clock: convert rockchip,rk3228-cru.txt to YAML
  dt-bindings: clock: convert rockchip,rk3288-cru.txt to YAML
  dt-bindings: clock: convert rockchip,rk3308-cru.txt to YAML
  dt-bindings: clock: convert rockchip,rk3328-cru.txt to YAML
  dt-bindings: clock: convert rockchip,rk3368-cru.txt to YAML
  dt-bindings: clock: convert rockchip,rv1108-cru.txt to YAML
  ARM: dts: rockchip: add clocks property to Rockchip cru nodes
  arm64: dts: rockchip: add clocks property to Rockchip cru nodes
  arm64: dts: rockchip: rk3399: use generic node name for pmucru
  arm64: dts: rockchip: fix compatible string rk3328 cru node
  dt-bindings: clock: replace a maintainer for rockchip,rk3399-cru.yaml
  dt-bindings: clock: use generic node name for pmucru example in
    rockchip,rk3399-cru.yaml
  dt-bindings: clock: fix some conversion clock issues for
    rockchip,rk3399-cru.yaml

 .../bindings/clock/rockchip,px30-cru.txt      |  70 ----------
 .../bindings/clock/rockchip,px30-cru.yaml     | 120 ++++++++++++++++++
 .../bindings/clock/rockchip,rk3036-cru.txt    |  56 --------
 .../bindings/clock/rockchip,rk3036-cru.yaml   |  80 ++++++++++++
 .../bindings/clock/rockchip,rk3188-cru.txt    |  61 ---------
 .../bindings/clock/rockchip,rk3188-cru.yaml   |  86 +++++++++++++
 .../bindings/clock/rockchip,rk3228-cru.txt    |  58 ---------
 .../bindings/clock/rockchip,rk3228-cru.yaml   |  82 ++++++++++++
 .../bindings/clock/rockchip,rk3288-cru.txt    |  67 ----------
 .../bindings/clock/rockchip,rk3288-cru.yaml   |  93 ++++++++++++++
 .../bindings/clock/rockchip,rk3308-cru.txt    |  60 ---------
 .../bindings/clock/rockchip,rk3308-cru.yaml   |  86 +++++++++++++
 .../bindings/clock/rockchip,rk3328-cru.txt    |  58 ---------
 .../bindings/clock/rockchip,rk3328-cru.yaml   |  82 ++++++++++++
 .../bindings/clock/rockchip,rk3368-cru.txt    |  61 ---------
 .../bindings/clock/rockchip,rk3368-cru.yaml   |  86 +++++++++++++
 .../bindings/clock/rockchip,rk3399-cru.yaml   |  59 ++++-----
 .../bindings/clock/rockchip,rv1108-cru.txt    |  59 ---------
 .../bindings/clock/rockchip,rv1108-cru.yaml   |  83 ++++++++++++
 arch/arm/boot/dts/rk3036.dtsi                 |   2 +
 arch/arm/boot/dts/rk3066a.dtsi                |   3 +-
 arch/arm/boot/dts/rk3188.dtsi                 |   3 +-
 arch/arm/boot/dts/rk322x.dtsi                 |   2 +
 arch/arm/boot/dts/rk3288.dtsi                 |   2 +
 arch/arm/boot/dts/rv1108.dtsi                 |   2 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |   5 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |   4 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      |   2 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |   6 +-
 29 files changed, 853 insertions(+), 585 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3036-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3308-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3368-cru.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1108-cru.yaml

-- 
2.20.1

