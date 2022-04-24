Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D282B50D1E9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiDXNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiDXNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:23:09 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A839C5D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 06:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKQp1op0HozZ7qn5YpqaKs4Dxu5FbYZzL73C3uCjmw2jIwBhhF1ZQs6qBiY55fPhqXN4bZGYSoBMclM5P4dWQTIyE5YQpy+NVbv6J0odqj5i6S02X1AS2hLrkkxBBZrFhFZXUqArqXgK5Kwa3hl2T3Cp0ha9rMxYDLT+0foHACnOtZTWsd9ZeInpDg33a6IT84ah9Rk05OWot49wK7F02TXt3JQYk6bNoQIvuaW3hmEUEHHoG19rifZ4/Y2qte/3aPxDuPzDHIuPcZNShellDdq/iIZIlNbBAoQuyGTrSaIby6bEaXxHP8JSQ9PvYk7oeohm5ZHMd7X9vBFPv5kZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j72QUG81ZvZP+V3A4MEKyVRMzhK5U1NPZEO5k0otDH8=;
 b=eOvA48fjaWn4MjQlqo/wVDFoqQ1PUDDzPqYoIeHOf6yqwQVrN/UGoc1cJzq6tlay75mJRb2bYZQAFCWmXc8+KN6RKydoR+9Xp2GwWaSd5zNUwxEW+zG9kMKIvMjUeW4/76ou35oIhIddq3uHroSK5t5xzObefc3q80CcbigWkTdJsN2bnpdZKjMNlrtr5HYJTK+XVWn/+jGvnr5orff70Zrvp/XXKw1aHch8GfizvNXH5b++X483BFiFX0qKGIzqIjGpayoj+3tdLeJW3E+bZXrXhMAWjdC+U4v+JSBxcK4L7P6iqCSLMR0OGgXrsCuBt28vH1RZyCQuQDQmfw0c8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j72QUG81ZvZP+V3A4MEKyVRMzhK5U1NPZEO5k0otDH8=;
 b=oH6AoIV8wAkfkEhQkbp7/rceYfWLg9FUDitslOysJQ/qKoDt8QcTgRbGq9PkAcNyQsRBzECcwYzagrJ/VOd26G69A69jtTvjPblbbvsAHYtWgoBJjicOvkRYQKRlhmCgjzCfQb0mOLS/ls40uY5kaUpi2yee5011Fkj8ePSKGUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2419.apcprd06.prod.outlook.com (2603:1096:203:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Sun, 24 Apr
 2022 13:20:01 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 13:20:01 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH v2] trace: use WARN instead of printk and WARN_ON
Date:   Sun, 24 Apr 2022 21:19:32 +0800
Message-Id: <20220424131932.3606-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211207091843.0765fa3f@gandalf.local.home>
References: <20211207091843.0765fa3f@gandalf.local.home>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cfd1917-9fc6-4a94-3671-08da25f522e5
X-MS-TrafficTypeDiagnostic: HK0PR06MB2419:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB241957B457A2DF951BDD9236C7F99@HK0PR06MB2419.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdPVTxD5O4T1U3Dlah+pgAapEKCGyoqx2bmGzcpnlelIV8LnhdokpX0aRuwKIPXbUOmGa47ljrI2spbIwQ8OzCIKQ/haSq9Lblqa3OYVsQGpY700/btMpbIggnT78NLmfRK517cl75zavcHFMHIaigCGZ9HubPs6jgoloTPZ5SvtBUj/J3XToQRbpZoylLC34mQ+XCNz8imTQ44Hi6s5OCiY+qqPnWMwOFmlpvkhV57nx3AVB2rwEjIKPVj9n2MnDoA1g2MhTV/OM6UUkE6c4fflUueiLmVPcuLHaCoLznRn+NfYJT6zI2rR/4QYhjTzdJvIIjkEtnfi2MY6eYQAik9DLhTmmUfYt3SwYQiXGyxPwJC9sh5BVD6ltpx8yH+PjwlKOwsn/XZf5LBUYwqmmNS1E+/C65wLdFTE08h81wpypwOrg4yunv2f1biAkAN6vW2cFKa8lyCcM07B8CxoU033Fb0aRcJDg1G9UHujf0qT0olkOFwwLI/PwnQ2F+o/Ygi8+LrVZ9ima6tDfkBD9EEwE4NaURHD3PIrEi9IovqjOtnNxhmIFwjyIxer8lfHXQz2QGK5E7HJMUgNHjH1fs15g6oPHqAMt4HsWirqqBcyDoEdNZhxcJaVN6fmNPY8X/APF+DzY2d4qv0D7mm6bQIM6eq0A+OzSpl3OXxbLApNO1D622u17p1KSR2cvBLMacD34UTQUtDOz55heiA9sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(508600001)(66556008)(38350700002)(5660300002)(38100700002)(8936002)(66476007)(86362001)(4326008)(6512007)(6506007)(8676002)(26005)(110136005)(52116002)(316002)(6666004)(1076003)(6486002)(107886003)(186003)(83380400001)(36756003)(2616005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vd2QL03uhqD/SPZWT1D1UPHF0QO9OEd5cffJ3/Z3905i1htojhbkW8bdct70?=
 =?us-ascii?Q?rWfcyqjQEiQK0w09SvoM8fmmaCsbpH4a+BKm1N50VRdBARrCTqCkdTVuSJLD?=
 =?us-ascii?Q?O52IbRacTScSsBJt/KpG+LRuMQzKar3owHubWLP4Bd2C5QLhEeDSOjy2FUc2?=
 =?us-ascii?Q?pJRueFEYFR5fwE/SI/8bg4VE0rRLscy3TJnLK6Gltn/0R+9N0qhPhzPimDP4?=
 =?us-ascii?Q?VNHan8Cfxh5PYXF/JGuNprRCuANQihj89b4BoMRbYWVuLMK4VNMet221Yl8V?=
 =?us-ascii?Q?LXUZNzdadINYiZwtKD8akDZFZ0FqW8yI05S6pkFbZHMG3LQTUrXDMCGJpco8?=
 =?us-ascii?Q?sIKmNm9zqDqQD57Wf1ryx0EG3ZTiOC6udbShhH4bHRibyAPAYTtkRE6nAsK9?=
 =?us-ascii?Q?3XSulKHPtq/OBuzd9UCsnFss38L5JtfYlCf+cilyjCGJJw/8NcMMCyuOOhzw?=
 =?us-ascii?Q?YUsTpHy+YkC3bQnfd4qLu8y97GG/pKspOlIDRAl9eD13oIKKvUh5Mfl6SrdU?=
 =?us-ascii?Q?QjJFqFXmPICcSn/DoBidEj05JbODfDxpHtcu8zNObOoGtREN3b3PPbMOQ1CX?=
 =?us-ascii?Q?P6IMeQlsn8+U3sxIwSoboWFSmhDwWwRzBj9kYRWb8NQ6Y6/SWy4uMeIOTdaU?=
 =?us-ascii?Q?wyM3cX2cEc69tBiXRDVUFgUB6md6RaRfTCmiYeRQ3fG+hMWzFh01An9siGO3?=
 =?us-ascii?Q?g4+8Wz9GLrYrrByAz02yl4RNGmfAR7M1H6T4o0i3N1d6B2u/OnOsJfQuBD+f?=
 =?us-ascii?Q?FKQocU+qQL7LsM9R7kNQ7kETpnzYZM7mL09Csl/DTpjSQeuPHQp2H/SZ6/Ol?=
 =?us-ascii?Q?usW6PUC3eH1wIB+aLsMthBbL3S4QyxdfSe+t9PTaJH319gh/JWmP3pOJG07M?=
 =?us-ascii?Q?TKzv6GQbngIntm2Xh0y7g4VXgFiV3mwdkDYseF8MJ3ndvomLkRei7pl9qh82?=
 =?us-ascii?Q?65FgqV1LTN2BJcIhYvHCcnghro8L7TD1MA4iecYfg0dmA63ba1qF4sZth4od?=
 =?us-ascii?Q?waXcS7uvJn4bS3MViKUN3vbh8xwdZkMtvKe+2Df7SbFAOUqe8/NYy0Jxp9Ta?=
 =?us-ascii?Q?QFa3c8vQyYpYf04vtQZYQb1WHwk7PuBP6Em/Cc3fKSI1R4SkUCKDyszY4hCF?=
 =?us-ascii?Q?ajAHsW+QIgSIa84ol16Psv1bGUUuxbaVDgP6OjX1AfYdbwp6ErzALYIk+QVv?=
 =?us-ascii?Q?Y4GYdqUBfsurvqvx61jVIRnWRGiqxi+XtDOaqor8o5ZUqbbyjAElheie77En?=
 =?us-ascii?Q?mmu5h8zz6u1M92S2E823prkSOlg2ardcpnWizbkP2w1uYFYvalQHwiGoPtzk?=
 =?us-ascii?Q?2PMloI3RxqzgD37fygYqBi/hvs8lo2eW+yreCWF+90PwXcxb/qXSyaSt6Lf2?=
 =?us-ascii?Q?fCZUCMsgrjs3N4QxBZaCaKX2g5CQIkpCyjcFB2HT3QMkRwVouldT6vlkoawZ?=
 =?us-ascii?Q?9nWn6zgu7Py7HE58BhaZQHEoAIFsYshQZZNn/e1G5II1i1ePvTalTf2PIIFm?=
 =?us-ascii?Q?sXmm02wy0Au4HzGNkLRkzr55vjPY/OfVnZX0++OrH9qbT1L320Sv1gAFXfUL?=
 =?us-ascii?Q?8SugjFf5DfJBdfkQn/r9A7++hqxxgTfP9UvPueZvo4xJsmh/r3ph8XBas20P?=
 =?us-ascii?Q?GLm2tLVeTswEtUzJDWQyRJW3adkSUh+iMqEMvEkgOYS+FE+2u/HMvSQ8cyoL?=
 =?us-ascii?Q?3o0SLID6jqusmuBpxtNd6NvJRowUh/5cLtB497sjBJS2dJm/JILP8FNw0dKY?=
 =?us-ascii?Q?rQNKrd9RQw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfd1917-9fc6-4a94-3671-08da25f522e5
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 13:20:01.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7x662kRyGv5KLbLSLOIVwfPLDYuHb50FCtjw41wJd/u3WLV68cW5QI5e+aKdzTXEabbFqkGTtQdf4vZwwBK9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use `WARN(cond, ...)` instead of `if (cond)` + `printk(...)` +
`WARN_ON(1)`.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
v1 -> v2: Put WARN in the condition according to Steven's suggestion.

 kernel/trace/trace_output.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 8aa493d25c73..d89e3f7e26eb 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -778,9 +778,8 @@ int register_trace_event(struct trace_event *event)
 
 		list_add_tail(&event->list, list);
 
-	} else if (event->type > __TRACE_LAST_TYPE) {
-		printk(KERN_WARNING "Need to add type to trace.h\n");
-		WARN_ON(1);
+	} else if (WARN(event->type > __TRACE_LAST_TYPE,
+			"Need to add type to trace.h")) {
 		goto out;
 	} else {
 		/* Is this event already used */
@@ -1571,13 +1570,8 @@ __init static int init_events(void)
 
 	for (i = 0; events[i]; i++) {
 		event = events[i];
-
 		ret = register_trace_event(event);
-		if (!ret) {
-			printk(KERN_WARNING "event %d failed to register\n",
-			       event->type);
-			WARN_ON_ONCE(1);
-		}
+		WARN_ONCE(!ret, "event %d failed to register", event->type);
 	}
 
 	return 0;
-- 
2.20.1

