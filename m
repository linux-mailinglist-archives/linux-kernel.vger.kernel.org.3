Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9CE515AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiD3GwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiD3Gvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:51:55 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6926A95A3E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:48:33 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id i188-20020a636dc5000000b003c143f97bc2so4381647pgc.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EaCGHcsDG0tMwzfjFDyxoRj1KsNCUPzot2CTkJJ8YO8=;
        b=XeZbd85ahgKOsLO2GbKMdVDgRgIPfwA3z4SI/m0sAjDv3yo5oA1ice55KWf2wHtgMW
         HSvUkAFeMSyCjdepcjXL31w382aA0EsMY3+8U6S/CPOTpZlYN+Kh10Atcsuf1iqMRsQW
         Zq8bIGfVt8D6V2h8tcO1BwPjGi9KYigI96ena58b616/X3ZPmdvaktTZwqSzZsKs8GI8
         n9hcunTgeQXA2D9EQnsV0eIQUNgBAZrdVJR2x+QCC2pm3f9Chzd8X0IVA44KlCW9UvM1
         Z795IeigWmDrMuxRZIhIF2izqPuAICBYu4PQK/S5m9IRTW6enwXpva67zMxegv0fBNyl
         0K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EaCGHcsDG0tMwzfjFDyxoRj1KsNCUPzot2CTkJJ8YO8=;
        b=a9MsIkLMmW31D6WGkN/8n0+swPr5l0sLMqXIl0ZylZOx0IVEliBvSFhtzbGC5byifl
         C0fFbtGU3YspSkxc2f7H5z5wmG8kSB/nRWMWoucWBT6vp/Y1lyLqTrN8uWEXJ++dMSOK
         sJnWT1zpMeQkY8WKVak1lKqAYUKZQ9jZHTnNREkwK9Rhfm4T/enfHKlYlo5/WmMtLzm8
         EAzMw7XjX84g2ObUtwaUfehBTh+xF8hLzJbFH0+koZx4r517A9iQOxH5lC4OGAdlCKjO
         N4OoYxtpxEfOqsTJKJ2dt80X4S5sCNhlRZS75DvL0UHvfkYXmrCVYPJBeTDY3tN+5JIX
         yj+Q==
X-Gm-Message-State: AOAM532Sf6CBXUoWHC13tS49yRd0hoOyZjhtXcLvgttnAmWPOhSkR/zB
        yOYYsNdJpTJDz6+39DOxLcJYfuZHy+P00CEZz+YKaCGZcewdksZxJxs+5bazVN05vvtwdWu+PPr
        Dq4/u4Jf8OeUqbvvEcwiQbn8toCIzonUYFlLTqH9Nxh/53FGXqtftyxMAnF/7N98iIpHJw6M=
X-Google-Smtp-Source: ABdhPJw7kACiMZupN1yjhSLGSjSAcXC85YGJPXXNCr3bAGPqJ3oPo7VRYPRI3HNUE5R20ajWg1viOo/MUtQn
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:ba8e:b0:151:ed65:fda4 with SMTP id
 k14-20020a170902ba8e00b00151ed65fda4mr2594699pls.127.1651301312460; Fri, 29
 Apr 2022 23:48:32 -0700 (PDT)
Date:   Sat, 30 Apr 2022 06:48:27 +0000
Message-Id: <20220430064828.2470989-1-jstultz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC][PATCH 1/2] drm/bridge: lt9611: Consolidate detection logic
From:   John Stultz <jstultz@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Peter Collingbourne <pcc@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Foss <robert.foss@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simply consolidates the duplicated detection
functionality in the driver.

Cc: Yongqin Liu <yongqin.liu@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 63df2e8a8abc..bf66af668f61 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -578,10 +578,8 @@ static struct lt9611_mode *lt9611_find_mode(const struct drm_display_mode *mode)
 }
 
 /* connector funcs */
-static enum drm_connector_status
-lt9611_connector_detect(struct drm_connector *connector, bool force)
+static enum drm_connector_status __lt9611_detect(struct lt9611 *lt9611)
 {
-	struct lt9611 *lt9611 = connector_to_lt9611(connector);
 	unsigned int reg_val = 0;
 	int connected = 0;
 
@@ -594,6 +592,12 @@ lt9611_connector_detect(struct drm_connector *connector, bool force)
 	return lt9611->status;
 }
 
+static enum drm_connector_status
+lt9611_connector_detect(struct drm_connector *connector, bool force)
+{
+	return __lt9611_detect(connector_to_lt9611(connector));
+}
+
 static int lt9611_read_edid(struct lt9611 *lt9611)
 {
 	unsigned int temp;
@@ -887,17 +891,7 @@ static void lt9611_bridge_mode_set(struct drm_bridge *bridge,
 
 static enum drm_connector_status lt9611_bridge_detect(struct drm_bridge *bridge)
 {
-	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
-	unsigned int reg_val = 0;
-	int connected;
-
-	regmap_read(lt9611->regmap, 0x825e, &reg_val);
-	connected  = reg_val & BIT(0);
-
-	lt9611->status = connected ?  connector_status_connected :
-				connector_status_disconnected;
-
-	return lt9611->status;
+	return __lt9611_detect(bridge_to_lt9611(bridge));
 }
 
 static struct edid *lt9611_bridge_get_edid(struct drm_bridge *bridge,
-- 
2.36.0.464.gb9c8b46e94-goog

