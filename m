Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BEF5810ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbiGZKQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiGZKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:15:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB4914009;
        Tue, 26 Jul 2022 03:15:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b10so13019638pjq.5;
        Tue, 26 Jul 2022 03:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVAfKYIxLF8XEC4qYp9NrQYOKbMB2AyqeCKsux8Y4Ps=;
        b=cKy9ArCR9EM1WP9fz9Y5fa+zfnyVHq6CyvuXJFYblKXw6aofaHpEgNTSqk67Erh/5o
         ELAf6AYwGEQcIaulu9r7gfQ8Fx8l6zCMWeDv2cGf0lZBNQqFHKmAMGCp0Yv6i0Od9sla
         d/UySqiHgYHfXdQtitfV2S2upTddqLESkdoJvU45VhtKF2lEUtheD3F2M38BYfQz25DJ
         vHDmffCneudZSr5RgJk4EpSSo6oYUz+y1WSvKgsTfqek3LKT783kc6j4jRmhM1XmkJI5
         ABdZi45zXIIoPl6W6I6ScwTcgyGlm2GeWhfBVDaHoV6FR4gStVBLuyI4cFq3wgZKpbSf
         y21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVAfKYIxLF8XEC4qYp9NrQYOKbMB2AyqeCKsux8Y4Ps=;
        b=2P9m+vyf7+zuXqQ4bpxG7UGqJJhjqIATowOVFUJ7/tFWhXGIYnfVGkvDNVAdmpFF0u
         U+NdyigPD2NcWm6DgSBFJb95UNIs4XjIiRzJrrdr5vV7DuZv8EgX5oX/bX4s7HJztpp2
         Rbo3MBDOEZdmeAYztCQvBVc3PsqEQXT6nsKpDVTpL0DXKxnFuIFKgJGV52/K9XiJdej4
         Se2O8N2DTlDIO/oZdj2wMMBNFFO6DcaNP1GRqA4hPtOUymrAb0S1u6e9pV28xD8OrGXO
         LfAHC7EG/kZ96zaAbAY6ETyoGpY3pFdM8B89jj06FlZ3nB2VsI5z67Ulzbg0In5p+jFF
         LLGA==
X-Gm-Message-State: AJIora9tP+hekri0Zk503sCIDCoBnATsKfrEc4rQEX2kXlrDWV6HfeaJ
        f1rLaDX6E4XijK9HI6YBnRs=
X-Google-Smtp-Source: AGRyM1uEuxhhReOUIpyudX28mVJ1+KwSazXM5vba9h56MpZRFoDdhfLZvQhnIpCAHaHL9uqXsmmYYw==
X-Received: by 2002:a17:90b:4b88:b0:1f2:503e:b19b with SMTP id lr8-20020a17090b4b8800b001f2503eb19bmr22248691pjb.30.1658830558240;
        Tue, 26 Jul 2022 03:15:58 -0700 (PDT)
Received: from localhost.localdomain ([112.0.190.94])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b0016d303f266dsm5515106plg.276.2022.07.26.03.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:15:57 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add Novatek NT35596S panel bindings
Date:   Tue, 26 Jul 2022 18:15:12 +0800
Message-Id: <20220726101513.66988-2-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726101513.66988-1-mollysophia379@gmail.com>
References: <20220726101513.66988-1-mollysophia379@gmail.com>
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

Changes in v3:
- Embed the documentation into existing one (novatek,nt36672a).

Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
---
 .../display/panel/novatek,nt36672a.yaml       | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index 563766d283f6..560fb66d0e5a 100644
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
+              - tianma,fhd-video
+          - const: novatek,nt36672a
+
+      - items:
+          - enum:
+              - jdi,fhd-nt35596s
+          - const: novatek,nt35596s
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

