Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9329A49D360
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiAZUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiAZUYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:24:50 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDEEC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:24:50 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id j12so443772qtr.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jx0fEdivrdIheYkmyUPfrhwIwpeLJHBEwq8uDdSjGFg=;
        b=nmmplP3DBvZ0FwYQd0TzFsbhI5oKxxSkpNdZtEXTpy6RAUjjL1zKnr075WtAw3Mf7j
         /R2PePkGFB+qf0lOPWUFU5ZRK/DOlsQmvZKJRa2YjM2tjoL6ZUmUN7e0Xk0Cl4jub/1K
         5dpsUF0FaBmHxtkNEaCMO6c2BcaQ/bhWTMKDRr/aXwzS1y7o6ctNg7n6y0VyGIimhqaS
         336VUgUXwWjxDWvVlT1vCHurjqIAjzbRdio4W8HrRA72txkvsZCjnFOSD5HIdwHWdfyK
         VhdlJJufslYZGSXlyU22yI/tDnE6FP/ueYbrGB0wAsiLhTCkT3XUNQWMDR0fme37CW0Z
         +m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jx0fEdivrdIheYkmyUPfrhwIwpeLJHBEwq8uDdSjGFg=;
        b=5NmhT4hJgPtQczDf3NU6Zwv27DV7otySjxJTZncuISEQ00WHcrlwwXQh2NQSCWwNTc
         VotT/bsc5bnsIXN9OJdSESmdzDkm4UIzbKus9jmI9UAXRTMbwigt080cPJJTjWMwtS8V
         MWA7VGBlFahC8h/ahGkGH0ZjmdyhkoYnr4kxau8YaM5kSSmHWbZRNegbP+x0xLhbYS6m
         1Kei4nRlQQfMk+zNG0WQmyH6t5q3VRkKJM780zeyQOchZnB2S/Phu+rBcml4oMf8XWiO
         rydH3a4eH9gdHCdof4/dZDlzDVV5J45fHW6rW/uuF0bQGFgJyNa63c7J8tujQrtzn+Fz
         M9CQ==
X-Gm-Message-State: AOAM532fyQnPPDu0eia+cYk38gdrTxtCsPZByzsnP4XaAscEXdtI0u9d
        VkmpagW8zqahJmhGwg3Fs9DDVvIPI0HM+g==
X-Google-Smtp-Source: ABdhPJzIvG8w863V8BukY+aumjHs5OcXH1DEGp8Dr6rScyQRiIvp25H6dbt8r+PUW3hnebEVDZor7Q==
X-Received: by 2002:ac8:74cc:: with SMTP id j12mr355803qtr.374.1643228689310;
        Wed, 26 Jan 2022 12:24:49 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id a21sm155311qta.65.2022.01.26.12.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:24:49 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pierre-Hugues Husson <phh@phh.me>,
        Archit Taneja <architt@codeaurora.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: synopsys/dw-hdmi: set cec clock rate
Date:   Wed, 26 Jan 2022 15:24:26 -0500
Message-Id: <20220126202427.3047814-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hdmi-cec clock must be 32khz in order for cec to work correctly.
Ensure after enabling the clock we set it in order for the hardware to
work as expected.
Warn on failure, in case this is a static clock that is slighty off.
Fixes hdmi-cec support on Rockchip devices.

Fixes: ebe32c3e282a ("drm/bridge: synopsys/dw-hdmi: Enable cec clock")

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 54d8fdad395f..1a96da60e357 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -48,6 +48,9 @@
 
 #define HDMI14_MAX_TMDSCLK	340000000
 
+/* HDMI CEC needs a clock rate of 32khz */
+#define HDMI_CEC_CLK_RATE	32768
+
 enum hdmi_datamap {
 	RGB444_8B = 0x01,
 	RGB444_10B = 0x03,
@@ -3347,6 +3350,10 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 				ret);
 			goto err_iahb;
 		}
+
+		ret = clk_set_rate(hdmi->cec_clk, HDMI_CEC_CLK_RATE);
+		if (ret)
+			dev_warn(hdmi->dev, "Cannot set HDMI cec clock rate: %d\n", ret);
 	}
 
 	/* Product and revision IDs */
-- 
2.25.1

