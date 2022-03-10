Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC24D43BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbiCJJt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiCJJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:49:24 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9637125C9F;
        Thu, 10 Mar 2022 01:48:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=augWVoaibgtLB5BOD+n2oDGsHGaUJWz9KQ0zcBSa3QBW43zCxyfL4m6caKqgHYAY1LtJfC0n2HW1YYDSrgIbaCqkkFO8hijlLWeHyBYppTNQmY7RAZ0/vyrJX1YSWqz4/ACjN0WZrZLg2KyYXqchhuR7fWtggcNP7GCjUHvO7MHZRpQG/2oqfTtI2bPR8E29IzrHsuRcMEo9k62q+LQR2JRkgoqChiTB5v8BqpdVKoFkODEq1Pxw1Dqkpt7aEeHJItwWnnyl+VxMjs7l1o6WugQVt30jS706vg9ex/reuCKsovnZeDhZzoNTFSvmtU9sdeRvL7Lj0+9Q2jfMrRmD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQftdU4xHPrN49RZbHmGY4m1rLaAsap84Dtb65x/gcM=;
 b=IDFeMegF7uVcoJ636gOJOuYqeL2X/01+nvGkZBX9Fck0XnKl+e98ql2BX4XXz1c72q5N8DViL6nQz6pMbGgosBhwcIt2tanufOeje0Tv2seK1JE0dvfCp9ftV9nv30uGD+u1STFYY7eWYxr1hmtWHZdoE0EcBFwdAnl/y5dIIxOwgcIk6XqtllQEhe+yHfylZpi7gZNS4+0Vy5WPTF42x/81C/aZPbCemitjqRzeccTo2XNbXMrzfcJ5TbaowJ6p5pueieJwJMXJmFMxsmc1FXuFrubFgY4BW1ctis7CfAUyx4H2lC1wHBwzesTuMKZtDd5MC92ue8K/fpMLaE27Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQftdU4xHPrN49RZbHmGY4m1rLaAsap84Dtb65x/gcM=;
 b=a12KKMhOPISoru8+hN3M2IA/kyKq311AblgTUFymIFSMy1orpzqjTJo9DAz8+Artk7OROPZHXZYk9sgycdRsyyQIN+uSAA5Qsy6aTsUJZxhpTE2sMzbx55PLqNqlXM5Td0X3/R6yBWEw77ZFwAv1tw48SwxyFYuAgcFdKiCOmQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by HK0PR06MB3858.apcprd06.prod.outlook.com (2603:1096:203:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 09:48:19 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::30ce:609e:c8e8:8a06%4]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 09:48:19 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] spi: rockchip-sfc: fix platform_get_irq.cocci warning
Date:   Thu, 10 Mar 2022 01:48:06 -0800
Message-Id: <20220310094806.13734-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13d8be47-4bb5-44c8-05ea-08da027b1b4b
X-MS-TrafficTypeDiagnostic: HK0PR06MB3858:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB3858155B5062D5B2E5969286A20B9@HK0PR06MB3858.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+vecqVIQVgaXvrg+IPFv/zgdKborkIAXyh2Pwn/ituAAdpJxW/6gd40bvEjx+/uLXJHATn9bY8eoj6Ik8Z3huHyX7LjGtFdlXN3rjMAO/oy97nebBRg2esNhw494zNfil0CbQBLvbPgSTDOwq1m5tVdZ8Qy7s+wkSfQIvp6DMjcaVBxrBZwFjYBWSQEoSAo49qF4bHhdgSEO3GWzPitNpHSM/qCreONSTQref8LiGhw4IleDo97vaHsPjnN59crAdAGuZ5B42LNqBGGCkSKKYhQV3RfRE0M4J4tKjy8yuGvhuABBp9FqB4dn8JwzxUNNwTCGBv8kh8vIR20wHmVbRj4iAa2Arn7hvotn7UTNP3XhB2aTrrRyjw//Lu7H3nhkYYXc0cZDJUu+raZI1RJ+UJfkLklKMFUhdMY4/2T0K0OyXwWIft1TFSpdvF6VZrG6kk7Ql1SnAQvbUwluoksbvXMOLBh3NLYUBw3qMv/0BUBBH7kosJkI/ePcoZC2FhApYKeoWQSh6GmGQIHdAmHHWtB5AgV0C8PDg8NQrVkuXRv0liimMz0pFJvQof6NruxwbFlihperKEtaB4aQ4YDyYeaaHj8u7fPi05jVCnduDlQUpKzfPK7QyluTMsk2kReZ1vWs4PdtvpgqWioFjvFy0OiXIvKoJqVZ0ITn9BA59V/emPjvgifTDC0eZzbY85LbOY4mTKn29HE3oZ4rwmm8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(66556008)(8676002)(4326008)(66476007)(83380400001)(66946007)(508600001)(1076003)(107886003)(6512007)(110136005)(2616005)(6506007)(316002)(52116002)(6486002)(4744005)(8936002)(86362001)(5660300002)(38350700002)(38100700002)(186003)(26005)(2906002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gIvkth4Pduc28AzVI1Z/SWyW6Rl+qiKawIVexzq7vio9VG2tC1iohJBPQ9TC?=
 =?us-ascii?Q?5TCzoF8ItBoIjjFdr1H+b7dfC61vH2Uq97z+1Xpn354uczVVk7Uu4sG6KrHQ?=
 =?us-ascii?Q?79Y8l92mhmoCrkFOB7seL/roQH7E7bOh5Y0jVDBh2Gz7Yo7KTlaHTHgRJMQL?=
 =?us-ascii?Q?EpqxMOUzxUoQ+F9iUo+y7KP6OAjQ9xEuVx19XrmmS8FJ2hGwhHeLsIHtS8lt?=
 =?us-ascii?Q?ymRIM6B3Y7SZfYO4UE3exJ+J1Nrpw2XtAi8jm5va9TIGc72zfZeI/RKKP68Q?=
 =?us-ascii?Q?q0kufsnTCj+xT92XDTl24cXQpc9BPlhZgzpcu00/jwNCXmEM21jl8WyOeQCr?=
 =?us-ascii?Q?hy9pH746NegnfarP1tP7YsSjFkwQg5IIcXpf4g091X6tw5jx9pbJvfqDRCk6?=
 =?us-ascii?Q?H5tXsbEJeeSiwjgCRs6MlNzFvE/eIVAFwP6QZAnjxcHJev3QrstoEm8b/BmM?=
 =?us-ascii?Q?iBaqCuNfjxENs47waqWeBb63ePYZpd94YT/Hs5Oyth+s3bTTa7aNF8n7CqtU?=
 =?us-ascii?Q?S++U+E8dk8T35Zv7wb98N5jA80gSf3EchhMQXnbOKB7C1XXGm088G1Na4QKA?=
 =?us-ascii?Q?4bbVs/QAjyxVrpWI+0FnqRVP74xML+6HaYetLgyu1+pnD6XoHlKpJVSBnclv?=
 =?us-ascii?Q?YU7arAf69bFGmNA5a7bOz9H/IYPER1gr8jS4nIX5EYM6WberIEDs12URiBYP?=
 =?us-ascii?Q?FMz/3sZjkKwvZ4yHGHFij31P2eV1xmOx+Rs1ZLrsXp79+zOqnCeWK++B9Sw9?=
 =?us-ascii?Q?sfpAocWtBiVQIg5SVDa/JfaJAZ5TlDETXEhZiPnCAiQr4c8i+heYQ3bSaLTv?=
 =?us-ascii?Q?y12qeiE/0Q0fPbkM/Ok57VVtzQSZwVIwvSzauLgEvUOFFoRG8UtBedKdoul0?=
 =?us-ascii?Q?jTaxl5qphLj0C+qiElrL5w3ZxNZRUbvWljd83kATJJztP6tHSz8CDzJ0UU5I?=
 =?us-ascii?Q?EeMMe08u8Ya4lHald7wnT5VZd5u7yVp8FK0IWo7pJ4P6ygJoEoihBuQxO4MX?=
 =?us-ascii?Q?NwF695A1sMdkZPP+Xf0QQHIaATWwySwO9k9eHDEy+O1L/KaKGSxIqfg/cfwy?=
 =?us-ascii?Q?XkvG3aZTYQnad2PC+9oGwyel5NuSRtLJxnJD+OS5f3R64HJpKWBIOOcO7Npm?=
 =?us-ascii?Q?J+1TK8c6EMocQsSYl6WAZuHL4pARQ0rK6HOT4plPCMfQALIs9lRwSqyEOpVI?=
 =?us-ascii?Q?SOZYe/B4Ot4XaF1eiyj3nDUZ8DgbmVgZRO1F2mFS/n1Ro6qe8MvT/hb+y23y?=
 =?us-ascii?Q?DRk94/i/4OInpevnxeyreHcXHiEux1JQuiKUNC+HUYhaBUXBn40fSVL3dhZj?=
 =?us-ascii?Q?8ugvmf/UcsnaOY6hjhMdl+J35nVeC7YsiL9rlPLok4fmfNY1mG+JKRLurvSZ?=
 =?us-ascii?Q?7MkVHAduDG1aeVLWYd1/l/OyeO7HKfs7seAYNUaG6Ish5EdMtz+aIoSa1ReZ?=
 =?us-ascii?Q?yTtFe89nfApRoP8CzP9UCpwOrYuagGV5Lx159FG0KfigtvMQsJRif1uXHOG4?=
 =?us-ascii?Q?6+dja35Npsn4P3RK3PsT8wCPbdDEhC6XpG19BvI1NhFGwOmYx7csBH6DyOiY?=
 =?us-ascii?Q?bokDa1eucTPEp0ZDgDvq1Ds0GiY17d7ByCjzHdjxhA+bdfalmSbxsJEynHp4?=
 =?us-ascii?Q?igPvdu8P7RUctr+awd7xrIQ=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d8be47-4bb5-44c8-05ea-08da027b1b4b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 09:48:19.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr2Qm9f0mAUc3HCYsW5HmZfOgzM0JGX74HnyL3Stwxh1KRNfrsyweTSqCkFJCCXBGm3GsomLdgAsZhPYq8bOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3858
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
 drivers/spi/spi-rockchip-sfc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index a46b38544027..bd87d3c92dd3 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -624,10 +624,8 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	/* Find the irq */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "Failed to get the irq\n");
+	if (ret < 0)
 		goto err_irq;
-	}
 
 	ret = devm_request_irq(dev, ret, rockchip_sfc_irq_handler,
 			       0, pdev->name, sfc);
-- 
2.17.1

