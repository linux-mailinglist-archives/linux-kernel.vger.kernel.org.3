Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48545453C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiFISLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiFISLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:11:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA643AD8BE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:11:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e24so22075186pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5EoYi45ZBUgcYzH5QmcJabRI+K9dAvb3lNExbNzDTc=;
        b=IRBv/Csm/7toLZfIoXEPX0E45ay4Enl4+enzXX7DKTkX5nUg1cRxZOi2qv4NePVtAg
         VoHy+EUE1WpiNMTX9FhRf/mrnjfYQPaESFmpZVcbJGR4OGpEFAlKDDengyMyRxJYaCqe
         7Zb9IVzTdblW1xpdWU5oA4UNZms7szwAcKGXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5EoYi45ZBUgcYzH5QmcJabRI+K9dAvb3lNExbNzDTc=;
        b=oSckdqZ8nOqkLrkNts5Njcz/5xievo4FOZrGw6pwlxudYB8AKBMSfYbThsFP7mrngB
         bZtRDkjV55I7SNFRq1PMZmGJ9AYAqTnZo02VsyqNd1S1moMufqnxO1tgYbOi+gE8t4Po
         nwZH6IGG3YFwrQZ6fZzS5KZLF6cx1gKn5SddkpUSW4SPmWk3A0waxikfZcjkqAqgtk72
         WWznJcVE84dRZI/0G5fBTXj4oDAelGxVb/mwbcipXNsqY0pEFcL7rOFvm9d7h4QR/ECa
         joUDYFKKm9Kcr5KBKL8mWeP+FtPRSPaQ3EzYhTx1b6s6f11Z02dLhvWm8l3RPx0sX8g/
         J8zw==
X-Gm-Message-State: AOAM531KRtwbtLtodjVvmjZqvzbAnoBtywV1hWR2fVNk65GRrovmNLiK
        lqOz7LBqNVO+KKNoJ9A27xu+64hshvdIcQ==
X-Google-Smtp-Source: ABdhPJxbvQFA24STYjSmsFQeh34YR6aLuV8nQK5wlXXW3CPcVjhZjHvmK6qgZXTrZwPj8dZKeSjFjQ==
X-Received: by 2002:a17:902:7248:b0:167:95e2:f83c with SMTP id c8-20020a170902724800b0016795e2f83cmr14304302pll.74.1654798297569;
        Thu, 09 Jun 2022 11:11:37 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r14-20020a63ec4e000000b003fb0354c43asm17728049pgj.32.2022.06.09.11.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 11:11:36 -0700 (PDT)
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
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Subject: [PATCH v2 0/7] usb: typec: Introduce typec-switch binding
Date:   Thu,  9 Jun 2022 18:09:39 +0000
Message-Id: <20220609181106.3695103-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a binding for Type-C data lane switches. These
control the routing and operating modes of USB Type-C data lanes based
on the PD messaging from the Type-C port driver regarding connected
peripherals.

The first patch introduces a change to the Type-C mux class mode-switch
matching code, while the second adds a config guard to a Type-C header.
The next couple of patches introduce the new "typec-switch" binding as
well as one user of it (the ANX7625 drm bridge).

The remaining patches add functionality to the anx7625 driver to
register the mode-switches, as well as program its crosspoint
switch depending on which Type-C port has a DisplayPort (DP) peripheral
connected to it.

v1: https://lore.kernel.org/linux-usb/20220607190131.1647511-1-pmalani@chromium.org/

Changes since v1:
- Fixed function signature error in "else case" of typec_mux.h
- typec-switch.yaml: Fixed indentation, compatible, and node names in examples.
- anx7625.yaml:
    + Introduced patternProperties for "switch" children (suggested by Krzysztof Kozlowski).
    + Added unevaluatedProperties descriptor (suggested by Krzysztof Kozlowski).
    + Added "address-cells" and "size-cells" properties to "switches".

Pin-Yen Lin (1):
  drm/bridge: anx7625: Add typec_mux_set callback function

Prashant Malani (6):
  usb: typec: mux: Allow muxes to specify mode-switch
  usb: typec: mux: Add CONFIG guards for functions
  dt-bindings: usb: Add Type-C switch binding
  dt-bindings: drm/bridge: anx7625: Add mode-switch support
  drm/bridge: anx7625: Register number of Type C switches
  drm/bridge: anx7625: Register Type-C mode switches

 .../display/bridge/analogix,anx7625.yaml      |  63 ++++++++
 .../devicetree/bindings/usb/typec-switch.yaml |  74 +++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.c     | 151 ++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h     |  20 +++
 drivers/usb/typec/mux.c                       |   8 +-
 include/linux/usb/typec_mux.h                 |  38 +++++
 6 files changed, 352 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml

-- 
2.36.1.476.g0c4daa206d-goog

