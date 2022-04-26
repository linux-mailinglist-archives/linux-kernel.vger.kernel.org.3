Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6D551022D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352546AbiDZPx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344512AbiDZPx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:53:27 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71121BC11;
        Tue, 26 Apr 2022 08:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn6QDtk1GDp/jqim2ha2W3nwDityXVJ04PuYX7eX/qgqixia5H/h+cbnEGV388YJ0ivczQAqa43x5VG1DGeMO6vVA9mUXn8KSrgPBP0dIvzcCGN5Y5U0YNWNAdhexKWOPmHS9JlHYvqpLPCfmRAu9UxceZsOPD9MinicEtLb5wIAegjEnvF1uDQuJmj+FEX9/3xMCfS9iRPceq9gyHYI+LrTb+xDA+cztha7OlQARAIfq4D1WzFIkl++ZtbyyjJjAqKXwi6LgMLIthP04/61/WC1db4cvn3wcF4rerr6SeeHitYLh3N7eHPExJMUB2xK+7DTey5EL/O2aF/+m7bJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUgRLN7fqyOS2Xx2PtFxBwV8emY9TH49nkqM3ioASZ0=;
 b=D4Uuic95PBqG8rU2SW+2FEpAlQlorceEUeDwe6jJ68HcWj8cLm+BNy2nYPZ3zFJN8/PotDkvR1uyBWh6OIXfl04/xy9ka7BAZ36uxuvYZ5OLKuneSbMCEabA5n8+omKU1qoAay8azXsA6l6kmyyCq9WS6cB+XYdrZ1t6Xdh9a4y2H3mZuXT7Lky3lwMsmqpGRe/nKvV3e1yMmWmQMNw/aeIcU2KljvbcnxUgiLtu0E0d+pRNt/gNyrya131cM9fxDezz3cBcLsAS2rPebsYCRDaICy7RnNXoY/P6neTeZIfjlEIea3wQp2j9xNKSWa9NshPbhtxK04nW4QuSC+A+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUgRLN7fqyOS2Xx2PtFxBwV8emY9TH49nkqM3ioASZ0=;
 b=iGK2nlbcGoP4j09994JQlF8a0AxtcCL/sBZfezxXj8JIWEWBnA0lDOQpEVhBDTwZiG38vUTNmFT+YofThOJ1Al5NVDCG1OYcTq9+u0snz6F3Rqy4aq+SUIJlA7fNXC+hMRi+SSTzqHCuIAgiNrS0mHHomVXU6r2b+iMw83sJwOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VE1PR04MB7230.eurprd04.prod.outlook.com (2603:10a6:800:1ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 15:50:16 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:50:16 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, linux-usb@vger.kernel.org, jun.li@nxp.com,
        lznuaa@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] usb: cdns3: allocate TX FIFO size according to composite EP number
Date:   Tue, 26 Apr 2022 10:49:54 -0500
Message-Id: <20220426154954.994747-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42ba8901-a166-4d68-33d5-08da279c74e9
X-MS-TrafficTypeDiagnostic: VE1PR04MB7230:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB7230FBFF3FCAAC23BC3A09ED88FB9@VE1PR04MB7230.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83xIJugYgbcsYowKdk6eAoUs2WitiHtOn6I/7dLqhQkK/JbZoqtwv89TX+1K+Sy76z07Rk5yxyp5ETCGLGyTx8XPQHosxfn9qVZjwwoUPZpeVL0az7q2Qq1d/O06OyAzXCUV0QBiaBmMNVbaY1Gk0lYv8Az0qOJaLXNUqfwTaBsQ7+IxRxuv1jnlpkixW5JLHMyO+DNAK1L5XWYeMJ56olnh62m98O/AYKWEzrhoWPtHJOz9kOc0H903ovpCcQPadfdPaBLjbI5MU+TU4iAghQ+CaCcglruZS2V7FziRPbcM6oZdbdzoQERlR99Sq/jIi7gncmlx48SSW7P84Msxiupjym5G3wNpYwu7aEoDI9O82mpgmTOiCzKP6j4CpI3fQ+2PWrz3STsS++dRHAX5U0vK2zMKcTRXGhvI44UqH1LggaGK3GJJFLL8dwsn2y0pQi9eMgy6ie4gAm+r4bWlaoXVRzKPSfyFlYv5km18Iqler/PLwy0+iXOgBAxLyz1WxWCwB54uZtS+MwuhWdBURCEVj9MFEg91JtLlCJbF2P89uYHe1uECJrHzAEtTo4oKaYg7lV/xy0bsCMawP7uaZ9lsA8dli2mJozaApFYkgROXuzRf7qMPISlMSFe0nX4E6ST2ylAtS3xCKAv1u3FQNB5yQQ15KH/sjC6eLbDeYcMHZf6hvcIWCGzM9EOskgrGhrtGgLIYcxM8d723tu/YtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(2906002)(5660300002)(8676002)(6486002)(66476007)(4326008)(2616005)(52116002)(186003)(83380400001)(1076003)(38350700002)(38100700002)(6506007)(86362001)(6666004)(8936002)(26005)(66946007)(66556008)(316002)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gp4rdgV/yegQ5MudtNzl7yfe50McDSV7YMer5GcJbRUjl5OWOVmGHi/stXUP?=
 =?us-ascii?Q?SQoBYAxYXAP13ahd9TqFLvVol15COaQFLuOAiQ7TuARm8Ka95/YE4j2NkXHW?=
 =?us-ascii?Q?mcvKdLUjMzQKWxYlPNmfkJo1lbk1aFbGEwc63eeF3XUcB0LUjqYJOcz9RNZI?=
 =?us-ascii?Q?LR9iUgej38wNilkzYFcv0/0xcDxaKodNsdLbgqV71osyO54pPTglRcLizKdV?=
 =?us-ascii?Q?2uMEAGQCjKB1MLdCBmGeRW4NQRS3FDHS4UDMWHX1WVDQPqkPPQ0W4OhaKDgt?=
 =?us-ascii?Q?hDQXi0qTwM8Jq7mHfgrX4WEBXfxXCj0e9XpeXsPh9pjq1cWJxWxxlTOMtkCx?=
 =?us-ascii?Q?4cDcMFk6G++I10/rJAwG3j6oT9yTPe734sGv9mYppqy06re4xf5eeAykn6L6?=
 =?us-ascii?Q?b6rOyKvHHh89M5HrVYOKNV6mzGW+YCkxLfFhTVsOMAox1Jzi04UUBT03k3na?=
 =?us-ascii?Q?vcmSe4izXYmYKfgVfPgzM85mTfTu6gYMvQ+hKbGjG1+RmJF3SzkpMd2x+POh?=
 =?us-ascii?Q?pIVN5KxilsvknggvlQBabnVHWrn6gewoA1tgm4WHC18BZbwCAftuhmLu3aH0?=
 =?us-ascii?Q?6o78Xvsoh19ikI6SJ6zpm1huqx5bQUTTqwciZaXx8A0iZiixAIQ3fH82iySP?=
 =?us-ascii?Q?DGfOX7osOYFzxen7z1/gYOwEsJ3dHrbF3tGMFosvCPPup3h2w3FUJMjMwXyk?=
 =?us-ascii?Q?LuDARaV9E0/0G5gr7MIznwRxydmx8NArMmdKvmpgmM/24YSshFfkyKhrGvIA?=
 =?us-ascii?Q?oaf/fN+Cs6QjLL56ZWjOyUjJx0IKiJg4ZPsdB6azROuLAKpje4hfRyeNL9aX?=
 =?us-ascii?Q?JbVV324DErTRcfg6a2fTNL3VOlLYu4eIPWdg2irmDIaQjK+2N9g5C+uhJwdq?=
 =?us-ascii?Q?cawqgWjB1PmhXVCn80Apf1RutIVFz0YW/1qDhc8d8zhzctCpzLGuSeR/tJwD?=
 =?us-ascii?Q?ujbTyEWcAmr86R8JWBJmb0Uk4eSh9LK2aEwD4/LDLkyMX3n6HKJuSmyn/QXm?=
 =?us-ascii?Q?4pEz2Vlnj8a69pAoG5+9Z2hRgK8IYArKHAo+In9E8MkjAjSMTGYzF/9N/yyy?=
 =?us-ascii?Q?J/YhKXEQwLACx8WwR44uKvrdv0KP4dQC2bcYsd/EdYxaSXzjyJVLC7yJ53lO?=
 =?us-ascii?Q?ktLHNaivN5TvZNPsU/dpdboGGYiw6XasN1LGDiOp+IO0Y27c66O+Q/fwHHF4?=
 =?us-ascii?Q?wus+1JEiQjRlvgXTQgfQSchUqojqiZgAIiDEJz1kxeaAMU2sNoj0/tKG9cCH?=
 =?us-ascii?Q?6U8Ggp8E5Cx8amrmR6lz7YP14OQxyO2RS/WodeofC4fxLQP9bNfYnJbb3K8w?=
 =?us-ascii?Q?bxHE4gKBHizPZqKu1z+mx5Op/W5DXlOEbgy+aj6xDdbHefSnssAU4xo9sehh?=
 =?us-ascii?Q?UJJ1ANK2JK8mXtNRd7jMWIaaz9sHUjXz47UEE9VF2xGIjKEJJH6uy8r+sul8?=
 =?us-ascii?Q?KgeJVY5IQdjqu6x6LlasBXrTR0v5vlEWKsNwkJpgGihj2z+z9fOdLhe2tZaS?=
 =?us-ascii?Q?Q1ydt5OrFDW55ryt16ZaVj4Ico8/8268fNZVNGQw02U6nzvTZHDStblJ5Avj?=
 =?us-ascii?Q?naRUUTqXbdRz49pnSUCvhxJkkx60gXR+gUUYt64/klAmg1J4Lhvuxb4LD/qW?=
 =?us-ascii?Q?qSKOFVA9N3udp3aNbuY2BklrdAQG0l/28Vbec2lgd/d3Md0bIsNqa2NhPkhq?=
 =?us-ascii?Q?sV42YYhq6zZYOkvDxAXUeNxmINiowMS0UFc03ZObzL4g74m6faKuQQ2zLvpM?=
 =?us-ascii?Q?dtgM3V8QMw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ba8901-a166-4d68-33d5-08da279c74e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 15:50:15.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqXg2Vl+7TEKnDGZT5w1tgWU4Q4QhXpW9BTyvhtSlDAiiDxHCS5K/rFvVULsKUKun67hPoJAr4aSO17gNkyF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7230
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices have USB compositions which may require multiple endpoints.
To get better performance, need bigger CDNS3_EP_BUF_SIZE.

But bigger CDNS3_EP_BUF_SIZE may exceed total hardware FIFO size when
multiple endpoints.

By introducing the check_config() callback, calculate CDNS3_EP_BUF_SIZE.

Move CDNS3_EP_BUF_SIZE into cnds3_device: ep_buf_size
Combine CDNS3_EP_ISO_SS_BURST and CDNS3_EP_ISO_HS_MULT into
ecnds3_device:ep_iso_burst

Using a simple algorithm to calculate ep_buf_size.
ep_buf_size = ep_iso_burst = (onchip_buffers - 2k) / (number of IN EP +
1).

Test at 8qxp:

	Gadget			ep_buf_size

	RNDIS:				5
	RNDIS+ACM:			3
	Mass Storage + NCM + ACM	2

Previous CDNS3_EP_BUF_SIZE is 4, RNDIS + ACM will be failure because
exceed FIFO memory.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 46 +++++++++++++++++++++++++++++---
 drivers/usb/cdns3/cdns3-gadget.h |  6 ++---
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 1f3b4a1422126..62ea1bd773386 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2050,7 +2050,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	u8 mult = 0;
 	int ret;
 
-	buffering = CDNS3_EP_BUF_SIZE - 1;
+	buffering = priv_dev->ep_buf_size - 1;
 
 	cdns3_configure_dmult(priv_dev, priv_ep);
 
@@ -2069,7 +2069,7 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		break;
 	default:
 		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
-		mult = CDNS3_EP_ISO_HS_MULT - 1;
+		mult = priv_dev->ep_iso_burst - 1;
 		buffering = mult + 1;
 	}
 
@@ -2085,14 +2085,14 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		mult = 0;
 		max_packet_size = 1024;
 		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC) {
-			maxburst = CDNS3_EP_ISO_SS_BURST - 1;
+			maxburst = priv_dev->ep_iso_burst - 1;
 			buffering = (mult + 1) *
 				    (maxburst + 1);
 
 			if (priv_ep->interval > 1)
 				buffering++;
 		} else {
-			maxburst = CDNS3_EP_BUF_SIZE - 1;
+			maxburst = priv_dev->ep_buf_size - 1;
 		}
 		break;
 	default:
@@ -2970,6 +2970,43 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 	return 0;
 }
 
+/**
+ * cdns3_gadget_check_config - ensure cdns3 can support the USB configuration
+ * @gadget: pointer to the USB gadget
+ *
+ * Used to record the maximum number of endpoints being used in a USB composite
+ * device. (across all configurations)  This is to be used in the calculation
+ * of the TXFIFO sizes when resizing internal memory for individual endpoints.
+ * It will help ensured that the resizing logic reserves enough space for at
+ * least one max packet.
+ */
+static int cdns3_gadget_check_config(struct usb_gadget *gadget)
+{
+	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
+	struct usb_ep *ep;
+	int n_in = 0;
+	int total;
+
+	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
+		if (ep->claimed && (ep->address & USB_DIR_IN))
+			n_in++;
+	}
+
+	priv_dev->ep_buf_size = 1;
+	priv_dev->ep_iso_burst = 1;
+
+	/* 2KB are reserved for EP0, 1KB for out*/
+	total = 2 + n_in + 1;
+
+	if (total > priv_dev->onchip_buffers)
+		return -ENOMEM;
+
+	priv_dev->ep_buf_size = priv_dev->ep_iso_burst =
+			(priv_dev->onchip_buffers - 2) / (n_in + 1);
+
+	return 0;
+}
+
 static const struct usb_gadget_ops cdns3_gadget_ops = {
 	.get_frame = cdns3_gadget_get_frame,
 	.wakeup = cdns3_gadget_wakeup,
@@ -2978,6 +3015,7 @@ static const struct usb_gadget_ops cdns3_gadget_ops = {
 	.udc_start = cdns3_gadget_udc_start,
 	.udc_stop = cdns3_gadget_udc_stop,
 	.match_ep = cdns3_gadget_match_ep,
+	.check_config = cdns3_gadget_check_config,
 };
 
 static void cdns3_free_all_eps(struct cdns3_device *priv_dev)
diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
index c5660f2c4293f..f333c34b93ffb 100644
--- a/drivers/usb/cdns3/cdns3-gadget.h
+++ b/drivers/usb/cdns3/cdns3-gadget.h
@@ -1094,9 +1094,6 @@ struct cdns3_trb {
 #define CDNS3_ENDPOINTS_MAX_COUNT	32
 #define CDNS3_EP_ZLP_BUF_SIZE		1024
 
-#define CDNS3_EP_BUF_SIZE		4	/* KB */
-#define CDNS3_EP_ISO_HS_MULT		3
-#define CDNS3_EP_ISO_SS_BURST		3
 #define CDNS3_MAX_NUM_DESCMISS_BUF	32
 #define CDNS3_DESCMIS_BUF_SIZE		2048	/* Bytes */
 #define CDNS3_WA2_NUM_BUFFERS		128
@@ -1333,6 +1330,9 @@ struct cdns3_device {
 	/*in KB */
 	u16				onchip_buffers;
 	u16				onchip_used_size;
+
+	u16				ep_buf_size;
+	u16				ep_iso_burst;
 };
 
 void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
-- 
2.35.1

