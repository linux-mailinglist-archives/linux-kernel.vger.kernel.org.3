Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DFC535AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiE0H4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348173AbiE0H4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:56:15 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD79103D;
        Fri, 27 May 2022 00:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaAeraRvzG2j81Uemj7mYVa4WyO+seuYv0xIFO5Liegx43ImaoArDALFsD8Vks7svApI+I7yl3xEHmiZCMHJ+N5eRlyUG6SOC2suNjCO3yiPx/PovPjqvHD03goPxeSlz0INO9Hi2tTWn9JUC+cNWTc+tKFJST7cgj7iksp802hv8XZT+sw4cVXBXo+Cq1iCxFtF5hWS4p7LJBiF5ypMvg/UXl6vrMFVHy4TtvNFyuXmU4jk/iIorg1ojYGiRykmrPHO5JdQF76rxxNvKCY+9iFvwbofwOXA1hdwNm6yqMd5JP76bh4+uknSsXyUpaWlze2Nogbk4A+jRobdPcaiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1oyS7Ku2eSEJO9OijTuoY1Rm2r5eE04oGvzV4/cGY0=;
 b=MaI0Lh45c/aKdvXT21wAiAdhRm1jRHpyY1NO3A7iecGoyry/ijvwhA1d1gipyu8edkHa8vR00/U133rcGLRlkTOtXBZ3kqDqilbo19n5gZVTKnyAcCVmwnS9Eo+1jC0/D3kVU1Ywhs6is0sjjAAvF2Ih2zuJf03uK1y6JI0UbHwH+RsO/cpOOGyIS27pV3w1sQuBHsuz82SK4oXXs2DifsbT24VoHgw9vPMxWsqpF9VT+JJebSDK92AkRD56WJSG+/lU63SFz0RpoSpt89SAEaeoBDhKyHUsPrz8gD+/D0uYYJ+HBurhfzt8LE/go21+4LpPgwJIto4aVUuCSoqkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1oyS7Ku2eSEJO9OijTuoY1Rm2r5eE04oGvzV4/cGY0=;
 b=VSd56sdcIdwvRCsoHTqSd+YU63CKdHput2qtH/vjRFA5YS/1R/rp3Iw4UkjUFpu2iYDeNTyKhjh+8/DY45q0/1C46FAoMshGvDeqRu7KfN9FSkIQ8qDEo47BbujathTrtGRpq4JlaqqgKNusfWs3dhkZOrtMzSUYw8og1z9i1Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4590.eurprd04.prod.outlook.com (2603:10a6:803:6d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 07:56:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 07:56:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Correct some definition according specification
Date:   Fri, 27 May 2022 15:54:33 +0800
Message-Id: <20220527075437.16882-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 504c8dd5-3e6f-4403-e89a-08da3fb65b9e
X-MS-TrafficTypeDiagnostic: VI1PR04MB4590:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4590701FC5DD0BC548986443E7D89@VI1PR04MB4590.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkdTgxMDDRGGVNaUuyDkVhlDgKkwRCuk0EMJrBH/BR0Rrxww34UlbwYeA2Xg05FDC+J+CD+XOICsH2w5o/7/3N+rZ7+mqRzVjC8/nWTqLF0REZTp5Af0HcYozbM8IKtY+DuqD1Wd4Lm3BPcUNIFABCUE8Ey6qTZTZ9eA/erBEpFLCfykXUCm40uvTLizQ7k1ImEXTACrArlZobWDnKhMSpAl4a710/3+bqVgCjPIxykAfOOij8+qhvwGAjpYFpdwZVl9kBODq9ZKdzmgB037sv4TygVRPX4bxF+AuYZtBj70zbz5FERZWS8qzm51gKVsEiWnERz7w++cTP0wfo3LzfpI8ano+AVOjxF01oeo/Cqwv0f1+UuAsMIuySk1x6YgzVB0fjC1BFGrY3xwi82SL8guyKqobnjgCtazgwGfzIQHZZb9WHOnr4KBafIht+xCPfRK4LWnHj+BewRsz9BNw9fReUgFm++flpiT1Yw59kf4QjR1lVnUuXnV2XZbpOEb8GcoXIVQSz3vognOyrPgCzF7BnHFWZJ87RUg48Wpo9FTEFfegGbdoKC1BQxkBwOKeOoHZMUXyvuzfHommuHtGZe0ceZa+dw74tzCs0bHBMRI6lVpLt9MLPqMy62SHwTwCOkAZUjxpF8SrqNRgVjpjXtwsKyW+PZcavniILhQE4S6mMJ9wnRzCLaSKHusyelUYbEvykoLmSMgkRLelDgF5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(4326008)(8676002)(38350700002)(66476007)(66556008)(2906002)(38100700002)(316002)(36756003)(6666004)(52116002)(6506007)(83380400001)(44832011)(2616005)(6512007)(186003)(1076003)(26005)(508600001)(6486002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RG10AhKUKk5PLAKWhOvNuhM85A1/iIc7G07wVh2OBzEP2lQYJiGQGbhtz+oR?=
 =?us-ascii?Q?wJctvGB6srqCbT3dg0ASfT5VEtP8KAKkvumlREp5QzwO7O0gRo6Q9JGlnkTl?=
 =?us-ascii?Q?x2WEJSFFZ7ssHGh0/LM/HihfPKz4sm1sS01QpJxr4VA0YotREDBPLNlWZ6VF?=
 =?us-ascii?Q?WKP0xmlQObSgsvWlOmMxGCkrlvgzGlRkezInY5lqwFnE9A0odWbywM/p/zPS?=
 =?us-ascii?Q?l3f1pVTqt0Luf76yDuLPCVz2MQUpiQfI0W/t6TLGYH+i+//0pn11dMpUlrSB?=
 =?us-ascii?Q?4tqjO3fgtNXW/P/Wc+BOEGdtXH37D5sa0pr/DN9dAxQzgfTpfaHS9r6KASZK?=
 =?us-ascii?Q?N6yNVVnj/6AvsaftuMsQeRW/tWlPTArPJMc9Md0pXWG/iQcKuMcxIJGmFXGh?=
 =?us-ascii?Q?uL0tKdy1huSadiCVycUSX0mJnl1AFMWKTmggrDK165X9Rv5JttsmJ5ftJ6Ni?=
 =?us-ascii?Q?hbiakOxUtqcV8CDYCi23z2rGFR/I0PaKNflGefhPmSLuKSNzhC7xnzzLTWfk?=
 =?us-ascii?Q?ovNHvyReDCn8tb7g5orW7WOfqvduJsKZNo6JodRBkZwZGnE7p4pmR+IS4PI2?=
 =?us-ascii?Q?M516eCMlfThtLCorHhafZv3r7F0plwXuNv5iCSRxiDnK2QM5pkxsefnchZxV?=
 =?us-ascii?Q?tVs5zaDTTUeNUwR8g4c8VfQz/jzk0bpLusa6fWUqW8gNxafYCTG1nZtozQmp?=
 =?us-ascii?Q?+/d/0X6Pxvqf1hEE/dfPVvfm7tcpHjh9B0zCzhCJ3+vIbiiEWLEF12Fc6ZQ8?=
 =?us-ascii?Q?n2ahPIq1Irm8+Solg1AnSXOMrWnSZal2arUwvxSc/mAoU1f1uIZUFclQ1yJb?=
 =?us-ascii?Q?0nYU2HAykcq8yjjSW/2qbuf4x2582UxtQnbY3f8O71fWizdvYK78ysS+xIOQ?=
 =?us-ascii?Q?RxvFDQ6Lw18Ft1ScPwnx7gC5ZFrPgRAzU71Smjz2E0j/opDn0Z4+cwEydZwC?=
 =?us-ascii?Q?2nWWqzT3CjzYUPv03GjXehBBRMn68kuSQGA7CFTBTlDyKIoskmKvbYJsXSjT?=
 =?us-ascii?Q?ScE9o81dE+Lj2Qe5+bUJFVfHS3TIgR6LxAFCUhl6V+g4DAF1QFmaN9FcCFHL?=
 =?us-ascii?Q?4kvINac9YVC9hHCxsDRHWy8hx1pnORxlErlvps8W2i0OEdTxcBDBzfG1WORT?=
 =?us-ascii?Q?nkCR8NwDBcu4C4PHChIUNxUO887TX//0Kg7Yc2Jir54x/1DgaoSmFZ7mu5ql?=
 =?us-ascii?Q?58bLKLSEAeGOksyLhYoZEq2cJqJptujmOINgnA1GcVCeQYVSygX1pULAQWcA?=
 =?us-ascii?Q?zgJF8nT5BTa4Naa9wLrsSae6pxh5bgAUDKEskA5lFLPc0ldkp9GxjYBLUShx?=
 =?us-ascii?Q?ZMzjjPzJAXLl8WTQHH35knsKGH6K4ynpXM3mKvLrkc3RE0iwZhQ5C+Z8gfNu?=
 =?us-ascii?Q?JaDQimf3MDHZ6/I2rnGBNe64Ydntdm56vsuegmM5chVkx+74j7VHcZarVjzx?=
 =?us-ascii?Q?X1dlSJstERmR1WjFUUHIUxs9hubGKE223VgSPZzDV7ZayIEMgHuTKHpJ6W1T?=
 =?us-ascii?Q?UH0viYSzsK6S5au6mAq32i3OPPLZ+BrMQaDcODMfArIdwWDMlshylUtdjJP0?=
 =?us-ascii?Q?8ObyoEPs8+473mJqZE9sCyhRGyJy1kxmZWBN4Q1guFavieWwZOjtTWiCHQtS?=
 =?us-ascii?Q?hyIHrzqeoQ0KHEDR1/duCT/LVEzqf38sVB3qZ40HnSDMFV3OmQwtwtH8UolS?=
 =?us-ascii?Q?9UGnpjehFWsLIXJrFgp/TERBDPjNiTEY8wZmsMRvWcfLXgboFOxTMlIoODbr?=
 =?us-ascii?Q?XO4j99mrhg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504c8dd5-3e6f-4403-e89a-08da3fb65b9e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 07:56:08.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHfaQuOODDzr0PwpdEbN62vL2dgLqaKyAsd8/vvti5P+9Wu2QBGD8p1W1KPx0t+27dYEoo+FFuhsRAYNDd05Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the register CAST_NOMFRSIZE_LO should be equal to CAST_STATUS16
the register CAST_NOMFRSIZE_HI should be equal to CAST_STATUS17
the register CAST_OFBSIZE_LO should be equal to CAST_STATUS18
the register CAST_OFBSIZE_HI should be equal to CAST_STATUS19

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index e7e8954754b1..07655502f4bd 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -53,10 +53,10 @@
 #define CAST_REC_REGS_SEL		CAST_STATUS4
 #define CAST_LUMTH			CAST_STATUS5
 #define CAST_CHRTH			CAST_STATUS6
-#define CAST_NOMFRSIZE_LO		CAST_STATUS7
-#define CAST_NOMFRSIZE_HI		CAST_STATUS8
-#define CAST_OFBSIZE_LO			CAST_STATUS9
-#define CAST_OFBSIZE_HI			CAST_STATUS10
+#define CAST_NOMFRSIZE_LO		CAST_STATUS16
+#define CAST_NOMFRSIZE_HI		CAST_STATUS17
+#define CAST_OFBSIZE_LO			CAST_STATUS18
+#define CAST_OFBSIZE_HI			CAST_STATUS19
 
 #define MXC_MAX_SLOTS	1 /* TODO use all 4 slots*/
 /* JPEG-Decoder Wrapper Slot Registers 0..3 */
-- 
2.36.1

