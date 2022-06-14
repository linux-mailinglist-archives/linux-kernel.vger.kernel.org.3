Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B654BAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiFNTh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242518AbiFNTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:37:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7DDB3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:37:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so8127184pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=erLQaoKxuSkbFQJCjbArAz2RxzePc18ZCmvI1Acodfc=;
        b=gwIcxv2ZkrWiyyqqxUQ7BYU2iMzh2Uu7SS53hpOqXO+sktoOoE+UkDlBhB8ZJwsSUB
         mkBhtWeYa2JVH/gboOnzRM4Q0vII1mtJB4WecYIkN2OiabC2GFxNm4XwnizW10A/7z5i
         jKgh688hQYwK43Eqf4vfvqcdJ74D4OUggEpk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=erLQaoKxuSkbFQJCjbArAz2RxzePc18ZCmvI1Acodfc=;
        b=5WS5MZaH1NImkeqtWvkch/Oxj9yV5UPRbL11hDTVmIQVrUkBpJ5iF9yo/1bv2jqihJ
         T8rrhX23Xv8/cKl5K5VTeHbTjua5yk+aEJVmP1HJCZ0gA0FCGFrpfPWKN/4byUXFB0Ny
         DfvyyhzuQhXcNiM/74QZyWYHiGC4eoB9q5gCZ3MePnwZvq4M5YOLnVgFcTYW9BBXyKxm
         8j4GwNZAK6dBx0ptMTmvfdps/OMMp4J2tp68EOsjTtyZ1Fbym5F/ZOKaDhYqt4thL2na
         PAMXnJL2nSb19xmV3p78biYVb2kHbbvj5u1OofFHM2IS4mcw2Fr2fFFGeeyAeEp8jVnz
         gMsA==
X-Gm-Message-State: AJIora8vOs9O8WGUWIUgH/m5hTbrL91UW+rUQznIN2MxVTVsPZViaO3y
        9mSJZ8ujn0GK2cOuIyUWDOyf0ZkJrwv1Ow==
X-Google-Smtp-Source: AGRyM1ukACZsX6LKO6byQRo8pQtL1aqEYoysh1VxyBeJSKBmpasYdaf/LeSYWsTIrWoKhqaEP7m2Mw==
X-Received: by 2002:a17:902:ef8f:b0:163:d61b:ec98 with SMTP id iz15-20020a170902ef8f00b00163d61bec98mr5759584plb.111.1655235444069;
        Tue, 14 Jun 2022 12:37:24 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090a409500b001df3a251cc2sm10014426pjg.4.2022.06.14.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:37:23 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, swboyd@chromium.org,
        heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
Subject: [PATCH v3 0/7] usb: typec: Introduce typec-switch binding
Date:   Tue, 14 Jun 2022 19:34:34 +0000
Message-Id: <20220614193558.1163205-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

v2: https://lore.kernel.org/linux-usb/20220609181106.3695103-1-pmalani@chromium.org/

Changes since v2:
- Addressed review comments in typec_mux.h
- Changed error print to only print when a device is actually listed in
  DT.
- Moved num_typec_switches check to beginning of function.
- Picked up Reviewed-by and Tested-by tags from v2.

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
 drivers/gpu/drm/bridge/analogix/anx7625.c     | 148 ++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h     |  20 +++
 drivers/usb/typec/mux.c                       |   8 +-
 include/linux/usb/typec_mux.h                 |  44 +++++-
 6 files changed, 349 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/typec-switch.yaml

-- 
2.36.1.476.g0c4daa206d-goog

