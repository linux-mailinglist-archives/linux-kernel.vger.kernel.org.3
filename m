Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F134BE08E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355599AbiBULLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:11:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355565AbiBULKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:10:23 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2079.outbound.protection.outlook.com [40.107.255.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90AD26FF;
        Mon, 21 Feb 2022 02:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egcb+tbp2UqJ8O02aO3fw6V8wPVbU/+UvnV+Evva1UiHKlhf3b4WB2qBcuEn+o1VqoWtiwwv6Y1D8MFi8H8qjlAfm6+75JgjQFTlBFFb8vog8RxV7dVdErBpVI4m3BxZ1RkR4/UJSsTKXXdvk7/rxXvCVWtKKChEzdgZWI0K9/TWgcJs4t6FkYzfRF5BpmroOtUMQrvEXknoGrfM090BhuZ+pG/eGVxxppxkgrOxoj9gzEcfJ/R8aw/WxIisQhRp8IEL3rPg3qqtjPYjTOYnjVITYFKnhVJBO1X5mRNyX1INeiNsb3rMfGqisxD1hN7L6CWodq2cOj/Y4OZTSS7Blw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ck4HNexOujKh/dhVKdA0D9ZaTh0MMXSsNxJ0WfOzgQ=;
 b=NdHpnMP17uCwhyAr0O02jKuWJrsVv8kDavyNe94xE6XNpYEEB49TcNsHte5/sW7UOSIKgp1MCwxrAPvxPSAYUd121GdDSjDGbis6xTVxjqr3C8GRQHUf8SXjb/a7CZSlafyD4IY68duc3AFnEKG19jbRoIvhWk+y7QAsyYOwLk4JggndyZwKSuEaAylJQpk13F/AS0T0x1181bQC5EdDC3gJq/Fv5/57L9/oItOYiurQ3DmTrUd2eL5x1dmdL2wWBCfMQhrUKiHowdE0gYWrEejlfpYElCNwYMObrF/5v/3eno+qoOq0Xqad0NxfThWWEPysSfbNjOusK6RUPGngJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ck4HNexOujKh/dhVKdA0D9ZaTh0MMXSsNxJ0WfOzgQ=;
 b=KNcI6pWrA7PqdaNTQB65wj4G7i6fP2pdRImdVc8AXdHQdq+G41GDjRhDBNeTqcnyVAhyTjBUdXO3bywlmTCJV/+5Qsta16F2dpL1+2DYPVYs+1n9miXk0Kwg3OY0qC50jur0FKL98XB6TWC/jzGkEgJ2tGO7KDYMlagCq1jQHBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from HK0PR03MB3937.apcprd03.prod.outlook.com (2603:1096:203:97::12)
 by SG2PR03MB3836.apcprd03.prod.outlook.com (2603:1096:4:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.20; Mon, 21 Feb
 2022 10:41:44 +0000
Received: from HK0PR03MB3937.apcprd03.prod.outlook.com
 ([fe80::a564:9d5e:a0d6:1ef]) by HK0PR03MB3937.apcprd03.prod.outlook.com
 ([fe80::a564:9d5e:a0d6:1ef%6]) with mapi id 15.20.5017.020; Mon, 21 Feb 2022
 10:41:44 +0000
From:   CF Li <cfli0@nuvoton.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        CF Li <cfli0@nuvoton.com>
Subject: [PATCH] clk: nuvoton: Add dt-bindings header for ma35d1
Date:   Mon, 21 Feb 2022 18:41:34 +0800
Message-Id: <20220221104134.6300-1-cfli0@nuvoton.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To HK0PR03MB3937.apcprd03.prod.outlook.com
 (2603:1096:203:97::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54935a68-14ee-4702-91b9-08d9f526c09a
X-MS-TrafficTypeDiagnostic: SG2PR03MB3836:EE_
X-Microsoft-Antispam-PRVS: <SG2PR03MB38361DB4C03E86C05EBE9CC7F23A9@SG2PR03MB3836.apcprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SflzbC5pvBXIc77FqagExhjia5rL/c7R2zxKyCc80vCiZ6VFG98FtIqMZLIv9RdlO2w+BtRm5boT8Iajn6fcGlUKVFJEFfFXYMb66TwQ+mMJ7mv4zp5cBhDE3zf4HRIRI211WFktIspZaq232Z67p4yNTuSe1wCPfodEA4g85z0bWrx5zO/T7MqqQWrjkocROPEfOKt9Hj8pUSBzK6SZHealmc7fqJjkpzR/l5gT8+5Zdi27Kj48/AYSC2oXWQ9CnCI7ZHfnGSNlquw3Pg5RO1pd6/iEiVjOpnE1NwdVZTIHOnpXHV+2pyx78riedUw58uDbVnrTEmU3i14RKgYaInP5QIBPT3DjeMA+aFt5FL27RUenEmc5l5o3rr653VtoLBt1UjGsJx+jlCtz+v1TpEU5m/DWu/rr3aoPgKbLZ48uxyME7MJPEtVnGqk8pvjHi071qUlQtnuBeePHBsd+kWVsEGZm5Ur0eQK9MUAFjpaAydbLkfp6lISIlpXUZTywAYTP9fmPnrR3sAcI1D6hgePZ9pIr2YaRVijjrXOe7jgNwOFcK9Gco2o72JzvUSKn5mF3QcxkZf1d7zw3hnCbpsQfXrmFLUQhClj5wQsxBtTtxi6Ka6VESjs5MPk+AwVlwqTP0SUW1bG72YP+0JTSf21U8a4h6y1WCXH4KQpGy0TU0zwZg21NnYoR0azHYP0Mu+XmEKEgW6/g5e+Z8d0iNbDzEeoV1W+2ZfP+3gulhFJaLaaLtwJs1Vko0mb0BeYl4pGZpc+6kmPFuGMNKqBPog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3937.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(8936002)(38350700002)(6512007)(6666004)(5660300002)(4326008)(52116002)(2616005)(316002)(86362001)(508600001)(8676002)(66946007)(66556008)(66476007)(6486002)(2906002)(107886003)(26005)(83380400001)(186003)(38100700002)(1076003)(36756003)(138113003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CtFcK0mhaUA8COHDlECYwC2RtbwKLA3RTjC5bAUYxt2brpSbjm+gyS2tEE55?=
 =?us-ascii?Q?hyeWLi04YNjZwiPq2hC4FWidihBnmOWjLpVLTrrLndv9+79V5Sr6kTQVmMMW?=
 =?us-ascii?Q?U0JIo48oFSI+ehmCBceOgeaNTAwcyXsMYtgW10xTeAiVl7Ye+NC2Bl+vkECC?=
 =?us-ascii?Q?eSV5NY2x2MLq+NoyS0fKeHI2ueL2dMkp7q9H3VJZhNc03ui4F8+CLmZyKL9w?=
 =?us-ascii?Q?EojxSQEsQv5d7KPKuL20o6xHhhVlrBNF1DC7fbM8pQan3sNBH0MAVmOrrZWC?=
 =?us-ascii?Q?u/Ozr72Ih4hYIGpODp2qzCNI9uH1fiqtGi37fRrzklwXzWOO/PxUDrr79u7I?=
 =?us-ascii?Q?skjymd8FdtW3yBe02h1eKo9hJHAkDjdiNzS5DjLtemeq4Hmdn3DKa8jP9Ooh?=
 =?us-ascii?Q?lT/iKmDhIdT1kbp8fWmKCQ8R9WxoEiCTaeX1NKw/GVIrBOmZHjz0kCdAetkv?=
 =?us-ascii?Q?GlSMzNDWaoGam1h/ZYri4VtksT7uovCaJgKuSmnwNzoKgl43fSVMe/mybqg5?=
 =?us-ascii?Q?VIEdHcRZNV4b4h+rXrKFLhhyWFkLC30YK/P0nRU1/KjwU67q2JwCFoEw2x6k?=
 =?us-ascii?Q?RXrPo73HPYoxSq974VKJEIaFIYayAq0vzT7IGVcI7VxPfFotgGPa/cPcomLR?=
 =?us-ascii?Q?TsyP4nN0A7twEEI6doVtUZ2r0wkAPMj0vgw2nEuqYnvcJB3wc7bYtFPiX0kK?=
 =?us-ascii?Q?jRQW1zRx5Mzw6i+FiHDBayv+9XnXjP6Rovsh3Q4kS2P+f0hsjjP4ZSYVDEzs?=
 =?us-ascii?Q?K+soZmcw7QCaSl0piRQd/XBvgcYUsQYn7gAtSc3g9GUyWS/RYN6alptH8JBa?=
 =?us-ascii?Q?bbCjYcZSD2TCKGVaBT96IBbsf+GGbsAedyphIzbx0JeGfwk+BUnhBsIQuG6u?=
 =?us-ascii?Q?Zqx6hkAD2xKK2CHGbCCCCWd4hnJnUAG91YufDtPc2mJCoEVbXQkq+ZlOurQz?=
 =?us-ascii?Q?6u5YqnAdeab6EeIeu6CvsqX894giu+jvfH9MRR5G3SsHspws/zA1fNZbzYV/?=
 =?us-ascii?Q?49B75DwWOSxz4BHtzvUNjbhfM1WHR/4JuKQjgB0AQgwEG6wy+RH+ih8WpRFl?=
 =?us-ascii?Q?RCB8COiRrFNdM8ASQjIwB9AapNEeYMdjuImRLI95q3bYvn33Q+UQHkk8rV6u?=
 =?us-ascii?Q?KZK999xBWklO9q45OJmNlgjRro+1qgtrJsPbHuj2DqSlQha61BK3Ote8vxvG?=
 =?us-ascii?Q?yyrZFnHNsO5RRo0FkLGBX6aO/T/ZN8wrBtRwS8lYWtdChrnfcPN5Ke/rxBh9?=
 =?us-ascii?Q?zExkU0Gj3Jyjez5MMC0l0depOPun/vqhJrU7vJvWkbPuqBrZF6orPUrm3zZ+?=
 =?us-ascii?Q?OVBz6+hyPeu+O0AfpCm8q0pbztNwqSpHS2B/NhwQ+5r57EA85JiEF6A0v4UR?=
 =?us-ascii?Q?s1vwqCNVgYOeNJ1MO51J4zxxVHwNX8q4zl2qyVLa8TErFfxxHBIk19gFXKOj?=
 =?us-ascii?Q?C2vc3Rz8DiD66kgaO2gwoYQg4ezMzlM54+knC2Tz5qsXOiPUpvRScv/vDlkn?=
 =?us-ascii?Q?9pPdBKbczuCTgnwgCWUQRhjn0TcJkN5xog7pd5lhcRJTuF4huZsRCDxxtI4h?=
 =?us-ascii?Q?p3g56N/xu+e79+1IOeF8KKAWpKIl1OQTU3z8e4idEDVYHKP5jxjHCD6wJLKg?=
 =?us-ascii?Q?TfGRV+pPOABJL66Q9a3shmI=3D?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54935a68-14ee-4702-91b9-08d9f526c09a
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3937.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:41:44.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSuWUzTS1ru0FEISX7Cl13GCgzpeUcoJdcH4Bh/8OrMahcVrhxBuzfYzckAAtNZe/TTAprQEkZvwVKU0Yyoo2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB3836
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings header with clock definitions for the ma35d1.

Signed-off-by: CF Li <cfli0@nuvoton.com>
---
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 262 ++++++++++++++++++
 1 file changed, 262 insertions(+)
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h

diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bi=
ndings/clock/nuvoton,ma35d1-clk.h
new file mode 100644
index 000000000000..b8bbc7f9903f
--- /dev/null
+++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
@@ -0,0 +1,262 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Nuvoton Technology Corporation.
+ */
+
+#ifndef _DT_BINDINGS_MA35D1_CLK_H
+#define _DT_BINDINGS_MA35D1_CLK_H
+
+/* Clock Sources */
+/* External and Internal oscillator clocks */
+#define        HXT                             0
+#define        HXT_GATE                        1
+#define        LXT                             2
+#define        LXT_GATE                        3
+#define        HIRC                            4
+#define        HIRC_GATE                       5
+#define        LIRC                            6
+#define        LIRC_GATE                       7
+
+/* PLLs */
+#define        CAPLL                           8
+#define        SYSPLL                          9
+#define        DDRPLL                          10
+#define        APLL                            11
+#define        EPLL                            12
+#define        VPLL                            13
+
+/* EPLL Divider */
+#define        EPLL_DIV2                       14
+#define        EPLL_DIV4                       15
+#define        EPLL_DIV8                       16
+
+/* CA35 CPU Clock, System Clock, AXI, HCLK and PCLK */
+#define        CA35CLK_MUX                     17
+#define        AXICLK_DIV2                     18
+#define        AXICLK_DIV4                     19
+#define        AXICLK_MUX                      20
+#define        SYSCLK0_MUX                     21
+#define        SYSCLK1_MUX                     22
+#define        SYSCLK1_DIV2                    23
+#define        HCLK0                           24
+#define        HCLK1                           25
+#define        HCLK2                           26
+#define        PCLK0                           27
+#define        PCLK1                           28
+#define        PCLK2                           29
+#define        HCLK3                           30
+#define        PCLK3                           31
+#define        PCLK4                           32
+
+/* Peripheral clocks */
+/* AXI and AHB Clocks */
+#define        USBPHY0                         33
+#define        USBPHY1                         34
+#define        DDR0_GATE                       35
+#define        DDR6_GATE                       36
+#define        CAN0_MUX                        37
+#define        CAN0_DIV                        38
+#define        CAN0_GATE                       39
+#define        CAN1_MUX                        40
+#define        CAN1_DIV                        41
+#define        CAN1_GATE                       42
+#define        CAN2_MUX                        43
+#define        CAN2_DIV                        44
+#define        CAN2_GATE                       45
+#define        CAN3_MUX                        46
+#define        CAN3_DIV                        47
+#define        CAN3_GATE                       48
+#define        SDH0_MUX                        49
+#define        SDH0_GATE                       50
+#define        SDH1_MUX                        51
+#define        SDH1_GATE                       52
+#define        NAND_GATE                       53
+#define        USBD_GATE                       54
+#define        USBH_GATE                       55
+#define        HUSBH0_GATE                     56
+#define        HUSBH1_GATE                     57
+#define        GFX_MUX                         58
+#define        GFX_GATE                        59
+#define        VC8K_GATE                       60
+#define        DCU_MUX                         61
+#define        DCU_GATE                        62
+#define        DCUP_DIV                        63
+#define        EMAC0_GATE                      64
+#define        EMAC1_GATE                      65
+#define        CCAP0_MUX                       66
+#define        CCAP0_DIV                       67
+#define        CCAP0_GATE                      68
+#define        CCAP1_MUX                       69
+#define        CCAP1_DIV                       70
+#define        CCAP1_GATE                      71
+#define        PDMA0_GATE                      72
+#define        PDMA1_GATE                      73
+#define        PDMA2_GATE                      74
+#define        PDMA3_GATE                      75
+#define        WH0_GATE                        76
+#define        WH1_GATE                        77
+#define        HWS_GATE                        78
+#define        EBI_GATE                        79
+#define        SRAM0_GATE                      80
+#define        SRAM1_GATE                      81
+#define        ROM_GATE                        82
+#define        TRA_GATE                        83
+#define        DBG_MUX                         84
+#define        DBG_GATE                        85
+#define        CKO_MUX                         86
+#define        CKO_DIV                         87
+#define        CKO_GATE                        88
+#define        GTMR_GATE                       89
+#define        GPA_GATE                        90
+#define        GPB_GATE                        91
+#define        GPC_GATE                        92
+#define        GPD_GATE                        93
+#define        GPE_GATE                        94
+#define        GPF_GATE                        95
+#define        GPG_GATE                        96
+#define        GPH_GATE                        97
+#define        GPI_GATE                        98
+#define        GPJ_GATE                        99
+#define        GPK_GATE                        100
+#define        GPL_GATE                        101
+#define        GPM_GATE                        102
+#define        GPN_GATE                        103
+
+/* APB Clocks */
+#define        TMR0_MUX                        104
+#define        TMR0_GATE                       105
+#define        TMR1_MUX                        106
+#define        TMR1_GATE                       107
+#define        TMR2_MUX                        108
+#define        TMR2_GATE                       109
+#define        TMR3_MUX                        110
+#define        TMR3_GATE                       111
+#define        TMR4_MUX                        112
+#define        TMR4_GATE                       113
+#define        TMR5_MUX                        114
+#define        TMR5_GATE                       115
+#define        TMR6_MUX                        116
+#define        TMR6_GATE                       117
+#define        TMR7_MUX                        118
+#define        TMR7_GATE                       119
+#define        TMR8_MUX                        120
+#define        TMR8_GATE                       121
+#define        TMR9_MUX                        122
+#define        TMR9_GATE                       123
+#define        TMR10_MUX                       124
+#define        TMR10_GATE                      125
+#define        TMR11_MUX                       126
+#define        TMR11_GATE                      127
+#define        UART0_MUX                       128
+#define        UART0_DIV                       129
+#define        UART0_GATE                      130
+#define        UART1_MUX                       131
+#define        UART1_DIV                       132
+#define        UART1_GATE                      133
+#define        UART2_MUX                       134
+#define        UART2_DIV                       135
+#define        UART2_GATE                      136
+#define        UART3_MUX                       137
+#define        UART3_DIV                       138
+#define        UART3_GATE                      139
+#define        UART4_MUX                       140
+#define        UART4_DIV                       141
+#define        UART4_GATE                      142
+#define        UART5_MUX                       143
+#define        UART5_DIV                       144
+#define        UART5_GATE                      145
+#define        UART6_MUX                       146
+#define        UART6_DIV                       147
+#define        UART6_GATE                      148
+#define        UART7_MUX                       149
+#define        UART7_DIV                       150
+#define        UART7_GATE                      151
+#define        UART8_MUX                       152
+#define        UART8_DIV                       153
+#define        UART8_GATE                      154
+#define        UART9_MUX                       155
+#define        UART9_DIV                       156
+#define        UART9_GATE                      157
+#define        UART10_MUX                      158
+#define        UART10_DIV                      159
+#define        UART10_GATE                     160
+#define        UART11_MUX                      161
+#define        UART11_DIV                      162
+#define        UART11_GATE                     163
+#define        UART12_MUX                      164
+#define        UART12_DIV                      165
+#define        UART12_GATE                     166
+#define        UART13_MUX                      167
+#define        UART13_DIV                      168
+#define        UART13_GATE                     169
+#define        UART14_MUX                      170
+#define        UART14_DIV                      171
+#define        UART14_GATE                     172
+#define        UART15_MUX                      173
+#define        UART15_DIV                      174
+#define        UART15_GATE                     175
+#define        UART16_MUX                      176
+#define        UART16_DIV                      177
+#define        UART16_GATE                     178
+#define        RTC_GATE                        179
+#define        DDR_GATE                        180
+#define        KPI_MUX                         181
+#define        KPI_DIV                         182
+#define        KPI_GATE                        183
+#define        I2C0_GATE                       184
+#define        I2C1_GATE                       185
+#define        I2C2_GATE                       186
+#define        I2C3_GATE                       187
+#define        I2C4_GATE                       188
+#define        I2C5_GATE                       189
+#define        QSPI0_MUX                       190
+#define        QSPI0_GATE                      191
+#define        QSPI1_MUX                       192
+#define        QSPI1_GATE                      193
+#define        SMC0_MUX                        194
+#define        SMC0_DIV                        195
+#define        SMC0_GATE                       196
+#define        SMC1_MUX                        197
+#define        SMC1_DIV                        198
+#define        SMC1_GATE                       199
+#define        WDT0_MUX                        200
+#define        WDT0_GATE                       201
+#define        WDT1_MUX                        202
+#define        WDT1_GATE                       203
+#define        WDT2_MUX                        204
+#define        WDT2_GATE                       205
+#define        WWDT0_MUX                       206
+#define        WWDT1_MUX                       207
+#define        WWDT2_MUX                       208
+#define        EPWM0_GATE                      209
+#define        EPWM1_GATE                      210
+#define        EPWM2_GATE                      211
+#define        I2S0_MUX                        212
+#define        I2S0_GATE                       213
+#define        I2S1_MUX                        214
+#define        I2S1_GATE                       215
+#define        SSMCC_GATE                      216
+#define        SSPCC_GATE                      217
+#define        SPI0_MUX                        218
+#define        SPI0_GATE                       219
+#define        SPI1_MUX                        220
+#define        SPI1_GATE                       221
+#define        SPI2_MUX                        222
+#define        SPI2_GATE                       223
+#define        SPI3_MUX                        224
+#define        SPI3_GATE                       225
+#define        ECAP0_GATE                      226
+#define        ECAP1_GATE                      227
+#define        ECAP2_GATE                      228
+#define        QEI0_GATE                       229
+#define        QEI1_GATE                       230
+#define        QEI2_GATE                       231
+#define        ADC_DIV                         232
+#define        ADC_GATE                        233
+#define        EADC_DIV                        234
+#define        EADC_GATE                       235
+
+#define        CLK_MAX                         236
+#define        MA35D1_CLK_MAX_IDX              236
+
+#endif/*_DT_BINDINGS_MA35D1_CLK_H*/
--
2.17.1

________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.
