Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137BF51098B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354455AbiDZULB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242266AbiDZULA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:11:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8AA1594BF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:07:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d15so31218640pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SW1r9xunGXg3yysfsoaj8Bnq3ZsDVEmEB9V/7mp80tU=;
        b=7foukoKrNys4GHY3j9yVIeTLC11mNsmvO+E3VubNfVzYpMrBO9+k1a/ihtJxR3yqUq
         1cj12lZdpqoUHhANmWi9mQ284vUoriuKdbMei9dT8Jr1nyi3aS7Ardpp2ac8V4U41dOK
         LzMHk23dHQhAJ0CLjQgmi5anszhTn/rmr321XgE772L2JLQ/jAZ7bYFeJhIz7UonBQa0
         GZ133toLbgaGfFrvviTMRTHM6lyleti47cuBlY2Hfl8y57DgVbrScBIBghlHdFiQToxM
         HXOeqZrxihZ4RWmgKR+yBWkrET4T+wT+xEtikLo2yeLRpr4g1khZz8hsQLBdwkADw1TI
         nOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SW1r9xunGXg3yysfsoaj8Bnq3ZsDVEmEB9V/7mp80tU=;
        b=TUU5PCmhqlgh/FHppJa6A19CnoY7Ajbe1TZTF3NQir5hQawL64uQQs5rhM9Wjyu3tc
         CHvx5TybMgaY47nJPnmHMohEpfPpBfhsR0Ab1A0HNHipCzpZ6HgNPTpPWM6PcCN08IB5
         YJg1yCjbUi7JkifZptbiwED9nutmvZrWjbx3rHkTbuN1HKIWKtX3TWjRqxM+Qa5LxpR1
         FCVEoShhHuKUQPUHGC3IuiN1oHtYadxGCsme6UuUCRxbotXxgCPtKsa/x6oJwBSUhk1o
         U7NDS+UBdPX4Yn8U/nbY5qKyjLrOl6gnpzAfS4n9j/UlXYde9I1SborawJ3rx3LqVE13
         9a/w==
X-Gm-Message-State: AOAM531j8kupkDVnmwvFwZish86IEEsIMfnZnz64t62cvIS1k6WVjm09
        psUi3USEat3VLdTxsH6WWmDnoA==
X-Google-Smtp-Source: ABdhPJzr32AprvOhjotUxBt1JDzT7nBTFeQBBS3sRqmMoxfYRupnoD0lnK7Y5rRAjQ3m31/sT/HE7g==
X-Received: by 2002:a17:902:e542:b0:15d:1ba:78d9 with SMTP id n2-20020a170902e54200b0015d01ba78d9mr14341049plf.107.1651003671259;
        Tue, 26 Apr 2022 13:07:51 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:9bcd:e060:b370:70d8])
        by smtp.gmail.com with ESMTPSA id o5-20020a62f905000000b0050b5b5efa47sm16203839pfh.191.2022.04.26.13.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:07:50 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: wkup-m3-ipc: Add firmware-name property
Date:   Tue, 26 Apr 2022 13:07:42 -0700
Message-Id: <20220426200741.712842-2-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220426200741.712842-1-dfustini@baylibre.com>
References: <20220426200741.712842-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Document that the firmware-name property can be used to indicate a file
contains I2C sequences for PMIC voltage scaling during deep sleep.

Based on previous work by Russ Dill.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
[dfustini: split from driver patch and convert to json-schema]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Changes from v2:
- fix the property name in this commit message

Changes from v1:
- change 'ti,scale-data-fw' to 'firmware-name'
- add 'firmware-name' property to the examples

 .../devicetree/bindings/soc/ti/wkup-m3-ipc.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
index 88d690de050c..0df41c4f60c1 100644
--- a/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/wkup-m3-ipc.yaml
@@ -40,6 +40,12 @@ description: |+
   override the pin's existing bias (pull-up/pull-down) and value (high/low) when
   IO isolation is active.
 
+  Support for I2C PMIC Voltage Scaling
+  ====================================
+  It is possible to pass the name of a binary file to load into the CM3 memory.
+  The binary data is the I2C sequences for the CM3 to send out to the PMIC
+  during low power mode entry.
+
 properties:
   compatible:
     enum:
@@ -67,6 +73,10 @@ properties:
       mbox_wkupm3 child node.
     maxItems: 1
 
+  firmware-name:
+    description:
+      Name of binary file with I2C sequences for PMIC voltage scaling
+
   ti,vtt-gpio-pin:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: GPIO pin connected to enable pin on VTT regulator
@@ -117,6 +127,7 @@ examples:
            ti,rproc = <&wkup_m3>;
            mboxes = <&am335x_mailbox &mbox_wkupm3>;
            ti,vtt-gpio-pin = <7>;
+           firmware-name = "am335x-evm-scale-data.bin";
         };
     };
 
@@ -157,6 +168,7 @@ examples:
            ti,rproc = <&wkup_m3>;
            mboxes = <&am437x_mailbox &mbox_wkupm3>;
            ti,set-io-isolation;
+           firmware-name = "am43x-evm-scale-data.bin";
         };
     };
 
-- 
2.32.0

