Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B05444D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbiFIH1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiFIH1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:27:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F1A15877D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:27:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id bo5so20374900pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6cns58U7ETFcRJZ3rxmYxEFcjgwqUT9LK1/jcMIzzTI=;
        b=d5E1HKLGWGQ+MJC1zhqIlaMdVqsmrJIiSTzfeCCJ8GRtmrxDluI8Nr3EsxGpB97Ios
         Kr+asgLmD6JQ2jgDM5t0DTd/FRpUUoJo7U0ZIe+nMxZDSiXb5ewCvsLZMX/tOZhbUVGs
         glzUZY+7Ruud+lKjcMEk+WIHOm2Nd1Jvp7emc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6cns58U7ETFcRJZ3rxmYxEFcjgwqUT9LK1/jcMIzzTI=;
        b=FySqqqCI0SvLquxppXabC+tNBPW0ED2hC6DmM7LKQz2twNrCdQdatUb/w4b6ngvU1B
         jUtrnkBig7HmkYY3kHFZk8KBn3Tz9iy4wE5paGnE1y14LiwWCV5vqKHF/Qo3X4gtrGaU
         84RCiVrHgOh21nscY4FnXpleNjNSjY7zxDZWxR+FghhmwydMNcmRJnvgjnXBivxbV4+P
         n/+O0miVHJqROrfM44oImEySRFsWpH2tHqUJXUpJtc5NHp5Tm1gXmQN53lrfpJ7WI3Os
         KX/1tGMA22Jkd8GcWGe1Sxof9QYOsoZNsQCxri1gRPQY+yrcVTKxt7Z4p7+vhSwPEUDL
         U0Zw==
X-Gm-Message-State: AOAM5319HcHSVXBYXWF5+ae5djzRQwL7B0lMlDqY3pPXL+lorfWH0pRc
        NYVYpzpRBSifJY0ilehyiidBZg==
X-Google-Smtp-Source: ABdhPJxEW2aEZOOk3eVwTOVHc08TJtKl0jc1RGX7hhglR738NBHPdiIFVkzAMa8GiWT2HYaWCqw6DA==
X-Received: by 2002:a63:483:0:b0:3fc:9128:60a5 with SMTP id 125-20020a630483000000b003fc912860a5mr34278819pge.606.1654759663639;
        Thu, 09 Jun 2022 00:27:43 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5119:d95b:c6cd:77fb])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm15312221plb.276.2022.06.09.00.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:27:43 -0700 (PDT)
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
Subject: [PATCH v7 2/8] drm/panel: boe-tv101wum-nl6: Implement .get_orientation callback
Date:   Thu,  9 Jun 2022 15:27:16 +0800
Message-Id: <20220609072722.3488207-3-hsinyi@chromium.org>
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
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 1be150ac758f5..07f722f33fc5b 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1511,16 +1511,28 @@ static int boe_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = boe->desc->size.width_mm;
 	connector->display_info.height_mm = boe->desc->size.height_mm;
 	connector->display_info.bpc = boe->desc->bpc;
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, boe->orientation);
 
 	return 1;
 }
 
+static enum drm_panel_orientation boe_panel_get_orientation(struct drm_panel *panel)
+{
+	struct boe_panel *boe = to_boe_panel(panel);
+
+	return boe->orientation;
+}
+
 static const struct drm_panel_funcs boe_panel_funcs = {
 	.unprepare = boe_panel_unprepare,
 	.prepare = boe_panel_prepare,
 	.enable = boe_panel_enable,
 	.get_modes = boe_panel_get_modes,
+	.get_orientation = boe_panel_get_orientation,
 };
 
 static int boe_panel_add(struct boe_panel *boe)
-- 
2.36.1.255.ge46751e96f-goog

