Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9546E49EC32
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343810AbiA0UHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:07:02 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:8839
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229896AbiA0UG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:06:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLcTp1T34HmDWx9XhFCI4i+H2GHIbfHAeYwOrIFrj+4KgQyg7uAnPyvzt8RCGWd/qpLXLw4612yTtTzlfEsDIOJpDCpQ9jTxWn5dzTDOsac95KfWPeHy4uSIA2u2yA2ctgzD+ApFc7axHFByehF2F3NPaMfu16eBpZKf+v5gVro75bsu08DGjljyNcw4FrxFVNnKgo5XiJws+2TUzBrcT/yri2nu/VqtuPEWmFjA3PiEP8j5wdEKpBss44UjtmYrTlIlOeqc7qedWpShZUxW2/zPIdD54d16+j0F9SSX74HL7GaHHppxnluXL4vTl2iaIWWGgTm5/2CGYJWOKs99DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQqbC9Cm9iNn+dOVl89ZLb/i1B9Eg7sRjcVDhjYIsQ0=;
 b=Rogd4cNbvUQZsTne0m0QFvkKVzlP7H49YQImKl3yROt9SP84o+tWophgEFFhKp4cxSFupECErFl+6EC/Z7pEIl6hxZl7p30DAHMMq0L7KxMT1WwGFzJ0GEy14Lqgl2UMoKHwxdGvwQgJe58klXzL2/ROs6pOlUvg96P22/bp5YDkU6/dUpdqyOtIhVQAvxfA9J80jkcKvLvinVRIeEN1aTY25GyUwxCXXz9oKd1PQhAdPkdxkU5zZE0d7ieVrGH11a3XnLm5m10V9GAG0vHAQ5j49f6RUSbDJBdKeQSnDANrn2pIU5TLoawDxwBVDp5+CjHVBX69ctmsSSB2kz48vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQqbC9Cm9iNn+dOVl89ZLb/i1B9Eg7sRjcVDhjYIsQ0=;
 b=1m/djmEA7RLx0OBiuHcdKqIgj+RbHOUczpGYdgqzDvtnIlmYrHJalG/JJ94nwzbXjrW1fA7ntI0Cz75GIssLr4P2DUV2jnDo9+g/tpXhSXfpvaptvJDeUjfYwz/jVqFqtPcIWldQWun68ideWJR+a6/fPFEn1EKwAiiOOAaL/GKRM/0tFbvRKuaJsgY8TRppJWeG1jUgnsyFWw0U1XqUjTRI0Ft5wkiLxS6kOBgGx+DWM0QO2RxkQPgabvAPdZgIMmN6o+lDzx8B1jF32A9b1rTukkPj3wDzPt1AwGpUmDbrb4rQacp/V4blSebp8U5qhBojjoC6X6bhr0lX0LvgLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB3747.eurprd03.prod.outlook.com (2603:10a6:208:4f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 27 Jan
 2022 20:06:54 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 20:06:54 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 4/7] usb: dwc3: Program GFLADJ
Date:   Thu, 27 Jan 2022 15:06:33 -0500
Message-Id: <20220127200636.1456175-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127200636.1456175-1-sean.anderson@seco.com>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:208:a8::43) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e08ba2-25db-4880-4a9e-08d9e1d09056
X-MS-TrafficTypeDiagnostic: AM0PR03MB3747:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB37479060432A3D7FDF0F625296219@AM0PR03MB3747.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OJny+sQQrAlU2HGqPYaiJo34PYd5r22m4Nu5CUVcZv8ppPba1zGwECcllJZ2Bi9GvTdR58j2QSVTKhmBUkD7WbYdUnFUF7QKQ4r+GqCoJGBlTjqIb4S6DzK0w4NTrEKBJ2+1wVlzuXsDW9BbhotSJwmsPEyHMvtGbae8QTqbiezhTTBLSfiM19Ut25O7cdFE5OeA82jlDGnQy32r+s1rodiVG+22zHMpzJ6WtX4XuQ3E3HyB7JCt1+CHvH5AQTew5qL5fKN8uJ8GBzR2dRUqDqy1cPaze0pah3oWW6m0t8bY+NvOSL51uHKIrwlN+DwZ1MtnDMRdb7lERgTGMqTLxftdADe7rmOkeu8RwtORV8B5lwvotV++de67ntpywfP2SHcTl6580aCzRucIfWhXATnIDsUoP/GJUGLUZ1Lq+5bkoQWEhxfDTQ9St6Ur2Hkxp4rY5uZRj5mVYApGgsojl0SpNyh9Bf3Yxh0CXvf5//VSWDfkYvAmWAPcV/oTd3WzocvquXhAubnZAxDKQRz6j1MKrYScuerj+/mixsNu7GB9W1vCzPruI7NaSXhnyFFsS3tFn7UQVNrELGzk/j61OxTWsAhgXgrG30E1fD1UbkGooLpCOqba3ICbeIlOVtlu9A/9otkkGVIdmXjYQ+JRc0q08qFHA3ahvjU0/470ag5i6Jhrl1EaNyA7ethrGanuig6bQ/mc3W5NY81m7PyRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(36756003)(52116002)(6666004)(6512007)(6506007)(107886003)(2616005)(186003)(26005)(1076003)(5660300002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(2906002)(44832011)(54906003)(86362001)(6486002)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QaXskUVVkM8zhDQSynMiKyeiEHG5OUo7L8Duo6N49BBk+05vHW6nXCSB/m8i?=
 =?us-ascii?Q?S/Dfy+WoCt7kJdVIw4XYgWlnXPgA3ODvkWe9bGTp54Jrb+y+Ul6R82XejIsQ?=
 =?us-ascii?Q?LbQNKc55WmcHw8CfqoW4WIFTUqvBF+IHm49TDhduGSBtZKs/Uij0EelXzIVw?=
 =?us-ascii?Q?jXWYhy8toAIBd7fbC5neQcASf8oatP11XEGqe6WL/tmcoB1VVuc97HT3p7h6?=
 =?us-ascii?Q?4do33XFAoqWqhRp5kYK4v5Sb7feiOCBm+Yo/Ifja+ZjyI5r7rkKgJhfgxf32?=
 =?us-ascii?Q?DbmmLTjwfCqxKsvaR9WG6khcZkXwXYsLAUFOfViaTCPIvaW/T8TMiwENGud1?=
 =?us-ascii?Q?D8xpnOMP+EDp8Req30iMflZ/JKEE6hYjLGuZVCmlpLSBk+1jemMXj0spv/X2?=
 =?us-ascii?Q?RYfX3E+NR6Wy3SOh2Om2v2O7JBzI8EZO9BlGBpE8+jiLVUJ1AkRRmCuLVB+l?=
 =?us-ascii?Q?omDUWIgrVRq4uc413xuqwi6RRx+ygXrRprVLd/Cw4EZ65boP+9+pkdqIuRLA?=
 =?us-ascii?Q?FY6B0x3QWq6UZAPZZcuQ32ZbVpGdCivZOIaA56GRyUZtTTor/7uuQ+oaps/W?=
 =?us-ascii?Q?0N3zq7U/ZxQydrTosBFSrEvGFRVgil1oskp779kxjfw0fbfmoKP8CPIiOJDZ?=
 =?us-ascii?Q?TlBIOkRKPnK/DxCNpC+0MEwl/HwKZ57pCRekY0YcE81m3alJaj21hwTUTHod?=
 =?us-ascii?Q?9YqUp9rnMrDGC0sNsGj/P/EEMgOIv8+DLbYp2qwDzuKvWH/xyWPoDWPhMu8l?=
 =?us-ascii?Q?G0LE4wZP5B4GgEHOGb7+dtx2wFTJUbAmIjxoaS0z66V69VGK5TdJ8n0s4MKX?=
 =?us-ascii?Q?7Yq1XoNsHm/5s2Xlfoz3G4OUPFIJq1/p4gBKU+k0hzow1Yvuq5OniqKapKXf?=
 =?us-ascii?Q?7hkRTMBc3e3QTXNid65+GZWqWUJXNyz6pYIIKh0VKfnluCqJRXdWYvuXdd/a?=
 =?us-ascii?Q?8o0PqFqA0xb9z3fUrVTGD0z7UL45l76JzBrU2uo0Eq5h9n7uwiFoIv/KHB6j?=
 =?us-ascii?Q?X2L+pw/VY8smMac4AwDccOrSj/02tmQiQXlfUQVNzOEm8+ChpeS594quVV8Z?=
 =?us-ascii?Q?iclwgDDdSFeMy/UMoOet1t7HdJnHVaWb2C2bK/ElUnXQvJKofMbOoXhBzwS9?=
 =?us-ascii?Q?QIrG3xK/1xOU+m+FTgZIqQpf/CnidkRTuZj+9+slv9IwgLdr2QQMHnWi6vd8?=
 =?us-ascii?Q?I5lIg6wZ8Q76oqCtkyM5n/2tCRyqnWChTLHM9AFST+P3UO9Sdr9nU81uPvlx?=
 =?us-ascii?Q?NNSXSob2HiBlkIgCRqKSt5p/2iVTq6fmHosG181nlVeILqfdQ9n32dwn06UW?=
 =?us-ascii?Q?7TvJlfyTETN89uRNMiV5aMcwccx7cmZO/2e9MHoGNdsGqs+ek9VBNd+GcTgv?=
 =?us-ascii?Q?BUFvpYdL8zTsR7ojzHylXW6vO5ffOKG667gJSRRTulkCmqCm0NW0NnaleX4b?=
 =?us-ascii?Q?AsJxr1/ztgdvzJ2P2OEXca2WVIu8Hml/js+15Ww1FQslOFqS0YA2nyuO5LQd?=
 =?us-ascii?Q?3RU2jsqEFX4BaygWkkJ/Zr1P2Z2SG1K/Tlz9U7LvSGARLYI9cx9L1ekT5EE8?=
 =?us-ascii?Q?aF85ACO8p8oaVoha3i/IebMvj+g/eRWRtsS5UQwse8xHS9fnQliZxfAF/Fyy?=
 =?us-ascii?Q?BCSrGRFjGoAHGPgVMzWhiKk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e08ba2-25db-4880-4a9e-08d9e1d09056
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:06:54.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wj02t78SSqocJiMClGUq17WRkWsv/S8T5E4yiYHgAlM3hggH/ZNVN/FpSAWk5wwNcnn7aNT/7QAtsRlgkNgAYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GUCTL.REFCLKPER can only account for clock frequencies with integer
periods. To address this, program REFCLK_FLADJ with the relative error
caused by period truncation. The formula given in the register reference
has been rearranged to allow calculation based on rate (instead of
period), and to allow for fixed-point arithmetic.

Additionally, calculate a value for 240MHZDECR. This configures a
simulated 240Mhz clock using a counter with one fractional bit (PLS1).

This register is programmed only for versions >= 2.50a, since this is
the check also used by commit db2be4e9e30c ("usb: dwc3: Add frame length
adjustment quirk").

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Robert Hancock <robert.hancock@calian.com>
Tested-by: Robert Hancock <robert.hancock@calian.com>
---

Changes in v3:
- Define each variable on its own line
- Update comment to notes some things mentioned during review

Changes in v2:
- Also program GFLADJ.240MHZDECR
- Don't program GFLADJ if the version is < 2.50a

 drivers/usb/dwc3/core.c | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h |  3 +++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 38fef5c74359..18adddfba3da 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -348,6 +348,8 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
 	unsigned long period;
+	unsigned long fladj;
+	unsigned long decr;
 	unsigned long rate;
 	u32 reg;
 
@@ -358,6 +360,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 		period = NSEC_PER_SEC / rate;
 	} else if (dwc->ref_clk_per) {
 		period = dwc->ref_clk_per;
+		rate = NSEC_PER_SEC / period;
 	} else {
 		return;
 	}
@@ -366,9 +369,43 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
 	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
 	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
+		return;
+
+	/*
+	 * The calculation below is
+	 *
+	 * 125000 * (NSEC_PER_SEC / (rate * period) - 1)
+	 *
+	 * but rearranged for fixed-point arithmetic. The division must be
+	 * 64-bit because 125000 * NSEC_PER_SEC doesn't fit in 32 bits (and
+	 * neither does rate * period).
+	 *
+	 * Note that rate * period ~= NSEC_PER_SECOND, minus the number of
+	 * nanoseconds of error caused by the truncation which happened during
+	 * the division when calculating rate or period (whichever one was
+	 * derived from the other). We first calculate the relative error, then
+	 * scale it to units of 8 ppm.
+	 */
+	fladj = div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period);
+	fladj -= 125000;
+
+	/*
+	 * The documented 240MHz constant is scaled by 2 to get PLS1 as well.
+	 */
+	decr = 480000000 / rate;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
+	reg &= ~DWC3_GFLADJ_REFCLK_FLADJ_MASK
+	    &  ~DWC3_GFLADJ_240MHZDECR
+	    &  ~DWC3_GFLADJ_240MHZDECR_PLS1;
+	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
+	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
+	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
+	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
 }
 
-
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 45cfa7d9f27a..eb9c1efced05 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -388,6 +388,9 @@
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
+#define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
+#define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
+#define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
 
 /* Global User Control Register*/
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
-- 
2.25.1

