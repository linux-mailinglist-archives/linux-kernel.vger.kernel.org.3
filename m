Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FBE4B0859
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiBJIbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:31:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiBJIb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:31:27 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E4E111D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:31:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEbDduTM83PI7VV+eZ04cMQnE0V4/dfr+yvqNNMsNZZxHQ6SRaR0OZvwARSJTIb2vvWjc596qNqgA3RMAazcO+1WLAZERApg7cdTqFERrslN5MfPO6Dyyj8K7h8HhU3Cn+qLcDUDDjjcoMN9OJU8Tb9BJeVP4LCMiqMdyZJqkJ3lnPPg3iMYnY5jc2EtA0QL3qRKOoFOFsJOaSpeT0r7UT3Qjm484hHDbKMKaUgdw6nRoKoy4pWIzBhxImlxiG/MMMgdMTpGcahaa4LL4CEAhYWO3adsIhxsLDTYgZSXXQGzYoqh41SwuxIXl8v7xEJdltGTjB//5dIh3UB+epXpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ls5sY7eKX3KoYLbEWhtH4oGNSQd4bcjrtmiHPC8tbM=;
 b=leKx3Twiv/FJ7xb1mQebdYYXyqlnQKM0Sle2kvHoMbTnO3rPSc1WyDS3JLdxEW3BmsvDoZQmj3Zycf280vvzTX20uJbhITC+T+90UfrsJnKmd8lkMKW1UYZT9i3T2HiOpwbZWz+oQ7XNoT5jjF/Q8ManUEWQ0eukqgJ+dQhCX75AjJV5P277EpPOGdtcLDr2vbJDhN0SxNdZHCVspU7DdNPpqXQH5YBua+brABcm+FTMLjjHGqwIe02zUjZKQcEWl7q+Nf2u0Sz4+XZigSbSDYITT/a4UVzi0+kKAoS3hQjbDpyfv5/o82L2prc9KZCdPd3urEN49gbWF/fSVTx8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ls5sY7eKX3KoYLbEWhtH4oGNSQd4bcjrtmiHPC8tbM=;
 b=OFLLkZN8eqKWojFJ9IHgjWl/TpGCKS9zFIfP7qAGVFW4wONYB/WN82tn75wP6IxEMpzkzQAnK5SVeZed8rQo/4IPwZXDyIV7xEJteZ1x4g1T1INfLQsfF+UsIKLcORlPUxV8cVaqbtFeu1bFbaoab2WNZoUYvtUyiWfXCn7hFAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PSAPR06MB4005.apcprd06.prod.outlook.com (2603:1096:301:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 08:31:27 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:31:26 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] md: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:31:14 -0800
Message-Id: <1644481874-14812-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0131.apcprd06.prod.outlook.com
 (2603:1096:1:1d::33) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5f46a05-62e7-4c28-d48f-08d9ec6fba7d
X-MS-TrafficTypeDiagnostic: PSAPR06MB4005:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB400546727DF61FEDA1DAE74BBD2F9@PSAPR06MB4005.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4bAOwGPVzRncR25sOpRb7nmyofZJ2XT7ToGKXUXrGvKeFi4rulJDMQHzi477p+/qPZR/tkn92idTuEe06CO9c0eu7+MinvElkMrdiaTqio6PX42xDysYTo/QUQEO8tGhjaTrH9KNEO44cntfleGAPtOgGTUyCUQh8YzE81XrC/0FqkfMLqJ/nu3O8Cmx2aFSkZdvNht+Q2ursKqTrcb5RaKpKpOtf2hvQZbzIWCcXn+qHYjsOt3hqf6S40T4YilEBidinG32slyadSw6qSA8s5Mo9NRa36eQfBMRSzCds1iLeWQ9LmW/j/oOprntsA9ShFaX5Vw3jhJetBdCkM3oYYOvn4XTkU5r3pK4oUZz5Te5uMIaa/IUK7PvGiptNuUMV2KIpyS+h94+LexCyLfUiElfAabV8OeQrK8bX6ZKxwd6J5fa+ShGWaUN7Yf6+eLRU6g/9NuzHyFe/Z4NQTo1Y+x0ggIjIvKQzHfosVe+KG6+qbaKdur6I9n8okpQztVO61bukGW8AqXD6tawFSBTinr68+pnQlro0ag+voKOP6pMicGQfc1iMJAxPSkjg///M4l0xHUr1Bmc8w/w8ITY3B+kCPOhF8BmQFptwxep1LpTRJle1FXwqn2+oM6pjmh4xip+oYu6IlwxQsQpactdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(508600001)(86362001)(316002)(6486002)(110136005)(186003)(2616005)(66476007)(26005)(83380400001)(107886003)(38350700002)(66556008)(52116002)(8936002)(38100700002)(6666004)(6512007)(6506007)(2906002)(8676002)(4744005)(5660300002)(66946007)(4326008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nqXdLOSssjdbWTEU3E/02CK6u+ogOgyehvk87xnGJFJPM26AUptxSBm1Q93Aiyoy7U0qttp8VyMwNIkwj6NMPyRoYzOtX/jo0l17Vo10c6CoA1YApTaZYKzAIDaDi/kDyZBBd4jrUygtIuRgLQOLko5TBorRBKZS3YZ0ED1FA4QlK3Gic9e6v3H8mz+lQ7yubLbrKMrUk9OJ5Re6pNpcurstXAx5ImdPy/F6+DMZ1e385v4Aq8FTFTQhU0imryXlz8OFJ0lBmbPFvqXOYqmNfF+hyOgkvUZjOEE3RzDd5AcutaGKY4v2C6TpNMh/vgKDNHHv/m+SdaDt0J+AtqTxtLVc6WGMb3Hej5qcFtXnLDhTfJsOIeTNDDRtLT1T6N6aNA3tKcTi9QkEPoq5qF5Dp9HfA4QgtpiuPZvTIsF25nmU3wTWDWWpsib0fZJxMjiO
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f46a05-62e7-4c28-d48f-08d9ec6fba7d
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:31:26.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWhOFB6T7a5UNykUA/3oMEzCZq5pl98sf+ogzE1/ZyCokqKYoi4Lofn0dO2fZfrCtmkQ/3616ADAtgJGv6B87A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4005
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

It is better to use time_xxx() directly instead of jiffies judgment
for understanding.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/md/dm-thin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index f4234d6..dced764
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -161,7 +161,7 @@ static void throttle_work_start(struct throttle *t)
 
 static void throttle_work_update(struct throttle *t)
 {
-	if (!t->throttle_applied && jiffies > t->threshold) {
+	if (!t->throttle_applied && time_after(jiffies, t->threshold)) {
 		down_write(&t->lock);
 		t->throttle_applied = true;
 	}
-- 
2.7.4

