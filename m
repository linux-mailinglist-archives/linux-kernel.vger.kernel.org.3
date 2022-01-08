Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF64488578
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 19:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiAHS7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 13:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbiAHS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 13:59:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36470C061746
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 10:59:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso7298040wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYh2HXtJRHDLyiqHjumy8SGr/ilHKwnU20CoAfLk/k4=;
        b=W0BLse+MIvxhQMBBTpCdSM81w9hDph/TF393Uus+VnlaAyGIBKw5sj4Qq6TpAaHVGO
         Av1SLjUcdjJpb6NV8PqyyPs6HplO4pIPK3YuIC7U5h0vUBQhLLIqNzLiMdfVpeNegvR6
         6PqOCxZk3bVj+UNaPGE0pY9XlbA/AO2rpAMSSb0YpOW0RRybmSSaMLU56+6e1vGP5UAR
         1ZQOPGEepjFq8XBOErp0vRdRN5n+3EOTMu5pPnPHwOwrEPGKjbYB2yvMjHpt5KAjhaIR
         xP9FP3T5nLOv8VhC4HIFNUwH+6uiQWnCFt23fVBU02b0qSOp4/bgW8CXvH47cfVmB5NV
         t6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYh2HXtJRHDLyiqHjumy8SGr/ilHKwnU20CoAfLk/k4=;
        b=E2jCDomQ0h7Z3nB4H4z81WY7OPgFMDSCtOuy1QEaX0mb7A/EkFvLxSq/j2z8PNYsqy
         qo47RQ035ITz7EADwBLnfRVirpxFOqmXYoYL2cCTMTkZ3fYQjCeMK3vDsCoG4JA+dJGD
         wKXacCL2PBLDfdyspV1yAUOYAu4U39V9yJP1HboxTPmAqAaqNJFRsJZ7Vnqq7U8mjXcB
         vwosgiefBX0ydaIO5vbvNWZEBwnP9I183HZtaCBI80aB85nli6UqT8tBPU9MmSCfDINm
         bfCNvjflzSzIn1azr6ZLv0HBVTvgisez3A1fvJmXqLhe9GXTv59F2U0DDG0ZmifJ8/0I
         oIZg==
X-Gm-Message-State: AOAM5305X1fQvD/rnHrkrdj5M3XixLxf7m6x8BmqIX/x+mBkX+Ms53rr
        MemFh0K5eDOQnRIWcnwZrdAYJw==
X-Google-Smtp-Source: ABdhPJwQn6yYUwxfhwSA0o1WBiGl15jl2VyPd2YfD7g3pyifIUlNmazaPnzAHEbGAKkr+lCZ90bOHA==
X-Received: by 2002:a1c:4b10:: with SMTP id y16mr15036595wma.185.1641668348732;
        Sat, 08 Jan 2022 10:59:08 -0800 (PST)
Received: from fedora.sec.9e.network (ip-88-153-139-166.hsi04.unitymediagroup.de. [88.153.139.166])
        by smtp.gmail.com with ESMTPSA id bg12sm2886209wmb.5.2022.01.08.10.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 10:59:08 -0800 (PST)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: i2c: Add regulator to pca954x and max735x
Date:   Sat,  8 Jan 2022 19:57:57 +0100
Message-Id: <20220108185759.2086347-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220108185759.2086347-1-patrick.rudolph@9elements.com>
References: <20220108185759.2086347-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a regulator called vdd also present in datasheets of PCA954x
and MAX735x and update the examples.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mux-max735x.yaml | 5 +++++
 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-max735x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-max735x.yaml
index dc924ec934ca..93eda07718e8 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-max735x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-max735x.yaml
@@ -57,6 +57,9 @@ properties:
     description: if present, overrides i2c-mux-idle-disconnect
     $ref: /schemas/mux/mux-controller.yaml#/properties/idle-state
 
+  vdd-supply:
+    description: A voltage regulator supplying power to the chip.
+
 required:
   - compatible
   - reg
@@ -75,6 +78,8 @@ examples:
             #size-cells = <0>;
             reg = <0x74>;
 
+            vdd-supply = <&p3v3>;
+
             i2c@1 {
                 #address-cells = <1>;
                 #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
index 9f1726d0356b..b28d05dc956d 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -59,6 +59,9 @@ properties:
     description: if present, overrides i2c-mux-idle-disconnect
     $ref: /schemas/mux/mux-controller.yaml#/properties/idle-state
 
+  vdd-supply:
+    description: A voltage regulator supplying power to the chip.
+
 required:
   - compatible
   - reg
@@ -79,6 +82,8 @@ examples:
             #size-cells = <0>;
             reg = <0x74>;
 
+            vdd-supply = <&p3v3>;
+
             interrupt-parent = <&ipic>;
             interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
             interrupt-controller;
-- 
2.33.1

