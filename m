Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7877504EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbiDRKXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiDRKXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:23:39 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EFD192A2;
        Mon, 18 Apr 2022 03:21:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23IAKqsC036644;
        Mon, 18 Apr 2022 05:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650277252;
        bh=GETV6o1XWx9p5QEWsFgu7ckK5R4K843mHXCaKcojxGs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VBPl4xE7KE82wKBVYiUFXUjpK1BV36uf4AVwOeksL8+zEsZRtz/wjOiSks2I/RzUT
         PpdsOLyVo5FuP102pR38k5oZM4egBMegI4S95baNBxtrPsuXtQ4PW6kHKVas+MohfW
         7ggirrvY2Po87NJ0+y19EGBFUErsmdIFYcOksy3w=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23IAKqDk070509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Apr 2022 05:20:52 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 18
 Apr 2022 05:20:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 18 Apr 2022 05:20:52 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23IAKgTZ021324;
        Mon, 18 Apr 2022 05:20:49 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-am654: Add flag to force setting to TESTCD bit
Date:   Mon, 18 Apr 2022 15:50:39 +0530
Message-ID: <20220418102040.4993-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220418102040.4993-1-a-govindraju@ti.com>
References: <20220418102040.4993-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARASAN MMC controller on Keystone 3 class of devices needs the SDCD
line to be connected for proper functioning. Similar to the issue pointed
out in sdhci-of-arasan.c driver, commit 3794c542641f ("mmc:
sdhci-of-arasan: Set controller to test mode when no CD bit").

In cases where SDCD line is not connected, driver support has been added to
force the controller into test mode and set the TESTCD bit. In order to
implement this quirk the driver uses "ti,fails-without-test-cd" flag from
the device tree node. Therefore, update the bindings to document the above.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 0566493c4def..0ab07759b472 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -186,6 +186,13 @@ properties:
     description: Clock Delay Buffer Select
     $ref: "/schemas/types.yaml#/definitions/uint32"
 
+  ti,fails-without-test-cd:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When present, indicates that the CD line is not connected
+      and the controller is required to be forced into Test mode
+      to set the TESTCD bit.
+
 required:
   - compatible
   - reg
-- 
2.17.1

