Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A4D470624
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243989AbhLJQv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243974AbhLJQvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:51:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BB9C061D5F;
        Fri, 10 Dec 2021 08:47:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso7535258wmh.0;
        Fri, 10 Dec 2021 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nh4nZ8x2F/zX2gpWtc/nCgmj7X2/sDfm3/7SsT32LNg=;
        b=lFc3i2MYZ/HgAL+GAmNWKHOCudhpgvc9BoRQeFKvF7V8M7r9xwYZ+DlFanMQUduQ5x
         EZ9nQfdauWM4OEYZrkGZfPbuD6L6wiak1pb027Lnna98CKP6gCrSDb4rNllq+XK9MUYR
         3/MeH1SbxNDXpKo8vmk4I8dUafXEqzdN+xp4TazVl09T1X7hB6WeLBvYn5MLr+JfEmGA
         LIVR3KVqJRS553ycG3ljcTNk3TuSCaOKc8B6bpQicxxlGkNRcb8TvuRWOlpFMfrmRE78
         +7goze0AUWeXUK6kh3UHy3sQS58wy9hLym+v6G40/7dNPbkbhKWe/o9Mknt39vDX6kpC
         nKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nh4nZ8x2F/zX2gpWtc/nCgmj7X2/sDfm3/7SsT32LNg=;
        b=gz6N/7vyd/IMyu/SaqHAPtSYhUrtd9lz5TYed2eFWzUo/CC4By80xQDWBC+u0A7fvv
         ReNklAvZbC3Zu1Ir9wkDhmP9buSbO3EtYpv4+46+6EOLPSfe5NjdWnbZdDnsriR7T9Bk
         h1iC+0Uy+K1bGcqsFKSnnt9WdyjsfkZ2LeufewyJ05+oTs0aM6izMAy9/ihk7WVQW78s
         WqdOwu/N/CihNLsAtx5G3ejQF1uU9zeKeZhU8UONKC0a43S/6OAmQUw/fGHw2psHynfi
         JuIqF7hc2wBDubAAQk98z067YO3V6bok9gU3tpX9KftNUsrGdApD9lhU3LeETmNIFWqU
         VcIg==
X-Gm-Message-State: AOAM5338wyBjEyVdBM3K/J4bwGLemg41GR7J2nzaq6OxSJnDLHTowPv3
        f+vWQ1/rFEpS0HM+XgKuDx4=
X-Google-Smtp-Source: ABdhPJy7kVIV/MMNgjPTRCzFFHYtYQxmeN9jGH347sY9ovGfCVUsa4Yj+xJr72kG7tFR3U0MwEAlSg==
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr17164266wmq.16.1639154866450;
        Fri, 10 Dec 2021 08:47:46 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id a198sm3321689wmd.42.2021.12.10.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:47:45 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: memory: tegra: Document #interconnect-cells property
Date:   Fri, 10 Dec 2021 17:47:36 +0100
Message-Id: <20211210164741.881161-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210164741.881161-1-thierry.reding@gmail.com>
References: <20211210164741.881161-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The #interconnect-cells properties are required to hook up memory
clients to the MC/EMC in interconnects properties. Add a description for
these properties.

Also, allow multiple reg and interrupt entries required by Tegra194 and
later.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- drop incomplete BPMP snippet from example
- explicitly set minItems for reg property
- describe MC and EMC general interrupts

 .../nvidia,tegra186-mc.yaml                   | 78 ++++++++++++++++---
 1 file changed, 67 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index 611bda38d187..b496564b1bdf 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -33,10 +33,12 @@ properties:
           - nvidia,tegra194-mc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   interrupts:
-    maxItems: 1
+    items:
+      - description: MC general interrupt
 
   "#address-cells":
     const: 2
@@ -48,6 +50,9 @@ properties:
 
   dma-ranges: true
 
+  "#interconnect-cells":
+    const: 1
+
 patternProperties:
   "^external-memory-controller@[0-9a-f]+$":
     description:
@@ -65,10 +70,12 @@ patternProperties:
               - nvidia,tegra194-emc
 
       reg:
-        maxItems: 1
+        minItems: 1
+        maxItems: 2
 
       interrupts:
-        maxItems: 1
+        items:
+          - description: EMC general interrupt
 
       clocks:
         items:
@@ -78,11 +85,65 @@ patternProperties:
         items:
           - const: emc
 
+      "#interconnect-cells":
+        const: 0
+
       nvidia,bpmp:
         $ref: /schemas/types.yaml#/definitions/phandle
         description:
           phandle of the node representing the BPMP
 
+    allOf:
+      - if:
+          properties:
+            compatible:
+              const: nvidia,tegra186-emc
+        then:
+          properties:
+            reg:
+              maxItems: 1
+
+      - if:
+          properties:
+            compatible:
+              const: nvidia,tegra194-emc
+        then:
+          properties:
+            reg:
+              minItems: 2
+
+    additionalProperties: false
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - clocks
+      - clock-names
+      - "#interconnect-cells"
+      - nvidia,bpmp
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: nvidia,tegra186-mc
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          const: nvidia,tegra194-mc
+    then:
+      properties:
+        reg:
+          minItems: 3
+
+additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -90,8 +151,6 @@ required:
   - "#address-cells"
   - "#size-cells"
 
-additionalProperties: false
-
 examples:
   - |
     #include <dt-bindings/clock/tegra186-clock.h>
@@ -124,12 +183,9 @@ examples:
                 clocks = <&bpmp TEGRA186_CLK_EMC>;
                 clock-names = "emc";
 
+                #interconnect-cells = <0>;
+
                 nvidia,bpmp = <&bpmp>;
             };
         };
     };
-
-    bpmp: bpmp {
-        compatible = "nvidia,tegra186-bpmp";
-        #clock-cells = <1>;
-    };
-- 
2.34.1

