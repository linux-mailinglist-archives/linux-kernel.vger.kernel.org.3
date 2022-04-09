Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21AF4FA4D3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiDIFFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241819AbiDIE7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:59:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B42BCB5F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 21:54:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c23so9656412plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 21:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAVbfi6r8F9XdOp98CXkQS4IikBYdUQdfQIzN1ojFoM=;
        b=I/IQJ8d02ZalKbRD9x+9un6Ur9ihwCEn62DFrCYP+LUJvcEkMy9zT8j/xjMogTUfmh
         ysLEGeTTqw0Vhbye1/P/HnC50F4qlhJFGhJigwefnD01sx14HbPaHv2BthwBJsnssT28
         K6anhWrgGSNN6b3RkXUODbFA2UJRBLjgM2NPq07x4Wqiz7qSkU5Aw4WHUGmT+Q+xtpkZ
         ffJawzl9HF5OIkuTB7aEXpl/BbFCjzZFolSj6F4P/S4SHfhJ1CY/CInaLlKBqGdIlfVk
         yFao5G+t81Nx1ib4TCQugWBpgHaiApTjoquKJzFir51tTOA5ErQmmmLE8qcNpwrqa+gP
         HSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAVbfi6r8F9XdOp98CXkQS4IikBYdUQdfQIzN1ojFoM=;
        b=JuAZmQZox05bJ7sAi0QWgH9/7VeBBVw+brsrMfcerAOEcATLwqdtstJlOMLgXvAxL1
         ymvnI/KLVSpcCgaNSyBolkbJiPiGDOiXKCjWjXLWeoJN6N0NBz7yjzB0VBoDg7dzAJZd
         B8wtgbjsx78jLDLoqF5w1iVm16AcaUSIEnA39DI7NSzHXnKP7BmZSCcLy/vjF44qqTlS
         z4sy1FyjX3z+Wb85Y7ySh2iFO/heCu7K4E0qEM/pRQ2B/8a8/prKizvVNYyrYt2X/JTB
         /uafAJ+tTk3gyye/WGlXOFHDdTmqXFps2WK1EEDGTDJHcObiTBuushNZxY7zHsOU3RIp
         lU0g==
X-Gm-Message-State: AOAM530fuWQQvGeq1dY3Q5VocGejHmrGCBkUvKxPYFg/XY2i625J2EGW
        ym7roxXbF/aW7bk0lLYQXYMPbNZPfL146w==
X-Google-Smtp-Source: ABdhPJzOiK3fWm5z6/3iLAE1BHB2BQCOndg+LCsa9XjF4l26qFeIxpOju+iIkW8wAUi3K5Aq2LN5pw==
X-Received: by 2002:a17:902:e883:b0:153:f7b8:fa9 with SMTP id w3-20020a170902e88300b00153f7b80fa9mr22711094plg.96.1649480047757;
        Fri, 08 Apr 2022 21:54:07 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:8fa3:3402:f693:9f86])
        by smtp.gmail.com with ESMTPSA id k6-20020a056a00134600b004faba67f9d4sm28423050pfu.197.2022.04.08.21.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 21:54:07 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: wkup-m3-ipc: Add vtt toggle bindings
Date:   Fri,  8 Apr 2022 21:51:44 -0700
Message-Id: <20220409045145.2434096-2-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220409045145.2434096-1-dfustini@baylibre.com>
References: <20220409045145.2434096-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Wakeup M3 IPC properties that can be used to toggle the VTT
regulator during low power mode transitions.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[dfustini: converted to YAML]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../bindings/soc/ti/wkup-m3-ipc.yaml          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
index d855c01ce61c..6a8fcad8b2fd 100644
--- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
@@ -24,6 +24,16 @@ description: |+
   A wkup_m3_ipc device node is used to represent the IPC registers within an
   SoC.
 
+  Support for VTT Toggle
+  ==================================
+  In order to enable the support for VTT toggle during Suspend/Resume sequence
+  needed by some boards (like AM335x EVM-SK & AM437x GP EVM), the vtt properties
+  below are required. It is possible to toggle VTT using one of two methods
+  depending on the SoC being used, either GPIO0 toggle (AM335x and AM437x), or
+  any GPIO with DS_PAD_CONFIG bits in the control module (AM437x only). Please
+  note that only pins on the GPIO0 module can be used for GPIO toggle. It will
+  not work with any other GPIO module.
+
 properties:
   compatible:
     enum:
@@ -51,6 +61,15 @@ properties:
       mbox_wkupm3 child node.
     maxItems: 1
 
+  ti,needs-vtt-toggle:
+    type: boolean
+    description: boards requires VTT toggling during suspend/resume
+
+  ti,vtt-gpio-pin:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: pin on the GPIO0 module used for VTT toggle
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -76,6 +95,8 @@ examples:
            interrupts = <78>;
            ti,rproc = <&wkup_m3>;
            mboxes = <&mailbox &mbox_wkupm3>;
+           ti,needs-vtt-toggle;
+           ti,vtt-gpio-pin = <7>;
         };
     };
 ...
-- 
2.32.0

