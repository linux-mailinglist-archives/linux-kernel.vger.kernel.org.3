Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44F48F316
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiANXja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:39:30 -0500
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:20289
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230136AbiANXjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:39:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDjZAqf2orThVnY0bbELZ7T8XgOg9JS7XQKcuR/sk2k7OG54FF6Q1+0qeDFPl+YsNDzhQ0W2ChzFEXSjpzEpRBvP0KqKgsMpZT4X0rYkJXY2J9T1zYuqNzf0zsf7VPH6ljXoHElWtP9fyFoz/4ef7yqNX19TazmATqoYLslD4iNyNumYRdm/ePb0Nixj2w3YAWqyEzcMq/CxVhnquzFPmU490M5CrK1A4QvtOVSW8TCoeZ6zF1QrCgI60WKQR/vmEY6UiFvGlqtxtNAgFOMB8ncLXDfeHe8IoJGr7K+6BIC57X1vbsW+iNDk683gCn+CW5Eovf50IXD2xp6vPKHBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLFhyChsJ4LImci8dwK5s99yueuJ8oXC7sm+P+C7M4I=;
 b=lYcerv8eQpeaXJd6XXGUqYcFft5u/Kes3BHPGhU3/BL8ksadts3kDkopcTD34/amzaOnHEMWjuoMD1fdZTApVkkRduI/uM38TfYw75w+DS1riJ7q9HJhQj+dlzepLR+PLNGz2Ahbh4DfI7J0wVOTH+XC0qKcgGwMxhfgFLD9gL+rEy2+EodA5ALKk4UxIICDyb/9DP3XyR1FTFrXCqMXc9qZ93/xApbZU7R2Xfp0OKasFDyyWQm7wlXeqR33ZS/515X/G6JmIcwss9CdlBTVkdxhq9URthnFlevUWLN6xvxV3fGXoxx5clx140ZAVI7+96v6Mk/1vb4nF+QtZnsvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLFhyChsJ4LImci8dwK5s99yueuJ8oXC7sm+P+C7M4I=;
 b=gFLpXdTVDInbsmj77bt51LwswWK0wO2NAgDz3my/vyBy8FOLQi/fHhHI9P/BPJmx5QhJgvxh/vM8Il7p2Q1rZVFck42XSYwNUTlbbvzKNOrPB0osUo4BNr5pTQ/HUgosEiKZu52rOmgRD5QJXTdMwNkyZZIeuNw7+Lkt2NosKa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by VI1PR03MB4336.eurprd03.prod.outlook.com (2603:10a6:803:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 23:39:22 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 23:39:22 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 2/6] usb: dwc3: Get clocks individually
Date:   Fri, 14 Jan 2022 18:39:00 -0500
Message-Id: <20220114233904.907918-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114233904.907918-1-sean.anderson@seco.com>
References: <20220114233904.907918-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d737e4-ad8c-4d4d-b1a5-08d9d7b71750
X-MS-TrafficTypeDiagnostic: VI1PR03MB4336:EE_
X-Microsoft-Antispam-PRVS: <VI1PR03MB4336CB04835CE9979860F67996549@VI1PR03MB4336.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29RwWOqSC2mhZZLSXYkDwc4ESmylAO3S7K6Qt53IKzbPH0c0LNKCs3ywHIdLhroX7rmIP1juO6prIFecJqUb/LM7tPoLOPBeLTv5UH2MKC0SP9Nr91Gjjf27WaZGHcj9lVloe+CpjwJiNDfV6ShXcpOo0Mh7LJ06Z76QZy8X5qDDoIivekIGR2Lt+cbaWyIKsANZNTngAh7hdfMnnPeRSitDvXU2QNurnGiDDCzXKOSuZiL3Vnr1/Hxhm0opX4cXx5m2R02QfvLOOrarwPa5cPbM08Mr18NMHfGFbdU29VDurbNcDkOU+fqxjbeE7EpU1l3jOSIgBH+k7A1AGE9hmQNTPjDyWKr27wP6kswO3iLmyJNNEsizLeYIo9YJLFREu+2sz4fNwEQAnVRDb7Its18YD5ykBVTrU6v5KS/RQZPUV1tbGFlvgty9+aN5qHM+HruwVwxsMtqD7zu92AzOJ0DlBycHQeDmXkzB8PDjfKDYZ2MNA4zOWlDnCOdfq11bxNusqe9ywjGsiBnV6BHbiV09FvWqStNrM3Y3JptiSZX4nWe6QO/r56fvAvn+YR+1p+CC9Z//deSFjN7vT8QAB1cPQP8Z1mT5vkQkgqrVWvHjhswcT+nl+zC1ai4ryGsikf4+4AZUcMiR5t18121FjZcB7K2MSOALexc1QCHBqsC81gEBAWNVPsPRc3wrtNDhqyUffa7kq5G5EQwMqEorbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(8676002)(6486002)(44832011)(54906003)(83380400001)(38350700002)(66476007)(52116002)(2616005)(66946007)(6506007)(86362001)(107886003)(38100700002)(186003)(6666004)(2906002)(36756003)(5660300002)(316002)(1076003)(508600001)(26005)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KOqec1q9FPfgXnZf4WrYipl9+JP9260+vjpuhYa/9lTlf4gcjzSaCahG/zyi?=
 =?us-ascii?Q?wYjpBFsH4Asmvq7YCzqYojacO+4sFBinQk2z6YM/YwnqS7jKsfqQ3mPjfvEN?=
 =?us-ascii?Q?Dv8C3vW/h3FRbbBMa0W2mD3dEAHB9tyAqqxyInyEXUbi2SNPlsw36xs/HMKP?=
 =?us-ascii?Q?m4vXfAC/M78N7BVW9NC75G26ryjj+G9LbnOsIks+g7k9KKWNP6NZ8EdE1zqz?=
 =?us-ascii?Q?CbXd4p4DK3uGmg3Jep0MdvJtdcuTyutJ9Wb5JS8DboNLkbJhKW1vOU0UYCNx?=
 =?us-ascii?Q?EqG2lcfBOi77/WGCOqdNASlQvTiK7xNVVx7akFkzste/zTykmBsDT8f0qhAZ?=
 =?us-ascii?Q?wRU213LWBUro2oAzqBy/zElABZkI+PoMInWnCmPOr0ptbMXBfJohqKflhXV/?=
 =?us-ascii?Q?E9RL26mEJkjKWwhDI4JwJxDxzAdJwdWm/hcjBVj0KDRZjyFx8+kjLbvcLF/2?=
 =?us-ascii?Q?pf3LrFPkYm6ayRbxgC7XodqprJdZJkKFT8CUyyECfFNtQgA1lGsVjxL/hZSb?=
 =?us-ascii?Q?h9QFt2tjBBWfB/i+1JyMz6S4u8kmicgsu/nCN5aBAeKUxk01crznxWR7Ys8Z?=
 =?us-ascii?Q?6uFvK9unQvelc+FRWgi/i3+Q+UEfZ8nXqBVbjzMCPfh2Jyi9ViP/sL0IjdaP?=
 =?us-ascii?Q?kpFQ3wK4elSQtnaxpdUa6Vvq+p4jVNGsct5nQWVBoEOmoLi6CP1Aegx1Plm9?=
 =?us-ascii?Q?U/+fT54OFN3wZEX8rqG/c2n50RQTYGlzAU5y4Pqu+6Eluj1cNdmI4qd+aVEo?=
 =?us-ascii?Q?Cdm/VVR88ngPE/uAkhfZkOLQVuT3HV3rW+A00x/6knI8zuVw79CJypoUVjC/?=
 =?us-ascii?Q?8pHUx8ZAc2DZZpyHJVVYDqdWSlUE8ySv9JivxuY2bCUWh/ftf3rg9EJGDydD?=
 =?us-ascii?Q?AWtRrEsmeOC1p7InMhfLrcc/jnRAOd9+oGQ0amFtugioOoJdVGGLavael7mj?=
 =?us-ascii?Q?pz3+mpgeeIQwAQH9IDbeyNsVFp1ReVBCFbtGF5oAtpUrxtOZ6wKrcekq/C53?=
 =?us-ascii?Q?cBSy6mY8KicBZ3ZbrbonU3NsMegIThHCEQQOeTJX3qS+wR0EgyClSxkbFAQ3?=
 =?us-ascii?Q?X/G2GLB5Gt+GMBhuIHoHndHlxB76QNXydqVYKxtdn3DhYP+3YhAKhMmQblvS?=
 =?us-ascii?Q?ZXRcI1PtA6MEWjqHHMcLDHbEAz+pIbKBlA48C5gLU1z0T/PpV3F14Ogt/ChH?=
 =?us-ascii?Q?PU8ec3sMkrJIyePhN7WXg6SOZy/Pe02ze9V9uLYqdhWV/E/1urvElfCw8Q+d?=
 =?us-ascii?Q?0kfPYQ87U7TEpxoFxJxn6siOTzmZQ0lBfe23CyVkgdA5wt1+nLjnojxMHZkt?=
 =?us-ascii?Q?A0yER5fovxxajSocP6bYkw0JHYPEtSLov4Mc+pRiCDG/JM0mqIIJ87hQgXzs?=
 =?us-ascii?Q?gRVTjpA60xwn0Ex9tHqWVQgkbrgVYhMGS3+s1LXf8io0On4oeB4pLrv87pb6?=
 =?us-ascii?Q?rx8UhI7tZIukgZLwrLPxjSTnP13FyvdZxkwhjqk9dt7CX5SWN1DhGFH9U7wp?=
 =?us-ascii?Q?ZDQci3pYZWYxsGzunxt4PQfMq2ueadPNy64xY46Y4PsYEvIRddpOXGaiE8f8?=
 =?us-ascii?Q?Gq0d6mdi80XEcWvfFJ2y0gKewK/ANNNvSYSxmdAyvSovz5vxczNLQMHJFF/2?=
 =?us-ascii?Q?y96Sq1uB6laU4DjxmiWVxkU=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d737e4-ad8c-4d4d-b1a5-08d9d7b71750
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 23:39:22.1037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJXLYfZNzHB5CD+EXIp7osZyxMbALPfB5NBoClUWJvFRL58x3ptnXeE9N9Hd0iXLXo497ifikunKokzJ/9EXug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of grabbing all clocks in bulk, grab them individually. This will
allow us to get the frequency or otherwise deal with discrete clocks. This
may break some platforms if they use a clock which doesn't use one of the
documented names.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/usb/dwc3/core.c | 62 +++++++++++++++++++++++++++++++++--------
 drivers/usb/dwc3/core.h |  5 ++--
 2 files changed, 53 insertions(+), 14 deletions(-)

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
index e1cc3f7398fb..32dfcf3a83d5 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1134,8 +1134,9 @@ struct dwc3 {
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

