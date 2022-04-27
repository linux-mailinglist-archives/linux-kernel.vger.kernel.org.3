Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05AB511424
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiD0JNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiD0JM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:12:57 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2803246D83;
        Wed, 27 Apr 2022 02:09:39 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R98wKe096536;
        Wed, 27 Apr 2022 04:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651050538;
        bh=tZmsedJBK+wypmz7ZMqScfecunctYA+e1BUCoMpA3L4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aNfVUh7g1x6SSD48M99Ff/4BfgX2xIgk20xloWFGn2DZOwb6C4UQNueXNmoc5rX8q
         Fix8K9rBfJy52f4c/WYJiClyQOV5OV7uY4urfp6JZexhEiRJVDSDX7Qcvco0O4dmDA
         KgmXQWf/280bXfNImmOOtpSONwFW9EfJHoOe2GcQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R98waq011856
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 04:08:58 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 04:08:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 04:08:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R98utF008682;
        Wed, 27 Apr 2022 04:08:57 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-am625-sk: Update main-i2c1 frequency
Date:   Wed, 27 Apr 2022 14:38:49 +0530
Message-ID: <20220427090850.32280-4-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427090850.32280-1-a-bhatia1@ti.com>
References: <20220427090850.32280-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the main-i2c1 frequency from 400KHz to 100KHz.

There are 2 devices on the i2c-1 bus. An IO-Expander and an HDMI TX.
Both of these are capable of servicing i2c upto a max frequency of
400KHz.

However, below warning log shows up while running any userspace
application that uses the HDMI display when the main-i2c1 frequency is
set at 400KHz.

[  985.773431] omap_i2c 20010000.i2c: controller timed out

With some further tests using 2 frequencies, 100 KHz and 400KHz across
different HDMI cable & monitor setups, it was observed that,

 - i2c frequency of 400KHz works fine with standard good quality HDMI
   cables with branded displays. It will show the controller timeout
   warnings only when a sub-standard / generic HDMI cable is being used.

 - Using 100KHz for i2c frequency, stops the warning from showing up
   for the generic HDMI cables as well.

Since, the IO-Expander is the only other component on that i2c bus and
we are not performing any intensive operations on it, it would be safe
to set the i2c frequency at 100KHz in order to support a broader variety
of HDMI cables.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index ab3d90d358ee..96414c5dacf7 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -357,7 +357,7 @@ &main_i2c0 {
 &main_i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 
 	exp1: gpio@22 {
 		compatible = "ti,tca6424";
-- 
2.36.0

