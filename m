Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676A84C3E66
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiBYGcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiBYGcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:32:00 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BBE19417E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:31:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmOniDJ626yt4UcrTRpGLuS3XSFFpWnVDLYnNlquKk2L+ge/LISfLINABEpqrDYsMwQWzoDQSQGNAYW4tI7vMA0009L1UOVQ3jEcHfPE/QoenewAVumopnAnk4+0fpXJZl36dgyKHNdh7sJ4YMPiuYrGPQBs6oEh80BmwSNv+J4DYITrzoFUwp5td0+mHXtZo+MLxPrvy2UDGWREJ5Ch3i76qAnuPwrs/tegwaDLadQNKr0AarecxWKt94aaxPRr0eEz2MzOJEM9DZSk+CVXyWbZ9rX7szT7TkOac1+mmEf3iDh/HKKfVenZtjVqGVWUnb70WwDSvVOxh7Baky0eOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8URrYsE7sJxKoQzbgHTJ4MLAtFa/W7tSD97P0imvkWs=;
 b=CjXAJ6FmeHb9lqwVhOPagvR98WuEObt0D8sGxc0wPLV49hTbS/Dj++RXb3sPg2mXH4k7EyQvOvs3wNXSWFERVgaC6TKKZaL9MyvT57BdIhfy73dkNsNaM9D5umlocXAG0IrBnLq7q/FQJbXKtS9MV1rC55m66ufJLYJMVNo5GNz3TuD+lSvRWALTscNpvY+Ik1UP30lDKTxzNgpXChp6zNYFuQGfMcwn1LEgkUnbLpvSk4RzHghHya4YsVtnF/tNJL40aeQ0PhFHLcGUJMf9YfB5rjg+xQCAX/KQfRzcmrZ7KUCSTuP0GA8QyJ0+XdCYoxw6Bs2mxdZAMvti8RIwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8URrYsE7sJxKoQzbgHTJ4MLAtFa/W7tSD97P0imvkWs=;
 b=BJypI2VvVgl3/YzhmNaO7mYVAPSlmHejWuZQsQ4AXRMUtgDATyeqtN7kdbtqOqXYIjH5weNS84lvyYgUyd2QnSc4yvko8wGwMX08RfkHVxGe+VD1EzfX1W7UMT8sRcYGaSR4JP2JYiupcBYzDjIMb+cvQDq/SUhApWi5ZAE02hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB3841.apcprd06.prod.outlook.com (2603:1096:203:be::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Fri, 25 Feb 2022 06:31:22 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.4995.029; Fri, 25 Feb 2022
 06:31:22 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] lib: maple_tree: fix boolreturn.cocci warning
Date:   Fri, 25 Feb 2022 14:31:01 +0800
Message-Id: <20220225063101.891725-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 132d21b2-7d26-4088-eec5-08d9f8287061
X-MS-TrafficTypeDiagnostic: HK0PR06MB3841:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB38418D192E9CEBE6C638A612AB3E9@HK0PR06MB3841.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOMx0YP1vA4CtbjUjXNdczskKN+oCRt0lUSVcp1m2Y+Ok5Iey1Ljt4pnLVsRa/zB4xxWp4lr00I3uQW7KDIskRSYKXdNvV/FcfY8lifVjXUN/oAM1qijpxaArKCVI68JCRnXmj51E+vOzohjWkAJVX3HpewKWV9wY/CZZa3UCx3mq5+GXqOWHnrl43zZyLBW4lPkKI3juBNrLQC6hQdf7AAVy4V2N+CpPnwKSomBNKl/qSd/dOHIKrVAmjMnOAPpaZoeCXcN5G6ntbf6LjgPZ+ruPTuY3/dP7U3/XsQj7vZimd45FQeRul5mKBaIDktjbwfcBHOanqoGZKS7VcXxAFaMTIEwv+eeEXmlpIBD4oxKzepNvsrNynBL76+q2TLoKDbitY8zimpozI7gndYb2kHV/HHL8/5V9bmPu4HiD339RFSoPIL8q1ItaqarD8UK6vl5vI5xTJtojfsHxiWPRDuVuutjIn8fBJU6p5OMrzGcWhPNxb4/f6gA/Jq2qY/ecEZHdlIhOiVVQ8SDIntggu3tKiVTG1maR6GtuAOkpspBMcC5upOTYiv19SZkcPwliBliesfv4DMYmH1lLdeV21tnUXheg9Oj+rSNw6fJUguwRn0jpTwiK/c/Cq7O6DJ63ZjBF2SWM8Q4m04Acmtv9ATFTloSYYq1r3oUJUG6SCVU++t3ExlghvalnQHrjkgm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(6506007)(6666004)(66946007)(6486002)(8676002)(4326008)(86362001)(38100700002)(38350700002)(508600001)(52116002)(316002)(83380400001)(2616005)(6512007)(1076003)(26005)(186003)(107886003)(2906002)(8936002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q4Bve9FSGkN7qPUDnZOA4axbo+7TntCjLv/bevF6hNpk6Q0RdAuVwtqSRDpj?=
 =?us-ascii?Q?P5ruvCMSHPBvi/MN/wdZf4tDht/5hoX3Nw9G8YgmBUy2633Y7uPjkxoBgZgj?=
 =?us-ascii?Q?cCHTOwCXHwbVSdfE/DvirNZ7WeV4Hq9ufCNlVU/JZcLlIHd8NYB2pxDd47og?=
 =?us-ascii?Q?26zr5054+FBtHJbhpcMXK0NmW1LQ0VfYtoUOKFmpvmM/9VJ48PQr2qXJkfDk?=
 =?us-ascii?Q?OhUfTG+dCkZtffxFueKKtj1UwuoG9THt+DLvbR5zvkpbHwFCyFG2YenbmBrY?=
 =?us-ascii?Q?GW1/pO5VBs0KStycu5IqnrlOINviiTunNZgbN8RpHL39DIv5MVo3UK/o2sy6?=
 =?us-ascii?Q?+UlzQnuVTW7vSBic7bRfYvDWqFBHNXJbttqcbEbxgD30hpuNgJHd1W9ocAjq?=
 =?us-ascii?Q?DyasO95reikgEOMH/q5UCf7gOMGl4lyQfGIDw3TLObzeHA06CqejhWoY18D5?=
 =?us-ascii?Q?dY2kdjGWhkXnJgYGMZPD9bKnM/FMgMWDiDYuno++bd4jj4B4E7hj6DHZtTR1?=
 =?us-ascii?Q?/HrDTNdpaTJpw5rWnNh9SsqkSPx8u7TAf20KLy2qiOx25Mx7Fe/+EjguHBTX?=
 =?us-ascii?Q?Fh7e75q/9YflUikkPCtFcObMFihppv9DLMilypA6dSqCY3bdbNF68qc+vAXy?=
 =?us-ascii?Q?Uvz5Zmhs4y6/xQxdYupVuMmPfsNCUZJJKUEKt8za+MksPzaaXuPj/UeOI5qy?=
 =?us-ascii?Q?vKkC1UVOqTkYxdEJBjOY7XiKmVk+A+L/p+uND5HgzFkFBZDQX5c6aALFCxtc?=
 =?us-ascii?Q?CMb1U+a3NZHZ2eOMCzuUOxTf++JTsLbJnBWN4mdj7UYXMjgXLFz9l0FqAZ+Y?=
 =?us-ascii?Q?XH5gXJi4pTcBc6D3xGfIdNN43cQkHu5wpyBkz4ZTWRoIs225HOe5p8En8fZh?=
 =?us-ascii?Q?dabQy7ya77o+wAinE9AOvE8uU94I3v94qjYX3vee+vGNw6MBxvMZguz9kd6N?=
 =?us-ascii?Q?DuwjByRl9r2NUX+5ZSqcX2sonBDkws639IEcAlUBLcB2oYZ1k3GwNWOJCGvR?=
 =?us-ascii?Q?1jh/seajvTCM3i7c9k9D7T4JZJQKmmgh8P4a6YPAqlCjFD4E8LA2FhehUcAd?=
 =?us-ascii?Q?E7iKKmsq+1RKwORbJq7cHwqcVOlHHY9Om3dG+fisRKRPK7KGKD5lrFBwEuRi?=
 =?us-ascii?Q?/AyOfduJ+fvI09t/m/9pc87LeboUaqrH+J5MIrhrvBxGHhFjiW7+MT8lm0JB?=
 =?us-ascii?Q?w3U2ZkQ6EdWRfuBYbKA5y5sZP0WrxjuM/fv8bA+sOoHimAMweLC6vyXE0GH2?=
 =?us-ascii?Q?UQmbNabKkU4mo0Tu0/umM9VwkxZ7jAleseOx77/x739IJo6q/i1i/ZzvL2Rz?=
 =?us-ascii?Q?eVjPHT+FfOJd85glu03G44zSh1Z8IvvziCcuJjW798oBgqmCelO+nCDpt+jD?=
 =?us-ascii?Q?srSPa7uf4WsH7W8yNV9YurugIas1NRelB7Rpu0pYkPnGwOEuKMzajDwzNtot?=
 =?us-ascii?Q?T2ibG82OXpisMkoTOzWtXRrM0LwHv9K2L+dyruCRKVLJGYNarCBTzvaWKFuy?=
 =?us-ascii?Q?vLY/sWlv5tY6yndl4UVDL/vjavh6WdKaGwJJz1lpETH11qMDkDweLgj+wsSR?=
 =?us-ascii?Q?Z3yKsmA8CJSfKAIjEbY21iq9PojDtJUbR/1aaGKOcZxjn9Rdf7nmQANrwqIi?=
 =?us-ascii?Q?32Sz4g/R8P1YDAJfN6ravzw=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132d21b2-7d26-4088-eec5-08d9f8287061
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 06:31:22.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVOC2QA9gEjMvqVlaEK5Z0WQG79qphKxbq0/SSNdQjZqZhb0hnwxHhbGK+KqAjm6ucgbOOieraf5pyCCvXoVnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3841
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./lib/maple_tree.c:4177:9-10: WARNING: return of 0/1 in function
mas_wr_append with return type bool.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 lib/maple_tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5f7295ba0309..933483726b85 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4174,7 +4174,7 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 		mas->offset = new_end;
 		wr_mas->pivots[end] = mas->index - 1;
 
-		return 1;
+		return true;
 	} else if ((mas->index == wr_mas->r_min) && (mas->last < wr_mas->r_max)) {
 		if (new_end < node_pivots)
 			wr_mas->pivots[new_end] = wr_mas->pivots[end];
@@ -4185,9 +4185,9 @@ static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
 
 		wr_mas->pivots[end] = mas->last;
 		rcu_assign_pointer(wr_mas->slots[end], wr_mas->entry);
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
-- 
2.35.1

