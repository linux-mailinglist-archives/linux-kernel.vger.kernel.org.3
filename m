Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C1851420A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354391AbiD2FzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354375AbiD2FzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:55:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7E6B8991
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:51:52 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j9so5201084qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wSVXGhpX7+3tqTsq9MsK0eHVkHax9CnVVMbIrKRPdDw=;
        b=fmuuBxFPSBAuf+kR6aW1QBSGWJabwOZqrtp+tpz8nO9W07mEM7T5UqX7YlGIDU52uA
         r410eXWTSmmOVPL3oT5WdLurXJUG+4WpD6TOgFXT99mnpN3c1CzrIODqw3etBrD9tG4M
         71ZSSkIUnhgoAP0D8l7lucky9atri3irfM3+q5ROXnCL9t1EX/jdeDV8y0KbLnBvFtfm
         yXXGTTG4ZtFRqauo88uIdVYM60Fwhy8f9u3kNs6yT0YrZCnNg38lighR/t2Ao1LjPK07
         NZGGkpkUhEEa7VoEcAGWkBN4Pni6oCucvOH/HbTieiw+RaS2DUNeDmMQ3VQ4+jMeuVN+
         JdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wSVXGhpX7+3tqTsq9MsK0eHVkHax9CnVVMbIrKRPdDw=;
        b=7jbAwhMFdqnGohK/WHrbDNOfoISnnjibNdZpiQfkEtu87YSHUPJWaK4ZEbe/EsAumK
         eu8TDos+F64dhJpHFMTi9ivXJ+aIj3MGIj+vqWSdi+KVXfOp4f6138MI/OqTySbOSqEM
         u+3ao1JKEnlCuLTPyB98n5jewLC66MSrhDt9dbRF8bd0CTbkDxq1MPUpYKJXBnPNbPLu
         r1pGVYolrDhc2ERN5H25p1bW+4LtCvjYh+n4VOXr769lSqkKF9Hpk1scWDkJdLJsQUHk
         gYJ6GPTIP/5QPODuM0srmpL/izHPC5WYEn+FiWlmIL4HTStfC0+NL9zNO14AWb/aML8Z
         p/vQ==
X-Gm-Message-State: AOAM533D/db6VXOjZ9oBFNDqY1rIhpq+vFIayBwucOIgZs0jAS8q+9Gx
        HSaJ1tIlbFYcXkDAAEzuBhE=
X-Google-Smtp-Source: ABdhPJw1gCc2UXxhJhiT71GwoRlCH57dMMt23E72MDXt2Kf+ewwW3RM2u1ZV1h3f73kB1kw5bbJHHQ==
X-Received: by 2002:a05:620a:4114:b0:69f:9b84:82a0 with SMTP id j20-20020a05620a411400b0069f9b8482a0mr5857387qko.675.1651211511982;
        Thu, 28 Apr 2022 22:51:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w3-20020ac87e83000000b002f33b2cfe62sm1277312qtj.66.2022.04.28.22.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 22:51:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dianders@chromium.org
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/bridge: simplify the return expression of ps8640_bridge_host_attach
Date:   Fri, 29 Apr 2022 05:51:45 +0000
Message-Id: <20220429055145.3852271-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index edb939b14c04..e2467e58b5b7 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -542,7 +542,6 @@ static int ps8640_bridge_host_attach(struct device *dev, struct ps8640 *ps_bridg
 	struct device_node *in_ep, *dsi_node;
 	struct mipi_dsi_device *dsi;
 	struct mipi_dsi_host *host;
-	int ret;
 	const struct mipi_dsi_device_info info = { .type = "ps8640",
 						   .channel = 0,
 						   .node = NULL,
@@ -577,11 +576,7 @@ static int ps8640_bridge_host_attach(struct device *dev, struct ps8640 *ps_bridg
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = NUM_MIPI_LANES;
 
-	ret = devm_mipi_dsi_attach(dev, dsi);
-	if (ret)
-		return ret;
-
-	return 0;
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static int ps8640_probe(struct i2c_client *client)
-- 
2.25.1

