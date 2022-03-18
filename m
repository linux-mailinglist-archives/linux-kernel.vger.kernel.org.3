Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394704DD61F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiCRIac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiCRIa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:30:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7BE1DFDCE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:29:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e13so6472119plh.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZerwMZnU5WRGenUWw/mrV6k1v4q9EhMydhshaosUPPY=;
        b=T2JR3/lfNpGKK7qASyH6+wW97BBOWNrh7oRmcfnmWSqfgDCBAwtyhw6+z45yNahIVS
         eT7DsjSjEvXTznTI7qXdOGBWQS7eFEssrIgW0IBCHbilYllZhz4kW2weUObdWIu+O4X8
         KFf9ujVOZylaa3ymqWZq66ufRx7SrPJ6hbHD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZerwMZnU5WRGenUWw/mrV6k1v4q9EhMydhshaosUPPY=;
        b=UR4jPhBusc6tlwq4NWpcU2Eg99ibBDMFjDWbXO4yUWlKS1kBTIeYmmnzQhVjKL309s
         bg4Bvj/NlzpGJdde6pvNsvoHyaRq7Mu5BMvRklLMAlz72LYBv5wYF9sRC9NEq4saj7Ch
         wigy1zT9dUxX9rgjxoTpL/yrkhtPHQP89lGmj0S/KXviuryrqT+JV8Kw4DX6DVQeJ1A9
         IdDA3cwFHoHVuprUjMiFnceb0Duu1Q9AukcMCuuXNxkAx720N7FSYQcT0+iFLUTi3X/Y
         SafuJzCBGlWNDIrAY6xRJmWyX16la8a+u1V7R0X5z7+XVPKJWh2ZH0zdWTbDFAyUkhJ8
         XdvA==
X-Gm-Message-State: AOAM532exyUAxA6t5YBhqEH8TQ5vDavq+TqffM/Ie+SPTmF6uF0CuJwG
        Ej181qEFdnDslkuWJ17mZpE4gw==
X-Google-Smtp-Source: ABdhPJxSlFaBTNqCJx14g1bDgmJ+YaO+Pg4LlRrGaMoIJ9J2tXiqSbojTVGwkQAUer85nUyOr+wzKQ==
X-Received: by 2002:a17:90a:ba10:b0:1bf:6900:2c5d with SMTP id s16-20020a17090aba1000b001bf69002c5dmr20601000pjr.36.1647592151148;
        Fri, 18 Mar 2022 01:29:11 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:435a:ce78:7223:1e88])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00084200b004f761a7287dsm9404044pfk.131.2022.03.18.01.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 01:29:10 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Simon Ser <contact@emersion.fr>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v9 0/4] Separate panel orientation property creating and value setting
Date:   Fri, 18 Mar 2022 15:48:21 +0800
Message-Id: <20220318074825.3359978-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers, eg. mtk_drm and msm_drm, rely on the panel to set the
orientation. Panel calls drm_connector_set_panel_orientation() to create
orientation property and sets the value. However, connector properties
can't be created after drm_dev_register() is called. The goal is to
separate the orientation property creation, so drm drivers can create it
earlier before drm_dev_register().

After this series, drm_connector_set_panel_orientation() works like
before, so it won't affect other drm drivers. The only difference is that
some drm drivers can call drm_connector_init_panel_orientation_property()
earlier.

Hsin-Yi Wang (4):
  gpu: drm: separate panel orientation property creating and value
    setting
  drm/mediatek: init panel orientation property
  drm/msm: init panel orientation property
  arm64: dts: mt8183: Add panel rotation

 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  1 +
 drivers/gpu/drm/drm_connector.c               | 58 ++++++++++++++-----
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  7 +++
 drivers/gpu/drm/msm/dsi/dsi_manager.c         |  4 ++
 include/drm/drm_connector.h                   |  2 +
 5 files changed, 59 insertions(+), 13 deletions(-)

-- 
2.35.1.894.gb6a874cedc-goog

