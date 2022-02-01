Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB84A6241
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbiBARWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiBARWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:22:21 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C8CC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:22:21 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 133so15944648pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VG6m0yGSKpFG4q+Uc9WqsHQnQC10ZbIeInL9q9ZvJP4=;
        b=Z59AWVextX0bLU1YwItgjLla2IDdnIhdNx61ujWPh3oF5IQSXKrK+CIngzOv1pmp/z
         BnGo8ycDeivDlCmc6skyHGhjq+vmmloQ8Cj+SC99shLtUSEMKhIgdF1sqsdBHhOr1I66
         bo11+Lna5pgOAd4oJxsgT5imhMdmbBakhYGeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VG6m0yGSKpFG4q+Uc9WqsHQnQC10ZbIeInL9q9ZvJP4=;
        b=mw2+M2k+cCZHe0HDe8DsbbvHe9ZS9JWUndDdgEi0IUn/F5aHGuCsuDY+HGKHajxdNi
         92nrnSBqi58uhqU5HTfMaXUYYOeyDoo3jFEFICxkrTMKLJLKHV1BqGfoQ+gIIrZVD2ga
         66zLhW3GGg+JrOdMBG2Lr65RfY85dQ1kpdKVYSxFyv25bbil+Z+L5tc5sR8I65CJNNsJ
         IbN3zBnNCXB5exblyLvSRoEjms5e0pHYdlKYo1cE5jMUCeLxC+/VJLye2XhDRN280lgZ
         5W1wvn+O9i+tBFdXYOciOACg1vt5zS1e5jEou0JSyUZjy7xFBeO03suwU7h4DTt3vOIK
         3ztA==
X-Gm-Message-State: AOAM531Y5zWXghtMROsDRWhBTET86WRH+VirHqZ0bCnh1Y+J6BOs3tRC
        wozaJzrGgIKJArgSyip9URn1QQ==
X-Google-Smtp-Source: ABdhPJwXfiKI3nFqn6/pTkWSkhtXry13WyUFnS4GLyA22EFm8qelW/dao6QZBnEvV3MAjoEEFkooaQ==
X-Received: by 2002:a63:884a:: with SMTP id l71mr19755054pgd.589.1643736140943;
        Tue, 01 Feb 2022 09:22:20 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:c148:8249:fae1:2404])
        by smtp.gmail.com with ESMTPSA id 19sm3304400pjb.42.2022.02.01.09.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:22:20 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drm/panel-edp: Allow querying the detected panel via sysfs"
Date:   Tue,  1 Feb 2022 09:21:58 -0800
Message-Id: <20220201092152.1.Ibc65ec6fa05017e9856ba9ef557310268429c3ce@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 363c4c3811db330dee9ce27dd3cee6f590d44e4c.

Since the point of this attribute is for a test, this should be done
in debugfs, not sysfs. Let's revert and a new patch can be added later
doing it in debugfs.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 39 ++++---------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 23da4040e263..a394a15dc3fb 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -222,8 +222,6 @@ struct panel_edp {
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *hpd_gpio;
 
-	const struct edp_panel_entry *detected_panel;
-
 	struct edid *edid;
 
 	struct drm_display_mode override_mode;
@@ -668,6 +666,7 @@ static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
 
 static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 {
+	const struct edp_panel_entry *edp_panel;
 	struct panel_desc *desc;
 	u32 panel_id;
 	char vend[4];
@@ -706,14 +705,14 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	}
 	drm_edid_decode_panel_id(panel_id, vend, &product_id);
 
-	panel->detected_panel = find_edp_panel(panel_id);
+	edp_panel = find_edp_panel(panel_id);
 
 	/*
 	 * We're using non-optimized timings and want it really obvious that
 	 * someone needs to add an entry to the table, so we'll do a WARN_ON
 	 * splat.
 	 */
-	if (WARN_ON(!panel->detected_panel)) {
+	if (WARN_ON(!edp_panel)) {
 		dev_warn(dev,
 			 "Unknown panel %s %#06x, using conservative timings\n",
 			 vend, product_id);
@@ -735,14 +734,12 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 		 */
 		desc->delay.unprepare = 2000;
 		desc->delay.enable = 200;
-
-		panel->detected_panel = ERR_PTR(-EINVAL);
 	} else {
 		dev_info(dev, "Detected %s %s (%#06x)\n",
-			 vend, panel->detected_panel->name, product_id);
+			 vend, edp_panel->name, product_id);
 
 		/* Update the delay; everything else comes from EDID */
-		desc->delay = *panel->detected_panel->delay;
+		desc->delay = *edp_panel->delay;
 	}
 
 	ret = 0;
@@ -753,28 +750,6 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	return ret;
 }
 
-static ssize_t detected_panel_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct panel_edp *p = dev_get_drvdata(dev);
-
-	if (IS_ERR(p->detected_panel))
-		return sysfs_emit(buf, "UNKNOWN\n");
-	else if (!p->detected_panel)
-		return sysfs_emit(buf, "HARDCODED\n");
-	else
-		return sysfs_emit(buf, "%s\n", p->detected_panel->name);
-}
-
-static const DEVICE_ATTR_RO(detected_panel);
-
-static void edp_panel_remove_detected_panel(void *data)
-{
-	struct panel_edp *p = data;
-
-	device_remove_file(p->base.dev, &dev_attr_detected_panel);
-}
-
 static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 			   struct drm_dp_aux *aux)
 {
@@ -874,10 +849,6 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 
 	drm_panel_add(&panel->base);
 
-	err = device_create_file(dev, &dev_attr_detected_panel);
-	if (!err)
-		devm_add_action_or_reset(dev, edp_panel_remove_detected_panel, panel);
-
 	return 0;
 
 err_finished_pm_runtime:
-- 
2.35.0.rc2.247.g8bbb082509-goog

