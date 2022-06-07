Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C27541F12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382160AbiFGWjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379141AbiFGVZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:25:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E60A150B7B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:01:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n8so15615164plh.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XlC5WhPEtlChZIl+n5BBhBXh04p3vnO18/6gEyRk/7I=;
        b=aiEoUfInXs6muqWe9eAFyYvM/XQRsycTnGNXLPtV5k6vx6lf9JLcKGqq5Qnluowoaj
         z4Wl1unEUXEkk8niQrnFc5kvsyfgbdRvPcRZtypHElhb1b+AmCNk3ZVDHDXvgObfm7Uy
         eKNnzoJvWvkExKgTkl65s6gsf+sxZl7wd9uc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XlC5WhPEtlChZIl+n5BBhBXh04p3vnO18/6gEyRk/7I=;
        b=bTNjKqFT+f7jddMJrKQakCCvURLM86zaNtfinybYS1CTfHhz1rzHR34DExVkcU3azl
         IUJZLvKDBzGSguiXgsoLuCmqLHQmMxugd0HNO78oLIH8EGrVHOhDpb4NzkeJTNKP4UMf
         oYNRHN7p3hy39mOaC5yQk2U/0Ou6ULNgWbaBKQ9pLZQ1BB9jDLHT9qBO8+GE1Wq8FOA5
         Twosna2L1kxNlATt6CyBLe+QzWWMbCOLTYSSIyE1bBUHYf63+LarthKLzlQG92YGVNz/
         GDzZghXJze7B6nM0KtToEm1Z5zPmFZxwtci7N46r4jBo5xTcgI6GRBeUuuifzehEg0QV
         Vg9g==
X-Gm-Message-State: AOAM533LEGiSnz3hLKqNc5fmPRgLKos30H03m7MfxvOLgfgYJGn5Yl2K
        ndVPfSt7Ho+xxGfdp+FyEMal7/Xl2kHR1Q==
X-Google-Smtp-Source: ABdhPJys+qHC9VhA3c9fwXaPhk0EIhEKcRgheZtI7KEsqbNQpujN5/HXjl1x4+YKKseCyyA6hK7pOg==
X-Received: by 2002:a17:90a:2c0c:b0:1ea:14c0:f0ca with SMTP id m12-20020a17090a2c0c00b001ea14c0f0camr2481026pjd.143.1654628501156;
        Tue, 07 Jun 2022 12:01:41 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g29-20020aa79ddd000000b0050dc762819esm13236084pfq.120.2022.06.07.12.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:01:40 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Pin-Yen Lin <treapking@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH 0/7] usb: typec: Introduce typec-switch binding
Date:   Tue,  7 Jun 2022 19:00:17 +0000
Message-Id: <20220607190131.1647511-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a binding for Type-C data lane switches. These
control the routing and operating modes of USB Type-C data lanes based
on the PD messaging from the Type-C port driver regarding connected peripherals.

The first patch introduces a change to the Type-C mux class mode-switch
matching code, while the second adds a config guard to a Type-C header.
The next couple of patches introduce the new "typec-switch" binding as
well as one user of it (the ANX7625 drm bridge).

The remaining patches add functionality to the anx7625 driver to
register the mode-switches, as well as program its crosspoint
switch depending on which Type-C port has a DisplayPort (DP) peripheral
connected to it.

Pin-Yen Lin (1):
  drm/bridge: anx7625: Add typec_mux_set callback function

Prashant Malani (6):
  usb: typec: mux: Allow muxes to specify mode-switch
  usb: typec: mux: Add CONFIG guards for functions
  dt-bindings: usb: Add Type-C switch binding
  dt-bindings: drm/bridge: anx7625: Add mode-switch support
  drm/bridge: anx7625: Register number of Type C switches
  drm/bridge: anx7625: Register Type-C mode switches

 .../display/bridge/analogix,anx7625.yaml      |  56 +++++++
 .../devicetree/bindings/usb/typec-switch.yaml |  76 +++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.c     | 151 ++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h     |  20 +++
 drivers/usb/typec/mux.c                       |   8 +-
 include/linux/usb/typec_mux.h                 |  38 +++++
 6 files changed, 347 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml

-- 
2.36.1.255.ge46751e96f-goog

