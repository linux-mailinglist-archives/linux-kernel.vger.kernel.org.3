Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C3F4A75F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345943AbiBBQb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:31:56 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.120]:40675 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345862AbiBBQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1643819489;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LBxmbz4TfETrZ47YuEqnDes+Hpmtix3LD7VI+Fg8uyQ=;
    b=KqYpppttCMbw7+71UpwlA3jGdiCZSthXDlyYyXQvdbQBAPeFjGWjbEVQLFC1f41LHB
    DWFl8eMNfQAS4+jl85nQcveCTyUA9CyomXAGGRn+CDt0fpW4GHTY/KuPF0G5dWac6Y0x
    dS/VrJEdH1nJUL2829yFsCRklE3oxXz/kB1qbxahiS4pluGEsnK/l9AwjLiq7nGBW1Ww
    YgYplekwjNxkLzUn6O6p5ckg0vIxVYMvBBwVTZVArfC/xTNOqX9n77PnYbJpcuJrBfoT
    Hg75pEJhe3ecjtuZfQdxz19rKWYNzCacAdlzFccFteSQP7RRdr+ndWf/VmXI/PFtCays
    EqCQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbjc9Y="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y12GVSBmq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 2 Feb 2022 17:31:28 +0100 (CET)
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
Subject: [PATCH v13 5/9] drm/synopsys+ingenic: repair hot plug detection
Date:   Wed,  2 Feb 2022 17:31:19 +0100
Message-Id: <08fb9549042d35c1904fd977e68aa52f74f755b0.1643819482.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643819482.git.hns@goldelico.com>
References: <cover.1643819482.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so that it calls drm_kms_helper_hotplug_event().

We need to set .poll_enabled but that struct component
can only be accessed in the core code. Hence we add a public
setter function.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 +++++++++
 drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c | 2 ++
 include/drm/bridge/dw_hdmi.h              | 1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 54d8fdad395f5..52e7cd2e020d3 100644
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
diff --git a/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c b/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
index 34e986dd606cf..90547a28dc5c7 100644
--- a/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
+++ b/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
@@ -55,6 +55,8 @@ ingenic_dw_hdmi_mode_valid(struct dw_hdmi *hdmi, void *data,
 	if (mode->clock > 216000)
 		return MODE_CLOCK_HIGH;
 
+	dw_hdmi_enable_poll(hdmi, true);
+
 	return MODE_OK;
 }
 
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

