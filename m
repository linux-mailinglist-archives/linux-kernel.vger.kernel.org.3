Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B92511CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243318AbiD0Qj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbiD0Qi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:38:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0743960DAF;
        Wed, 27 Apr 2022 09:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1NtpXxPTqafP92H7ZUUqK0pNipoMC3uvOX9q+K3oRt1C5qjOozqcKzc5d6V3zKPYgYgaKsp6Hn2WwoAs4DjRBSGaHPfbKDnG5a2agCbMg74NcX0kaNuP099e/Jtuez7tZtYLNM7tIQcbh9k6b1o6ubR1/YltNTqyxvtAHveGxM9XlKq5PD7KEJfa+QQ4i8NJ3CEeT+F/j/znF1KZLrs60/wZRBQgpn6in4HdYG9XLf7twL9/NO7xwziT8VZsgBOUWr6lHHv22D1Wjkc6Oezl1JGdNbyJJM7TZpmjS4WWC5AWua54Vqr1NpWT/vbV68CsmqILoPNgyZqWKKvZXnQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bticU8X+dFJwPegozhx8Ya2KlrTXZWJ4MV1edNRGOeA=;
 b=E/U0NI9w4b45VLMIzFElARzfp2kdkCzztakLvaGFqmMJrdPhCMuRs4XKQ+5fEv7aN1e+Yr5CWA6XNsDLFySEmAUUsqfyxRkBp4VdYEIqMEdxfLOLj2WN16NhelyFLYUxqJPCSFvJDWfcp6WJ/obPto+c6zoMg2Nwx3iYHeEcy+FxBjGscvkImQwuPw2D0lyKlrlu8UTVzxa8U4pIRHCbIBAjWmUfFEgqlMuqfEjAnjOSTvovmmfg4oHZy0x08vWandl4f4kLXwpA/0e3sZzj0RYXx/HenkwEEnz63ZfYS2nwdsMFkrwU13tFwDmlgJ7V6kB+2GJwI3+0Kg64e7TZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bticU8X+dFJwPegozhx8Ya2KlrTXZWJ4MV1edNRGOeA=;
 b=oDfEJQZn1iqKc7l9wpxHmcuntwERyoFSkbGBYJxfS9ilJToXhqWaFS4mix8tuiQLUjUlAhrfdLH287wG7ox7Eh7vU2iB8940milkhG2RCcQXfOqSWYe/eCSBlWwlTJFBGNpXYQshW2nynZCSpdIS4KaxUNy2CYN8SOte5W4F0Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 16:35:43 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 16:35:43 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, linux-usb@vger.kernel.org, jun.li@nxp.com,
        lznuaa@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/1] usb: cdns3: allocate TX FIFO size according to composite EP number
Date:   Wed, 27 Apr 2022 11:35:25 -0500
Message-Id: <20220427163525.1129887-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::30) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7487b25-b732-4090-486d-08da286bf900
X-MS-TrafficTypeDiagnostic: VI1PR04MB5600:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5600E17A49DCF633E6D079D388FA9@VI1PR04MB5600.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9NjFkrN4JvfsiANsC7F+EdHY250PbbYdVd42d5s8nwSRq+po/h9rlYEE8PMX1LwGJ0i8oAfW0VXFMJtNXSnYoYE1xVyynbOBLfwp/L4ZlTWlR67COF6B0zG/45U8VYEma4SOtcpxgw/w7kGFxu5AIU8aPcLfXuUeGc26zYi1/DwKpGnTzmAV+hlBngVLSif13aMLq2ZgpTHOJP0IjHDsaN9YQ8AUNPlfTEA6b9jsrI9ToAgqTwtnwp77WxgHmDu9v9kqcKRxea7rOn3j/q7Hs7qLpFPjUoDQT2Wcz5k2zE84SZtUCvzazWXOHwkpOOLxxfLXw5EpzYCcRpeiOrXYzdm5GcYpujiA7bD3tsd2BiNqzDNoJSRzxXHAaKKGDkW3defSEmiiqr+q9NzzQ3mdudBmjyN5C+fXbT0R8aohfOHeIIJ544ilJIcWh7utkd944lyTqq6h5Q7ln8/jqQK/bRBlKofsDyQYovABlYEKGF1MdcMt1w8bCJBvwsdM0d1UgIVSbkFzPPuoTnmMuvn9h+AKzaYxUwyIRg3eUc6GJyugKdE6RxBLPBfHEaJcA2nySykb9YXWOha61Rv9EqNIZr8cBlQpFxwOOEzGhhmR36cBXNd1OxtvEboKzcAFfoa7wB5M0Ly9rMj9fYjCpgoVW2+8P5aLM3IJMnJg+p06cXJqoNsEvqo5MOwldIGNczzPFedpv7MIFEd7bqbrTEbQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(86362001)(2906002)(2616005)(1076003)(186003)(36756003)(83380400001)(5660300002)(6506007)(6666004)(6512007)(52116002)(26005)(4326008)(8936002)(38350700002)(38100700002)(8676002)(508600001)(6486002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDObp3YIE8P5xP7RjO1a/K1dG9LMJIBu0WvAi3E6EhtzXiFrJegyLnwnqUZP?=
 =?us-ascii?Q?yj6K4+1MbYAfwattgrPC8W0rLTl07ov9j7ctx6brbyWwecF3REfc1ol5HN/U?=
 =?us-ascii?Q?QlPmYLlTwZ76Oa41yRw9YCm6L2lsAeauFaKojeOUkOt5pNFSrhTOH/NvYaZB?=
 =?us-ascii?Q?M5wrKYQcuE3YcDQkqyimdQSTeOPk5Ogek+sS2wDwPhUsL97VztBKRkgEI/eP?=
 =?us-ascii?Q?Q5nS9jb/ga9COgNyAs4hupZGy9jHzZ+/70vVQnsCz0CDC3OjHUK7BNNqnCyQ?=
 =?us-ascii?Q?Bqi3Zl6DN7DLHS1BWMEX/6rHdUeR0J9XFWSVyZBq/sHaqACg5wjoDv68l++Z?=
 =?us-ascii?Q?gKFicmiFkZ1ibk1RhUjROG+UsfyI9V1GQE/0z23Azab8tpzNoMfdAd4ojJpK?=
 =?us-ascii?Q?Da4VvxpobzfA8q7drHKI4OVrrFpzDPO/jsRGpQhqUhfVgaOiuYIk4lZlWTg5?=
 =?us-ascii?Q?ylOPWIiqeiHUQIoRz7X+A05I9mVJtoxd8tOiUdSq+tq+JAHZN0MxsYeeTmCl?=
 =?us-ascii?Q?C8OZDrwebIF+tjpWG/vulyRIjswXQeyvRG4xOeV+jwMMjvYHYCIO48YVtFxX?=
 =?us-ascii?Q?0hO7wYjTL7bBs/bXgEz0NzUnEXODdlgbB6HIHc7iPn3cGkAtlRp544ZxRUb9?=
 =?us-ascii?Q?U4mOiV38ynhPy+BQade8BW4O/fAh/ADrqMPrd+CE9e62JP6cl9tRR8wN84JK?=
 =?us-ascii?Q?7Sz/ulcdUk1E+7K6VbnVgIfRByAI528dM5oGlDR7uAeGe06hhIY0jxUova6c?=
 =?us-ascii?Q?62e1g6WqSiDEq0HTopB3P+axhfH1071077FFQmrbkLRA/KgngJIcTe2b5i1+?=
 =?us-ascii?Q?F6sbkqgVfGohtUEX8dIze39LBZgqcN6fA1Drvcf4GeAAuIGW3VjB21+HnPtw?=
 =?us-ascii?Q?ry5PEz3yoZ1yLzWBIEVGRxjMKm833XTbik263pl671lR+Qryf3RM6h3yjK+t?=
 =?us-ascii?Q?DO+Ji8xyJrEYmOZjhwQu9TACkZdE3S20WDIi33/mPYuivp/44HdNOQJG0tTE?=
 =?us-ascii?Q?EuzSIbyEk16USFLjjaif9xxK/WZuPM0tyg1cb6aJsLzqxEW4Zp472Q2Mto0c?=
 =?us-ascii?Q?rnGvycWFUkDg1W9DF9aTFuaR2U/AqQtJaBUGWvVfOzQpsl09znsQNw0ufSaT?=
 =?us-ascii?Q?kj6MXNW9TUjpIc3guvu36Scv2/4TM5Kj5bCSArBWQpz4gNSO9vpnzV4hBNQ+?=
 =?us-ascii?Q?tWfHKForTm6V2oqGLRyhLMhozsFKPz1FcbfOKPy8Uh6IV9U7D4xgKXpidZEj?=
 =?us-ascii?Q?rfJrfmpAp90vs2KuM9PafBOtvuaMU3Y5xekY46zx4d7tv3xLmcWbGEgIl54W?=
 =?us-ascii?Q?/w4xr/fGhefjdLmotZuscdR2um8nOZ3glaDOHO7UO3KDFoJp/CzqlQae9iUD?=
 =?us-ascii?Q?tlvN2T4I5CTVU3F+yRHHlsEIdy8WyJGd6u2E1NZuzTgqmoQPNx9G+Nlq/2XN?=
 =?us-ascii?Q?EIikx942lTY6Fnl2VkCeUqmRZ7aJmdOiq0L8KB9eh9rIO001YWTiGio/KKTh?=
 =?us-ascii?Q?NSfFVj/RpviK7JXpp/05VFvStAdMTXo8+MpOtgq7e6IZ0fBEaoMXDERQnIch?=
 =?us-ascii?Q?+OGSSAWSyfzLcue9P5RFYA3h1hTd1gLbV6akKsEJyQtB4ec8J9fXdOCSWdws?=
 =?us-ascii?Q?oGqmAEc1/NieMpYXSix/XzEPZcbsq3S3OtT52AbFgtVdK34mAvHIMLqC2u2P?=
 =?us-ascii?Q?rxYLT80Gx4llw8KD7XmIjBLMYiziHGp67gQMsA8VDECnceWkVLJ/x1iZd5pA?=
 =?us-ascii?Q?EslRtCDY0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7487b25-b732-4090-486d-08da286bf900
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 16:35:43.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2+Mp7jBeYh2uTqapO8Bo7BIuOgxmkshkYjg2Q5vcjkxy37xHalKEWG3/aNUKlV1B8UvH/0nohiDFcDn1tswVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5600
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
Change from v1 to v2:
 Add safe check for mult, buffering and maxburst

 drivers/usb/cdns3/cdns3-gadget.c | 50 +++++++++++++++++++++++++++++---
 drivers/usb/cdns3/cdns3-gadget.h |  9 ++++--
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 1f3b4a1422126..e25e7a2b55862 100644
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
@@ -2136,6 +2136,10 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 		ep_cfg |=  EP_CFG_STREAM_EN | EP_CFG_TDL_CHK | EP_CFG_SID_CHK;
 	}
 
+	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
+	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
+	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
+
 	ep_cfg |= EP_CFG_MAXPKTSIZE(max_packet_size) |
 		  EP_CFG_MULT(mult) |
 		  EP_CFG_BUFFERING(buffering) |
@@ -2970,6 +2974,43 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
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
@@ -2978,6 +3019,7 @@ static const struct usb_gadget_ops cdns3_gadget_ops = {
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

