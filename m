Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544444C11A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbiBWLmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbiBWLmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:42:09 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60055.outbound.protection.outlook.com [40.107.6.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C76240;
        Wed, 23 Feb 2022 03:41:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRdG0V1n9pyLtGiBw480aXXveAXs+ZPMwmJy8TWe3sK/Wjqikw5HUg6E7HhN/j5yvXJW2TLG91EDAdTPN77JNxXzW3KvK7p5+urp54UfzvmNUXKPhf3UD/dQjYmNlQ3fT1zwgbqJx54zBazHOPRmcwtMOpue3xHl6OFH/+lQDmhjWkslM2sBUaOzvq9LGZBEXRXfuqlBlGyc/sognfHU4GvfmLe3Mkrzm7kLlOCaEHhD4aey3q8Yx8aKoYxDr7l9RnC7t37AzlC/ZWVNP13ZN6yWbI1uIFBKm9KqnP3+3CGotu7HryxfMFcE3WO1P2FTEB5MRDM9ozJuITMrVC5/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDHOpRkvaL8TBkStfB3/tjhywB2nWYq3xxwNn1TQsnA=;
 b=DDrdTA3LWKK9ykOYFornVyLJ5qsOWG7LVWh5IS52hqqqMFdNI0CleW68Njldkmi2Qi1aGIcAJ1G0H9onlR9ba3Fwni5hMYy4CJ09z0TkJfZPC7lEGXuRCrGGD1MrBMGwz4H/lISI7Cs1iqN6lOl5cbTFkQo6MqtJNPs5oWgrVS0AJbl/HRLpQn6KU/qwON+iBbmuK0CNhTtZTGqN+iXa1I53qizK1qkzV/5MA2KRuUjYW1poQ8MYQCyAET9n1cGDACVo5rrluMekyxIZCapvHz2dYYInpWoY0QNIibBrX0NAUP57L5eAHffAQbu5mcR0Y5wX4w/e2TabbV8KvSmavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDHOpRkvaL8TBkStfB3/tjhywB2nWYq3xxwNn1TQsnA=;
 b=KNi9AaXEQhwys65nwQ84pSi9LAOJpdoyM+w9F8wpvPofwLhxJqNulmodyjOR7littBEKqi3vjlDLsJdGjJzmVFbsWmiu5kKsTiH4tL+vJC6Z5knM7Uj5Qf+cjtCYJlVzKY1nVT5blKLun84gT0rzZYEI6v3ZZtg+ZUj8Cxzomvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3416.eurprd04.prod.outlook.com (2603:10a6:209:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Wed, 23 Feb
 2022 11:41:39 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:41:39 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v17 13/14] MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
Date:   Wed, 23 Feb 2022 19:40:06 +0800
Message-Id: <8b847a49316208f9ffd6dfff637dcc6e619e0741.1645615976.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645615976.git.ming.qian@nxp.com>
References: <cover.1645615976.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0015.apcprd06.prod.outlook.com (2603:1096:3::25)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f001286-a0d7-4176-6804-08d9f6c17418
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3416:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34167A1A8841C071A0588E18E73C9@AM6PR0402MB3416.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KdJ3JnSuVkNk16T8FvQuZ7n08AAgmts9o6idMgzANY6RhzkFnZbfLS14vEH5+akubRDqDC9L1x2YKx3rnnQUDKI8tfDLroMoJYw4Xx7QSl7prRHYAFQ2oAiMY0DvIPSTHZh0PxU0Zw88oIbdWV8TxuqGNSwIAx14ZUi736smn1lbc6OTgVxEWtC3B/WYnAYQp6yV8c8D+jRifErsLAZVMChiZw1WZYEk8HIQUQDbtsCkx9HXtihlmhTEeB3W0OO29u4XnC0kbv71U6s6djVgZ7BaV/R8hiCNM4XX/kLShn/zqJ2Zg0U+Zehq2InF2J7gZi/gCK6QF/QGFbiWRVxt0FxYJGd6bxGD/gFGbZmYFr/LSV3GdTnfIC7dfB1+clZlxFKrR3FgqcALvQIEF8gq318nNvexPFaQ8J4ONdRl9dzyc5gSKTcqSVdnk32rQz1WhuQ+vkVZONnjaee8DmDvoINy3y5OskqCiGPpEG9Ty+oCpp8pnyooVYzc9BDaCxGUY68BUKKPnxMQMaz5SNxgTLt4fpFN33llw583FZPr/eT2tax0zSpuhuY553rGtHvXpojQmCe8kvFGvBbJUlsAggHXOyhMjNveN4NLHNPX822RhXehSyNzDD0K8X6alpgxbzDXRiwnDdxuxsCNdkLlIKTyl0alNzCJmKn3SCB3aA/qer8OSKNpeCSHIbVXB0AWTuJxDcUH74edv2rcenptQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2616005)(6666004)(6506007)(6486002)(52116002)(508600001)(38350700002)(6512007)(2906002)(38100700002)(66476007)(4326008)(186003)(5660300002)(8676002)(8936002)(26005)(66556008)(316002)(44832011)(86362001)(4744005)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wjQMi+YORnkhJqvD4tCPARS8Zzvr4rnz22E8zxgtY6KOLqxwZ7ZFElP3ckS1?=
 =?us-ascii?Q?FMZkzZGpGMDSagmm3MQO2UwFe3vLyxF70s5EA7tEqaVFXtYSyU6dCdoOMsfK?=
 =?us-ascii?Q?0Own2wyJDH0Tih58kA0zbj+FB8ypSUzlvdB5pRRvmF14rLDPL8H0sUrqehu7?=
 =?us-ascii?Q?osXs1HxsvGyUBnkhz0/4w0xcOkFG6s4xG+mVgh3pORq0Bz5OJ8+NpflHEj7T?=
 =?us-ascii?Q?F8UEXD3rGVCoEu3UzuETjDphJjvo8Qeh5F6zcrL3ueD7zEVOrw1ycGDNi34e?=
 =?us-ascii?Q?HHjU1+M98fZtxPBv9Vi2/SmflBjNrgI7rucFBmvOmkvW/D1wEEBKzJRlHnjK?=
 =?us-ascii?Q?/VZl6XoFZVfqGPbaBQBdu0ukRPzftND/vTNmfqllFRa4bqHpQpjckxpMTjIb?=
 =?us-ascii?Q?IuWRBSY6OdJCH80j6/v1GWgXqZ0aemHshJpnWqoxJuRCpIbXiGvQ8tglPQ+P?=
 =?us-ascii?Q?k4THNlKXa5dTQvSzUKm6hdwn7GBYOdFFAnD7iWR2LYf4yhEygOh42akiPrEB?=
 =?us-ascii?Q?H282tQGvvpt/jiFhfV+9UFu01rp5G0PCHx9zqU7E1oAgRuAeBl6q6Gg7qyqk?=
 =?us-ascii?Q?WMwsWOrrxQ7wYxDXS2YPO+zs31vAdX0zBZFHfJiau5smmsEgr1H+RPax7vH3?=
 =?us-ascii?Q?12Ivx89bbRAhC0bsZhxN85q+lFZ/n2isvtpfbBX5OjKvuWNTD5ZG2M9NKcfn?=
 =?us-ascii?Q?ZMQ4kUwblKGC/wwk0HkQEIyaJMOFCWF7gimLWWmtfuuf1ootUhPhMOmtSseF?=
 =?us-ascii?Q?p/P1GpVgNEq9v8UXdDUTMNQ7WnUieeqzgoVxo5hEPwKmo0gHSJM4qwTHHC1+?=
 =?us-ascii?Q?hspF/GwAk2NFatNNFcUeuKSKplt/hh86+7v2Aud7rnhibQmkZl8QnLwHnwDE?=
 =?us-ascii?Q?M1JpDD/pqSoBsUGCRGYDW2GyIgNeRz2WEUCgeuqjIwITRZLenMKa1U78DIM9?=
 =?us-ascii?Q?X1Ge+f2Ypk8DmMnLKmjlt/OYYqaKP2kHRh+4RzjzmCGd+o6em6PX8v4Aaq8r?=
 =?us-ascii?Q?FLGJzcVUw1nkZz5nCDeCFfAkJ1D4yNGluwXb9u2GU07/e/1nN9ALnqA30abn?=
 =?us-ascii?Q?fnpSaqg3AVLf2DgLweWJs4LETCUpzv9CYf3hhjKN6TjA2luwkuAWRrR5jZlL?=
 =?us-ascii?Q?fqw7B+toGpN+YQ7yk8eFyporNzUgAcZ0mFDY1p56PX4X04IVP24y6XMttsFk?=
 =?us-ascii?Q?BST1GQc4Fz5rR+NCoTRj2FPSf7kwlaGZgauWka3SvZbI6/fQckflAJrjujcv?=
 =?us-ascii?Q?G0crz4cnBQbxItDigDDontKPQn9ssrhW/XG9CMrmVIRZnEw/vPUIBK46zH6R?=
 =?us-ascii?Q?H+p/318ZkYDrz9oQHS8RidheLPr7MjBuzjfp1GWRIfMSATIHBpU4kuJItLeb?=
 =?us-ascii?Q?GX9eXsvnDQe8f/O8e984aOGiATJ5ZLosREyqrn+MHz3nUUfJlVkEUMrLOGmE?=
 =?us-ascii?Q?WX8dDKn3mf2kpZm8F59xPuaXAkv7VbrTpkkUwvfSGV+r+ti4LpUcU6vIsapd?=
 =?us-ascii?Q?KcaGLHMFGHxmHbZdAeUqcvEC9WU80OPiCa/RLDe6ukW0DskGWLm1IPfmn6Vu?=
 =?us-ascii?Q?RDweREIuWxJ3t6xq6twZGjpmwSrdBmsB9jWwuBnBkepw+thmoIf+mNv2Ir8c?=
 =?us-ascii?Q?aGceYkcqQ2dJAPcDUIQq++A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f001286-a0d7-4176-6804-08d9f6c17418
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:41:38.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohvAii1kzSKpkWFpSdeiZum27DqZ1V3lkGuB1frmLa+/mL/IaLNzFDBC/ed1/A7XSwd1yW2n1NSdhdiXHtvsWA==
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

Add AMPHION VPU CODEC v4l2 driver entry

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83d27b57016f..80b21f36702c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1030,6 +1030,15 @@ S:	Maintained
 F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/
 
+AMPHION VPU CODEC V4L2 DRIVER
+M:	Ming Qian <ming.qian@nxp.com>
+M:	Shijie Qin <shijie.qin@nxp.com>
+M:	Zhou Peng <eagle.zhou@nxp.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/amphion,vpu.yaml
+F:	drivers/media/platform/amphion/
+
 AMS AS73211 DRIVER
 M:	Christian Eggers <ceggers@arri.de>
 L:	linux-iio@vger.kernel.org
-- 
2.33.0

