Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4134A582119
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiG0Hbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiG0Hb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:31:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0793DBC01
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:31:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so1313062pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JAMO694Oo6l0rJ9WHvA6jFiTH+suc0dOkuX3t1F6TQo=;
        b=SrZZh4amzZ2qIwoFA52mW+urWPH+uedlcGdJG7StMSHrH0RoU+IpR2Z2wFfiESXP6U
         GuqZ6uhVDccHR2XDiYtxlPjkrCJaMczYYWUCek/WXZfxfRQgYdUdywVU1c5J0AtUZVgx
         cZizK5eBLnntpeJPhhppNeSyUx6aAcacB4PuVfSnRhCONDVXbvdnOICBzxG+cfqmH4NV
         QlQvB+o3ahES0Ce3FGA2N1Gt9HJwAC5ffUWKObrceeLgPfLnv9rjAT+SkgkmnZltsNgL
         iQT2+TdV0pzC/3KGYQqNQdTu61xN4pbneyxHl93yvQPxNeJkgqi9HI65Dzegj6dRFT9U
         1J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JAMO694Oo6l0rJ9WHvA6jFiTH+suc0dOkuX3t1F6TQo=;
        b=RMBHJgjNeLCTzJdYKOqboDQi7mYxbty4feT7z4IGPg9KHwZ3uIEk51wIvFhN+GtU0/
         4LtEGJuJzT1BmLAwrObPwJnuaTkz3nq1bVWXMipOOZGciNe7b2BWpgSpAyWQohkjT6YU
         UfvLT9zrpuDQKPQNKrbq6yh5RiNVWPQTuxoP0zKeZSlBHo9flQRW1/vP/xi8vg5hzNXy
         mofGBAU3nztJxsiaYCWp1JvhCNQ/OXRc/FqyF6Zt2S2Ht5iSsY55dNUHh0pZNnHBIbgy
         LxV1/mx6IsWHla9INNFpEzf4m+2dzKeq4ZJWJ54vE7Pn26uh+MJriwV6U6cBb16m+q5U
         dhfQ==
X-Gm-Message-State: AJIora/ISBF8Q2VXKdkjL3RH5pmjipofgclItkH/xp25c0ZUHX8zdVp1
        5dlubEnf5nvDbTfmmWIHW48=
X-Google-Smtp-Source: AGRyM1v0TikaoZXfPRYExckx6I0q+Dh/vK5TzQMBoH7oEpGz7bf6kXLR0mBBip/ifIV7mqt+ze/zVA==
X-Received: by 2002:a17:90b:1c04:b0:1f2:91be:b6f0 with SMTP id oc4-20020a17090b1c0400b001f291beb6f0mr3145473pjb.139.1658907085539;
        Wed, 27 Jul 2022 00:31:25 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id 63-20020a621942000000b005255263a864sm12956915pfz.169.2022.07.27.00.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 00:31:25 -0700 (PDT)
From:   Zeng Jingxiang <zengjx95@gmail.com>
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] gpu: lontium-lt9611: Fix NULL pointer dereference in lt9611_connector_init()
Date:   Wed, 27 Jul 2022 15:31:19 +0800
Message-Id: <20220727073119.1578972-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Jingxiang <linuszeng@tencent.com>

A NULL check for bridge->encoder shows that it may be NULL, but it
already been dereferenced on all paths leading to the check.
812	if (!bridge->encoder) {

Dereference the pointer bridge->encoder.
810	drm_connector_attach_encoder(&lt9611->connector, bridge->encoder);

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 7ef8fe5abc12..81a4751573fa 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -807,13 +807,14 @@ static int lt9611_connector_init(struct drm_bridge *bridge, struct lt9611 *lt961
 
 	drm_connector_helper_add(&lt9611->connector,
 				 &lt9611_bridge_connector_helper_funcs);
-	drm_connector_attach_encoder(&lt9611->connector, bridge->encoder);
 
 	if (!bridge->encoder) {
 		DRM_ERROR("Parent encoder object not found");
 		return -ENODEV;
 	}
 
+	drm_connector_attach_encoder(&lt9611->connector, bridge->encoder);
+
 	return 0;
 }
 
-- 
2.27.0

