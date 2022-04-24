Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD9350D19B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiDXMNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiDXMNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 08:13:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D41DF22
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 05:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os7rfj5IbVNF2D4Wg9fHKiv533Y52BU+LR44978M8JwWaKYNq4236ePNdkP1CovOA+LFFTYpmeN9OYNd+KczVinkh8TLQg8QhEaZdi375rvsVoKQgLrt8e44KDkidZGpIBqjlO7x/DjcJPqfDw6HmgkXtfQxGcBGoX9iWU2HR391KBWZe7vHLmZU5xhVEenC4h4ZbEU7ofuOo2rO2kQWzjwslXoWOBLzEfHTml8Cs9pto/mD/dcoJLw0gBlGkxvdCA98/ZkhHduKmpj/E/QYu58TOEMjkN4z5blh4kYZ40R39RAAP9X+bpVTHDibUATJkNoyBW0ZAoD0gO5RVsu0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHnB7VkpXTIHOYVEx4eJrFcQbJi2U751C2sU2QA2x38=;
 b=MqNR2qZ9S6gaREU3HON7vD/rGE1kwXZO52k0PVy5F3WX8B6EirA0DX+eIL9mtRZieety7wRDS+veDEtiAhZvkO/EocHZMKceTJiD0Cgi6YKtFIn1r3wdIDuc493vsdvN6zIEvoxIU3bpLdZpzMAq2eY1RFJHlHMtTgGf4CXh352y3Cyujg3Jvy5f8QcbiZKOy/CHrz27RVtzv/dx8Jpr5KzKiVhbyEsl9P2G9PF+/ViJ6i1GB5LQc2Q+sf9R+UtDEn1p1RV0/0kIpGqr1PKnfPnuXapEc48iT/6s3jThUQBrNZWbLv4acx8ySLrjLBqh/HVy4ZEVkL1lphXGzhHCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHnB7VkpXTIHOYVEx4eJrFcQbJi2U751C2sU2QA2x38=;
 b=NG9CpwrHgMoC4G4kU0SzW/RsFPEGzTCC+as1GjUOeA8DG5YsJPpvOZz32tfHOk7MHaHocxNx202kc+fqsvmk8S6UYsxFoBHJzd9XeSjZPyVzbzGEd5p8S0VxRK7f9XMD9tNor0q4heQ0EzYDpblZRbmPsyqkvUwjrZFxt80iWl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by PS1PR06MB2712.apcprd06.prod.outlook.com (2603:1096:803:4b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Sun, 24 Apr
 2022 12:10:15 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 12:10:15 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>,
        Qing Wang <wangqing@vivo.com>
Subject: [PATCH v2] trace: use WARN instead of printk and WARN_ON
Date:   Sun, 24 Apr 2022 20:09:54 +0800
Message-Id: <20220424120954.3368-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211207091843.0765fa3f@gandalf.local.home>
References: <20211207091843.0765fa3f@gandalf.local.home>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:203:b0::28) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a31ac0f-bf08-4a0e-b8d2-08da25eb63bb
X-MS-TrafficTypeDiagnostic: PS1PR06MB2712:EE_
X-Microsoft-Antispam-PRVS: <PS1PR06MB2712E30ADD0557633FD58869C7F99@PS1PR06MB2712.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76wOKJZJW7AvPJjO787LETbV1wQ54mbHkR3KUoAWxIOwArUd8D6vEaslMvkVdiMVW0Xkfn5IW9RSQu9OtlOREV8A4Z5SUs0M7189xnTB1x7IX47XlRGrSwNl343PdTHLOHj6IPObKIxBelU7vETzT2QEPLMYqLOumB2D8UKMSae86g4IhLMFkVfVu8E25F7zsK02+B4Ii8dZU3NijuI4FEHNvGUsmdb9vjjW9KBUefWpBCXZWTNuqNhIEYvk5tub79FqJxsxDXP+tgr2VYiF0sdd8kqZUnwhSx5ImCuNKefjTIGg4OCvP1lwCAAQuazlEDGvMEEe9nThC/K1m29vcVvCHQcTDU0oDqrTtj6X/nztTm1geRLXSS30juOPoj5q5PZkW+NJ5SCCwUDj+8crdTeI1xUzv9N+jdA/BuJyrcpE2cdMwKOjAnBgIiVRAXtt/oEUBqPQ2smHr13xF7Wm/2HABVg6MKmGM5FZ1bOmTd4iW79IwlAzWZv2mAijTXUm9tMoxtAw3nEkS8N+D24x5HNErenFK3RkCDkG+7UGS4Kl7qIkzFt3lgKBv0fHb+l6tbuJ44MwbGQRVnV23QahE8UehS43/CKH6vtWghF5hqRGaaoPehKk5WQGS+oEnOIs1djT686UYacWOJgtpDuu9KK72sV1I7NzxFF0KU/S/tnZcL+fJrmG1JoyxwsAAK0XKg5zp50ahFYbh3tDhhARMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(83380400001)(2906002)(6486002)(66556008)(66476007)(6512007)(8676002)(4326008)(1076003)(2616005)(107886003)(8936002)(5660300002)(52116002)(86362001)(26005)(186003)(66946007)(508600001)(316002)(54906003)(110136005)(6666004)(38350700002)(38100700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ihQdhDF0KN39gsGGqSducGY+S7ybLV64+ASEMT/ktPmjkk4xxbfCOWrVOoxm?=
 =?us-ascii?Q?V1vbUO0v2aSAsMZVwfRo/C40g7dThphbmaYSorUz5IqkNVbENSdGhZG0BZvu?=
 =?us-ascii?Q?p+a+8ZsEQyyEcG6pZ/0RyWeW7cMKpz+jlDb00b0nYTxjEjnr4deyxLz/cQtU?=
 =?us-ascii?Q?PMBqbeh8i2vsgAuAadAYaBzC2UJzLPS9hZ2zCI7RssfT/YsdXz4N4wXUP+8k?=
 =?us-ascii?Q?8AW5KwgqQn/DOkN3E7/U1Qe4n1vb2fjlAS57j9+Jf3WX5mdVFrwHff6NC2O9?=
 =?us-ascii?Q?c7Lj9unfoNO6gGzlJNqMccu2OLNAQNK5GVAKvnkM7mGHQtBwvlQwKw7pIR/z?=
 =?us-ascii?Q?N6ATsoIArsdOVP/2//255tZSKgWTQDq9XOWFLMmliz4hN+mIM7GRoeQF9TOj?=
 =?us-ascii?Q?0fVcjzoKR5//disiXd2SwRBC9fexZYOZu1TWPV1a3LWivDQAXMUzE2uqmAuD?=
 =?us-ascii?Q?0PO2Bt0DhnsdBcnPP89dA0MEeS04ZpxIt6YmkGgbF7qWQLuAIbO8/yLgCkM/?=
 =?us-ascii?Q?3h5XSOXsE191B1wgyUASnEhUranXSCtLsRRBLoqhQmqigEN6BIykZcx9xxsI?=
 =?us-ascii?Q?9LOwzvcSXJGAosoMCOrEYyDVxB7wsAXdg7d+ypPa4vJk5359AYgFowxapfT7?=
 =?us-ascii?Q?YDbungM5NkpIeUb5vGcOPBYiH7pkF8ZfH++Rak/tuWLqSUkQosP1UJBU5jNM?=
 =?us-ascii?Q?OB0VC1gaa1GPb0ZETAe3ixBKk/rdRwhQlcpSxaV0On5SdEcBiQLEIsRXoe/0?=
 =?us-ascii?Q?CXb6Tw8/todbhw3ue6ktNKgZ0SPgA+6CJm/Bizo7jhW/dXuYANS3Jkshd3Ax?=
 =?us-ascii?Q?4YFWgaA2iLGqJvCA+iNFJqCXEtTz98QFZrztukXg4un5Nju2+0KOqzpQ/0Li?=
 =?us-ascii?Q?LOqAL3lDb893knkuD+6Sj+STI9/U7CA9lU70kPeV4EzCHa4WUqHBrBquN4pY?=
 =?us-ascii?Q?b0HljIdu+fzQjV8WV4rZWVa4L/bH2aVRGuJZMgL4KZ6uY7ykWtba1RKn4MZe?=
 =?us-ascii?Q?+zcdH4a8vJWVWZeT9DfjuzntftF8zV1mlMCkqDaWbTP4Ezdl43zWJP3XGko9?=
 =?us-ascii?Q?sPyZt8AXv62AtJ++OobXkzfoFHg1iczqGigBvPZQhr9hIlqycwiS3qRAIoLk?=
 =?us-ascii?Q?2rJl6aztkeAQX66tsi9lXL+Xr3acD5gKefc0LbCB6h4VxVfVIYtEtL4peiE+?=
 =?us-ascii?Q?S0mF0DNNcpMesIBpdnfS+b+qnknngsiw3DErXcyKKv9DMoAwaEo6+i5lAZwy?=
 =?us-ascii?Q?ZkWDRg/CxKig17lG870f3DJgL/QDLqeal0zC+EFxxVPfqW1JYTFdOiF3XMCh?=
 =?us-ascii?Q?WnG+uHFFqhebFonAMn3KMz1311IvG1FB+F0nvjUd3YtdhOrtvkZW44OhZ3G3?=
 =?us-ascii?Q?jiP8+0iACNdnZLE3R1x6HmS/hHuMZaUVuJyMtybKa7O7J4LvpmfVgGTZmUkJ?=
 =?us-ascii?Q?1T5u60CKjrygZOZXhpYRlARPgT9ntB0cEXZJMaeaOCmRrvoFzIZ4yIKhWdTx?=
 =?us-ascii?Q?+rBCOuDcGjHns5IUyOnVsEhSCTV3OOtDTotPm1j1KhJ9vOXWEr+ouzAommKd?=
 =?us-ascii?Q?Daf9gjvoxWb0SW/UJz6f24FpSxBxk0YEYOdKpds/cGWFeavjfpHaZ1FGsxYZ?=
 =?us-ascii?Q?OfSy90UHNKBJ1n2khDDTaGn1Us0cn9rsp1zfwks1MtUoqehZe/svX4izcqrt?=
 =?us-ascii?Q?ZRIWk1tKQzBzeLpRZUKijYN/qaKx6xpdL/N6Fdx5sMjGi332NNgab3CkaEZh?=
 =?us-ascii?Q?zzUn7y9icg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a31ac0f-bf08-4a0e-b8d2-08da25eb63bb
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 12:10:14.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaBdp07jebg4eMdCbkuEf8r4JS8NAbAlEct8GljaJSH/jV95XrcVBfhLTQQA250BATW3wQhm5hhTftgOH4Po2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR06MB2712
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

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Qing Wang <wangqing@vivo.com>
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

