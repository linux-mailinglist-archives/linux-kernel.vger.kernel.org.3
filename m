Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E645376BD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiE3IT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiE3ITX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:19:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ADE6CF5B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:19:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u18so3520814plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pBLLK5jVhwbNway5d1jcnH/mwgI9yxE1r2VmUrlYtDU=;
        b=LLgjKgp2+ro4rOIKxUWfMFimQjfxFWRvVWoMjpqWUvgtX/IIENmwdkMHUIq88hcolf
         ROFZ7vAAUlY+NJsshhvUkkommU11wX7sGxpjL1CjmCeZgVV/zkVhk3p7u/ZyNujeoi9J
         QxRXyXc9nqN8qIybleH4/7N9FDZp9fBXbaLPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pBLLK5jVhwbNway5d1jcnH/mwgI9yxE1r2VmUrlYtDU=;
        b=5xCbj0iGCYHiBtA5e4wlCuezMGzMinm676AFMFeFIptlVmMdj870XRp+8VSSb40UQ+
         YJBBTaFc5pCJvDWEQ+BRu6aDyFbKi3/ONCDawYq7rqSAaVE+L+mTg4xrvOmYCLtW0tv1
         4wo0lvI9tUiBbh6jLQmGiy5iheQxwEZgaboZbbCemyXHX7Dk3HKjlJXU+Y/AcPEuBSXV
         Yx2Rs7E5XQSfm7JkEgzGSUTng/Oy4x6cl2OZszpxC9pUwHSUighsLuq7IDfIZKXhPZZo
         MgRR/GtXGuVRx2iopny+9UXJXB3QklIy/fWrYpyPUqf1fqncwIV+5NEfjKJmxMipbzBw
         miBw==
X-Gm-Message-State: AOAM530QpntOfLa55t+FxHEh9r7luJ89yfJW/bMUbr7kfkY7W9XecXTk
        PrrWVhY9Lz933uEYq2ISHG0VKw==
X-Google-Smtp-Source: ABdhPJz+H5PQ1/wn0WMWpccN62eOSMQ6CsdGl2YYPW6OhEKjBgqYnlaum+TZJlp8G3W0bq500UZXIw==
X-Received: by 2002:a17:903:124a:b0:154:c860:6d52 with SMTP id u10-20020a170903124a00b00154c8606d52mr55869147plh.159.1653898761542;
        Mon, 30 May 2022 01:19:21 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ae1c:3d63:abec:1097])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902f64100b001618b70dcc9sm8537900plg.101.2022.05.30.01.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:19:21 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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
Subject: [PATCH v10 0/4] Separate panel orientation property creating and value setting
Date:   Mon, 30 May 2022 16:19:06 +0800
Message-Id: <20220530081910.3947168-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
before. It won't affect existing callers of
drm_connector_set_panel_orientation(). The only difference is that
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
2.36.1.124.g0e6072fb45-goog

