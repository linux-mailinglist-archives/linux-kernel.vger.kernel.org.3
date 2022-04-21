Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259C550A69C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390543AbiDURK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbiDURKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:10:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA240905;
        Thu, 21 Apr 2022 10:07:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c10so7613088wrb.1;
        Thu, 21 Apr 2022 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOsXpLWi9QLA5ykkzo2aKVd+yr4+GMP+CHJv0QHqFPU=;
        b=PhOXgh0Q5LE7m9gF9czIrKZRq55dBYQfo6JFtQeE9ijzQGIxBM1V5QZtkJjgUAPcva
         mijV+yVjCD1Y5vzy+S/9QeUO9MiLfeuJRoGQ20nYs5NNhxoMqORFTDdKMo8HmDzrMzo9
         q8voQxoIddhVNAF6gBbxgGFWo3cmsBYPJCeEq5oSHPHkD51e69O6TQt3OmbCXV13dl3x
         1nmhxU/KIU992jK2iLSLd01VSlI71j+KQOLtbEiSIGTgDUEOSG4tqwDOFLyrLtkcvG5s
         D3ssv0r5pDlrF6bXeXPICXsORkR4XZl7J1mLagy+RZiY5nXL4U+gkRy6RvMQllEHIZV5
         tHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOsXpLWi9QLA5ykkzo2aKVd+yr4+GMP+CHJv0QHqFPU=;
        b=jher6b8QeqKyytWJ1dfAQW/UqkC1RyLCYp7oCZWB+tlzPscE+ZPspTH6JtVUlHxjhJ
         5VpqQfvoAy9PtQS3XlkJWBlMYPAisw/Afqe2l0tHg+8y0HBQSk+x3idmRNAptrBGs3qq
         ouVh1XSoXWM4i3r6PPC5K7FdtYZDZxAP3+m4yL4/flBtewZcXx7IDIy0MieLp6/6AlCj
         xZCP+wiC17PVTej2Ov1kRNnJGxdtzX6JUx9EMoRsl2ak9X/B9u3rGH15A0judhq/6hmC
         0YzYx0LOQ7C2Uk4EnzGAejX/HaVTGiCQE97p2+3YcfS7inDeTEtYlp27JlDOsT0eOyME
         GwTg==
X-Gm-Message-State: AOAM532Mq6K0n+jmwE7xeTdHk+ZxO9MNh+cqhg3DksX6Vz9KX0lEaAEA
        wBuFWD9YclmzoIMnJ/6zdE8=
X-Google-Smtp-Source: ABdhPJwmkd8rSG5wIeasQSmzXw1Hxgzf6My3j9pRLVWS50GQVQrvimreO3rNSOKpZuUsPU9r5kjkvw==
X-Received: by 2002:a5d:45c5:0:b0:20a:be8f:aca6 with SMTP id b5-20020a5d45c5000000b0020abe8faca6mr513028wrs.493.1650560852175;
        Thu, 21 Apr 2022 10:07:32 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm2963849wrf.10.2022.04.21.10.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:07:31 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     inki.dae@samsung.com
Cc:     jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@linux.ie, daniel@ffwll.ch,
        krzk@kernel.org, alim.akhtar@samsung.com, lgirdwood@gmail.com,
        broonie@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hjc@rock-chips.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, alain.volmat@foss.st.com,
        p.zabel@pengutronix.de, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-sunxi@lists.linux.dev, laurent.pinchart@ideasonboard.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 0/5] Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi
Date:   Thu, 21 Apr 2022 19:07:20 +0200
Message-Id: <20220421170725.903361-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

After implementing a similar change in the VC4 driver [1], as suggested
by Laurent in the ToDo list [2], I noticed that a similar pattern is
used in the Exynos, Rockchip, STI and sun4i drivers.

This patchset replaces drm_detect_hdmi_monitor() with is_hdmi in the
mentioned drivers.

Best wishes,
José Expósito

[1] https://lore.kernel.org/dri-devel/20220420114500.187664-1-jose.exposito89@gmail.com/T/
[2] https://docs.kernel.org/gpu/todo.html#replace-drm-detect-hdmi-monitor-with-drm-display-info-is-hdmi

José Expósito (5):
  drm/exynos: hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
  drm/rockchip: inno_hdmi: Replace drm_detect_hdmi_monitor() with
    is_hdmi
  drm/rockchip: rk3066_hdmi: Replace drm_detect_hdmi_monitor() with
    is_hdmi
  drm/sti/sti_hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
  drm/sun4i: hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi

 drivers/gpu/drm/exynos/exynos_hdmi.c   | 15 +++++++++------
 drivers/gpu/drm/rockchip/inno_hdmi.c   |  8 ++++----
 drivers/gpu/drm/rockchip/rk3066_hdmi.c |  6 +++---
 drivers/gpu/drm/sti/sti_hdmi.c         |  7 ++++---
 drivers/gpu/drm/sti/sti_hdmi.h         |  2 --
 drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  1 -
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c |  6 +++---
 7 files changed, 23 insertions(+), 22 deletions(-)

-- 
2.25.1

