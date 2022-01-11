Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E02648AADF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347895AbiAKJxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbiAKJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:53:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB082C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:53:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h10so21704577wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 01:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6Yer5+RWHiyObPhotCHoiFwGst2nUMplE/Hr1jBYzE=;
        b=MtHy2/o5zHgO8+sJV/wnvVbtlrq1TJ91C7S2Svaj8kMIvVs/fN8SgftynhA8fdVzLM
         GuscKOjixI81rAfR4+bdBfTJVpp8eccZWs7tsA9l7NUUQDWrbY0WbRlYg/lOeeVet4oR
         QfAywxQOQ7Xzo6FVTOrZS0vguVruguSqgJI7mzxloZt6qozPyPJ+4q5LZlP4FZTvwpL8
         aqzPDd97RJPgMG3lGiOYYe5wm1YwumO7NSXgW7q3oXdvPJTCRu4OY48k1jQgyD5fePnD
         lDhFEHApicdmD8oN3Yb+nDk2xxWK4WMFMbzuMDyqXz5lSLSYxCfEfo597HgtFYFVBv/i
         v/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6Yer5+RWHiyObPhotCHoiFwGst2nUMplE/Hr1jBYzE=;
        b=On6ZF4G/rN9VN2xtRwWskkH34qS/+knRs8J8N5JELE7TDiTIjegyBf5c7z1mYJRw3R
         imbsDBESPJ0xhnfRK31SHAoxCw2pjp5o0NZVSG1+FtSS4H09BeqwTiissZXd3gPEYIy9
         Bf//5DtcSRknuOEOJxsJ77aZLge5Q2EKegK0Dl8AzG+1Ke79wJtf0Wk7qQquNrwM4pjs
         CFo4p5jsc3Mq/ukV7PPg3qFrfSAlbzze37qIF3GcqANot+WpXdHhhhReks90F8cIX2Jl
         Eu7L9cArgcUfDUnBXGAzDEiPpAQDF9sjSnPxkW4gQ/wyjDFhnp3ymHVW4v0C1FAQ6MEc
         4Xlw==
X-Gm-Message-State: AOAM5317DgkLpYNRi0YhsvR5RbGJ8cTrlRyWLUawT8C1rFCMj16q4BhP
        2/bmcnDT/+EUllHKN3g+zCYIww==
X-Google-Smtp-Source: ABdhPJxc5sOJVxSZJOZnTg+H3RQ07fBd5zkYR0tA00iUMUXkJkJDgdj9028tmtOW7O5yrH5JXHg8RQ==
X-Received: by 2002:a5d:6b8e:: with SMTP id n14mr3122306wrx.537.1641894801554;
        Tue, 11 Jan 2022 01:53:21 -0800 (PST)
Received: from localhost.localdomain (203.247.120.78.rev.sfr.net. [78.120.247.203])
        by smtp.googlemail.com with ESMTPSA id l18sm1248916wms.24.2022.01.11.01.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 01:53:21 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     kishon@ti.com
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        p.zabel@pengutronix.de, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, khilman@baylibre.com, vkoul@kernel.org,
        linux-phy@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v6 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
Date:   Tue, 11 Jan 2022 10:52:53 +0100
Message-Id: <20220111095255.176141-2-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111095255.176141-1-aouledameur@baylibre.com>
References: <20220111095255.176141-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use reset_control_rearm() call if an error occurs in case
phy_meson_gxl_usb2_init() fails after reset() has been called ; or in case
phy_meson_gxl_usb2_exit() is called i.e the resource is no longer used
and the reset line may be triggered again by other devices.

reset_control_rearm() keeps use of triggered_count sane in the reset
framework. Therefore, use of reset_control_reset() on shared reset line
should be balanced with reset_control_rearm().

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/phy-meson-gxl-usb2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
index 2b3c0d730f20..db17c3448bfe 100644
--- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
@@ -114,8 +114,10 @@ static int phy_meson_gxl_usb2_init(struct phy *phy)
 		return ret;
 
 	ret = clk_prepare_enable(priv->clk);
-	if (ret)
+	if (ret) {
+		reset_control_rearm(priv->reset);
 		return ret;
+	}
 
 	return 0;
 }
@@ -125,6 +127,7 @@ static int phy_meson_gxl_usb2_exit(struct phy *phy)
 	struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
 
 	clk_disable_unprepare(priv->clk);
+	reset_control_rearm(priv->reset);
 
 	return 0;
 }
-- 
2.25.1

