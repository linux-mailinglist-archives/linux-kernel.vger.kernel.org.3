Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC446487948
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347911AbiAGOza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347888AbiAGOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:55:26 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1B2C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:55:26 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l4so4080690wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OB1egdVUErhbIEcGNr9v6weyeR2HVWTfX0w5sfnPT8=;
        b=23kNyt/oSxQ3KeKDbsaqaKBfUsp7ntvPK7l7R5DcvRrrqteLCLDOIUE2EXy9y3cwUT
         U+8Sy4kng1/ON5Oe9tj4doiMQgEOEbnXm5z8qMDlQRI0uzJ49jI5+rbHkHkxYklybntN
         y08Kq6lTo/wN18Ypin7P+UVZcwhXtTr/W6M7qdtpfrIO0LqdYl4nWyNREV91skSSDnOd
         +KYL4/0GpLtBY/IMfMgZixsZ7Wq05QS+bClHOp5ZCB8xQCgWTecCB2mptOyqS03LxWr/
         L1M0GJZhxlRdVvUxzeQQpNY79cEk8PzkxAj6KNB7okRa66QcERl76iFqKRG+xxh2U5ws
         xqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OB1egdVUErhbIEcGNr9v6weyeR2HVWTfX0w5sfnPT8=;
        b=FTgaPszgo/W8Nm/Ts76Ch9H8gED7QqBVmX2rfTnu6Kt1I6BruKs3QJLjhiC6tFshfb
         BkOIyJC9Oe34IXnxcqHkBeHdpHAsGoGkN5XUhAs+enXtMMQrrauf8eu8MOoVTvrl6NuM
         HVhU3V9t5DKj6fyiQmWmNRjH0QJ139ERew/Ecw4gwu84H4AjUIZOGCmFIImSFoxTe1ie
         h8ET0yqXGFmoVhtC0KTO0nEwGW1uyNy2dfLZ0ET6DPL2n/guIYe0O33nHqHJlvXLLlWZ
         RgAyZ+jM8iLH1+1iejjPpprVnHYI/qyqXTZ1ZvoTQxkvvI8eiGd0cE6THg+XfBR7ZRu9
         cTkw==
X-Gm-Message-State: AOAM533hlrEsVWb4xkv8+YBQMe5EFcR69/pFwNT69hSeAS5TfluYZpM/
        zlesq9xuK+YQs1htEYgolcgGbeBHayyzhg==
X-Google-Smtp-Source: ABdhPJw/hF0g74U9jqW1SRjLFDdY6ypEE7h2nALHUm54k6OflJfKc5qsDc8wlGXt8MIhuedZT5cEJA==
X-Received: by 2002:a05:600c:2152:: with SMTP id v18mr837414wml.50.1641567324545;
        Fri, 07 Jan 2022 06:55:24 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:fc89:e826:8938:cbde])
        by smtp.gmail.com with ESMTPSA id n8sm5594492wri.47.2022.01.07.06.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 06:55:24 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/6] drm/meson: add support for MIPI DSI Display
Date:   Fri,  7 Jan 2022 15:55:09 +0100
Message-Id: <20220107145515.613009-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

[1] https://lore.kernel.org/r/20200907081825.1654-1-narmstrong@baylibre.com
[2] https://lore.kernel.org/r/20211020123947.2585572-1-narmstrong@baylibre.com

Neil Armstrong (6):
  dt-bindings: display: add Amlogic MIPI DSI Host Controller bindings
  dt-bindings: display: meson-vpu: add third DPI output port
  drm/meson: venc: add ENCL encoder setup for MIPI-DSI output
  drm/meson: vclk: add DSI clock config
  drm/meson: add DSI encoder
  drm/meson: add support for MIPI-DSI transceiver

 .../display/amlogic,meson-dw-mipi-dsi.yaml    | 118 ++++++
 .../bindings/display/amlogic,meson-vpu.yaml   |   5 +
 drivers/gpu/drm/meson/Kconfig                 |   7 +
 drivers/gpu/drm/meson/Makefile                |   3 +-
 drivers/gpu/drm/meson/meson_drv.c             |   7 +
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c     | 383 ++++++++++++++++++
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.h     | 115 ++++++
 drivers/gpu/drm/meson/meson_encoder_dsi.c     | 159 ++++++++
 drivers/gpu/drm/meson/meson_encoder_dsi.h     |  12 +
 drivers/gpu/drm/meson/meson_vclk.c            |  47 +++
 drivers/gpu/drm/meson/meson_vclk.h            |   1 +
 drivers/gpu/drm/meson/meson_venc.c            | 230 ++++++++++-
 drivers/gpu/drm/meson/meson_venc.h            |   6 +
 drivers/gpu/drm/meson/meson_vpp.h             |   2 +
 14 files changed, 1092 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
 create mode 100644 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/meson/meson_dw_mipi_dsi.h
 create mode 100644 drivers/gpu/drm/meson/meson_encoder_dsi.c
 create mode 100644 drivers/gpu/drm/meson/meson_encoder_dsi.h

-- 
2.25.1

