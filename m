Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDAF4CBE17
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiCCMps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiCCMpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:45:45 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250B818463C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:45:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glslawtmKNOj46+eodnYC9nuhAiWqUAnk6nORi3l0Wh+xR6DspafVHQq3QuZMhYWYMHDFJPUAncAkwZTzPapf7eS1YAT0pQim1PBXaX60otNNz+YmVRBUTxv7kLPjdQ8Yx1FyMhNk9tzLYlTWAKvdRczEMTzx7EXFA4e2QOTN/BAzLVgDKiDGJ57SpBlXX3IuoZzRILbUJnUgGdq4WrnRAz9jOS2UypJpYppR1JIteogGSGd0w4k1MiUAYpOHDHhH62m4qZXjNcr/2PcCVcjSsloSMIrgaJoaM8nldu84uGpGc5IfcoMMXGUot9bKHP66YXJlOmge7/UJjnHIZfeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNGPPpCeYiVyr3c/JMejXkrPuzsrtgPunwWHin2lSo0=;
 b=a4JCJkOuv6Be9OJriqZNYzmMnJ+MH/5G+lSxQGTaIEUtzSw8yQvl6is0r0xBLGVCFB16olSrP/bMMTB07rh3T30+c6oXhcCwgDVGoKfPD5uG5o8zFkVDnoluHJXMfjx+8Vu6mYESS2tNzJuzpBrZuUki74gms+tMHX759m3cTFGM88tIVxX3yWM6PyqTTGRNlI1dW34oo/W1ba7+uM8qDneYaaGBWj2Fo5vfltif+LCzIEiVh2kEEpLzwku9JzOXOc1Yl8JCNWl2vPt5qgHQg6B7DE+QY9RyYY2ma/0TAaNABvFJ32dYyksGGtKBJoC/pK9a4XKSG1hOHTxzBee2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNGPPpCeYiVyr3c/JMejXkrPuzsrtgPunwWHin2lSo0=;
 b=NprYjWfObWgEBeyuYVj/Tf0FSxISXiT3cgn9X7mFr1ouW7cmAbS0c5svylUHBJ7+d1+ZBDPsUt4EMwXRlf/RjtyzZOz9Mrj0vT+BLfwntV1rDDjolNAzoMrhmXit3mV2tSFAZCa2mSDRLzuT3d1N1JGxGwaZSh8jw4iFxiFbYrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by HK0PR06MB3219.apcprd06.prod.outlook.com (2603:1096:203:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 12:44:57 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 12:44:57 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] soc: ti: wkup_m3_ipc: fix platform_get_irq.cocci warning
Date:   Thu,  3 Mar 2022 04:44:44 -0800
Message-Id: <20220303124444.3373-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:202:17::24) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7861270-3d68-4118-451f-08d9fd139f43
X-MS-TrafficTypeDiagnostic: HK0PR06MB3219:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB3219AFCA9A00663FAF48577EA2049@HK0PR06MB3219.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDr9Pu/YlOc8jOgMDdlalY+qwmR1g5ZGYwHGtFeojx+nZKvS71j8HwtMImTg80KOzBdCeIHeTr0VkTOidOq6ptTKe7W/+XWrDuccB1ubPUyMrxHm7KmxcxH9kqCRUCQxwySsI5FiogLSoosmaFa+korOhuNpxOkYZJX2/6Xw+o8ZpzmVb2ho3REzmyzfZw1MX3B6fhIU1hx2ewljWzqu5a1DmDo/14cytU0COk92Z1xrXAkltcvQdFyM1BKKs7+WEqPNxpQuIpX0ycMUqRO409fWk2U147iUiQncJsPX9g33Zza2tZMEB0kOv3Am04oXvJPqfnB499aEkRUwIGPwijtBBcKtgGffSBSvLIgOaHgSE8MTBhR5ciHlXPfyd77ZimirPOfN8npZaPQMlUEiFFGDWlxiEqpbopr9EaopXv3vc1hQh++gHaJwoJHtibC+TkTTlvgmX09EsxgNzgcPHUEsXVxDsAdsU0kFe+A/2FiK/3cW2nVK2cKFUugi75zUfV1qjTPESBhYcL577+dVOYVln6MLbkXkb4qYXDLQayCAQ2SAjVRpX3oxvEy/VsbyjD8ALJUUCMWAtRuXfNO/qcV7qlNJiMV7pMo4Za4bgUyqGNFqhFMEa/U+7unAUG04SG4Qdy2qEQAul8cheK4/ZG2ARj9Ck7JU7Fo5ymKF6S8C5rMHwPjHWcD/pWTFIV0R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(4744005)(2906002)(86362001)(110136005)(8936002)(38350700002)(66556008)(66946007)(8676002)(66476007)(38100700002)(5660300002)(52116002)(6512007)(6666004)(107886003)(1076003)(6506007)(2616005)(26005)(186003)(508600001)(6486002)(36756003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jD8/2delJiORWLgvTqxyaZwbu54etR7pXQ6a7Hfb1MJ9mxdtvGywGuw9cf5b?=
 =?us-ascii?Q?w0TBukESNBghW2QebUzCCkjEKszB/ZcufzQ3UnusjpT0BXqWSu5G77kV/eMy?=
 =?us-ascii?Q?ykWUi0w0HmIeG0OJdmVkVaP4URcJfJQeDD1yMckJCDuAp3HJbg0YKXs5+NmZ?=
 =?us-ascii?Q?HhI+WiqDTB+JWUGx4E+FqGsLLnbjrpImtkkRC3MchLrGTOwJMOHOlzPAc81X?=
 =?us-ascii?Q?1hBffSDfNJsDcxU4tCd100PjVDojTmTnWPpdY1PUnnwcgxIm9CV6mRHNIgHw?=
 =?us-ascii?Q?Vtf7+um4t/RG84ENixU0ku7RiuOHqUfL2cbCQBYxVcq7qpC++K5deAPLaVNb?=
 =?us-ascii?Q?NxrKGNg51LFLNfhPR5+7EvS4I++kok5d91Yg0BgxkPHuo33OxSLcq8mfaQz2?=
 =?us-ascii?Q?zST38idqPVZtqufiTqEQ6gvFB89Mw0ZQRbpcQB+x9oG0/6nQKoPCG1AQrsaK?=
 =?us-ascii?Q?c5Xc31XYUXE2i9aFEz0uKaBF7ec3XFrIEGswOuHYMb+AwaQ6+6sq3PsFhD/n?=
 =?us-ascii?Q?lDiX9E6RTdYJp7pdmop/oMsRS2Rqb4SC/POZyJSW76kpYvX4Qk87XIyrFVFR?=
 =?us-ascii?Q?hR1QNH8fFRuJr4dLjCXBqmX7jaTEjFW2tVjbX3g9UsQF5HEn/k+p0B34oxG0?=
 =?us-ascii?Q?WgvTDP7gKfd0XljrVncEx5wNSHN4IQ6jad7I5oODA9wmhCLIwCVYlAIx0ZzE?=
 =?us-ascii?Q?N3jl7G/DXr5KTjiKpHY/XcMzlgfkkpOx5o2Ice1bvJphkCCKUAZMRpcV9oSx?=
 =?us-ascii?Q?rcdrWrYcYeQragAc8pUFm8Z2RQbaBD1qRJNdJEWraN7+0Gs6uPvOnzKlXqS5?=
 =?us-ascii?Q?CwHKQcercQb3Eqgi694tcbuKb07I6Dw+6xrr4JaVeho29puKh84DNncGoCuJ?=
 =?us-ascii?Q?6TcebnVdrMVKONZtU/ImDPQr0ASmY+4G7KV5nSsWfm5WGXHOzPt06gCaWccM?=
 =?us-ascii?Q?a8dUbV/BQ4A7GUmvSg9eF8n4aw8IqH0Z3HqshQibRgfwLsC8OmvIInVwVHFa?=
 =?us-ascii?Q?8vtH/UlFlffxlaJM5dDV65BIKKuEp7Wz3WzcA/ZT9IYAkZyk/Gd8WDiPKtCs?=
 =?us-ascii?Q?Zj1IIKgjpkJUCQtMwxKgaP7NAQ69J9PZ/r8VLNufAW7E8kM+8paeMoZ6hpXW?=
 =?us-ascii?Q?e8HoZ+PTYzihSD+itrjw3sM+BHJFtVh3MlhHhOGXRrjKwH50fuwbNy7R4ZRs?=
 =?us-ascii?Q?QlSKD6d0SQ3T6HK5ZfJ/aw1HfHbxPmYgWi//MI6tMKfgouDeMyDmPzYjiCbZ?=
 =?us-ascii?Q?3SVue0VfoGHfCDrHZ4CuceD5VdUeQhFCOYbJw4rIHFgTugiqr4vL/nvYu7wr?=
 =?us-ascii?Q?rftrQ908jEWa5/c3/545T6KkWUaZQ3fnuGJ9rAfZm+XH9D2iMNF6tqBicpp2?=
 =?us-ascii?Q?+GOcHp9/LKnUqthgJk7CulcwZCs73PidmDBgahnXBXwnQos11AvsgCflR52d?=
 =?us-ascii?Q?tleD348yrHrXBJmn2t6M3fTHjLUuYrq2s8KS7CyMgOFwsE2vFyYLnhVlXW7e?=
 =?us-ascii?Q?snhDHVSBeKsngqQN+0K0hu+jZwRn+4tDn7zsA8K2cFni9/wiK6QoT0JGyYUw?=
 =?us-ascii?Q?tt3s8d4ttX5pDNqh1crvzq5Jui7HhO2izszizof6IaCq6rzbQDRNdyH2oNhD?=
 =?us-ascii?Q?3Czpz0NsELJIDRQPKvaMyak=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7861270-3d68-4118-451f-08d9fd139f43
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 12:44:56.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebM0EzLGEVhUx/1OfrkkzkP5HHCobaRJ7vH/T8QvnS3w/hkkPBgqtgoywO4pZiJmBV7rnJJ5X1gySpzZ5qnUzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3219
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dev_err() messages after platform_get_irq*() failures.
platform_get_irq() already prints an error.

Generated by: scripts/coccinelle/api/platform_get_irq.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/soc/ti/wkup_m3_ipc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 2f03ced0f411..f145e65041fd 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -450,10 +450,8 @@ static int wkup_m3_ipc_probe(struct platform_device *pdev)
 		return PTR_ERR(m3_ipc->ipc_mem_base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, wkup_m3_txev_handler,
 			       0, "wkup_m3_txev", m3_ipc);
-- 
2.17.1

