Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D629A465C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355095AbhLBDPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:15:55 -0500
Received: from mail-sgaapc01on2114.outbound.protection.outlook.com ([40.107.215.114]:57232
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355091AbhLBDPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:15:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpFkHL3qdiWQvcCQ87DGjhlrQ/S1cEFuIzVhBq9jPDSTFskJncaLh6NSs7mlOV1Lcy3MGRkhP4WRovYXgMbT5tFEarlTP6jBpORHuLDSYC9PUOdqQF9cFsgALKJMW6YGb823tky5bsxnrVO2rTzO+qDTJ1+//BxEy1XydNsVSpW/D5UGCP2dI6vmHVORoJBDq+I70LhwF2+W88XUrqhmxIs9NrixmaQpmc0zT/qETfYWrBQ28JRFbMrW0DiyjUky4p33gbDYlz5NrCjeQyQ1GaMljtNuTHJ4NAogkAavrqH7dtGoH07AiPhcnJUk9V243htqKuA34YoItKn7HLvhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDknXJxjwHsibi/box+Y84G71NXCyqfW9iJ0vrJE57k=;
 b=cpv5ElbifGNTo+M2rgjCG3RAc+F95jDSNw1efSdatodiz8AeaXvRDSCxHR7+egm/FR4uztgBYiDsZvTWLV1n9B7Vi/x3o49tFne7O6tK/TIsHvQHrGTrKG8ztZMEIMsp2QtoKqlAvTD0fflh0wSWliToX8KPjM/4a5VAtfGiu+XuyGPHCFtfFjDeLsKSlrHAa4+S1krGmtwqRh2mbVNyhmq1WIDC/gnYo1PfF58hA2jSQPa+Xx4TbYsYLpy8hp3jVDwBoJc0vW4QoGmW3b9a34bXrVOENb+0XmW5UDWaw52zSgkkJx+pOZkBgQOK39oeAXllngKCIdK6C7DqchHgrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDknXJxjwHsibi/box+Y84G71NXCyqfW9iJ0vrJE57k=;
 b=JaQrEUNrC+254mF+M0ofsWVijgUpy3KIcz5qktEwIkY+Qc4VDvaQ/BTeu35y6xHOoxcG6r70lqq5i8Sk3ee2QeAiXxC+OXaTaqcDjF2GnEKOdBGy/oVMO/KXjHvjAmeeu/WWjHX4+zC9cqfBGt7NT1bXnbjlIF1+f7LJnEEw8yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by PS1PR0601MB3690.apcprd06.prod.outlook.com (2603:1096:300:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 03:12:20 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::395a:f2d7:d67f:b385]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::395a:f2d7:d67f:b385%4]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 03:12:20 +0000
From:   Bernard Zhao <bernard@vivo.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] security/selinux: fix potential memleak in error branch
Date:   Wed,  1 Dec 2021 19:12:09 -0800
Message-Id: <20211202031209.253228-1-bernard@vivo.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0021.apcprd06.prod.outlook.com
 (2603:1096:202:2e::33) To PSAPR06MB4021.apcprd06.prod.outlook.com
 (2603:1096:301:37::11)
MIME-Version: 1.0
Received: from ubuntu.localdomain (203.90.234.87) by HK2PR06CA0021.apcprd06.prod.outlook.com (2603:1096:202:2e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 2 Dec 2021 03:12:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8654f474-4c88-4ce8-91d8-08d9b5418d33
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3690:
X-Microsoft-Antispam-PRVS: <PS1PR0601MB3690B22983F71EEFB359A0CFDF699@PS1PR0601MB3690.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLF//QNpSXj7VsQZy3hbSrvc9oMp4Zw3oPvZNmS2OEz/YMRqB9ucJyuOw3Kcwjb9b7WzB+MufJD8gCY5HjQSOKvLEK+K2/z9dmqUDhLeUivLUJO+CCqUTO/hSSiOcMO8gOzfMsj5QpA2SPNH4DRAjj7dWKFF9E2ljNjLiqlhM1e+g6XJb+1Zb7PatYeGDWRcpRd0JFyUXIm7zDMCxDFldJSj80EarrgJ5nnz9akaeoGY6UaB9tMPyhsooOfaIgnb1uaYszqYttMhaekS2wH2t7bJ7rF8ubAbFydE2t2hoVdF3NPJxp3Yr8fOuZCfY2EhCx8rPBlKfBpCJkayQIIe714Q5KKyALuJoKUUmpJiLRGaeG2O0SalcXQjhpsFLquJ06nxuvMjtXLrDlaWBJdE7boual6EmtjxLuZVcwis5Kz5ejmhNO0qJ2LTXmZXXnFBiN7kR059+k/EnO/+IBNMgf4zDEF9xafVw+emye9WPhlYxDXUXBqHYDLyB3+ZwREtNoG+KxfD23npemxMw8f/FmMAjAhL33lj3wTTWDmpC7M+J1j2XH51oJPjwxT/21Z4xKDYXIl9Mzg6iVOvl79WYtGfftQ9V84QpcCgPtlLFCUpzRCCNK1aqUnM42Xh5PeNbCc1ZwbBvaauRNLIQiHouascGuUcmya+mvO4O9Bt/KGmhW8RV2+6asPRHlndAW30adbVtPzVwskNjn2Kg6RxiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(15650500001)(107886003)(6666004)(52116002)(86362001)(83380400001)(508600001)(4326008)(186003)(66946007)(66556008)(2906002)(6486002)(26005)(66476007)(8936002)(5660300002)(8676002)(38350700002)(36756003)(956004)(2616005)(316002)(6506007)(110136005)(1076003)(6512007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WGwdsaC6oAzlzSdrwmGd4FYRE/BzwBI+G7B1XgZwekUNOO7M/MI8uG8PAo4P?=
 =?us-ascii?Q?HQO4G1NOycBXSZD2q8C1S0GmiDZSpK7ujaj4aeAhhuv+0bZWMhpgkHOv6VJL?=
 =?us-ascii?Q?lKBaByJ/JUsBljjfa7gnMMjMxDbt70MRPIale7U+RP+dR8i15l3xBnldN2Mc?=
 =?us-ascii?Q?ND+bY7vKeoi34mNB6qguTxYmn5BggQgR346zQQbBIdj6cFMEkXRlcDv7yO3Q?=
 =?us-ascii?Q?ElL8dSDaCL39nJGGCigqHL1P4eGWSTkNPXduMrFBoXpVN+5xSXIzSsSJQuvn?=
 =?us-ascii?Q?hOj9WZMb5DXuzMkG6mqJXVdT7OiZredQTQJg6RhEQMplMugQ1B7PjexCb2Va?=
 =?us-ascii?Q?N+gd3d2Sm/CD1FSoepeJMmDXs/1PYoedbRI55m2MUbRpXKJnS5T7CvZTHdcb?=
 =?us-ascii?Q?B+g3oaeoF0KQx0Aj/kyyniCL3z+vFpHO8/cnJG9Rn+PsX/viwGrFrENlMnBj?=
 =?us-ascii?Q?fSzP1Cm11EMsHL5mrnyQ45yitipd0VbyswyWqZqHxHdJVorPUfLq6+62nREO?=
 =?us-ascii?Q?KBhdx79KnuqTulSoH1i4UjrFkbaNgGs7Rh17DKel/JL99H5alK+boS++nDEO?=
 =?us-ascii?Q?k69QGTZNRTKD4frIgXb9UWMRkb0O8awYRj4Ch3ah81jEnMTVk5mOxKl5A/97?=
 =?us-ascii?Q?LhYbTbTY5CA+2jHCCUW2/a8hCvCoi/micb9QVgsvvz02Lfj1ICraF5PKJc1P?=
 =?us-ascii?Q?VBdBkUr1+Sv4/luz2cH4vGyH9i7ZKUGFKTjyzJ7c+JoUNRS/Yu3sphi27q6O?=
 =?us-ascii?Q?vdORSxTBsqIP5tBDqyBHJsoU01CvFG1uXsuuUwoI10WuwkJLyYUtKGr6MtF0?=
 =?us-ascii?Q?wESSdfzq4orDMob5B0u9OKhr1LjT4c7A1VFMcI41+bCh1iO2NNELRuG/SPJm?=
 =?us-ascii?Q?O+BVCG/bmlOPebfKl1chJxxfbP/nQXg0twvUW545aaA5hTv5eJ/b1Gv1XPno?=
 =?us-ascii?Q?7tS1+/Huq8Nqpqn9nGH5koA+7udN8tLKxcpHFC79mauViq2laNzHlF81JCfn?=
 =?us-ascii?Q?jmPD9/t2gx9zs00Vi8aEyLkdZclSz/HFfloAA9CIKI0xnvC6wILxITDj5kkL?=
 =?us-ascii?Q?8/l0SvyGtWuy9Fs3liIVkmgCF36cCuWwOKEFF5rKXFJHTGhw0t2Z2I7DVvLH?=
 =?us-ascii?Q?EsQluzQSJcDY+LiQ9wl2bKplCn/7vigvp6wFrCmVmpML2HmHz67rzHxh1wrG?=
 =?us-ascii?Q?DLogaHIysCePsuZPLAHhOKVxc+0cuEclWUJxQ/JKI4hQx1++CbGnXbXJO9x9?=
 =?us-ascii?Q?3ic/drwfdRCMzK6rfvblMPkuQLtcB6sQPNLicfo6VaOv9XsoqF8R3GQTlcja?=
 =?us-ascii?Q?Q/mUuzAzfxcXDfXcRo1Gf6GiooeWG/cil2WptK7Gi/o63plTOCh7+dBj9892?=
 =?us-ascii?Q?6JfgRehVxlW7gayDq6ryiWinyymh6qvRtAOf3bs2FtOruYUK9XuMuasZw9+p?=
 =?us-ascii?Q?awkC67EA/GyGggaR5fwLlboxET58fPqN8TOL3iJvVT3D4VXR+jn0BH+Mpr7c?=
 =?us-ascii?Q?5OCLPxujd2VLSNosmnbFSX5gAmM7hWCAqlVQ4QGWsaCzPy5YLXCTrbpGkl60?=
 =?us-ascii?Q?bZi4aTMsN2ogvIIGCGM3gXBwFGJdZLJVHZzgmlF2iSton2W8IMGc9lBMe0dV?=
 =?us-ascii?Q?j8aIrO63OVJrc8ktUeFjQQ0=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8654f474-4c88-4ce8-91d8-08d9b5418d33
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:12:19.8653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tvxmXxpa86vur68skDaRpjKFTuomkWHa1E8i4byiKyd2gUY5IZWyXDjYZx4AvZcPEZ4x0CYYivRLYmnWPYiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0601MB3690
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch try to fix potential memleak in error branch.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 security/selinux/hooks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62d30c0a30c2..10700720bb74 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -983,6 +983,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
 	struct selinux_mnt_opts *opts = *mnt_opts;
+	bool is_alloc_opts = false;
 
 	if (token == Opt_seclabel)	/* eaten and completely ignored */
 		return 0;
@@ -992,9 +993,13 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		if (!opts)
 			return -ENOMEM;
 		*mnt_opts = opts;
+		is_alloc_opts = true;
 	}
-	if (!s)
+	if (!s) {
+		if (is_alloc_opts)
+			kfree(opts);
 		return -ENOMEM;
+	}
 	switch (token) {
 	case Opt_context:
 		if (opts->context || opts->defcontext)
@@ -1020,6 +1025,8 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	return 0;
 Einval:
 	pr_warn(SEL_MOUNT_FAIL_MSG);
+	if (is_alloc_opts)
+		kfree(opts);
 	return -EINVAL;
 }
 
-- 
2.33.1

