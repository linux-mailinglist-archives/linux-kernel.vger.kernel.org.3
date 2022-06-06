Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E533053E0EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiFFFGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiFFFGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:06:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19214926F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 21:47:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w3so11202948plp.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 21:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V48jIpUPpkwi/mXw0vV1qlo/0R+nh6UqO3bUzG0QHns=;
        b=nqQSjOvanX+8t+tfNQWjxQaFfRS/+GiSKg6PgDaC+vs0EtY834wW/8lUSx+MIh6+66
         QxSZBzAa72S8ewu9/W+7na7Kc7k0dqpizfCf/j+3vNxRtbDBwkBlrf52exTYP/uHo+77
         Ssb8uKKBEcUSKuPtsbTbCH81UkVrmiSnDCncw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V48jIpUPpkwi/mXw0vV1qlo/0R+nh6UqO3bUzG0QHns=;
        b=osgjjDtzqwm1m+uzs2/hUujR1OMwwU+HO+ZwJZiFvMx758GdXCqEGypJlUpZTiVyNB
         pjVGKBek32adTjHS+FnPfnHCaEeLhD4+c347djIlGBMS8hYbBdgY31IGCnPpnfWjL83K
         tT220NK7c+4vYwXUv4Ynt2Bf0iezIeAelpV1h9aZ8wVqVFomkEL5K0kBquXXglufCfqE
         AeOd2TP66AY0dtsqiv0AQSnR7DsSiiS75tJm+c1ku60JyAs/mAG92yayP3oXk0HjgZ1x
         0Madfq9bN7AHclKq+n51R51J17JpLZuFvh8XpSHLNgzt+Z+Eo0CQEP03x8Vp5TpwmV1c
         DSgw==
X-Gm-Message-State: AOAM533EDsl+mNLISjTLBRRShqP+g77WeYJA14fhZNiD+94BYmbTfKLx
        A3nHmbwxeGA5rwf5IwDbU+JYlg==
X-Google-Smtp-Source: ABdhPJwNc9WTpHKy7nu/+3cTPEdExZl8996ly7Ju/bCZ1Rjy5dZNznjIR0+wzUFpxhRy9BhxaOu5oQ==
X-Received: by 2002:a17:90a:c002:b0:1d9:250a:73c8 with SMTP id p2-20020a17090ac00200b001d9250a73c8mr24459800pjt.133.1654490847065;
        Sun, 05 Jun 2022 21:47:27 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ced3:b110:401b:b32c])
        by smtp.gmail.com with ESMTPSA id t190-20020a6381c7000000b003db7de758besm9718609pgd.5.2022.06.05.21.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 21:47:26 -0700 (PDT)
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
Subject: [PATCH v3 0/8] Add a panel API to return panel orientation
Date:   Mon,  6 Jun 2022 12:47:12 +0800
Message-Id: <20220606044720.945964-1-hsinyi@chromium.org>
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

 drivers/gpu/drm/drm_panel.c                    |  8 ++++++++
 drivers/gpu/drm/mediatek/mtk_dsi.c             | 10 ++++++++++
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 14 ++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c              | 15 ++++++++++++++-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c   | 14 ++++++++++++++
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c  | 14 ++++++++++++++
 drivers/gpu/drm/panel/panel-lvds.c             | 14 ++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c           | 16 +++++++++++++++-
 include/drm/drm_panel.h                        | 10 ++++++++++
 9 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.36.1.255.ge46751e96f-goog

