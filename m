Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5E44B085B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbiBJIcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:32:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiBJIcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:32:04 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E6B2186;
        Thu, 10 Feb 2022 00:32:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6G4BQ0SxrfTiML10Qt/j2jBVjtIVrBUoELNFGMU0IzyHzkp1/I0RwaMYGZFl2j/bI7/B8UUw66ZUtmC/8Km5n61uJLYp6Exo/LBY6/mekDezgNjiKmzZVfbKmG4OcZJsi6zuoTXxjOcVBH1PM2nE37TL3oKUYNgih2GGaaw4npMDsc2Z96C2X2KaEUORKP96okM+9QjDL6vdt65JsnM1Dhnp0ZuyFvjXxPfpnvgAeNwefKvVE1vy0wxVYD5KsLYVDsGRC2zP7Hvk8SmayjBBpgmVW65LAgJAhbo4WOVQsEKNOGhtMxyNiAm0S3nKPkPKtJE4yhwwC2AgROdZo86Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx7AjB8df2EdWjgzfAyEDJ0FFVJsR0GJohlThzhTZE8=;
 b=IZBXqCUxnRhx+HVZYBAQyW2MOxuC9Muuca58KxUEyibKQqoeu+mETvKVNuyQk7ZJ9XlsODtvrbcVdnbyTpIpNWNdrkBVDlfBZhvsDeC6sL3ejrzUzG0nXbi3oWPaoy4diGmFtcIUpIpCpOiYwcaSEXwNlWXTzcK2N/WsHoan9xAANNAvisP/9M2G2P+sVmQI/dT+G9y2g2w2xpmrRm1wVRdOHsnQ8TIcuC9v6TDYZZTMn7qh2SbbdnQPH7YC0dr5dzzyQP5fMoAe5rqUrnIaWrW5ERjMOJTcNIOoiWPaclQSuy1TgTbIbwxeNaUxUKhpnpnfNFVdTDObAGcxJ9F2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx7AjB8df2EdWjgzfAyEDJ0FFVJsR0GJohlThzhTZE8=;
 b=UEdEyZsVbr8qCzqrw/ja2F6UxxlHBXHmj1UqpDPa1wVIb3TSHymm42KBN87x3p5nfMBzd0qmRnZfeKofXV3JA9/vswqijV8Vq4FEoDK3Al1A7qI/zBwnhOPNFgoch+CYZiZsZ6aYsDGc0Ca8labumQ2UJ/q3JC963ytIYlLn/Ow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PSAPR06MB4005.apcprd06.prod.outlook.com (2603:1096:301:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 08:32:03 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:32:03 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] media: si21xx: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:31:57 -0800
Message-Id: <1644481917-14908-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0154.apcprd02.prod.outlook.com
 (2603:1096:201:1f::14) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5f0c18c-3013-48bd-2dab-08d9ec6fd078
X-MS-TrafficTypeDiagnostic: PSAPR06MB4005:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB400560C23456AD855CEDF2AFBD2F9@PSAPR06MB4005.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:231;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgP0oiLqqGfN5JIgmYpBtfJB6XM1M33xTwsWzuDL/j1uDcqyg1nkLY9rcrasalaocxHls27D31QPFDbKScBeyrN5TpT0jVyZQlaYvInQ2EM2Y3b0+cv2guRdOKkl7AD173OfCt2hRnFCTPTMHYO5YNkIUmhl98uQdSjnsma5clPTdI1GnH8xBSUMCaNgvrzOv3/2dc1F3i/1xWIVXdgBWwTi3B1rPozCgkzdE3bLt2Rsf2vpfLCJFhusm65XAd/lwIHkdRG9WUGKyy1ghICCtGRl9cAo//9Z05qy4KPrq1TjH9IwlgDNoHJoMW0rdwr/J+YX8gxIvPbpXSlB/v9Flunuj/az/4zKaIKnH7erCJOZqhIO58vuOUOLMg7VhhUSthGHF493nzZWDZBds+SgQiqtSqTGpbxKjgTBqpIlvjd7U3KxeX5Ev7oE4JsdJuZ5T2UtYA/8AF/XqIAORUFf3QGdTrOltUK/HFvRV16uHZH8/z1SIaF/qYwruJgnhhfwNCbZTNuh7xJ3avpA610OB80/9AzF9tI0Zn+3XGkIWtY3jAlTC7Yk46+PQ4XLqf0YjjfCc0H1tdy9zM3LqzniSR8duYjKJYUQ/WF2Lz2yC/+vWoQ9RsxUOADNMzOhfjUXCjssjfuJZz4ZQ2o+ezHYNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(508600001)(86362001)(316002)(6486002)(186003)(2616005)(66476007)(26005)(83380400001)(107886003)(38350700002)(66556008)(52116002)(8936002)(38100700002)(6666004)(6512007)(6506007)(2906002)(8676002)(4744005)(5660300002)(66946007)(4326008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UZiBrcTEuMW2egFIajzPXLFTEa5T/jh05GdEo2Kr9cMtHSGQncrzgV7AmLIWN8Iuk+sS4Qs/njRWQ38XRJm+qZXrFibJUIk0U1hUfZiL1lSTFnp/jre4ZFBxEyToFSuDH5wB9YtAAks1B1wJRXFeh9MAz/VE2k+a2PyL3bz36ogkRlFxh7AGV05S00IBpu5Xp03E5269sQxIvJa3CBiDMcHzZLUS+iBD7VsBvmS5Z1Z9XHtXywTYALLaKm4PbUuj3MnYdnufIkJOlm3nbJS7Pj52zsWoI7m4vsedCxIILGkiU9vNa6OPq2WB8XbZHGFvrosBn0rhB6bXJyWE/gsBarRhcUwKf2LtEwCCEhJczGYWw+zshJR/4VUqIudG0SrtWz93z2iNxSWCy1SkJj3fP+LA5Gvlzmb+bHqDiileTARpPmoT5Luo39GA/7BvxEYk
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f0c18c-3013-48bd-2dab-08d9ec6fd078
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:32:03.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryirJbSuJkC58PpzTI7LZfNsBCCJ182rSzUIusns9AVkmEX5QgUzbYWW1OpaFP7op63Bfm323glEwZuPSdfstg==
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
 drivers/media/dvb-frontends/si21xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/si21xx.c b/drivers/media/dvb-frontends/si21xx.c
index 001b235..1c6cf76
--- a/drivers/media/dvb-frontends/si21xx.c
+++ b/drivers/media/dvb-frontends/si21xx.c
@@ -336,7 +336,7 @@ static int si21xx_wait_diseqc_idle(struct si21xx_state *state, int timeout)
 	dprintk("%s\n", __func__);
 
 	while ((si21_readreg(state, LNB_CTRL_REG_1) & 0x8) == 8) {
-		if (jiffies - start > timeout) {
+		if (time_after(jiffies, start + timeout)) {
 			dprintk("%s: timeout!!\n", __func__);
 			return -ETIMEDOUT;
 		}
-- 
2.7.4

