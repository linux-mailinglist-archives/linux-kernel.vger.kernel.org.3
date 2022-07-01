Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD3562A88
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiGAE3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGAE3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:29:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D053F58FDF;
        Thu, 30 Jun 2022 21:29:43 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2614TOqn076480;
        Thu, 30 Jun 2022 23:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656649764;
        bh=RdWieFXSTVSF5qpoNseA6pN2AYbEbvotaPg5KZk9hEw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wFa7Tue+fvIhHUqukRJER25jpeTRJeeOyU2z9cY/m6mLtnXl5fexl+LqjJS75c7ZO
         Ie4nJrxc42NSwAzw1spKqYLOjR7dXDfsFXpR6EYTksMsmNEIRnqdaJDc5GKReSckAo
         BoE+HyBP8dyHmKdJIeCgFxVMK3WCbbkbFAoqlbVI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2614TOSK022508
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jun 2022 23:29:24 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 30
 Jun 2022 23:29:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 30 Jun 2022 23:29:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2614TO22062987;
        Thu, 30 Jun 2022 23:29:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Florian Eckert <fe@dev.tdt.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: adc: ti,adc128s052: Add adc08c and adc10c family
Date:   Thu, 30 Jun 2022 23:29:18 -0500
Message-ID: <20220701042919.18180-2-nm@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220701042919.18180-1-nm@ti.com>
References: <20220701042919.18180-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adcxx4s communicates with a host processor via an SPI/Microwire Bus
interface. The device family responds with 12bit data, of which the LSB
bits are 0 for the lower resolution devices. I have been able to test
adc102s051, hence adding just the missing ones in that family.

Lets reuse the binding to support the family of devices with name
ADC<bb><c>S<sss>, where
* bb is the resolution in number of bits (8, 10, 12)
* c is the number of channels (1, 2, 4, 8)
* sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
  and 101 for 1 MSPS)

Complete datasheets are available at TI's website here:
  https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf

Handling of 8, 10 and 12 bits converters are the same, the
unavailable bits are 0 in LSB :)

Inspired-by: drivers/hwmon/adcxx.c

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Checkpatch does complain with Inspired-by: insisting it to be an email
address.. but I was really inspired by the hwmon driver.. Don't know
what else to say here.. we could probably drop it?

 .../devicetree/bindings/iio/adc/ti,adc128s052.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
index d54a0183f024..85adf53c83c1 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.yaml
@@ -16,6 +16,12 @@ description: |
 properties:
   compatible:
     enum:
+      - ti,adc082s021
+      - ti,adc082s051
+      - ti,adc082s101
+      - ti,adc102s021
+      - ti,adc102s051
+      - ti,adc102s101
       - ti,adc122s021
       - ti,adc122s051
       - ti,adc122s101
-- 
2.31.1

