Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A9147FD87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhL0NgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39576
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236787AbhL0NgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:06 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C69694005A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612164;
        bh=dTI2zDeDg5Ov2MVesAdMFb4DLtPjkHsfZX6ZhlC4pnM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=HmBLSIaKhooLStAl34yCWecDsemlm/PO8BJReovS+lBiIdSvSuMdEyIKetG80wmr6
         ZRSwSCQoNhW+O4FnO4k0FlrLpusCqVRjvNhoAQLxbfZbYkpFh2E6SJY3ASXzkb2uem
         +IdOq21GNneLZuTLcMwIeuKWwrceeIDqgoFZ88vMx0pgVqXPgSjcFVQukfv/5oImgv
         +8aDkvXXswlwyDq2e3VGnnHlzOoJa7uH58NDpLcbveV0MZ7p7fqqsg1MbX2oYDCGcG
         MABdi0iF2YwawRZbBuroRve6mK4x28BE9ZpHSVzwmXYEwO/MFPRNWZBLxQuuM+n7YE
         H2PaNXW9JPggA==
Received: by mail-lj1-f198.google.com with SMTP id y4-20020a2e95c4000000b0022dbab5f69eso2202464ljh.14
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTI2zDeDg5Ov2MVesAdMFb4DLtPjkHsfZX6ZhlC4pnM=;
        b=xJTQ1RsEZDQaZ4r2fqOhqJK5M6o/s3OKtVlDZ35/+8ci7MtJqV1mqnu1GDVma1Jot5
         +ape8M7glDBpgs59OrkGrRutfxrKRz271BzotVZhNr9dx2xhQj6imYmyiTTHwEbqqCbR
         dAK4dhGxHvFRa3ZmX9jhT7Qb0Y5u3wEW+k6JCHZulu/d8Y6xkMYDB6eOzAduO+OY714z
         R+B87RAa7g9Gg8+dkh4H0RcE2up8djIryhVn8fot34b1DlBUirnTxb9m9iw4Y6BbQWbB
         nE7NUejEE8BRSiLbqmwieLD9uhR8tvY/MwBoUosjF/3f1fAveX9j1gzBlhefKh/6J8tc
         TXLQ==
X-Gm-Message-State: AOAM530qeGwwNmRUAl1MsuqZwALVaypULdifo20DMiAvwiS9kySBtqId
        Vol5D3EQntOaANgAZrdOQ2icvPADgipXxXgdpKpUks5oefSK5HiqcE7gdjwfid471s0GYuc36b9
        k+PejsqxbM+YfpjS/zHlZV7fz/dLCWXV9GYpeW7IQ6A==
X-Received: by 2002:a05:6512:c28:: with SMTP id z40mr15234311lfu.160.1640612164170;
        Mon, 27 Dec 2021 05:36:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2MmCuF0ftBRccsslCA92Tl7JVpFwqCVAXujMVaa5RH22ZImz8yFM+eB/OQd7LrY9vX9AA5Q==
X-Received: by 2002:a05:6512:c28:: with SMTP id z40mr15234303lfu.160.1640612163963;
        Mon, 27 Dec 2021 05:36:03 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 09/19] dt-bindings: mmc: synopsys-dw-mshc: integrate Altera and Imagination
Date:   Mon, 27 Dec 2021 14:35:48 +0100
Message-Id: <20211227133558.135185-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for Altera and Imagination extensions are the same as for
the original Synopsys Designware Mobile Storage Host Controller.
Integrate them into Synopsys bindings to have dtschema coverage.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/mmc/img-dw-mshc.txt   | 28 -------------------
 .../bindings/mmc/socfpga-dw-mshc.txt          | 23 ---------------
 .../bindings/mmc/synopsys-dw-mshc.yaml        |  5 +++-
 3 files changed, 4 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
deleted file mode 100644
index c54e577eea07..000000000000
--- a/Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Imagination specific extensions to the Synopsys Designware Mobile Storage
-  Host Controller
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the Imagination specific
-extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-
-* compatible: should be
-	- "img,pistachio-dw-mshc": for Pistachio SoCs
-
-Example:
-
-	mmc@18142000 {
-		compatible = "img,pistachio-dw-mshc";
-		reg = <0x18142000 0x400>;
-		interrupts = <GIC_SHARED 39 IRQ_TYPE_LEVEL_HIGH>;
-
-		clocks = <&system_clk>, <&sdhost_clk>;
-		clock-names = "biu", "ciu";
-
-		fifo-depth = <0x20>;
-		bus-width = <4>;
-		disable-wp;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
deleted file mode 100644
index 4897bea7e3f8..000000000000
--- a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Altera SOCFPGA specific extensions to the Synopsys Designware Mobile
-  Storage Host Controller
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the Altera SOCFPGA specific
-extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-
-* compatible: should be
-	- "altr,socfpga-dw-mshc": for Altera's SOCFPGA platform
-
-Example:
-
-	mmc: dwmmc0@ff704000 {
-		compatible = "altr,socfpga-dw-mshc";
-		reg = <0xff704000 0x1000>;
-		interrupts = <0 129 4>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index 240abb6f102c..ae6d6fca79e2 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -15,7 +15,10 @@ maintainers:
 # Everything else is described in the common file
 properties:
   compatible:
-    const: snps,dw-mshc
+    enum:
+      - altr,socfpga-dw-mshc
+      - img,pistachio-dw-mshc
+      - snps,dw-mshc
 
   reg:
     maxItems: 1
-- 
2.32.0

