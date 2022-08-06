Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4656A58B4B1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbiHFI7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiHFI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:59:10 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80109.outbound.protection.outlook.com [40.107.8.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D1615FE0;
        Sat,  6 Aug 2022 01:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDykZvN4vAfSwQOaHLzgdzh6Dp8H/Km5YwHZSNa6PRzqoLHaYWNV0OJIm6vFHfw+7TQuBgJAH71p8AHN8sqliK3MC/XalsbcR8dvBwM+9Plj22eE+d18sJ1DYTDZVH1haUAg0lFxFdZ84xyr6iHX+36gxmgaLEdIC/IVwc1AIFbDqAyfwstIjz8K6rYKUsjgPrS2xUEgpdE6YUzMhOemgzPGNV0+OKANSlUE202+T1LHezk7gyUlkD000yl/WKgrDD0WpZCydU3difTsIIwqROZpud1SVer+E55EDSCifZkBQhpPjkUd1fPi4Um3SsESnR3QMDr176GTCcFDrXhIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHuXGICrjgFOuVxk2MyjXKIwyKADe4tqLiEvVuzXzjM=;
 b=jFiDRMb2Huqo210En8lE7ofBgnJJcYkLj6ftHzWRqPSPCD4BlPwXeKGLWj7Vu/Cm1SO7mWWJmK+1q5j9SihrOEL2hnSSKHoUVLr6XhtyTY2Uq2H2FfbM/xCMBHXJo/nBCh/KfeXdcxnwEFimH41EG/pccxDufVMLLY/xvOuJZ2wGKmKdISRgNVhRxOk8KdyseNnSJPJDy3jFcmhSb9zbBgvFltoBnE/cCXtu3MacG4/v1/9U2ONLo01BHsio67t5ag0WWPr39gW0XiLivflv03HkGOsMa+qJB9dgApfyXKNATzkjcueRRlxjN/OPAhQPazFoF7fDWXF7m67sSFWuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHuXGICrjgFOuVxk2MyjXKIwyKADe4tqLiEvVuzXzjM=;
 b=Xmy13RodtYmb1kgmVSZ79Jcnnc1ZECDVUk6FUBCzgMXzT++ku/JqgcyGxIzVrDjfq16Jkl+YhuISXDg5WvN071tTcjQUu4jwykqBDZdDzSYHoWuOC68KK52YpGOtW8bjerZeU5+6npXBSt3TKh3R7EzC/P04vSUk7LP9FVOfR1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DB9P190MB1098.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Sat, 6 Aug
 2022 08:59:05 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::80b1:f2a0:4365:3c59]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::80b1:f2a0:4365:3c59%3]) with mapi id 15.20.5504.014; Sat, 6 Aug 2022
 08:59:05 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH 3/3] arm64: dts: marvell: Add DTSI to fix Xenon SDHCI 2G limitation on AC5 SoC
Date:   Sat,  6 Aug 2022 11:58:14 +0300
Message-Id: <20220806085818.9873-4-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220806085818.9873-1-vadym.kochan@plvision.eu>
References: <20220806085818.9873-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::15) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6da7dee-35fe-4bad-2ceb-08da7789ea61
X-MS-TrafficTypeDiagnostic: DB9P190MB1098:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqP3gUfgfqvzVcN5KMgfQgG4YYWMvXnmKqOexT5Iur/ndPvCGv9G998psQyMmsxgpBtW1z2McD16l4ERjbbpipQv+2QXEXifXyf3pEuwxMSxvUmgSVQIhgH4a2qHJOmpAhUhX1IgAakZnqVx95vBcgB1qlU5hcNwvVw3jKK5kII+hM0/Q//63Z5CSplQlh53MP7LwFQDo3efvKQ8AFut4Xlhf/KsnrdAfL/5qvKfRO5yuh9onilnu6QQyEgwVULhRpKZvl3GzStstD01Asbw4EeXloYWfKj3emv/l8wtG8URNwmadYoexdmeiztmcrosYJfmfCRMjVtr5w74LFe2Ix9h7fS/cchLeBaoq7n2GwTeEB0+e3sHV5YIE3Ht2H7BBipd6gJz0zBpL+IeXkFZebBGNwzFaWnn8BBsJR48HUle6aUIwOE4KNAc+RgHWCNb2E2xawmC1eC81KEPtZs0y2jiCi9t4UlCWekkSZOUUKhemYXbuDubs1+pYrDYkAM0tZzcHBNz+29DzLItGJ8ixVFnp/8AsFUFXm2iA7OJl3XyZVQBjD8RQrzcUcBoM94z5g6EBtSDgVizVE2crTDmEySXM372SUm1J1YZSe/1p6GmlIpfjpXCbESQjDGsI9iWJ5nNbS5Im+sGomOGpsYvvH70ejUZKiZRTX/ZuV/wWq78c3eJx0sWsMuiBv+tKCXa6X+arI8ck4CdIsfh1pUdxxR4b5QWOOiUxVSwD5aw8YoI+m584/6LWvOw2TlLvsyLh8FOjKucrnNuH7PUa9J6Eg9CY+OfvYOhzbnTz0MkeW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39830400003)(34036004)(366004)(396003)(44832011)(2906002)(41320700001)(8676002)(66476007)(66556008)(66946007)(4326008)(508600001)(6486002)(316002)(36756003)(110136005)(38100700002)(26005)(41300700001)(52116002)(6666004)(86362001)(6512007)(6506007)(8936002)(5660300002)(38350700002)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PbR1Go4d4RbtwVUhQ59LqSU7bXizznLdnOdxmoKqSfmkfg6bGQKPw73v+mYA?=
 =?us-ascii?Q?zYoXvrsV2UEug71HRsuoL/m1W24ZLUIIpFUY8lVl4ZhXYx0y8N814UYEHoYb?=
 =?us-ascii?Q?1HMkoDd/27TBesDAdDY9v/5V280S6FAf8mQkuVFWqvcbZpRt5LiIu95y17gp?=
 =?us-ascii?Q?c+2ZfJtY42EpzBv+IEWIuUCi3/jV3d3EZffWPG8iYyeLE7izzHUybukYkqqP?=
 =?us-ascii?Q?jXnghCF1+KRzEfEUOik/v2Rp1cFChc/oR1b8MVXa2/AtnSfMgW3Ffho/3tGN?=
 =?us-ascii?Q?m91jFp+EQCgtwk6yuls1ogdTwtGarM9QCTsBS4dOz2qaSnJAX0Q+jNUT//L2?=
 =?us-ascii?Q?hx1FmGyRUarYFVCMfs8KIb/yxlMnkB2zg8awlEwWWIZu14Qf9l1PJ6K/6alh?=
 =?us-ascii?Q?VN5m2oyXdtSVLqpWhhgCSBQCkXCkEpyOzoRsnCI8d9AnKF9AxLRWU2thfQ07?=
 =?us-ascii?Q?7ttENzxjZqNtHsiNinsOOHj04G1Vm8JAlsXTGhS6VBngzoR9UDkt7FBDohIw?=
 =?us-ascii?Q?yofRGRNB9OUFjdOxKTqLq+VHYpA8Jo6wad+LLzOoQNcMoDxkaM4csFRq5bM9?=
 =?us-ascii?Q?5QugYcYKqWSoDyhjiCo22454gmBAwrF+pL9TK3j+fsHAraweAzLMb/4VHq1I?=
 =?us-ascii?Q?BZKX9fI/AkrqTyjoI/gwBr8X5GsrvZZaFr4ChU+VSW5mpg752A8QCoZsUI1a?=
 =?us-ascii?Q?CoRzMUJbY3DLC3QKnlbM2jwnG+vYdZYKxJnHX9/ahdx7L07ZDEuVaSFCYM2i?=
 =?us-ascii?Q?kowtDGSJkf31K+5dYYxvOW/5oE6B2iZuTjKgcl35S0FiIgVIb3Dbyg+fKriD?=
 =?us-ascii?Q?PWn+IrXAQnT5l7u0PQzyrV2BAo06lesSO8MFTY1AcisPupN+2rz/Lp7EPXWc?=
 =?us-ascii?Q?0l/yNUW2RBEzA7tV2y85jMjJ49plUL5bJfbo7rUwoa9X1/99wFVGkOpqyg4G?=
 =?us-ascii?Q?aZ7M0H6VV08q9pGFLdpcnH28K7iFI9SnWA6PbDa2VYXFCGY4h92HJyDwPPym?=
 =?us-ascii?Q?o6sgMBgRJaA7vPabL5dZuII5H+6IO6jxKNa9R2PEsy0A3d1W+C8t3qr+jmq8?=
 =?us-ascii?Q?iwK3LfiwtycfDn2pk76OYag0RUxWsqjgOEQ/AqPeOYPHgVgsrJa4dBpuiMnr?=
 =?us-ascii?Q?hAB7KdwVq4Jf576ZbtCbQAGC3XCEwsMLAPNVO+XtpdJqXtuq8eRsIIk5DPrw?=
 =?us-ascii?Q?I/20+zpgdia7mPBRMgfMdI9DKE+PuVPmTTmTfZL5Qjk0A2eL7bQ6Q6feURV7?=
 =?us-ascii?Q?A8QV/2bUCcK/Asm4MyxqLIzzbid/bf6iyFV8iDWU6QhpHG6MrSiPc1l7n4by?=
 =?us-ascii?Q?G1WYcxXx+nl0luMWJbmLSzkzjpCW4SiNLSNpA0u7vqZaFM1fDhb+rSTmB6sO?=
 =?us-ascii?Q?+zcE+h/+JYAtwcsd8siSevSe9OpSz3fh4TVRQmrHRlUuEmrseQCK5nasZ+Gk?=
 =?us-ascii?Q?F+NaVUCauJyV2fZX93VEJFb5Wb+uKHtBy/So6u56next/vCrvFow1B0QWK8l?=
 =?us-ascii?Q?ojzsSABYeZXmQMGFG2ijSjzRoejV+mylNGI/BJSDOJ43QWjk5Edfixi2wTBs?=
 =?us-ascii?Q?abyHGAm6FahhGtxEIgfdLcVi/ulTKE/pa7qhs0McCKFSbaDO3sFJPxWIlDCE?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c6da7dee-35fe-4bad-2ceb-08da7789ea61
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2022 08:59:05.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ispCFq80mwyzTNMIvdXi9WECFCPi66khtssBit39ulLAlWOcWidZZq2PMTGCbMHFaHIOt6Gp5UIoHCwyn/ZgqknNGB1e1JTWK/fvwo2sZp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a limitation in Xenon SDHCI on AC5 SoC that it can address only
the first 2G of memory, so it was decided to use reserved-memory as
bounce buffer because swiotlb=force and SDMA mode did not help.

There is a custom property which is used to attach bounce memory region
to the device on demand (only if more 2G memory is used). This is a software
property only so it was not described in the dt-bindings.

Separate DTSI is added to reserve memory only for boards with eMMC cards.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 .../boot/dts/marvell/ac5-98dx25xx-sdhci.dtsi  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx25xx-sdhci.dtsi

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx-sdhci.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx-sdhci.dtsi
new file mode 100644
index 000000000000..cc5e53b64473
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx-sdhci.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree Include file for AC5 with SDHCI support
+ *
+ * Copyright (C) 2022 Marvell
+ */
+
+/ {
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * SDHCI controller in AC5 SoC has 2G address space
+		 * limitation, so in case if RAM has more 2G then use
+		 * this dedicated memory region.
+		 */
+		sdhci_dma_restricted_region: sdhci-dma-restricted-region@0 {
+			compatible = "restricted-dma-pool";
+			reg = <0x2 0x0 0x0 0x200000>;
+		};
+	};
+
+	sdhci_dma_bounce_pool: sdhci-dma-bounce-pool@0 {
+		memory-region = <&sdhci_dma_restricted_region>;
+	};
+
+	soc {
+		sdhci: sdhci@805c0000 {
+			compatible = "marvell,ac5-sdhci";
+			reg = <0x0 0x805c0000 0x0 0x300>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cnm_clock>;
+			clock-names = "core";
+			marvell,ac5-sdhci-dma-bounce-pool = <&sdhci_dma_bounce_pool>;
+			status = "okay";
+		};
+	};
+};
-- 
2.17.1

