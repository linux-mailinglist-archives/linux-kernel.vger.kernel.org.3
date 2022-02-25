Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B64C469D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbiBYNfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbiBYNe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:34:59 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5CD1DB3C1;
        Fri, 25 Feb 2022 05:34:27 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21PD9g12003198;
        Fri, 25 Feb 2022 14:34:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=rdOjHgKJc4SCKXlLLQvRCdwRKO1UUKziVYt8Vm+fpww=;
 b=vyq1tONAqpmVT/t6+X7Bj590/HrJtK3hvy07aJPaciaJhf07AUqzgGYN5R+GXurMi4Ka
 S7AVghBVma03IZbOuQok0Pcat+TdWyyJofyGbEJsVr8vPfR7DqQ+rn/Zkbkg4o0muycg
 iQ0flHnMBl/N2vFcPolgSEjhHCtmuPI4JD2ykNTyHVdGnOUpdA9ykhpaHOmAvUzS16Jv
 SWWcdsCkyN8jAE6mF5DpDlFok2vmydEH4IvEND2iz0r5qcO5eik0zVD+vLlxhgFKrd+7
 8ici429SXr8lEIknz+T6S3Gq01uJnTA0rKGHTBvzduhyPdEyCKGftqDPdmxMTJc+1i8R Qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3eetrn27ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 14:34:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 11C1710002A;
        Fri, 25 Feb 2022 14:34:15 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A1952278AA;
        Fri, 25 Feb 2022 14:34:15 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 25 Feb 2022 14:34:14
 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/13] ARM: dts: stm32: enable optee firmware and SCMI support on STM32MP13
Date:   Fri, 25 Feb 2022 14:31:36 +0100
Message-ID: <20220225133137.813919-13-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225133137.813919-1-gabriel.fernandez@foss.st.com>
References: <20220225133137.813919-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_08,2022-02-25_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Enable optee and SCMI clocks support.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 262de4eeb4ed..78eac53224d4 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -27,6 +27,43 @@ arm-pmu {
 		interrupt-parent = <&intc>;
 	};
 
+	scmi_sram: sram@2ffff000 {
+		compatible = "mmio-sram";
+		reg = <0x2ffff000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x2ffff000 0x1000>;
+
+		scmi_shm: scmi_shm@0 {
+			compatible = "arm,scmi-shmem";
+			reg = <0 0x80>;
+		};
+	};
+
+	firmware {
+		optee {
+			method = "smc";
+			compatible = "linaro,optee-tz";
+		};
+
+		scmi: scmi {
+			compatible = "linaro,scmi-optee";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			linaro,optee-channel-id = <0>;
+			shmem = <&scmi_shm>;
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
+		};
+	};
 	clocks {
 		clk_axi: clk-axi {
 			#clock-cells = <0>;
-- 
2.25.1

