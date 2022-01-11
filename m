Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8F248AAE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348264AbiAKJxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348238AbiAKJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:53:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2DFC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:53:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso1448427wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVh5nRmY/laQhXrJmZ8gLshP64K+NMdNAMHCgvzKe+U=;
        b=6sSuM/3s50L4vZ3q/tD7Z88/0gOxnko+TEETOKMcYK0cz7E3XMCiSyZcHcbtxNmSIg
         YW7hmCNasCfQs6VaJ5DK59epYQ1PdwwPQ+zIvAJFU6OvzhavqpLWmWE8bCa79TkTQgNV
         /CoQ8R5cgwTaVWgusSQBbGXmT5kjNqcHhpFPu68Tf1jeHbkREoDg75Kmj0GeF8ZdqrG8
         jqOxrtolkcjfBhN3+UFYs3IYXs95/d4epNrgZpmPVayBHXPWJPqTWeBlz8yk5cnGTLSL
         z7YL3dQNbIYM0AV8RTmPRPUlz6a/Kdjk6tQMuEeittcRceBEkVYLcvRZPzLI8302rbke
         o37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVh5nRmY/laQhXrJmZ8gLshP64K+NMdNAMHCgvzKe+U=;
        b=NGjq8KYSeAxPYuevufOCT6EmPWPf/S+TRPz6EJlwOqYJFeTvthMbjHNohDIATEzviq
         ZiZuEaOchjl72G1gAx7r+FmL8xGx+pOLG8NqllEfQV7aETkRoMFBi1a8Qe1wAsvjYuey
         DIXmQUYKPXvl1H8ZTUtuHyzuATQTk3fPEwHj6Ig/NZ720n4gQwZ47nKs0AiPyA34Gz6I
         DQMgMaNKIyZ1vht2AJpJTVYdBF6bTn9AjiR/ugVw7NaCaXhzrmVhvqjNSpRh348IWFKC
         Q05OoZsQkQGWYSdxFwFnTc+iV0ARHcEyao9PxBQjutFeClR8fv5qNMcwprU+T5xXT248
         H4Aw==
X-Gm-Message-State: AOAM533IYpuoyRgv1nyrZEzPYcSVYwjERWwpjHxb8LqKdXwR15ZggRKi
        1qKmY196aDk6LF0NDWZCYy11EQ==
X-Google-Smtp-Source: ABdhPJwc1I2GFw4Edw3Pe2DmYcavGYaYA9rtbMrUDdxBE5NcWt8EiDMa+1O+zf3FSo416HYOiZvXFA==
X-Received: by 2002:a05:600c:1c22:: with SMTP id j34mr1757958wms.1.1641894811138;
        Tue, 11 Jan 2022 01:53:31 -0800 (PST)
Received: from localhost.localdomain (203.247.120.78.rev.sfr.net. [78.120.247.203])
        by smtp.googlemail.com with ESMTPSA id l18sm1248916wms.24.2022.01.11.01.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 01:53:30 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     kishon@ti.com
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        p.zabel@pengutronix.de, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-phy@lists.infradead.org,
        vkoul@kernel.org, linux-usb@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v6 3/3] phy: amlogic: meson8b-usb2: fix shared reset control use
Date:   Tue, 11 Jan 2022 10:52:55 +0100
Message-Id: <20220111095255.176141-4-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111095255.176141-1-aouledameur@baylibre.com>
References: <20220111095255.176141-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use reset_control_rearm() call if an error occurs in case
phy_meson8b_usb2_power_on() fails after reset() has been called, or in
case phy_meson8b_usb2_power_off() is called i.e the resource is no longer
used and the reset line may be triggered again by other devices.

reset_control_rearm() keeps use of triggered_count sane in the reset
framework, use of reset_control_reset() on shared reset line should
be balanced with reset_control_rearm().

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 77e7e9b1428c..dd96763911b8 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -154,6 +154,7 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 	ret = clk_prepare_enable(priv->clk_usb_general);
 	if (ret) {
 		dev_err(&phy->dev, "Failed to enable USB general clock\n");
+		reset_control_rearm(priv->reset);
 		return ret;
 	}
 
@@ -161,6 +162,7 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 	if (ret) {
 		dev_err(&phy->dev, "Failed to enable USB DDR clock\n");
 		clk_disable_unprepare(priv->clk_usb_general);
+		reset_control_rearm(priv->reset);
 		return ret;
 	}
 
@@ -199,6 +201,7 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 				dev_warn(&phy->dev, "USB ID detect failed!\n");
 				clk_disable_unprepare(priv->clk_usb);
 				clk_disable_unprepare(priv->clk_usb_general);
+				reset_control_rearm(priv->reset);
 				return -EINVAL;
 			}
 		}
@@ -218,6 +221,7 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
 
 	clk_disable_unprepare(priv->clk_usb);
 	clk_disable_unprepare(priv->clk_usb_general);
+	reset_control_rearm(priv->reset);
 
 	/* power off the PHY by putting it into reset mode */
 	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET,
-- 
2.25.1

