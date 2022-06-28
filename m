Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6FB55E39A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbiF1Mp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbiF1MpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2214E1D0DC;
        Tue, 28 Jun 2022 05:45:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sb34so25452359ejc.11;
        Tue, 28 Jun 2022 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWy53RILJ6Qa6Uv8/5trw4fA3o1TR4WeWhGrXiQns2g=;
        b=GI2bfTI+oPZhauznzAMgp8lBoloxpPFWPIPpXcnJNAilvSNKyrnKjpqXq7yND2gkF7
         uf22bEej7rhHW0vyyzfieSB2MB1IZlGRDzv+c+25uriZyHTspThRrM5RBmAwpfxK26VE
         o2TtcyZuCZ5hxjZDI3HYXmJ2xW5nkhvr2HWCN3+38P2CEPRdbxZSjGLqfMFmFd7OAVZJ
         v+u5mmuxA+TtxH90fqfdQNcCRs3lpPqH9mNE+GaS9Lzj7P8kYNjNcz+PI5DraymXKXRR
         mvS/CcSUaoDEDJDNi3ME9LJJUfvHhuvo1muB6tfGmYJZsT88yyD8Bsp4o8h0HUWm+uYt
         NWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWy53RILJ6Qa6Uv8/5trw4fA3o1TR4WeWhGrXiQns2g=;
        b=HTQPDIaUX/03CVZzKWFvMCnbrmlUA0fp/nxyjcQhiIGPrYRISKx8CnGNLgJ3quX4C/
         pcjEDTtlJCihxVlBbZvJW47FjQgBCvXhk4c2LxGSuX9Nzmjomc6HS0dccV5z9rMZ1ExF
         GgOX5Td4qKx5Y9Jj4Zz6T1yLNGf5hYGVTRyvWlCpe3CNlB7d8TCclFAkwB3CPNnxHZzQ
         lC9USdIn/JCBRIPmjyIMZo+4m6Dg+xVFTJmt+QRttQXxr+OLwCeZrDycmT3Y9AsxjrRG
         Qt3URxsrGvq5N3X5hCzGgnn1ZLBjMX0a+V1NWOs2Ee0CUDplbPqMRFw6GxqlMAqR/gql
         bB3w==
X-Gm-Message-State: AJIora+Ah7Xa3I1g2D1s2caKX51iC9N98b+lNshsrYHQZw76I/LxnsnQ
        Lh6IMV3L7dVZmdcK/kBfAm4=
X-Google-Smtp-Source: AGRyM1vTDsl70Af9eviVGtq5Yi/oUbUqx8gBk3UZxf/wRnSVdh4QXGUQ5G93aKdq3ZK5B3ETIHKqsQ==
X-Received: by 2002:a17:906:5343:b0:722:ea54:fe67 with SMTP id j3-20020a170906534300b00722ea54fe67mr17867627ejo.181.1656420318647;
        Tue, 28 Jun 2022 05:45:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm622871ejx.173.2022.06.28.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:45:18 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/9] dt-bindings: reset: intel,rcu-gw: Allow up to three global reset items
Date:   Tue, 28 Jun 2022 14:44:34 +0200
Message-Id: <20220628124441.2385023-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy SoCs use three elements for the global reset:
- offset
- reset bit
- status bit

Allow this in the dt-bindings as well.

Fixes: b7ab0cb00d086b ("dt-bindings: reset: Add YAML schemas for the Intel Reset controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
index 13bf6bb3f097..be64f8597710 100644
--- a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
+++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
@@ -22,11 +22,15 @@ properties:
   intel,global-reset:
     description: Global reset register offset and bit offset.
     $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
     items:
       - description: Register offset
       - description: Register bit offset
         minimum: 0
         maximum: 31
+      - description: Status bit offset (only if "#reset-cells" is 3)
+        minimum: 0
+        maximum: 31
 
   "#reset-cells":
     minimum: 2
-- 
2.36.1

