Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08623539F25
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346586AbiFAISj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiFAISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:18:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABE624F07
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:18:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so1374803pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GemiEwLCjqeqzreRXrlIOTn/YyLsal6nhhhXl7NXlqk=;
        b=fUCScFzCpuzwgyHn7xrFQ7LGQY1FA++dCWMbhVb83r3eKHVpLa283g3v7wU3WUEKzm
         JGCGzFjgej+HQwWcdTNenFSje7ses1XT25cOmGt+ACU0UKCpvDLhllWBp1y2kuWuZGLT
         jy0QT+usJUmu/D0p+bU7o518zh0ElhfJMicpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GemiEwLCjqeqzreRXrlIOTn/YyLsal6nhhhXl7NXlqk=;
        b=W4Vn6SH1c5hnjdbaO+8cTr4g3V3Y97FAb8ByPTQqYbTen4W6MdmML47B5rgBw+f5Lv
         6dK4O7DFjMttoAD7Zny9Cdbu3S5Z0JB8OjLfcLdmwyIa4d2LuuqRypZlHRKXnBDErOA5
         3/CkkMNi6UejJ6SOvH65CRJNcbCEzaChIZHZQF2Zuhq7rn1Oc02tQL/hdHTdoOoie7I9
         xRUXcyxW8K+uMK2hBYM8AKA6VFpyJbAANeOSHqB/KhIg+xDORmPbl+AIia5drfuXbN9J
         0KJ+0IDubSKWhAjRRrq14okm2VjRA27K6QOGOBVXCHxcXv77DntjxaWYEXZ08OT6gMfs
         1gKQ==
X-Gm-Message-State: AOAM532AeG5IrSpJXC++Tanp/xqq3rn15HKit97deuR1sNJdNW3w6/8K
        71ZKtBhGTHAYPVAg1jvS6QgJ5A==
X-Google-Smtp-Source: ABdhPJyLFVUlLgJ+84lYTY5lEbCVVe3v3IQgMn9ywuY3YaByw8oDrtX0EITnzMoe+Ibd0yBMOKH7fA==
X-Received: by 2002:a17:902:a705:b0:156:9cc5:1d6f with SMTP id w5-20020a170902a70500b001569cc51d6fmr64614112plq.66.1654071510782;
        Wed, 01 Jun 2022 01:18:30 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b0050dc7628182sm824680pfo.92.2022.06.01.01.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:18:30 -0700 (PDT)
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
Subject: [PATCH 0/8] Add a panel API to return panel orientation
Date:   Wed,  1 Jun 2022 16:18:15 +0800
Message-Id: <20220601081823.1038797-1-hsinyi@chromium.org>
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
 drivers/gpu/drm/mediatek/mtk_dsi.c             | 14 ++++++++++++++
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c |  8 ++++++++
 drivers/gpu/drm/panel/panel-edp.c              |  8 ++++++++
 drivers/gpu/drm/panel/panel-elida-kd35t133.c   |  8 ++++++++
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c  |  8 ++++++++
 drivers/gpu/drm/panel/panel-lvds.c             |  8 ++++++++
 drivers/gpu/drm/panel/panel-simple.c           |  9 +++++++++
 include/drm/drm_panel.h                        | 10 ++++++++++
 9 files changed, 81 insertions(+)

-- 
2.36.1.255.ge46751e96f-goog

