Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AEA4931D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350461AbiASAZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:25:04 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:23461
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244782AbiASAY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:24:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHqAMhRMpW92YAls31wwEyiFoja8GIP6lHQ18eYlJOkkwGfvIN/5nii+fEGZLhbMmgt144QeDWX/74uG3lZ9czzlQaNn3UiB/Su9xakaFWyYKEZKj/iwy9hcrF1WHWBtIoQdkLKoRa+skj3EUlaubtAkax57Emu0rOqEKpZaovP+mkGb/m7D50wxj3pMGzK7m784xIkSxDIx3T8C+JZBPTrwuFCx4XLjO3SemtI3V+5RNdBLpKw8mL8ij3CJcFHywc+XsHOHeSldu7HoK0TuRtMMW3XncHYmDTI5e7GytuJZ8N85MVvmAjKxi1uZX4pRjdTZqgqcBN5fE71dmGHpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1wzgHxMee1sqsmiL1o13ZkzRDifJobPMhYkv72TIZA=;
 b=KHjQELW4DSzV7aFFA4Su7Mxt6ZcmbpMZ7SzDfWNatY7Pa9MdE30trhdBBsqo//fUVwj1/5GoQTJj+gxA363dscqPjaGtdqq6pVSTQ8vm/+JPN3hqW8nN1etP3lrFxxShkXGe9MVAHtvzFK5/UFyAT30kl2gyqPWlKbKdUkeKMZh53k9zsnNSyoVh+3W/4uYAyXStfgmVmDD1DHP0r0vjaV6yubUS26rCm1bKPYr8f/qNwZ/LKhY8PqjJq2zHztsSoQeMEeJ0uV5sX5zMDXvSnxH9ECcaHB/erwwApflM8pe84HbRQXEjEtMnFx7mg695cDAacWrjCeVr/b+OkIe5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1wzgHxMee1sqsmiL1o13ZkzRDifJobPMhYkv72TIZA=;
 b=qdUhLX74FEghxeJDjLJ9ZTfHkSMv3zmR6sMwSlb0kvLr5jibqEdv+jXdI6kQoNKIFe91/HMypFN0ntWGwMv2V9dtqfBzJ3ZZUOMpGoJ3HjFa+FylT/Wq4xKR4GnULJqBeAtrYWG4NQq7hL1BqbsxS5eFHyhI5ILs5sZlrFUO8r42tB0BBtJ4XX6MkclssVVnoMbUCG2QNeXfDW82sDf1W+tnGPQsmyO44NDJYNIn0qPN33N0zbZO7X3BYgwlEC51mQ1mHocQNF6suC0PDAFiNLXdjvpWhGYlRurFy1w3YufGeJqI8xV+5KsKFXSCOP1xwUsWlDNiuI4G/JeO+MT+Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB4373.eurprd03.prod.outlook.com (2603:10a6:20b:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 00:24:55 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 00:24:55 +0000
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
Subject: [PATCH v2 2/7] usb: dwc3: Get clocks individually
Date:   Tue, 18 Jan 2022 19:24:32 -0500
Message-Id: <20220119002438.106079-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119002438.106079-1-sean.anderson@seco.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b139ed45-4227-409f-b3fd-08d9dae21e30
X-MS-TrafficTypeDiagnostic: AM6PR03MB4373:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB4373495081197AA0AF185E4D96599@AM6PR03MB4373.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7Q37EAl3y+BoqVC5YQYAOKm+P3iIxxcZLM5LQ+NvQ9SuyYHkkFus2KA0e2sDVyKRrHZKoDGBbIxxh7fGWetIKvaijbT8lklcANXjqr2G29tnMkyyKGbzNY4F1qW9QNs+J27Zf4PP3gOPl/GnQgYwfVSFUpir3RW8A72bcuBXo4kMleJUNL+2az/FpvYJ1zWrMA3wmcFGjogSopCSj93B8qX8YMaHMW1gxbjqdWsn63Zag5YfD61OOsjHYfJS5hn/VYvE7AtNXwjBvEbewHuiLmLvGEELX0RuJtD3F4TibltYZib6eC2NSV6tpFtrK8InDFI7O6YhvK7QbRPch65SAXngqvMG0tfyWSCfQP0GA6GQ7UOoZpFmrzGMs5i6ySVIUGvKBu13uZKjK6g2xCfw5gaaonAxM3MyOQAAQmZjf7mnhNeVFnkKp+7x9CFWY5+f8xYYxHCQZdiJVvwSVh5+m3i1S63lPBBjPFphDe291std0GIqs4CgdtHnviz0byK0N7Ojw0fEAFAopSRl75ekykK4Eg6tJBLQigkLEQYiyBdMxuMGJQodvTbEzPWlsVonDnKKBVtkREFgMxPbY0AZwd6ABkr4IDQ00TyF2rRyS729PDntBQi3ElMbVvm/Z2VD7Wal164CNCaT2CwSYx2amPgTH810uF52WYZhS8cb2FPPGgDstjUbt5lbT6z0eoZnVYIzrAZHBJ4cK/vgtmCVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(316002)(6666004)(5660300002)(186003)(4326008)(6512007)(44832011)(6486002)(6506007)(38100700002)(2616005)(1076003)(66556008)(38350700002)(52116002)(54906003)(66946007)(8936002)(508600001)(2906002)(83380400001)(36756003)(26005)(8676002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JJW//faSsHrt6qOVuMSjlrFF4J8zhb2y/mh2RUSsXy9TEPjh0q+K6cNn4QOh?=
 =?us-ascii?Q?hENb02O0YMvC4sEV738WDorx3teIcszCGsR1aGHh1wA4iLcn3ciI1Du5xA2N?=
 =?us-ascii?Q?gqYORNbYsVBGGQPYecgYY8x2o3JC/lDY9UojS6eL5WQ65kg7Z2WC4dpTUjwD?=
 =?us-ascii?Q?xs1jNDv1f8YcjcjSBO8Gup0NkBcqTgiNCqiMPJxGjWA6BTUKPZfnJakIh4X4?=
 =?us-ascii?Q?g6Xbo9I2567GiEQTBx5slgbAqybfQQwawdge5zfyzCV7K1YDLmuLY5M06Oml?=
 =?us-ascii?Q?zDE8ko21GauhC69mTezMiXIPvAV7+cZMH8UV61COva2BbKGYXFVPCMGYhTIZ?=
 =?us-ascii?Q?fXUJoGd2O5kmYenJRxy3cICpLG6WL+RMEMiQVknrfZe2LfWiati7tzNdk78p?=
 =?us-ascii?Q?98DNnPIZNNjFKXOHdGGuN59HMJvp2lQlyq4gDTCtMjA+VBq39OqmyKPh6aVH?=
 =?us-ascii?Q?4qxD1A4lUXgnOgtUzfcOBg53zSx3Cc0mKv1aDYD5iwihwNTQAWx4Gvv8BGiT?=
 =?us-ascii?Q?58xMBTRrtbc4QnQprn4gHOB6XpkK+HQLXeMsavmrSZgW6gQgbcru7ROQcnoN?=
 =?us-ascii?Q?gx229hGvyomYzaZWFSWC1g3fVtHA6th2FKTeqqGrKHY5NUdIChZZzOmwbP0h?=
 =?us-ascii?Q?WjIRQhXmdBBfRQoTbLYqo0uD0Ggap3zX415LOosagXiMRh7nFhUmsX3wC9cL?=
 =?us-ascii?Q?Qf66KxVOc47DjGPAeTas6yABJ2hEeRmW3igRa1KLNSyHWSkxFyu43ZgF1ZDr?=
 =?us-ascii?Q?dPblfTh9Qj77XN3MxptZnyVi+sMWNdpzbj87r1vnUIelwB80b+jzKQ86dszQ?=
 =?us-ascii?Q?W9ppR80xdj5YoppGcc3heqlMBinEz+3fDH9+n++kk15zM1gLhTxPqOJ/2S7X?=
 =?us-ascii?Q?7FTHrVmArvauukGNYzuoeum1ddGVBS0mXasobNmqEHP62pHjPzXkvgiZdmMo?=
 =?us-ascii?Q?TGOzfzYLFLA0B7G5v8ixOJrxBTeu9LbPWEiA/fUCx3ByPrbtnMJVoCwDOCbb?=
 =?us-ascii?Q?05aXnmiicQ2eZhKBwmBUyvJP9LmNi8gfjs6ed9nehnekG1k0OdQtdeDgZB6K?=
 =?us-ascii?Q?J1vvw70tYdWDINzpmOoMEfj1HUuROi6VC08AtFQAy7jCzcF9SIJowIC4T1P6?=
 =?us-ascii?Q?S3A5wEBAyWQhmwTjhFF0ybeHEPuDwgSqkaXNSfxum4U9HPNjNH5YXep5OU6f?=
 =?us-ascii?Q?Rwzl1UI27Z/wF4kWJYqsuNik9hf6uA3XDBNQj2o+sJ2jUyI4ooQBDUGGfOrG?=
 =?us-ascii?Q?2dqUNel2YfGsjLqMVXuyLFXZEEv3ycssm/PpI4Bl3C52xwgexHeemVel9z8k?=
 =?us-ascii?Q?v7ITpGdnVtVXCcXHA3uNXbg/h3QuMBe/JbaLHBeqN2NyXRUguVGNWKpLMdvi?=
 =?us-ascii?Q?cY6CqEHVgOElonzYiwQ+5DHeIuOKhNSrQzQUgLoLT9wCGdOY14UEyLxk9W5c?=
 =?us-ascii?Q?MMvO9E8yBGqGudyz27hzsVS4Y0XlwAdltUHITyDG1k2o74a606Su+EwIknaa?=
 =?us-ascii?Q?uM49VhNKc1Lq/nmwoo8jSu38Kc139W0kgdlqBiz7aUq4H484cIqWD5onYQTb?=
 =?us-ascii?Q?lFeWACrIAUyjAIb9vs5f/vQ+vfZlEBoSrof+DUr9h+lDp9egZpIN7chOk4Jv?=
 =?us-ascii?Q?+VeJC+q/s7L0uOKKIpm+0rU=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b139ed45-4227-409f-b3fd-08d9dae21e30
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 00:24:55.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MspnLRClLlkuMTFjbNf62/tF5tVyCDiOZuLeCGDQ1Nr3CvDrdb9hynncloZQUf60DCXI+v6H/cu1ZyR/roy4gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of grabbing all clocks in bulk, grab them individually. This will
allow us to get the frequency or otherwise deal with discrete clocks. This
may break some platforms if they use a clock which doesn't use one of the
documented names.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

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

