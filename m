Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA1493A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350271AbiASMhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354706AbiASMhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:37:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3415C061771
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:37:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso5660725wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCSzim4chD2YZ1nYmMNUQu/jVANvmFwzUsxwlSkjcNs=;
        b=wZ+86cHu8by60Agnp1LSNhYjMgIjqTdNmvTULzONiNWLDnC/Pu6/zOmu/j4lE9pLJh
         oQC4FdupKTx5Fv8aq/4GC95rl+LCb1zLVz4RacPi2lbEtI8vGckDJLYCA9QQWFZCzhVs
         jRnZnAWkiE4yIK2+mCMbBiyMstokGQGvyEErREzQKhIzpxHeEL+5r1Ukpv+CAQjAuqd4
         QV1/iOyV+3NShPPDnszcc4FX0J1c/I2yjDC6ga7Z+d2AzpG6EQGhOJPmexLh+WOxJgl5
         Ay/w5+oLRIg5iuIm0ocOT2++SwIiB7xjpUAzaLsexUQbVCikOYzzqja42SDz4KOjIWvN
         6C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCSzim4chD2YZ1nYmMNUQu/jVANvmFwzUsxwlSkjcNs=;
        b=wArqL23LHO4rqbiCKNlKp0MgQHrFpAUUUxQd7wCa+afEmOqeMeS0+4mHywJjyTJWyb
         y8BlKSx+k9Z7n4r+AXe3FTCbi6CaX5vU0hZvbABuJOsrxDq9FiE29/qFgTjs889l84I4
         ga4yDPDq5JZt3X2TgC8nvWweY2N+lz+EqqsltOb6wpwKBq7WgULoV1bwCvKtcPefQ5wK
         1AZbVeSJ6MCybaSZEvWKxMYrEzcibSadjgP2pyYTo76RvNOkcH4h4woCJmw5W+4BO4GE
         nAvr8Zj7Npvy0W3PQSs+eh4iRTYwxsss3VQMQA0aOrU6Ghdsukdfyvk6/b5fXEdK+xQK
         Abvw==
X-Gm-Message-State: AOAM530eHqt36Qe+RFlk3GixhevryLFIfsFoV5dXj2VtnSnCEezVMldw
        5t7cfdZyjikyfkxpfG0jiPlJuo6gYxi5hg==
X-Google-Smtp-Source: ABdhPJw5a6DqhO5V4G/twLsma+1rrkJjiYS0Dq+Tec+BjOq4x+FA3gSO/pnEybBYhPBtNQSJ0iIj9g==
X-Received: by 2002:a5d:428f:: with SMTP id k15mr6580508wrq.347.1642595820339;
        Wed, 19 Jan 2022 04:37:00 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:d394:97d0:bc02:3846])
        by smtp.gmail.com with ESMTPSA id bh13sm2610327wmb.33.2022.01.19.04.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 04:36:59 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robert.foss@linaro.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] drm/bridge: dw-hdmi: filter safe formats when first in bridge chain
Date:   Wed, 19 Jan 2022 13:36:55 +0100
Message-Id: <20220119123656.1456355-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the dw-bridge is in the first position in the bridge chain, this
means there is no way to set the encoder output bus format.

In this case, this makes sure we only return the default format as return
of the get_input_bus_fmts() callback, limiting possible output formats
of dw-hdmi to what the dw-hdmi can convert from the default RGB24 input
format.

Fixes: 6c3c719936da ("drm/bridge: synopsys: dw-hdmi: add bus format negociation")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 97cdc61b57f6..56021f20d396 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2674,6 +2674,25 @@ static u32 *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	if (!input_fmts)
 		return NULL;
 
+	/* If dw-hdmi is the first bridge make sure it only takes RGB24 as input */
+	if (list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain)) {
+		switch (output_fmt) {
+		case MEDIA_BUS_FMT_FIXED:
+		case MEDIA_BUS_FMT_RGB888_1X24:
+		case MEDIA_BUS_FMT_YUV8_1X24:
+		case MEDIA_BUS_FMT_UYVY8_1X16:
+			input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
+			break;
+		default:
+			kfree(input_fmts);
+			input_fmts = NULL;
+		}
+
+		*num_input_fmts = i;
+
+		return input_fmts;
+	}
+
 	switch (output_fmt) {
 	/* If MEDIA_BUS_FMT_FIXED is tested, return default bus format */
 	case MEDIA_BUS_FMT_FIXED:
-- 
2.25.1

