Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3244FAAE5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 23:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiDIVNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 17:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiDIVNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 17:13:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79AB7664B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 14:11:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so12930529pjk.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7L2Rl1Azs1qdyPqBYsqG+p3Elwf/l1kjj+FLiYmbT0=;
        b=DSlovrPyKrzRMXH6RmU9rxtzpuENFrLHzZOcjwuGHTEYFCWIVPC6xpiAY44LMxxp/m
         a47mFuEjBqpIgr6wdSujSp6VXedgqKs7meLk31oA4WXJTV+Q9RJ61nFW37J1TbhA6wFp
         FGOD99F1zvudg/Sj5XVOdG3DcdPWqYgX6F8juZ4bkJhZrHQ83dRcCrm2T2AYuA3/Epyd
         nonGKxiEVzFJ5/TWnAR9ipkkESC2vfX8P0lY0OgU2nkKbUdCdS2HPDvlrgL6I4ziVtl4
         uJMvko0Sw9L6vopyQtfKtt4PIpCIBmDZ0AQM4W3/SECmghK/UtmGSkjtquvC3y66VXdA
         yn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7L2Rl1Azs1qdyPqBYsqG+p3Elwf/l1kjj+FLiYmbT0=;
        b=DrzmW8NyIloPyp80Kn16uSUJY7gk17895ZZj+co16IAF7GRU4pCUDtfFXWmYMb6Pce
         p1GGsfNtMheyN8K2S2g1phgNM9VG796GCeWkB8kl1QGogEj387CkC2/0RxcEq8v9PqTi
         u3Z2Yrtbynnk4f9tYCjm5RW6KTpN7ybQtx60jCLLVlOLBCNoaW/6OivM3jQto0mKr7RZ
         EY6UHAozMAN9utycTa154H6TJGpj/0D71BvS9O0d0gHAFEvTGVKSWof4U30CE/OGC5Mp
         r387QIjC6FBH+qaqf0shssNtFU9BU3EI+LOo5grTQJZDPfH4FogUAmTW2F3puEAylXI4
         hJew==
X-Gm-Message-State: AOAM532yolCKSBeEbAFMqtT0/6jwZhxOGeZ5mq1rzd1lPdvbfVcfXUPw
        VrDuPyBsZSSRoKHhrLWg5XDXJA==
X-Google-Smtp-Source: ABdhPJw5Rq+GTknDzXhuTRZefTu+M6QpC71rPXCKCsZk3sK1J0SV/wvRnzaw7+WTiuuhP1WBn+uB5w==
X-Received: by 2002:a17:902:ecd2:b0:156:9992:5892 with SMTP id a18-20020a170902ecd200b0015699925892mr25158352plh.7.1649538697093;
        Sat, 09 Apr 2022 14:11:37 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:925c:1a60:e433:31b7])
        by smtp.gmail.com with ESMTPSA id w127-20020a627b85000000b00505a9142ce5sm1393295pfc.22.2022.04.09.14.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 14:11:36 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2 1/2] dt-bindings: wkup-m3-ipc: Add vtt toggle gpio pin property
Date:   Sat,  9 Apr 2022 14:12:14 -0700
Message-Id: <20220409211215.2529387-2-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220409211215.2529387-1-dfustini@baylibre.com>
References: <20220409211215.2529387-1-dfustini@baylibre.com>
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

Document Wakeup M3 IPC property that indicates a GPIO pin is connected
to the enable pin on DDR VTT regulator and can be toggled during low
power mode transitions.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[dfustini: converted to YAML, removed unnecessary "ti,needs-vtt-toggle"]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
index d855c01ce61c..7f4a75c5fcaa 100644
--- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
@@ -24,6 +24,14 @@ description: |+
   A wkup_m3_ipc device node is used to represent the IPC registers within an
   SoC.
 
+  Support for VTT Toggle
+  ==================================
+  On some boards like the AM335x EVM-SK and the AM437x GP EVM, a GPIO pin is
+  connected to the enable pin on the DDR VTT regulator. This allows the
+  regulator to be disabled upon suspend and enabled upon resume. Please note
+  that the GPIO pin must be part of the GPIO0 module as only this GPIO module
+  is in the wakeup power domain.
+
 properties:
   compatible:
     enum:
@@ -51,6 +59,10 @@ properties:
       mbox_wkupm3 child node.
     maxItems: 1
 
+  ti,vtt-gpio-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: GPIO pin connected to enable pin on VTT regulator
+
 required:
   - compatible
   - reg
@@ -76,6 +88,7 @@ examples:
            interrupts = <78>;
            ti,rproc = <&wkup_m3>;
            mboxes = <&mailbox &mbox_wkupm3>;
+           ti,vtt-gpio-pin = <7>;
         };
     };
 ...
-- 
2.32.0

