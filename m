Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AC84C0476
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 23:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiBVWTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 17:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBVWTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:19:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF40E2376
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:19:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nh8-20020a17090b364800b001bc023c6f34so340262pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvDRTgPxChmGOwbBu1IEeDWngy/wxmiyuXIu4qG8GgY=;
        b=M8EcTdQKHhkZyHx6loaC8hCQMviRsxMW7ziLP6j7P+589ry2FmHHmOkSjfvTR5X/FP
         4etnTp1OyTf5rf9gVFoADJ80z3VoOe1uV/Hn3rU4LMHFtm3ymH8VRjfv0sTBBc0QfUf8
         hPPfaIccp74UaAN/hkXda/dcjm9W5aBRryT+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvDRTgPxChmGOwbBu1IEeDWngy/wxmiyuXIu4qG8GgY=;
        b=JKLeEQJI42+bmCg8exE8tMYkJXYvNZ/1kVWumC8m9kLHcfWqxoixv4IGPzrDpBguYD
         UXrjJnUT7D9VkiRrC57eQV+LDvdkDXaYpO+F4uXZro7ovZGePJdOwxX2Sk24JGrcakPr
         uiDfGyTBhOc3u9yhnrQ1oYRpS9O+BFjMrklyamMahIYMZq1VXzYC5akmgathTxcuWVGm
         pFa+aZVucO+bo1oHi3RrhOwQd1WD4DEQ9KLNI9WP94jfihbOzrXJ+o6rRaCkLJaU2XE2
         v9HgtK/IIzU4K7NBi7+cfpSuS63RuZ8aji5MPB7XPqE3X1BXwQXdAUQ+SqxKUx+nOfC4
         A2CA==
X-Gm-Message-State: AOAM532EFxweKa25bEJg499keK4TVtjbnzQ91qhhxSnFaEeZ9E/LQC5v
        +Gisuz00bbZcc07JCvPQVirF0Q==
X-Google-Smtp-Source: ABdhPJz6kzGJn4fxm6ra8m4EVhyRNC2Fji6XMAc/wBelVEhtvnboO+xynWuFmQZA/IDpglCz2/axmw==
X-Received: by 2002:a17:90a:fe87:b0:1bc:6928:86c7 with SMTP id co7-20020a17090afe8700b001bc692886c7mr6199022pjb.129.1645568347984;
        Tue, 22 Feb 2022 14:19:07 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:ab7d:6b2a:b01e:d6ae])
        by smtp.gmail.com with ESMTPSA id g63sm17345756pfb.65.2022.02.22.14.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:19:07 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Properly undo autosuspend
Date:   Tue, 22 Feb 2022 14:18:43 -0800
Message-Id: <20220222141838.1.If784ba19e875e8ded4ec4931601ce6d255845245@changeid>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM Runtime docs say:
  Drivers in ->remove() callback should undo the runtime PM changes done
  in ->probe(). Usually this means calling pm_runtime_disable(),
  pm_runtime_dont_use_autosuspend() etc.

We weren't doing that for autosuspend. Let's do it.

Fixes: 9bede63127c6 ("drm/bridge: ti-sn65dsi86: Use pm_runtime autosuspend")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 38616aab12ac..fb6c588b0f71 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1758,6 +1758,7 @@ static inline void ti_sn_gpio_unregister(void) {}
 
 static void ti_sn65dsi86_runtime_disable(void *data)
 {
+	pm_runtime_dont_use_autosuspend(data);
 	pm_runtime_disable(data);
 }
 
@@ -1817,11 +1818,11 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
 				     "failed to get reference clock\n");
 
 	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(pdata->dev, 500);
+	pm_runtime_use_autosuspend(pdata->dev);
 	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_runtime_disable, dev);
 	if (ret)
 		return ret;
-	pm_runtime_set_autosuspend_delay(pdata->dev, 500);
-	pm_runtime_use_autosuspend(pdata->dev);
 
 	ti_sn65dsi86_debugfs_init(pdata);
 
-- 
2.35.1.473.g83b2b277ed-goog

