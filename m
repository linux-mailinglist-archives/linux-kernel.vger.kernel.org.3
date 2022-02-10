Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC03E4B0857
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbiBJIb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:31:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbiBJIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:31:51 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBE4116F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:31:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho7gKaqEvnqgRF+bFOc5exeJ5LRuork78BodBwr/BGz0DeaDPF5Bg2P6suxyIK+T+C3BFm6fghvgI1yyXVMGyndtsMIDjhlAJsQfuBk6+EFiclayOQORGROLekCJ5gxIUK3Arn2WbYyyOBa8/jel4BvJYt8ndpwGyQJlTsVvMvs6zhjDnBwpA7aYdCLcQIAaNIGrO3Vw5ZhWvziDtaeqTFaBjQFC1/WEZZwvNHzW2sNNeam4BrkLG/aa9EBVYb/aCF1/wv6mB0RSzGkdJ2Wg6ycHOAsu9wMquMo7KayXlLpcoadYbA8qFwfh0DHqAkqc2GtdIOqlwVxyir3DRfSKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6hLdY1Qujvq+S7yDcXa/zb+4Yu1bYhubykYgM6wR2A=;
 b=Dh4BfXPqPd4Xy5lcMwJv0eUtjgfz2ylDsJdKw84z22DHOGTs1oZN24PrRHqMkq5vCvwYFrc66Cn/6zT2+AK4zHl+ekwOIRVszyPzkJMHf42EsZi36pAcpDAlv8q9xIEPzA2xYXwzI/MiJvY5u/1jHsqnGhftQbX26HtXe1vlMz8SK1Oxo2oY0QnuEpWHa2qPIr2fnkkgtkITEl+ZfS555YZIO4ROgmEtfD1QISzQiApa5C/LeaiwLS0a0dTtwlwCO0gYSyzMCFbKFA9xD5V9f6Xwj4vnMcjrcECZsz6pY/yNH3xLg54dr43hRhf6jiaA8pekM0yHvRSNUA19PAZuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6hLdY1Qujvq+S7yDcXa/zb+4Yu1bYhubykYgM6wR2A=;
 b=LvzowsqCe2QX14j71oJo6DlaIuPWC3zGw+I1/Nuuv2mBjeNogO97S0s8ouELe6fPbD8RU52FyH8j3B8p8fz23CW/D/Qo8D6VeW+XtdCmd2GMOFPfyGpMOXHJ2Cjc6egKx2BEHcAsDTLSOC1k3KvJH/ywYdvJ77hOv0wn6t32oLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PSAPR06MB4005.apcprd06.prod.outlook.com (2603:1096:301:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 08:31:50 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:31:50 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] md: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:31:37 -0800
Message-Id: <1644481897-14862-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56401447-81e9-4372-2365-08d9ec6fc852
X-MS-TrafficTypeDiagnostic: PSAPR06MB4005:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB4005B03398696A436D766E26BD2F9@PSAPR06MB4005.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41mzeBTVMosngCND81i40R/k7Z3JwLYmXuhelSRHgET4XaRF7p3SEzVuaAel0Dtzg6wJEp1tOwrRXaLQeXpRG0IpGmfP/zxsc5Et+KvINlnTgWja8RhwLoKAU9tbE3DWCkGLsxrO0lIN8c1VbVOKIYNR/TbGy3bJH5LoG1YDV44SuexDAyzsQCo6uCdEo4jq8jcN9TtPMhxP+QygOTbwBkQIU2f7MjUD0onpnHywBXWqG4dokUVZ9A8RlNOknLrPzyaVWerwthD1Gdl6xKxy6X5LxEnyOJFmcPd2dcDxvDj1aRtFocC2mAwW/eyhbBboctuQMvDUscogofNrqWVHF19G5SpqONCns+P/XG7oSePRGI5j2mKxITMqL83O7sKppb2qCpwSqzrGBiw+Dv0oKo06QCFKDb1QpTTm5CSOEB3AjNIDCepEDnt5EZ5kcmCdfik7VdJsaFNm186AUgKgalDx66jdwiLoRdgFhW068Z9HPGXfSErNI4XVqb0yTTeXFKZQiujm2jaP6L/NQsb/687CowZ6h7/SUkK+pR1fMXYEBAONrfn8JOZPo7fEu4SQSq79Ddla/DaBUNX4sAVX2v3zwbrnKv7IVgBiGX50SE/NneL59TDgQ67UAKimoGJKmsZJzhhB0r2r5A5GQcWMcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(508600001)(86362001)(316002)(6486002)(110136005)(186003)(2616005)(66476007)(26005)(83380400001)(107886003)(38350700002)(66556008)(52116002)(8936002)(38100700002)(6666004)(6512007)(6506007)(2906002)(8676002)(5660300002)(66946007)(4326008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yKYBhp2Vp2kNDCcSLmPBOpAyfWSZueit588xShKP2bGuLrCwlNnrr8Yiln4uO7PxqQ9vWsmiMC887QKDw+Uud8dlTEuwIHOb62w/zYD+HqVxNhyis79XSA6a3KIVGi35Q7Jwpv97Z5wqYziq5EHB59qvakEKnhOqucCX7TC37BTo741dWUDl+xZogZAY+ZTpGZnD4tOgdPGtaPb1WtKrCVp2szov7ALABiP741OmvOCCQCvLdvwTfHK1XG0pNcpZ30lac0igIDmVt7CdP6IJSHmn7dt6eHdbZ69Y21YDq7UhgbcMzDx0gy4hoYks+8KxcZRgtYrK1OCv8CWmmieoCG2Ep6aTwMD0e4z3pQyYpFIz2ZyvU6zZ326F6U7blC4NeLRjDFJ1mmBuU3CQicPel+tYdwC/JeZL5X0E1TEac4IfF2VYU7ipZFlIRIJgPpde
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56401447-81e9-4372-2365-08d9ec6fc852
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:31:49.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmQigH0SGOH8ukl/buZSBMo5RCfbvFrq3LnCE7XzPatpTGwjTLmhhcaVJVVi6pp6kvgxDMa3TYNqW/3X9bhUnQ==
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
 drivers/md/dm-writecache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 5630b47..125bb5d
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -16,6 +16,7 @@
 #include <linux/pfn_t.h>
 #include <linux/libnvdimm.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include "dm-io-tracker.h"
 
 #define DM_MSG_PREFIX "writecache"
@@ -1971,8 +1972,8 @@ static void writecache_writeback(struct work_struct *work)
 	while (!list_empty(&wc->lru) &&
 	       (wc->writeback_all ||
 		wc->freelist_size + wc->writeback_size <= wc->freelist_low_watermark ||
-		(jiffies - container_of(wc->lru.prev, struct wc_entry, lru)->age >=
-		 wc->max_age - wc->max_age / MAX_AGE_DIV))) {
+		time_after_eq(jiffies, container_of(wc->lru.prev, struct wc_entry, lru)->age +
+		 wc->max_age - wc->max_age / MAX_AGE_DIV)) {
 
 		n_walked++;
 		if (unlikely(n_walked > WRITEBACK_LATENCY) &&
-- 
2.7.4

