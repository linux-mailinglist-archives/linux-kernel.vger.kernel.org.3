Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95264525E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiEMIl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiEMIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:41:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7992E54014
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GozHlWbutrDFfEH/YLSG3QIR4VgyP+8O0MNuYRtEBXGCaUg/M+dCqo7Ueddtkv2qDqa9YaUV3XSu8Tl386d+TX3DFPuR/j4+nKmdED5d9nppCFFowBoqGG8K3qigK2H5zcC6H+LKUdI8On2iETz05IplOcUNX37vDK6wROsJf3ZSkZDk+Q70qPLJhVI3QoOnEnY0ED7QmP1wbo8y6qu+ezyy9nrvrf6NrM+YHvpFDIIEDIlh/4OA4GtW1gAsj3ZA4h90lNxctL7t0xZ6U/arT85OTaeCi3xtFY8yW/Po7eIFU4I8I0fXs39mHNeP6aGFQtyHyMtSeIsS2yNIw3aINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SbVCC2jYEM+shYSfOWBtVk1bHpQ91rQbph/hDSA6vo=;
 b=e/Qpk38cQZphEoDxDPPtOjSA61Jta7FaVySpdU515Wcst8ljvvG2fK9AveOdm/dVFbm0npKXJRdRF2bPGkXY7lg7ONtLxsgTOpA0109I7OOILSEkBVkD0Pk02LWoY8/gVfoBZ9Nwb90VDqoLonf/Z2xy6qy1rXbUxkNPZKl4PPnrXn5ZJI6MZRSYkXY5UkQ0DDFP+LrrfOB/p6mo2ZFod3moTzy9e1RCgmBnPg7jkAj5B1+F94phMOGh/euJ0jQJdsa+t0vUlcDgA8fX14o/UWx+1xZJ+AQPJL8TH04QSbVuj3D9Axp4jXIY8cxerhWOHa7W7dbsQxzftmm+UB0aFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SbVCC2jYEM+shYSfOWBtVk1bHpQ91rQbph/hDSA6vo=;
 b=REjC6VWN75GMp/JozlIBnrIqLmNuAZyTorfwOGE8B0ULPgbbs2X2o8PKBX5X77Kt01pZP5KwDQs0+ploFtn/bmpV6+Kdl1N5tWqHMIj+WgGdNP0tXxfa2zkLe6KjDs3puYOxIuMGDrx7M3+qEfrLr3B6Rc+Q4HVR83s5cmym5yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3374.apcprd06.prod.outlook.com (2603:1096:404:a4::10)
 by PSAPR06MB4390.apcprd06.prod.outlook.com (2603:1096:301:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 08:41:52 +0000
Received: from TY2PR06MB3374.apcprd06.prod.outlook.com
 ([fe80::b13e:aba1:b630:a14e]) by TY2PR06MB3374.apcprd06.prod.outlook.com
 ([fe80::b13e:aba1:b630:a14e%3]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 08:41:52 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] iommu: Remove unneeded NULL check in sprd-iommu
Date:   Fri, 13 May 2022 16:41:42 +0800
Message-Id: <20220513084142.129304-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0072.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::36) To TY2PR06MB3374.apcprd06.prod.outlook.com
 (2603:1096:404:a4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 198e1bcf-34c1-4b5e-777a-08da34bc6d88
X-MS-TrafficTypeDiagnostic: PSAPR06MB4390:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB4390080DD8892DBF8812D917ABCA9@PSAPR06MB4390.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6Jj4pU/Tw0/n8KILDb/dpNEXSkdLtYueiD+zJj9e9nsZcIVTd78l+SaBImgDsrXs9lIGgPXcmLkHo/yE+Cj/lKRid+IFhtHXNY3UVi45J0LVExAjqMozc+cqIMCAxg31ILFkw6ev0UZ9tKJUJ4mC8bmkZjig4KmAQR/mI2HLUzUGv1kMlGor+pUcxoaY9174gg/z93NzIsR/9Jjta12t8pp5lGAY3bg8VTCQCyFBiRU5CdvMmovsMDM7izg5luPf0EL8yiJsjKRfuZbx1iloBfDG8myQ/dOWd0o1OKYqhCDOz+C2svzU0OpAhg1L3+9amir+mpCHPLnY70EGHsGcGy/EaR4feiI3eanT3VTfFFQVbAFzcxVGf4xZXiBKgQFd2nWjcvNarxNlJ2MfrizRW+C6ovmxtxxNJaWUH95fMf9bsbCwsTw7wPmx6HV6fEW2RkDQir2Ju5mSB1Ah2RjsxxcGQ1ZNTC2rz+WNXaLef/eqddcBik8L+MzJ0LFu0iQtzTqOUP3KIgvO8oXmKvsSc3wDhrpamUVL7I7le5x3s2g+B7M2y74O6yquJQsojZCLnWxnGYx1pRDLR6dbwPWAHrxnHuEQsLxLnXJvCvRHbVUEJgbkujr7bkCtzUMQTWPkFmcOg2Nyan7Tz/t+wbs+ltPEmfBT2q/5phuUHtfwqkp6zoZpbROKOzCj4erOxOwtJ2M/I/50fsI/ekwfMdfsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3374.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52116002)(6666004)(6506007)(83380400001)(316002)(66946007)(36756003)(4744005)(66476007)(6512007)(26005)(66556008)(110136005)(8676002)(4326008)(5660300002)(38350700002)(38100700002)(8936002)(1076003)(186003)(2616005)(107886003)(6486002)(508600001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?29vufwst1LLP2/GBoKzMEuoofe3sRZIAqQQLy3eeB+4XDj8fcpFP+W75K0F1?=
 =?us-ascii?Q?kxldmyUi68q3deubNEdVc0Uvnj0/J3QR+V2j4SzGVqFqALk6Zb+5/YdnlBEH?=
 =?us-ascii?Q?nkiwEOSfbVlPEx/ahvQTyp6C8TzYk9V88i0SyCnw5ga099cbTbhgydDUxHoT?=
 =?us-ascii?Q?MnDg9/AHFadyIW/YD495afdFAcUWjVxZq5Ftox/jktaR0SaA4M6GNhEhAD3J?=
 =?us-ascii?Q?Eu3azL9VwAn6quwXKEWK7gYFBzWoMJ+3OrsTih2fMNL+RtRrUReoKs0jVDHK?=
 =?us-ascii?Q?hMIvZGBibY8DM7CY69JCpodxulbfPfiPvm6jPXjYdKebhwd2HOpIbHhhNLlN?=
 =?us-ascii?Q?8QsOZtBx5QspwgBkkxYQTd4RijNGhg3u6YCPGFDhRVBDVHXmIx4w36A2/Ot8?=
 =?us-ascii?Q?Bhk9K4h/fTtJ4bOtG/+uj3IExT6+y52ahAwwfIQlcL5UMrN/rWSSviFmYObq?=
 =?us-ascii?Q?X05D1xK5y/1eCy/mKc1Q/qTfaTb6dLoQVKufQvphUrVOXOQfhXE6imp4DJJL?=
 =?us-ascii?Q?YcD1As6hv3ma6IEsLHHO0xX1FIBpVhkUJs5BheMYTwUC9Gz6QY7czrRKWVtk?=
 =?us-ascii?Q?YhVCg52tr26yT5mItdbT2TUehVuiXQR/bBGCKeAGXrn7X9ut4z4DQensnWO6?=
 =?us-ascii?Q?RB4CGxajmTOy0GBJLkhn1NiujyV7TsEbnCVOXzrZbkOG3RjZNqmyKHwbSrUA?=
 =?us-ascii?Q?4Y0mJeoPGe+92hkylQE9iI5KA2Gr6OUquiiGZ72nLrg3vrANTnfWOkGGBWpL?=
 =?us-ascii?Q?WF7oAX632WmwyQb1p1ErbDkPZiQgjkhXsi+DpmDOw9MyZm+HIcBN8taVSC0Z?=
 =?us-ascii?Q?C7RjbebCEDN0VjMTJZpI9+iHCXhRQTp0kHdsXnq57qoHHAwev50mDzjS3jAn?=
 =?us-ascii?Q?xjTagrvIdiTexcnRD4ryMoPvby3OmH//3pdbON4bdyI/kyXEBjvfjiDgJjMR?=
 =?us-ascii?Q?DSeTeCRwqVy4xI3zSlCgOppO3DoeNUa9musOC3S72aGaF9sCbFgFGaNOlOA4?=
 =?us-ascii?Q?FJv29nVzgDwnc4x/qywTk/x55skitlIZOxtrcqsXYEJF3mnob4ljt26B4jXz?=
 =?us-ascii?Q?kKt49CDe/sq/V/PjHl4n5/beIv8yOXO8ZTAk+Mgo8ST9kwm+8qIXXnbRExv9?=
 =?us-ascii?Q?vqpnWc/YJFKTjPgDpnU/7e4fcSGb/7NKeNPgZ5ZjMHkvRJGcAW+0QixjmrzD?=
 =?us-ascii?Q?MlA2IBeYimo4Ymt+P0BplnqwG7UYMJWFjBULiov2hiP3I4hNouCv+DuI2CDh?=
 =?us-ascii?Q?BOWauCEBEuFUJYAxgDt+Q9nQ6qIk6OW/x2JEkN72bFeMNoA+AeksfxdmPfwg?=
 =?us-ascii?Q?T2NF66xF9BaRDbrImUh0v3dltHXLCyVvdkjjg566AiFoeV7Sg7qRLE8Xas1f?=
 =?us-ascii?Q?1Z7gaQGQ5z2W/VWt9vO52CMJAh/Rn8y/dNsUCKOXLSuzFHQlDLxKhvur2v9I?=
 =?us-ascii?Q?XwaGK090YrTsDn9FWWXDufTj0hBoRUC6ikFaN6J8PP9Xi89L6OceKsOfcDHe?=
 =?us-ascii?Q?hncfAHi19M6qcTikFt6UzU+m3BJTCu0U58vFVcjuHXaDNZCzRgteS7gEUoV/?=
 =?us-ascii?Q?AoiYNtJYn5D3BSf93Ohnh+KqD2Flj+nGduvhurQ1RarMM+PAZtsUnb4HlD6e?=
 =?us-ascii?Q?3Rlc6F5IIprOzYf6ts2RWeF44cdTNE1Y5ZphvRJah0qCGRP5DdPwc8HrpMre?=
 =?us-ascii?Q?9U/FmufsOd5D3F+102TP2IONetcUV+UXCYV+beYukkfCyXNVdmqly4MWPG1Z?=
 =?us-ascii?Q?ReFWNW8aVQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198e1bcf-34c1-4b5e-777a-08da34bc6d88
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3374.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:41:52.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXj2Pjik47rluSC2jxchdUjWKBnLxmTAdzL6uRboN665wrd6nv5zi2pcN1d1Z0hsHz+BkiXMnMpDzFe/mGxveQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4390
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for sdev->eb here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/iommu/sprd-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index bd409bab6286..7c2bd6fda165 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -462,8 +462,7 @@ static int sprd_iommu_clk_enable(struct sprd_iommu_device *sdev)
 
 static void sprd_iommu_clk_disable(struct sprd_iommu_device *sdev)
 {
-	if (sdev->eb)
-		clk_disable_unprepare(sdev->eb);
+	clk_disable_unprepare(sdev->eb);
 }
 
 static int sprd_iommu_probe(struct platform_device *pdev)
-- 
2.35.1

