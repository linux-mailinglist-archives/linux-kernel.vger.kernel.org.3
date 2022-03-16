Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C484DB1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242076AbiCPN7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343810AbiCPN7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:59:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B12443F1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:58:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p9so3062027wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IV7qFOLD4q3zq20RHPOYsu9T3drVDXzjg20JRDwUX8=;
        b=pEAx9CwFmoct9hr2tNPZV5DjiQG683/4ff5MH5nYiUC3ICJaYosdn7AcrDQzHNINnd
         WeipW/S/hYMxTaUJ7N4d3H0O970yhfJ0zNjE8JhoB3eqaB6Ftky0SKD1Ug/hTiHMyUyl
         OdYOBodYG0lkPW0fUj8cPxNiPfIv4g5QN0/ITVJ+zoNxMdX+/nktU7m/RQjy/C4d3jYE
         K6UPCqhMAdJYVXs10wKqrpB8Mc555n4F+HzoF8wzWFTjQ+fK+ORilsew/YWNPiODy+Av
         n3RT498m8xwBvBeu3GUy7hYpK1/dTdnMN6lbJk2kfkn05mwZ9ADrf6zJE3+MGZ5wR1qy
         MauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IV7qFOLD4q3zq20RHPOYsu9T3drVDXzjg20JRDwUX8=;
        b=jSlAUPdv9WNuq+Gf+91aT9ZWyOm0sR8a+gA4Np5If/z96sfLMFH4DK14b+96xt4CHI
         brqTceoCuUSPXKhB1i51us2fKRR96mM9akJCfdr9KnkRR+SCtITyurQef6O8wfKi5GY8
         3bGaHmZVvsor8DEO1NYJLzsXGX4IdtjmiOZ/UtvdnNVX47JQeKCBug7W3MLISApkhzvt
         beQIL4cTJNGJ/DmNtMyFK2z3z9aFuN8+Ka9i0ZsuEBOuFN0Jf+glw1p2/Omv2KQZ6xC/
         8mSRPJhavDVLDU+LyVxPKPM4f6UE9cZ6wawHKh6Xa0t8jpP3hU4COG3zStACXVprzXOP
         1RrA==
X-Gm-Message-State: AOAM532m9ZEe3sN5hqBThx21wZnLr8ksUXNfnTfA8MMeZJ0+iCeIwdy4
        Ju4O9/lUZE4UgZCB63IK/5ru6A==
X-Google-Smtp-Source: ABdhPJxkbNIncjvhV76u+CQgFORpjOgr7BLWcjNg6G2wuLjeNG9y5sMlA2spnK1hfKCW4rvpjDz5yw==
X-Received: by 2002:a05:6000:10d2:b0:1f1:e648:5ed3 with SMTP id b18-20020a05600010d200b001f1e6485ed3mr65695wrx.243.1647439113831;
        Wed, 16 Mar 2022 06:58:33 -0700 (PDT)
Received: from localhost.localdomain ([37.173.241.155])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b00389a420e1ecsm1790563wmb.37.2022.03.16.06.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 06:58:33 -0700 (PDT)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     narmstrong@baylibre.com, andrzej.hajda@intel.com,
        robert.foss@linaro.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: display: bridge: it66121: Add audio support
Date:   Wed, 16 Mar 2022 14:57:31 +0100
Message-Id: <20220316135733.173950-2-nbelin@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316135733.173950-1-nbelin@baylibre.com>
References: <20220316135733.173950-1-nbelin@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the ITE bridge HDMI it66121 bindings in order to
support audio.

Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 .../devicetree/bindings/display/bridge/ite,it66121.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
index 6ec1d5fbb8bc..c6e81f532215 100644
--- a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
@@ -38,6 +38,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  "#sound-dai-cells":
+    const: 0
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
-- 
2.25.1

