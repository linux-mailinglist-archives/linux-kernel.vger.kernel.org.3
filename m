Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A6497767
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiAXCce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240814AbiAXCbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:31:39 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F27C06173B;
        Sun, 23 Jan 2022 18:31:39 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i14so12607346ila.11;
        Sun, 23 Jan 2022 18:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSXId6wFOcwUDpkasr+brcXkI4I0RStdwVThOM4wpW8=;
        b=BnwEBpGlnINz8w3TiMumEaouU8bPBS6KOItmirQXtnhLsoURAZc8PHjjPkSjqotUoc
         45NrFzUtmnouqQ6b1OJxkiA1UNAD9HEabiXaKF15P2YijbYTyzx2OI29wJSib3+nNnXB
         yY8lKWB0mLRZbvfIB+JfS7DlMsYWsKzA9v4lN+YBey03ESkHhNDTD4VHWxKh/1OMA6mF
         ZB0WG05kJckrvepULbvD+zT18ipBV6SpGcQt5tfRkP1Ug9xDcHWNjwRup8exlU9XdF+l
         +oiWYPTbXjqAKGvfqcEWzZUosTxnyLtDgysY8V9XcMTYlooZ2ne3AH7j4ya/NhmR7IKQ
         +BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSXId6wFOcwUDpkasr+brcXkI4I0RStdwVThOM4wpW8=;
        b=RhgOf6eFs3J/59HEhP8wC/qJM+zClxrvJGWRek6wiIT16xPxYjntTv4HviJ8sTQ8Ks
         Zrn3ofNd+ZrtCA8bkIq504H0YUEqVwOnhhAxBoVJPblWxigio1MAf/pGD7PNpejc4mtD
         jEZpZ7JVs9DX2iFSWC2bh0MoE55/srC0R8SF/r4taZPG0bL80ySU+fSWhrCqCotVt/PV
         xjrihmZiuktfW8XTvUkz0Nj5vFDxiS19D+dyaX6Xz2tOgWHVqTl1eDusduF2+WrnUPDw
         0q7a21kpTQHTvcey9w9ikfLcZ8wfy1UjDmwISqLlmb07yJpnlLocrgnBdyib3UWT1ddn
         9G0Q==
X-Gm-Message-State: AOAM530hfKrZiDwHd+eoUbqe8UfjcRwQ3zT93IW0xxkT1NxPWsau2zcf
        SmfCzyIC+s995kCcmUcPOiNbJKPeO68=
X-Google-Smtp-Source: ABdhPJy0iip0YA6qcDdY9zJrChTlccm57oyzXUHPMs4hm8x42fbzYT8Wltv4BmDQw6enkSBWBNRI6g==
X-Received: by 2002:a05:6e02:1648:: with SMTP id v8mr7455887ilu.286.1642991498331;
        Sun, 23 Jan 2022 18:31:38 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:582d:ad0e:e5a6:94b6])
        by smtp.gmail.com with ESMTPSA id w4sm6625633ilq.56.2022.01.23.18.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 18:31:37 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH V3 03/10] soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
Date:   Sun, 23 Jan 2022 20:31:17 -0600
Message-Id: <20220124023125.414794-4-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124023125.414794-1-aford173@gmail.com>
References: <20220124023125.414794-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the necessary bits to drive the VPU blk-ctrl on the i.MX8MQ, to
avoid putting more of this functionality into the decoder driver.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 511e74f0db8a..122f9c884b38 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -15,6 +15,7 @@
 
 #include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
+#include <dt-bindings/power/imx8mq-power.h>
 
 #define BLK_SFT_RSTN	0x0
 #define BLK_CLK_EN	0x4
@@ -589,6 +590,68 @@ static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
 	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
 };
 
+static int imx8mq_vpu_power_notifier(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+						 power_nb);
+
+	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
+		return NOTIFY_OK;
+
+	/*
+	 * The ADB in the VPUMIX domain has no separate reset and clock
+	 * enable bits, but is ungated and reset together with the VPUs. The
+	 * reset and clock enable inputs to the ADB is a logical OR of the
+	 * VPU bits. In order to set the G2 fuse bits, the G2 clock must
+	 * also be enabled.
+	 */
+	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(0) | BIT(1));
+	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(0) | BIT(1));
+
+	if (action == GENPD_NOTIFY_ON) {
+		/*
+		 * On power up we have no software backchannel to the GPC to
+		 * wait for the ADB handshake to happen, so we just delay for a
+		 * bit. On power down the GPC driver waits for the handshake.
+		 */
+		udelay(5);
+
+		/* set "fuse" bits to enable the VPUs */
+		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
+	}
+
+	return NOTIFY_OK;
+}
+
+static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[] = {
+	[IMX8MQ_VPUBLK_PD_G1] = {
+		.name = "vpublk-g1",
+		.clk_names = (const char *[]){ "g1", },
+		.num_clks = 1,
+		.gpc_name = "g1",
+		.rst_mask = BIT(1),
+		.clk_mask = BIT(1),
+	},
+	[IMX8MQ_VPUBLK_PD_G2] = {
+		.name = "vpublk-g2",
+		.clk_names = (const char *[]){ "g2", },
+		.num_clks = 1,
+		.gpc_name = "g2",
+		.rst_mask = BIT(0),
+		.clk_mask = BIT(0),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mq_vpu_blk_ctl_dev_data = {
+	.max_reg = 0x14,
+	.power_notifier_fn = imx8mq_vpu_power_notifier,
+	.domains = imx8mq_vpu_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mq_vpu_blk_ctl_domain_data),
+};
+
 static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 	{
 		.compatible = "fsl,imx8mm-vpu-blk-ctrl",
@@ -599,6 +662,9 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 	}, {
 		.compatible = "fsl,imx8mn-disp-blk-ctrl",
 		.data = &imx8mn_disp_blk_ctl_dev_data
+	}, {
+		.compatible = "fsl,imx8mq-vpu-blk-ctrl",
+		.data = &imx8mq_vpu_blk_ctl_dev_data
 	}, {
 		/* Sentinel */
 	}
-- 
2.32.0

