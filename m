Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC654AAFB8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 14:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbiBFN6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 08:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiBFN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 08:58:28 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BEFC0401D8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 05:58:23 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3BDA7405B1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644155899;
        bh=GcS0xegk3NQr2qe7EYMZRqdHDgP4+x6pJzM+iYNNW+Q=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fK7YGXoZw7whQSqSIlcZ8H4Ge6aCzZ+9ffaHbS/nikueLqjXdLqITHx10YO2xMo4c
         2Yv49GUAOFLAWGbl5BAtJW6QeupE5MIEfhcw4tbzWSWhjTjjBhPFRRWns7I3f8pCWi
         K4P+GDqbz2WZkAU7ausNbO0jRtwMcK2gkH2DquKMSYsnPoNvnfQHjPgV2mFO/SI0IH
         wMYwN6PevhrVVArOluw8TbH6AdNVF9IYfrZ2ZIhTeijOU5/h5vHvUW8mr/60T7g9jP
         VWn+LJbl85+tR8XR5Vx3WqXWSXI2s6+SgYSzaZ6q7h4odLAWVjbUctf9T+rJc0tNT4
         OhJ8GcWTkFbdQ==
Received: by mail-wm1-f70.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so10569931wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 05:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GcS0xegk3NQr2qe7EYMZRqdHDgP4+x6pJzM+iYNNW+Q=;
        b=GpDtoyZ+yi5ffZnRthDFKMGu3+UvG7kIog3vh4d4iiQtiWeep9FktfczF91LjFiiEn
         YGlY4iLz4QnjFlcYfcLByE3TE14Bz/DNhAn2wx5eKKkjObXWp52N3aLR1kbjTTidBZqm
         46MJlBZ3xadEdlWC7HiCn1dvnNNAupkY9GdKtuFfSUBDCdH8yN0yhcwnzUBl41P5jPdU
         bN0aIN0YcptvGiFrnfwHFnmbR0+O4kCx8WhPja2zRx1GwuhnUi64rxg9j2y+wROFZvrB
         wOz4ctqdCRjTSntwn1or0voUrOZTeaH0gyOgBQhUUI+JEpJ7BpAeLouz8Ylchp1Wo8dK
         +xTQ==
X-Gm-Message-State: AOAM533/xzJszdRSt9hwy+6CfWOzjT5DIGf+nAvVtPNuQPA54yVDSRlb
        lj28uf+8PcyEQ2q4Eh4qdEVb1Nj+58lQkKux1fF3MDSlfzt8rkpTm0LumhyKUBkO7Nypq8kHeWu
        Lxkx0Ib/jiEBU1nmdUWqm1SnLVrbUEpzhhV6bGTkUQw==
X-Received: by 2002:adf:e344:: with SMTP id n4mr6504861wrj.630.1644155898924;
        Sun, 06 Feb 2022 05:58:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuSNQjrLfrOqkh1Zg9vi10v0k1NU7kRQCyj0/HiRY2zJfNZaKNZISedgt1YjEhCjtZ2SdmJg==
X-Received: by 2002:adf:e344:: with SMTP id n4mr6504852wrj.630.1644155898708;
        Sun, 06 Feb 2022 05:58:18 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e9sm8296888wrg.60.2022.02.06.05.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:58:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/8] dt-bindings: memory: lpddr3: deprecate passing timings frequency as unit address
Date:   Sun,  6 Feb 2022 14:58:05 +0100
Message-Id: <20220206135807.211767-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timings node maximum frequency was passed as an unit address, which
is actually a workaround.  Such workaround and unit address are not
needed at all, because the device memory node (parent) can contain
multiple timing nodes without unit addresses but with suffix used for
nodenames, e.g. timings-1.

LPDDR2 bindings already use such version, so unify the LPDDR3 with them.

Suggested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../ddr/jedec,lpddr3-timings.yaml                | 16 ++++++++++------
 .../memory-controllers/ddr/jedec,lpddr3.yaml     | 12 +++++-------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3-timings.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3-timings.yaml
index 98bc219e8a25..97c3e988af5f 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3-timings.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3-timings.yaml
@@ -17,6 +17,13 @@ properties:
     maxItems: 1
     description: |
       Maximum DDR clock frequency for the speed-bin, in Hz.
+      Property is deprecated, use max-freq.
+    deprecated: true
+
+  max-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Maximum DDR clock frequency for the speed-bin, in Hz.
 
   min-freq:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -117,19 +124,16 @@ properties:
 required:
   - compatible
   - min-freq
-  - reg
+  - max-freq
 
 additionalProperties: false
 
 examples:
   - |
     lpddr3 {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        timings@800000000 {
+        timings {
             compatible = "jedec,lpddr3-timings";
-            reg = <800000000>;
+            max-freq = <800000000>;
             min-freq = <100000000>;
             tCKE = <3750>;
             tCKESR = <3750>;
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index 3bcba15098ea..c542f32c39fa 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -18,6 +18,7 @@ properties:
 
   '#address-cells':
     const: 1
+    deprecated: true
 
   density:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -55,6 +56,7 @@ properties:
 
   '#size-cells':
     const: 0
+    deprecated: true
 
   tCKE-min-tck:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -191,7 +193,7 @@ properties:
       cycles.
 
 patternProperties:
-  "^timings@[0-9a-f]+$":
+  "^timings((-[0-9])+|(@[0-9a-f]+))?$":
     $ref: jedec,lpddr3-timings.yaml
     description: |
       The lpddr3 node may have one or more child nodes with timings.
@@ -201,10 +203,8 @@ patternProperties:
 
 required:
   - compatible
-  - '#address-cells'
   - density
   - io-width
-  - '#size-cells'
 
 additionalProperties: false
 
@@ -214,8 +214,6 @@ examples:
         compatible = "samsung,K3QF2F20DB", "jedec,lpddr3";
         density = <16384>;
         io-width = <32>;
-        #address-cells = <1>;
-        #size-cells = <0>;
 
         tCKE-min-tck = <2>;
         tCKESR-min-tck = <2>;
@@ -239,9 +237,9 @@ examples:
         tXP-min-tck = <2>;
         tXSR-min-tck = <12>;
 
-        timings@800000000 {
+        timings {
             compatible = "jedec,lpddr3-timings";
-            reg = <800000000>;
+            max-freq = <800000000>;
             min-freq = <100000000>;
             tCKE = <3750>;
             tCKESR = <3750>;
-- 
2.32.0

