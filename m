Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8985048E744
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbiANJR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239753AbiANJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:17:55 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D7C06173F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:17:54 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id n11so10828431plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95yOM2oPjDW4I8teUQkYRlUXa8kIk+GmIx7gO72jBTY=;
        b=YPEZ7ukMzI2cN/31vBowmfQTiXMWclpljDXP5gx0881agK7JAmHUVY9q42xB0ig2sz
         G+JyRiZ6CP9KFEzGsvCZTn+9VGV7e3bS76bD7Mrkyu1blZVp4jGMillm7mL8+h0/9Uuw
         UAH3zINjhF1GKPTpYEoelai6zo6X3Mg4G4ymZHOqyAmxnygG3BdqsAkX4yR87t7RGODz
         IRHxnTz8fFK3SyL+f8ExbfdTi2FOpmMiW0kplgbiJ2gLFUMwBgKD9YXT848RdGbVbCzH
         p/ih7UBtp26Hxy3VATbG+fbJuJeBXFTcVxcKRM+ukRA9rjqxgp0CkMZGM+h1UQ6Y0BKG
         u4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95yOM2oPjDW4I8teUQkYRlUXa8kIk+GmIx7gO72jBTY=;
        b=Zluf7BnB7Zx1ThabbD8uIrOTPqokUcBipPufiOIZdCG4qcLIBiycHgFxuN5O+s4wK6
         jZKJlV9UYFXgm+mXGFNhH9y7QOVctMRQpoiBd28tqDuSkI49hxKJY4RNDQZKDM/DJkMW
         WJqKgSZGlwFtxJYENWbhm+QAq7eU4Ot6JtuHFihzx8iqdwqJLlKRXSCdTAxGKNgG6HSq
         p+yTBAGt2YW5kNLkjv3BEtAPgXHarcLU9G4QEdw56dx6OfmtQEg/oQk/qEuKU5WGVVHU
         QOKjuc4BDDxAl9TvP+K8yAN8Qgzy2JGKqy4v0iH3cKWWJzfMH71RZfuCri0PThVkwK95
         9Q4g==
X-Gm-Message-State: AOAM5315mWMiq9wY75NiygfYxQc3/mbVmSuNwmo8+TJy3RJK0vEatbAK
        C9Yq78LeapWmtmHPps2MjMsVESriWpqf4xyo
X-Google-Smtp-Source: ABdhPJwT/nt0sujPYxFREq4ukryghTeohQvw9hI58l80zXnLp1SZJVKh4R2Mb5hKDbfGttEkklp60A==
X-Received: by 2002:a17:90b:4a8e:: with SMTP id lp14mr5351158pjb.6.1642151874394;
        Fri, 14 Jan 2022 01:17:54 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id z3sm4237179pgc.45.2022.01.14.01.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 01:17:53 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 2/3] dt-bindings: Add dma-channels for pdma device node
Date:   Fri, 14 Jan 2022 17:17:40 +0800
Message-Id: <5db314b798cd9cfcb5cb61bc56515220b7d50315.1642151791.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642151791.git.zong.li@sifive.com>
References: <cover.1642151791.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma-channels property, then we can determine how many channels there
by device tree, rather than statically defines it in PDMA driver

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
index d32a71b975fe..3dbb8caefc17 100644
--- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
+++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
@@ -34,6 +34,12 @@ properties:
     minItems: 1
     maxItems: 8
 
+  dma-channels:
+    description: For backwards-compatible, the default value is 4
+    minimum: 1
+    maximum: 4
+    default: 4
+
   '#dma-cells':
     const: 1
 
@@ -50,6 +56,7 @@ examples:
     dma@3000000 {
       compatible = "sifive,fu540-c000-pdma";
       reg = <0x3000000 0x8000>;
+      dma-channels = <4>;
       interrupts = <23 24 25 26 27 28 29 30>;
       #dma-cells = <1>;
     };
-- 
2.31.1

