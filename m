Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB1465CC4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355215AbhLBDia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:38:30 -0500
Received: from mail-eopbgr1300090.outbound.protection.outlook.com ([40.107.130.90]:58912
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355206AbhLBDiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:38:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNI5UEa7L1+fNlHTp/ZzZYZMwtHwHdPqt4XJKcQx+Ht8rfb9TnH3Djzx4rvBQr+nup0w340CRKKFCtY3j7cvzHn7kMu+IxxztdqeIo7VvOapbJWWsSvpdeH/dpk8J3rskEIB3l1Ffk92h6GfTvY9DT5WiwlPJ6SzPBrJxAONyWEWxMUKLgYqH7YM5Z4x1uYtRwfoHkUNXkEzEJRxgf09OuQPjtTRkuZ99NpODUPKKvVEs1Q69q8Z6QcCEzwzquzhNrIFPHUzR95OpzSxdK5N0n/DnownMADxFYzuYTqGEXOCoWwl3+YPhgSYVDVQ8gZUAyx/VyfptpSdpXsooPvDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEB+2oNqNmKh8OUZAQz1OqMxxNBKcX54c3kKt/n5iTc=;
 b=hDmdqXkBLldWs6W0rxNkOsN4gveVIvsZmCyacrF+XBdBs+XOduRFlP/8Ciusk8Jfqxq62BjYjwuhHoIeog0YyHBGJHM66ygFZspSnl7aF7iF0cifTXEo6bVcH7Ee9MrtbZIkrKcS4OYZKTepRDVBUqo69ZZSl3o2mQwtVrvVbPwDN0nsVWR9yLFtoieasqK0XKVMPeqt/zkaLli2lIw58CqpZTEvrIIwXqpdFJ8AH5Xyf9HkJYfBlNfdQi1WHTQHYXil4aqdCqAQZRBpfmLveb+R480CmlfeAAgpsKGQaeCGFHDr2TzAMtt8GBh0+RsDMBEpnezn9EKg6AIKAa0Fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEB+2oNqNmKh8OUZAQz1OqMxxNBKcX54c3kKt/n5iTc=;
 b=fO0e0tp3BFxP6n6PzsKTBeC0m2QMXXgrudHUFlCTZdUoQ6MhpFG/kSPKLYUJ45zhj1Ohw0t1U6Gny11uRoT6wusD/5E4Yw/d6lqgiK7Flkdn570LRIdLzP0kRyWwXGn6kIExbIvs/AyTd05+UJ7wkaGC+vgFYqqI+m3VQ+sbt38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by PS1PR0601MB3692.apcprd06.prod.outlook.com (2603:1096:300:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 03:34:58 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::395a:f2d7:d67f:b385]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::395a:f2d7:d67f:b385%4]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 03:34:58 +0000
From:   Bernard Zhao <bernard@vivo.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] security/selinux: fix potential memleak
Date:   Wed,  1 Dec 2021 19:34:46 -0800
Message-Id: <20211202033447.253596-1-bernard@vivo.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0247.apcprd06.prod.outlook.com
 (2603:1096:4:ac::31) To PSAPR06MB4021.apcprd06.prod.outlook.com
 (2603:1096:301:37::11)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.190) by SG2PR06CA0247.apcprd06.prod.outlook.com (2603:1096:4:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 2 Dec 2021 03:34:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd39d50a-93e0-4d6d-a628-08d9b544b6d3
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3692:
X-Microsoft-Antispam-PRVS: <PS1PR0601MB3692B25B456654BF5AEC7234DF699@PS1PR0601MB3692.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnaoDU+NbtRKU7DxAVvFlVc1A6xLlONSvpQRqdOHbeWEyPo17WRCslPGuYJUtGMRb2GvvuiysAhnqWr+ig7RELXFnWNrwnGExGMhpsLAKsJgbl4YUE/wwG5mXOE2fuJGibBh9VVMKsodLcKBBE5Xc1rZwwHAxBoLC83Vipq2QUaA1Ge3PBfpP4DlUe7HOwB9x+RGjSBcBa5EBRz+z3zH5ieb9aVrYVwa+IzYFaLTvaiu/nGhBfZZ5IpProZU2KG3Qvfo8mRTfeVkYnwS8Yte2PiTNrmUyEy/FZn4qbA5Jf1s3GRr+zupXS5Qe6+pqEi3AMIO1uB4ye0+01rzZTr9yTfIipeB5aeydsf6ltZmvsqyy3LjgIxHcvnQWwjyV0Hq9PhDy7LkQ8rYy3GYglsBqom5Qwht8yhf2UGKhqSa251rPQIN3tfDf83TZaqpF2PtoP1omap0I9DPlTYRmL1CTgJXdMaaZdSZJa6PMgat7dHVEOXl/zrFblj8D0yZpyHRhLCr88L1isa/whY15UHXENzl+ohBiOdkx78uYwuPk9o1g1aYqBoTOKJcy3keB3V+J0kezcy1bgHGhOT4dvuTb0k4FvutuI9vVpQIfbxe4kftJnbAnCxerUEWedIaDoXzYeZ9jTN62ACUyAnmuDNhopB+1x7fBXaR2us2j0l6uO2uZO0ZqLK8ieu/ASDJVCBd9I813oUcK9rnTveYpCttIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(6512007)(83380400001)(956004)(66946007)(2616005)(316002)(15650500001)(66476007)(5660300002)(86362001)(1076003)(26005)(6666004)(66556008)(8676002)(110136005)(36756003)(38100700002)(107886003)(2906002)(6506007)(186003)(8936002)(52116002)(508600001)(38350700002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hPyw4+gHPggn47utod1EgaVxHkNU8rL+IN+P66dL1V3tAdCZMzq6ypD+K6g5?=
 =?us-ascii?Q?gM36XOj2QtFfckcMZfh7B65W1SnP4A+15kJdVJxzBYaIiQNsWF3qWV09iykK?=
 =?us-ascii?Q?RYR2D1xRURaEeDHhAIM6VTHX47gzG8dkDbZDfeI7KqDr/djWQi8jOEPCSPWI?=
 =?us-ascii?Q?H+okB9hwy/VdU/frHtqTUvsM3JFbOr0gYIASmxvcj92YRPAjybwgAJpF2jXg?=
 =?us-ascii?Q?WeVfFJ0SU2LVLrDpaAVeVV0XbAf5q5ZX4r1z5uEY1hfG0TXjXEoWuESyVkji?=
 =?us-ascii?Q?mE5MEyOIyIYLsN5b98AJ2eIyYklErtrizswCFeFWZ+gUdxeks1x7MMpCH2nX?=
 =?us-ascii?Q?0//L0ojiszSaXHvetBVMhmE5r3b3fpSQtftMTsJph0r4XwX0oXRIEBM1ww13?=
 =?us-ascii?Q?VPZKXrAUIV6U2NFZ49Uh7L9Ombkiixs9qe4i77ctoP4eenK0REeUI+uJAXNJ?=
 =?us-ascii?Q?gazuLDTlYkXeEdRwHv47U7CAm9i+xMTqr/rdEQ44YxMeu+aaALea3qCuHMHx?=
 =?us-ascii?Q?ZKr580OBzog9nEj48yPH328xqHghyJtXzd2qTOvU3hVq9su+8dpSwEnzMMs1?=
 =?us-ascii?Q?tCgvc6Z1Uk7sk+W9/tL0Rp7i5ujSmHN34Wd0IGwV6syPL3corpsoHmS1fzJr?=
 =?us-ascii?Q?nVIdGDc48sxnoCRznFD6DgkXXehwgdeFGgbcuTj8g5OfAesqyyM4IiRk8/VI?=
 =?us-ascii?Q?qSjJqDH6dsAlynHBTLb460RdgnOF7ZVmPQgsFWlL0Db+HJa38I8LX7fG2PMw?=
 =?us-ascii?Q?oSAllDlvgBs5AYm/FP30rRdlmjPYVAkJ4QGsmpUBssDfXZ70o4VnDM/5G+Qf?=
 =?us-ascii?Q?KZ9sXR7+GqISDb4d49/o1DEaUMK759ZYJH31Y/9fjcl7ulhHBDlmObwehK10?=
 =?us-ascii?Q?1wDaWTRI33E53P9bUKfLmZTtsEBB0p39kxcC2oAxfXc8xIeotz4TIhbD0EQX?=
 =?us-ascii?Q?2Y0J4gNilb4KRJukwgHa2odleYMhY52GqEhJ9m806vNX03VeLWlf0w9FKJ/Y?=
 =?us-ascii?Q?0LnIajohSjTIv3XsAmH4oTT7Mj/pAzS1TbvFNt0Q6xH1+4g5KS5Iq/9KeKmp?=
 =?us-ascii?Q?d+KrDlrjW8eCX84tUT4ReJzWE2SSUiR59GmzjrJfVvjl9TdvDD+fmBae50RP?=
 =?us-ascii?Q?xjY3aAfJ045xKsH9SJzfFtbfgHZyULzOleFmp3Qk4WmvwLVa+p1FsjB/Ywz9?=
 =?us-ascii?Q?QkW/j7lOCnBRknoUyH/MpH6MlJze8JP/fCe78IPfsW8Ll34p6an2RrQ+uB4m?=
 =?us-ascii?Q?xMf4pjYsxI2oskHf51Wc+ELIeGKbhyRnmWD2MBXVIqQ5lepnQXSS3GTZmTf5?=
 =?us-ascii?Q?oapDyDYLWZW4tpJpJqyksJQ2xU1ZCy4e6tLG5UVnsgS+4wVW12aOIY6o/PbA?=
 =?us-ascii?Q?MzFq3y5pxsUC1rACuUzuwLtSmnfxC8+sJEH/xQjkH15Q9mIONtlOEAA24Bd0?=
 =?us-ascii?Q?VkNwuI0Pbj2/L1kGmnmNPWVXeJDRXqCnzPlL8irs09Uy/Nbp/HnCu/TkpmXf?=
 =?us-ascii?Q?Ka7rSJ5ecN9gHz3QosNgPVxxGpSq3eYPSukloch85rCjn1jXk//f1aPOBqgS?=
 =?us-ascii?Q?51d519/iI6bI5Zi2lf0Mqemyx69BNB6KEoXTnHatDSrddJT+yX8I9UaVaTXJ?=
 =?us-ascii?Q?OO3ROZubwXInlL+p342UI+A=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd39d50a-93e0-4d6d-a628-08d9b544b6d3
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:34:58.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Lethuql/NWEIUTfHnsiRwMgjGY6nqtSna3c0eun11jPH8con+Q3apJ73LvcOXy7gTkza62Q8+9nxi0wTSnsoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0601MB3692
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch try to fix potential memleak in function
selinux_fs_context_dup`s error branch.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 security/selinux/hooks.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62d30c0a30c2..36d7fc373839 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2856,24 +2856,38 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 	if (src->fscontext) {
 		opts->fscontext = kstrdup(src->fscontext, GFP_KERNEL);
 		if (!opts->fscontext)
-			return -ENOMEM;
+			goto err_fscontext;
 	}
 	if (src->context) {
 		opts->context = kstrdup(src->context, GFP_KERNEL);
 		if (!opts->context)
-			return -ENOMEM;
+			goto err_context;
 	}
 	if (src->rootcontext) {
 		opts->rootcontext = kstrdup(src->rootcontext, GFP_KERNEL);
 		if (!opts->rootcontext)
-			return -ENOMEM;
+			goto err_rootcontext;
 	}
 	if (src->defcontext) {
 		opts->defcontext = kstrdup(src->defcontext, GFP_KERNEL);
 		if (!opts->defcontext)
-			return -ENOMEM;
+			goto err_defcontext;
 	}
 	return 0;
+
+err_defcontext:
+	if (src->rootcontext)
+		kfree(opts->rootcontext);
+err_rootcontext:
+	if (src->context)
+		kfree(opts->context);
+err_context:
+	if (src->fscontext)
+		kfree(opts->fscontext);
+err_fscontext:
+	kfree(fc->security);
+
+	return -ENOMEM;
 }
 
 static const struct fs_parameter_spec selinux_fs_parameters[] = {
-- 
2.33.1

