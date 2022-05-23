Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B184530BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiEWIqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiEWIqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:46:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73A395B8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:46:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id wh22so27099453ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/UJVNFJlnsJgNgDCoE5ZckFUTQDcqZNSRJVFlxfYlxA=;
        b=b11+npovOhBjUUHd+nEfFfMTBvFoZw1H3W9282L6Tp3WbVlZ8IxSFZZXZ6q9xJDxGY
         EW1ov0cjxrepoUt/z3W4HjL9LUbatrctpSRC9iqEJjw3GHGmgLB/YBL6gMlhBU+bwOZ8
         9Q2yb9CKp+1U5D6U/Ay9/RB3nGyutYaPD6KW+N8ur1Y3+YOycQMBbYZ20dED3cD7g3IE
         1eRqCVYrsLEw/YykEeamjI/JjXWvLR6UnboQs41oXXwp/9AvIOAFrk5x7TtPgSCjsgZx
         z7YJ+Pnkd+JFJx4ABoXMvPZqVjTOru2Gq7bWp7ETR5OctRJG6RLNwJpra4oFp7l28h6m
         FG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/UJVNFJlnsJgNgDCoE5ZckFUTQDcqZNSRJVFlxfYlxA=;
        b=F65GwEeKEPwOvNuOJIqkLsGMxr3gXfkAmcCFbH8q4MOeJE1OYMhi18lmNV4C/dthnR
         sG/lT5bgF56j6XmLYdZtCVLQBbP74FIerLqIHP+7EZpIDezGv//PlCB7Wg26oN4v9gz1
         17Uq6EBMV9UeYOACvd5ZIdsSjXvCIdaWEbub7dIb/vOE66ixVrqiSxxf4Sa4Gqv9Hr/a
         SN2Dbnwt2lBuyvGdFtyvR0dAiesrlb9t1Z+A2P+9NuOZgjw2cK9aHBcdU3LB9M/cm+Ii
         IVPCY2ziLV6qLGVURPDw1qKC4TpIywTSs/bJOHcBW3kodJJ5U7dgt4K4bg+nDsBsihtR
         D8FQ==
X-Gm-Message-State: AOAM530pbAgkVPzheIhwNuqurAwddkEVne1sI5iddlEkkCtfqE0grHHw
        7uWcNUMEd9cogijZXi8z5oHjiQ==
X-Google-Smtp-Source: ABdhPJy/yZ/lyLvwTyt4cXG/A5E5S0zgmqqcWtG9q9FfqLebYY41G/XptN11JbgOUzqxswfr2um6MA==
X-Received: by 2002:a17:906:dc89:b0:6f4:d3a9:34ed with SMTP id cs9-20020a170906dc8900b006f4d3a934edmr18924201ejc.459.1653295595105;
        Mon, 23 May 2022 01:46:35 -0700 (PDT)
Received: from prec5560.. ([176.74.57.19])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b006fee27d471csm905706ejf.150.2022.05.23.01.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:46:34 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xji@analogixsemi.com,
        hsinyi@chromium.org, sam@ravnborg.org, tzimmermann@suse.de,
        maxime@cerno.tech, jose.exposito89@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] Revert "dt-bindings:drm/bridge:anx7625: add port@0 property"
Date:   Mon, 23 May 2022 10:46:15 +0200
Message-Id: <20220523084615.13510-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220523084615.13510-1-robert.foss@linaro.org>
References: <20220523084615.13510-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7328736d270aa4fa6fcd033ade02acc2874a2db5.
---
 .../display/bridge/analogix,anx7625.yaml      | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 4590186c4a0b..35a48515836e 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -94,22 +94,7 @@ properties:
         $ref: /schemas/graph.yaml#/$defs/port-base
         unevaluatedProperties: false
         description:
-          MIPI DSI/DPI input.
-
-        properties:
-          endpoint:
-            $ref: /schemas/media/video-interfaces.yaml#
-            type: object
-            additionalProperties: false
-
-            properties:
-              remote-endpoint: true
-
-              bus-type:
-                enum: [7]
-                default: 1
-
-              data-lanes: true
+          Video port for MIPI DSI input.
 
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
@@ -158,8 +143,6 @@ examples:
                     reg = <0>;
                     anx7625_in: endpoint {
                         remote-endpoint = <&mipi_dsi>;
-                        bus-type = <7>;
-                        data-lanes = <0 1 2 3>;
                     };
                 };
 
-- 
2.34.1

