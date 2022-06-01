Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1490353A123
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351484AbiFAJrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351430AbiFAJrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:47:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5F611449
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:47:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q18so1274321pln.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVLAPZRG5UqIkFmmis3uM10FnfT5Ljau+xefKKOpEpE=;
        b=OE93Xi6fuFvNjrUPzVoJX4DICUjzwZ0FrNbASk4QhkljwjjdO/t0+U9bsHLt3Nq16+
         2jXyFGb9vQV2JODWz1J1HY7MqWvFdGQfxoZCRMPGD0flte9sS8xfM5OvEXrqzlCd8Bhi
         wM7/e6IqFwZwACP7InwILEx1YGycyNgsKSh5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVLAPZRG5UqIkFmmis3uM10FnfT5Ljau+xefKKOpEpE=;
        b=lTYB5ggV12j4CyDrJMGjg+zHqbiDUc2ktW6eEAIqlIZAxonyRSmEA2Iq301g7fcJZJ
         /y9n02EZbufihCfKe9wF2XmKAqIsQTIa86s2+7l2GPnzjicjzXbjQR1cEcbbQjVMN0gH
         BbOzw35daB0ACpHEdb0JzeY4yEeMbXVSXFl5GWdgKftF2dO7ymimVR2EvPW7K0VkIWI/
         xdSZVuOciokzkb3tou/cAQ9I791V5cdJDk4zZu/umUTtbzjgZHZuW11D2StZ67Vo/h1d
         64aWj7GVPSlRb92hXzvQB2AIgNIfrCLtqx+j3jJeXsIrIpKFf2HQ72X7c+8xBRa3KHcm
         ou7Q==
X-Gm-Message-State: AOAM5308Tf/Fe1clZ3CbzuIXxpfdOzcgcvBJ4vKnxccimEwS5DhqBAEf
        bgdoRkqSVLdK4RyJtSEDCW5RVA==
X-Google-Smtp-Source: ABdhPJxax220Y+zg4h1kp6XXN13EyER3sz3MXL01acYe3CvWec7xBmexQhbBRgOQrByQ7j3lpjfQeQ==
X-Received: by 2002:a17:902:7045:b0:163:9c45:e330 with SMTP id h5-20020a170902704500b001639c45e330mr25430866plt.32.1654076821222;
        Wed, 01 Jun 2022 02:47:01 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:dc30:e75c:ae95:f2d6])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a0018aa00b0050dc762815esm1039494pfh.56.2022.06.01.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 02:47:00 -0700 (PDT)
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
Subject: [PATCH v2 5/8] drm/panel: panel-simple: Implement .get_orientation callback
Date:   Wed,  1 Jun 2022 17:46:34 +0800
Message-Id: <20220601094637.1200634-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601094637.1200634-1-hsinyi@chromium.org>
References: <20220601094637.1200634-1-hsinyi@chromium.org>
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

To return the orientation property to drm/kms driver.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a34f4198a534..54e78d978dcb 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -434,6 +434,14 @@ static int panel_simple_get_timings(struct drm_panel *panel,
 	return p->desc->num_timings;
 }
 
+static enum drm_panel_orientation panel_simple_get_orientation(struct drm_panel *panel)
+{
+       struct panel_simple *p = to_panel_simple(panel);
+
+       return p->orientation;
+}
+
+
 static const struct drm_panel_funcs panel_simple_funcs = {
 	.disable = panel_simple_disable,
 	.unprepare = panel_simple_unprepare,
@@ -441,6 +449,7 @@ static const struct drm_panel_funcs panel_simple_funcs = {
 	.enable = panel_simple_enable,
 	.get_modes = panel_simple_get_modes,
 	.get_timings = panel_simple_get_timings,
+	.get_orientation = panel_simple_get_orientation,
 };
 
 static struct panel_desc panel_dpi;
-- 
2.36.1.255.ge46751e96f-goog

