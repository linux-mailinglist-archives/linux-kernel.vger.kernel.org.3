Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6E9569D57
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiGGIUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbiGGIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:20:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CB953D17
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:19:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e15so1224776edj.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36QQffcbfgyCYivXIz8C1vW53ip+ep0hb4pGJir6Ai8=;
        b=RQ1XzMNV7/E7fMX515logqe2KcF0Yhs0XpadO3PCNDe8p0KUboO0Afj8c+94Ry2U3z
         RLDD3lb8z/tDpc3d5hZo0o0qM4YlloEv0OnMk6zHfjkdiX6yCP4S+iMDkQvdJZLD/NGR
         tLufLaiOdenWIYjXyPzWGzCZh1wWmu0Ff+ymB/l1WBudOxXODbuquO0RJ/WeLELLg+hH
         NgyElH6FE1nne2vnQDuJEBhxzzsT55k/B+/IfK7pQTLjYrB5+QJwDX/imfU5vTXCpBfy
         1uVevoBlXAHlVU4bWiQh2MrN6cdRJJEWyDnib7h11k1Ea+Sj4dKIpvFQNbH/oslU7zUb
         SRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36QQffcbfgyCYivXIz8C1vW53ip+ep0hb4pGJir6Ai8=;
        b=S7DFB24CxC7In3zUTDqoomlxm+lhlWY51LryVXBr1/98a276EdEuOp6Bm8VfWGV2fe
         4xjMImhF2IOHUK/Lyp6Szwrw0AWxPLH346gjKbV8Z8aIleL77psWuGOPs/mUtDXVlzGQ
         XPCc5HycNaKIl4dBJI5RqS6AWT2DNJvjCcQtALbQN9U0DJ0sqaBhCfwj1Qp42Ca3If0E
         xbba289g0FqC4h3ucO3EkePd4S9GN/W+bs6GRnXc5NyDCqpfk0YklrLCwFNlgzpUo3ue
         rV7bcjArTWYfA0p61fbYf4JAhIS4TBqiJMyUmFMTeFdVm0mFcJNlw/t7SzKzKuLzLjN/
         twXw==
X-Gm-Message-State: AJIora+dox88KAjIvDD0oP78V2urLmLlT45qYUe174LL+jE+qq1V94d4
        15aSoQNizoXt5SAChbhVY5+2pwHuKUhAgQna
X-Google-Smtp-Source: AGRyM1tbT3fSN3xY6/W8zwopdfYWLaRrUmN/LYTVg5vzAeMd4zfvp+fAJuUH6+RvWzuqIakNjnAtig==
X-Received: by 2002:a05:6402:42c8:b0:435:b99c:35f9 with SMTP id i8-20020a05640242c800b00435b99c35f9mr61511391edc.137.1657181946010;
        Thu, 07 Jul 2022 01:19:06 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm12871779ejx.173.2022.07.07.01.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:19:05 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 2/4] dt-bindings: regulator: add bindings for output-supply
Date:   Thu,  7 Jul 2022 10:18:24 +0200
Message-Id: <20220707081826.953449-3-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree binding for the 9elements,output-supply driver.
Example is also provided.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../regulator/9elements,output-supply.yaml    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml

diff --git a/Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml b/Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml
new file mode 100644
index 000000000000..e4b67bc0794f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/9elements,output-supply.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/userspace-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator output-supply driver
+
+maintainers:
+  - Patrick Rudolph <patrick.rudolph@9elements.com>
+
+description: |
+  Regulator output-supply driver helps interact with regulator.
+  Provides regulator events & sysfs notify to capture regulator events
+  in realtime for userspace application.
+  This enables userspace application to monitor events in regulator(s) &
+  handle them appropriately.
+
+
+properties:
+  compatible:
+    enum:
+      - 9elements,output-supply
+
+  regulator-name:
+    description: Name of the consumer line
+
+  regulator-boot-on:
+    description: Enable regulator during boot
+
+  regulator-supplies:
+    description: Supply names for this regulator. This can be multiple strings
+
+patternProperties:
+  ".*-supply$":
+    description: |
+      Input supply phandle(s) for this node. There should be
+      <supply-name>-supply to pass regulators handle
+
+required:
+  - compatible
+  - regulator-supplies
+  - ".*-supply$"
+
+additionalProperties: false
+
+examples:
+  - |
+    p12v_b_consumer {
+        compatible = "9elements,output-supply";
+        regulator-name = "BCM1";
+        regulator-supplies = "vbus";
+        vbus-supply = <&p12v_b>;
+    };
+
+    ssb_rssd32 {
+        compatible = "9elements,output-supply";
+        regulator-name = "ssb_rssd32";
+        regulator-supplies = "sw0", "sw1";
+        sw0-supply = <&sw0_ssb_rssd32>;
+        sw1-supply = <&sw1_ssb_rssd32>;
+    };
+...
-- 
2.35.3

