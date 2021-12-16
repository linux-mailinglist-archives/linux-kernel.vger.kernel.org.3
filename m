Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4B47776B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbhLPQMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:12:39 -0500
Received: from finn.gateworks.com ([108.161.129.64]:36012 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238952AbhLPQMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:12:35 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1mxtMr-0093Cq-N1; Thu, 16 Dec 2021 16:12:29 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Tim Harvey <tharvey@gateworks.com>, Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] arm64: dts: imx8mn-venice-gw7902: disable gpu
Date:   Thu, 16 Dec 2021 08:12:27 -0800
Message-Id: <20211216161227.31960-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 99aa29932271 ("arm64: dts: imx8mn: Enable GPU")
imx8mn-venice-gw7902 will hang during kernel init because it uses
a MIMX8MN5CVTI which does not have a GPU.

Disable pgc_gpumix to work around this. We also disable the GPU devices
that depend on the gpumix power domain and pgc_gpu to avoid them staying
in a probe deferred state forever.

Cc: Adam Ford <aford173@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../boot/dts/freescale/imx8mn-venice-gw7902.dts      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 236f425e1570..2d58005d20e4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -220,6 +220,10 @@
 	};
 };
 
+&disp_blk_ctrl {
+	status = "disabled";
+};
+
 /* off-board header */
 &ecspi2 {
 	pinctrl-names = "default";
@@ -251,6 +255,10 @@
 	};
 };
 
+&gpu {
+	status = "disabled";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -546,6 +554,10 @@
 	status = "okay";
 };
 
+&pgc_gpumix {
+	status = "disabled";
+};
+
 /* off-board header */
 &sai3 {
 	pinctrl-names = "default";
-- 
2.17.1

