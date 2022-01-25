Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AFD49BA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448996AbiAYRQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbiAYRNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:41 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DBC061762;
        Tue, 25 Jan 2022 09:12:33 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q204so9923724iod.8;
        Tue, 25 Jan 2022 09:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSXId6wFOcwUDpkasr+brcXkI4I0RStdwVThOM4wpW8=;
        b=jvq2weiHDbFCUevkgkPdczmPL6fzlcvMzmh2jrJxpO/Sdv/oZE+g/WRBe1lnOJocOm
         tQLZPZixBcvXD0jCsCWL6biJJCwl6CvZXd+2LDUGL86ovKzrInyjzFQxNf3cMz2OA+hD
         lsHkJcwXC1i17yZbqBNNJ6sjklScgpwu3sxwUeGKmRFoWknqgzm8n3jYwqBxSyqTQ5dd
         q471L0yA+NFzaNE7ZxvzPD4CAosyYbL2jrmUoXCRgRuGcPFM1VV28ALhZGro+uXHI6H8
         4+S3FaiPs3k7fMEp90QkIDWfVQlGI/mdOjFotVKJtOE1sfww9rhpTmh9vlrXjy38Vsp4
         u/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSXId6wFOcwUDpkasr+brcXkI4I0RStdwVThOM4wpW8=;
        b=HX09jPySTeTTvT1r/pjfPWYChs95o2/W+LfGXs0ulbzYZWl+Xr7FeQd50nPRmUlkZO
         8+doHMBcF5cbM2ay4D2cnBjb8DILPiqqcKe5fywadlfGaG0iiFBgB5VmQj8wkYUW+BhW
         +sxX0fTZ2tpD1Ntuhmqf36Yu/v04x+Dy9R2pCiIleIVjevkRAPwnRZKPVwN1hidBmfLZ
         G3j+EJeJEgdcXKVDeezsJM0SEpO4/xLbEhQsmLtnox8Ul4FNj5Q2R/CJ7CpA7xqYwaqL
         9G2U4fsLFrGxz+5aAkQV85bx+42CduMfFSIpRXHlwCnfypOGSsXLL8tCMOch/YnEbWXM
         +6/A==
X-Gm-Message-State: AOAM5317QN9FR2Fgqr5B8p+C+QrUMVE5G5ore2UcN1rK2DPrkD0rU22D
        AVO2QcLjOnM1/FczTp3ztwO5gIwm9q0=
X-Google-Smtp-Source: ABdhPJzBGSiQcvKXn6tqkMJGvECZoUooaOMA1+IPWkAFvfMB7bRtoTpU/L/GdGAaRwO+LW+TAVJ4Cg==
X-Received: by 2002:a05:6638:761:: with SMTP id y1mr10429953jad.240.1643130751936;
        Tue, 25 Jan 2022 09:12:31 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6592:b6fe:71b1:9f4c])
        by smtp.gmail.com with ESMTPSA id m14sm8090291iov.0.2022.01.25.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:31 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH V4 04/11] soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
Date:   Tue, 25 Jan 2022 11:11:21 -0600
Message-Id: <20220125171129.472775-5-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125171129.472775-1-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com>
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

