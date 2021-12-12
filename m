Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC1471CEF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 21:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhLLUUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 15:20:02 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:42633 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLLUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 15:19:55 -0500
Received: by mail-wm1-f50.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so10398007wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 12:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kg/EoUTvtJCV0eIOzDDw+a6fO7fnDbKWvif2j9QvU1k=;
        b=pcjNcXo7dFjKe9b3PBWARFRWZr4FFcHxkOlewPzmHYW8JxHjngMhrx0q+knnJqVDab
         QNJvLN85AfBHFPP8BiSpZQ6oXra++aByHtSUTJT43ycUaBS8gvZWDOhelrbn8xCY9vBl
         F+QBryo0cuQttHFEApUNveZJ2lGksjVT7MKTBvtqHFuMqxj2lFyREZkUPQfug759skRx
         TPXKV8Rky63hnwLWIYcZR3ULPibkwz7wUzgX0SNVR6KUJ/NL59u/Gnj5siakM1H3RX18
         mCmT9FYecMGk6isn6Lh1oDJPLBs56QfP2a+l/z2GQRpDo0Ao6lONSzrj3JBxGe1VWqqg
         wfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg/EoUTvtJCV0eIOzDDw+a6fO7fnDbKWvif2j9QvU1k=;
        b=rPsjd91jP4jQCreQe3FJjInNDnjXYJ89dRDH+IiBBUQBl271RjVf1LKmUAIv4ILNlq
         mSTlseFeEXQ5TMHlOyhp0GEU144bfWUGwTScvbiwbWF7dhu6mZ+Cpx2dStlrDH3vzoiq
         SPKpXfmZdGBIXm7ePGVmSE2ydqYvfScfOvzJ6+FinsT+uta32xil/lsJtdzs6y3ANZEH
         mVy3S+LBNE3IEXI6qz5XaGG1rvxzSJuC+XRemsS3m9qmXHWsPBBH8bEt0x9svjBm+CNu
         kZrw7NTX1a/BdLO5v9Itkjt7DMiUC7bp8lpkt0lWYKmWAXQKt4dZxHnRa/8a+A2ccreh
         Ifig==
X-Gm-Message-State: AOAM5322ZWu1nx7NSORaonaj7aD5TQBc091w5vUvxdv/fqFuxfhz7Qs+
        das8zWZldI6gZ3GF1qT/RcQfeg==
X-Google-Smtp-Source: ABdhPJwgdpYCgr0z0RkhIAAroY4dPi0MQtlkklljD6krZXWkI9iwaVuD8lv9C9Q0BP7oIqg6Dm7GiQ==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr32689470wmi.44.1639340333806;
        Sun, 12 Dec 2021 12:18:53 -0800 (PST)
Received: from localhost.localdomain (203.247.120.78.rev.sfr.net. [78.120.247.203])
        by smtp.googlemail.com with ESMTPSA id p5sm9092710wrd.13.2021.12.12.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:18:53 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     khilman@baylibre.com
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        p.zabel@pengutronix.de, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v5 3/3] phy: amlogic: meson8b-usb2: fix shared reset control use
Date:   Sun, 12 Dec 2021 21:18:44 +0100
Message-Id: <20211212201844.114949-4-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211212201844.114949-1-aouledameur@baylibre.com>
References: <20211212201844.114949-1-aouledameur@baylibre.com>
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

