Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C7476427
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhLOVD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbhLOVDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:03:07 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B220CC061747
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:03:06 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id g28so21381271qkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 13:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=js1jSO4OFQ7U7dS2izOYemvuMGJjz15gack2xht55jQ=;
        b=PtnYZZC4ELrFfJxFdXB/6jicCKg5x9/uj9D0bTr4fEufKEE7dleAzzjWUIwmbuclzD
         2R7MySzIs+F1/17ZqnIQ8ipu+R1pSn+sdruOYeQyLSzm95/bR4jouhkg5bfcgBSZEDSs
         PC++lAgq14GowmWLAb7atAfctc2JJvxJp2PyQu446TCmjei8BQBg3SKeRA2AAT6mtmuw
         4XMNx0T01o7sVZE5+CkbL3ucb+13a2z4MvBO1xRt9xhgiCmPhW9ekq+LHWyp+r54AFQv
         i8h2JnEUforYH3LHdXHYm1f67Wdo1olwmWQ1G8mq6C42jI+cjfQnilIfvV38rtc9S9b9
         HEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=js1jSO4OFQ7U7dS2izOYemvuMGJjz15gack2xht55jQ=;
        b=ykmBP6Xu9wzfsUbiDYzYQZnX2XWYZzvqhgKR707Xs7ylJKmHPsm5P1ySKolnYzaTfp
         Q1QsNYHlHeAMLnVGVV4D9SBnycvmS7jct3zb8K3oxybryFUoZm6IuGoskiTFc9HuECw7
         8o7hzSxFkZLStZRBIiW7DBOVoI0m/tT3SGIpoz2M0FNi/GPotBITlIkRXb4ZkIBdw+Gf
         3CzcVkC9LcZe+70To/h9dvsXYw2TPlnktWXc6p0N4KVhIQ1gNaaRp19gI3cu0Rl03yQY
         3ob6QmZGASHYW1caxC0WawAtHrcf3GKlvN7E7uPxW3AaOkDWue6j8wqPjz683Dkt1/wB
         O4nA==
X-Gm-Message-State: AOAM532k2+x1YsqPwuncWnwgIMVsDJ0n8O3pVawvAwvU3ZgUYDm0dyFc
        I6qbgk/OMBiya/9n27ScUD0=
X-Google-Smtp-Source: ABdhPJxgxGpTirbr48viDuS6QNylWAPqepFaT7ltRmbj/eF8GAp+AmJ96662/GcMqD0KghZz+Y1GHg==
X-Received: by 2002:a37:6716:: with SMTP id b22mr10005020qkc.123.1639602185799;
        Wed, 15 Dec 2021 13:03:05 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id a20sm1644356qkh.63.2021.12.15.13.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:03:05 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] phy: phy-rockchip-inno-usb2: add rk3568 support
Date:   Wed, 15 Dec 2021 16:02:50 -0500
Message-Id: <20211215210252.120923-7-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215210252.120923-1-pgwipeout@gmail.com>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 usb2phy is a standalone device with a single muxed interrupt.
Add support for the registers to the usb2phy driver.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 285958fdab38..bdc5a861891c 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1093,6 +1093,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	if (ret) {
 		dev_err(rphy->dev, "failed to init irq for host port\n");
 		goto out;
+	}
 
 	if (!IS_ERR(rphy->edev)) {
 		rport->event_nb.notifier_call = rockchip_otg_event;
@@ -1504,6 +1505,69 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
+	{
+		.reg = 0xfe8a0000,
+		.num_ports	= 2,
+		.clkout_ctl	= { 0x0008, 4, 4, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0000, 8, 0, 0, 0x1d1 },
+				.bvalid_det_en	= { 0x0080, 2, 2, 0, 1 },
+				.bvalid_det_st	= { 0x0084, 2, 2, 0, 1 },
+				.bvalid_det_clr = { 0x0088, 2, 2, 0, 1 },
+				.utmi_avalid	= { 0x00c0, 10, 10, 0, 1 },
+				.utmi_bvalid	= { 0x00c0, 9, 9, 0, 1 },
+			},
+			[USB2PHY_PORT_HOST] = {
+				/* Select suspend control from controller */
+				.phy_sus	= { 0x0004, 8, 0, 0x1d2, 0x1d2 },
+				.ls_det_en	= { 0x0080, 1, 1, 0, 1 },
+				.ls_det_st	= { 0x0084, 1, 1, 0, 1 },
+				.ls_det_clr	= { 0x0088, 1, 1, 0, 1 },
+				.utmi_ls	= { 0x00c0, 17, 16, 0, 1 },
+				.utmi_hstdet	= { 0x00c0, 19, 19, 0, 1 }
+			}
+		},
+		.chg_det = {
+			.opmode		= { 0x0000, 3, 0, 5, 1 },
+			.cp_det		= { 0x00c0, 24, 24, 0, 1 },
+			.dcp_det	= { 0x00c0, 23, 23, 0, 1 },
+			.dp_det		= { 0x00c0, 25, 25, 0, 1 },
+			.idm_sink_en	= { 0x0008, 8, 8, 0, 1 },
+			.idp_sink_en	= { 0x0008, 7, 7, 0, 1 },
+			.idp_src_en	= { 0x0008, 9, 9, 0, 1 },
+			.rdm_pdwn_en	= { 0x0008, 10, 10, 0, 1 },
+			.vdm_src_en	= { 0x0008, 12, 12, 0, 1 },
+			.vdp_src_en	= { 0x0008, 11, 11, 0, 1 },
+		},
+	},
+	{
+		.reg = 0xfe8b0000,
+		.num_ports	= 2,
+		.clkout_ctl	= { 0x0008, 4, 4, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0000, 8, 0, 0x1d2, 0x1d1 },
+				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
+				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
+				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
+				.utmi_ls	= { 0x00c0, 5, 4, 0, 1 },
+				.utmi_hstdet	= { 0x00c0, 7, 7, 0, 1 }
+			},
+			[USB2PHY_PORT_HOST] = {
+				.phy_sus	= { 0x0004, 8, 0, 0x1d2, 0x1d1 },
+				.ls_det_en	= { 0x0080, 1, 1, 0, 1 },
+				.ls_det_st	= { 0x0084, 1, 1, 0, 1 },
+				.ls_det_clr	= { 0x0088, 1, 1, 0, 1 },
+				.utmi_ls	= { 0x00c0, 17, 16, 0, 1 },
+				.utmi_hstdet	= { 0x00c0, 19, 19, 0, 1 }
+			}
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rv1108_phy_cfgs[] = {
 	{
 		.reg = 0x100,
@@ -1553,6 +1617,7 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
 	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
 	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
+	{ .compatible = "rockchip,rk3568-usb2phy", .data = &rk3568_phy_cfgs },
 	{ .compatible = "rockchip,rv1108-usb2phy", .data = &rv1108_phy_cfgs },
 	{}
 };
-- 
2.25.1

