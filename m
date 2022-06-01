Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43E053A119
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351401AbiFAJqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351396AbiFAJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:46:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80296462
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:46:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so1546909pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fvYVrSCHuE1p50B2T8AG1mFSUMzRH35rYwVgN1pnAHY=;
        b=VFr+ClLg8bfhBtdYrCra7C+xLD2UYCMvTA/ZuyDiO8wD4ONPpbRBz3vXSv+5c9mvJV
         0KazDP7LcYct+M79b86+YFML//pqwhRdDnznoXtO+FLTA0sVmCu/tUuL7DIxaRN6V0li
         dlUGidNlzChRksOxsxfY7emIpz2VYfPjY1YGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fvYVrSCHuE1p50B2T8AG1mFSUMzRH35rYwVgN1pnAHY=;
        b=h5KynWbBsi52A2UFuE2SZkA5VR8c/yfcSQfW5mEUPeyBV1qD4YyQkb2+KSFegar4dV
         la2EM7oPGFGPkQsVP+SuKTKPW3cZZCVtGvywF9UnEWy6rZeiGCO2Vr5JBotuV8c8L4vx
         JWyTRG+UkEZv7nO+gG113khze9P+6qeJyuGY6EBGz9wtVK7XR9E4CW8Y+blDNBqdvbgx
         soHGanfdh5K1Ub6cVL7SNHwXxnLib5eT+AMJ+A72ztiFXf4YMQjgEflhOjfgDr7Ch3/D
         esnvjcWguX/icGWy/UhCiYNUPdkDJtsHAWEHn6I99sMYY0NfIy5BxJV6CTh9s3ptX+jp
         MLgw==
X-Gm-Message-State: AOAM531x2XndgfuP8L6KApA1MgdMxxIVL0pUAUeDRZGAZi8qCjOeGhjE
        wuR0H/8GflUxiUoR6M0IaYXwoQ==
X-Google-Smtp-Source: ABdhPJz/lyHkTPTNWf6r3FAfoIfyICC7is3wiA8+I+xC7MUGVd8BMu55GAC4KUIxaK9Y/TNtmKBDEw==
X-Received: by 2002:a17:902:ecc5:b0:164:1a5d:576f with SMTP id a5-20020a170902ecc500b001641a5d576fmr4541605plh.19.1654076804179;
        Wed, 01 Jun 2022 02:46:44 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a0018aa00b0050dc762815esm1039494pfh.56.2022.06.01.02.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 02:46:43 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Add a panel API to return panel orientation
Date:   Wed,  1 Jun 2022 17:46:29 +0800
Message-Id: <20220601094637.1200634-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panels usually call drm_connector_set_panel_orientation(), which is
later than drm/kms driver calling drm_dev_register(). This leads to a
WARN()[1].

The orientation property is known earlier. For example, some panels
parse the property through device tree during probe.

The series add a panel API drm_panel_get_orientation() for drm/kms
drivers. The drivers can use the API to get panel's orientation, so they
can call drm_connector_set_panel_orientation() before drm_dev_register().

Panel needs to implement .get_orientation callback to return the property.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/

Hsin-Yi Wang (8):
  drm/panel: Add an API drm_panel_get_orientation() to return panel
    orientation
  drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
  drm/panel: panel-edp: Implement .get_orientation callback
  drm/panel: lvds: Implement .get_orientation callback
  drm/panel: panel-simple: Implement .get_orientation callback
  drm/panel: ili9881c: Implement .get_orientation callback
  drm/panel: elida-kd35t133: Implement .get_orientation callback
  drm/mediatek: Config orientation property if panel provides it

 drivers/gpu/drm/drm_panel.c                    |  8 ++++++++
 drivers/gpu/drm/mediatek/mtk_dsi.c             | 10 ++++++++++
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c |  8 ++++++++
 drivers/gpu/drm/panel/panel-edp.c              |  8 ++++++++
 drivers/gpu/drm/panel/panel-elida-kd35t133.c   |  8 ++++++++
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c  |  8 ++++++++
 drivers/gpu/drm/panel/panel-lvds.c             |  8 ++++++++
 drivers/gpu/drm/panel/panel-simple.c           |  9 +++++++++
 include/drm/drm_panel.h                        | 10 ++++++++++
 9 files changed, 77 insertions(+)

-- 
2.36.1.255.ge46751e96f-goog

