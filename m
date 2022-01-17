Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D090948FFC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 01:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiAQAoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 19:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiAQAoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 19:44:01 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C24C061574;
        Sun, 16 Jan 2022 16:44:01 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u21so58674806edd.5;
        Sun, 16 Jan 2022 16:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fVBwHqjRiTPngWkNGF9zdvdA//oHQIGX1K8FVBmadoE=;
        b=ahBnotuLo2MHhRJNsnoJSvsPJeP0nuIPb74JifxhzfTNUva1Vmp1Vq4Zc6ZivaEViv
         9nq4+vSH2/FTECHhEJ5ZraYvkWRYoVPACRbUrsTyq04YFJlVjA84kPBFfByykgRgdoMr
         jLb8Vn6+kUjpFVcV9kzZs3cU9OGrLl8CE/fDn00mAdVmOzsRFFwAO7D0wh0wIp1ELnfW
         NmGahlbaSFhpcKXd3wSPcTtXW8eEj6PNOWnELVoei3BM6f1mImANOlqsHabqdzcteXxh
         NV75MnAUb9Mmjx/jNPhOnmIKw6ZiFM97QBQWZ052DWG/yyCkLf8r7UTvLzr+wm0GQX/l
         joLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fVBwHqjRiTPngWkNGF9zdvdA//oHQIGX1K8FVBmadoE=;
        b=iS5Irj0tVBABnki8KJlsrxcuTYwJp/aeFHh8Je94zLlKjbOWbOZO9s2i9WzKwKoRqZ
         kDm7Y/UNoUavej+jOSMnFDZ6pTWqzVFmQQAZyn4V7KqNBUH29jY0+jq39M9TtoD1LF0k
         12hGM66dGIvdOlLESEr1UXzjF5rfRO/GBb4uPerIYqZeY6JnfDoQLgUCrO29xgY8FZNK
         obZxI8nuLBYnR0FFQC21j2qhvlZcqbF/1DnqgFHu2tqTH/+2ylcdmrAcdceiBy8A5Jik
         6Imw1NRe3gSFLxlSJqK/h6D70kNyT1LDTCzpVzKgWpDt9kch4YxwlbSK2ojY8X9MzSG5
         QYgQ==
X-Gm-Message-State: AOAM533x7WhE7Im3JnDMKWkznls0iaKk/gQJgQpEyXNmFV2dSetuLddV
        4NbctFxaDXnV6oPctd3x0Zb3ZaKRFlM=
X-Google-Smtp-Source: ABdhPJzueh6U+3ebTRaJF4BFO4gi/HSDdXR09qU0X172/JUL/EVbKDFdN4yPWzvoVNgrxesnWeUZ1A==
X-Received: by 2002:a05:6402:1bd9:: with SMTP id ch25mr14458702edb.84.1642380239563;
        Sun, 16 Jan 2022 16:43:59 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id go41sm3879266ejc.200.2022.01.16.16.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 16:43:59 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] drivers: phy: qcom: ipq806x-usb: convert to BITFIELD macro
Date:   Mon, 17 Jan 2022 01:26:40 +0100
Message-Id: <20220117002641.26773-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert some define to BITFIELD macro to tidy things up.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
index bfff0c8c9130..6788e0e8272a 100644
--- a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <linux/bitfield.h>
 
 /* USB QSCRATCH Hardware registers */
 #define QSCRATCH_GENERAL_CFG		(0x08)
@@ -74,20 +75,20 @@
 		 PHY_PARAM_CTRL1_LOS_BIAS_MASK)
 
 #define PHY_PARAM_CTRL1_TX_FULL_SWING(x)	\
-		(((x) << 20) & PHY_PARAM_CTRL1_TX_FULL_SWING_MASK)
+		FIELD_PREP(PHY_PARAM_CTRL1_TX_FULL_SWING_MASK, (x))
 #define PHY_PARAM_CTRL1_TX_DEEMPH_6DB(x)	\
-		(((x) << 14) & PHY_PARAM_CTRL1_TX_DEEMPH_6DB_MASK)
+		FIELD_PREP(PHY_PARAM_CTRL1_TX_DEEMPH_6DB_MASK, (x))
 #define PHY_PARAM_CTRL1_TX_DEEMPH_3_5DB(x)	\
-		(((x) <<  8) & PHY_PARAM_CTRL1_TX_DEEMPH_3_5DB_MASK)
+		FIELD_PREP(PHY_PARAM_CTRL1_TX_DEEMPH_3_5DB_MASK, x)
 #define PHY_PARAM_CTRL1_LOS_BIAS(x)	\
-		(((x) <<  3) & PHY_PARAM_CTRL1_LOS_BIAS_MASK)
+		FIELD_PREP(PHY_PARAM_CTRL1_LOS_BIAS_MASK, (x))
 
 /* RX OVRD IN HI bits */
 #define RX_OVRD_IN_HI_RX_RESET_OVRD		BIT(13)
 #define RX_OVRD_IN_HI_RX_RX_RESET		BIT(12)
 #define RX_OVRD_IN_HI_RX_EQ_OVRD		BIT(11)
 #define RX_OVRD_IN_HI_RX_EQ_MASK		GENMASK(10, 7)
-#define RX_OVRD_IN_HI_RX_EQ(x)			((x) << 8)
+#define RX_OVRD_IN_HI_RX_EQ(x)			FIELD_PREP(RX_OVRD_IN_HI_RX_EQ_MASK, (x))
 #define RX_OVRD_IN_HI_RX_EQ_EN_OVRD		BIT(7)
 #define RX_OVRD_IN_HI_RX_EQ_EN			BIT(6)
 #define RX_OVRD_IN_HI_RX_LOS_FILTER_OVRD	BIT(5)
-- 
2.33.1

