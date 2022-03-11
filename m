Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641E34D63D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbiCKOjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349573AbiCKOhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:39 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733531C9468;
        Fri, 11 Mar 2022 06:36:32 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B8262240008;
        Fri, 11 Mar 2022 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWC8UV10AFRXwQVKEyuL0EJsXyCUBUdFgxYAqrwrG+w=;
        b=ZCpuy2uQpzT7nmclRYOAvCI4yYxIehY5CC+w+Fx9ZVy37XB7uf85+3MDo3uFUU8NfDwp4P
        Vkm0Bhnk+rMjZtw+9CCtIuN6aQQzBVS8qMydjs/RaMRDlC7rTSbOvDYBoZPHclD0Y4RECc
        VlLtRYr4ob/EgBFxwB1wEuRCR+ERS9WnNXJ41teXOyVUU6Ia3PLo99moVmwtOMKVjdDEpj
        CrWFEmLANeE4mdMhokVO9zqj4ePPRxa7Fc+4MH/Jbu9/YyStnc1ir0TBdr3Z/2raAVYWzD
        ifc90MDDH4jmPWKTJrkM6OUmRNF6KC+n3GiVeozf2Gyp2JewjIrZPByGdezrdA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 27/46] media: sun6i-csi: Add bridge dimensions and format helpers
Date:   Fri, 11 Mar 2022 15:35:13 +0100
Message-Id: <20220311143532.265091-28-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new helpers to ease getting information about the bridge.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 20 +++++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index 33309423d1e6..8009b281cbb6 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -12,6 +12,26 @@
 #include "sun6i_csi.h"
 #include "sun6i_csi_bridge.h"
 
+/* Helpers */
+
+void sun6i_csi_bridge_dimensions(struct sun6i_csi_device *csi_dev,
+				 unsigned int *width, unsigned int *height)
+{
+	if (width)
+		*width = csi_dev->bridge.mbus_format.width;
+	if (height)
+		*height = csi_dev->bridge.mbus_format.height;
+}
+
+void sun6i_csi_bridge_format(struct sun6i_csi_device *csi_dev,
+			     u32 *mbus_code, u32 *field)
+{
+	if (mbus_code)
+		*mbus_code = csi_dev->bridge.mbus_format.code;
+	if (field)
+		*field = csi_dev->bridge.mbus_format.field;
+}
+
 /* Format */
 
 static const u32 sun6i_csi_bridge_mbus_codes[] = {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
index 55be292d308c..ee90ff6a6f75 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
@@ -42,6 +42,13 @@ struct sun6i_csi_bridge {
 	struct sun6i_csi_bridge_source	*source;
 };
 
+/* Helpers */
+
+void sun6i_csi_bridge_dimensions(struct sun6i_csi_device *csi_dev,
+				 unsigned int *width, unsigned int *height);
+void sun6i_csi_bridge_format(struct sun6i_csi_device *csi_dev,
+			     u32 *mbus_code, u32 *field);
+
 /* Bridge */
 
 int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev);
-- 
2.35.1

