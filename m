Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A048D542C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiFHKF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiFHKFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:05:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396CF179082
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:48:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i15so420174plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xoj6Y6vsBc6hOtaXqeaeGFoJW8FafEOdkg5HbhVP/pQ=;
        b=ID4FZPatRWu6aKxAGWULNw3AmgDv3Cu0P9obA2A1AwWJXmfD1b1bk4RFCLFLnxOJib
         MpCD28iv6vJrfnKfQ/hNC9AfC4h6piTj0FtXXRNEncuhiyBwMcsIC+uLHVEh+DBKUH9H
         g/XjIEptHyQJv3NBf4eiNQu5uy1eX43PcqjJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xoj6Y6vsBc6hOtaXqeaeGFoJW8FafEOdkg5HbhVP/pQ=;
        b=zgzuHCoppxOCzYIOz9XG47vWiCcTmHVdcEs0o0vJvspKw+xnpsyhr6Wsq3YAEyUZqP
         UimS3EyVh3PIw6SByFgCpd6QDRMPMFOYL6Hx99+rgyeasWw8OPnGmcCSBUJR6i4CFpHn
         flOjxkZSD0qJpdJuHD6dyrMhiLwJJ9gyMvYDGmpL7W2tNLVhqZouMPKz+jXD8Db6s41r
         b1+haPJ0FmIi3CDS6Q/8sDwN5V5PIYzoCZ0gXwIqx9jQDOXNzVhjGFhKnUOLJnClcVOa
         t12MO9V5O/wR7QVryRfLyTGww6JWCkolVNlAGNAbMfYs/j0usTHrEDgV+1vEbEL8x0px
         ePMQ==
X-Gm-Message-State: AOAM531APm6/WKYrEGwsS3WQmkD0X0IbCe+PHpya/jrN5q/AhreJsU4+
        xgspUMF3DQ8096Vg7abGzeLayQ==
X-Google-Smtp-Source: ABdhPJxPs9NcvxXZUKf1/v6rkHbKlBgtRBGn0bAl8jj+zewKhtrKaIRrG03sGONezyJrVcrnO9M6ZQ==
X-Received: by 2002:a17:902:bd83:b0:167:8dd5:6a5a with SMTP id q3-20020a170902bd8300b001678dd56a5amr9767295pls.114.1654681702602;
        Wed, 08 Jun 2022 02:48:22 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c46b:e7b1:f6c8:5eb8])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a950a00b001e28e80a8d6sm13584038pjo.38.2022.06.08.02.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:48:22 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] Add a panel API to set orientation properly
Date:   Wed,  8 Jun 2022 17:48:08 +0800
Message-Id: <20220608094816.2898692-1-hsinyi@chromium.org>
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

The series add a panel API drm_connector_set_orientation_from_panel()
for drm/kms drivers. The drivers can call the API to set panel's
orientation before drm_dev_register().

Panel needs to implement .get_orientation callback to return the property.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/20220530081910.3947168-2-hsinyi@chromium.org/

Hsin-Yi Wang (8):
  drm/panel: Add an API to allow drm to set orientation from panel
  drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
  drm/panel: panel-edp: Implement .get_orientation callback
  drm/panel: lvds: Implement .get_orientation callback
  drm/panel: panel-simple: Implement .get_orientation callback
  drm/panel: ili9881c: Implement .get_orientation callback
  drm/panel: elida-kd35t133: Implement .get_orientation callback
  drm: Config orientation property if panel provides it

 drivers/gpu/drm/bridge/panel.c                | 36 +++++++++++++++++++
 drivers/gpu/drm/drm_bridge_connector.c        |  8 ++++-
 drivers/gpu/drm/drm_connector.c               | 32 +++++++++++++++++
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 12 +++++++
 drivers/gpu/drm/panel/panel-edp.c             | 13 ++++++-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  | 12 +++++++
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 12 +++++++
 drivers/gpu/drm/panel/panel-lvds.c            | 13 +++++++
 drivers/gpu/drm/panel/panel-simple.c          | 14 +++++++-
 include/drm/drm_bridge.h                      |  3 ++
 include/drm/drm_connector.h                   |  4 +++
 include/drm/drm_panel.h                       |  9 +++++
 12 files changed, 165 insertions(+), 3 deletions(-)

-- 
2.36.1.255.ge46751e96f-goog

