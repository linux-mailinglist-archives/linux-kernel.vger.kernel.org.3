Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB45482D06
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiABWiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:38:20 -0500
Received: from mail-eopbgr60102.outbound.protection.outlook.com ([40.107.6.102]:38910
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230405AbiABWiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:38:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJbDzUq+xcF8wGf7eriuVXLMGShK2b6OaEkHTusgYIXvpMdhSu+YxuHxRFHMInCIZBYuF0x+3gbf911/Iyc8HdkuA992DUPb+X2gPYEj/2P4uGwZKpUv2a0htEhrUKLpURfsyE6Mvxqm+2oz5c90Tt/CU6Bn5fGj5TQAft2pnRmZ/OItR797jey3QgP3T7z8C3EZmQujRWahk1FpQkSjmKicbu0Za557Qr50p0oGTj//qUW9DDRaky9tm8Hi3hSa0x6c28YCIl4rUejcz75yxQP517ovaVfqbfNSCoy4Jvm5sATw/mY7EWJFZizBoTUppKrXODz95zUt5lTA49XpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uMAxwT0txh7w8O0YWF7+73NkfsdNNqfV2KSQQd0x+s=;
 b=gnO/1AaPId94K2HOV6Gz+PHB0WFwpYlNtZtf6xtm3IZDI+uRwB/onPpz3skPszV4us+P8EQt3TEuFxlsBmyc71IXIEMj3eSN31wSAn2I+jTS6/CaQYf9laHvFfaix6ur4vEVbeoLk8sC2/uAmE2Ptj8WqWxFli6jQmGruAl6HAH3xtNDAxbjFC6etCjIce2cNfRYSa30Huj48KWP+b0I/uu8IbtHO2zx+weYQVJ7ZHJBaYnEFc2Sv0YFpFVk6zHkmAV2CHsMPN6wKjBVUfd7mfoew0rUGDyo2wN40bESPg8MYtzMeL0AqjtJ1jEgwrUcCLsE0Xu13c4xWaiQ809PLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uMAxwT0txh7w8O0YWF7+73NkfsdNNqfV2KSQQd0x+s=;
 b=bQzuNkXLzb1jgHQNVkCVG1EsJ98byO/27uW4qzI1zMndTWR99Jk5EdOyFX9tqTLyVLFSUnk5EOm+OFAoN8FpXbvOMy/4sYyC6jPub44AoJUizTX3r4Z0L6KjuPb+CCTb/uC1u/0CoVycJRv3q9q+JqNMHirTFNDIouNLOdA+Tvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2920.eurprd02.prod.outlook.com (2603:10a6:4:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Sun, 2 Jan
 2022 22:38:15 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4844.016; Sun, 2 Jan 2022
 22:38:14 +0000
Message-ID: <0571fd6b-ec4d-71b3-5cf7-6fa48ed5592c@axentia.se>
Date:   Sun, 2 Jan 2022 23:38:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
In-Reply-To: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/6] dt-bindings: ti-serdes-mux: Add defines for J721S2 SoC
Organization: Axentia Technologies AB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::28) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abf2ae17-8877-4fd3-7472-08d9ce409022
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2920:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB292073D0A9139549A83D739FBC489@DB6PR0202MB2920.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdQHPclJnQLj+6aVsNhlIPRohxbmVEMx1mLLFpgJAgo0DFNo5iefL1+yOXB5oGJSvH7y4u/U5E/nLNS+vzQR1HYnO5QZeVZUJFnfbM2mfb/MCslI+AOsvlYn8LL8ZoJ6SEMWjNr9InJc5UfynFEXgPDFIjsiZ8RE1TWjAOovdv7Qnv0lDRQwbjRbbAY6+vk48vVCHNlZIGx5dz7hUmQu5cS/Vv2+XSZcY9Juf9blMprD5lAmMfLYKtTgQwWCkMdVXuaAs80rKAeIByNYJNCrSQfFTKxu+AUEj9oa7HIB4SxlAZKjka2ivLq2lWU8nhxRo1Z4mpH75Jx0x0GCcc69w8mnhEquxmNd6YNqw6A3CjKeePxCFffBj4VKrLjaQXg9wHxpPp4bggK/doErKLLgChVLSjMpR8I2fJ4UBrflxIX5JeMPcyFO6oUHhW14ro3mhi7nHOXwtSU8DxHAP26GE7pRigi8mArVVMfX8SZ8boo76+ZpPHBPg/XxgUjAxL34Z8bH3QuuJdrjq/GMwgqXKlEudUyFNLvbfbGPsQyXECpULNEk3ZurGJJpyQPb0FvIq8gYVr4GYGMBfAjk3D7yZQ+4RCkJhDsmRasXDRJmKqfuQ0uHc+IPoBkdOYlE2Y5VgM+G8+1dzsUryxVEEv5bQmzPzhho+Hq3a7Ozp/NjvmeHfGU7xxE2zmSR/uXogJ0Ux99xHrnXqlPTlTFUgQutoIn1+ViRu7bUvwEHTEhlsjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(136003)(376002)(396003)(38100700002)(508600001)(4326008)(36916002)(31696002)(54906003)(2906002)(2616005)(66946007)(316002)(5660300002)(8676002)(66476007)(66556008)(6916009)(86362001)(36756003)(6506007)(26005)(6486002)(8936002)(31686004)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZKTzBMbzNCc0RlZ2lqazl3cFpYMWk0MWtqTGMyVnEwc1dxekpSdDJvYThX?=
 =?utf-8?B?TjJUaWRmQmZ1bXlKVWZWWHFuWExMMTRkdndNaUt4NWY5ek9xS2MxMGljRUNa?=
 =?utf-8?B?THlwWGNqVFVLd2FTZEw4a0hEUnpxVnVneFVhOWZOaUdySHZ3T2xVZlNCTzdI?=
 =?utf-8?B?NzN3QVVrQldPRDIzNGdjMVQybVMxR2d5NE9SNFdyZTFEM1JLVVVqTW4xWDFp?=
 =?utf-8?B?dGw2YWFqa0VneUVjYy9kK1dNNWViQ0JBWkxxbmR4ZE03TXIyVTFRTlNBRWI1?=
 =?utf-8?B?WnM2U25VdTNyM0lCMGlNL3lxdEJTOCtpU3ZlYktIQkUwNVcwekJZZnhTRDMy?=
 =?utf-8?B?dURQUjNuQ0FEcklwZ1RHY3YvdEdmbFpLbHRKWnMxbHJLNkZ4TnNVV3dXQkRp?=
 =?utf-8?B?UFExSm80WDdBOWNvM1hERHN6Zk5ENEFjQ1U5Tnk4elArVzE2bXl5elZtUmtX?=
 =?utf-8?B?SDZGcEpYS2puZGVjZ2thZ1F6bXF4cXh5Ylp5VlpyVG5CTVZxN1RCVnVWTHAx?=
 =?utf-8?B?NTlqbExsNm1kQ0ZFb3BlR1lWMWMrUmFLdWpnbnUwdUZGTEEzeHNWRWFkRmFB?=
 =?utf-8?B?ZEdkM2d5dGRsdmZRd2NPNkhKYWV5ZENzUjZ0ZkdiTUoyQVNTaUVad1lFNHlN?=
 =?utf-8?B?RkNOT1JpTVJOcXdlMlFZa1o1OWY0T3BtSUNHcTdRQWZZS3ZpczBWNUlEcDZj?=
 =?utf-8?B?SVhOWG9ZM2JYNk1TcW5uRk5xZCtiYlZPMEJ6UU5jOGlVcEl1ejlFZ1JUQXJn?=
 =?utf-8?B?emxpWnlLWDhXTWlMK21KbExsdDlzMEs2Y2Q2VWhJbHpIbHhxUzlFRjBoZUtN?=
 =?utf-8?B?UTh5M01udGR2bG05RzNwZ20zbkRHcjZzT3VzbXdicnFCcHhqcG00MzJGTWxI?=
 =?utf-8?B?YWdxVGNrWm1TTFByVkU4TXM1cVhaYVhNaEYxdmFVY2xtb08yMXEzR3ZaSDJ5?=
 =?utf-8?B?Qm5hVVZjdVh1RmRBUmhUTzdhTjFxb1JoTDFNbUJWVUlJL0ZhY1kwSDU4Mjlo?=
 =?utf-8?B?ZjdZVFhyVWp0UnAzVnpWcTR0QTduYjBZdzdzVnBjRXV0Um4zbkRKR3praThl?=
 =?utf-8?B?MUJkSFBHRE1LRzVXWlExVnhTQzczc0U0SHN2Rm9EV2paMVZ5TDhiL0xTSWdW?=
 =?utf-8?B?N3JCQUR1d3BiTXFxdUxpMjRCUDk5azQ4WXZqOWVWbVRuaXl1dHNKUVBQUEZL?=
 =?utf-8?B?K29zeUZPQWlSNU83VTZYN3ZKcjdHMHVGbzhQZWpxcnJ1c0puZVBIVFl0S1pO?=
 =?utf-8?B?R05TTEg1ZTFVNkRKSmw1VjlEUldTc1hxN1NLN3lFbmFJY3ZHNkRGaURoRG5n?=
 =?utf-8?B?aGVRR2lnV0FUdXhkOXFJN1VZRE04RkxnMmhVTFE5ZzdlUzFaVjRiVzdQVWZR?=
 =?utf-8?B?Mk9nR24rUnVFUzVMdHZqaEZ0M2liUng2OGdjeVF1a0NwUU9aUTZxSm1LOCtz?=
 =?utf-8?B?NWd1RHF5aVMzSFE2VjIra3QrekpRU1lsRUVYZXp4c3IzZmRXZEhwUGp4czF4?=
 =?utf-8?B?ZG9nempLcFBNbWR0VVJLZjFtdlB4b1NLNGhDdWQ2eTJDVjVMbmZVcCtuRGJu?=
 =?utf-8?B?cG9pQktVaDM5c0RiMFVVQ2NzbGFQVDhGYjc2eVpMbXE5MDJ2MWRKV0pCMEY4?=
 =?utf-8?B?VTBYNGlqQ0hEcUtEL1RIUHlTNC9TbHp5MmQyT1lGQ0dYSm0yNFBxd2VNTlJM?=
 =?utf-8?B?a0VOS3BFRkFBNm1tUGNkWCsySE1STW9CRWx1OC9UdWw4R2tFdXBINi84UURw?=
 =?utf-8?B?dEtjM0lBbnExZ1dJaGFaVzFGdmk5SFFESTNCYzNNbTJBRWVobEhTd1pTL3hY?=
 =?utf-8?B?MWxUTGxYQ0VBcTlmVHBvdHc1SWR1S1F0aW9NVS9yVm9ZeFA4RjVqb0ZZTklW?=
 =?utf-8?B?VlZqZldkM05iSDU5UXY5N1lrNkhWemRxYkRXYVFDUTdzaUxJemFnQ0VNRHhU?=
 =?utf-8?B?Njh0VGIxdTM1L2JzUHJHYmhrWlhuTUR3NURtaG9qUEMvSUNvS2lnNEFzOTlx?=
 =?utf-8?B?WW9qSmgvaWtPNTFYVmNPQlRCU3U1djl6clVTakxuSUdNMi85bjRuVXRHVGVm?=
 =?utf-8?B?N1JLZDlEd240QWJ0Ukdua2Z4aktiSUZuaGJJaXBuejBVRSsxQnJXS0tGVUdT?=
 =?utf-8?Q?HGwA=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: abf2ae17-8877-4fd3-7472-08d9ce409022
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2022 22:38:14.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H34DwF+vwGrA1ZoBbcro4AmeWmIUfLogULoU5HMy1vohtzV9tAbjuADCgSZMBix8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

There are 4 lanes in the single instance of J721S2 SERDES. Each SERDES
lane mux can select upto 4 different IPs. Define all the possible
functions.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 include/dt-bindings/mux/ti-serdes.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
index d417b9268b16..d3116c52ab72 100644
--- a/include/dt-bindings/mux/ti-serdes.h
+++ b/include/dt-bindings/mux/ti-serdes.h
@@ -95,4 +95,26 @@
 #define AM64_SERDES0_LANE0_PCIE0		0x0
 #define AM64_SERDES0_LANE0_USB			0x1
 
+/* J721S2 */
+
+#define J721S2_SERDES0_LANE0_EDP_LANE0		0x0
+#define J721S2_SERDES0_LANE0_PCIE1_LANE0	0x1
+#define J721S2_SERDES0_LANE0_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE0_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE1_EDP_LANE1		0x0
+#define J721S2_SERDES0_LANE1_PCIE1_LANE1	0x1
+#define J721S2_SERDES0_LANE1_USB		0x2
+#define J721S2_SERDES0_LANE1_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE2_EDP_LANE2		0x0
+#define J721S2_SERDES0_LANE2_PCIE1_LANE2	0x1
+#define J721S2_SERDES0_LANE2_IP3_UNUSED		0x2
+#define J721S2_SERDES0_LANE2_IP4_UNUSED		0x3
+
+#define J721S2_SERDES0_LANE3_EDP_LANE3		0x0
+#define J721S2_SERDES0_LANE3_PCIE1_LANE3	0x1
+#define J721S2_SERDES0_LANE3_USB		0x2
+#define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
+
 #endif /* _DT_BINDINGS_MUX_TI_SERDES */
-- 
2.20.1


