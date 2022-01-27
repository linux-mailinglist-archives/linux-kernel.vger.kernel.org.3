Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6255D49EC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbiA0UG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:06:57 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:8839
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232984AbiA0UGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:06:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFRxIK84Ydd0dyxTPiHbQd/u7vA4m267NWheVVc43ya6aaN9aeVQwcrKD9S7lWfXv9xvuRP1AMCDo/oKxsMTlSHXpnw4QcrKvBLRfyf8JObBGj264IzwmRuMUp3UebO97VHw7i8Jg0ArGYlm3y4PGq9AfMA3h6ZTtKoTinzkc8PTnPj6HT/aNsJOHil9k5rLgf/U70IczuhJEi6VtPl8u6mdbIIKrYMWFQ7jdJnGTlAMpfGwMtzKxSJEDuEa7t5ewFl2i+KRL04XL2Y4VrjF8uc+yDTZd+mfwNwXJnLHFDj23I4eIkdWcKNdYL1kAqpm9C8rTPiJN2MwMzNNJj2f0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzHP/x+dYHR6FvTXMK0BLZIhC37+aiehnMT9dxjDGf4=;
 b=ZmNyEUEhQbtkHd5BYaF5jlhZmjRubsQoBtxkCMCGSMFDc5/KAdIsbcmtHb1qNm7aoZ7LHcml4bR6D9BlVJ2JTwpJqg7tflNHen01GzOD/uglmpFQa1xGPUvehEWsOLa/uf3/zTUypZmBG+wXOzLbNbSYYZrCg55Z4rbhKK1Qq2xc72xuTc8BmP38AcYAu7HyQmm+CBIz0oa+18bMdI8vMsV2ymqw67zbfJDqLV2NQKQz7+8F5sLRIYyEbmK1hlo0hADxg962C84XZ86LOE7KsTrEkoBS0dy0AD3ciiHMzmJ9+o7XsA4GIExfbIg/BzKHm6M+NfIolpEcMQPxju3GyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzHP/x+dYHR6FvTXMK0BLZIhC37+aiehnMT9dxjDGf4=;
 b=BErEmWjv5fZmi90Rqd1McUJwbcKNbz0ZEgaRjMHPGGyfU5gG526mnU+pICUNXixhbFCNAMgLR691ssjEv1AmH/qEWq25PPzP02P1276VJ1C/zJyk41SR3SptwsgHlkioGweAHelRZMcQxU7MVTtDYiVCoa78j4Jj6kBjXSBJIKr+gePd1xSAgMwNgYalKTrVFI/nz2QRmw1nXv5QvnOFUEPTxnn/+LvXbRlBK7wM4LFGy7EcOWQdXDrGYINgfS2bRfJcZMxlfDQhDdlLajTZCXrkt3k3tykIePWKdEg9JKr3DZDP6/6TbLq5c/TyY7pL+S0n76PiZm78dBdXR7hMfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB3747.eurprd03.prod.outlook.com (2603:10a6:208:4f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 27 Jan
 2022 20:06:51 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 20:06:51 +0000
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
Subject: [PATCH v3 2/7] usb: dwc3: Get clocks individually
Date:   Thu, 27 Jan 2022 15:06:31 -0500
Message-Id: <20220127200636.1456175-3-sean.anderson@seco.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf0f319d-b56e-42de-17e4-08d9e1d08e96
X-MS-TrafficTypeDiagnostic: AM0PR03MB3747:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB3747670F0059AD74F79F155996219@AM0PR03MB3747.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdjEH8OQJNMJ8X4C/wj3l+u60LS9xtZ3agBZ8mxCTsSSY8SBU6UhQsUnWUJrkT5W1YwRPUgOTecOExok5QyIGiTl2BtkcMCN+mfN99PaDSYqspaRb3IxGq9pR/6AW5o0OuFheAdPtSw8aTmgrpqEHRYhbTF0Sh2NkGYVubAxRcHcb5LI863v/Td51HOMHUoxcdc+N3WGS9KNi8hPweYJMnY13HzZRtAvEIv6tOIXOYReQUlfdCrRr7tI0yBlkhDzdDu0So9D1RR/idwq8kDTx2rli69e694U7ERQZ0iNvS9ofzY+AzzC2rRrzALQRh0Px8H/whnXDKAI9fvIuOafOeljQLv8x/5nHkqDoszHFYFb4g6GVZQ2cp+kBQRBiz7qws7feks4OkHoyMHGco1IM2dfA/RdfnLQgIhbDwa3ZECqVwfS1+N5h+dZySvOOvfsDeb9qlYjZnNdo4IrIUPfkUkREBd/l1cCOrPlD0v0CXN0BQury2Rkesw+1frzEz2wIRq89eHX3xCgH/SipBLauYkA0ZyGyCQL8RpOtXxdejcA+7q5PBhyP37FxzkV2dGaKV6jELkSLy4b/GrQYugHPoYzdVsxKbE+w41b3KrpJjRX/lWMKUsjMc7z5N3VoLkp4JQupuQp37UBzeh8Rj1tWP8jqcIiSF84AipYEcYVypnJwty/3gNlCGphxBNALOImYUEZsyn9I4/gZT4RvDJsdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(36756003)(52116002)(6666004)(6512007)(6506007)(107886003)(2616005)(186003)(26005)(1076003)(5660300002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(2906002)(44832011)(54906003)(86362001)(6486002)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzyz9kM3xDiAagzo4Wi7XJxg5C5BYN1lIvy+JPi2LyDpbncZNmm9LqnAzsv/?=
 =?us-ascii?Q?1PT/k/N8rX+gB7QpTGZPUw1sky6KACW1AR26WOfE88qeUCJ1wwdTP1H8s1Jq?=
 =?us-ascii?Q?nQXpD48T8u1Lz8YDmbUy2RK0I8mS4NFPuF8cL+XtcXTFjwYpht1qgUHwy/cv?=
 =?us-ascii?Q?U9yeAsaT2ECZFk7dfjBHzXhbP9mutT4MkJzu+3VpowKBg3se5M0rOWD1BMuW?=
 =?us-ascii?Q?64axSsNcy0DPTswOJHWvC7aManxneUq5dLTUJXgEruCPuXxDHYBtzyIeCnp+?=
 =?us-ascii?Q?vetWVgN7pHhv+mhh6kzVoRr2SHMt2Umspm8OCfN9wt43wwyJb76G/wH1m6SZ?=
 =?us-ascii?Q?pdAvuGMt0lANTS6FS60kQC+y4sw1fKS9fRH7/T8skGOeVn8DAH1VRMb+UKkH?=
 =?us-ascii?Q?QQcxIb483Au9MoFmQ6xQ1YyvHoeMRD5azcrmMr6N3/XsmpszcfNRy85m2plw?=
 =?us-ascii?Q?wLdCI+QMc0S2pYCZhSGayqs7B5iS0u7LZTBI5WNmtWm9s/Rwuf/BP0ewpSsM?=
 =?us-ascii?Q?2VOQuSGcw1cnuC89Z+2aL25tpdpLEpRe4/N9AWPmAcUyAw1oA96oMjTq2quU?=
 =?us-ascii?Q?Xm6MNCu6+HWTgH0Ibtcav/G7su3HS/hRYsELtpiju6XKS3DPvUhPP1EzDIoN?=
 =?us-ascii?Q?+uuUpcTQMaqCpH2QdRuk3UKu+Mnj1sEZM1/k/71EAp9MbjrqZ80dm8X7Q0aH?=
 =?us-ascii?Q?MsMFAPKMf1L8HKm0JCrnvFANp3uWBSHrcSlEJUmRQdoNxf+AplRMV+k3E12p?=
 =?us-ascii?Q?hDGjfAsB87/kCLnGwyx4tkpOohPNdAqpzEhXWFPv49XG1GHarwV1LWJvH2RF?=
 =?us-ascii?Q?Lg+rkbAMy6WUVAXzodjo5OOhA1T2+XeaO6PKhXesbjR8+1J3URdrJDsgdZGD?=
 =?us-ascii?Q?PeF9SlwtxTFf7xxvyYuEoR/B9TTwqN3AP8q/OhDGb6NhRATGxyQyZ9XvCsHA?=
 =?us-ascii?Q?XZulPVe3G9NssIFZF0iexcYhMtBM7Im4IiEpmNTYNhW2Z0kW8E9kF4P5kycN?=
 =?us-ascii?Q?g3ops1902xMKFqgwJxb0nA7skL0dLmqiuVMiMYfC34pelPqH9cTpHsN4eSxO?=
 =?us-ascii?Q?blOUVp5qVP7yncuhlxvpsFkx+j39x0S+y8mVI7cHg9DT2EGyhcnCvWjLPxeL?=
 =?us-ascii?Q?1HdEHDh4BugKq23QNxxoTqUhB8S6JFPSTkLwiSvDe+mYxxyHD1DzzLKsJuSg?=
 =?us-ascii?Q?LBTCn15VQtDEAyKlRFvHwf4K+MM9/GNAoqIKbNKVDebwmyRPkEnySMtSV8Qy?=
 =?us-ascii?Q?pvEunBueDyMNOMGhj9cWYatjQ/mvopkKH1cIyJWnvZMuJ49wU1mj5VGY3pfP?=
 =?us-ascii?Q?M8+8u4PlH3EKtO62OyfDriuqdOewA3MOV9GVBd1omGqTN1GQZhCvHxZxVjF3?=
 =?us-ascii?Q?I7BBGJVV4gN1dDvTp2KBfjx1/mXXA5qlgyX0RIgJN7E0dtccjTzdbEh/Xuml?=
 =?us-ascii?Q?/GcKxzrwZT23cFTAHd+1wA6qgRWubSt3bp4p4DkeDl59Uwjz3DbS40b9tSaN?=
 =?us-ascii?Q?qb8/yWrh1UHvj7BqcbGFM7j+d8L+msY8pmBr+oCTyLBKc4SnCcxnDx5P9mJ4?=
 =?us-ascii?Q?NpSoepuMNwcIcsWvVJ3S8s+XlTsv4WrLVfOd6xsdyvrxFa1cRAmZpMPLKS1W?=
 =?us-ascii?Q?hiu1wAXN9vTXftyzikvGvW0=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0f319d-b56e-42de-17e4-08d9e1d08e96
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 20:06:51.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KWIdU2qjwX4v5sGxjEGvumalowcjr6e1r//hAWk+etBKv9MVSpmYrZJgDmzObmd7xSUrTG8P2r4iVZcJJajSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB3747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of grabbing all clocks in bulk, grab them individually. This will
allow us to get the frequency or otherwise deal with discrete clocks. This
may break some platforms if they use a clock which doesn't use one of the
documented names.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Robert Hancock <robert.hancock@calian.com>
---

(no changes since v2)

Changes in v2:
- Document clock members

 drivers/usb/dwc3/core.c | 62 +++++++++++++++++++++++++++++++++--------
 drivers/usb/dwc3/core.h | 10 ++++---
 2 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f4c09951b517..699ab9abdc47 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -745,6 +745,38 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_clk_enable(struct dwc3 *dwc)
+{
+	int ret;
+
+	ret = clk_prepare_enable(dwc->bus_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dwc->ref_clk);
+	if (ret)
+		goto disable_bus_clk;
+
+	ret = clk_prepare_enable(dwc->susp_clk);
+	if (ret)
+		goto disable_ref_clk;
+
+	return 0;
+
+disable_ref_clk:
+	clk_disable_unprepare(dwc->ref_clk);
+disable_bus_clk:
+	clk_disable_unprepare(dwc->bus_clk);
+	return ret;
+}
+
+static void dwc3_clk_disable(struct dwc3 *dwc)
+{
+	clk_disable_unprepare(dwc->susp_clk);
+	clk_disable_unprepare(dwc->ref_clk);
+	clk_disable_unprepare(dwc->bus_clk);
+}
+
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
 	dwc3_event_buffers_cleanup(dwc);
@@ -758,7 +790,7 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
 }
 
@@ -1605,25 +1637,31 @@ static int dwc3_probe(struct platform_device *pdev)
 		return PTR_ERR(dwc->reset);
 
 	if (dev->of_node) {
-		ret = devm_clk_bulk_get_all(dev, &dwc->clks);
-		if (ret == -EPROBE_DEFER)
-			return ret;
 		/*
 		 * Clocks are optional, but new DT platforms should support all
 		 * clocks as required by the DT-binding.
 		 */
-		if (ret < 0)
-			dwc->num_clks = 0;
-		else
-			dwc->num_clks = ret;
+		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
+		if (IS_ERR(dwc->bus_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+					     "could not get bus clock\n");
 
+		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
+		if (IS_ERR(dwc->ref_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+					     "could not get ref clock\n");
+
+		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
+		if (IS_ERR(dwc->susp_clk))
+			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+					     "could not get suspend clock\n");
 	}
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
+	ret = dwc3_clk_enable(dwc);
 	if (ret)
 		goto assert_reset;
 
@@ -1711,7 +1749,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 disable_clks:
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
@@ -1755,7 +1793,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
+	ret = dwc3_clk_enable(dwc);
 	if (ret)
 		goto assert_reset;
 
@@ -1766,7 +1804,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	return 0;
 
 disable_clks:
-	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
+	dwc3_clk_disable(dwc);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e1cc3f7398fb..45cfa7d9f27a 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -978,8 +978,9 @@ struct dwc3_scratchpad_array {
  * @eps: endpoint array
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
- * @clks: array of clocks
- * @num_clks: number of clocks
+ * @bus_clk: clock for accessing the registers
+ * @ref_clk: reference clock
+ * @susp_clk: clock used when the SS phy is in low power (S3) state
  * @reset: reset control
  * @regs: base address for our registers
  * @regs_size: address space size
@@ -1134,8 +1135,9 @@ struct dwc3 {
 	struct usb_gadget	*gadget;
 	struct usb_gadget_driver *gadget_driver;
 
-	struct clk_bulk_data	*clks;
-	int			num_clks;
+	struct clk		*bus_clk;
+	struct clk		*ref_clk;
+	struct clk		*susp_clk;
 
 	struct reset_control	*reset;
 
-- 
2.25.1

