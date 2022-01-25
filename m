Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BADB49BE06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiAYVyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiAYVym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:54:42 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF4DC06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:54:42 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id u10so16449343pfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 13:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CNxeFPmBtV0nU1VBJ9IaThwJBrT6bBJPSlaX6q3YHjo=;
        b=PwoPwBJ8ayNdLuEzGamBoy4ylPVdvw31+F5KzmlGaEgDzDqgSSC4A5kstr5nZlKGKj
         QMqNFsg7IRvAiguF8JfU9BT2/f+Xmirhv9h+B4jTGimss0YklotHPbnOsE5QNU/cJBA3
         6BHqhDg+ptnsYGUtloS0XkQMs5M7LeCFapXHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CNxeFPmBtV0nU1VBJ9IaThwJBrT6bBJPSlaX6q3YHjo=;
        b=huqtIOCbsK2g1mRsZOKv/5hDT19vYudONUUXNasBJ/K1rECUMSRNebQrOX4UeJ4sz4
         e0juiopv3i8EVyY5ws6gPEl5Ny4WY3v4dQlNqjvirAK8tyFT2aDRwK52SRMqMQ2evkNf
         +0vtgeFiKGbs4P2CEDN9/ciVBwo8ZSbfMbpk3TGiCSm6WdbVPojzOyPjRrVH8GtWGJWk
         36Qg4IsT8kNE+5BJQfm1gYHv4vpwcLUeWxM1qaqNt0H3xEuz+Cha0tt+BKPzXNObbw79
         S78hO2RD2LWkrTCg8oA0V6UYov27fUUhOfM+TO2yFo5miGbBRQwuh3mSfY5HUH1Ynq12
         8f7Q==
X-Gm-Message-State: AOAM5333GM5chDxZIl2124EgTXFsExU/U/ZlTNnBTolOc11cqEwjC+hZ
        QnfctjfrrxBwzG7uGvTsrDC/1B9Zzdw00A==
X-Google-Smtp-Source: ABdhPJw5U6oW/scKNg8xtgVAv6dXvqTxYa5dhg3K6y0xe0gyhH8Y/wW04K2bjOLygk491pB2W6HWnw==
X-Received: by 2002:a62:798d:0:b0:4c7:3766:e938 with SMTP id u135-20020a62798d000000b004c73766e938mr20354648pfc.64.1643147682258;
        Tue, 25 Jan 2022 13:54:42 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f313:ff03:9fc5:6152])
        by smtp.gmail.com with ESMTPSA id f10sm6385pfe.29.2022.01.25.13.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:54:41 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     jjsu@chromium.org, lschyi@chromium.org, robert.foss@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Allow querying the detected panel via sysfs
Date:   Tue, 25 Jan 2022 13:54:09 -0800
Message-Id: <20220125135406.1.I62322abf81dbc1a1b72392a093be0c767da9bf51@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we added generic "edp-panel"s probed by EDID. To support
panels in this way we look at the panel ID in the EDID and look up the
panel in a table that has power sequence timings. If we find a panel
that's not in the table we will still attempt to use it but we'll use
conservative timings. While it's likely that these conservative
timings will work for most nearly all panels, the performance of
turning the panel off and on suffers.

We'd like to be able to reliably detect the case that we're using the
hardcoded timings without relying on parsing dmesg. This allows us to
implement tests that ensure that no devices get shipped that are
relying on the conservative timings.

Let's add a new sysfs entry to panel devices. It will have one of:
* UNKNOWN - We tried to detect a panel but it wasn't in our table.
* HARDCODED - We're not using generic "edp-panel" probed by EDID.
* A panel name - This is the name of the panel from our table.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 39 +++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 99ca1bd0091c..719c1bb6c45c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -222,6 +222,8 @@ struct panel_edp {
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *hpd_gpio;
 
+	const struct edp_panel_entry *detected_panel;
+
 	struct edid *edid;
 
 	struct drm_display_mode override_mode;
@@ -666,7 +668,6 @@ static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
 
 static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 {
-	const struct edp_panel_entry *edp_panel;
 	struct panel_desc *desc;
 	u32 panel_id;
 	char vend[4];
@@ -705,14 +706,14 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	}
 	drm_edid_decode_panel_id(panel_id, vend, &product_id);
 
-	edp_panel = find_edp_panel(panel_id);
+	panel->detected_panel = find_edp_panel(panel_id);
 
 	/*
 	 * We're using non-optimized timings and want it really obvious that
 	 * someone needs to add an entry to the table, so we'll do a WARN_ON
 	 * splat.
 	 */
-	if (WARN_ON(!edp_panel)) {
+	if (WARN_ON(!panel->detected_panel)) {
 		dev_warn(dev,
 			 "Unknown panel %s %#06x, using conservative timings\n",
 			 vend, product_id);
@@ -734,12 +735,14 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 		 */
 		desc->delay.unprepare = 2000;
 		desc->delay.enable = 200;
+
+		panel->detected_panel = ERR_PTR(-EINVAL);
 	} else {
 		dev_info(dev, "Detected %s %s (%#06x)\n",
-			 vend, edp_panel->name, product_id);
+			 vend, panel->detected_panel->name, product_id);
 
 		/* Update the delay; everything else comes from EDID */
-		desc->delay = *edp_panel->delay;
+		desc->delay = *panel->detected_panel->delay;
 	}
 
 	ret = 0;
@@ -750,6 +753,28 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	return ret;
 }
 
+static ssize_t detected_panel_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct panel_edp *p = dev_get_drvdata(dev);
+
+	if (IS_ERR(p->detected_panel))
+		return sysfs_emit(buf, "UNKNOWN\n");
+	else if (!p->detected_panel)
+		return sysfs_emit(buf, "HARDCODED\n");
+	else
+		return sysfs_emit(buf, "%s\n", p->detected_panel->name);
+}
+
+static const DEVICE_ATTR_RO(detected_panel);
+
+static void edp_panel_remove_detected_panel(void *data)
+{
+	struct panel_edp *p = data;
+
+	device_remove_file(p->base.dev, &dev_attr_detected_panel);
+}
+
 static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 			   struct drm_dp_aux *aux)
 {
@@ -849,6 +874,10 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 
 	drm_panel_add(&panel->base);
 
+	err = device_create_file(dev, &dev_attr_detected_panel);
+	if (!err)
+		devm_add_action_or_reset(dev, edp_panel_remove_detected_panel, panel);
+
 	return 0;
 
 err_finished_pm_runtime:
-- 
2.35.0.rc0.227.g00780c9af4-goog

