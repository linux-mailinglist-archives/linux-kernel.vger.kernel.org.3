Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CB4B0875
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiBJIdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:33:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiBJIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:33:04 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300112.outbound.protection.outlook.com [40.107.130.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCD9E7B;
        Thu, 10 Feb 2022 00:33:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZRPeKQVkQtMq/ouiAwWD4QhxxQ517nQ+6XdDOUF2cMfCahieiiXPkqlRyrkW5CMEbtZ2r+hi/G33Vsap9zwucpxdTo8Q5a/L3rUtEM9JWRGl+LAZEpYAZyYT8dp0U5PtENs7pxfXTbuGhrlsZuP0wg077//w03sx1OuzUOu4dcfaK81xeTVen0voRkGhZXb1cdstZUn6vIFt2mG2R4FH905W4LFnfs0pzHJjWe/+dJKRDW7Y8m1+EloJ6Incn+JDlofm0CL7Po2apxjyFybb9edXhV0R6/nusN/rGrL6CXQ/IR2/DBVjcp4aUEjha5MaeThowgDj+nB6T/wcA75mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDkzuWIUPeLfxjS4hZ7nA/nJr9CyZ+HMRwVf3gqfJuk=;
 b=LPIUgBAF1xM8wwcmUG8mzoLUUbLkyz8YsqtNROAI3J0U2xeswCqndApcn5AUqoHFQLeofW5vnCMjx9Th6UXetb24EtDEPU73AoDDlDLAWkrn9BlUo2q8aMZpwXIxVW6c/1WJoYYvpIUF1ryDK4WajsN7L9UTntyqiTG4CZ0c2ijCqyw3kgIaLqjoBduMic63tNPkQ523N1s/k96c9qF3Qlo4JL04mepjyzBn5duxwrKGT3SvdHbQWKGqjb3Aja6q7IhXnVXDUed0o13bhYeHpDnuleZ/J+5FWLSAM6cNwSwQ7n+adxEy48yZFRaadxiWBv2xBUg1msIEgtioNtMIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDkzuWIUPeLfxjS4hZ7nA/nJr9CyZ+HMRwVf3gqfJuk=;
 b=aPzWoH3yIPD93NvuICXz7CCSm0DN1PN40BJSbr7QXPjTkAHYTFP1yWODINNCjXnMV/md8wGH6+R1dLR74XYdQDaRhUbGv0uB6c+/GoRSx/+YHNuUjNH/MWf4myDNdib6vAEVG2bMcybomb29HBw2ILxfEeK6BQNyb9gb7s2d+iU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4068.apcprd06.prod.outlook.com (2603:1096:820:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 08:33:02 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:33:02 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] media: vivid: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:32:52 -0800
Message-Id: <1644481972-15113-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54ba8c82-e746-4aef-6ffe-08d9ec6ff339
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4068:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB406819BED0FF24858905A3AABD2F9@KL1PR0601MB4068.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sno4FeHRBdq8AoTbjWwfZM7LwtEf4IK9ss6Ef2dH7Niq2VaY8dDTLHYZoXBWcnif1REJXG1a1DApRwscuucqRbZGAXr7nvgDn4QS0KRmUhsDRiAmgZjSnkfJ5KVV/1XeHCShmE173LOfButkvdsvUYnL4iaOLrwWPb+Yn8JkHbklCwFNtApq+l7BAAg0Re51alairUNcGpdL1lUTbeOu6ifKVoEuMCRIhk6bkHeC4+jeNuaWzklJZx0FQGPx3gd7E7WEwOtqCDGh8UdfwoRcsX9H28LnpZlEL6s531m+v8fh9Ty2ldnTFV0Fl3LyEKmlMm9oaIbmako0+ExTfUY6NlQupvCZY9xOtpn/6gmTmXsELq6eFKUyS931XKyjIQ4fGJ/LN4cHHJBoahc095F8ZtsFqlTBnprCgxwiW4UIqRQUGQ5njs3J/ff6jBKlGiv5eU+fzN9Lz1uxB1MfZeCBjG99uvYRrbzHJtBiAin9gBl5jWBIiB+66q2qD/ZJUgYfQeeEi7wBYugYag22Avq72wHQ2yc/cEq27Pi1I6P9+ZggG1lUZZ7UOBINfjaDm3uX/EsR8zlCirmTHW0UDFripEu51hlJVHTWird/h0vSz1DlVXqt9IaY2t+4JoAywoCx8Mu6GwGD80IStSDmqkHoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(86362001)(186003)(6486002)(83380400001)(508600001)(4326008)(66556008)(107886003)(36756003)(2906002)(316002)(110136005)(2616005)(8936002)(5660300002)(26005)(6666004)(6512007)(8676002)(66946007)(66476007)(52116002)(6506007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9uVudw7tn7x3Uo4hkJgFGtlTPfyK/9m4KONUmRaOQfkv8YzvIULsoxDPSRyLGEwWYoGUU0igcicP7nyMO8HGannaHV7ru/xLJTNFugRypF0Eo7Xbe/DWOJr8921BeNZcm3y9l3l87OZ4RDwc1sIoLk61YRwqFsawkxIlhtkrrkw3K8chnXKanQzTPVmEUlisxp1td6IHaR/vgu1DNE/nPBxXvk33WmCl6Q8gydYiZEb5/sVccNrTl3nZxsIgU2sW5ZCycSNFlsrruVPztX4TJmwSFC9PzJ+0xql/8ycQeFGunNaOsQCdfSdjUknJ80WDqo/aMJbgP9nGd+7bNfbMhNT5CIw62NT3wRQNkecNYxxBXLLZibVQpsUbR3lEjRSLROEfzCMz2QBExVJkVPDIB6FtTWLgnJRppkvmSRyHjMEjJtidyrS/+mMGCFWWGBQP
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ba8c82-e746-4aef-6ffe-08d9ec6ff339
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:33:01.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNPKBvAMkr7SKCK07kFyiROEkfsRVSQWc5KDl8Ct4vBYJ/QAXVCyiLS4+mMXDmQy3+nZ34+H4C1oRDo/xBL7lQ==
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
 drivers/media/test-drivers/vivid/vivid-kthread-cap.c   | 3 ++-
 drivers/media/test-drivers/vivid/vivid-kthread-out.c   | 3 ++-
 drivers/media/test-drivers/vivid/vivid-kthread-touch.c | 3 ++-
 drivers/media/test-drivers/vivid/vivid-sdr-cap.c       | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
index 6baa046..295f4a3
--- a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
@@ -18,6 +18,7 @@
 #include <linux/freezer.h>
 #include <linux/random.h>
 #include <linux/v4l2-dv-timings.h>
+#include <linux/jiffies.h>
 #include <asm/div64.h>
 #include <media/videobuf2-vmalloc.h>
 #include <media/v4l2-dv-timings.h>
@@ -893,7 +894,7 @@ static int vivid_thread_vid_cap(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (jiffies - cur_jiffies < wait_jiffies &&
+		while (time_before(jiffies, cur_jiffies + wait_jiffies) &&
 		       !kthread_should_stop())
 			schedule();
 	}
diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-out.c b/drivers/media/test-drivers/vivid/vivid-kthread-out.c
index b6d4316..13f737e
--- a/drivers/media/test-drivers/vivid/vivid-kthread-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-out.c
@@ -18,6 +18,7 @@
 #include <linux/freezer.h>
 #include <linux/random.h>
 #include <linux/v4l2-dv-timings.h>
+#include <linux/jiffies.h>
 #include <asm/div64.h>
 #include <media/videobuf2-vmalloc.h>
 #include <media/v4l2-dv-timings.h>
@@ -234,7 +235,7 @@ static int vivid_thread_vid_out(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (jiffies - cur_jiffies < wait_jiffies &&
+		while (time_before(jiffies, cur_jiffies + wait_jiffies) &&
 		       !kthread_should_stop())
 			schedule();
 	}
diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-touch.c b/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
index f065faae..8828243
--- a/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/freezer.h>
+#include <linux/jiffies.h>
 #include "vivid-core.h"
 #include "vivid-kthread-touch.h"
 #include "vivid-touch-cap.h"
@@ -134,7 +135,7 @@ static int vivid_thread_touch_cap(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (jiffies - cur_jiffies < wait_jiffies &&
+		while (time_before(jiffies, cur_jiffies + wait_jiffies) &&
 		       !kthread_should_stop())
 			schedule();
 	}
diff --git a/drivers/media/test-drivers/vivid/vivid-sdr-cap.c b/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
index 59fd508..f82856b
--- a/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
@@ -17,6 +17,7 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-dv-timings.h>
 #include <linux/fixp-arith.h>
+#include <linux/jiffies.h>
 
 #include "vivid-core.h"
 #include "vivid-ctrls.h"
@@ -205,7 +206,7 @@ static int vivid_thread_sdr_cap(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (jiffies - cur_jiffies < wait_jiffies &&
+		while (time_before(jiffies, cur_jiffies + wait_jiffies) &&
 		       !kthread_should_stop())
 			schedule();
 	}
-- 
2.7.4

