Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A176472642
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhLMJts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:49:48 -0500
Received: from mail-eopbgr1300138.outbound.protection.outlook.com ([40.107.130.138]:17849
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235850AbhLMJpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:45:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLSZK+5EM7bW33qkGC51cSdsPdzRDh0r+PoZxufHq/IqBTfuhzrVkI0u9sTp2FhqxIUUw2nto0hsogcLJ/fKAz50rPXqc7WRlssiKkR96O1CWBjtt1+QuiwiD4UM3WLvAMaCOWUOib3Ias2BlJdPNKS5WpzOr8HPxdIwLTRmNUmnwNut38q3EtP/DNhOeCCZhfaZyv7vWyyh78h407gVxhWITUOA1YjXNrTaku0IFgRpn1/javpQwkp7UWVi4UlNwz1d76MSqAbzk5QvthOzMNdcdmE3M26khBMyEbUe+ymZFmdAA5wIYnoSivKBhTIJHf6KWwC+f/npYMKb0+zQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JoimoGWDCn5E1PbBE8PyQ8UIPUhFR/3oefqRqzIvAs=;
 b=d3dsSNlpcMg+ikSXkq/q+jAlYt2G/2prl5qFT+S9fK2twbpP0MaAl5OEFFUY7jZMaLnirLxApalPcAmozzu8tnsctAmHjTt7yGikod6Am32m7+qu2uuZzFVibqTCuIhCqg6HXCy680x4EKSRe8umNylULYvx1Xc1aRxSxT95cb9loq7BP4NvL94Og6VjzRpzm837NbeB3AxUNwzuige5gr2H9eOvQfFgpw2cxyjLYPMRdWWdwf32cFfVsY2bEb7ZkAsbPq/JOur+EVjQfBu0yYBHl/QHK21qKwoTp+lZR/vvjRmtSNZk+Z+Dd8cthTIUVz881x9kIvWPJvCzDN+vvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JoimoGWDCn5E1PbBE8PyQ8UIPUhFR/3oefqRqzIvAs=;
 b=VxC7TlwLKJrwdZHtwOqn3emsXhZfFnYzE7XPkP2NsFPt6XiDFSs23n+t9e4tAI5Dcz+Sv9PaS02x77Pb49hO6kLuF5iyUwOIlEXt/BMiHzJxU4sP88lHc9f0LA3TwNoa0DXRyAN1jNPs3dgYnnsTV6C/sQs7o2X1B9w9zrInNcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3050.apcprd06.prod.outlook.com (2603:1096:100:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 09:44:13 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:44:13 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mailbox: mtk: add missing of_node_put before return
Date:   Mon, 13 Dec 2021 01:44:05 -0800
Message-Id: <1639388645-63897-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5e65d9e-d6f3-444a-7885-08d9be1d1ed8
X-MS-TrafficTypeDiagnostic: SL2PR06MB3050:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3050EBA68BE1CE02C81F440ABD749@SL2PR06MB3050.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbNDqE1oYVVWpxNMMrqx+Z2tcHGUUBBmDkuO66CB3FbHucLqhJApzlf2OdE6Bs1rr0xwPpAvOd1hL8gn0SVjBXNlQeLs4JnKJnwqF9KjLPVtrrXtxl2h24f11FHhg1F8HObX2W/ZaP2BTGX9HWZKKwxsYNs4R/O+xBNhdRRKpuExYF+5WKX4WgpO2r1Cvjdi/8ViOcMP3i3HFNCfyNNxupBXZWj5/YAQHms9PJMxoLN46lP1RI+vCw2zSmiQnONxgkx54CnTvqWW/8U7TN9p03jWpLiCO/cpOLTOiuwmY/hiQE5pWhWxBvzCcc0N3e1TjvXP8QZSCeWOsVhU2vRzch2wt/0LWsX3bevkMgsLkX54OIRdSxmRmPMPZLPkAOqxeMynj+xqN0A8nHwgXDRMQ5yJ6n3HAuMHE39djM+XjaFARDalHne+z60GbaXdk8SvYg5TdP68cgnS7YyYnvxrt/wroUaB6v0J5sVTtIWrPfIrielQFaaZQ4MItnhFETUWeRVNoK1PpfG2zWmqvdu+OSqa4Jooow/xEv5WIjFwNjrBuD3Vh6Crc8iaBDCNaF27mG6IdG6pAMiud2OvIqdrTB3ZMA2+4MRu65CDrXVbEVf5mPkF89BM5JaGY5qIU3tb0p1OpyDVLFIlaE6FdtW8mT9KO/nXinNk+z11quxWyHG/9MRjh5rFVjZU3ll3Z1khKY1K362rJjr5d1H41C1lWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(52116002)(6506007)(110136005)(2906002)(316002)(508600001)(15650500001)(26005)(186003)(66946007)(36756003)(107886003)(66476007)(2616005)(66556008)(8936002)(6512007)(8676002)(4326008)(5660300002)(6486002)(38100700002)(4744005)(38350700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6bnx9WTFNWP9n9y7TRjqIAjZTpFQJWkv6qAqqbfuTEVpefS+lFNpRx810fnu?=
 =?us-ascii?Q?k2orKdooZVrv32TeC4ZpatWYSF1xUtkYi1z1eM6lncymBMiMWECzx5HoKX57?=
 =?us-ascii?Q?naNn/oFmme2vy4AjRd672N/Hm3aSO6VLdweWTY/+2uIW3pU9xqjXc2TtIChD?=
 =?us-ascii?Q?UPF3mvJi27S6hLaGInudJ45gHuJlvLKZPgppHT2jHgh2TJX5+RxlMZFajW/z?=
 =?us-ascii?Q?wJKh2AkJ8VoVPHuWbXsw6P8+MRMOoseSpV4F2ANNqICJVDEBg9rDBt0cN7lf?=
 =?us-ascii?Q?Dmgl0rHA3j2F23LQPrIqXLmYQLaF4aM5CbAU+Cqi5Et4HiZNuAYYBelJ07wp?=
 =?us-ascii?Q?yYbdJZzASqkXKwyN43wf9AC+bklCf/O6byG2aFixzklmhko6gLdSFQd/dqSC?=
 =?us-ascii?Q?CI7O2Er4UE6VRVUYOXnfo+4wWwLih+ax/7IGr+I1DdPSZHredXLsebIhf61T?=
 =?us-ascii?Q?QPvTWCteeZbogUuCwaXNMJFawL9SxdNGWPuI5jHL5cyTJDhXqYat0Tom/Et8?=
 =?us-ascii?Q?ACvYsLHFEpEB5nIu0CgbFTeaN63Q1YoWGc2tTtIBJRnySMqTah7koXOL2yCR?=
 =?us-ascii?Q?Y+6zb0HtPdceuFmdlAfzLwDuovacFFsBDFtBJjH6SRzsszz7pAWvtms4ctA4?=
 =?us-ascii?Q?uh6ziQs//YRfHDEFUddeIeB+pfOjNvNnhlW29XCnzEGvpxSlni8O4ufvl+IG?=
 =?us-ascii?Q?vVmtuUj398Q9WJx8Gv+Du1Pp4NyNUaw3mWwpCgUxDugrnOy2u2M7M1UylMlX?=
 =?us-ascii?Q?a2GGJTNCTOuRwQKLZEsriUvAIig4pRNZknecQ62UOQIvBSfQUx206rHZDtwU?=
 =?us-ascii?Q?4fSqhkd5iIp7taNcGELe4xckMfSC21yKitaLKDkFTVWh2V26yAdMFUYGEzPQ?=
 =?us-ascii?Q?PMvC6CHUXhRykfbUA5nwjFBDZDi07D0d+WNTK6jn1Z8hY2G3jtKC3mhR6jlC?=
 =?us-ascii?Q?i9NqXXrEl8d9es/J7LFGVxbR7oQPNeH0l9/srCtAeWEYXHTY7AEPLv0EK+9r?=
 =?us-ascii?Q?oVm++TRqGKcSGXkIgE6xPqz32vV0tPIQ0JHIoY/fSkstKV7jhikA//mZ5RVV?=
 =?us-ascii?Q?QOK2F/0FUFBRVMKV22k713gudDaYfPxd7hfFhaSoMTm0XpnoXk3LQQAYG0Bp?=
 =?us-ascii?Q?QVoftMyfsUURgWioZmyv1s8u3A7hKHi3Hp9ZbU9aAb4r8MdgOArsBVOCt4a+?=
 =?us-ascii?Q?KR1WQN7EskgQqggR6Y6BHwlyDfVur9dHSG1T7kJy/e7WTm8SWMWXOcpro8tF?=
 =?us-ascii?Q?dnpBsmdi0+7qxWPwa2lOpgHSVKBCWmB/dtapOk6AWXSNg0ZCpnHkkcRYqs3A?=
 =?us-ascii?Q?JkfHIxN72w64vHvejvbPArpZFD+9aOAApiCfG2agavvtBzjQSSJO+1RP9B5I?=
 =?us-ascii?Q?MJFFP/6rmFvY3NTWZ4rXnjITKytXQfmYlsLFN2Jls657LWsnKxg7izTnkqcn?=
 =?us-ascii?Q?ZlBvzBjYYBlKMR6gImtgVFwukbUTk738ytingxF2e9uB0snFjzbZlVDtbdA5?=
 =?us-ascii?Q?eGehllQucTWZ2bpOwHksc37OYmnIZqsDslUGDcfFwHXgJ3jnLaIGn2C12hYI?=
 =?us-ascii?Q?+xFFSpAUdgWgAqszfq8IbJRT+cqwqITvWaZkahMtqY7EKf9y0esmptQK0Ixu?=
 =?us-ascii?Q?DpTISVKz8Nka36Wrft9yPxI=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e65d9e-d6f3-444a-7885-08d9be1d1ed8
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 09:44:13.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWcGWbu4kP8HHvWviTz20wb8stnEK6i6T6XtJUMgN7PPNIkEMINCjLp05P1bIa4jIUuUjixw0LxTkHi3Lh9/Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Fix following coccicheck warning:
WARNING: Function "for_each_child_of_node" 
should have of_node_put() before return.

Early exits from for_each_child_of_node should decrement the
node reference counter.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index a8845b1..03abad5
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -573,6 +573,7 @@ static int cmdq_probe(struct platform_device *pdev)
 				cmdq->clocks[alias_id].id = clk_names[alias_id];
 				cmdq->clocks[alias_id].clk = of_clk_get(node, 0);
 				if (IS_ERR(cmdq->clocks[alias_id].clk)) {
+					of_node_put(node);
 					dev_err(dev, "failed to get gce clk: %d\n", alias_id);
 					return PTR_ERR(cmdq->clocks[alias_id].clk);
 				}
-- 
2.7.4

