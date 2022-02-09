Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BEE4AECDC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbiBIIko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:40:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiBIIkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:40:41 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FF6C0219F5;
        Wed,  9 Feb 2022 00:40:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5glfEMTDsl998Yd6vBHjif4A2UtERdbP84i4T40S83c/sR3H/aLFimgAXeveupYoSvmrwHPPq6DTjO5qeVMWnpqp4zu4qRIaq9fIN4l3NVnkzUlXe6s+dP8xMxKKljO2ZJ/OfyFquKBuqvtCGbdd+WNBSJyQakls+B8pjycpm6eTYkjZvEwyLOA0owKLIEKzff6CZWnrzampJbu82TraMpWwE2oVRss7xYE6Wd8JZAT0MGbJcJhCO3dFkSu+XgBB5TWQkK1HyEBpQ2/BeSNPAktm0Tg66JuuHVplNJ4xIFdSUGPinMWpICBtlJGmVAT/6jwQYDsmxtZZdJ5KSAi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c84f+RqsZIvZ2nCAJ+kPeS3L4Yq10q4YsjCI0hwFU0=;
 b=XzfxRiWEq4HzwnnXQHLGMuaDPHtuyqVARR798MqleTkQY20J2XiERazZvuixqpnt7E2EfLTPu52HY7adlOzn750KjV2W4aMB+1BXjriQSI/8hZPPw3N+LA+lAgxIQlpqh1G4V3mfMA+dEBwA4GbFLVb/DfIiuj6noDSfnZzuVjvRGmZaPzHgVUU7W3EkSh/bndnMUe+7XPGsvgM3q6zgP1Fg5ulYg9QtKUmXcoG3N4btyw1V2EmtHxUfwdI1EiqMaIDqcrsJ2ivGcx60QQOlHg4dkWH/96sudJ/9I7QMli36ggQUOGIb42rEdy7jTvgOuOJIpx3hKhDV9QZk/JhIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5c84f+RqsZIvZ2nCAJ+kPeS3L4Yq10q4YsjCI0hwFU0=;
 b=jzvG2GBRKnlidVVTG17hYaV2K84AmJz5Rc9gnCNwRlkMRV9pbWmU7gtKON4sm80gSMFhfPUFU614PkjDwkLvvag+21Pq+SfOebWAyyMXBuejXn8wLtlOi3+xyG7t5eylpz9GUYYt2D43KS2ddVMOA07UugkvGxS5HNCbeRjTNkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4387.apcprd06.prod.outlook.com (2603:1096:820:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 08:39:53 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:39:53 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] power: supply: da9150: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:39:46 -0800
Message-Id: <1644395986-4349-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::31) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d603645c-226e-4780-b246-08d9eba7bdf7
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4387:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4387FD36ACCD25FF1E369E61BD2E9@KL1PR0601MB4387.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POLUJejP688mLt7snYx/Kgw/kKw8rdHKjiVGlaVMvKsDgDWTiP2dfKJabEVr9J0wyJIgF3aa66KH6TOtfJ3fsMg/pwBI72ju5YzBGByRYEP0QRp9R3Z9gd+Roxn54/ZxfuVBZukRkzrE65ekLzsh6xBCSGFsaqRb8uFQHJWrWN2Ettnj91oQkX/aXdQJAbmDi+d1ZOZ5kzjGwg5Q20gL7D21UOmiTTm3gyrXO2wCc9aFYdDl3ZQhAjlXwZm2cM21LCZDGvuI/TPi1ovX68HatweHOlCPtzca9yJHJwU1px9gLnm3VoJ2kqCSHeL1jujZ1Q3+4Uh4FTZlVi6UgrBgojQA9pqlsEcUXvH5aZ5GNIqsSbB1zBLenaJXS2CnEGow6SGfvnqhPdREOoid8xWPBFAhVBio7nEmS+dgUL+cCNtWMxPh9ihDZiyVlc6593MFbt4Ne/dpUm8GCPK3E+kxpBT4zNRQ0YPVe6OTA4g8M5ms3AN+1K3AWHi1dDhlbpnuTbt8lDzcsFIrgELnpsk7lcecEu5TBHPCbCcF0sHVJ7lj7pz8fGM9AnyeL8Z8mHCXlt/fp/meyuzLrcpyoNlHZ8Qdqv4oJp4hDgkDfTR3v8uLdblLBfooH6nxjXW4dvZLVlszc18BWGv05/N+2wRuup3X8FLZcSFFs/gfJ0so+E4osbjeEb9e690gsgdSTdSN3p4jnuefPw7yJ9r2azC1zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(4326008)(110136005)(6486002)(66946007)(66476007)(66556008)(8676002)(86362001)(38100700002)(38350700002)(8936002)(2616005)(2906002)(107886003)(36756003)(6506007)(52116002)(5660300002)(6512007)(83380400001)(26005)(4744005)(508600001)(186003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+jnqCoGqs5iQPuoZ0O3795ymXmGnYHJeFp7CpEfW6GN4KRHpHtEg8ljPKOLe?=
 =?us-ascii?Q?CTK5eTtD5ZKvvwD92HQQUXPu72WJNqvsqL3o92ithg1Yg1imP0m0q7Z2syUz?=
 =?us-ascii?Q?FnSCLk19aP12OMTsY3FxJmcZsDtjtnx0/3wDAi4JcfcW3Y2q/jlUrZwsMr1g?=
 =?us-ascii?Q?TScYibTYwFIDk1AH0n7k3KybMj8YNjQc+Qkf3gEnZhjSuQMbQ7gWPK8ygSRK?=
 =?us-ascii?Q?Ft59Nd1h+ODFXQ2/zAniiKT0LPT7EgP0nO86eD9ydrdkL2t8teoJrKmbrB7Y?=
 =?us-ascii?Q?PCYtY6lRXLf1d4QfCtKhhSf0U9aXgJLoLbtmRKMR5Z1huFGrBRfRCbVpLz5b?=
 =?us-ascii?Q?L0l8MOrUbMzYVNRLFAUaqs2XmC6upsperP4P+7/s71ql2ygzNVleC6w7+R4r?=
 =?us-ascii?Q?JZWynmCWtrCHQ0BXVLCQ2KRjobQmjtSO+6trWq+0oz3Sq4qvx32FT6V5ef2j?=
 =?us-ascii?Q?AMVGTTSzot5MKInFxMde8djKj8KMlwgFHsAxDl8eWSdi7DTWMFmCIkbZjM6N?=
 =?us-ascii?Q?4DZ4HkGmypQyjt+vZ6XTQNtBgPUj8dMVCgZgUZZToGGEdzwXmQIxj4bR0vK1?=
 =?us-ascii?Q?8BId1Q4VB/LppdiD9U52IkcTn1NJAChfA2sMfO18ak7+OwmAHca5qOTbSDAl?=
 =?us-ascii?Q?esCdlRj8/ZhbDWI2O3yclXtQzfMn/0ekFbt+wkCC8ReC4k6evhSNFRqXB81n?=
 =?us-ascii?Q?XPkDLCyUMmAhFUOmhsZGzZluc/dqYo/NI0CcngL9yI7vPsYQO16kIvWfFMTY?=
 =?us-ascii?Q?vjcP0plMppH/eKEAGEy5pwuHZAXPxSVM0Z+5b6mRVdcsZwuHGUQVHhh23lb8?=
 =?us-ascii?Q?c6A18sRT7IePkrCrqCQoM93caOi+MgkumPNvlrgFC9NVE7AsumOYeLAVa6dv?=
 =?us-ascii?Q?bRxpyuv1drURYcEZgHh5si3Wa1bSY5AYtex+jhoqLlM6rKbsc+1q96tl198V?=
 =?us-ascii?Q?yhHwvgbOhhtKVliMq1bQ6vZoAutg6rIPvYr7UsO1LYNGG6+o9pRSrZpUc1ic?=
 =?us-ascii?Q?nG046WvjOpZ4J5DekdgHD+nxuzYCrOAeVKvMnNz7iPSk8Zq6LAc0C/VHwRnD?=
 =?us-ascii?Q?WWVnyzRRjoRxtL0+T/TD+zh5f0QhzfvuiLpydhPKucm0hwrwKEX5Z607gHs5?=
 =?us-ascii?Q?9NY0oR/VSGs2o6s6fm1yD6lwX8KVrYHbf3BXkq0kvwz0W2CPCNUbNYrurEEq?=
 =?us-ascii?Q?TnXOXc0RptXOl1s+oqpyMBl2DNDLcWRi2Rt8MNToH4eGtRzAjQJuj6XPSSgS?=
 =?us-ascii?Q?i8P3rb7bIV3zI0ttB9ymjkGn0LTeXeWw+UlRmh5NI73fV1OKuNZ2ttkyefv6?=
 =?us-ascii?Q?v8Ub4pQtsRyQuzQvN//6QxGMYD2ESSV/ID479x3jJnUvoSjxb7z5Tm8M1eOU?=
 =?us-ascii?Q?zLUL2G4oFULXboxDv0ERHGVMBiXlUv50Z425S8utKcb71ac8wE0VohHtUrra?=
 =?us-ascii?Q?K92ihd5xho9J3eqi0pvKCecftoqzfG5tKSyEFtqG6oUDt38W45kzddYLsvAm?=
 =?us-ascii?Q?yvGHES4M+Ch//+TiYmTI2loAC7xTQ4zIePczow00z4eQrmaj39jGfuMVx6LA?=
 =?us-ascii?Q?9Zlk67wV+TXUGHcxCPCPa3JA6h+FR97P/JFQRYxkclQ5SDZmXxkUlpaFBYDR?=
 =?us-ascii?Q?AdI/sJesmf6yzvnRctShX/w=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d603645c-226e-4780-b246-08d9eba7bdf7
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:39:53.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16ps6ID58NyHNVw33HATrZc1qXu3rDpRphRDjVT01moTUOkCJoQ7QRdGnR6u3RBM9w2PxYhD3xvvzFqARGgJSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4387
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

do_div() does a 64-by-32 division.
When the divisor is u64, do_div() truncates it to 32 bits, this means it
can test non-zero and be truncated to zero for division.

fix do_div.cocci warning:
do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/power/supply/da9150-fg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 6e36782..896491a
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -250,7 +250,7 @@ static int da9150_fg_current_avg(struct da9150_fg *fg,
 	div = (u64) (sd_gain * shunt_val * 65536ULL);
 	do_div(div, 1000000);
 	res = (u64) (iavg * 1000000ULL);
-	do_div(res, div);
+	div64_u64(res, div);
 
 	val->intval = (int) res;
 
-- 
2.7.4

