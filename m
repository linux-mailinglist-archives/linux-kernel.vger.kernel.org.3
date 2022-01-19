Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6C4931D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350500AbiASAZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:25:13 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:23461
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350472AbiASAZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:25:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrGUc4yj9iAg+6LGDdaS66ZeB6Ccht0I3eoS6eYz8Vpo5we3dTOtYHLAf6lT+gP63E2O3tgeSZdznUNDYcSnlFvhlD6anQqUeJsc2htyWMsZOj6RCEXXD3o46OyyVSIcY4qEVGgHCIogjU6OW/Xa9pJrSFnzPKMJzjbOfArg2DveuNWDdbqzCGgwY3Kr5JOKKKQCKnFuwa/taBsk7UlHET8WlHxWzvyV0oDCH3uDiVv3whydywrn4ZdW8pnDsv1HKGxnlGnHhK5WPD0bc9P3CSeENz/jEFUT8XQPYuQHCRnPaF2B161U4rJWQi60qSG7dOeHVK/5U/C5UDSDojJNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gJ3tpUO4xPO7qmzqGirDI10WApIHJjpOAdy6x/QlVI=;
 b=KA2gAB+CB/MVVqxIz3+ClidtEZmPv0bobz3sS/bCqoo7JGFEOcpTfkMg+63YO0J4NnlzpxZwOSz88ipVNV3z4bqTw2ATvsElWlWFkqdce/ERMIKx3eGrz6qhxfj5eNjorBdKdWVxSDZgBLIrKMI1HsKawqaO5dcc3CTpBeH5guA5SktvmxOYSvR2Bb3CXZejSW+EYR67FpXe/VUvP9z1QfHmai5ibyjQrhIZiTOG/HB5hlH/iQncUovnPrRohXserHUoZ36RO5sQ9FV8ZW7FbsDLRqJ+YcpGCDGdSG889W/DFvrheFVrN5G21Zra9MtfXX7v0t/hsxJ7OrD/vtxtNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gJ3tpUO4xPO7qmzqGirDI10WApIHJjpOAdy6x/QlVI=;
 b=reTXIWNEXUZvXDcnpzemsfBWFSESpl77CvDvvH85/zvcs8x4LDYd6c8rlypJpPqd06aNASKPqi2p8FKe/m82JdsPL4vtXrZf5ibUtWqrrbUBb0XCJ8NLRojfcER0e1XtDYwlnDfbfXXT7tjOdf5i9SGS74jH84yYUqs4N8NJOCcjzUThXxZALIUQRUMtBxFjcup3hw1Jm8X2bfv105lbKfT0Foyym0mPN/xKdfHCIvaQ8T93xvv74x1hXDAb33QuVa+FM5ujnUotJ1i61fOAUAbUV1IJfVlKAyB6Yp/CBgcIyXE5TJiHGi0yE5ExGG1zUujZlEstHi2VzPX7hyIxUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB4373.eurprd03.prod.outlook.com (2603:10a6:20b:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 00:24:59 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 00:24:59 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz property for ACPI
Date:   Tue, 18 Jan 2022 19:24:35 -0500
Message-Id: <20220119002438.106079-6-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119002438.106079-1-sean.anderson@seco.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c5531ff-3ed2-4788-b262-08d9dae220c2
X-MS-TrafficTypeDiagnostic: AM6PR03MB4373:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB43730D3EE66C1E1DE896A0AF96599@AM6PR03MB4373.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Am1Lyj33n2oHMlpdqDaknHfi66HSdZImKGhU9+IngzDugSY3JNMNfjiU9NqjmVcLaezv42/oEIF4AKBYwoqFD/fAjeiYNCQolR6zbeYPwi4lJIC5DMoh9k8c+w8nbRNHJtfbsTWmJcf05R0aHgtuWTondEJxP9Dufcj8tgOhJXDKkv47DieQP2j/9MrsMl5TyzCqCmZc15zjHMSdOQGVWyTK4n1dVXvRUDtefgrUWnqzWHBNR7P5DF3XFkt75kL73Hzg70pMFjQCk9Ev4dDZYzWBvg1DKJf4osFJlyk4djvVb+ioWUHJI5Ccw3ZbbA2h+U0o1eBVNRC5O8M3hhoIOAiu7mCy157wZIX7G21inXbDp9hYwLeD8fR3IIOhE7Zhk+jvlEmiVvnG+a4fzJpvjja+uwt0rPlaNkJzTC4f4x6Hn9dpYzS4IIxe+u0koZ6EL93ONhDOlDS273vrZLmmsRgFsO+oaLPAAtLW59+BsUQ8WigQ8hrPR7YKipg75qcFOExIbUSmTUkVD3RtIaTLFY01TDmpZZks1fm+y8expDz4WF+gkDDNmRXBgvCsP6RoN5j5OgVxNUAVe8+3tl0pTTePGL35Cis1A72AFeKXe4iHL9d982NiTqi8LB+uPPqkqcrfVQbqy0Qxq5uYBzrl7riqDys4TO+XHK9dGnB5VXpFelW5ItCoJoWdxktq1NWI8uD2PNL1kOGUcrMsdV6lVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(316002)(6666004)(5660300002)(186003)(4326008)(6512007)(44832011)(6486002)(6506007)(38100700002)(2616005)(1076003)(66556008)(38350700002)(52116002)(54906003)(66946007)(8936002)(508600001)(2906002)(83380400001)(36756003)(26005)(8676002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1JJdG7maIBUXCbtZSBGlcJBggO3DqWm0JlxKxkHEyN0Wm5QC8Akt0gEF/fIX?=
 =?us-ascii?Q?XWEPIn086TREPWbCF4gRMLSDIFLno0TLonP/4cpXHDT4SA7itKEi9gmyejzD?=
 =?us-ascii?Q?8OgJwwoebiXaKROTO3fpEHSIDzexzDtQpyHFUKEOR0Rd4M0b2Ba4lIeJY0pE?=
 =?us-ascii?Q?9/Fi7bZ/3fsqwJPpkQoW1cqFY2yVrVbNvsBUhopmBDmeJH7RpKMT1aJeG/j0?=
 =?us-ascii?Q?Crs7ROfTv7k8Fi1nI3pp+U5r4Q0mjaambBM3l3fvv24kobRw5I1w5KYyfprr?=
 =?us-ascii?Q?ENA6+gMv6hQqaqIxxHAXnJcYW7V0ND3M8vURh9fVplHqGi4nRLVaAbHARRW9?=
 =?us-ascii?Q?nOUQsJ9qHalMMV7b5Nle1pmpilPL7F8l8v7+4Ul0JofnobDm63wS4xbMQLLi?=
 =?us-ascii?Q?dBoFue4nN9n1yesXuO9/FDjpFnKk3yfPD/TwDzrWF05RuKKAhpb1j2tCnO77?=
 =?us-ascii?Q?X4PuWB4XYNpNK3S50ODjfYcB3GU4i8KNuNIilDyRTypVFuXuRWsoGkGzwXZp?=
 =?us-ascii?Q?z41sJp3nw574dapdJPqB+hgXl8/A+fu0k73gRymoD4pdUE6EdCerFbchbdyQ?=
 =?us-ascii?Q?cemAgrGZbu2zPxe6B9pTBEnb5yIQu/n64NQe87JuR/2aexVulrV4YBbV6xfs?=
 =?us-ascii?Q?sm4WegFBC025Ok9h3IBvvzrb+EjqqjZCDqfXEJYmgOddTvlR17EX47dadyDU?=
 =?us-ascii?Q?F3kxWvOiXi3kQmIQonxIvmKctyrgCbeOwhgxIHYnhAuW+aW3Ed7tiisa2kZq?=
 =?us-ascii?Q?Xsz6rDHyLumJrgSt0/upAln37RhsZCW534aSHgU+81kFkw1b1gE8mOi17P4T?=
 =?us-ascii?Q?68Cy0D6oriepBc1CEnXkOP7/9g7ZBbjOFyMX5IDwBdKCxGHrPHcms4GZKBup?=
 =?us-ascii?Q?h9GfHQIeBGgdQ1QU02SBeLT9zB3G0qXtBx5vQ430tS1JW46egjU3wDLCGZyT?=
 =?us-ascii?Q?72wQ/iQrp0d2yIepQJvae+gVqwUl6UyOgHvL0vz6HIb1UFlSkmM7CfUU3wPQ?=
 =?us-ascii?Q?eNeSpsxUjcXR/V26NR/hKe0EGR3qf5ZO996xMge10xIVFC74IiYCc3Hc8FI/?=
 =?us-ascii?Q?UxtCOo1j8++ZTQ94LY30Y4J8QtcEtM7LgKthDT1KUkhP2WMRqqS+AOe1U2T1?=
 =?us-ascii?Q?fWdEJSPUZqSlgLw+M0IxvcWrMDK5U+mOpUUEZuN8JpyF4IrGvbOi2Hu2C3Ll?=
 =?us-ascii?Q?FnBfIiQGwiBCpT086aF/1G9N+FvPqL21bFwmR7oVAXgH1VC8vEmApi7D3H5w?=
 =?us-ascii?Q?QnGVzE45rieCG0IYKAZOKjIzGDClWUCxoIJdxe2QGGHLL2feDGAW9MdQGzb5?=
 =?us-ascii?Q?QmTeK7wCirjL/RksFWYSnVnkoasKsIQrdFCRtLJwijujzOjKAXbIiPhumdPH?=
 =?us-ascii?Q?EnPlmpO/AhJonJmBLHJOZNchnMHCf2BEc5Weo1PMdYpwk7Sxw/4WHjIFjZQI?=
 =?us-ascii?Q?uGIKgDu6cTD5VowMAiYYTeEiS3Rw4T0QoVYVbJAcH9hqfSW+8GnuCS25lIil?=
 =?us-ascii?Q?fmuYXE+nokmGI05VpZ43xQqPTU14z7jswzDx6taIQ3aHCBG/ZvrXsSg2p0fz?=
 =?us-ascii?Q?H3FYNeZc4gUN65qN0b4nCxmj7071l3lfNXxCqjG3JvW7Pe1yCueHVOEKvggF?=
 =?us-ascii?Q?YCYAgk9YlhZM0H6UvNBEYqU=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5531ff-3ed2-4788-b262-08d9dae220c2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 00:24:59.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWM0qZ6YI1a4IIWHkNdAnEkRJbsBF8pJiMq2TzSmSr6lKXmvkix6r8Ftxcw2WnMCd+FKD/X9XWm3S26gofkvEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property allows setting the reference clock frequency properly for
ACPI-based systems. It is not documented under dt-bindings, since it is
not intended for use on DT-based systems. DT-based systems should use
the clocks property instead.

Frequency is preferred over period since it has greater precision when
used in calculations.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v2:
- New

 drivers/usb/dwc3/core.c | 6 ++++--
 drivers/usb/dwc3/core.h | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 883e119377f0..5f3dc5f6cbcb 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -350,8 +350,8 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	u32 reg;
 	unsigned long decr, fladj, rate, period;
 
-	if (dwc->ref_clk) {
-		rate = clk_get_rate(dwc->ref_clk);
+	if (dwc->ref_clk || dwc->ref_clk_freq) {
+		rate = clk_get_rate(dwc->ref_clk) ?: dwc->ref_clk_freq;
 		if (!rate)
 			return;
 		period = NSEC_PER_SEC / rate;
@@ -1492,6 +1492,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				 &dwc->fladj);
 	device_property_read_u32(dev, "snps,ref-clock-period-ns",
 				 &dwc->ref_clk_per);
+	device_property_read_u32(dev, "snps,ref-clock-frequency-hz",
+				 &dwc->ref_clk_freq);
 
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eb9c1efced05..00a792459fec 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -988,7 +988,8 @@ struct dwc3_scratchpad_array {
  * @regs: base address for our registers
  * @regs_size: address space size
  * @fladj: frame length adjustment
- * @ref_clk_per: reference clock period configuration
+ * @ref_clk_per: reference clock period; deprecated in favor of @ref_clk_freq
+ * @ref_clk_freq: reference clock frequency to use if @ref_clk is missing
  * @irq_gadget: peripheral controller's IRQ number
  * @otg_irq: IRQ number for OTG IRQs
  * @current_otg_role: current role of operation while using the OTG block
@@ -1171,6 +1172,7 @@ struct dwc3 {
 
 	u32			fladj;
 	u32			ref_clk_per;
+	u32			ref_clk_freq;
 	u32			irq_gadget;
 	u32			otg_irq;
 	u32			current_otg_role;
-- 
2.25.1

