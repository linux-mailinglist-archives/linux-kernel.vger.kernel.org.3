Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F6A46B035
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbhLGB67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbhLGB6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:58:43 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59151C061A83;
        Mon,  6 Dec 2021 17:55:09 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i9so12191373ilu.1;
        Mon, 06 Dec 2021 17:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zA35Y58P12mhcmBAnqxZhkfn5G9++KfvTLXr1jNa/3g=;
        b=QnF5iRdjFtybl/juAE4py5FH0qqAmQC1e+eyjUrU1r/nfX5ul7NRtBg7DqMqDa9VqF
         r4npcpH+pMu7CVpapcdHvPDL/HdX2N6Rb3sIYC77oXsReWo5gsdIaCZoj59Zur0iepLm
         DO/lQfzHvkv3MtUIWNQjPkkgpopXraY6WRnP6M9b50Crv+0rcWtK/UiECIc/jL7KKhdu
         UL2O29phnvkw5vq9PCY7f0c1wwDaUPYZO8tzJBjiv6WdaEioRpXTdUh2nKr7JJ7RRumz
         UX6NewtsGzCMVbPZHlv6vkztNd3DDLCSI5R3A8KympwEb5fyH0JJWpTferMFkGxrzTZQ
         CFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zA35Y58P12mhcmBAnqxZhkfn5G9++KfvTLXr1jNa/3g=;
        b=MicCqzY4tJyQnmrice77ZPF+WyI60+t3HiPUhUCTgcqwEllhwXQMgZxwmqBO/JU+N5
         aqH3Kx2wRd6y9AD3/T0ohL+z8tFhv1fj8sEkcSiX/pAJ2Wzh7ZBJ4zQiv/p/CKOGOVy5
         GIk9Ptnc4bJNSFOo+tsn27Y04bSeqishcmJE1k3CoinV79ae8I/077f0f6Q6SXSpK5RS
         8hffgQSNx6MFftztuHily/Y2fuxScUnJlU+h6xwNrgHH3EilipH3odlCXQT80vctoj1l
         BZhMnzBLcYmd3v+/jH9ImEUwSlGTc9iqpL5xTvkdGBpA0udwcfQiMdJRSZ+Skz+ctQjV
         bQhw==
X-Gm-Message-State: AOAM531FYRc2eyskRcY6RgkgTGf6eXtYXSpERydTzv673/Qp1ny8RIDQ
        7i6Nd89cE9pCLIBBZp+O7KHpW6pUT0ZcE1W3
X-Google-Smtp-Source: ABdhPJyJgbJOu3Le6EQ1Ce0WpfUDTLfZY9Ktti+vSs5yIVRyR/wNK5ZMnFGUjdvNV9APxEk3RBv6cw==
X-Received: by 2002:a92:730c:: with SMTP id o12mr34677255ilc.116.1638842107785;
        Mon, 06 Dec 2021 17:55:07 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6db8:c9e4:6f6d:f38e])
        by smtp.gmail.com with ESMTPSA id j21sm8623639ila.6.2021.12.06.17.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 17:55:07 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     cphealy@gmail.com, benjamin.gaignard@collabora.com,
        hverkuil@xs4all.nl, Lucas Stach <l.stach@pengutronix.de>,
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
Subject: [RFC V2 4/6] soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
Date:   Mon,  6 Dec 2021 19:54:43 -0600
Message-Id: <20211207015446.1250854-5-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211207015446.1250854-1-aford173@gmail.com>
References: <20211207015446.1250854-1-aford173@gmail.com>
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
index 519b3651d1d9..a7c12e8fa89b 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
+#include <dt-bindings/power/imx8mq-power.h>
 
 #define BLK_SFT_RSTN	0x0
 #define BLK_CLK_EN	0x4
@@ -498,6 +499,68 @@ static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
 	.num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
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
@@ -505,7 +568,10 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 	}, {
 		.compatible = "fsl,imx8mm-disp-blk-ctrl",
 		.data = &imx8mm_disp_blk_ctl_dev_data
-	} ,{
+	}, {
+		.compatible = "fsl,imx8mq-vpu-blk-ctrl",
+		.data = &imx8mq_vpu_blk_ctl_dev_data
+	}, {
 		/* Sentinel */
 	}
 };
-- 
2.32.0

