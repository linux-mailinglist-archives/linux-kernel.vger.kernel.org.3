Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50889490A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiAQOR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiAQOR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:17:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F622C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:17:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso24096173wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJwsITSMY4QI1R0GyVDZJD0gSOxLKr++NG45dIxuuJs=;
        b=RIqG2RM1JSZMzH3Ltu70CUWzXiGPKZkk6KaXW/WMH4QnBcWgVffvRVOIPTxBFWHxNk
         QEK25D9g9Cofj5DtQrc5AhOtb0wXb7XMWB9w+2/BDyS8T87HBQ1q+KL15jwHX2m0rV/W
         YBdSd0Nc6gA87MRxxsfyisMmQIghcyXDqbXR2l/yUi7Zyf8NCDjnafAupzL2cIdPlcUl
         Q7jlKIqf49CRzNjKiMNhpe1uZb62jVfeUOgUzyzFJTmLBVfhqqoh764JVknbA/2R7JJy
         B0PkWyIYRAKppKAlHG+q44USoznorkTcX6G0FB8M4kaC2Wfta5+c4DwoRzVIMXBNsfLK
         k5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJwsITSMY4QI1R0GyVDZJD0gSOxLKr++NG45dIxuuJs=;
        b=K+HgbH97SYhA4EzEsvK/cIjE/kbGgZuwXatKwrPrfPJz1WhmxAZXvzM5QBpITawRQI
         A3RlYPtkDwcl2XOCZjrWb+z0VsvWw3v9MLntyX/lmE2tHySZeFB+VsgK8DXuS8QFeik0
         oVHNynmEUtkRujhwNeZZ05vfo3pL1u8pXMaMpVj4G0mnLbsf5TiAsVcVNbf61iFD8YZj
         Txe/EW8RybHAvn3CcU73qjpGJrQ+T1K8TBRdhA5ve3QjMPQp52wCd7Y/6EVbtjdYqWsY
         4eVx2R4wd+EAU+GXjWIW5SRui7I52M0ziGUnRcr8brZCRowhgoUKCqLujchxV7CV7sYS
         dqgw==
X-Gm-Message-State: AOAM5321B/w0qSaSA0dQJQ+67dh7Ucrt5wIkJvxnDIzHjrH96LRFOm+e
        uxUJV70S2M4kXVt6bmddXHDkdA==
X-Google-Smtp-Source: ABdhPJx2Lp6ss2rXVGBn2sErjrUmZPIzPgpqhB8Kd0/S/liD97bAVpi21dNqow/jsz25iV/zAWV9AQ==
X-Received: by 2002:a5d:5849:: with SMTP id i9mr7839177wrf.358.1642429076455;
        Mon, 17 Jan 2022 06:17:56 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:c004:9fe1:fbda:2d0c])
        by smtp.gmail.com with ESMTPSA id f141sm7975972wmf.30.2022.01.17.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 06:17:55 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robert.foss@linaro.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com,
        biju.das.jz@bp.renesas.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH] drm/bridge: dw-hdmi: use safe format when first in bridge chain
Date:   Mon, 17 Jan 2022 15:17:50 +0100
Message-Id: <20220117141750.1182223-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the dw-hdmi bridge is in first place of the bridge chain, this
means there is now way to select an input format of the dw-hdmi HW
component.

Since introduction of display-connector, negociation was broken since
the dw-hdmi negociation code only worked when the dw-hdmi bridge was
in last position of the bridge chain or behind another bridge also
supporting input & output format negociation.

Commit 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts callbacks")
was introduced to make negociation work again by making display-connector
act as a pass-through concerning input & output format negociation.

But in the case were the dw-hdmi was single in the bridge chain, for
example on Renesas SoCs, with the disply-connector bridge the dw-hdmi
is no more single, breaking output format.

Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Bisected-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Fixes: 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts callbacks").
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 54d8fdad395f..9f2e1cac0ae2 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2551,8 +2551,9 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	if (!output_fmts)
 		return NULL;
 
-	/* If dw-hdmi is the only bridge, avoid negociating with ourselves */
-	if (list_is_singular(&bridge->encoder->bridge_chain)) {
+	/* If dw-hdmi is the first or only bridge, avoid negociating with ourselves */
+	if (list_is_singular(&bridge->encoder->bridge_chain) ||
+	    list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain)) {
 		*num_output_fmts = 1;
 		output_fmts[0] = MEDIA_BUS_FMT_FIXED;
 
@@ -2673,6 +2674,10 @@ static u32 *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	if (!input_fmts)
 		return NULL;
 
+	/* If dw-hdmi is the first bridge fall-back to safe output format */
+	if (list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain))
+		output_fmt = MEDIA_BUS_FMT_FIXED;
+
 	switch (output_fmt) {
 	/* If MEDIA_BUS_FMT_FIXED is tested, return default bus format */
 	case MEDIA_BUS_FMT_FIXED:
-- 
2.25.1

