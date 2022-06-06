Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B355453EB31
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbiFFPYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbiFFPYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:24:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F328F2B7B43
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:24:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j7so13070947pjn.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nCKSgi5ghJh488few+daxz3n+frldGQMli1tF7tyziw=;
        b=Ly/cjxqyjPT9IndQDQLYI+ZjtL8lWCrmZudRv3GvHr7KjYTv4MVJzC8F4KqzUH1WZI
         ctE8rDupsFcURmpqMWiF944tW2wc65OHIXrkmqNN1RblfZ5SXZrHEPuXa7lrzgx0btu8
         +bCBc0Pcrtiwv8frSSD330az/t2Dp7qQy0uMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nCKSgi5ghJh488few+daxz3n+frldGQMli1tF7tyziw=;
        b=W5J6ERyFfxqlHjwI01qG+HQKfsNpJHAo9AGdIUuLY4qK0XARMn8EmwPXHCj/Al8q20
         nS/BwfrCb7PQU9cvA4wbrC+HQwi35AhnJOnLVVymUG1ahFvxft2ySQFBMrlKkzHSA29m
         u5tq/hPbDEyI9IYkGsT1BP198mZNH9SeTYDyB5DqSLPNCXnKPjAv2Sdp3JPiYQ1w3yu7
         cxyF7Grkb19ClcQnuA+cVpYu0dgS0fefLdJiVGK7LyXuha2w4uHHyppms2B0YV10H9Zu
         Z1pG/iCS2DuIDH0AzM5RYROONCW4Vdge7bewchnx1WaZ0HwjeqlT0kpf3ToErakbXitz
         CeoA==
X-Gm-Message-State: AOAM53026xuLZ1VESxn0aUdE56YO1U1Zc7PxTqtlo/b3b1z754c/ViMn
        Mmfp10ms/Nt/BVv8rHsb9rEJmw==
X-Google-Smtp-Source: ABdhPJx/j2miMgCNt4Lz+zNAOBFsU+ps9maigyn2E1oMZ0cj6Y7pMkdlNEf4FN7+jd1e8jQNIgqnrw==
X-Received: by 2002:a17:90b:33c4:b0:1e8:6e2f:97a2 with SMTP id lk4-20020a17090b33c400b001e86e2f97a2mr10110935pjb.165.1654529077457;
        Mon, 06 Jun 2022 08:24:37 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0a:5e4:e24:c8c4])
        by smtp.gmail.com with ESMTPSA id h1-20020a655181000000b003fbaae74971sm10749306pgq.72.2022.06.06.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:24:37 -0700 (PDT)
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
Subject: [PATCH v4 0/8] Add a panel API to return panel orientation
Date:   Mon,  6 Jun 2022 23:24:23 +0800
Message-Id: <20220606152431.1889185-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
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

 drivers/gpu/drm/drm_panel.c                    |  9 +++++++++
 drivers/gpu/drm/mediatek/mtk_dsi.c             | 10 ++++++++++
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 14 ++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c              | 15 ++++++++++++++-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c   | 14 ++++++++++++++
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c  | 14 ++++++++++++++
 drivers/gpu/drm/panel/panel-lvds.c             | 15 +++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c           | 16 +++++++++++++++-
 include/drm/drm_panel.h                        | 10 ++++++++++
 9 files changed, 115 insertions(+), 2 deletions(-)

-- 
2.36.1.255.ge46751e96f-goog

