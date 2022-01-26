Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DAA49D3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiAZVBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiAZVBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:01:44 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE809C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:01:43 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b22so745392qkk.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oCWuC818kxptSSDVBuEBTaU6eMFMBR0V0DEYlw49JmI=;
        b=WBd1S9ReDJVLCy600I/GwQ4fkCVbs4o8jCYoLM5Ga8rFrYobPBN3cVRi5KPUyVHAvX
         PAbMzcDUWZ86T1lShRkuJd+mg/440U77DNFBvFtwVXMMKRYpMs8FC9OvkTBznQagWYFK
         2Ys+mv4AsBola0xY8ohxKl61FA/3rCnzhp/9WU3Ypf02mSf3cvMaDDpKidl5tMp0XqDF
         yRr3lum6LzSkfpnVKWZgskut+D+gSMO0aVEkg+IluapNtRWrbabSAPg89TPRnH9xv7DC
         bcj9sb2wMRYBtOmmNbY63A1R0wEYudJMKK1ZpzNHRbrJN3DTRVWOj1pDKk+wX+QMddu8
         fmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oCWuC818kxptSSDVBuEBTaU6eMFMBR0V0DEYlw49JmI=;
        b=rFDzuv9avzSGJdAA/juo4ckeVMPtwyhYG+KI0N/3CdaqQmgtFUbQXofu3b0ElrtU4/
         MmHFjuSfqW0YiluRVs3Dwkfn68Q9FXOySnJw5Uyv9MokMERvZmyclpoBPCgX2vpCHXZs
         wkeHaTlNHpHKPfbY5qjw4fw5p1C/fMdZRKt2JLgvmugNPXnL37BzgIDJqpcSxKKkNlib
         C/7PFhWC0iEgDP6pZ/CF14pDBWQzGqjxEeo+rHkBWUmMuLeZvdqStze1sllubjf5dns2
         HnA3wruPz8ud51Sse3wmzTICGYvUlGbrE5TaI0F0cSk8a1FIkxSAnSyMBKxiw8I6U0AK
         QzNQ==
X-Gm-Message-State: AOAM531HySGE+Bo76tM4vC1gsItL6+Xbln6W7KRXpZtu01IYpYSzyiiP
        7ZsANhNVA7ZahJex9hCAsCE=
X-Google-Smtp-Source: ABdhPJzQwVBWVM0Of40I6QipLyaGCsyPdlGpui0r8AIQ5RKUGPZM8lcMOC7JoZi5KtQ7luELeGDmhA==
X-Received: by 2002:a37:9d42:: with SMTP id g63mr459670qke.83.1643230903092;
        Wed, 26 Jan 2022 13:01:43 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id m4sm237427qkp.117.2022.01.26.13.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:01:42 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Pierre-Hugues Husson <phh@phh.me>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: synopsys/dw-hdmi: set cec clock rate
Date:   Wed, 26 Jan 2022 16:01:37 -0500
Message-Id: <20220126210137.3065508-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hdmi-cec clock must be 32khz in order for cec to work correctly.
Ensure before enabling the clock we set it in order for the hardware to
work as expected.
Fixes hdmi-cec support on Rockchip devices.

Fixes: ebe32c3e282a ("drm/bridge: synopsys/dw-hdmi: Enable cec clock")

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
Changelog:
v2:
- Set the clock rate before enabling the clock
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 54d8fdad395f..65c16455b76a 100644
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
@@ -3341,6 +3344,10 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 		hdmi->cec_clk = NULL;
 		goto err_iahb;
 	} else {
+		ret = clk_set_rate(hdmi->cec_clk, HDMI_CEC_CLK_RATE);
+		if (ret)
+			dev_warn(hdmi->dev, "Cannot set HDMI cec clock rate: %d\n", ret);
+
 		ret = clk_prepare_enable(hdmi->cec_clk);
 		if (ret) {
 			dev_err(hdmi->dev, "Cannot enable HDMI cec clock: %d\n",
-- 
2.25.1

