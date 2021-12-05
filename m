Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86FD468D8A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 22:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbhLEWCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239569AbhLEWC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:02:29 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C93C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 13:59:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so35115134edd.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 13:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kg/EoUTvtJCV0eIOzDDw+a6fO7fnDbKWvif2j9QvU1k=;
        b=0jJjPzSB7Fr9IOmpAWko2usGi6G/gq1tsZf77t3EBt/V8TebTy+bB3tuuQ67tI9A8J
         W2JmJ5Q+UGzJkQggad7OqTJyJlgGYKegNGa74yG++PRfpu/NbxsjoVCB82YNi6EY9TbI
         E86uK3wKF4jnatmn7I+qmIXvxkWOJQtWco/OAXUQ1m3HynXc8A1g3s4YUgexmdjy+2Kh
         G3KNUNGkwm59fvzUsnBSeWaH//I1RwkSSPWI7lS/RuC1Z6HsCYia2tfAj0px6VGxhouM
         0CVi/KJf2cYmon2jgQ6SahAQrjXsDef7xzqTJzh1wYhiC7h2jxB+hd0kjNx4h12bnPBk
         vFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg/EoUTvtJCV0eIOzDDw+a6fO7fnDbKWvif2j9QvU1k=;
        b=TPjsePxFnBwimlCa/IL3gocahINghD4zqQzhHODVPwMZUFQiDScpKUi8Q1+MR1EJhx
         XkmmSuY1GupblokgItU9AD+8j9hvnisFM5gEJVpDcGclI1IwILftCWWSPphhfhW8bce1
         4tdD6VXpYpVFf3zyI3m2o0BNDgtJVqrwQairZk88SR7fuvND4sIcvq8s8RtoJX3vgU88
         xvqhrnU1T4I7v6fUxNme9jH37XZI/xgesvwzAbby/aUPH5F2OVzPrWBPe5Dwp25xdTI6
         0QKLryw+4WHwYmgfKYgO1m+RKrYYlSp5JCAEsJNaPea7VYFMCIWdpk3sCXRpIUwDYD9E
         eNGg==
X-Gm-Message-State: AOAM532VAwwIt5P2jLwbeqjF2QTzsJoUI8/h/aWUw5vpjmQdmjx/Gqw8
        2Jz96KeyLp7RQYnpAPPhOxkMvw==
X-Google-Smtp-Source: ABdhPJwMycCNqTJai4Fogj0S3vU9tnOWsCUMPXRynIPwKaqrJ8Vk7a5yVoJu72xQZYkFI2xyE7u5aQ==
X-Received: by 2002:a17:907:a0d4:: with SMTP id hw20mr41300607ejc.16.1638741540143;
        Sun, 05 Dec 2021 13:59:00 -0800 (PST)
Received: from localhost.localdomain (203.247.120.78.rev.sfr.net. [78.120.247.203])
        by smtp.googlemail.com with ESMTPSA id nc29sm5724291ejc.3.2021.12.05.13.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 13:58:59 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     khilman@baylibre.com
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        p.zabel@pengutronix.de, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v4 3/3] phy: amlogic: meson8b-usb2: fix shared reset control use
Date:   Sun,  5 Dec 2021 22:58:46 +0100
Message-Id: <20211205215846.153703-4-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205215846.153703-1-aouledameur@baylibre.com>
References: <20211205215846.153703-1-aouledameur@baylibre.com>
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

