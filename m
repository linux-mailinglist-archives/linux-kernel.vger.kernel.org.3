Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039984960D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381166AbiAUO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:29:57 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51340 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381116AbiAUO3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:29:40 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20LETaRT090854;
        Fri, 21 Jan 2022 08:29:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1642775376;
        bh=geTKBI8WcaqTTS2xGO8mgqJx5isSEGQvCDZZMic/QRg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sq4zjGumCoKtxJMSsf2jj2nwE3D0WD6omJqEiaSVD8O/SagQGCHw/68Xugx0ABXct
         fn46LRvJC3ZcE2rCUB5637GD7MAfefaBoegYvTWb2+X2ICiZ1VAWWVaS8LaqDFhBGc
         SCpbsJ8g2rR8Wunhtqa2/IcM1xS5XZn3sbApPV6s=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20LETad1065089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jan 2022 08:29:36 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 21
 Jan 2022 08:29:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 21 Jan 2022 08:29:35 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20LET4Hs072129;
        Fri, 21 Jan 2022 08:29:32 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
Subject: [PATCH v6 07/14] media: cadence: csi2rx: Fix stream data configuration
Date:   Fri, 21 Jan 2022 19:58:57 +0530
Message-ID: <20220121142904.4091481-8-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121142904.4091481-1-p.yadav@ti.com>
References: <20220121142904.4091481-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, there is no VC_EN bit present in the STREAM_DATA_CFG register.
Bit 31 is part of the VL_SELECT field. Remove it completely.

Secondly, it makes little sense to enable ith virtual channel for ith
stream. Sure, there might be a use-case that demands it. But there might
also be a use case that demands all streams to use the 0th virtual
channel. Prefer this case over the former because it is less arbitrary
and also makes it very clear what the limitations of the current driver
is instead of giving a false impression that multiple virtual channels
are supported.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

(no changes since v1)

 drivers/media/platform/cadence/cdns-csi2rx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 5cc18fe0f1b9..f072e5111240 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -48,7 +48,6 @@
 #define CSI2RX_STREAM_STATUS_RDY			BIT(31)
 
 #define CSI2RX_STREAM_DATA_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x008)
-#define CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT		BIT(31)
 #define CSI2RX_STREAM_DATA_CFG_VC_SELECT(n)		BIT((n) + 16)
 
 #define CSI2RX_STREAM_CFG_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x00c)
@@ -270,8 +269,11 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF,
 		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
 
-		writel(CSI2RX_STREAM_DATA_CFG_EN_VC_SELECT |
-		       CSI2RX_STREAM_DATA_CFG_VC_SELECT(i),
+		/*
+		 * Enable one virtual channel. When multiple virtual channels
+		 * are supported this will have to be changed.
+		 */
+		writel(CSI2RX_STREAM_DATA_CFG_VC_SELECT(0),
 		       csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i));
 
 		writel(CSI2RX_STREAM_CTRL_START,
-- 
2.34.1

