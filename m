Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521CD46F25F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbhLIRqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbhLIRqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:46:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB8AC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:42:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so4706652wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qqK9+xQ9ZbtBELQAT0EXm6TWiIt+xXrrL7fOffh/Mk=;
        b=swxVRUXimw2W0nql09GwFWrzunSGiTpyC0gIyxyFYN1Dsy7gNq0X9WTTLgh1neZcAH
         nCIp+9n2+NnAzbizapTLdyXdPG5ce9MoU1foUmZ78cIFbjc79sHxnAm/FdcRjXPJeyC2
         DstUVGwBpbzLQ3xHjAPNFYmqEfE7n6kszR2ht/lK3d+vScLmwSmN/hkeAOQqPUGuXr1Z
         1JSlb472zlPiw1XUQfrdTYUfcHyFDhiOSVNNxLLIBA4HDPicyTHdZesrRrQLIzvAZo45
         ne1Tc+AgGVWd2+aZ6kYaWZyIey1BDbrsekOUdcn0cHfMeAj3C9A+disu6qQixs77gWOv
         IF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qqK9+xQ9ZbtBELQAT0EXm6TWiIt+xXrrL7fOffh/Mk=;
        b=v+bVcCRhr7ED8ZGcRJ91BNjVATcdqwhj+zHq6DsQO5ShuHxi8yWrsuwg961Z1X8Io+
         85JBRTPHhTbdpWHhT/pjhn4FGuccL8rWxHKbLl5dNWwv+9R2t9HGCvtE3MOs1WVQ9jzf
         1zp1qZoCW9bGDTYUZYoTpxFrJB4P4B8Cw/0qBf0EPAg5YB2fcZ4Dj02J+NorWOj9ID4M
         fFiSLeiflaBOsCjzYE5WNdm9Znkne0Fi6etiJhlXUI4rZxLtgnE/msuPAdYjfYXHG0rC
         t8jEmL8X1ot83O4sWgBb4+Es8KFx8QB7JHtfOJ0aoeyaInac+ISC4ZqiC8W9ngTGjriT
         qlqg==
X-Gm-Message-State: AOAM530AV1K3zvoFNAIncJTsavaK5fZwvgNSRnVTcfHg7UKJpXl7aGeY
        fxs5ju8Zsayg847nwZ8stPnz9g==
X-Google-Smtp-Source: ABdhPJwCv+vjl+oQsw4enZewe0eQ0mMvqsRmRIJqksr/2N4WKMc8gdbQp9dYk7yOUjrpWsd/GzTzyg==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr8895294wmi.134.1639071770161;
        Thu, 09 Dec 2021 09:42:50 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id w4sm308666wrs.88.2021.12.09.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:42:49 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4/4] dt-bindings: nvmem: Add missing 'reg' property
Date:   Thu,  9 Dec 2021 17:42:35 +0000
Message-Id: <20211209174235.14049-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211209174235.14049-1-srinivas.kandagatla@linaro.org>
References: <20211209174235.14049-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

With 'unevaluatedProperties' support implemented, the following warnings
are generated in the nvmem examples:

Documentation/devicetree/bindings/nvmem/st,stm32-romem.example.dt.yaml: efuse@1fff7800: Unevaluated properties are not allowed ('reg' was unexpected)
Documentation/devicetree/bindings/nvmem/rmem.example.dt.yaml: nvram@10000000: Unevaluated properties are not allowed ('reg' was unexpected)
Documentation/devicetree/bindings/nvmem/brcm,nvram.example.dt.yaml: nvram@1eff0000: Unevaluated properties are not allowed ('reg' was unexpected)

Add the missing 'reg' property definition.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Rafał Miłecki <rafal@milecki.pl>
Cc: Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml     | 3 +++
 Documentation/devicetree/bindings/nvmem/rmem.yaml           | 3 +++
 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 58ff6b0bdb1a..8c3f0cd22821 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -24,6 +24,9 @@ properties:
   compatible:
     const: brcm,nvram
 
+  reg:
+    maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
index 1d85a0a30846..a4a755dcfc43 100644
--- a/Documentation/devicetree/bindings/nvmem/rmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
@@ -19,6 +19,9 @@ properties:
           - raspberrypi,bootloader-config
       - const: nvmem-rmem
 
+  reg:
+    maxItems: 1
+
   no-map:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
index a48c8fa56bce..448a2678dc62 100644
--- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
@@ -24,6 +24,9 @@ properties:
       - st,stm32f4-otp
       - st,stm32mp15-bsec
 
+  reg:
+    maxItems: 1
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
-- 
2.21.0

