Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9434C61A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiB1DPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiB1DPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:15:53 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300132.outbound.protection.outlook.com [40.107.130.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CC442A3A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 19:15:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1fEWfHCHkAUJpDNFUgKGKSfUYPuyoiT3QrP6ueVail+mA/KRZ/XunmYzqsvAIT+Dph4Bg3gMteyIOXc6tNCnQJCqnjByWvZx237XKYxYmPvvXMNaon4nx25k5zZvpNWPJA6nlILXvnZssSjVbiImVY67a3HHRYVLMZPmrdbDjoYBR0JVFag9jXjJPf1jjvib2T+/osRn1I5W04skS2HXf7jrFCnJHkW7Olksrnoc1iEUIyZjpVySFKi2CWKj0aB4uGlTk6IGI0tFS/Qg9Uy81lap62nUqKErWSpS0l5+BSDmWez45Pd1zvtuogW8KdgXxQ5UDOiYwLlvyeCNAXyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8krF1cSsCFYuWdZnXErYBDMuwe0kPjprcu+E4vYgxk=;
 b=T8swgeEfOCQlPLxu+xYDfSqF0DkXbdkyCk8jKWsNT8aJi7kB08PAnULHxO0nkL74SZ+WhVQ4s6YNa6ll3ogfZSmVZtyUd97HYgiR6TnpupirkYrjAWykas0LXaY+Dr4+F1V2i2dDWNiwvlt5iDayPpEOaUf366TmmFLp+af1/L48JypErtl2Uov/6Qdq/cXyI+vATU/COav7CHY7TpJAOsQuNp7LLgyVr0SWhwxiT7KAB9ZGaFeae4ebVcufje0kRh+ygPSIcWvr83OYJIOBogY8ReJXBa/NXhUxE94Uuko5XFfVyeWilW9K5KMi9/67uDDp4+5mYQIVCTrgvI8i2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8krF1cSsCFYuWdZnXErYBDMuwe0kPjprcu+E4vYgxk=;
 b=V1Zs5e1pwDes0wr0ttkRBMU8aXsPE/RunOP6TY13hzdlOWKJ/qDbDfxKTP1kQzA4oxTzM2dc1zhC1Vku6AWeHaR8sgaWT/KsbvluB5gJ8JfOtNFGKX2tZy7dE4SXb3AZinIvsvmDraI2FkNbu+bpizYNHpkU4tAlHHUVxYIwT7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB2454.apcprd06.prod.outlook.com (2603:1096:300:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 03:15:13 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:15:13 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] xen: use time_is_before_eq_jiffies() instead of open coding it
Date:   Sun, 27 Feb 2022 19:15:03 -0800
Message-Id: <1646018104-61415-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd0805ba-2ddb-41bd-1bae-08d9fa688916
X-MS-TrafficTypeDiagnostic: PS2PR06MB2454:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB24548CFAAAD967E65022F11BBD019@PS2PR06MB2454.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRGi/Xd/OUNXhHrQXT/dGia6UKXpRsPlLnTi51rXEqsjh/Yssv0QAJX7N/JmANQuOxMq0lFNA2b0+Nk0GPTrXIuJDNSkF43Gl2I9LasKSGkj7ajt0Vq07Spjw5hqZ4B8Wko/f7b/ovvMQvxOSoEP0ivBHmdr+4G2TBGY0sHiJC2OSL6QRG681SeQqnmu1XMKWPxKj40jOGkzWez0oMZ4VP2x2YDT4B74VduIZO8ugjTpJrykF5qBikyBcvzKwhmUBLH/Xb0HjrMdI1c+H/t74UjC50FUNBnFclmj1di8HabPtFalpjjvjIXMwGFVjxFN2BqfhZeTKP7YqRfGbjuCoe7XaEYGl9rJjtkM2QydBXdiyJU5SNHDNJ5Zx5uBBqWJ2q5laT0Z756EExfO4NkU+GUBcIpMnpV4zUdfzWVN++BxnklHrtjwi926VbgA4q97qX/0b+ZGoOKpubdbZxCj+glmSV9AewNW72e/MOn8uKU21v34LNj0vcq8igK1O/dSIK83v2MAlUDURuITW7YVReNOMCNWbZrRZzpW0tOORpy7DLV2fLi+jvMLIV3wjuSUBNOt41COaHWzDM1m5AJ/Qa953bW8IvDef58Nm1o5t0N5YcyWOiyYDPlQ1xolT/v0h0Q/XRzNecRaLGfZXwmxhVq8akySRv6nldaVNaC4y9gApVq0b8E155ysqWQrIz1FxvmbkHl1ZWs2kaGZ5s8saw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66556008)(66476007)(66946007)(316002)(4744005)(4326008)(2906002)(86362001)(38100700002)(38350700002)(8936002)(52116002)(6506007)(6512007)(8676002)(186003)(26005)(107886003)(2616005)(83380400001)(6666004)(110136005)(6486002)(508600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gtZr1btOGnkEeac1kPh1nFGZkRZXhA8zlCuSivctJ5oMEJPzCRy+ZQLi+Al5?=
 =?us-ascii?Q?+eahW1+aUv+ok6JyoGHfQOJqsHtYAlJGHrGMePe1cY380lUjAMe0ps7kZV0T?=
 =?us-ascii?Q?u5j4Xf27jhh6jP1096dGd8Xa3PSgd0wKC+ilnqLU9eRwHVNEqZB8W+brrfPk?=
 =?us-ascii?Q?69ECmiEaw7wJp4pEegcabj+AHTQ+SDaZLE6vhOLUX2S8BqqNbVgmwx5ThS63?=
 =?us-ascii?Q?tmGNwbRza26U/Iisg+FwZl96OfjqnqXkdErkBGIU7nlHogP41sVrNAoJAU/g?=
 =?us-ascii?Q?6spy5Jawh3MQrrU4gN3hdcIR7AsqAKMpKVovbFaWdISQ8Aj/zeVOw8zF/zQR?=
 =?us-ascii?Q?wtdC+86j+j6rm86XNcwt3/+giEZLE/iTqNwDRE81I3+wjmmDPvpTNrDb4Upm?=
 =?us-ascii?Q?u4UgFqx2uWtXKlfDGRfRJFgxUGdziGH2YwH/UtqaH12q5ZPogNWu42oi2uom?=
 =?us-ascii?Q?2/4sF1hOQDozoa6z2vHG6Toviznw7Ek/tKW2k76P9EYoEYJ28j17oIgtnwIY?=
 =?us-ascii?Q?FRCW6F1GmRj7WlYTqt4ADP2xyk4liTRCpBTRG2g8b5bo9BoZ8kQ1Y+QooYcy?=
 =?us-ascii?Q?DvpMRhfFMN/633JPNxN9BXHbrYYsT3SzbAY57JLFmZwcv/ua2uWVhidtnqkW?=
 =?us-ascii?Q?7lWqcq61H0JiI2Kg+5OjCstcM+e/+HkTzJ/lnIL5CCfBGWvTtw/XcfWuICmq?=
 =?us-ascii?Q?7fp7RKOC1nk2MzTGQ6v/CpxvYTtxe8aOYCFL8iMP6IiGqnwfeJZt9E401MBn?=
 =?us-ascii?Q?q97Ey8GmmVmChRDjZvoX0W5Ft3UGzOZ7IatPpkNZKFVDEyniBZTOiDxlXwiU?=
 =?us-ascii?Q?Je1rZ9WlOAm3CFu+lJD+D3m51yE1vjx0YBlc7uMdhXRxOs50nhh9sjWUx+Gi?=
 =?us-ascii?Q?X8pPj+byuvJhc70SAYbaFd8F5dL06t90qfRf4kfCB5F5Y12LSvLylLGB3n5f?=
 =?us-ascii?Q?sJsTkj42au+IEbZ45C6nRJDCaedsH+IqZvEuHp3NSw1tLp592FT+UFDD7UNM?=
 =?us-ascii?Q?aRLjuKj+/W3Jb/OCWeaeRbTsq/s5gSbfht5AtMbDWb+tuQAmBVKx+Uj4hHsl?=
 =?us-ascii?Q?9m3uZPpQ9GyQH+7cWI+1+Ry+GIYU5yzwTwnYwvIpSHK+XMBb7LYnpGJhewAV?=
 =?us-ascii?Q?Q7AS7JBxJjP7QdFXiPrYeads0ulam8WEsLnv1djWX4s+LPISYCES3mcoHJ68?=
 =?us-ascii?Q?obSjOd/uhOk1GdzbWPxm7bwmNnVk4V9lSYCYNfeEfypQk/y6iYO0oLqpkEvi?=
 =?us-ascii?Q?3Ng4a+Z9/x6aiK5u9xL7GJq1OF+nBDYNcH+jmtItQwPDl0xYLB+a/wYEQwMK?=
 =?us-ascii?Q?KpmuDsktSZNsljR22J0kO62kkB0+hVCJNzX5uK3eLg9H4783sqQYUG5n4TRU?=
 =?us-ascii?Q?MvZpWU4j0pYF73tZZIoRi5nwOf5Tfxmouq7DpCO7mM1HnZRzCcFagugXi1Xi?=
 =?us-ascii?Q?86el0bYO1vlO1SBx/IiSGouk0hwk1sTZlnXPbfXKw64+LxKJ3zoWcX721YnT?=
 =?us-ascii?Q?RggeI4rFvitwUzzFNZJWShO1lnFH9SWlZdbI4lHXSxZs+jeagK554Wp8D8lL?=
 =?us-ascii?Q?X+qZnfXJJMNMpmav4MqyZ7U2KoCU25+fm+Q6kzfZjJMNZ9lHK2R2EHWu0Joj?=
 =?us-ascii?Q?H5vWHnpX11Tfp6+WkiKjJ1I=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0805ba-2ddb-41bd-1bae-08d9fa688916
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 03:15:13.6074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Yi5/LVrwiDNSXXtQ6WY2QQ3DEiVs6VNs5x16XAbWDkO1ty4kRNz0+koxg9llp7BTdfjWfHXfT9YvG8BrMZKhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB2454
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Use the helper function time_is_{before,after}_jiffies() to improve
code readability.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/xen/balloon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index a2c4fc49..dfe26fa
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -59,6 +59,7 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/moduleparam.h>
+#include <linux/jiffies.h>
 
 #include <asm/page.h>
 #include <asm/tlb.h>
@@ -794,7 +795,7 @@ static int __init balloon_wait_finish(void)
 		if (balloon_state == BP_ECANCELED) {
 			pr_warn_once("Initial ballooning failed, %ld pages need to be freed.\n",
 				     -credit);
-			if (jiffies - last_changed >= HZ * balloon_boot_timeout)
+			if (time_is_before_eq_jiffies(last_changed + HZ * balloon_boot_timeout))
 				panic("Initial ballooning failed!\n");
 		}
 
-- 
2.7.4

