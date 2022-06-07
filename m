Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7EA53F903
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiFGJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbiFGJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:05:57 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D00D2469
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:05:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s68so15269507pgs.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4LE7zrySWEA9gMurfRvYyAHVJx1m9VkHmbAjloR5rc=;
        b=OSmFZAqcOBYpVk9PtT//wYdshGIbZFqLmNvinrT7LM2bplu1QaPw+SAh9TblfHTm81
         tHtOg9TZdOLiWycsapflLUGU+qZw0lGKzsP2SvF0Sru6lkn3VoC4KdThYPVwFRvsn7IC
         DSxoneUuol+XxCC8sHbzH+zHV1oF13gvUW5o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4LE7zrySWEA9gMurfRvYyAHVJx1m9VkHmbAjloR5rc=;
        b=lOQ0qq6eY2SaI8VDmRuQaV4FedXgyHbOQmvjsawKtj7blvePCYbyoxsEO1PDTzZfty
         AP1mJXz1mKk/Hw3Y6aQAnLxJiZyCGFRMrkRcvVYH93tDXO3ClcXZ2lE5SjGfaIbpHf2s
         4bSc0LskJH1X3PwrnvLxEa/y04m5aNurU1UmbrIkG1j7HPX4PhATlXxlNaoMsnZDo5A/
         gU6w36CIqcefq+hPwEXOG/6vyhcN0TXfpIhez9X4gtkBT/BG87wT4kcH6+J7462Y/2wT
         5INNktKTFchwFTGII1hEYXCo5nIeYwdGYtom+sIdlRqC3iQiJQ5NVL8L3z19VB8VqBMH
         Z7tw==
X-Gm-Message-State: AOAM531/Tj6I3o16NVXCnoF44Tq+uvfFj+t37IKxPCDODHenChGSgWlB
        +Li2TvDMg0CJDnKpMudO4RE/K5PhlluDeQ==
X-Google-Smtp-Source: ABdhPJw1n+xUkdGWbXx1cahLihtS+UTJFd1fPnlTaE3+N4brLzLb0z8zg/XQOnqI8aeTH/v2v9Cp7g==
X-Received: by 2002:a05:6a00:244a:b0:4fa:ebf9:75de with SMTP id d10-20020a056a00244a00b004faebf975demr28675288pfj.73.1654592755183;
        Tue, 07 Jun 2022 02:05:55 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:40b7:55ce:10ee:c7a0])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7947b000000b0051c0fe8fb8csm4507010pfq.95.2022.06.07.02.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:05:54 -0700 (PDT)
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
Subject: [PATCH v5 0/8] Add a panel API to set orientation properly
Date:   Tue,  7 Jun 2022 17:05:41 +0800
Message-Id: <20220607090549.2345795-1-hsinyi@chromium.org>
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

v4 of this series is "Add a panel API to return panel orientation":
https://lore.kernel.org/lkml/20220606152431.1889185-1-hsinyi@chromium.org/

Hsin-Yi Wang (8):
  drm/panel: Add an API to allow drm to set orientation from panel
  drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
  drm/panel: panel-edp: Implement .get_orientation callback
  drm/panel: lvds: Implement .get_orientation callback
  drm/panel: panel-simple: Implement .get_orientation callback
  drm/panel: ili9881c: Implement .get_orientation callback
  drm/panel: elida-kd35t133: Implement .get_orientation callback
  drm/mediatek: Config orientation property if panel provides it

 drivers/gpu/drm/drm_connector.c               | 32 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dsi.c            | 15 +++++++++
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 12 +++++++
 drivers/gpu/drm/panel/panel-edp.c             | 13 +++++++-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  | 12 +++++++
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 12 +++++++
 drivers/gpu/drm/panel/panel-lvds.c            | 13 ++++++++
 drivers/gpu/drm/panel/panel-simple.c          | 14 +++++++-
 include/drm/drm_connector.h                   |  4 +++
 include/drm/drm_panel.h                       |  9 ++++++
 10 files changed, 134 insertions(+), 2 deletions(-)

-- 
2.36.1.255.ge46751e96f-goog

