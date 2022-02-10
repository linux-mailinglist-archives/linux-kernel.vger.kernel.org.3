Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD47C4B085C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiBJIc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:32:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiBJIcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:32:23 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41EC1174;
        Thu, 10 Feb 2022 00:32:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPpYEejO6N+C2K2Prql6Cwj3xkR2Bt1n53ibuCOUIe5t8w7kiLssyaQ6tF0L31fEvCskPdBbEs5rv1Xfi706YLNWPexuITcLZxgJGYQ5RhSxPfJNZdA2MhppkS2SpO4DjIVAhsuv9Ol4LkWKt1qedz0XXFQM9rnbkVssvfiIWPM0zOD5+HBJPWykMEiNAklqHEh6uvi5xeUhWS7hZ+zbioNC4OPUohb0LGvI5vvhF0RrPmh8//ww6af58Eu8/V4uWZOzqmDeaJ3odR2DhBsYZsCgVOLnQ+VXAYs2fkjLHW3NayF37m8pszHiwwPeZM3sJI3m8sJcf8stwVZ7GuK/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPD3JhLdfmSGV79wxtmtsbGqkMo6wvLeJwtHfk516wo=;
 b=TsIYlXOdy+qZHNW+/foxnU/sMMxx5S3XectE0j92Ui1sNh6EBtkcoYjO6SuXxW4BDNeIYTPEMgx8EjHzg15LkZXysSQs/NeC00LW2y5gvAnWQo9+yzWUiun5l8SVOuF8beMEpg5ErYjhqI6TjGN4D5NSLh3yNdWBqTXP4mFrFlIwCiSWJ13tAsJBUXftsgY+cog/5JCM1v2sTdcyK8z+1Ku+mlUZqkrm2jRpEbL8L+5Kcv1syZSoqGhIQn6+33WFMI5+IuInbNKxKPqeTEK9qkBUHoJtDFizNWqc9r7AIc7mdv6oOYTgRtgeX5G4bAwvXKd1wtvPIqO2+2DsworuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPD3JhLdfmSGV79wxtmtsbGqkMo6wvLeJwtHfk516wo=;
 b=aFOOm5irrswjZ6j9z4iMgiqHvuaJwvoJrve5Hxr87NAZBx76WVkAL2IEF8CB1Bg4Cfj6drClmLJgVcSNjeswpGkUrY3V6kzM2k7pPmF+Izu3VuROkReWhTSeRpNme8TK/c/joPjYxcG1sMlmGKErZWyfjjYQDIgZeiqRZcWhbhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4068.apcprd06.prod.outlook.com (2603:1096:820:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 08:32:18 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:32:18 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] media: stv0299: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:32:09 -0800
Message-Id: <1644481929-14955-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b893a1e9-9368-42da-b7bc-08d9ec6fd942
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4068:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4068F954704B7013F3141A1EBD2F9@KL1PR0601MB4068.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:231;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/1u8c2ds2Suj7z6Utjpf+5qQot6H7Gh5kVxBmmEpC51BzajIdL6f0Ilkw8jfYAuFjr1cch6PPAxrmuO5sADDwQxL4YllbtEWDwLDqHTq+iqilQeFu14ReHJMGsKVYD4NgeQiCQM3fru3HU7QhE2Ys2EY1M9+ZtAPVtB8lfB348FZBmIi4pqMKt1er/gJFzp+FJx1NETHdjiqye1VcyJ+/vL5iQwPSR1fz9Ce7h4wlsE3GiiCZjnDHKTzlI1jXO05PtO7TmCvzcLUgzgEao65Dc5s7TzIhvc4OH8qsmOUyPmkvaB5CEDVKspyJvv3pJ7AkfApai2ofo4C7kNAZSxmabf0twAspE66qd9lgpPYgHnHtXU66VW5MoqcWmvxZJNnmF3XAj2HlSkIdoP/83JgLa8TMoUUSRqrh2piWRuj5feGITIVt8DzrDlYA6ClZ6CAMP3M3h0kmukK1WOohuKuHoK6bcYEh4Dh/48oDnk20tQCU8RDT76rxHTnLkatClNwyEXao3tOdMTOrRKcCPcSbp51x6ai08n2A6N4TEfMtUlQLNEaOejoS1glHHXU0CKp/+LdlzG7Cq2ak1JY1AgYGAqFD/G/x4mt0Lr7Qdf2nidYFVHZLzfWDm8wvvgti0lQLCErBdZE6U6bNRIgFPVtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(26005)(66556008)(4326008)(2616005)(107886003)(36756003)(2906002)(316002)(6666004)(8676002)(66946007)(66476007)(6506007)(52116002)(6512007)(38100700002)(86362001)(38350700002)(6486002)(83380400001)(508600001)(186003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MPRrGxpqCQF/r69Mgz67LDsYIG+aF3j75sURlhBku0oop1Pv2x1Bb1GGzIA4Gnd25eutQo0PgOuPJQT28NbcJVUoXRjRheDw8RyxxAgi3oVG41Hrc/C4UNY2KDvlytS6e9/DGFtDIw57UlVO/S12pZKEsID86l5X1Yy8NJiFQzwXmJN96jxl5vGwmU7IRQjvemD+y54EsAsvzSoKNA+/hfaZfS/e+5nj80/q8DsJ3eamJ30kCATr/iZaKCyMIsaOvxxdXaScNRkBW/zmZR+oairo9hewnG4SRNSE+BtGfUnk4F5+HliXLovH9nsvHQYuuWnODJjDfEpNZo0xMLR/ZrIysUrHIdb8lGiG28ne5mmW3FoF5Yin02sAQWmj+E8pYf1es4iPs+ny8uSGUVdTBaDahNJTRJcER3aXxAE79+spO1ZDkfmCqtRXD4PmAXU2
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b893a1e9-9368-42da-b7bc-08d9ec6fd942
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:32:18.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yirxzjlnbh7SqhUEi1sM2K3mBmGoZQGVWO0Ro1nXZmseBSdC4bCjFzlctq0bSd/j3M9BzAkAhrM1qn6hGH7Evg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4068
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
 drivers/media/dvb-frontends/stv0299.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/stv0299.c b/drivers/media/dvb-frontends/stv0299.c
index 421395e..867ae04
--- a/drivers/media/dvb-frontends/stv0299.c
+++ b/drivers/media/dvb-frontends/stv0299.c
@@ -183,7 +183,7 @@ static int stv0299_wait_diseqc_fifo (struct stv0299_state* state, int timeout)
 	dprintk ("%s\n", __func__);
 
 	while (stv0299_readreg(state, 0x0a) & 1) {
-		if (jiffies - start > timeout) {
+		if (time_after(jiffies, start + timeout)) {
 			dprintk ("%s: timeout!!\n", __func__);
 			return -ETIMEDOUT;
 		}
@@ -200,7 +200,7 @@ static int stv0299_wait_diseqc_idle (struct stv0299_state* state, int timeout)
 	dprintk ("%s\n", __func__);
 
 	while ((stv0299_readreg(state, 0x0a) & 3) != 2 ) {
-		if (jiffies - start > timeout) {
+		if (time_after(jiffies, start + timeout)) {
 			dprintk ("%s: timeout!!\n", __func__);
 			return -ETIMEDOUT;
 		}
-- 
2.7.4

