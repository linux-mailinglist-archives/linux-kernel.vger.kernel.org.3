Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B05D4ACC20
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244704AbiBGWjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244667AbiBGWjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:39:19 -0500
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B27DC0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:39:16 -0800 (PST)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 1F7AB20056;
        Mon,  7 Feb 2022 23:39:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1644273554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9Hrv0q5degBZRzHJi8zdFvUy/sNS40DZBw0W334KX7A=;
        b=EAqJAHwNgILhLHYMb9SluOMd9N15lijee22r39HTUjFFKr0sihX1cU4KzeFApt9AaTL5Bu
        BbuP17zjfIdfkOLSIfil6+5HsL6j3GxbeJKHhUzJD6iwYDlLAI9XmjOvTWI2VXO7t7zayU
        ZI1mHimlr5ut2gVwKiVtX4HrZQPWx8E=
From:   David Heidelberg <david@ixit.cz>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: display: bridge: document Toshiba TC358768 cells and panel node
Date:   Mon,  7 Feb 2022 23:39:11 +0100
Message-Id: <20220207223911.97180-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inherit valid properties from the dsi-controller.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - added $ref ../dsi-controller.yaml# instead copying properties (Dmitry)
 - additionalProperties -> unevaluatedProperties (Dmitry)
 - example dsi-bridge@ -> dsi@ (Dmitry)

 .../bindings/display/bridge/toshiba,tc358768.yaml          | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
index eacfe7165083..3bd670b8e5cd 100644
--- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
@@ -77,7 +77,10 @@ required:
   - vddio-supply
   - ports
 
-additionalProperties: false
+allOf:
+  - $ref: ../dsi-controller.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -87,7 +90,7 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
 
-      dsi_bridge: dsi-bridge@e {
+      dsi_bridge: dsi@e {
         compatible = "toshiba,tc358768";
         reg = <0xe>;
 
-- 
2.34.1

