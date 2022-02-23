Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE474C119A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiBWLmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbiBWLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:42:07 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60055.outbound.protection.outlook.com [40.107.6.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C024F24;
        Wed, 23 Feb 2022 03:41:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jenUxAQhwuADaDUfXdJUDGLWWtFzJqW07DKI6g9OdTW6wFOFlGP9ufDQc/JSxSp3B4Q1G2ahgidJW3BgfaRuyucCad8DkX6GErUzCQQCD9dPNXJS2byYiDk9t5ZmKr2JKOw/1yWGSU2CuPk+uN024F2WO3wGcyi+tZvg1AlqAAU7HReTzbPdNFkNSffsqoILC+oaFUMWF42Xu4EH+H+45XefxsC+4hu/6kedAVfzm91iWQ1kMz703s+jipwESylBB6TNGS+C1yRXdE3neSUkHN9qYfninEmb/Ypz4SfvkdH7nOp3vvxvi1ggqLNxaSRCixpm6CO4Y3RiMnKM87PRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=fuif9bCoQWXOa+iiJAAtshzvQgxkpnWMWya02OcYkPx2Czd4KKi3XAIIawHdzQv4Bi3DAnI3lFD9QyQHVlFHEeqJyi/JuejJ3Bddg44FK5P0T9scYVWDqF/qddAhHV8xk2MEyiVWR94gRH87eNziMPjMb/NbmOS74xb024izlvk68mggcJTTEmijbyf6Q2nBF8eDh7dfs6MQYWIDtWvXkEw5g9ExGYLWnzxh8EGyzWpqAnJo+Re3p6BoIlXvaMhJOSOGD29BwQhiSyn24iFeFtdqqAq+yuHdfWrZ2uhaLTP/6tWqJmBaApvZPKsbOcujAf8JOYF5aaolhb/zgsiv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=J1X/wn8/PqjZOedZXzUiRV4G7pClO2sZHbtqouD0SrjgvzfgbJsV3UCQRD5dFSqDs7ZV6zw8Q+jfQFh3IWA2t4FKAkeekrljdZiCoqCqAKFQiYKkttYki023kN0XAGdJI6rY9ZdFGo2Mnevixl7ZiMm5BB15M6ymRM76ofa21Zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3416.eurprd04.prod.outlook.com (2603:10a6:209:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 11:41:34 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:41:34 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v17 12/14] firmware: imx: scu-pd: imx8q: add vpu mu resources
Date:   Wed, 23 Feb 2022 19:40:05 +0800
Message-Id: <b4421c76a69b7192ba434af0d02d3300b94d92cd.1645615976.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645615976.git.ming.qian@nxp.com>
References: <cover.1645615976.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d88b845b-bbec-4257-3f87-08d9f6c1719e
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3416:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34164AFD63355CAC2C0FB923E73C9@AM6PR0402MB3416.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gDMAFiibwaJFVY8GasVUOS03WjyYrMvGlyT1L0fdStUl7v3pG1Kg4OHyU0yCmP0H9CuhSKM+CyIYjhv3P4TKB/2BUg4Sq9DVpWsbNdWjROmlld6CzEEWt0pPnz38kgTG8kapVlk+CIbWaK4OLFWP0z6qv74dnp6qeOEBJQyr/361przmAipKXtHYh7tdd9BH/n++2f4TKCwT/IQwC2XD0LNjZwBoh6aL4dHvD51YyQ5Nq/GyDWQb1aEtmDDaugDbWwEiuw8xYOBsWycA6cuquAkNei5tMa6C0JxyZMzm9JILFXTJ71GbuRUArQpbkMo2Bev5GLOCHMUdKHwXDDsYgQg69cwFffRl3snFcv4zyZqS6/bgPUnsT30T+u5oRUlAoi8F7/6kyYBhhCuCcN3RljDAMW6M8yL1D+QJarUx5xOFhRfM6xEB0EuAWCCQbMQwJAhtShKtLqzjaZJJELrpUTFpAdeDtAZzJuiIpUKKgBFtZ+EDSlPP5N82S0uDfkRrLLMYrRFr6G71tL+f6iSfGUfYIJ36G+izTN6s7XRQGpPzYO4JROxf7Sd2xip589p75Y0z/SEwzeoMEU6LUWr+GDwbZKY3knjMMIOKlV6Mi4Dw5PCIu+O58PqvJwZktw8J1FHb1WkXyYupsMfSU2HFRismTCCa/6jE0/KP5chXT2a/ADxZMAbpUQT6cK6RQbk/Wb11A6YYX6xcWtRSufW36yiDJYVmevSJSSpaWLSiiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2616005)(6666004)(6506007)(6486002)(52116002)(508600001)(38350700002)(6512007)(2906002)(38100700002)(66476007)(4326008)(186003)(5660300002)(8676002)(8936002)(26005)(66556008)(316002)(44832011)(86362001)(4744005)(66946007)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CxMXkcYoGFaG83aYgVFdEMduI/Q4QTQl2Z9alf0chDL0VIf7FO+8voTLo5Mx?=
 =?us-ascii?Q?4faREaYcZvA+7dCs6v55nRDz7PS+idCC2T3mmOyAhrSkSESMiQr6gAL7nB8j?=
 =?us-ascii?Q?PJivi3nl0CPtR4Ko7JcbEp01qZTAL83Q7XvsqBDz+xrvpBMp0QC2zBV3SnlW?=
 =?us-ascii?Q?S528BU70VYorRa615mQLFPKjYMoFpGxmjNO0XWjihZ8iUKNpSH0gZV/pYaEy?=
 =?us-ascii?Q?rK6jRwU/yx/E0O6lTqjXU2inFUd7ACrxtYdHX/SIf3Nywio8aWU8JvmY+8WB?=
 =?us-ascii?Q?u9wskA09g4hLCnHxND/+EYt6ODyYAAZdIVQIcZyC3g/tLPYba3fc9D+uv7Or?=
 =?us-ascii?Q?/3lskTNq9lxtO5DQHFJxJ6CU8YQEsdQJ9Wz2+GU1WfpJ3W4OV/Vfswt9BgxO?=
 =?us-ascii?Q?Efv5GhepdbkMV8vMeurJGfiztYDnDZBAfR5SZ3fmfpDjKOmGt1dJo7IZGyX4?=
 =?us-ascii?Q?8YZnwU3UjGCtiKJ7sJ+6JcUAx0FH0m5NF3+46K4watQeMwONEpxhbJIAWW+s?=
 =?us-ascii?Q?z9cQU8PwmbWSCP5lzhlpKUAd02PJZ5xXQTRIXPZ9di/4Cir9y4VI1MJq0C3B?=
 =?us-ascii?Q?c34h64QdTC03/GLafpJBR1TYMuNu/49rSQDMIy+ncjFa3hdSlWzCBYgWS6k1?=
 =?us-ascii?Q?DvuyFmp1Q+i4A4QwyWIsH6bP+on5AkzAkh5Hz+oGzt8yNiD1TCdS1+nPnVdX?=
 =?us-ascii?Q?4n2juwhoP1CnacQuFGhiV2Hoeg3ZosOqGdJZo6QU5N+7ekSIZ2gOuvCMfWHV?=
 =?us-ascii?Q?95Rn8j8zW2J1IFjo/ZyHQybrA6pLYHGUG+UyyD75yZ3eprPRBZ1907BiCzaY?=
 =?us-ascii?Q?TDUj37KENdpKP+uqNoO+ZKyVv48BAOu8Dpqo1RTEf3VqucUCrl7Tc8qoHtQG?=
 =?us-ascii?Q?FTq7JylFhZdxTD+kNIWttLRvXBaeyV6AC6GeyX9O0/cVfMlT0zSfnd7kGx8p?=
 =?us-ascii?Q?0rwD9ju03aMVEgT3qco6zogpWYpQVcs831HYl4YxyoApl8sl7yjhG6QMkGoI?=
 =?us-ascii?Q?t6GLJYfcB9/3c+zbYB0h7GtF1cg2o5JthMd57doSUXSChV3e3sDTws6d3FrA?=
 =?us-ascii?Q?FAWqsHblSbgQd/QmZ7b6nOoJwvAYeSclNX1/shkE7bY2VRkx2jglSWlaui07?=
 =?us-ascii?Q?PiOTBoQiwZsu/u9u4J83Q7oa66Q9Uql5CltepTqTXRJdx/oIxjEMP8k3OCdD?=
 =?us-ascii?Q?F0tP0bhzqgtpIzgmQBqY/DFzs5OFxPr3OyW158zCkMAPCuxVJ/B2/2LXPrO5?=
 =?us-ascii?Q?1+p4eILFxb1o8mwKHsUOb++mOYwVvhV71+zwH7RfBPYeH49yp4csNAcAGx3F?=
 =?us-ascii?Q?7arTINy88nfKhcFPLoEsuGZIe+tQh6ufWK9CiwBZtwy2NBcsImcf3An+w8Pm?=
 =?us-ascii?Q?q5lDGj4xkzY5CdtG2PkNVjLcm5JYWYijF0LC9S04JhTL+dnKTChq/kp9pSFc?=
 =?us-ascii?Q?Nuy+MZ+beFiagOUGfmfuB3PC9BAKPjl4c3hhNSpVo7eJa9Ht8tomfD7ZQGgT?=
 =?us-ascii?Q?iWfdwaTJs77x/JAyZnJ2rIvGWbl9hjV9HdE9rlk8ILMXibnBikfHIvQjx2dR?=
 =?us-ascii?Q?q8gGmXoX2Stzegt1Oza7P5skj4Xoi3AoZi3XcsG0Lk0Rj9pz7G25+yYJ/XGM?=
 =?us-ascii?Q?21J/9x8qfrSNtESAaoLyzTg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88b845b-bbec-4257-3f87-08d9f6c1719e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:41:34.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9zMYsy1n2maPswqXOAXiTLeQI57DMJICkf1Ui/hXOfUSBNHITrycOoIuMmoX7+PL+CRmRQkMaE6DUAwDKnzzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the vpu core depends on the mu resources.
if they're missed, the vpu can't work.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index ff6569c4a53b..af3d057e6421 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -155,6 +155,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true, 0 },
 	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false, 0 },
 	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false, 0 },
+	{ "vpu-enc1", IMX_SC_R_VPU_ENC_1, 1, false, 0 },
+	{ "vpu-mu0", IMX_SC_R_VPU_MU_0, 1, false, 0 },
+	{ "vpu-mu1", IMX_SC_R_VPU_MU_1, 1, false, 0 },
+	{ "vpu-mu2", IMX_SC_R_VPU_MU_2, 1, false, 0 },
 
 	/* GPU SS */
 	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
-- 
2.33.0

