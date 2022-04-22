Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8350BABB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449000AbiDVOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448941AbiDVOzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:55:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5823A5C373;
        Fri, 22 Apr 2022 07:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpO7QjL3th/kQ7sIDXA5Az5VXCEDj4Vg9PkWeQVNnjB6GCQKMKevJnBJuzj+mzrs0haBIS20kBgMw5uuFjedy4n+ZaGyGRuGyWVu1NGOQ35kJIabzdCzwIJzl+76B+KYrcepUCk8h/RN/GuJ8Wg5mivCdZDJv+Xp5+AOAPcJCLqhevd096GEm0F6DbsdDB9RiUfzG3QBKRiODHhGGiS+ngSNlGOriyNqSBfPWRiCF/hLIC73zpJAinBeGh2uECGQHsL2xGprWK8CT+pHYviic1Tg+ggBuZTEsAPBMd12DlEjuapmdh+g8mNrlRnj3br9I5evg292wBwZAWW6okELBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3yWbO1eNmobBvHk2WqT+h2o6a/lggZukvnhHN1hLFY=;
 b=ig3pMcgv6FT0phl/iaM3SzJT/DLTm8IIVVYtiPgRHt9Ixf6GkowTFp2YpJVYadt9oDyilspT4du3YoFBBw+bI4naDbGcje30BfyEcHJ4WYjzVTWZ4OO+7edsh9cY77e5C2KjldE22AGMxyCXDC/QEkO7bho8ml6rfHqDR1C0A3B17HwFTU2UFJE2sV9fkNn6Z+DDwgZJMSjxrHFI9ewzXUjD7jGxsNxNMfo3Wf2BqGcYL1zecOshQ5aWVfWiAUja+jKW/VSzzV7jXz1Jg4dKaNoMAmrBDi9dXUOVoe7vT/WrPbrQhTAuvBqG0C3F9D+9o7sqQRVXfDRy0nECTPmsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3yWbO1eNmobBvHk2WqT+h2o6a/lggZukvnhHN1hLFY=;
 b=yDvdnOillpsA+vi5k+Vt81hlRk8uAf/37jnPFpffEve6g2ZImHuSCHoY322K3DGKmB132tgSYbpN9xB6vS4/7YPnBjhqvcXnQ3ubo2ogIYJ/ZFUm7IiQi2vwZFFoL4NEbR/1KdTLoE19ow8NAxxTeF18IfP2phujcEMVncYj4Rog7U2bgAwy/vCljCg+5QXzuL2necFBeqv/Zg/yL87+TglsXk3eSiZ55BKff72dOl5TB4aXFmu/VJYW/V1C2N3XH+oxctM5zEYf4974c+eQWcssZNXXiTeCDGQePbwa2DTwfp9yj3FPZdkSsqhutAgGjRQdoOH70lqUmAxWNLm7EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by VE1PR03MB5213.eurprd03.prod.outlook.com (2603:10a6:802:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 14:52:10 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 14:52:10 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 7/9] ARM: dts: Add SFP binding for TA 3.0 devices
Date:   Fri, 22 Apr 2022 10:51:45 -0400
Message-Id: <20220422145147.2210587-8-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220422145147.2210587-1-sean.anderson@seco.com>
References: <20220422145147.2210587-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2d10754-6426-4413-9a7a-08da246fad9f
X-MS-TrafficTypeDiagnostic: VE1PR03MB5213:EE_
X-Microsoft-Antispam-PRVS: <VE1PR03MB5213AB079C0A48E8193B4E4696F79@VE1PR03MB5213.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2MrcIbN1BZtXDcID2d2SSfEj63D/x1AuSV6SheX8JJLy4fROyBlHdRVvkQR/DLRhXH5J00LugSHCV+aYhQdWk3wNwxw7ljYiMI4y+PNFVtYkHC6HIQbnClgbGW4EfvDkxrBLYpAws0SscpDhM1uaQ9xEPwXBCNTwMgJtwo3xyOcsjO8foXEsFYMYTz4tvKPTy9HVu7Y1rR2WzOx3ncy0ChJFCcjk3z1FVyKI320PW2HpEnJBEj9DkmSAh1bfTFkrEFlV/C6pJZfVlyr+8oj2hg0tFRlClqDijpDZ33GgT8je2eFNPrFh4VEHW5tK8oVN18ohnPp2Y+T6+kHAOpw2Cpi9uKg3p24pD21mwtLNiu7+RzGhieTYWO9Jm8BgjMXks66/5mFHaA/vtkaGrWSSr2H9tiHYPOibxrbW2VDjPyK9V8zxcss/D1y/ePX7dgCBsIf5RPH9qLskMmgD7tVBuQ5jlI8BQt5qZKKLcF8ly5CZPXdecSbSq4oV+mTnC/BunaKv9Hihd2mkTxpHwVvOtF3XV39hCjFVQledK6nS1JNMaE7NRkTRH9LzFF0/zxM8Ur2Fno8ozmTJzoICuohvopP7XAQvOo95d6chAKepfFF4lfDD1JzZeNwplSesMeG8+SC9cWx0ItAWWeNGFMBbnrwRTfd2AArfpWc1hq+8mFX4BS4czwMC1gTfPBI/IzAVNoyUsn22GxGNw8pDKRhww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(5660300002)(186003)(7416002)(44832011)(508600001)(86362001)(52116002)(2906002)(6506007)(8936002)(107886003)(2616005)(6486002)(6666004)(83380400001)(36756003)(6512007)(54906003)(26005)(4326008)(38100700002)(38350700002)(66946007)(8676002)(1076003)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hR/UVIgYDQ1KNQqfQOLa4NNGCVnr11jIPbhSmZbCcbBDwbkOyDmTrm48T98Q?=
 =?us-ascii?Q?Z3O4P6a/JLpYonXAnhRXEQ4gLv+XqwvZpViqOd21xCgqzg2LqWYox43tWVoN?=
 =?us-ascii?Q?rkvU1tpd7UTKFxLk+SjcpT9X6jlKmy/7SVS9bJaVd50+MPU/0HWqUKGi0oK+?=
 =?us-ascii?Q?LKW4WYEzO1L+NqfpDdM88hnohfTW6zIoC43GVYXbE9CGFDP2mVgxth6yTWkA?=
 =?us-ascii?Q?kVGh0c3uN/M4PN2s83kPML5vRjoGjklmBH6gF2hEsnX+1tEVvyfL4dFswEBL?=
 =?us-ascii?Q?RIjR+J9eoeytyz+VMS4TzCBJ1gqgqSC02L+7Y+HMJMCVwA21tkeSZhHx7Flv?=
 =?us-ascii?Q?E2O0SNRUOG19u/4wZgF5KF81djCpiMV69b4dc8/fod0TSWqAFdyps7DfVniC?=
 =?us-ascii?Q?VnNE5ffVlo7PXSrx4ioxNgYFyvY46KY8Ihypn24vnVTogu8FYO3noNzWDXrN?=
 =?us-ascii?Q?NM9KNfv9VNkpJo8dz4opp7gWGwduaCuo6+k+hM+acM3xQIOosL2aq4l/18F+?=
 =?us-ascii?Q?8huJGEMBCalTapzLzdVC/AnXe1MVdetS9FbIJl4YkllDMcRw/Az5PMVb/caF?=
 =?us-ascii?Q?qGGCfmFwr7wfPYxCTWksPIZDSYXt1sied2f7oKrJ9Jf5NfBGrNwqXA6F3UGq?=
 =?us-ascii?Q?DeIJ8CkQg6wnVPdV/zew6cIdavwdiAteYaYg4IlMtV1pwmkpfgmJUvjTlWgJ?=
 =?us-ascii?Q?OZvKG4Hir29I2aXtVebn12ACv4HWYTh4AgcfbFTmrlqHM9QaNa0gBpjA+9I0?=
 =?us-ascii?Q?juX5ib0i8GDUmefQEggWWbdl8hNJbrPMaaLFpnmLNiTBJNDrGRe2IqCfyjgn?=
 =?us-ascii?Q?V/QhWK6rLW4U804JIrRadmKr9Vppe1wXsULNr0cAvGm488lP1E0CR3vE/7ph?=
 =?us-ascii?Q?uAZPmHs1LtZVM6sG2NyTzM3f8aCFlezGjqghYjncXSXOd7MlV/jdsUfp7pZW?=
 =?us-ascii?Q?PAkQ8XQdeK712F57YUuSMQxtwfO4iL7Ovc3AusO+ZVYiNd+ymOaqIalbUC6G?=
 =?us-ascii?Q?FPDjjSBAc49vvV6P6rQDKuQ0R5GuySEuxJ9kXitFSI6G26w09ei2Jxu7hFpl?=
 =?us-ascii?Q?TT/QH2rK6jJ88G/F8Iv8JSvIOZMsFEPIzNR4Nt56DSheOlwNeHHRJPIDPUhZ?=
 =?us-ascii?Q?KLpmfmNlnG76xH7i6Tv4GImbwJGsdZNKlv3i8gVH6Bz8qiDykaeoi78Zi8xH?=
 =?us-ascii?Q?wqU2AvRymONo4UeNVhQ63n5n+06vnWpzyrbODNqTKq6V5U8suaTLSEFr5NfM?=
 =?us-ascii?Q?xUguS09aZqDxLj+9Dpuj6qgLyUxQthNlsnLRscKaO++zl06MbUNZ57d8zU9J?=
 =?us-ascii?Q?rnq4ry+H3c9OnN/VH+u40wI6FEluSuG/AKbb8DG5kpgUdHk2yd+APggIGCg0?=
 =?us-ascii?Q?3jZ3n8yNzFoxIYM1ymMPefqtSrIbI/JkfoyBIryWbBHYPI7D0J/e36KPSGAQ?=
 =?us-ascii?Q?5cZsZ6ukOFCPvnNIdMzSOJbEnaf1qQLdHi9QNASZGOM6CveD2ex50XDFII3T?=
 =?us-ascii?Q?WzSmoozmKX9jF6Ahnb4ORpklUpNzw2uKmsOCEeckdK3bVOd63Z2x5dxf6z1B?=
 =?us-ascii?Q?iPJjVbJJkyp5CWppOEpcg2euyZXCxnBicYgkAzq5qS5RAM7Hfz4pzaRztbkX?=
 =?us-ascii?Q?z0njW7a8dQzesLN0E7z2Q9DriIMKn54praueN2s5QiIJrM/PPMx6m8c6YAWh?=
 =?us-ascii?Q?Lg9eOudmKOa55WDQxiFpGrbmOGq34MLjbX9pTqtZj4godeqcyCV2WVT6viIg?=
 =?us-ascii?Q?LfCiLrh6Y3eMWQn2qKYaOdN23j/lO3s=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d10754-6426-4413-9a7a-08da246fad9f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 14:52:10.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhB/Y32khJ/RnItNpHoh/H9YpoVD7yhMbincBXSi0nykSGKbe0J3kqXrPukU9RsqSjAJuebMv/GSIR0mo0k0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an SFP binding for Trust Architecture 3.0 devices.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 18e529118476..1a58e8671047 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -269,6 +269,14 @@ extirq: interrupt-controller@14 {
 			};
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		tmu: tmu@1f80000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f80000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 1282b61da8a5..5705ec554bf9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -278,6 +278,14 @@ dcfg: dcfg@1e00000 {
 			little-endian;
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		isc: syscon@1f70000 {
 			compatible = "fsl,ls2080a-isc", "syscon";
 			reg = <0x0 0x1f70000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c5daa15b020d..53dd8c7dc048 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -671,6 +671,14 @@ dcfg: syscon@1e00000 {
 			little-endian;
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		isc: syscon@1f70000 {
 			compatible = "fsl,lx2160a-isc", "syscon";
 			reg = <0x0 0x1f70000 0x0 0x10000>;
-- 
2.35.1.1320.gc452695387.dirty

