Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB855EC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiF1ST0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiF1STW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:19:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FC81FCDE;
        Tue, 28 Jun 2022 11:19:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lw20so27519563ejb.4;
        Tue, 28 Jun 2022 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uCqC8GW9HKHpFH4wlDQrjFsLE8xAOLT85EC6wVnCbqE=;
        b=oQPMOr1hl7nMjOGc021ayJnlDHmo0YsdtCqmr12Q+NJnCBe3TtOuMP7ZP2QWsWgZOS
         PM++Gv4Z2N+KZ/KMDnUUZPv4BIaSVuCiTER94aNfvJTVno7FaOMmzWU+M1h2HYKWOyuB
         lCEnleDaxrk8uR/TN9qlgSaCVW6x4XQRhFsuMMHLAEPJSt4JWC1yBGHH/cRAKg/zHdrK
         t7CWgzOaWLR+1F08DigV6cFlQS/7OaZzu3QimOeI4DbSvpFRjBjb6jvgIKSKc/S6H8hX
         kpFjKwFnWuDQ1sVVpsmiWPGxdo2YmCyrTF3DhOnyUKNibpEHzgiuwldS9LO4czF3Ty78
         +DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uCqC8GW9HKHpFH4wlDQrjFsLE8xAOLT85EC6wVnCbqE=;
        b=6Z5mflnZrQOnRFxJI0MnbCTGwjpK+4F/0/e0Gf2t1JBvCw3wAMvBvemihB+cLlK64B
         WG064qpqnqHNX18o+QMaAaCvoDUMMAtKykGF8kaqlwX8sk6H4XkVPD2RizzJvOttRzsE
         G0oxuXcodWpn2aaSdM48+3IkR91wWXrInXcc4CcdD1gpBuuD4yx1K52gckWfHll7gN/V
         CJ9vU3lzBTlOqoGojuiIISzN5XoHT7A+UgaZeRVyDFyfxx2Lg1+jbwvCyRVIc3Y1BLy/
         L1C+tuL/dNW0PFbMbsjTASfXNnTowOoaJzikmfnUkVKcv+AXXmGx6NmfQBg25j7gRpxw
         jkaQ==
X-Gm-Message-State: AJIora+pX51mMToVJ7WI/Z0nRpHn9C/JTcxWBTv+iYPB9xsCRWVwP4RI
        ijqRlPPQcI794J9DMBhqAv0=
X-Google-Smtp-Source: AGRyM1sSqfRLsI0RsDDkEx/dMXLezB/q0XsKNxmge2U196i4Gi1R19bmaPHDDrtVUGfpn8tDCQYSVA==
X-Received: by 2002:a17:907:2d2b:b0:726:a628:d1ae with SMTP id gs43-20020a1709072d2b00b00726a628d1aemr11401718ejc.336.1656440360397;
        Tue, 28 Jun 2022 11:19:20 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm6730824ejd.196.2022.06.28.11.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:19:19 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: display: panel-common: allow for additional port node properties
Date:   Tue, 28 Jun 2022 20:18:35 +0200
Message-Id: <20220628181838.2031-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220628181838.2031-1-max.oss.09@gmail.com>
References: <20220628181838.2031-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Allow bindings which reference panel-common.yaml to add additional
properties under the port node.
I.e. 'panel-dpi' needs to add a new property to 'port/endpoint'.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v3:
- New commit to allow for additional port node properties

 .../devicetree/bindings/display/panel/panel-common.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
index 5b38dc89cb21..ff8dc07ef3b5 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
@@ -68,7 +68,7 @@ properties:
 
   # Connectivity
   port:
-    $ref: /schemas/graph.yaml#/properties/port
+    $ref: /schemas/graph.yaml#/$defs/port-base
 
   ddc-i2c-bus:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.20.1

