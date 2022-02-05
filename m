Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317D04AA4F3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378734AbiBEAOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378710AbiBEAOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:14:16 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3E7DF8C1BE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:14:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id d186so6294747pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 16:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSn2M/yKAMsfnGZFwHB10y6iqnXx4FF2oGb2lIsnFpI=;
        b=lbZTKKPzut0pSDp0PGEfSw3i5JnQ5JXUOvWVZ6Bqe23XIqEF6A2W1GMcYGs4LM94eq
         1tgtOTcFBq6W1UWg5oKNaKKyOSErFWPClzvAqvTWGYekDZykaMBZ7OGE6HsZzPuqH8ec
         VHPh6nksgC3cBqMWKW3nX7/jZgVqlYWTuHtTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSn2M/yKAMsfnGZFwHB10y6iqnXx4FF2oGb2lIsnFpI=;
        b=NKkaFVvgnSCYaCTleAGEfbb8tRhye/LSel5Oxm1IxNH4K+u3ezxDBE2AJhX6blJwc9
         JZfZKSz8mUSmcVSnNNw2yazGe/gmGVG0VUrZc69++pidVz9nP2R/CglbAZRyBR028O6j
         nbvEe9s3bCKNGFuXGnEbXmZ3xaoe7stxZZlIem6IHLzD+eksSNHK2h8BzNFWH+OtXNaj
         2IKa7mVi/u2nsuSoJB+5UxLFUtP4vftfAHae1VyqKAXhHgXMIWFR0hviddQf9XcZQ20n
         NujHDx6r+bRHAtgYMAkP132lg8VIJa130Nza4W6kyAiCPjVL+l1eZo/cy5vMhd+771cT
         ltog==
X-Gm-Message-State: AOAM532NWAsvAFS8WK7WVkrnypzytXmXHeR6uTdN0AtnUo/rHWWdXBTg
        Z3w/cFVP2Iap2oLrTOzuo36q7w==
X-Google-Smtp-Source: ABdhPJxn/GCPUuG4dWCd6GKM189yB7c+AgTeBQ6yKeW1fQ/otXDa51dtaC8z5cJVw357oaP3WHq34w==
X-Received: by 2002:a05:6a00:1810:: with SMTP id y16mr5530158pfa.65.1644020053748;
        Fri, 04 Feb 2022 16:14:13 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:d668:55ac:a465:88bf])
        by smtp.gmail.com with ESMTPSA id q13sm3720231pfj.44.2022.02.04.16.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 16:14:13 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        robert.foss@linaro.org, lschyi@chromium.org,
        Sam Ravnborg <sam@ravnborg.org>, jjsu@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/panel-edp: Allow querying the detected panel via debugfs
Date:   Fri,  4 Feb 2022 16:13:42 -0800
Message-Id: <20220204161245.v2.3.I209d72bcc571e1d7d6b793db71bf15c9c0fc9292@changeid>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220205001342.3155839-1-dianders@chromium.org>
References: <20220205001342.3155839-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Let's add a new debugfs entry to panel devices. It will have one of:
* UNKNOWN - We tried to detect a panel but it wasn't in our table.
* HARDCODED - We're not using generic "edp-panel" probed by EDID.
* A panel name - This is the name of the panel from our table.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Now using debugfs, not sysfs

 drivers/gpu/drm/panel/panel-edp.c | 37 ++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index a394a15dc3fb..0fda1eb7b690 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -21,6 +21,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
@@ -222,6 +223,8 @@ struct panel_edp {
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *hpd_gpio;
 
+	const struct edp_panel_entry *detected_panel;
+
 	struct edid *edid;
 
 	struct drm_display_mode override_mode;
@@ -606,6 +609,28 @@ static int panel_edp_get_timings(struct drm_panel *panel,
 	return p->desc->num_timings;
 }
 
+static int detected_panel_show(struct seq_file *s, void *data)
+{
+	struct drm_panel *panel = s->private;
+	struct panel_edp *p = to_panel_edp(panel);
+
+	if (IS_ERR(p->detected_panel))
+		seq_puts(s, "UNKNOWN\n");
+	else if (!p->detected_panel)
+		seq_puts(s, "HARDCODED\n");
+	else
+		seq_printf(s, "%s\n", p->detected_panel->name);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(detected_panel);
+
+static void panel_edp_debugfs_init(struct drm_panel *panel, struct dentry *root)
+{
+	debugfs_create_file("detected_panel", 0600, root, panel, &detected_panel_fops);
+}
+
 static const struct drm_panel_funcs panel_edp_funcs = {
 	.disable = panel_edp_disable,
 	.unprepare = panel_edp_unprepare,
@@ -613,6 +638,7 @@ static const struct drm_panel_funcs panel_edp_funcs = {
 	.enable = panel_edp_enable,
 	.get_modes = panel_edp_get_modes,
 	.get_timings = panel_edp_get_timings,
+	.debugfs_init = panel_edp_debugfs_init,
 };
 
 #define PANEL_EDP_BOUNDS_CHECK(to_check, bounds, field) \
@@ -666,7 +692,6 @@ static const struct edp_panel_entry *find_edp_panel(u32 panel_id);
 
 static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 {
-	const struct edp_panel_entry *edp_panel;
 	struct panel_desc *desc;
 	u32 panel_id;
 	char vend[4];
@@ -705,14 +730,14 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
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
@@ -734,12 +759,14 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
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
-- 
2.35.0.263.gb82422642f-goog

