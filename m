Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0AB542998
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiFHIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiFHIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:36:43 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0848012088B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654671931; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=I6iTAv7VV57zQvIZ3qbDQHUVA7U6jmANnzJSSF64qN7oWfgcz7JbbfFFLFK+LkpJN4ukb9IFd7AhKhRT+cqittQNJMgolkveshF27qSCcPZwdGQv0WO16VD7RP7JsWGsbQAGh40T3OkFFo4BDMEYbg7nMdKcSsK1+KE4CQHAgz8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654671931; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=d2+L3oYy7eNvjEgKjDZKUUUnCobv7HCrKGgG0zEy0dA=; 
        b=PblKKECZ66RYVO2Gb+iMUgUTDlYNeRJ/xFs6lQJSS5ogy8vfdgGmO0VE8lLq7CA1giqjBC2T37447FAlzm6KnrBcA+tMBoz7jzHzbxNhU+29rKMlk+cLU7ssLJHsiCSWBWHcPvSrXswx/asHMucKYj1N9yq+PqIsi+wuW86DxpU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654671931;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=d2+L3oYy7eNvjEgKjDZKUUUnCobv7HCrKGgG0zEy0dA=;
        b=HIJ6fzQ5H58U2YX9pWAZ1Gyp6vbfNYSNNIPe1ojTHRtMXayGuj0HC5OhtsAljhOj
        hu6MZ8TQh6w6+EGG8zHKij+HY60jpnGmU3ikImCWiFy/VoCZeiVMhqd2EfMBxUc27xN
        8nl4VnmgKHLo5es0GEz9sj2TqeatBaQXh+P4dLP4=
Received: from edelgard.icenowy.me (59.41.163.66 [59.41.163.66]) by mx.zohomail.com
        with SMTPS id 1654671930603545.7452579301226; Wed, 8 Jun 2022 00:05:30 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 4/7] phy: sun4i-usb: add support for the USB PHY on F1C100s SoC
Date:   Wed,  8 Jun 2022 15:04:49 +0800
Message-Id: <20220608070452.338006-5-uwu@icenowy.me>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220608070452.338006-1-uwu@icenowy.me>
References: <20220608070452.338006-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The F1C100s SoC has one USB OTG port connected to a MUSB controller.

Add support for its USB PHY.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index d5f3b42eb8ce..f6592c8d611b 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -109,6 +109,7 @@ enum sun4i_usb_phy_type {
 	sun8i_v3s_phy,
 	sun50i_a64_phy,
 	sun50i_h6_phy,
+	suniv_f1c100s_phy,
 };
 
 struct sun4i_usb_phy_cfg {
@@ -859,6 +860,14 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct sun4i_usb_phy_cfg suniv_f1c100s_cfg = {
+	.num_phys = 1,
+	.type = suniv_f1c100s_phy,
+	.disc_thresh = 3,
+	.phyctl_offset = REG_PHYCTL_A10,
+	.dedicated_clocks = true,
+};
+
 static const struct sun4i_usb_phy_cfg sun4i_a10_cfg = {
 	.num_phys = 3,
 	.type = sun4i_a10_phy,
@@ -988,6 +997,8 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun50i-a64-usb-phy",
 	  .data = &sun50i_a64_cfg},
 	{ .compatible = "allwinner,sun50i-h6-usb-phy", .data = &sun50i_h6_cfg },
+	{ .compatible = "allwinner,suniv-f1c100s-usb-phy",
+	  .data = &suniv_f1c100s_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
-- 
2.36.0

