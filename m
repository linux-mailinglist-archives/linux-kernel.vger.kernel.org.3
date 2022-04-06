Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6864F5E13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiDFMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiDFMjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:39:07 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 341DD26AE34
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:41:45 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CA5791A06DE;
        Wed,  6 Apr 2022 10:40:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 802B81A129E;
        Wed,  6 Apr 2022 10:40:13 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 663E1183AC8A;
        Wed,  6 Apr 2022 16:40:11 +0800 (+08)
From:   Sandor.yu@nxp.com
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com
Cc:     Sandor.yu@nxp.com, shengjiu.wang@nxp.com, cai.huoqing@linux.dev,
        maxime@cerno.tech, harry.wentland@amd.com,
        hverkuil-cisco@xs4all.nl, amuel@sholland.org
Subject: [PATCH v1 2/5] drm: bridge: dw_hdmi: enable overflow workaround for v2.13a
Date:   Wed,  6 Apr 2022 16:48:34 +0800
Message-Id: <5339589121b05c0db7ee4befdc48c7e4ab4f1653.1649230434.git.Sandor.yu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1649230434.git.Sandor.yu@nxp.com>
References: <cover.1649230434.git.Sandor.yu@nxp.com>
In-Reply-To: <cover.1649230434.git.Sandor.yu@nxp.com>
References: <cover.1649230434.git.Sandor.yu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandor Yu <Sandor.yu@nxp.com>

iMX865 HDMI (v2.13a) have been identified as needing the workaround.
Tests show that one iteration is enough.

Without the workaround, iMX865 HDMI audio may not work
after cable plugout/in, because HDMI mode is not really set in
register HDMI_FC_INVIDCONF.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 4befc104d220..b11577de4836 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2087,9 +2087,9 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 	 *
 	 * The number of iterations matters and depends on the HDMI TX revision
 	 * (and possibly on the platform). So far i.MX6Q (v1.30a), i.MX6DL
-	 * (v1.31a) and multiple Allwinner SoCs (v1.32a) have been identified
-	 * as needing the workaround, with 4 iterations for v1.30a and 1
-	 * iteration for others.
+	 * (v1.31a), iMX865(v2.13a) and multiple Allwinner SoCs (v1.32a)
+	 * have been identified as needing the workaround,
+	 * with 4 iterations for v1.30a and 1 iteration for others.
 	 * The Amlogic Meson GX SoCs (v2.01a) have been identified as needing
 	 * the workaround with a single iteration.
 	 * The Rockchip RK3288 SoC (v2.00a) and RK3328/RK3399 SoCs (v2.11a) have
@@ -2106,6 +2106,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 	case 0x201a:
 	case 0x211a:
 	case 0x212a:
+	case 0x213a:
 		count = 1;
 		break;
 	default:
-- 
2.25.1

