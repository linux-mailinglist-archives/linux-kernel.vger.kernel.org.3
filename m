Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B569515D64
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382743AbiD3NQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382692AbiD3NQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:16:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F134282D23
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:12:58 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so7403210wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X01Xnve0qqr6OIc5S2nNdJzpIGzcmZy0c42E2H5TnFA=;
        b=0BDgOPux36pkiBKZ1Awo5enlCPyaYpWLmekPEnzNCVxB2COH9QPxWkacPNxgRb/CmC
         idlXYFLT19/YaJnVREMNOdAvOsVBBiNCdraRObIy2OjNC1xH/SKUgN+Zd6FGaPrJGOcp
         /OiJMBOE5PUYwX9QqWXnS9GKXFh/gm8mazu4tHKKzV82gKwPDIErXFcsfsWLy3tA2plI
         VtPWLgwiSQ0Hro1hrlHoRBEvfX4CZ5iZcpcPWWO1ZYkoisjrlqvcwcUn0R/OLwx+sfS+
         dro6uUwVJ4agBlQMjvgRs+k+LB7V9rRj+Asi/9qhWx/z/OxrGWwl2FtShOcp0ATpY3nH
         +4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X01Xnve0qqr6OIc5S2nNdJzpIGzcmZy0c42E2H5TnFA=;
        b=BFILoTPaOK2VhER1y9tMzx1TOy6WAxe+JK4xyKklKznPW6Hq9PAn2w8MI/uRg2gyst
         edP3YlJgsuj17Sv57/BlB4IDVN2nOuNwDVlTLedTy0cXdtBka2J30iPzfSku/ajw5dyM
         4XUOSIS9FStPAJ1sdpj2hSTJ9tkTCne96t7huV/+mqC+fc5X16gGDRmvv+7hw6wo3oUF
         NDZI1dj/8A3nwfIfIw3eSwyq5h/ja1aRAgygZmB5y2djLBWAFViSS0VHqWpZ9F3dZz9c
         n4IsokWII4ptiuCEyj2PlYOshzEqX591jUYbhmD6KVcYhuSwenK+U9+VAeA/ghftLyQW
         Eiaw==
X-Gm-Message-State: AOAM530SCuYhUqUKGiOszw0QQSQPl3zMCetVbNiyzavESzqXKjxhvKGO
        FWoH+1Vj/LwhEYYRowyY4od4jQ==
X-Google-Smtp-Source: ABdhPJxEFPS4yI2UKBPZYVYHHGUEADdn/oo4ZI7S0StmG9hSxuFz1e5YOjLmg07b+nO4hMsKZnHO7g==
X-Received: by 2002:a05:600c:a44:b0:38e:3ce3:3148 with SMTP id c4-20020a05600c0a4400b0038e3ce33148mr3542227wmq.26.1651324377553;
        Sat, 30 Apr 2022 06:12:57 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id p9-20020adfa209000000b0020c5253d8ebsm2004439wra.55.2022.04.30.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:12:57 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Conor Dooley <mail@conchuod.ie>
Subject: [PATCH v2 4/8] dt-bindings: riscv: microchip: document icicle reference design
Date:   Sat, 30 Apr 2022 14:09:19 +0100
Message-Id: <20220430130922.3504268-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220430130922.3504268-1-mail@conchuod.ie>
References: <20220430130922.3504268-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add a compatible for the icicle kit's reference design. This represents
the FPGA fabric's contents & is versioned to denote which release of the
reference design it applies to.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Conor Dooley <mail@conchuod.ie>
---
 .../devicetree/bindings/riscv/microchip.yaml          | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 3f981e897126..c9d8fcc7a69e 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -17,10 +17,13 @@ properties:
   $nodename:
     const: '/'
   compatible:
-    items:
-      - enum:
-          - microchip,mpfs-icicle-kit
-      - const: microchip,mpfs
+    oneOf:
+      - items:
+          - enum:
+              - microchip,mpfs-icicle-kit
+          - const: microchip,mpfs
+      - items:
+          - const: microchip,mpfs-icicle-reference-rtlv2203
 
 additionalProperties: true
 
-- 
2.36.0

