Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08354F1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380455AbiFQH1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380440AbiFQH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:27:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8E0238
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:27:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hj18so6499521ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQq40oMN7gmdQC+AT9QDPaFxl7FPBvbWJRNfnUwXKDM=;
        b=WVyrrkfevDNjf+huonwA9B5s9xSQZYZi2r+aZUELTsXXjF4O6vQnCqY+BUEzJzZNRd
         d0LLVZgipLJfHZccSmmrVjXndNOa1A1T+d6hzxJOJMd/SCGtqukb0dzuV+Jdns53yf/7
         Ol4vmMnc60F3iMCAHFSuDmvoCQ3urv9+N5CM04/o0XSJWSQ1PRXCIUrFblifTIVUsAmp
         dGv/7awkXmswiMdpVa6RwYH0fHwxeitYDETgmlTKVnoAQiG14yu2C2+QJfrSz0PYRTpp
         vjsPAciMrBMiuyaIhvkjJbElQzVbnKgUyiXIfEe2s9c38vYjLN3+J649BKh9yggDUtOx
         WeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQq40oMN7gmdQC+AT9QDPaFxl7FPBvbWJRNfnUwXKDM=;
        b=B3jSWTmUUcZcjQYmyXnDIGrrGDUiulHlHv2S1iCUEGOFySoREazDr2EApQmQbHK0sj
         cXjVXg12sLvrzaFODfiJQruCC0oxWVihssbXTwSJ3faDFfuXV7Aw6xAUnRxfoS1Z32jr
         cQzi5yMZ/yIXBFY8IxQ/k+L/hxxXoLzCKEx5qqS1oRs5dBuYNR3gO+BK18qaOGJ7/q+0
         yfjE5iJJq5iFvwY0R3D8Tk5L+aRQiphNRh4Nxxzqnq0OveVxxch9xlQneq2trgjFCZLu
         blR12gLGr2SdjhJIx94tcqApCqSEx6joQpge6AGjKQr9WrHHMPdxFL8TrIy7YUfNWKjM
         D9gg==
X-Gm-Message-State: AJIora/q8NiQvoVmzpE49mlbuCRAZVFWUUk7NG0O4w8GzHc7s98ulpaL
        /fSuYmngpG/IqJ8G7JzBQTKYHQ==
X-Google-Smtp-Source: AGRyM1sxFqf+ZA9TwaYMiAGjuKdZcewUkcjEfmKspEGGfwpwBFc9cv9j/GszRPgEU+WXq8tqHYmaJA==
X-Received: by 2002:a17:906:2001:b0:6f3:bd7f:d878 with SMTP id 1-20020a170906200100b006f3bd7fd878mr8116353ejo.133.1655450851577;
        Fri, 17 Jun 2022 00:27:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:d227:8f3c:286a:d9d8])
        by smtp.gmail.com with ESMTPSA id n9-20020a170906840900b006fec56a80a8sm1762556ejx.115.2022.06.17.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 00:27:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org, martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 0/6] drm/meson: add support for MIPI DSI Display
Date:   Fri, 17 Jun 2022 09:27:17 +0200
Message-Id: <20220617072723.1742668-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3794; h=from:subject; bh=BYC7E8gt4vas7fssyMJgGADHrk4Bwh9RxYGpTB1C8D8=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBirCyovMIHKIMtHpx/OwvFBdD5fVOk6xZj4JYrwLfJ ZEfcuKCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYqwsqAAKCRB33NvayMhJ0bnKEA CmyCVZ3hb6HAVePCseiDUslVAYevwqViz8UY2glZksO26r2p8ClzOMmK+cRExDx3CqFgl07CT2+I6E Yl7/h0pgvDSwv3pFlN7cXaWitSgG4wH03VelPzbaqBZpSwktLocHfkwN/sSwQyzO49AQtnUdPaYeLQ 7rOh2oJwxFYJJWHqgab+wznPy5HdPVsAAVEQWZ0pN8jnZ+qUNqIbr3x+m3SMMAYKVl2Ew1eABDSRdG ravmDkaLPC/KM5BYPIEtjiPTqYGXRlNT5Q06pLhtkiROP8+tSSSKEkyANjnqpwWaqYQb/8VQRoSEr6 dqRtcT0eKTeuEZZyYXP2fmQu8N7qg0iZk+Mkz31Hfn4xvB46QIPw6e3lrU/Fn0LrmaA4g+0gasJ0kd ukeaRlae2RvDOGKkgzdk+sxh/zGZmy6gfk1SMmY1LQo54YbB6y9XanJuqaeSgdZRYZSKEvZRtWxkB5 8relb6eqemFt/c/LEPKX61hMczMd9emGFQcnXIums4pXep0vLtFNHWDjZp3IMOW0iPCgzl0/ujCzYB +MJw+jngKVAQs3RAmvtNLu8dw2w9lrjViHBHXsph4GAVZDe6WUUguSiV68xCG3v+NrNItohcx2iO07 CDDpkQfoyCP7E7DaeweqxD5oTxlp/zTml/KNPUQcf2V4XhDnJwUzRoJLWclQ==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
glue on the same Amlogic SoCs.

This adds support for the glue managing the transceiver, mimicing the init flow provided
by Amlogic to setup the ENCL encoder, the glue, the transceiver, the digital D-PHY and the
Analog PHY in the proper way.

The DW-MIPI-DSI transceiver + D-PHY are clocked by the GP0 PLL, and the ENCL encoder + VIU
pixel reader by the VCLK2 clock using the HDMI PLL.

The DW-MIPI-DSI transceiver gets this pixel stream as input clocked with the VCLK2 clock.

An optional "MEAS" clock can be enabled to measure the delay between each vsync feeding the
DW-MIPI-DSI transceiver.

This patchset is based on an earlier attempt at [1] for the AXG SoCs, but:
- the AXG has a single clock source for both transceiver + pixel, which makes it an
  exception instead of a rule, it's simpler to add support for G12A then add AXG on it
- previous glue code was a single monolitic code mixing encoders & bridges, this version
  is aligned on the previous cleanup done on HDMI & CVBS bridges architecture at [2]
- since the only output of AXG is DSI, AXG VPU support is post-poned until we implement
  single-clock DSI support specific case on top of this.

Changes from v2 at [4]:
- Fixed patch 3
- Added reviews from Jagan
- Rebased on v5.19-rc1

Changes from v1 at [3]:
- fixed DSI host bindings
- add reviewed-by tags for bindings
- moved magic values to defines thanks to Martin's searches
- added proper prefixes to defines
- moved phy_configure to phy_init() dw-mipi-dsi callback
- moved phy_on to a new phy_power_on() dw-mipi-dsi callback
- correctly return phy_init/configure errors to callback returns

[1] https://lore.kernel.org/r/20200907081825.1654-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20211020123947.2585572-1-narmstrong@baylibre.com
[3] https://lore.kernel.org/r/20200907081825.1654-1-narmstrong@baylibre.com
[4] https://lore.kernel.org/r/20220120083357.1541262-1-narmstrong@baylibre.com

Neil Armstrong (6):
  dt-bindings: display: add Amlogic MIPI DSI Host Controller bindings
  dt-bindings: display: meson-vpu: add third DPI output port
  drm/meson: venc: add ENCL encoder setup for MIPI-DSI output
  drm/meson: vclk: add DSI clock config
  drm/meson: add DSI encoder
  drm/meson: add support for MIPI-DSI transceiver

 .../display/amlogic,meson-dw-mipi-dsi.yaml    | 116 ++++++
 .../bindings/display/amlogic,meson-vpu.yaml   |   5 +
 drivers/gpu/drm/meson/Kconfig                 |   7 +
 drivers/gpu/drm/meson/Makefile                |   3 +-
 drivers/gpu/drm/meson/meson_drv.c             |   7 +
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c     | 358 ++++++++++++++++++
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.h     | 160 ++++++++
 drivers/gpu/drm/meson/meson_encoder_dsi.c     | 160 ++++++++
 drivers/gpu/drm/meson/meson_encoder_dsi.h     |  12 +
 drivers/gpu/drm/meson/meson_registers.h       |  25 ++
 drivers/gpu/drm/meson/meson_vclk.c            |  47 +++
 drivers/gpu/drm/meson/meson_vclk.h            |   1 +
 drivers/gpu/drm/meson/meson_venc.c            | 211 ++++++++++-
 drivers/gpu/drm/meson/meson_venc.h            |   6 +
 drivers/gpu/drm/meson/meson_vpp.h             |   2 +
 15 files changed, 1117 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
 create mode 100644 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/meson/meson_dw_mipi_dsi.h
 create mode 100644 drivers/gpu/drm/meson/meson_encoder_dsi.c
 create mode 100644 drivers/gpu/drm/meson/meson_encoder_dsi.h

-- 
2.25.1

