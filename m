Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD75288D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbiEPP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245306AbiEPP2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:28:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB511EEF6;
        Mon, 16 May 2022 08:28:09 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v10so14378533pgl.11;
        Mon, 16 May 2022 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mFpRGtOmuIhiGD7D0FWLTSmGnj4Hu/mNhuuhhbY9Ebg=;
        b=DNhRYJUrlkBhXbYqplYhNKX9LJJUn8zoAoD3oGkxHk/b4RlKVKv84ZjyOlKsmDYP1H
         LGY++k8NXTkFLrjvXqxNs7q7lEA/FAxvp+SIVNxc9qlp6kSQpi+61rFPf/JHgqexhEYt
         c/mrZ+74uOrsPQYTraAPvKtE6Cpr9QCRRdya48gTQsP30EOLos/FOCn8ipAtuoe8YP+T
         xAeTLl/7Qy3PPBzFLYLGmBi0yT2Mgc2rPk+K081h+4cSD6PkzN0qMMq2KRkzkAHB2eFc
         J9sLp5eUHgRnhyJtO6lDQN4mPucYEFtDjwHLtLG5/XK7Um0vesBPGxEQqq+vbtbNtFDP
         mzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mFpRGtOmuIhiGD7D0FWLTSmGnj4Hu/mNhuuhhbY9Ebg=;
        b=PRkGvhB770fTDkAosZXiErZU7HqA/tEqygoJRlo5aHIutRm3kKhvMVZVDV2mu1WZGn
         yWDhAb5N6YGVO8R5rUnUTiSHT3z8xjQDo9PsEUK8Q739szeGPzFkNckGUhx53WXAymTy
         y7IWrFgRYlbTf4B7mK5VJIeCTPaf3K9dtSoZZUCb7j/QwaSV5m1ZfETTX5orGpkk9xNl
         k8eLyqf+frvizFD2ONX8V4YDnMJNATE/yROyvB+ygovVqMe17MyQxzPTLkb5Kyw8kKuL
         kieyArb/94D8aSgXoX9ONkv0srdjBWw3UO/Dss8t5ZZi3peNMMjmok5h6zqTyY+zASKy
         MJDA==
X-Gm-Message-State: AOAM531SctKMW/MN32ViWfMZXFCsannKoM+sP2ds6bJgQAa/5OikZpO9
        P0xB2UOjnF19qSq1B5HDDkM=
X-Google-Smtp-Source: ABdhPJzpw/VXi0SgEApDCwAOAKLlNIiL/drvGpMjBE9bCvQPPS4xE3+AIeyS9T3cmuly0UDuRDoufA==
X-Received: by 2002:a63:85c6:0:b0:3ab:4545:e29e with SMTP id u189-20020a6385c6000000b003ab4545e29emr15300294pgd.573.1652714889354;
        Mon, 16 May 2022 08:28:09 -0700 (PDT)
Received: from localhost.localdomain ([116.89.131.16])
        by smtp.gmail.com with ESMTPSA id d15-20020a655acf000000b003c14af50605sm6895126pgt.29.2022.05.16.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:28:08 -0700 (PDT)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     benjaminfair@google.com, yuenn@google.com, venture@google.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, avifishman70@gmail.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        JJLIU0@nuvoton.com, KFTING@nuvoton.com, ctcchien@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
Date:   Mon, 16 May 2022 23:27:50 +0800
Message-Id: <20220516152751.27716-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220516152751.27716-1-ctcchien@nuvoton.com>
References: <20220516152751.27716-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 .../bindings/rtc/nuvoton,nct3018y.yaml        | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
new file mode 100644
index 000000000000..788d92a32a70
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nuvoton,nct3018y.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NUVOTON NCT3018Y Real Time Clock
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+maintainers:
+  - Medad CChien <ctcchien@nuvoton.com>
+
+properties:
+  compatible:
+    const: nuvoton,nct3018y
+
+  reg:
+    maxItems: 1
+
+  start-year: true
+
+  reset-source: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@6f {
+            compatible = "nuvoton,nct3018y";
+            reg = <0x6f>;
+        };
+    };
+
+...
-- 
2.17.1

