Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C975444D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbiFIH1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiFIH1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:27:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8137B163F6D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:27:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso1097034pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1na78G+WYnf+bDU7BFeNQ72mHl3X9VY6UTeZz/scWws=;
        b=dxaeejukIjJiySX01gLIqKev5aQJJwNLrHV58fbo4DG9P6QF2p6Kji3n6hUcepaFLA
         usWl2HCL75kVDDyV2zNZwWPqAYwPV8uLnruCzinCg8fmJi0T+UlkAxbpspPelswch61n
         0FpgmZpv8zr9gt9LWaxwPY3/gnF2ll4Wy5y74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1na78G+WYnf+bDU7BFeNQ72mHl3X9VY6UTeZz/scWws=;
        b=OMQr/PhCn4kePhO+ByzQuSwSD7ek3w0qLWDPnNWcOv2PZwUXvq7QHaJIT6dczZmy3N
         V3viLHnlpEam/VM1Ss/mxMRFIbTlKBY9MDFhK4rPq3X1f8c6bFhZSsO8tUhrgjLCDpb1
         vZAo5nfU1sHDKT/L7V9ap+526fO9M3iOZ4enRYHy+uzUrdGA4CSh8vBq3m5mxqLGR52K
         VlL+LB5ZyqecufYYAwaSyyL9UbOoU0KAwI4fRuWTnPR5/jbbqeH3KBL7NV9h27XSHEE5
         SXjkvRJfftSvhG+mSJdgD/f55vpndSYihpao8P9To5zuRQfEyyYfDm2fBeNMJXyXW+l/
         H4/Q==
X-Gm-Message-State: AOAM531xAfz8yjnubWOJ/XOVtHdBUcJ7FrJn5LoAky43smtu6TI8yJWu
        J8lExsBkN/c1YGdT7wi2SQNbxA==
X-Google-Smtp-Source: ABdhPJweM0KK9iVhSZ8fBaZxUAiJUsiXSH2sG/EeYGjG+JHL8lvAGJbrav8zVhmsuoRbvr0UlIh0KQ==
X-Received: by 2002:a17:903:22cb:b0:167:992f:60c3 with SMTP id y11-20020a17090322cb00b00167992f60c3mr11306012plg.59.1654759655956;
        Thu, 09 Jun 2022 00:27:35 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5119:d95b:c6cd:77fb])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm15312221plb.276.2022.06.09.00.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:27:35 -0700 (PDT)
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
Subject: [PATCH v7 0/8] Add a panel API to set orientation properly
Date:   Thu,  9 Jun 2022 15:27:14 +0800
Message-Id: <20220609072722.3488207-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/gpu/drm/bridge/panel.c                | 34 +++++++++++++++++++
 drivers/gpu/drm/drm_bridge_connector.c        |  8 ++++-
 drivers/gpu/drm/drm_connector.c               | 31 +++++++++++++++++
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 12 +++++++
 drivers/gpu/drm/panel/panel-edp.c             | 13 ++++++-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  | 12 +++++++
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 12 +++++++
 drivers/gpu/drm/panel/panel-lvds.c            | 13 +++++++
 drivers/gpu/drm/panel/panel-simple.c          | 14 +++++++-
 include/drm/drm_bridge.h                      | 14 ++++++++
 include/drm/drm_connector.h                   |  4 +++
 include/drm/drm_panel.h                       |  9 +++++
 12 files changed, 173 insertions(+), 3 deletions(-)

-- 
2.36.1.255.ge46751e96f-goog

