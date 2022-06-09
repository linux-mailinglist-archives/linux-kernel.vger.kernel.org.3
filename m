Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE2544A69
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbiFILjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236946AbiFILjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:39:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B6A47054
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:39:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o10so30786828edi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yoi+zPkWqTTvlN+wO0cy6XLBUH8069tfMWIB3LL7MAs=;
        b=jiHkLK2k0V/g9+AU3CbOGfidj6TqBsk4kjV64geDER1L1xv+kpMA6vTWnvPc0C3HcS
         g8yVvr7jLk/na3LS/SGySvcKJPqXFiUPI7S/5y6LUCElhUncPQWSccSD+hLN4lryu3Mu
         LUnNeC5yPeRjldMXzw++Sohz1TSconnBpYNnZbZw+aJ18630ydwPup+sBYpkBNTK0I4o
         ii8PEtXpm02HpG9/z1Hy6kcnwfBJlcGHD0BVITC2VWhn8Jldo5DUSz9jaXiJYFm2wc0i
         69jQFNVwsQ+slukxmL3x5og1A9PjRJHXqtXW7THYyyw6Qy17CCsAJE1Ip9zIHNYqyg2Z
         t9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yoi+zPkWqTTvlN+wO0cy6XLBUH8069tfMWIB3LL7MAs=;
        b=S4kiO01j2N7oVYish3iefcXCNeNE9Gib0LCpBCo0L5HQRHKJmyurQ1t9ALO3UztkZt
         oHjyDhBk824Zo1FeV69/0pBJLYZ64RH/ItrhoOfn/LF6ceFPKM2crxJwPjWIB6Q2RhfN
         pa5u1sYcqTSQTrSww4NYSXdp/x7JJ8AHdJ5QK5AiyuVFlAluIaOq0T0LydUBKO0VsXIG
         apYGqtJ3k/NfftDvVw19RZQFBbUYHUZZ4T+g+jzugs4hElgaD80QgyV8cLH1OOqwTxzP
         TVoUbI61+R1FSEZQPxcEl4MaaEi3kcNUlUPuEHiMzeV1xleykQNXX8N3BmMlx0BS0z1C
         pysg==
X-Gm-Message-State: AOAM531bWwKC+hzQKWuD0KWI0Q8ZUTZp4xnG6NYD87Y2n8mCqtbGyqpN
        nKELTUTsaRonZJdi73j1vLgDcQ==
X-Google-Smtp-Source: ABdhPJy+7F28cex3h0pFanY6YezFkbHHuVzHYvL0vVNyCbO/DG3qqXf1BUvEgXxJsF4hNHkgS2Vp7g==
X-Received: by 2002:a05:6402:3586:b0:42e:2a6a:218b with SMTP id y6-20020a056402358600b0042e2a6a218bmr38718649edc.208.1654774754952;
        Thu, 09 Jun 2022 04:39:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d54e000000b0042e21f8c412sm11898495edr.42.2022.06.09.04.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:39:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 02/48] dt-bindings: input: gpio-keys: reference input.yaml and document properties
Date:   Thu,  9 Jun 2022 13:39:04 +0200
Message-Id: <20220609113911.380368-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original text bindings documented "autorepeat" and "label"
properties (in the device node, beside the nodes with keys).  DTS use
also poll-interval.  Reference the input.yaml to get these top-level
properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/input/gpio-keys.yaml  | 32 +++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index 27bb5c6ab8d9..e722e681d237 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -15,6 +15,13 @@ properties:
       - gpio-keys
       - gpio-keys-polled
 
+  autorepeat: true
+
+  label:
+    description: Name of entire device
+
+  poll-interval: true
+
 patternProperties:
   "^(button|event|key|switch|(button|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$":
     $ref: input.yaml#
@@ -94,19 +101,18 @@ patternProperties:
 
     unevaluatedProperties: false
 
-if:
-  properties:
-    compatible:
-      const: gpio-keys-polled
-then:
-  properties:
-    poll-interval:
-      description:
-        Poll interval time in milliseconds
-      $ref: /schemas/types.yaml#/definitions/uint32
-
-  required:
-    - poll-interval
+allOf:
+  - $ref: input.yaml#
+  - if:
+      properties:
+        compatible:
+          const: gpio-keys-polled
+    then:
+      required:
+        - poll-interval
+    else:
+      properties:
+        poll-interval: false
 
 additionalProperties: false
 
-- 
2.34.1

