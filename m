Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11C248A63A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345524AbiAKDWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:22:45 -0500
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:37763
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347685AbiAKDWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:22:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8jD9UYTbaAJemQasbfENJWdCVZn5tvvXDNTZEXI4i+0Rgq3KuD4dY8yPurAzb56U8tq4x6n9RSftG+d0WIwZHU5peVZb20YuC8ywilCFBM+1Zb5h8d09S1+9toevyfq8oDZYrOZiE+h6vwMhWuM61g9DjQVQGE1HxwSX86ffmV9CBGab2CW4AD2fOERTor6EDFRAdQClgFzHWedImbohJr96x+C8srJhQ9TSb+UOc2+7hG7sRCEau6oIMRoKSRcNHEoAzf5zMHl2FHPytud9jsqYhrZScHse1lIleV/7gvRwN106A+1yU14l1HyRWQhAvOHbhFPiNoJLAfNYXbz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlUAa4RbC5UDTb1rStHQB/36BSrXbnNRfl5gPx9YO8o=;
 b=B+zmixr6lRkTVTxHeVI8Mv2Emg49/S6+Gr7Yr7+BknZRPqVkTn3r1fEJrcJyRGu2SdDc6lFQtVhvbomoyTHnyux8+ibQVp3kUxQcRNzIJRwRWP+DmJBoqCTugx3efJoFA2QUCwT1uqqfLanAbwn4R6a/WvNumgFx0zxJZKQv3jGuX0x/47Ad+8jSS2lFkTNbVbz7x4czaH/xTCkUgbM1rotAzkdksjsup4dUovCVc5XfBzLCat9MB84rzc4QOF9uwsgm+vVywv2H+xAAMIQgyEjRlDXr/8bDEm09NVwY/DJgxNA9vXkO2Qk5oxt6pk38scylBcffmpWXp+f0H45GHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlUAa4RbC5UDTb1rStHQB/36BSrXbnNRfl5gPx9YO8o=;
 b=UJ2FKA5NmfYr6hSxRpzTb3ORCDP+Af9+l2Fpx12SpkipSf6OHJLnLWsGPTtfpHxCtpa5N6mZ4g5EADj0iBJpeJ4v4KGNxwqgLXbP7L/IwV2bKZABO6QIepZuYFLC8nBKdfN8fH5wQh39njtHGfrzvL2sCE21knOopCPmDqekvc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9465.eurprd04.prod.outlook.com (2603:10a6:10:359::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Tue, 11 Jan
 2022 03:22:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:22:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] firmware: imx: add get resource owner api
Date:   Tue, 11 Jan 2022 11:21:47 +0800
Message-Id: <20220111032147.342012-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1efa9075-2a50-4256-0d22-08d9d4b19eb4
X-MS-TrafficTypeDiagnostic: DU0PR04MB9465:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB9465D8578B4D723BC233F587C9519@DU0PR04MB9465.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rVee21NR97R5OMwWT7ZxcGVwq7BHgY2vSIgSksLZOg5pwgSwRwIw3m3Clj7bnKc0IO5u/577uxtR56HizPQbkX0RqawpAAWwg7VxE6v1KrKhPddNFntEIU0/uuWadAamHIN7YhCYI0Nu7AF1gqa4OIQvOdeimm7on4UgOLYfU2poP256LkXLoD4LYuWxkjP6jSa5dfAYogaFDoCVQgb+roCg/dS58nm1QeYt+4U88uRXbYFup4Y3c1wpxYc4cbuTRcQmhx1eAFXB+yXn7zafki8Q6BQO+4q3ODWFne8ccUKYbMXFyaEWM7C0v0jJkrEJiY6nx2sM2xoVo6lEgM0/ISJJkf2nmOuBXZ9Z/GIZ323daHuoy/VPjILbKlTOGCfNiA4yUa6s9BZBN+tnmxYkUpXaIkUce2R6VilULA0JR4POhROzAkQ7ipHAXlX8ORXBmdEQqud2XtCAvv8fXvQ/d19fNCi4L8bLyl31PT/4bSrzPurAmH2CGPPZQYIQ63pYdN5DY9ApFALQUzXGcyfwSbCEsOk1IxEoFsRmXCXeoOcUGlXtW+KQPha7ADpJHVC/Y8OccUCPQE6n74mMoLO08DE0h+dFMcPEST4PdidbOy1YbbnrpUJ0dP1yD5qURC5+X+cBWoYhVdO7WAKSAiG22cP04yywWvgndqHrHMRML2fInvhy861g4aht9zr7wcOV3KaLicY3XPJmQej3PEgPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(8676002)(38350700002)(6506007)(6486002)(2906002)(52116002)(86362001)(5660300002)(38100700002)(6666004)(2616005)(26005)(316002)(186003)(66556008)(66476007)(4326008)(6512007)(508600001)(1076003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecfh4c8NHul2/1qw6/z5wta02rUh6dEbfIEgrdJEzow3tSzpwp8UdIT5BpnC?=
 =?us-ascii?Q?RnqopfEqWJCRPiB7rBRC6Zw/Z9PX4CubesBCYRpCB4p1t3KJ2VA381/QXEA5?=
 =?us-ascii?Q?jQBe1gkOcMb0oWiMQmbvF23QXK6/+74AQtmx+0nLX6crNiEJeCo593ruMUoD?=
 =?us-ascii?Q?HTcwzBqGGr820v/51hglOGOPQP0eBqvx2UQOmjaCIHohMcsewNuiH8SJkKQn?=
 =?us-ascii?Q?yloNw91fT5lNm1o5uAyMjcNrU2r6cue2w+04dTRBdgpQ4KcKtS1fkcftE4Hm?=
 =?us-ascii?Q?QqX9Y39XJgF55cdix7X+rYzaic9HCunar546QnhVXJoc9W1aF8uYsADG2fmG?=
 =?us-ascii?Q?UB0DtkIhXjZ9HI8qV1WfEfo+XsXNhM4JB3E3b/EjAmAtioqJiR3guM2z1ofo?=
 =?us-ascii?Q?9iHuaYDPrMQGhDS4NkncNDSEstqxiaesxP5iStTI/QxqZUspJCd4NdQJVYAw?=
 =?us-ascii?Q?WFwR21DwvR8QLJRf4by4qfKSWGICJysW1aOTuxw8hw8RKRBsFIwWDAWehAY4?=
 =?us-ascii?Q?AjtVCv1UMj3VMAIeiyKMjlddTb/4x6EA7wwpGsAXMMT9iNR+BqxWrLK1XjzC?=
 =?us-ascii?Q?5a5pyHxlILDtCKfwTUTBKM34c9bJMkfUYiSTV9+jcpBn8BSVfnzf6zj5OIHk?=
 =?us-ascii?Q?oCWwCgX7PA4qnlR642crX6IfzHndEn/HLiPhnwDFoeTFlF7aHNrLBUrV1Z7R?=
 =?us-ascii?Q?I0VfoYA8IcXjfwcdfeFlfynWm1sG0iF1vg316HfNEONnlGxcCgcTsqin1Kz8?=
 =?us-ascii?Q?S+JHi7p8T1JFWG47Ups3AEK3ChO9M4rVlbxRCrO4k1GtQMkSi3Lg6s3YDi4s?=
 =?us-ascii?Q?5HmwxMrzReBdfDWmPud/2HyYzuWi7OITuuBgbGMFr1Qz7vGE7ypx6pAHJ+II?=
 =?us-ascii?Q?pLgD+jWTEpU7B94nZFFhlld/FoHmVlrS5K/mJqMIj+efp0FNgMD7ZoXijpVl?=
 =?us-ascii?Q?6VdXebq0CwqPAIuqY3mbrkhVjiO1/k19f+VjQ7mtDYG4rP8LzObfCEVbCCiK?=
 =?us-ascii?Q?v+HTE3y/Yo8PUYzPIsLC2qNRJbBUW1m93Goj6bv8ZazO5EdASGngtTBOhjx8?=
 =?us-ascii?Q?lrpC2ut9EHYWHkgia0tShmeWPKq7yMVjFa7we+6LxvTgLzDnbeM6khf3d0ci?=
 =?us-ascii?Q?QY6VfjiF4x5mG3u+WShXQZf0PWz6TI54Z/kQ6XjJ3iDIHtOe77pAcenla47+?=
 =?us-ascii?Q?8BttgpkH1mWsGHG4KSMkmr6nQT8DJlif1/Ub5gWmMdaapup+6JVaS7//RYWF?=
 =?us-ascii?Q?JqD2ooe5EUdZBAPmatM0C2pO+UPY0ZU6y5ba9/OgTtM9tb9DPLLc21rcxQSf?=
 =?us-ascii?Q?EUkD56ehiZonSkK8XQuT1yYt7OJyGJ270M/d4mLo1K8gerR/JJhbnU8MENoE?=
 =?us-ascii?Q?ahxkndeuxFqDZLgiAL8TNBdLl4jzHRZMsvwhF02rpcX4Kayrlck5s1yECxJW?=
 =?us-ascii?Q?BRI1hKx/Wcp4oqOxZ4FUAqZvPjrV+2uro81E71/POjC0Y/M1CVH1bVdK7YQq?=
 =?us-ascii?Q?sFULzBobM/Vnr73VJ2Jwbpf2z0kmQQKzM1QCcO6QH6cLUcc73kcIvWSZcB9M?=
 =?us-ascii?Q?BgpLZhtGohWfqBzgzqi7SHQZE/PF53MeiYXCVjtiQoxZ6jAmIHjE93tu+pRY?=
 =?us-ascii?Q?ioI92zSIDyJQT3yGLp2cvuo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efa9075-2a50-4256-0d22-08d9d4b19eb4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:22:38.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDBQ+ZqzRqcwSQQRXzCb8XXt7GZERVYJATmQo6+QAwf5R5oD1+hLMBTz1ZeWpCMraBLhUR3IUle04wmJDJYtHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9465
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add resource owner management API, this API could be used to check
whether M4 is under control of Linux.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/rm.c           | 45 +++++++++++++++++++++++++++++
 include/linux/firmware/imx/svc/rm.h |  5 ++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/firmware/imx/rm.c b/drivers/firmware/imx/rm.c
index a12db6ff323b..3c3605f98123 100644
--- a/drivers/firmware/imx/rm.c
+++ b/drivers/firmware/imx/rm.c
@@ -43,3 +43,48 @@ bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource)
 	return hdr->func;
 }
 EXPORT_SYMBOL(imx_sc_rm_is_resource_owned);
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
index 456b6a59d29b..ff481b23ea36 100644
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
+	return -ENOTSUPP;
+}
 #endif
 #endif
-- 
2.25.1

