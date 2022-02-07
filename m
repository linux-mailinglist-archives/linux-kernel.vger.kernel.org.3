Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA54AB34D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 03:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348542AbiBGCGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 21:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiBGCGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 21:06:40 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D35C061A73
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 18:06:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLD2MXJbCtJadoiUwmyJgd+2Rh4WG8lAc5iKwpGEV9YyrTBuvOZXWcOyK196gMM8onRiwwIpU0/yJdgcmlbTdtQhmQ8iZ8uhYKqM/cIgnmdo0ftrY/PpeOxjOaLJ12p1v4v3c5k64K/iVdWeEBgvLcTzZs7cQ4S3mCdvt90xMhXmnRhACJRNotDJNT4dzohjManSG7Ot08VIa9rAR0Jf1shPGmGWi8qKF+n/yJR2mHoSVaE361pOSfmGFEnS94cGobiQYx3UbP7FK9/YEON5El8Ci5XcQ6zp/NvIfYmY1cmMwl44qegEf7qpMNZKqq/c4dJ1h2sghHynzObgLVFAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5+vZGhPSDypf4UcN8LwI2iM2cH6oyW/XRSaQ86djOA=;
 b=MRVEFzswg9BlgLxNah8Ae9ImFRyQdoOQEADGIAcW+Hq4kqA5O2J3yQgCb8fJ4hK5V3l1API3WdCmn9XVfjkEhAu374QslfWXDbEZm52tqfwP1N45nqPcII8Fp32dXhTUFccyYtwO3bRIzf3miGoZzLG4UQQYTDnYt2HGLIrwX8a6TsT2Y6pVmGAdZ5kPzpRUcZp7LcafoyAN05QknSpLMQfO1QzjsyUsyxNj6X4JThshRiXJ3jFHP6FvPCVIH+3gSd+VsJFk/ny0qbtGWGCGHgGxEzNTJK35391GFgphWg9cx2WP34W1oGKNIPIj6EpRAySamvkMy3BV31TTEb34gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5+vZGhPSDypf4UcN8LwI2iM2cH6oyW/XRSaQ86djOA=;
 b=Cx2xEj9UJg6WbJFURSvxzIa8ldWs+YTn/tVtALYcZ04I7YXddC6Hb6dUvCAcTgs9z5psNtroScJwtZ+TGWk9hIafhpqVVWPY0fik7Oz4u/2E0IZLS5hfsiCITdF7yHwXjl27cbtoEeoStfxrL4IjofUopVWJkzcb88Fw6zsW64I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3462.eurprd04.prod.outlook.com (2603:10a6:209:6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 02:06:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 02:06:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] firmware: imx: add get resource owner api
Date:   Mon,  7 Feb 2022 10:05:40 +0800
Message-Id: <20220207020540.466670-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0097.apcprd02.prod.outlook.com
 (2603:1096:4:92::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb3c3e35-fc46-4c25-0871-08d9e9de7798
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3462:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34627F88ABC28839F1F48210C92C9@AM6PR0402MB3462.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHaWtLPw6yagBke+d9F9MFv0+tbDVTUtVEwH6EnK4yH0PuPE1CQXuhhelaIJlRDtGjIUq5mdms1PlpPlAAa5L9wLUCKc0AY0KVCWFS03ZCcRZNJsrew0LWS7BxS23XInzERB2AC2Uf8I7Zv0pbTk0FEbSoNDbVzBkPJtqOUrEkcdmoMZfYU8QqFvxf75sQmXN+NIcT8vGAWMguNFl9I184gXgqE3TYiv8BYyZL+GtYU5b698DGkawRSNwXaH1aouezqqWSJ5pfQT1DYpywnRcMQlJDCJxH74Ez9qLyyAPVt1iXdyH5xxc8VyAe3meHhimjDry5aGIxORA+GAJ4h4rkltbBdPp5hF6/lPkor/N+yg2pHJ7Fijr8TUhlYb+wp+AbncBHCC5GF59YH9YDikORjKHnopGlCrjXhlyQ2s2/RZu9O9lRsyf5WF/U2k6xtjxQ34bv51oYDIA9GENp2QT+2Gw+LWiVO/nNV/WqO/WNFNMPSeRXXeTlvgDkRKlFO/P5Oa+npHdLEQgaMxy+AZR6rnFd1HfgEHF8ndyz9Glzuh+zL1oP29xKnjX53WpmW6TDASXmfIjMkAgnO5VaQkN7NB4tRc7g00XP8EKe4eCvxAKEn+RFO2MulOA4RfQljQuzzp97rXmikvlBoRDT5Svx1MQQp6xyCrd+WtRvwMJPofXgYk0NFQnmQi+WEp9zIAu1Hm6WSBupf+GK5qPfS8pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(2906002)(186003)(52116002)(26005)(1076003)(2616005)(508600001)(6512007)(6666004)(6506007)(66946007)(38350700002)(38100700002)(86362001)(316002)(66556008)(66476007)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3XJGpISvBHsLAkNKy6nAzdCD6CCymatKMCf2hXu/EzshwMst2T/81aE5yOLK?=
 =?us-ascii?Q?+/hWPbJEvr8mHdqq21aBGLtBQ1CF3f/RlgVhr3scJllISagRemuL49Gzrrkq?=
 =?us-ascii?Q?hpckT46YZ7s6Y0TxXuyo0byH92btznl2ugwUxnjadPEWa5Uqa4KeDHUFaezN?=
 =?us-ascii?Q?RHyzNHPIVz/1NaYJhoQKXFK6v1dLicnjUxHRG0mYdp3LQSzoNuQe6ZGxklv0?=
 =?us-ascii?Q?6ScYmUQIBMrZcFwt0EHsohWQ5KzXw0E7SgIjEQURHcj3muAunYseeMpGuz8N?=
 =?us-ascii?Q?zDBO8Y+VPyfJy9R1GEOjz9Ru1SARz+RInYUHW5iZJ5bULzBpYqnu16hM9bq7?=
 =?us-ascii?Q?cBq6dRVoQD8qK2HXFm7VWr5OZqeWTE24+yTi9gByZIy7RppcukqpAf+Ga7If?=
 =?us-ascii?Q?c/E3HrlVObphIz46gPI6/VGvcu3VG56ashC3RjWMrqI2K7BH5Uu/aYxJBdkq?=
 =?us-ascii?Q?l0hiYlsN+TrO6bdlzatIJ/NdBcq5fgkVC1LtRJpKvCXeiaAfN/l7s28am0Ao?=
 =?us-ascii?Q?oXa9C/SHLLQjsCMOWI6u3d6QkiU0/RA8qrOUjluz9jDWNICx91J7uayya9eQ?=
 =?us-ascii?Q?edxsIW6cVWyCdQYHQdR+ioALEnflutyWy4DDHA9YPHBot0d1Q2L+HbCgg81y?=
 =?us-ascii?Q?IKaTxOLC5p0GB/YyLZUIaMWmCuk0knTGbo04lD5ZKaXvLdEMHKobgcNVlxoi?=
 =?us-ascii?Q?GbvhiqQJw8plko9AMJ42+N27tNXClg2lAoftJfCoO8/R7dN8YISvJaAV9Jk0?=
 =?us-ascii?Q?pbBzksDfwkYwWve0mkpqsq2rBH4kizihqEkYbIoznV0Mwqfvjdjv5zAIZd4K?=
 =?us-ascii?Q?JLVRw6Xrgtfp8lV5HhY1mkuPxxgQ1CUq1Joi2PbrFSARVIi9Z6Amh/TNFQSr?=
 =?us-ascii?Q?G5c+UP277IY+bNC95kphPxP8Xd+sjXEB89dzqUUBPm3zZseC47S5kg9Odlcc?=
 =?us-ascii?Q?rr5Yw86LS2rScbvmKwki1eGe8UMSOL2mk5sHezD0saY4CGHIX46CSrx8iE7u?=
 =?us-ascii?Q?jeFiLM8mGL0lyn2djNVKu4jMi+14jMx8skYE0OfkWgtkpuNkdFMagsV4UxcA?=
 =?us-ascii?Q?Bd3kVApjBQ7/LW6m1/57iKLo+u/Feuvs+CXTXy3tCHvf5yiVfv7xAh2chIZ9?=
 =?us-ascii?Q?KwrdbPU+Gc/sq/zJ5BoqM3w7jhcr1UzZrXk42kY9cTzZEN12jVlk9aYmp3WT?=
 =?us-ascii?Q?1ckh0vUG+/5ht1z1qQ6ZzkVrAtkj6m96/gRGvaEc3y6Vtc0JLvPKcFgN58dM?=
 =?us-ascii?Q?VYs4m2Mezn4n/13m7rMDqGVqPgN4hKBH3viE4PxHUPvbst7GuKbZ8ISeFKAS?=
 =?us-ascii?Q?3xJp/+Es344EfG81sXRuahI2dVRwFQVqa8Hmwmw8QfJgad6X2y5Zp0omd4QX?=
 =?us-ascii?Q?3VS2ZW8cyA9Ifh2sYjlwhjjtwoHio4VwlthyYAPaj5MxC5lvQiuoyRPrckgx?=
 =?us-ascii?Q?pV1DPZFk0VGRtxfCKMffZcfozIfspxlo5jTCxLGT1NL5JByy2DgfsPkOE2rJ?=
 =?us-ascii?Q?v94oHC4wh+HhdvWulxH6J+KqOn/ErtOhhhF3dWFzZdcl04JWken++sMc2Nn+?=
 =?us-ascii?Q?9mhv6AWX+oj9EbFD6Z6qGLyN6/z/fVRqUtl4m1NJU7kxIFx2P8bB+y+4sap7?=
 =?us-ascii?Q?qsutY1UyRqxhrbolu/htNNU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3c3e35-fc46-4c25-0871-08d9e9de7798
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 02:06:35.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +P4rULn7+SaWf2GSw9JNpTHI+f1TOLe2rkgoQpHyrM+gbugJxbx78MYqM4bMyRkGY2aOvjRxcqHeIEcDy413mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3462
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add resource owner management API, this API could be used to check
whether M4 is under control of Linux.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Put comments just above function
 Use EOPNOTSUPP as return value

 drivers/firmware/imx/rm.c           | 45 +++++++++++++++++++++++++++++
 include/linux/firmware/imx/svc/rm.h |  5 ++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/firmware/imx/rm.c b/drivers/firmware/imx/rm.c
index a12db6ff323b..d492b99e1c6c 100644
--- a/drivers/firmware/imx/rm.c
+++ b/drivers/firmware/imx/rm.c
@@ -43,3 +43,48 @@ bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource)
 	return hdr->func;
 }
 EXPORT_SYMBOL(imx_sc_rm_is_resource_owned);
+
+struct imx_sc_msg_rm_get_resource_owner {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct {
+			u16 resource;
+		} req;
+		struct {
+			u8 val;
+		} resp;
+	} data;
+} __packed __aligned(4);
+
+/*
+ * This function get @resource partition number
+ *
+ * @param[in]     ipc         IPC handle
+ * @param[in]     resource    resource the control is associated with
+ * @param[out]    pt          pointer to return the partition number
+ *
+ * @return Returns 0 for success and < 0 for errors.
+ */
+int imx_sc_rm_get_resource_owner(struct imx_sc_ipc *ipc, u16 resource, u8 *pt)
+{
+	struct imx_sc_msg_rm_get_resource_owner msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_RM;
+	hdr->func = IMX_SC_RM_FUNC_GET_RESOURCE_OWNER;
+	hdr->size = 2;
+
+	msg.data.req.resource = resource;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	if (pt)
+		*pt = msg.data.resp.val;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_rm_get_resource_owner);
diff --git a/include/linux/firmware/imx/svc/rm.h b/include/linux/firmware/imx/svc/rm.h
index 456b6a59d29b..31456f897aa9 100644
--- a/include/linux/firmware/imx/svc/rm.h
+++ b/include/linux/firmware/imx/svc/rm.h
@@ -59,11 +59,16 @@ enum imx_sc_rm_func {
 
 #if IS_ENABLED(CONFIG_IMX_SCU)
 bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource);
+int imx_sc_rm_get_resource_owner(struct imx_sc_ipc *ipc, u16 resource, u8 *pt);
 #else
 static inline bool
 imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource)
 {
 	return true;
 }
+static inline int imx_sc_rm_get_resource_owner(struct imx_sc_ipc *ipc, u16 resource, u8 *pt)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif
-- 
2.25.1

