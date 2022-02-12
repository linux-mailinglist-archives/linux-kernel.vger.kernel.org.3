Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B4E4B359A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 15:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbiBLOUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 09:20:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiBLOTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 09:19:51 -0500
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de [85.215.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13283245BD;
        Sat, 12 Feb 2022 06:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644675573;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=kj93pV+O/Ut7gMVXVeqqXeECB+NG0uC4DImxZwcSglI=;
    b=lSnv5wrFpNMKPlve8+bj0y/LSIvm7dJvYeHtQw8l4uzxs/HbNw4aLxHSaWdixLLgQz
    7dvTnP2tvhBUqJs54VeEtKWHrfmKfL5hSfJH+czBoHAKXzLn65roscScQj1osQeVaOxW
    fx4fXqlIUMzADAzrjLjp58aXzQNSE4gEptoKYczrbVrTNZkXwRFcNhXfiVfvY+FJfv14
    kFqJ2OOa/PpYcZVPVc+udSyvYEKTKjJMqwfAgos7W/gC2eCqpgtbKKk9FEXVVVoJ6lUX
    jtBwEAWdPmZrd/grc6OblsCw3MS8FhGfZP8K5hE+BO7XzyAPzl0G2TfWzXeUhBW10lsf
    1odw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVblcdY="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y1CEJWsqX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 12 Feb 2022 15:19:32 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v14 6/9] drm/bridge: dw-hdmi: introduce dw_hdmi_enable_poll()
Date:   Sat, 12 Feb 2022 15:19:24 +0100
Message-Id: <ba89671808ff5cf464bb923440a1630e50a0f7bb.1644675567.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1644675566.git.hns@goldelico.com>
References: <cover.1644675566.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so that specialization drivers like ingenic-dw-hdmi can enable polling.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 +++++++++
 include/drm/bridge/dw_hdmi.h              | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 826a055a7a273..fc2d5422c8a19 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3216,6 +3216,15 @@ static int dw_hdmi_parse_dt(struct dw_hdmi *hdmi)
 	return 0;
 }
 
+void dw_hdmi_enable_poll(struct dw_hdmi *hdmi, bool enable)
+{
+	if (hdmi->bridge.dev)
+		hdmi->bridge.dev->mode_config.poll_enabled = enable;
+	else
+		dev_warn(hdmi->dev, "no hdmi->bridge.dev");
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_enable_poll);
+
 struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 			      const struct dw_hdmi_plat_data *plat_data)
 {
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 2a1f85f9a8a3f..963960794b40e 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -196,5 +196,6 @@ enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
 void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
 			    bool force, bool disabled, bool rxsense);
 void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data);
+void dw_hdmi_enable_poll(struct dw_hdmi *hdmi, bool enable);
 
 #endif /* __IMX_HDMI_H__ */
-- 
2.33.0

