Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39455EC58
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiF1STU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiF1STT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:19:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E79D1FCDE;
        Tue, 28 Jun 2022 11:19:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q6so27400524eji.13;
        Tue, 28 Jun 2022 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fdTohnwzks/gTkxccnd1jT0zw1DHsha+QDW1u2kKkLo=;
        b=bKrEuHKVX/T9khnYufknsufyxTdopR33A0CkGLP1+q3G7YT8eyC5M/+VcqlWvSw90U
         k/kYpAnpRK+yaebdy05geSxHq8E26j946H36BU8KhOHpN3+cMC4kqSaIribgkmIvAPgB
         4kygFDC/FtHjHNQWenWZPEVhecXmtmNmthPnXmiZ+aChe9AOs4j8VFhOVAUN5U33V5ID
         jI/Gs3lX+aU0OzWtvinC9JX/ydSe6N1angKPoxFl3a1YNebY67Kz7XKczh3+gBZXd0pu
         TJTg2M8yP2rI6Ptq7Z+uHT/yx5WCqHw0Q5c3+hhqqCf2G2i55JlFlzinPEL4O8AZOZ0w
         Oq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fdTohnwzks/gTkxccnd1jT0zw1DHsha+QDW1u2kKkLo=;
        b=2IFOb19JtF4MwxZnDMt0VHzrSJlHRRIyf7iBfG2macDE6GaxnOiAhU40F/iiOOw1vf
         8OFXaJG5vuU3eyRuuNmOKBpCsL6ELG/jXHmiHqLpm89WMutS9453zkHxIapHVFAvbXKa
         AztX5SkQG8qNiuLXrc4Kd02UFW9AEXIe2urRElDkf++j5Isa42I/MxyVg74ygDvbxBQy
         zB8xR32KxRviO/bMbJq55eAo1bAe8BFCrR6X55OGZJPsDV6/OFGhKlQxC50BwqwqJYFX
         WxOqCMtfHIdu87ENr2XY7ZbXr2ZzH4oXAdN634mUHWjpcA9S9uuQdKQQ2NenaRTXjSqQ
         LJ2A==
X-Gm-Message-State: AJIora8i62a+meW6UP4BSlVj0AyUMbMGcmqLFH+0Io93koL9mAbImhA1
        BrLQLeLzCVZIsRQ4j+Dq7NU=
X-Google-Smtp-Source: AGRyM1tgs9AjAF309iEPltATHnHr46WoxNMazKWNFtHavXP/MUJAmyJwOmaBx8NS1LDuvrmJIV48fw==
X-Received: by 2002:a17:906:8790:b0:722:e812:b26 with SMTP id za16-20020a170906879000b00722e8120b26mr20360040ejb.18.1656440356526;
        Tue, 28 Jun 2022 11:19:16 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm6730824ejd.196.2022.06.28.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:19:15 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Nikita Kiryanov <nikita@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] drm/panel: simple: add bus-format support for panel-dpi
Date:   Tue, 28 Jun 2022 20:18:34 +0200
Message-Id: <20220628181838.2031-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>


Commit 4a1d0dbc8332 ("drm/panel: simple: add panel-dpi support") added
support for defining a panel from device tree provided data.

However support for setting the bus format is missing, so that with
the current implementation a 'panel-dpi' panel can only be used
if the driver of the display interface connected can cope with a
missing bus_format.

This patch series defines the new property bus-format and adds it to
the panel-dpi implementation.

Check initial discussions [1] and [2].
[1] https://lore.kernel.org/all/20220201110717.3585-1-cniedermaier@dh-electronics.com/
[2] https://lore.kernel.org/all/20220222084723.14310-1-max.krummenacher@toradex.com/


Changes in v3:
- New commit to allow for additional port node properties
- Changed the V4L number space as suggested by Rob Herring
- Set constraints for bus-format as suggested by Rob Herring, used
  the range reserved for RGB formats.
- Editorial changes as suggested by Rob Herring
- Moved the bus-format property under the port/endpoint node as
  suggested by Rob Herring

Changes in v2:
- Fix errors found by dt_binding_check
- New commit allowing bus-format property for derived startek yaml
- Fix errors found by dt_binding_check

Max Krummenacher (4):
  dt-bindings: display: panel-common: allow for additional port node
    properties
  dt-bindings: display: add new bus-format property for panel-dpi
  dt-bindings: display: startek,startek-kd050c: allow bus-format
    property
  drm/panel: simple: add bus-format support for panel-dpi

 .../bindings/display/panel/panel-common.yaml  |  2 +-
 .../bindings/display/panel/panel-dpi.yaml     | 26 +++++++++-
 .../display/panel/startek,startek-kd050c.yaml |  1 +
 drivers/gpu/drm/panel/panel-simple.c          | 49 +++++++++++++++++++
 .../dt-bindings/display/dt-media-bus-format.h | 23 +++++++++
 5 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/display/dt-media-bus-format.h

-- 
2.20.1

