Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC0651C10F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiEENrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379855AbiEENrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:47:05 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE257999;
        Thu,  5 May 2022 06:43:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 245DhA3u030876;
        Thu, 5 May 2022 08:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651758190;
        bh=7PpGp+IxjY/mFC2wCH1dJ/EU5sBQTGAt350jNpBo3oU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=h2aKHfebjZGw0M5mTyx/EmM6CIDH2KRf6D6PMo2jfhRwr7+GFLgmlQLJ+Ql2vOuUn
         mCIg/J0s3GM/9h31tAb4eqOENIxWoUkV+9j+APvQN8qPl0cV5eKhJhn7x/BNoxyJUq
         0l6ewkMnQF4+Kbpq0brtGnlQK8mzkRA2VfIknR+4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 245DhA6J053453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 May 2022 08:43:10 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 5
 May 2022 08:43:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 5 May 2022 08:43:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 245Dh939104707;
        Thu, 5 May 2022 08:43:09 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v2 3/4] arm64: dts: ti: k3-am625-sk: Update main-i2c1 frequency
Date:   Thu, 5 May 2022 19:13:02 +0530
Message-ID: <20220505134303.23208-4-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505134303.23208-1-a-bhatia1@ti.com>
References: <20220505134303.23208-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Rahul T R <r-ravikumar@ti.com>
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

