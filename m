Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5433B495CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379768AbiAUJeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:34:44 -0500
Received: from comms.puri.sm ([159.203.221.185]:56224 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379757AbiAUJem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:34:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 992BCE007A;
        Fri, 21 Jan 2022 01:34:11 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wYRX_LIbK8PC; Fri, 21 Jan 2022 01:34:11 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 1/2] arm64: dts: imx8mq: fix mipi_csi bidirectional port numbers
Date:   Fri, 21 Jan 2022 10:33:25 +0100
Message-Id: <20220121093326.2388251-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220121093326.2388251-1-martin.kepplinger@puri.sm>
References: <20220121093326.2388251-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port numbers for the imx8mq mipi csi controller are wrong and
the mipi driver can't find any media devices as port@1 is connected
to the CSI bridge, not port@0. And port@0 is connected to the
source - the sensor. Fix this.

Fixes: bcadd5f66c2a ("arm64: dts: imx8mq: add mipi csi phy and csi bridge descriptions")
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 2df2510d0118..bb68c94c2fc9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1151,8 +1151,8 @@ ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					port@0 {
-						reg = <0>;
+					port@1 {
+						reg = <1>;
 
 						csi1_mipi_ep: endpoint {
 							remote-endpoint = <&csi1_ep>;
@@ -1203,8 +1203,8 @@ ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
-					port@0 {
-						reg = <0>;
+					port@1 {
+						reg = <1>;
 
 						csi2_mipi_ep: endpoint {
 							remote-endpoint = <&csi2_ep>;
-- 
2.30.2

