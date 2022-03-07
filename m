Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5634CF4B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiCGJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiCGJUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:20:48 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2055.outbound.protection.outlook.com [40.107.215.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3E517DF;
        Mon,  7 Mar 2022 01:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFYfXpSPhKVVdIuiDQ1cTUWCC03pWXYfiqcwOLLPns1vrXFz7bm7hwhcKj4vwrPZ8JIZL5wK4jWkJCvcmnYpo/JNlCTxi0Ek1F3GIxBcKPnpPZh2kmeY9SCcFa1qH1fDrJAUTwAJH+HZzxDS4y5Ol+sLpigH7tUrFN5uZRxx5rTFm3CncEzG1ioMr+rXnZXUEaBf79/to4bYB90bPdVxKHh45fDMO2LRYrv+DHEjhd0rBLorSynhooukJKrYYT32HxR9mkzGI7Bo2BHTKAFVQPFNS9gMiqpA13/31rAruyNASOOVPoduJ0fzoj7qTkIqLa1qsn2KCwBkdH53PQfNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBe2uK7z9BH0Agoojh3RMuWkRPRB7x9WVAJfFN9vd1A=;
 b=hIWTumZ32HZPMmp/zDeZP8UCaeT11GRbHSHkzBJu/a0edu9zkfCguViDLrwAAHdwVD532aGFxpTKio7yi3dnw2W7X+8IJ5I2OuIC8BeN62aqv4xOl1kt/USBVEp+P5W3ABG3dByrcdzA7/gNGnHXOqcQFI/Lz09SkMKDpKmAabh62wYCsKrW8mQ3Mxc6j8+sO60+0zNkKn2XJfloy9Ra3bdzaaQK8zTnHdcfSQ934VjUgd5Pc4seb19Qfn2sfejDGPjdtpEE4ZKGmiUFYjXVUpKVrgBZlO/NX7N/QjhQxTUOdWyVGb83NWBExMZa1OmU5lK6GTmXxioyOlojaB6y+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBe2uK7z9BH0Agoojh3RMuWkRPRB7x9WVAJfFN9vd1A=;
 b=mFg6y78S5SveaRhTjntI8ZlcAuIWsX38bDbyLSV4CA/aV43+aTBQwLBPqf/7K6FNuTRyJ7s34KE4DQiKpgI3pzEGw0Jj1tLnuDH1l+QzXUpVCiseEGDzjHxuIODCGatqrRpDXlgK/kiXStP8nwZ17S7Xyjy2RvCuLRhAbnVXARU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com (2603:1096:203:b1::19)
 by KL1PR03MB4646.apcprd03.prod.outlook.com (2603:1096:820:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8; Mon, 7 Mar
 2022 09:19:37 +0000
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e]) by HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e%3]) with mapi id 15.20.5061.017; Mon, 7 Mar 2022
 09:19:37 +0000
From:   Jacky Huang <ychuang3@nuvoton.com>
To:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        arnd@arndb.de, olof@lixom.net
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 1/3] dt-bindings: clock: add binding for MA35D1 clock controller
Date:   Mon,  7 Mar 2022 17:19:21 +0800
Message-Id: <20220307091923.9909-2-ychuang3@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220307091923.9909-1-ychuang3@nuvoton.com>
References: <20220307091923.9909-1-ychuang3@nuvoton.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0079.apcprd04.prod.outlook.com
 (2603:1096:202:15::23) To HK0PR03MB4833.apcprd03.prod.outlook.com
 (2603:1096:203:b1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9413de9a-3c3c-4017-d6ef-08da001b99d7
X-MS-TrafficTypeDiagnostic: KL1PR03MB4646:EE_
X-Microsoft-Antispam-PRVS: <KL1PR03MB464633FDE735CED891B706E59E089@KL1PR03MB4646.apcprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGXsys1Mr+v92/fz1UaaqDMegPyoTtZ2MeW1B0j6Ss8vLdOrgJPHm/SF5IfW60Vpj6bo1/3LyW6TU94uV27HABaJSethxufr+n7C0SLO8T0pFVZeDPHmgr7odZS28f+qdeK1GmRw3T2iX9Aj8FoQywkpXXBmmrAW7FOiUtvJ6Dvt/DwjJBK0SLiDbcNoStOCMm3nJ8AyUiIil2kbvZ0wZKzo6dOCY2dpKNRtlP0zm85z54ehFHXmFYfyZO74udgFUNBoeQ8Q0qvMrt9XcJobifSzwycRG74kFNXJMmVoabasgxTwspZyxysloNO9aXf5VsbSqoH8AGIwsJdHKFhV4DV40xvm2cdhqv7Ni97Xn7UzC/ny3mTprxLr7NctrA2t2F1mdC7LBjRdVqX4BTZpKLji+iq9wUsDe2wS0na7Ia1d4oznRNRmLB/QCnKBT1GrcxT3vImnZSPwcSB4AQJxvdo20Z5pZucxU/46a5ec/aZqVLyrlaF4a1ApKO+ADXrFsgAdLSweV1BBkdSmBFokdgRTWgQ7eAwlVcnaQDEBNiBaMlhy0eW6vfr18pXhkjXSEV7yhKFZqV2FLldqq/RUtUTH44ulW5YNk5jbDMSOSTtyqLndAiR7gCK2qAsszANDFDRS/V9OXXloFqQlpOEFLua0vUV0WZ4Kc+1QzP/sg8y+LdBu44D5wkkuMYemliqJFYmJeWIMIP3Hr5HVqXs/cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB4833.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(38100700002)(38350700002)(2616005)(1076003)(186003)(508600001)(5660300002)(8936002)(7416002)(2906002)(26005)(36756003)(6666004)(6512007)(6506007)(66556008)(66476007)(86362001)(8676002)(66946007)(4326008)(52116002)(107886003)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Ha9+6Y+EnbJ2PkdMKIqR0c3teGLEcVK59rY0Ti+ziXowNpQB/vX1atzPWh1?=
 =?us-ascii?Q?eRseTDaC72DBfyaOgusmfno8UJVyl6Fz69Drm5ZErBcJlx8ycatGJrUkkZJF?=
 =?us-ascii?Q?8r2vLTOWLplcJ/8l+e4FZ6lAhFWadLsxazATpqm7Y7s6JD9MO0mm+j/tR22G?=
 =?us-ascii?Q?bCMpFs4w/LJ85CaKDwET3ehzK0/kZMcONP47U0ezReK32KglskYxBLIiBrIj?=
 =?us-ascii?Q?UwupBZEhttNtGbJROTVdKlzAu9SmrulzZn4WrQF9YREij/uqoxb9swOz8n6K?=
 =?us-ascii?Q?I9Z01lm2TsBkHHoTm5WXBydClVzTgvJInGNjZhK/TDCaD7Mofm5dUneEuzag?=
 =?us-ascii?Q?dc+RXeitOlgW21EEEd9ei47au7354x6nU6+oNvt92TvSget2oveMe94zuNzk?=
 =?us-ascii?Q?D7YDNWogQhl77ExuVzHsH0OAX1oRXVPDE2AKOG9by69SCfE/Z/bDQRaDcK6f?=
 =?us-ascii?Q?CdF7lTgKy/GzYnXJok1jpOjtSUmpwhaYWngY2BIqg8vL1s6PpsmL656s6KaI?=
 =?us-ascii?Q?MKoRGlgXehqlM24iXMroGiA9QeSVg6nCreWw9woN5UZG7SyWAB7tPfMCRwb1?=
 =?us-ascii?Q?IFjsPVZ2Hm8OLb0eOAApaBpAtdHZOyyVE6uS5YrmvMl4rW9eTUqCJs8OSCAs?=
 =?us-ascii?Q?ik5OBZaD4lDDxP5NDN82LLpGHIPivyw8Eid4GS95rSz+/ZsyPxBsFDFmR7uw?=
 =?us-ascii?Q?Gpk/589hNtNQeDxgAJ79JPp+Gnt133sj0RIy0IRUUyMgZq/iwdeg7hKnJZpa?=
 =?us-ascii?Q?Z+mnmMlAGm+IitTaubyAEPoS165DZ2AA8Fob0dD7VedVo+sSWX6MygBm0+Dw?=
 =?us-ascii?Q?kqHqSzp3NfUKK62AYnzraiUXJzzz4gQJWhLEGgZRoJ0y/TpGAIHGg+IvV0ad?=
 =?us-ascii?Q?h0cKFYe3qREbBmIkOGKuefJhwotZbhhyAvf3WVqvzsfwM/PAU7UdWzazc1Zp?=
 =?us-ascii?Q?O8PCj1D6Gw6DIhcaxfC7x3kvJOxmP8Ivmz6+nb2O5+jOxYLGj4jj6Hr+KrHT?=
 =?us-ascii?Q?jOXse0LKbHOUkfjF4t/Ue9SbOPT66oFSGdXTecZ3QF6Re9sZVrW4YrOCzIp0?=
 =?us-ascii?Q?HoFP5x0AcNcqob/6oQJBUphpmX7m11A4lrvVoc/uB6GUOKQl8zkUlrrzLcXa?=
 =?us-ascii?Q?vC43oUkkKRvfcfDy1bZKxNDpqU+xCQfhkvxljQlJEeRLA3fbjnBqtBhofjGK?=
 =?us-ascii?Q?/280CDY6IkMsly2afWRKr9w9RvFKPiVIn0llgQBvjst0mNUwsvWBQPtF9rGA?=
 =?us-ascii?Q?kLhiJaXWlOsK9HYy7QvrR7uV0vJ+grloGUNK+k1mL0x2MZcWWAuteaZ36ezj?=
 =?us-ascii?Q?JuLfvkbDEYCj2/C7H0i7DSoDxzCVzbPwo6KZN39gMeSi1wYS68rrJCNuLUcl?=
 =?us-ascii?Q?zFEr9zqJ6RZOCgIffFkqRvjE6rGrL5zFKRitYe8fxEV4kf/6TZdR/QPX/0Xa?=
 =?us-ascii?Q?Y7eJI/MVFiPzkzkroUS9UvJfhhnkb2KRKlp0M9x1IuEQFYTw9xxyHQ=3D=3D?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9413de9a-3c3c-4017-d6ef-08da001b99d7
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB4833.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 09:19:37.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLoXB9m8uenoG8pHMovV1MAh8gpIxuvxDYVRooX6OXUr0B1ccHftg6Y+guDe7v2vT13wX+p6OF/AIYj3Xsjyhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB4646
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dt-bindings header for Nuvoton MA35D1, that gets shared
between the clock controller and clock references in the dts.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 262 ++++++++++++++++++
 1 file changed, 262 insertions(+)
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h

diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bi=
ndings/clock/nuvoton,ma35d1-clk.h
new file mode 100644
index 000000000000..3634e5edcac5
--- /dev/null
+++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
@@ -0,0 +1,262 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
+/*
+ * Copyright (c) 2022 Nuvoton Technology Corporation.
+ */
+
+#ifndef __DT_BINDINGS_MA35D1_CLK_H
+#define __DT_BINDINGS_MA35D1_CLK_H
+
+/* Clock Sources */
+/* External and Internal oscillator clocks */
+#define        HXT             0
+#define        HXT_GATE        1
+#define        LXT             2
+#define        LXT_GATE        3
+#define        HIRC            4
+#define        HIRC_GATE       5
+#define        LIRC            6
+#define        LIRC_GATE       7
+
+/* PLLs */
+#define        CAPLL           8
+#define        SYSPLL          9
+#define        DDRPLL          10
+#define        APLL            11
+#define        EPLL            12
+#define        VPLL            13
+
+/* EPLL Divider */
+#define        EPLL_DIV2       14
+#define        EPLL_DIV4       15
+#define        EPLL_DIV8       16
+
+/* CA35 CPU Clock, System Clock, AXI, HCLK and PCLK */
+#define        CA35CLK_MUX     17
+#define        AXICLK_DIV2     18
+#define        AXICLK_DIV4     19
+#define        AXICLK_MUX      20
+#define        SYSCLK0_MUX     21
+#define        SYSCLK1_MUX     22
+#define        SYSCLK1_DIV2    23
+#define        HCLK0           24
+#define        HCLK1           25
+#define        HCLK2           26
+#define        PCLK0           27
+#define        PCLK1           28
+#define        PCLK2           29
+#define        HCLK3           30
+#define        PCLK3           31
+#define        PCLK4           32
+
+/* Peripheral clocks */
+/* AXI and AHB Clocks */
+#define        USBPHY0         33
+#define        USBPHY1         34
+#define        DDR0_GATE       35
+#define        DDR6_GATE       36
+#define        CAN0_MUX        37
+#define        CAN0_DIV        38
+#define        CAN0_GATE       39
+#define        CAN1_MUX        40
+#define        CAN1_DIV        41
+#define        CAN1_GATE       42
+#define        CAN2_MUX        43
+#define        CAN2_DIV        44
+#define        CAN2_GATE       45
+#define        CAN3_MUX        46
+#define        CAN3_DIV        47
+#define        CAN3_GATE       48
+#define        SDH0_MUX        49
+#define        SDH0_GATE       50
+#define        SDH1_MUX        51
+#define        SDH1_GATE       52
+#define        NAND_GATE       53
+#define        USBD_GATE       54
+#define        USBH_GATE       55
+#define        HUSBH0_GATE     56
+#define        HUSBH1_GATE     57
+#define        GFX_MUX         58
+#define        GFX_GATE        59
+#define        VC8K_GATE       60
+#define        DCU_MUX         61
+#define        DCU_GATE        62
+#define        DCUP_DIV        63
+#define        EMAC0_GATE      64
+#define        EMAC1_GATE      65
+#define        CCAP0_MUX       66
+#define        CCAP0_DIV       67
+#define        CCAP0_GATE      68
+#define        CCAP1_MUX       69
+#define        CCAP1_DIV       70
+#define        CCAP1_GATE      71
+#define        PDMA0_GATE      72
+#define        PDMA1_GATE      73
+#define        PDMA2_GATE      74
+#define        PDMA3_GATE      75
+#define        WH0_GATE        76
+#define        WH1_GATE        77
+#define        HWS_GATE        78
+#define        EBI_GATE        79
+#define        SRAM0_GATE      80
+#define        SRAM1_GATE      81
+#define        ROM_GATE        82
+#define        TRA_GATE        83
+#define        DBG_MUX         84
+#define        DBG_GATE        85
+#define        CKO_MUX         86
+#define        CKO_DIV         87
+#define        CKO_GATE        88
+#define        GTMR_GATE       89
+#define        GPA_GATE        90
+#define        GPB_GATE        91
+#define        GPC_GATE        92
+#define        GPD_GATE        93
+#define        GPE_GATE        94
+#define        GPF_GATE        95
+#define        GPG_GATE        96
+#define        GPH_GATE        97
+#define        GPI_GATE        98
+#define        GPJ_GATE        99
+#define        GPK_GATE        100
+#define        GPL_GATE        101
+#define        GPM_GATE        102
+#define        GPN_GATE        103
+
+/* APB Clocks */
+#define        TMR0_MUX        104
+#define        TMR0_GATE       105
+#define        TMR1_MUX        106
+#define        TMR1_GATE       107
+#define        TMR2_MUX        108
+#define        TMR2_GATE       109
+#define        TMR3_MUX        110
+#define        TMR3_GATE       111
+#define        TMR4_MUX        112
+#define        TMR4_GATE       113
+#define        TMR5_MUX        114
+#define        TMR5_GATE       115
+#define        TMR6_MUX        116
+#define        TMR6_GATE       117
+#define        TMR7_MUX        118
+#define        TMR7_GATE       119
+#define        TMR8_MUX        120
+#define        TMR8_GATE       121
+#define        TMR9_MUX        122
+#define        TMR9_GATE       123
+#define        TMR10_MUX       124
+#define        TMR10_GATE      125
+#define        TMR11_MUX       126
+#define        TMR11_GATE      127
+#define        UART0_MUX       128
+#define        UART0_DIV       129
+#define        UART0_GATE      130
+#define        UART1_MUX       131
+#define        UART1_DIV       132
+#define        UART1_GATE      133
+#define        UART2_MUX       134
+#define        UART2_DIV       135
+#define        UART2_GATE      136
+#define        UART3_MUX       137
+#define        UART3_DIV       138
+#define        UART3_GATE      139
+#define        UART4_MUX       140
+#define        UART4_DIV       141
+#define        UART4_GATE      142
+#define        UART5_MUX       143
+#define        UART5_DIV       144
+#define        UART5_GATE      145
+#define        UART6_MUX       146
+#define        UART6_DIV       147
+#define        UART6_GATE      148
+#define        UART7_MUX       149
+#define        UART7_DIV       150
+#define        UART7_GATE      151
+#define        UART8_MUX       152
+#define        UART8_DIV       153
+#define        UART8_GATE      154
+#define        UART9_MUX       155
+#define        UART9_DIV       156
+#define        UART9_GATE      157
+#define        UART10_MUX      158
+#define        UART10_DIV      159
+#define        UART10_GATE     160
+#define        UART11_MUX      161
+#define        UART11_DIV      162
+#define        UART11_GATE     163
+#define        UART12_MUX      164
+#define        UART12_DIV      165
+#define        UART12_GATE     166
+#define        UART13_MUX      167
+#define        UART13_DIV      168
+#define        UART13_GATE     169
+#define        UART14_MUX      170
+#define        UART14_DIV      171
+#define        UART14_GATE     172
+#define        UART15_MUX      173
+#define        UART15_DIV      174
+#define        UART15_GATE     175
+#define        UART16_MUX      176
+#define        UART16_DIV      177
+#define        UART16_GATE     178
+#define        RTC_GATE        179
+#define        DDR_GATE        180
+#define        KPI_MUX         181
+#define        KPI_DIV         182
+#define        KPI_GATE        183
+#define        I2C0_GATE       184
+#define        I2C1_GATE       185
+#define        I2C2_GATE       186
+#define        I2C3_GATE       187
+#define        I2C4_GATE       188
+#define        I2C5_GATE       189
+#define        QSPI0_MUX       190
+#define        QSPI0_GATE      191
+#define        QSPI1_MUX       192
+#define        QSPI1_GATE      193
+#define        SMC0_MUX        194
+#define        SMC0_DIV        195
+#define        SMC0_GATE       196
+#define        SMC1_MUX        197
+#define        SMC1_DIV        198
+#define        SMC1_GATE       199
+#define        WDT0_MUX        200
+#define        WDT0_GATE       201
+#define        WDT1_MUX        202
+#define        WDT1_GATE       203
+#define        WDT2_MUX        204
+#define        WDT2_GATE       205
+#define        WWDT0_MUX       206
+#define        WWDT1_MUX       207
+#define        WWDT2_MUX       208
+#define        EPWM0_GATE      209
+#define        EPWM1_GATE      210
+#define        EPWM2_GATE      211
+#define        I2S0_MUX        212
+#define        I2S0_GATE       213
+#define        I2S1_MUX        214
+#define        I2S1_GATE       215
+#define        SSMCC_GATE      216
+#define        SSPCC_GATE      217
+#define        SPI0_MUX        218
+#define        SPI0_GATE       219
+#define        SPI1_MUX        220
+#define        SPI1_GATE       221
+#define        SPI2_MUX        222
+#define        SPI2_GATE       223
+#define        SPI3_MUX        224
+#define        SPI3_GATE       225
+#define        ECAP0_GATE      226
+#define        ECAP1_GATE      227
+#define        ECAP2_GATE      228
+#define        QEI0_GATE       229
+#define        QEI1_GATE       230
+#define        QEI2_GATE       231
+#define        ADC_DIV         232
+#define        ADC_GATE        233
+#define        EADC_DIV        234
+#define        EADC_GATE       235
+#define        CLK_MAX         236
+
+#define        MA35D1_CLK_MAX_IDX      236
+
+#endif /* __DT_BINDINGS_MA35D1_CLK_H */
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
