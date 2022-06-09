Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F5A5444CF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiFIH2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbiFIH17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:27:59 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2231F5898
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:27:55 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c14so21043110pgu.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQhOn/YiixyOJw4v/o8WRfr7u50AUleNhUdb032jkoc=;
        b=L7jS/0Ul8GyfGFjRHSjlC/3V1YgWm5fckAx4cb0ozB4CuNwCbDePiYLy99VKkO4eYR
         vsIEwXCARojXs6cMBuEgOpj5milTERUvgpkWcuL7Sfsn8AInOOdQvfSoVcc334NhuGZ4
         7TUKV91TAvpAbsMABW8YLDZN6I2yI6bugPIPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQhOn/YiixyOJw4v/o8WRfr7u50AUleNhUdb032jkoc=;
        b=Px8WMhGuXfWvCTE93ntVD6bfSGiu5QI9TRFMK7nDzBhNsYH84+ZCbo14Ij8ol5ZbwX
         w4zSe8hSCCh9hEcWgW7abmeRlTXrE90GBip4Z+65CXrk6faLjEJkJ04vBhRVpgCw7Jc9
         9ZBvVPvqWtuDeh61CnL7P6VTewPC9OxrxXm+0V7zDOgvcs2o0iTE/XvvG8Wtc7j7dQqF
         YmnhCA07kxOvaDPg80LEKpCPLBKl5td1FajZlAiqJUgOLw6LlzA0I5dNxki+OyAvqbFH
         JipDob+K1cmcWwc5xFL5fTZVXQcVtDT/IbrkUgAiENsKqCXSETK/gLRsHPN/nSLTbzmJ
         iAOA==
X-Gm-Message-State: AOAM533CAxPhcMuiQJOM8Cu6Lm1qx33eJI10ZKWC8H9UVFg+7QBZs0XT
        FZ2Z8T/mim5EZv/8waUmcYeAHw==
X-Google-Smtp-Source: ABdhPJwaokvXUJTqJoAx08HJzYQQnKmSiU3Qu9ykQ3bFrg5pAH7mwkib4XyJbC+tUSapAx+aGXawRQ==
X-Received: by 2002:a05:6a00:1805:b0:51c:3a7:54dc with SMTP id y5-20020a056a00180500b0051c03a754dcmr23846453pfa.15.1654759674657;
        Thu, 09 Jun 2022 00:27:54 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5119:d95b:c6cd:77fb])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm15312221plb.276.2022.06.09.00.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:27:54 -0700 (PDT)
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
Subject: [PATCH v7 5/8] drm/panel: panel-simple: Implement .get_orientation callback
Date:   Thu,  9 Jun 2022 15:27:19 +0800
Message-Id: <20220609072722.3488207-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609072722.3488207-1-hsinyi@chromium.org>
References: <20220609072722.3488207-1-hsinyi@chromium.org>
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

To return the orientation property to drm/kms driver.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4a2e580a2f7b7..b4b9195251891 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -411,7 +411,10 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 	/* add hard-coded panel modes */
 	num += panel_simple_get_non_edid_modes(p, connector);
 
-	/* set up connector's "panel orientation" property */
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, p->orientation);
 
 	return num;
@@ -434,12 +437,21 @@ static int panel_simple_get_timings(struct drm_panel *panel,
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
 	.prepare = panel_simple_prepare,
 	.enable = panel_simple_enable,
 	.get_modes = panel_simple_get_modes,
+	.get_orientation = panel_simple_get_orientation,
 	.get_timings = panel_simple_get_timings,
 };
 
-- 
2.36.1.255.ge46751e96f-goog

