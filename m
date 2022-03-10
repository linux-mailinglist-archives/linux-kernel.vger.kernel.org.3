Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61A34D41F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbiCJHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiCJHmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:42:20 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A82F1323FD;
        Wed,  9 Mar 2022 23:41:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GulxdkxOVW8qyjEaH0ytvi2ILTsb2fe3HtsCr7QVIDhgpcqsdcUYLMjEG/O7O4rHReDOuqnDbTPZu/hat8SM/qyT9I6woA2Vr7PLZf9vulfLUqB6hhkm8D1GG+ThGq5mRQ/VR8VWU2zkrNTpy855DdX3B9Ubjh6a1K4eqvXc92m4X/219k0D7dy4aNkAnTyIsmvEjpk63c0RWOwGWh8+Zn4DppVx/Vv/Y1Xch7VwDhvFEhME0ijbljVsUIeTY/fDp9lh5ZjGj9AnoMGp4QH7S1eWfW905/t61OWQYIpCurCppqgxjlwbNxaIyCAobZ+z5b1ZmWE4FtLKASs3rLPVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lv57ZQDeEd80m+wSsrn+YVvcuHhkUv4T1KlyWmNOI8=;
 b=WkgR9fMB6pQOeOSeYgwJNUKGOYR3vsJTcGRRsq5puMv+QXNrchWlJBPHmbTEJ/lfjME+oY5Vl9c0Jt4XVR8LBe1aim+RKAEYbFe6LMJVO8ut/7q0KIddNwFdrxhUuQpFceg9fwslsSOr1D++PdMymujQQdKHyiTuZSC4T/MHPpueWdQCyr0T5dq3JPWKtfNN3xVYmwIkGyh9ox4dnKvhoNz8IwGBoODIbmseS4+2k7VKwSTUHJHw9Kbg8DufT+jiaPdFRKg2vqc0VWk0BMzuEKF7u8bZ6BygOMWvvofLcWNauK+mcn843PpaFCw/FjN7LhpGFLD/olkues6rh8t6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lv57ZQDeEd80m+wSsrn+YVvcuHhkUv4T1KlyWmNOI8=;
 b=Bvx0giKaaVrOkcnE5RWHFqh+ukYBGFDLE2zVO8IOusyJ7gBkX8gDCQdGEcpLY/u9FiC+NDWjfV9mEEuqD1Z6tqNNureO1g0SbJzJG5l80BZ23/hzsN2pRU4dOVDpvFjde8mZxzQYQbFTy04xClpzFVobRbuVVJg+tuwnw8krCRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SG2PR06MB3063.apcprd06.prod.outlook.com (2603:1096:4:6b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 07:41:15 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 07:41:14 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] media: meson-ir-tx:  fix platform_get_irq.cocci warning
Date:   Wed,  9 Mar 2022 23:40:59 -0800
Message-Id: <20220310074059.12269-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:4:91::19) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fc8955c-aa1d-4ee8-7235-08da02695af8
X-MS-TrafficTypeDiagnostic: SG2PR06MB3063:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB3063DACDB588C898843A31C5A20B9@SG2PR06MB3063.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGQlZ8iNfTTUOzmyrHQ/FKgJf8kEmIc/+vIGrsuxIrZmaZBy7Vl3/n8+o7Uv9tMHAQte/sTmZEH0BPZQWzyhaRaLqn+M2thChM7fAFBUxWwcUwQBlonwOBGF4lHzAw35CGMTllLS+9S1I1SavAdb0c8AB52OO/btmfHDcp89+9cre9IYf8DzgII/BggJMFEzZzB9UmdA4hjo2Rw0vd9ZkccAtGvyG6q+yIPxaLJQgqXGn8/qzW+GrKBHNRUAjEpMCLLJl6PnziOHZ8iwmgFN319K0bJdNmtKJ3mchNv5/xV3RzQ5jT/fLnGCClxMPmzKDWP+q45di2gse+jQo+CdkDBWa6PLXFVvxHXlBzhrt7FmD1BPFUUtsy9SsQGebcXboribUDVZG3e0g2UDKaXYSgBJB8QfSNVrEMenDFjm1ksJkvVtdzhr4VOXH2aMKtDT7Bnaqoa6GV/zbHGVyEo6riBJ4szCwnRITd4C9t7gzdmOfY+RPumydNGSj3WbasV3kOgGJq6imo5b1DnEOntWj+ECmVRB1XlerGJngh0ZxqaFbL2M89dDDE13vzmYS8JeBSw46vdrAvdzNnMbMv10un1hlXsJbXoJ54oU5ne8vMYH+0XvPfw5gcumZNUo4MrrHRM+xbC8Q0gLGWlfImLZHQ1359Ild9jOSgMLhUAMWjaKyyqrDYEh9W4jP8ve7yuF/bdMiNbb1H8ttRjhSUhobk38tO/D1QYkDisg+g2MZ1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(2906002)(186003)(26005)(52116002)(6506007)(6512007)(83380400001)(508600001)(6486002)(86362001)(316002)(921005)(6666004)(110136005)(66556008)(4744005)(66476007)(38350700002)(7416002)(107886003)(8676002)(8936002)(66946007)(36756003)(5660300002)(38100700002)(4326008)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2CejvFRXL5cwqbH9fQRwOrFcN5cxTHbS2yaraxqmz8Dh/M+UZ/vVbIMBE6zp?=
 =?us-ascii?Q?QPRkJQ3pEndBo/6us28oOWfcjmczaLnHOXIbrQ8fonX4RSkXmTI+MA4TnxVf?=
 =?us-ascii?Q?D6UEEfDcTB6qcLljQcKIydS/XmHF8tdGYp7ntBSwtMgPy1hfc+WcgkGkaXOn?=
 =?us-ascii?Q?JCK4ial+MBaX08RLu/UQIGIJ77GOQmebP9IvLNBdilmjaeNMbhYUq7P/nnRi?=
 =?us-ascii?Q?oOyUk2O8leSXLvXjFP9uyhwo7oGuD6F6suA4w48ocCmjfVwYnX2x+SB5op37?=
 =?us-ascii?Q?9RizNriofgGIUqlMIuJ9Y+mV5ZXpgb/ev6hSkNIKCqOifbctsKGWx1J+qLk7?=
 =?us-ascii?Q?Mm/WutejDXEaH7CycwZVw/uLaI74ka+nMfZFQaywH5R5+UgLzrJlvk4pXCY+?=
 =?us-ascii?Q?jQTcB9Yea1vKev6gYB+mFIE+uy7j8QNOvRNM8WwU+EsPW+DCRRgpDpHL+7PH?=
 =?us-ascii?Q?yaTakvToO8/ftbiuAdWERHZejWAj93aACXPp2n81bTBDdiO1n8QaHUZFB169?=
 =?us-ascii?Q?t7r5qp0W39NYa6W3r9kxBaqIb4plYX8S8JyzU8gcLtyL78pcGmEPiLwrqKEt?=
 =?us-ascii?Q?a8tuAE6Db0T5MVyBaOFWU6x1JwiPGnMF5XLzMxJKbK3O71QhSdmhRd89n9vZ?=
 =?us-ascii?Q?wO6/P2nAVQTKUTQ+kjTVuyHHJNrgvjnnqZ/aytn7qPlYREuLtNsjA/JneI50?=
 =?us-ascii?Q?QBzUBvvWcp71lGXTguoetLaNmna/IHJw7ix0p3TFcKb/rPvcFl8fjeZOdbUj?=
 =?us-ascii?Q?bBB/sObawO1FnuQYfncovi2vbZoNrnABjBdU1pbnjd/qtRN0+XJxCuUSjqRv?=
 =?us-ascii?Q?QmV3+MjuAzB+2en7+6RYIt0e2BgI829v9Ug4XMVeLCEwP30A+ngecItn7mhp?=
 =?us-ascii?Q?yzsUIYRLDl79PThNFKg/cpUxT7XltXnMp4qGVVSXKq40G5CEYx+RNAI+56AC?=
 =?us-ascii?Q?xncohejr5UsVqoY9BDs9eB9jtpd7TgaRUZy8nW424+efDL1b41AnuNU7u/rf?=
 =?us-ascii?Q?czHdgVmlSfrdMK7cHwxSNly6SRRwdZyEK9K+hNXWfnKfWCeBu3TxgBxnqXNm?=
 =?us-ascii?Q?5YJ/uPi5VOWpx9pmqFToG00T/JxYSFP3w/yAIRgwdk1kz8ya9vDqguGBoEN6?=
 =?us-ascii?Q?PLbY0+ABBNmwmQLCeEi83N69VUXaKvZQJ47EFDkAdKwTJuRkRzWFJak02LVQ?=
 =?us-ascii?Q?r/kjtkHIxiaXgcDvVVvSXGxQGxBXHGIAUh2cb262dXFckCm+yCs5zT2U5GSU?=
 =?us-ascii?Q?xuJXgTSXqUsFYuz8kosJyz9B7SKzuJgArcznq+nFuAkyGdj009+rOQnxbboi?=
 =?us-ascii?Q?vztStIsK9Uq6XdN7J1FYtQCGn8jA1vGYpZQodOwczAMXbZ0RMhD4AyikNJ/q?=
 =?us-ascii?Q?sto3wHNG/7RBroUFSqzTw8e1GW/dDAm9QNE5rljbxUxPHJHIyUkLjK0+MnMH?=
 =?us-ascii?Q?5WWNqrTrl0lWAC9SwZQeEEURMOVR/0KEJ6EHedzpv2c7lKQQKYKYo5IYAXYW?=
 =?us-ascii?Q?8QVCmPDnQ4vResznlPFtlnbL023xG1Q8yQ0+o3hgCQCLtdrtNm6nAbpLUTi5?=
 =?us-ascii?Q?fU5bpyth28WZ+nX8C0tBNkb+Y7B4hCZGcrNNfOVvOXO0oZMkFMyuECUxHaiQ?=
 =?us-ascii?Q?V7KiEe27cZkjzzYjQSeJLhE=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc8955c-aa1d-4ee8-7235-08da02695af8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 07:41:14.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XWdjKwXd3cGs2J9DxkHJBwkRNcPE35n52GOMYq6xskWnfvmIWBsoNMJG0blvQd5bUq7KFSkyNFrojBvn3Ju3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3063
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
 drivers/media/rc/meson-ir-tx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index 63e1dbf0a4e9..abdb62b16e98 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -323,10 +323,8 @@ static int __init meson_irtx_probe(struct platform_device *pdev)
 		return PTR_ERR(ir->reg_base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq resource found\n");
+	if (irq < 0)
 		return -ENODEV;
-	}
 
 	ir->dev = dev;
 	ir->carrier = MIRTX_DEFAULT_CARRIER;
-- 
2.17.1

