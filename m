Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C4D5444CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiFIH2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiFIH1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:27:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7AF16A512
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:27:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q18so19575452pln.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=979njmg3lDINGZi/hjk1WmVdoXok3WEPuAqEU9cZJ2k=;
        b=j9KpAI/b9qRseLDWsOBweqGi86kh7wYZQ3ofyFDfkDqIfZ+/HB8ErM8G4QPMbx/1K/
         wrn500+3sYP2OfOeyGIlRevPsuSzxegJU4bDZ01Hl0kdJZqsMwrQoTkyshushfeQtZor
         gqU3O6bM87DjmVq4Kln8bX86DBr+n1dbNzoV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=979njmg3lDINGZi/hjk1WmVdoXok3WEPuAqEU9cZJ2k=;
        b=oJwP1YS7/ugPjDv24e2KymhmFjl6R57+3VB5C0oL8/LzrXpMgF4ZprTqquEPpCkG4o
         HG7JS276tFuUuoSjW6hYpRk2Smez/s1NJ33XPaQcvFKjMjaUt0OW8b9MmElA77kd83np
         T2bZTl9CtYqjbHuidV6IgFWWBuGJojWgpL1PBoT94K3iAoeWTl20IKO/sbDCRjK6dKzt
         4QTL1dk1kCNT8Q5B+7cTgFR7HQm+2/XGD2Xh/ALnJJKJNNqSEq9USt3edosEKJ17tjA/
         0WQAcgV5/ROp2DNt2DFNf4x5Py006OUntvlC/DVZN6LOZCj6c7SEmsvX6/lfZXB823r5
         xFYA==
X-Gm-Message-State: AOAM533JeofLb9TxdKopZzQeuVnYGrSGE4VCUz6+tNc/S9KrSoRK3+H6
        dMTjGZhE56dKpSNeZ1JtbvwiFQ==
X-Google-Smtp-Source: ABdhPJzUtYiKc+YHbz9WSYk2PsW/dDB6EjjkY/X/5kiQ0m6h6L5dfv1hbOR67mOKxuCqT6BPA0oK+g==
X-Received: by 2002:a17:90a:4e82:b0:1ea:3f61:51b with SMTP id o2-20020a17090a4e8200b001ea3f61051bmr2127811pjh.16.1654759671059;
        Thu, 09 Jun 2022 00:27:51 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5119:d95b:c6cd:77fb])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm15312221plb.276.2022.06.09.00.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:27:50 -0700 (PDT)
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
Subject: [PATCH v7 4/8] drm/panel: lvds: Implement .get_orientation callback
Date:   Thu,  9 Jun 2022 15:27:18 +0800
Message-Id: <20220609072722.3488207-5-hsinyi@chromium.org>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/panel/panel-lvds.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index f11252fb00fea..7a4fedc63e8ec 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -99,15 +99,28 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
 	drm_display_info_set_bus_formats(&connector->display_info,
 					 &lvds->bus_format, 1);
 	connector->display_info.bus_flags = lvds->bus_flags;
+
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, lvds->orientation);
 
 	return 1;
 }
 
+static enum drm_panel_orientation panel_lvds_get_orientation(struct drm_panel *panel)
+{
+       struct panel_lvds *lvds = to_panel_lvds(panel);
+
+       return lvds->orientation;
+}
+
 static const struct drm_panel_funcs panel_lvds_funcs = {
 	.unprepare = panel_lvds_unprepare,
 	.prepare = panel_lvds_prepare,
 	.get_modes = panel_lvds_get_modes,
+	.get_orientation = panel_lvds_get_orientation,
 };
 
 static int panel_lvds_parse_dt(struct panel_lvds *lvds)
-- 
2.36.1.255.ge46751e96f-goog

