Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59E15836F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiG1Cgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiG1Cgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:36:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFED550BB;
        Wed, 27 Jul 2022 19:36:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y141so743023pfb.7;
        Wed, 27 Jul 2022 19:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6PqjvUfdXE1hrn9zx8bHU/TCdCT/CsB8mmw94/JhKM=;
        b=Lm4HW/pnGCR2dZaVRuQk1dOrOSAzbaiC3bTwZINTIfMWL6zlJRi7tqPe+TJ03s/HpT
         ReBy89/q9Yvap0VFR7mfSRx05HXX+sD+CIi8wTTX0ZE9jrxN6VG95MFHFJn4UQgsFxZ9
         qXAwstgFXokyHQku2ZponVYYIloPfy2JjlKhaFet6IU6NuV7dPj6FKT71VD7mdhdrm20
         /e7BiG8tD+WF/69ldSie9lePl2BTMrac5fgp/zb9PG3HpfdCKBhQG/0YGjzImYBJOHvh
         HSI8J3SjmR74QeQIQJ8iaYbfdiUdGCQUtza7b+xvchRVk7s5ozVp/LcUikxvm3r+FUUm
         n8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6PqjvUfdXE1hrn9zx8bHU/TCdCT/CsB8mmw94/JhKM=;
        b=pXx39PKLQFk9f/NLMus5yEoot+ZcDAD2uixPpQYKKXvRL/4+xwU7BpfQZfgJRraDHe
         Y5+pQzf1BpdWwWXDPNnbt01oQ6Jf2xRZsflGODvTeJs/GlEo/gyRQFhX/qIQM7nYfJr8
         U9jSGPF1OD+b89Z3n5Y4lHtOS2hobp5hm9uvLwEEZR52U/2+xewZMm6nk4o8T7MRZIXO
         js6kWNlMMnWZ0TbPWCDvHoZWGhVwqRn+wiZHccsoycrGug01eFA5vCiedPGKpgP5AolX
         IdLkNM9qL5GgpNMAvthVMrXxvBQi7C9i7gXO+fdFHSBJo+e04nyYgYP4VQTVL0rluSh8
         zsgw==
X-Gm-Message-State: AJIora8A3rDffmHUN2fy2lUL15nB6nVgTad91F8OPj7kqf0cMZxvJspO
        5D5OLFm2kydXVSXnIqYwUVs=
X-Google-Smtp-Source: AGRyM1uoTd7vgZLP+jNu7RpFAjD3RlQLiUPIegjHCHHveEpqVD0QIUiXsI71MlB8LtSmPoMc8cJlvg==
X-Received: by 2002:a65:6b89:0:b0:41a:69b1:8674 with SMTP id d9-20020a656b89000000b0041a69b18674mr21195388pgw.417.1658975789956;
        Wed, 27 Jul 2022 19:36:29 -0700 (PDT)
Received: from localhost.localdomain ([112.0.190.165])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b00528c149fe97sm14631311pfi.89.2022.07.27.19.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 19:36:29 -0700 (PDT)
From:   Molly Sophia <mollysophia379@gmail.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: display: panel: Add Novatek NT35596S panel bindings
Date:   Thu, 28 Jul 2022 10:35:54 +0800
Message-Id: <20220728023555.8952-2-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728023555.8952-1-mollysophia379@gmail.com>
References: <20220728023555.8952-1-mollysophia379@gmail.com>
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

Add documentation for "novatek,nt35596s" panel.

Changes in v4:
- Correct numeric order of the items.

Changes in v3:
- Embed the documentation into existing one (novatek,nt36672a).

Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
---
 .../display/panel/novatek,nt36672a.yaml       | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index 563766d283f6..d21a4a87a9d8 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -20,14 +20,20 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - tianma,fhd-video
-      - const: novatek,nt36672a
+    oneOf:
+      - items:
+          - enum:
+              - jdi,fhd-nt35596s
+          - const: novatek,nt35596s
+
+      - items:
+          - enum:
+              - tianma,fhd-video
+          - const: novatek,nt36672a
+
     description: This indicates the panel manufacturer of the panel that is
-      in turn using the NT36672A panel driver. This compatible string
-      determines how the NT36672A panel driver is configured for the indicated
-      panel. The novatek,nt36672a compatible shall always be provided as a fallback.
+      in turn using the NT36672A or the NT35596S panel driver. This compatible string
+      determines how the panel driver is configured for the indicated panel.
 
   reset-gpios:
     maxItems: 1
-- 
2.37.1

