Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0055202BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbiEIQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiEIQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:45:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A3854013;
        Mon,  9 May 2022 09:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef5qTfDvCJMohB+UNxXGwzFcQKh08bHZUktTaBICR7Li2jJahxOi4ep1/73il9SqD1xt6SuXvx6jPwzM23rqwpDzwC0BlG16eCFiW3/Bq1eHPQmaEFfDUeHjJzkhlfxDVGIYTqawW3RGs9I5JuIzn+kNacvMKkTN3sIj4RTJIHoQxM6sviEhJjuNVYOPsD6ASFyTkPVIHOoexSItnITQv+bUIhCm78ZGSTw6sxXT/km2EgjCY1ASQ5EgA5jFgVBjU71agEQWxwkPtjmQzR7tL/Cxp1iIYIb0s493dHAXB+TJG0KAS7PtdciXT0V0ebh+W1ITFcyt7n9Yic/o4WbLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhNgtt7JVGvFDiYCM3LgFsIp1HcivVW40mJjzaDmmms=;
 b=OIgjbeBh3h/Hy35Fbbp1mYvpup/Ou9LDKZpT6xPrsDnLzUlb5gtcIATJYbue6RX4sf74xDSI1qjcCNPbY4nknkL0TIOCg2WSkvliXyd9cpDOmrWz+X6Kd+O+0qeV5CfWqaPdl25OTjh9KdjU823WjbDoAY6WK6KsinvENMr68jMVksamk9abEHKAZ2B+qEAzRRHXPEfJ9DkBE5RKzHfyhzl05njaf5ZqJyuI4m5Dz6RfELH7q/4nh5kWAq7z6kmDiiilyj/sbC6a+3S7XnEvDJM+epH7JynICnmhcr2mhqeCGD/fzt0s6BxwdxCKW690ucLZxVl418ArBw/Q1gtp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhNgtt7JVGvFDiYCM3LgFsIp1HcivVW40mJjzaDmmms=;
 b=nFuLeRKsqmeJ2LX71Iz7zvDLtymIF4xmMLE2ZmAba2zNUVCT0ceKKInxWjBE4tplvbCpdOy2RuVQ0rnlDp+jlCD0eh3WyeH8dLCcyuboc00GeBQ8XhbJD4/8LlfJT8SsC6+nAZZaIUFi0yCm+L+a7PWMHkGCrds1/8/lWIEZ0Xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 16:41:11 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Mon, 9 May 2022
 16:41:11 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, linux-usb@vger.kernel.org, jun.li@nxp.com,
        lznuaa@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/1] usb: cdns3: allocate TX FIFO size according to composite EP number
Date:   Mon,  9 May 2022 11:40:55 -0500
Message-Id: <20220509164055.1815081-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41d77c54-7e9c-4731-8483-08da31dab99c
X-MS-TrafficTypeDiagnostic: PA4PR04MB8029:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB80292CDF515540893FDC391D88C69@PA4PR04MB8029.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrRpIB1JnxQSan4dvGzCPmam3ESYjuhf6Aa0r7uXMVBgrO+j9aoik4PP1VH8ScvlXPOIq6PewgGep8Bs9+IxpZ2MK3P49r46C/1o3BUcx61sN5uD+Izuf1rr99+2OfcttrIPbfzl/ZzNmCbdZvb2w443gF4legnY/eZs9kjC3ZGuhLqcZLSIdQml0BTEBIZH+Q/ZE2e4B2Yly7KoCYms4i5fjipxSw2vpHt3gPjPqu5dWu7hBTq9Tho6BQojb9oCqozngi6uqDK6CH0TKBwebdtl4kaECXVz4gWlTsJQ+0SQqxvat3oQJVZxWFhuBwdnZd/7PFWlqSAXLsVLvgfDZsBV29RJcph3a2CkJTEpRWfkaMSyua6XyVzRCU1FOnD3Fp8snM7R6vllTe5MNIGo04VLJaCp1yMMQgkUiBDXABObafbt2lmecXRy6YyPCKsrASSHlBm4F8AEE2uw0rWEub5+NEFxi+QCYPOU/kdrC+f4oe7CVTMzSfvfAlXuCOWP+FA7KXT7GZicVtZk30ZDtGcV1WNv58m1I1GHopzg+QCFjzYzYFA5swN+ITZlu09+F/tNFfqpymc+vSrnonNWK7/pGc6T3GbGG2sgZlqDI2DTNAfyzOCcGf+nc4VDll+wM7vbWMhGHcDoDA3TCeCywONJNLmFZVbqsKxRadIc/wr4iwcajk7MeSxrM7zuIFWJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(86362001)(6512007)(186003)(5660300002)(26005)(2616005)(8936002)(8676002)(66556008)(66946007)(38100700002)(38350700002)(2906002)(4326008)(83380400001)(66476007)(6506007)(6486002)(52116002)(508600001)(36756003)(316002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zPlfhmnqA77Z2+PjSHkee5naWUotxyMScMlfDjxHfpKWfKJjH/X20v0dMM9d?=
 =?us-ascii?Q?dJ8NJ8dp3QddGUzO55VjFSn1BuxhbwaApMGC64WfLD6fM1or//YkwthIwBJx?=
 =?us-ascii?Q?cF5alWmiUGxRRHm+WLWrf6qQnD5S5ztxogOsRQYXDMB0JhNsOcgvnhq8rU3A?=
 =?us-ascii?Q?eRcHLL4Qap3K2MlHWIPYBM+uP/sQU4w12z5j2jjIM2Pk7CTfvzCHKpku0+5N?=
 =?us-ascii?Q?7BJhUc9sA6VQB4DWuUSuOFcm7cijYxAifDx3HJNptX9Ms8nacr9uMwuvIfuX?=
 =?us-ascii?Q?hzMO1ZfDHWTll8apcCoy6aJM+q4P9FrnwexfG4f0ox33RA8lLy4N7SOV7is4?=
 =?us-ascii?Q?L5N+mcrFHAVB0CYWT3htBIBRmVFjpONbC83SACmylXSZWhbk9VX14xHIhcYk?=
 =?us-ascii?Q?LnUTVMrmb9qD1wdlWq2boFV9DVk2RHlZ7fk/oZD4GH6NDGIwJEt7UeyMDjFQ?=
 =?us-ascii?Q?Ug7fAq+Ix7krrOwItNYTjwbFqo6YrAK8w1z4TJb3kOAIQbgyR/UkcQ2is7Ju?=
 =?us-ascii?Q?ULnkE6D91zS7gggb9V08P7jCTTxJCDKJ2zMk7N7MBflSu2+ER7AKOAtBj3ab?=
 =?us-ascii?Q?aN3E7yhxO8jlwTGbY703tLP9hLe5mVl7mjPfFnzHOyUVKDx6CJqGr0shcluI?=
 =?us-ascii?Q?8nWWvR/yR5/1At4nw6xSQyt/fSDJCGSNAgM8Ou03Khh/4QlrZLaxzg29W/O4?=
 =?us-ascii?Q?TXRYM67yLkPeWroDjV9KAR4OvC7Salbj/TNuXTVpJ8nu+r98hd/9rIkQZgy2?=
 =?us-ascii?Q?l9OYy6uxuvA1e0cLJF48DzPfecw3HvSfhsMC67+B7tHbXeR7ITO7YzUtw+6r?=
 =?us-ascii?Q?8WdtcZSEb3nqJqZZZ8RR3KPn2xJqEaUq0v+wrjV6bg1gcGkuMcNG+zqE8XTF?=
 =?us-ascii?Q?nGJA4tGQwsQDU0q9Lg+PXxo6QC1N5d9iU2/otimbXo0bqARDhqrM1LmZVzgY?=
 =?us-ascii?Q?+MEbGEyxmgYElOLH8fQhqgJPNyGPC0dtU/BG0MYxIp1icKYk1M7xmmkVyCfZ?=
 =?us-ascii?Q?OOOfUIdtaztqVnfKckSWe2kul2X4CFaHK2T5GLJHrNAkwZBkMK3wH9540wZq?=
 =?us-ascii?Q?ATiTjujTzPlgE9F1Bd2AJsyJ6o1MXcsDKbH8zNP3KjCwmfw948dBWmfdNyiH?=
 =?us-ascii?Q?sDJjs1JjM4ok2QkR6OWhKZmTWKtKWJzbwoW8kjXgufWzVF2Iq3b568wcQ7HG?=
 =?us-ascii?Q?a4hdoGjfJASGUuExJimp/lTTozYdfCV7jYQfYbJVUFVYx3GyiyXUIm5HxhLW?=
 =?us-ascii?Q?gt9GK7vNGJeTXT2jSAnfstrUTzgUxBiDB2z/1BdyCZjEt8z8ZifbAFu6MkLy?=
 =?us-ascii?Q?Pi29mkC4ZkpUTSXlqQWFbksuhSr54yVWjSoUpWYQId2AhctF6CpLY6Tim0iY?=
 =?us-ascii?Q?5ZloaySMFE4XGqT+gXMs+PBEQSzJHJ739SxHX/CI52+G0UIer/dzHlitsrt0?=
 =?us-ascii?Q?aGkKAkB+bEFBzekyrwlWkv4qSSIOUZ/Xo/Uf/PGI83qLJjY8Kssk1CHzxwMr?=
 =?us-ascii?Q?s/sfQehO9TUKnzpzkPkYEDzvUn5I4B39efrG4+qFlP/oJe/oOOZpiBEuXfuj?=
 =?us-ascii?Q?Eqf2z4XvcIpXIhBLIHe/qP70P8Scgug5ywbokxqhNcbHU5a0JwYjdcxbXfW7?=
 =?us-ascii?Q?ffssFlW4JvJq0/9hOhicObAvtnFEB3WCu7EVA7rK1fWptFbnRMFfC1FzAlxV?=
 =?us-ascii?Q?DRVBCTpp2u2ldDl9avZ7nOPYR0LKTWI665Oy2mJCyCVejZBMXfWaldagTAN1?=
 =?us-ascii?Q?1hNXDDX7UQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d77c54-7e9c-4731-8483-08da31dab99c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 16:41:11.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kxl0uHR7a/gWXdSfWQECFvuZwwW5BB1ibRjyKohcAhL45U/FQNQX4Xu5bskjnHDBUOQSccTZqrGMihVL6QdCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
cnds3_device:ep_iso_burst

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
Change from v8 to v9
 fix typo in commit message
 move max value check before cdns3_ep_onchip_buffer_reserve()
 remove priv_dev->ep_buf_size = 1 and priv_dev->ep_iso_burst = 1;

Change from v2 to v8:
 mistake pump version to v8
Change from v1 to v2:
 Add safe check for mult, buffering and maxburst

 drivers/usb/cdns3/cdns3-gadget.c | 47 +++++++++++++++++++++++++++++---
 drivers/usb/cdns3/cdns3-gadget.h |  9 ++++--
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 1f3b4a1422126..3a3f323d9ce79 100644
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
@@ -2107,6 +2107,10 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	else
 		priv_ep->trb_burst_size = 16;
 
+	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
+	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
+	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
+
 	/* onchip buffer is only allocated before configuration */
 	if (!priv_dev->hw_configured_flag) {
 		ret = cdns3_ep_onchip_buffer_reserve(priv_dev, buffering + 1,
@@ -2970,6 +2974,40 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
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
@@ -2978,6 +3016,7 @@ static const struct usb_gadget_ops cdns3_gadget_ops = {
 	.udc_start = cdns3_gadget_udc_start,
 	.udc_stop = cdns3_gadget_udc_stop,
 	.match_ep = cdns3_gadget_match_ep,
+	.check_config = cdns3_gadget_check_config,
 };
 
 static void cdns3_free_all_eps(struct cdns3_device *priv_dev)
diff --git a/drivers/usb/cdns3/cdns3-gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
index c5660f2c4293f..fbe4a8e3aa897 100644
--- a/drivers/usb/cdns3/cdns3-gadget.h
+++ b/drivers/usb/cdns3/cdns3-gadget.h
@@ -562,15 +562,18 @@ struct cdns3_usb_regs {
 /* Max burst size (used only in SS mode). */
 #define EP_CFG_MAXBURST_MASK	GENMASK(11, 8)
 #define EP_CFG_MAXBURST(p)	(((p) << 8) & EP_CFG_MAXBURST_MASK)
+#define EP_CFG_MAXBURST_MAX	15
 /* ISO max burst. */
 #define EP_CFG_MULT_MASK	GENMASK(15, 14)
 #define EP_CFG_MULT(p)		(((p) << 14) & EP_CFG_MULT_MASK)
+#define EP_CFG_MULT_MAX		2
 /* ISO max burst. */
 #define EP_CFG_MAXPKTSIZE_MASK	GENMASK(26, 16)
 #define EP_CFG_MAXPKTSIZE(p)	(((p) << 16) & EP_CFG_MAXPKTSIZE_MASK)
 /* Max number of buffered packets. */
 #define EP_CFG_BUFFERING_MASK	GENMASK(31, 27)
 #define EP_CFG_BUFFERING(p)	(((p) << 27) & EP_CFG_BUFFERING_MASK)
+#define EP_CFG_BUFFERING_MAX	15
 
 /* EP_CMD - bitmasks */
 /* Endpoint reset. */
@@ -1094,9 +1097,6 @@ struct cdns3_trb {
 #define CDNS3_ENDPOINTS_MAX_COUNT	32
 #define CDNS3_EP_ZLP_BUF_SIZE		1024
 
-#define CDNS3_EP_BUF_SIZE		4	/* KB */
-#define CDNS3_EP_ISO_HS_MULT		3
-#define CDNS3_EP_ISO_SS_BURST		3
 #define CDNS3_MAX_NUM_DESCMISS_BUF	32
 #define CDNS3_DESCMIS_BUF_SIZE		2048	/* Bytes */
 #define CDNS3_WA2_NUM_BUFFERS		128
@@ -1333,6 +1333,9 @@ struct cdns3_device {
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

