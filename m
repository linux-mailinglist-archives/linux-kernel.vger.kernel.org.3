Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D14B0864
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiBJIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:32:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiBJIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:32:47 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300135.outbound.protection.outlook.com [40.107.130.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F3218;
        Thu, 10 Feb 2022 00:32:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9tvTWXOd6A4wcRxXoCuHBj1BaVuXN9OVwKyLW6incucm5n3tOyWfoszibXG/PCuIY/Dhy6MGobfvrulMMPQl2/qNyiYjwd9wjIznBO7ikSJ5NtKwCBSt4VCTQTH6mwXCsm0qdN+5sZke7X1fr7UkQX+8T6SJWUzvKQsSgZEbtU2su8ah9s6hHMKPiV2ALyB7qZq5iV8hcNRd891MwoUwPJplRSxvoyI7KwoxaETnhWUOwzTHjQ3XFFd3TcKdi+fFZzZBI7KS6FJAQdQ1En2/mqZ5QK0Sfs8f3eGwmtENJO2MNx1dKrs53yA0bj8Xtsf0mTOdFH3XzdFvXGQxtf+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kewc060QBJROOhHw1uJ1EaVBA3CRA8Je4Vr2R6NFvSE=;
 b=nU0/bGU7dNH0qNtqnligL4oECffTwv7yDlbMFitBFkZxZ7VxpzdGLjRTQHGNoSW0B23UChPNhkJ9pgOj7j7SFxrSVwAa4dVVShiKcwdSN4IdkyfeNwK8sFuauGsEKDZ9tGGVUaabb8TksNtPCaU7j9IIvrFqsagdO43BpHG1Ccp6x3lgi9IE1aJo/UPYecbaITtOIJsT9V6NbMFbbdsmd5bbs0fCEj4w2Jz80aawysQ+70HS5SBUblEF2nKqPbYDcij5b2Rh5WDGHKsq87hHfMoqe6uPu3cgCSKSEh55ShnRzsfcTlduiFYfMyYL7fQZ9OD/9zaP//iUjJeHOJyG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kewc060QBJROOhHw1uJ1EaVBA3CRA8Je4Vr2R6NFvSE=;
 b=eZB3N2ASHfbe9IJKfeecKZ6isW1uj/KH3RwVnhiAz3FLkkXPBPzoZE7m0rYcErbaCtIynqwjx907EEQDRplPavOBX6mM8mBdUs66Z261IYI1n+2ByhlYHFnpTGw7HS1fainRJqIzzBplbNt3BUon3dLV3QDHRXT9gvnmI3k5NGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4068.apcprd06.prod.outlook.com (2603:1096:820:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 08:32:46 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:32:46 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] media: wl128x: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:32:39 -0800
Message-Id: <1644481960-15049-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a47afcf6-f891-4245-b41f-08d9ec6fe9d8
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4068:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB40685848A016D4108C2251C6BD2F9@KL1PR0601MB4068.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQuCKPfCuHL6Mz5Zd3bMDFz8FWybrR2dI5uPMlYTWXTUV/pOYuzh700RDzuYxxQCMmQEO5uUiB+5nIPyFlu9geu2Z1ObZndaXElAxbNZ6Cku1J24L83zmNzvrjDYJZQOZMYPByQQUXdZ1213UE5BpT8OT2miYaqxuOk1v93T1fLCufi4WkQy+rHNMZnn7UCnvFopA6S3NSh9UuxUJhmMt3VmEm8/Nbp+DN0cnFnmAhfMLNQy0lbAZObJ7OvuW5AZPVuSYEnyX11q1m/07d+eTXmbaziDJuqeUELD2i77+yW7+6il8PGYfcOdb7ze128uuNsBrGwOzz95AxS3tUA57+TixwKfyVvTYgDsSDCJXgdg7HU1RS+sMsn0Tg+CGlVnWr3Xsvij+0fN9jv1rLsHTNewNyChqyFvBShTt4AgKFUJ3uRvn/k9shjtKBpxnuVEOngjGhZdJVi0yb+cvyLcKo94biCSPXG/DvjlJ0sdT+A0ChFtRmMn37h+DgChUHjUo4qkwQ6dTRGyVPowy+ByuWFNuy27OtELrN5Nonc8sSgrQCC/bWwPBK16FMoMfhmgrRBeyqaqzD4bA0uPGrw8web4zBxTtpTyFnUvfLohZUH0HqQTEwOH5bHtkeyoE6VjCaLH41D51IRr1PS2soeTAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(86362001)(186003)(6486002)(83380400001)(508600001)(4326008)(66556008)(107886003)(36756003)(2906002)(316002)(2616005)(8936002)(5660300002)(26005)(6666004)(6512007)(8676002)(66946007)(66476007)(52116002)(6506007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BmyDl/A9dQaXrZ3XCSe0LEeC+YS3I7VUBj18SUwKa0VA+sHwEvgvBeh3v/sIZhU4ZctvqLebqwwpqqP6IhqaHWgeeGVTmWhZVesHJdAAz1fvc8qTblkR3j/GOqOApZpFITNvi0JQ5+q+2NzuvMyJIoFMxm59ukM8SgQDQUo2a9jPjOEhmLvXFC0iHeIr99pMoF+GRIQ4wxb6BpMXJdjPWJKA8pU8KduenAhmBBIEPKgFRiOqBRWyHAcOA49oJDpffMe8KiWS9uK6/2riqPpGcMULmu5uVsFl5cBMps+UEhHy7IrPiIRKG4YRWG1yitLaRK2w8FcJTNq+DbipdXZNEj+T+PZ1VfEig/caLQcZe/7cNQVaYXKGZv8msj5nWObG45vvSVgtMWg6kBEHl8gdz4pFmGOXHEYiVaT545zrHv2T2EtJUHeqRzAtVmVrib3j
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47afcf6-f891-4245-b41f-08d9ec6fe9d8
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:32:46.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9CQ3Q+nONZ95PLrMynF9w6uDdU0u6d1AUiZ9a7kvU+ZZbe+3DZz52lH4Arcfnc/nUwA6pT0FGDSLsDopfokeQ==
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
 drivers/media/radio/wl128x/fmdrv_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 6142484d..a599d08
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -23,6 +23,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/nospec.h>
+#include <linux/jiffies.h>
 
 #include "fmdrv.h"
 #include "fmdrv_v4l2.h"
@@ -342,7 +343,7 @@ static void send_tasklet(struct tasklet_struct *t)
 		return;
 
 	/* Check, is there any timeout happened to last transmitted packet */
-	if ((jiffies - fmdev->last_tx_jiffies) > FM_DRV_TX_TIMEOUT) {
+	if (time_after(jiffies, fmdev->last_tx_jiffies + FM_DRV_TX_TIMEOUT)) {
 		fmerr("TX timeout occurred\n");
 		atomic_set(&fmdev->tx_cnt, 1);
 	}
-- 
2.7.4

