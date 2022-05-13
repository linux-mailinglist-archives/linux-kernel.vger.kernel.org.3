Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA9525E23
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378441AbiEMInC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378317AbiEMInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:43:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2126.outbound.protection.outlook.com [40.107.117.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84386131295;
        Fri, 13 May 2022 01:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USoNhrtyelqrLI9+WcnSPv3jtXkQ/p/BuIvI+Ss9DFSWM2GU/j8TMVx8b2KZtwt57rHT/Depl2YtMS8pDqjOKWDiQd8AzRrHW2zy+Mdew/FDVQ8zfs9oeyl5zpTtwt3lT+oFEeRLfGWgyJGUx5qHgC48PFhN4DKMpo5ONbLkkdz58kP/j0YSKsGeukepDmhyNzXgUTWvtjDZQKC3hbpfPIu2Kn/5S7bfnr0wdWZk0bk/B0vMZuxYuMGS64EQfkS0wlIMstOICXeXqMMTKTo64T6ijZPEcIRcWrTMVUYmmoaT63vvJjDQCN6Vmzr6nu8UCmmDx2aGkoYL17Xwc0oxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN59h5TSPYGr7JoAeoKFmmO7ITRgsNMhOyG99wKaLCA=;
 b=mGBpsSC9WIcLFVbUHTiA/yaFI/iS1cM3g9OAlwZxkTq0Qog4bc8W8Z4GYn+phlyVabpBfpL1MkmwGWeTBAb/2tKBpl2N28ouKD/oAWbq28ZR1cfrXPPBrdCosVpzEJA6FGLJEGQj/Sq0akOFmW+2+kQt01tH0cycrZUwtfx9XCrjHZDLJFXh2KzlPStt8GNZYSCgpy3QzzjfNFBx3tDOFuXNugtxZoobYOa3W+TafoccIsamRcnaXTigZZKI/1/9IQg1jwAF4eXuEOjKZSzApusU8SekzWSLvXHaUATBM0q2XRvec7dXRZryBk3Mn0PK+mUOgnCF3axhw7YhZz3nMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN59h5TSPYGr7JoAeoKFmmO7ITRgsNMhOyG99wKaLCA=;
 b=KYfOJ1pWHVLI2cXy2O7JIse/9xHWWqUYFZKnav6no/JUCSKZKNG4BlwHS7cGgyi9ZKSaDRqCX7MgX7csOZraf3qH4X4+VTHQ+aIH7zizALOmYvw5S3XFl8VmwF85BW0b/m5Sd/oURoZl7FicdbSkqN21ja90noxAjRRsWY4jfRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3374.apcprd06.prod.outlook.com (2603:1096:404:a4::10)
 by SG2PR06MB3368.apcprd06.prod.outlook.com (2603:1096:4:71::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Fri, 13 May
 2022 08:42:55 +0000
Received: from TY2PR06MB3374.apcprd06.prod.outlook.com
 ([fe80::b13e:aba1:b630:a14e]) by TY2PR06MB3374.apcprd06.prod.outlook.com
 ([fe80::b13e:aba1:b630:a14e%3]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 08:42:55 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] iommu: Remove unneeded NULL check in msm_iommu
Date:   Fri, 13 May 2022 16:42:26 +0800
Message-Id: <20220513084226.129437-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To TY2PR06MB3374.apcprd06.prod.outlook.com
 (2603:1096:404:a4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03164108-8c2f-4aaa-695b-08da34bc92ff
X-MS-TrafficTypeDiagnostic: SG2PR06MB3368:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB33687F2C84110EA84A69E590ABCA9@SG2PR06MB3368.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lb3d0b90pQg+jFhgU0R777QzQR/vQo01+kXJ95M2CRdK8fe0cmYob8ODCt/mlbtGRfTCkr2ceAI0+2XhBGFssbgnvHdeJHxV5d6AevtNwooFUjh8XhczexNgPCkoO94qePJh2sihubTVI37O0SHLeQI+iYKUCYPJ4+1r85p2680O02xH0fj/fe8AITkI83hISrz4RrrnvQPFEfU4TUNqWlmUBPrk3grmNHeQiIjkw4/ePwVgcKH5G8S6wZ64t+YwXmNrKFv3ctr60JFv6UAVasVY0XnU5gW5A1Dg3B095s3LyR/e968VDBv1DkFqdd3gpmG4DiGUAB3oYi+4Q1d6ls08UlFDjpvhhsLP1Cst5ghvvAv6jP1kiHuWaU38R34iHAtZa+vmIzYMMB6RTeRkkvzKUS5BdQOB3MYeKmPfWdCPSoqhbFEMhBgg5QfynQ6fx8jCJFgIisxeqE+3NdjTQBPtDeDfSkmFiOYejekEsYrRgfGFJn+kbb8rCKM3EWY0ta+2geRO/iq19kd5m6CcBa32C6bn/zwDRRsJnuSrGWe6EqwocBAQZFTKWUmjtGf6kOfMapKsiWg9gegqhuX5PSu8l4s+CR2/0Y/xr38kRaWK6GMq0bklDlC+b3rfR/9VmqdyRreJVUXq35XvGe3OSVQIgQElZ/lDaNopyTig+/waaGoa8jKWMnKposro0xNF+cQUqj15BLMx+csbR5LPuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3374.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6666004)(6506007)(66556008)(2906002)(186003)(6512007)(38350700002)(26005)(38100700002)(36756003)(4744005)(5660300002)(508600001)(107886003)(1076003)(8676002)(4326008)(8936002)(2616005)(83380400001)(66476007)(6486002)(110136005)(316002)(66946007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OgdZaRi1gqes0i9KFzw8h3OuKrSkp4mbDPMkY4MqueEfSrnK9y29HJukXTp5?=
 =?us-ascii?Q?boGUCUEwI1GOv/JKgkjHQS5L19871JpFMj4L88E48/XkdfY9gl7jXmoku0Rr?=
 =?us-ascii?Q?bb/WM6XLsPH2FQtXiQC2qGWSK5X+L5jZV6D4Xidgh3HKTapmr0tCfRHeAlD2?=
 =?us-ascii?Q?6QTIhSE8pbqcU4m74b0hZMdiEtl+886vbfIHWZoXFGtQXW3xmsMOgiwUUCiR?=
 =?us-ascii?Q?IeiYdXoNJvoRAgLwtkXVtLwKy6tSShNp74s14m/83t9Vcg0a+LCP1LcIzFf9?=
 =?us-ascii?Q?8XPmuS0RqgL5pPa3Kut/ahPCOrFsnzetVrch2xc2xxWL+aADuaAEDogqDAzA?=
 =?us-ascii?Q?1Jx7dwvMZn57e6qjFYkRfxevsiu/6DciZ93/jTKhWA2fjvEtw6JFI2GU5XwU?=
 =?us-ascii?Q?EvFxsFrYDMXeSONnifDA5nz10ktL/mMn88qoyeqvVGVlFuO1m4tePbMYhYeU?=
 =?us-ascii?Q?B2Pb03FpH5mGI/unXIckW0zd8dk6+usb+ultKe1P4MdQs82XQh0sQeIVW1UU?=
 =?us-ascii?Q?jXjzlMIEl5liimZAwTBt9VX86HSrL8gqEnfQwqOB+M4Hw1hvj8nVuwuRH958?=
 =?us-ascii?Q?9iaGVLMbUgg0SaKbiHpCCMjVu+ZhRZ+UhA8m9fSyQlKvbqFQwovpPdjO9cNC?=
 =?us-ascii?Q?pjgjMJWruEJcFfMzzLNFJbU79BgOhgLYM0xWvMYXokjGdUmsYLt6Rno9Ir1v?=
 =?us-ascii?Q?rZW3UYfNZNZV264ZivYo5soBVPBG775EcOUMgi5cOQnIuK5/89T7oTOrgO54?=
 =?us-ascii?Q?X0rSYWOc4W3cEz4Sxl06BlqPPIcr1HLGN+bVrBd0Y05uFKSysU+mRaoliXPJ?=
 =?us-ascii?Q?aKw1AvLxGF6WrETeARn3Sz2rMTsukU60Un2deAyrMh8D1MEQ0BPwmbY7xqpK?=
 =?us-ascii?Q?12XLndFUlgXeyfo6TIHGD/dbdZWKeo/hl7WWQEW5vg3SEENEp4OjsWOVAaDz?=
 =?us-ascii?Q?CexsaFlgtkLpAaMBPZWOvKplZmlE9AqNdhLR/vp5Y7tjlHEiFxStyduI9JxC?=
 =?us-ascii?Q?eEl1en3RpukpS7SG4YWkzEYtUwCPjX/lApU7DqcQS4ppVYbW6Y1A9EfZUITE?=
 =?us-ascii?Q?jsHj0vg5Fv1PyueNKkGGhH6YT1CkbdJhH33dPTTEuKYBl3wXFfJOzSHXf/he?=
 =?us-ascii?Q?ioeT2UARVJnoRXqyNcOaGh4Tny7iuqdFcbC/xOCX9rRIsYouV+Eoiqztadw0?=
 =?us-ascii?Q?l/s9htSVrsEmiGQPsiB8+jyA+qNIdLFImYI8v2ZnJp+4ndFOTtOtjlXRaq5N?=
 =?us-ascii?Q?e/twD4zL1VrFlDpwaOOlUP8OcOqRFWu+XoHSf3k5B1M170TzjS2nv72zvBZT?=
 =?us-ascii?Q?OhE1/FOrSSycHfcKl54QW8qS70NHleXJ4kemsUt2QZv9ZcgXVgQ/nvdg5F4v?=
 =?us-ascii?Q?4QLawkHnbnl3by5PyWT1dvf3kNKrW5u/yusmSpxTBsbeSHXXkakABRDNnvom?=
 =?us-ascii?Q?tNquJ2AM/iiYladaB7xr6how8YpI7w/3IY4wzC+aBkeIUILrqTwFPh5zRXAp?=
 =?us-ascii?Q?wn/tBsDi4XUEtdiNKoT25wVuQ84gub42/PVEwzu3Fcx+hRj+LdoqMqxYK2yG?=
 =?us-ascii?Q?nfDe9NuVHEDRDIbafQmDhjD5Yp/oEFWon0HcQKcDyI9DI3GtDUL6R9wJUj1v?=
 =?us-ascii?Q?ELFpl+yqzohrr6o8kBLKevp8T3Q/C23gMdczal7yfoKuo10oaxn/z9O/o/7G?=
 =?us-ascii?Q?vmwpJEmqnjmeryyF67gWse5llMJZ62oofJ4ZCCxi5WYn7iOPzXy9dg+smg8f?=
 =?us-ascii?Q?mGSYtWCdmw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03164108-8c2f-4aaa-695b-08da34bc92ff
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3374.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:42:55.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2G0Cg7Y83ctaSNLdAEzjP6b0iGYEWIHRfbAvFfv0dnjHJMEW0uK+vhqc2zx1w61zajP5zvAMzDGiJQUGZ9+6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3368
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_disable() already uses IS_ERR_OR_NULL to check NULL pointer.
Remove unneeded NULL check for iommu->clk here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/iommu/msm_iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index f09aedfdd462..c3ec2b7d33a5 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -70,8 +70,7 @@ static int __enable_clocks(struct msm_iommu_dev *iommu)
 
 static void __disable_clocks(struct msm_iommu_dev *iommu)
 {
-	if (iommu->clk)
-		clk_disable(iommu->clk);
+	clk_disable(iommu->clk);
 	clk_disable(iommu->pclk);
 }
 
-- 
2.35.1

