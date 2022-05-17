Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B4529E15
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbiEQJaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244635AbiEQJaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:30:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37833EB5;
        Tue, 17 May 2022 02:30:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so1887488pjb.2;
        Tue, 17 May 2022 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mFpRGtOmuIhiGD7D0FWLTSmGnj4Hu/mNhuuhhbY9Ebg=;
        b=aXyC3ZS5t7ipijq1PXlVXuX3XGBsirl0S7jfGDm4yUhUHLDQYRTd4R5YIQ8tLLRztB
         B5KPuRLsTMgTFr9zzE977+yCjloFEt++bS7dPBsgXAVfvWXopQOPXxS5Z9t4Ev4k6dfp
         iTW2jbRxT2B/SRkSs4FGw3SxFaYV+yY5XrXrwcwRZf93wD8GUYz+fZsDDT1lUnTk6cy4
         HSpBW502WQg+L435HiGmmmHKm6MeSYvgAlklcFt2PPVbwrsxeAJ3tL5BbHyM3F9NPZJB
         zAd+aX3S3sRo6R4bq2HaiQnx/W1Q50GKaHaH24bNGusqmkN8vbabSGrN7+W82qpkxpj0
         gCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mFpRGtOmuIhiGD7D0FWLTSmGnj4Hu/mNhuuhhbY9Ebg=;
        b=TyvO/jImMaHpOZgeI4WzmzV4sJd+9QF99d2KvSFVSjWXxeu75FsHkHJ4zCEpaN6aha
         YdUdeTU3Mq0rEaYLmIbzRJQmTSFZhqQn6aeH/wWsK9d3EnUzkwdgrnWaUvGiQntbywfI
         9ga7By2By1F+jcfd3EVYl7bCrDSwbvNFjMptg9JkPoybLAUtEhqzt8/xNU2n0mYBhd1O
         vvNPAAtA3pczjz52QvED2u33pC6uQFWnEyFj8THUbZ+i70BTxYac8mMtQPVDZPyVJDsP
         Tjx8JRwuz0bi1VhZDXhqwYejKIMzXNe1zQJ3GJycHWhPH+/co0iB35d9Czy+W06S3urr
         AizQ==
X-Gm-Message-State: AOAM530JHQN9bZhqxSnGitOFCAWa1cBu9Raok0Nhgh4Emap6biNOHPcv
        V1SBPrUZzVoYd2wZ1VIklts=
X-Google-Smtp-Source: ABdhPJwF8mVQzn32mkC4c739pbMqoY9M06OPC/8qZo1KmO0MYhQsrCFE63IMXhM1UsvIBWvt82xGNw==
X-Received: by 2002:a17:90b:3843:b0:1dc:3da2:7fd8 with SMTP id nl3-20020a17090b384300b001dc3da27fd8mr23870463pjb.219.1652779803774;
        Tue, 17 May 2022 02:30:03 -0700 (PDT)
Received: from localhost.localdomain ([116.89.131.16])
        by smtp.gmail.com with ESMTPSA id h17-20020a62b411000000b0050df474e4d2sm8399720pfn.218.2022.05.17.02.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 02:30:03 -0700 (PDT)
From:   Medad CChien <medadyoung@gmail.com>
X-Google-Original-From: Medad CChien <ctcchien@nuvoton.com>
To:     benjaminfair@google.com, yuenn@google.com, venture@google.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, avifishman70@gmail.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        JJLIU0@nuvoton.com, KFTING@nuvoton.com, ctcchien@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
Date:   Tue, 17 May 2022 17:29:25 +0800
Message-Id: <20220517092927.19537-3-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517092927.19537-1-ctcchien@nuvoton.com>
References: <20220517092927.19537-1-ctcchien@nuvoton.com>
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

