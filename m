Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4882E560BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiF2Vfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiF2VfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:35:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D229A3190D;
        Wed, 29 Jun 2022 14:35:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u12so35107367eja.8;
        Wed, 29 Jun 2022 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A93wKO/uXTQv/8Lh6Y6CctCekOaGpcWQXQjkcifmHes=;
        b=BK8Xcuk69Pi7Vcppuxoa+Xe5GLLxHngkMGUtbUTjq/tpvoIMfVnBJ3YUS2uHE0dNw3
         BZEEy4xyp7PVyOvANndESZMvaT+Ki+DBIuljFgYfZRb2DDjfTzUAMFkFUPg2v9x8XorF
         OHSi7vhRmbPEIRsnsQno9Lr/udNjW9Emk8dK8/Z/rrSycmP/QM0KW3IYRz6cOwTO5AYE
         jmOHOQ9+FINk73uU/bOTMhn8FG5X4D8NiVMJ0IGxe0dHNT1l7HT/WZR8as5MZ/i5GUW6
         52tgRhtL7xnZ1gpRRg4T8kGy62ljse0BY9R+UWDUX8ZbOBW+O4rB3A3WpToxDrhiQMjF
         wh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A93wKO/uXTQv/8Lh6Y6CctCekOaGpcWQXQjkcifmHes=;
        b=jmj49KrWqgD1snUww5vUc+kcoqbbX1knmsZVOt4Jz3oazdex+4/NpWMt+kDq+KhVwD
         8Cr/LILa1YRYJbG28LnjJoj7JXDo8SJqNfUdauoL2RRSjwWUVxbSu14sMBGbehyaNt/T
         wMb+kimARgZGXFhMa1b4qYZZyTcASUa8ZWMqJ+UWSRIHyObMQ3TntzDS3/xVgzVT4709
         NTjRpGs1p3DjTog3cYknQOvM52LYomnuae+dNOWgjyq/Q7TTPoz2JBFqlavjqusD7J7S
         B10Whna+lHdt9VAL0Bd2mTJfuo3sbxgF3k0fvTmqrr21YnbHPPPQ/vL80sppNMJ6bibB
         61qA==
X-Gm-Message-State: AJIora+OUBER1b3X6W7+pR+vHeDkgcRiwPwuhMXWmR9J1wLpUx4j8pog
        U5JgAY2FBJyG/i8GtD42zAA=
X-Google-Smtp-Source: AGRyM1tBntq0h6DliMrGtytOQadSYCkcjalAx1tGOtnkw69zz1fNwRpCsF5zmzmJHIhNklr2sSXAaA==
X-Received: by 2002:a17:907:868c:b0:722:bc0b:500e with SMTP id qa12-20020a170907868c00b00722bc0b500emr5671151ejc.703.1656538521359;
        Wed, 29 Jun 2022 14:35:21 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-003-132.77.7.pool.telefonica.de. [77.7.3.132])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1709066c8700b0070c4abe4706sm8237889ejr.158.2022.06.29.14.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:35:20 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/8] dt-bindings: mtd: intel: lgm-nand: Fix maximum chip select value
Date:   Wed, 29 Jun 2022 23:35:02 +0200
Message-Id: <20220629213508.1989600-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
References: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
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

The Intel LGM NAND IP only supports two chip selects: There's only two
CS and ADDR_SEL register sets. Fix the maximum allowed chip select value
according to the dt-bindings.

Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
index c45dd87fb5fd..af99b8f7c681 100644
--- a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
@@ -51,7 +51,7 @@ patternProperties:
     properties:
       reg:
         minimum: 0
-        maximum: 7
+        maximum: 1
 
       nand-ecc-mode: true
 
-- 
2.37.0

