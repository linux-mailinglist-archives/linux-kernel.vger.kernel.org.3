Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD9470067
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbhLJMHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:07:49 -0500
Received: from mail-eopbgr1300103.outbound.protection.outlook.com ([40.107.130.103]:14129
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236854AbhLJMHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:07:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr221zx8xAqT4OJy+MjwHjdHQKweYtkzjHshC8MbmXCYzeVYpxWSoyZx0rP1avHE3oGFCogIIno/XsCW35855YMuSOIKPkTepVHrW1bh9rmGBTNz64DIHHwSOfr54DIFnsX6A40g3/e4H6szzsQE/bNZRMetHrIXx1uwU2bd2xoEX5majGc5G9oGgUPBB/EC5bz3VGy4VcxKft5U/WmYbhGuTPekZ38uEYrGatDdAnG4DCpgZEYyY8BPg0y84Eql80aYts61VAvdmgk4N1dpn4xtgTnnU7TU8+qm062Zpu+imXZYX22BtSYOaa0Xjph1qs7HN852YW6UxSlMZmO5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD0ZrxUsbKv7zCxaOHXqBQP4gQgokO1ZLif5+ZCbQz0=;
 b=dXfNB8DjVR2/MMIB/esdz74dbxy+DTBmzh5tYuSpM2TtpwX9tSPfFd/TN/2GTZ8bEYoIc98xtR5W3wlWNLRNzUOA9HWVzwPtGYktd5HCX0qDEZpAMLCcD75MhotjhKthSPeJiU50WDTTQ4qbzAgQmfiFXl094c5wf2VkcQs1tlKpNL5SJ0vcbxbXbzmxdK7q44NiJlng34fnBIGgdcP2TPZPEWodJvKWYaBF0RSzGUM2O9S/Np6xbGYGJSArNzQzY3T8oy/tvrSjuHamT0VtqeTXKeRk3wpux2OwEeV4Tok9s6f9T/OhbXI1R2gQ5LPb0WcpFlWh1aym6UxC9nWzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD0ZrxUsbKv7zCxaOHXqBQP4gQgokO1ZLif5+ZCbQz0=;
 b=GDfjzTRSRTxIH6s//A47pRCd4Zb0nBACz7fnQDLBbtGU1oexfzIzChGfujYYrmg/+Z/rWhnw8eECmwmlBXfckPHpkstk8N7tfdb1gImtzzyCvBJbl/k9CJ4zbNNhGOHl1GKsZP1zPY+APW0Bt5+zDJweSYhNIznQBvDOX2DpARE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by PSAPR06MB4326.apcprd06.prod.outlook.com (2603:1096:301:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 12:04:10 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7%7]) with mapi id 15.20.4755.026; Fri, 10 Dec 2021
 12:04:10 +0000
From:   Bernard Zhao <bernard@vivo.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH v3] security/selinux: fix potential memleak in error branch
Date:   Fri, 10 Dec 2021 04:03:58 -0800
Message-Id: <20211210120359.394986-1-bernard@vivo.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To PSAPR06MB4021.apcprd06.prod.outlook.com
 (2603:1096:301:37::11)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.190) by HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 12:04:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 706668b9-8745-4e59-1eb8-08d9bbd52c72
X-MS-TrafficTypeDiagnostic: PSAPR06MB4326:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB432646A5134C338CD5EC3049DF719@PSAPR06MB4326.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpWXoA7WEHyO8xPXZ76ZaFmmRWF0Bltd7pKRwJRZSIzyh+iB6/6YpaA4v1I7yYyF0ZkT1z+5dsvYubKFkD6P+YqwUmpp8uDroyvf5Q35BPzyCCGctZvWVzlXTFT8TVPf8neteDxMLAOLGCjevq93Fdjc5reL+L/7SsaxsH6swOyLKPdecVF+RUoZQ1qclo3qfQ9wH1is4BUI3/tm1cTppolpcyFaQisFzcfliQmF0pF7MB7qHpIEzacR6G5pzLUIWS9v1NkypHKweKwhXsSfPZNs8wRzEKxFFqktA/FkAAEwiNCrwZzmsMeTYV1XSXB+DglYgbQUZ93IJmfcLWdhR+bZqFu3LKrt5yHVoTw4GNcvSyX0FxckODzahud8EdUjg3gaYDbYX8qFIFoEuswRkqEAI1c9kvIKdNDypro8Slz2Y/p3/khp3XIdEpyCy5YpIs+MvatAHyTzJSpf3lwJIGrTsdcUaAN9aqgTEclb/gwYkWrnJrXbMLWyu/WeYkrGr31Y94MVqL3nWCAzKro5ZXTbDw8YZ2ib59e9y0dQY8t48y2hnMJa7mMhZoguE0ItAORc/dowkSXhWLfoU5hfK9z0qiaH3FQlxpFlCwEg25GsOBsKrqRmfn7GucAiYgY4qy5Jq8l1qKz2GvNHI71wGP4VY4gYDiHztEVZ8XVgfZHyDwytPt+36PftmEFSEs5m1VEJ3w0xBdjzAJkuG6G93w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(5660300002)(36756003)(38350700002)(508600001)(38100700002)(1076003)(316002)(110136005)(86362001)(26005)(83380400001)(4326008)(6506007)(8936002)(66946007)(956004)(8676002)(66556008)(2616005)(66476007)(15650500001)(52116002)(107886003)(6486002)(6512007)(186003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EeBZLwkm9hzO49rEm1MkLuu0u6ymF0S+civGxjhzLGRdIcya9QmbZxYPBZlp?=
 =?us-ascii?Q?tmubZEAGZaVwwksXBgQyaXFGOyYyl372M/gJe47cjo/hTq3CsC62I80Fpx9x?=
 =?us-ascii?Q?hV+dmK4Vv8jQeO5Hg3arZcCYrnjaRlZjJnQ1yrqrlqjWUKJumWKqwKVvSk+X?=
 =?us-ascii?Q?B8NRduZy2Qh+LjvzdNy3GSUDEAqrgffQO4JjuReqChHWJLxk78H+YJh4tvnb?=
 =?us-ascii?Q?xkjE0exSXR0KnqNnYOhSSm6TPdA1so3mSEaWGGk3GuwfP+1caGaoJRFYnb7w?=
 =?us-ascii?Q?V9RpJXfy8KGFixiVNi5bVeltL19s1RcDXpLQOvBuU92CZTOIvj1hhHF7tWtL?=
 =?us-ascii?Q?r5QHlwdqAeZKp42Q7Z4QkipnfLzpZpgHImsGareJMhNJYpt+KdS+7Y8kKUQO?=
 =?us-ascii?Q?hvegacrrKDNvtGfTl/dnM52KR9glZVCQBzYl7MZnPgm+EcpuEwnr8qEIFtrF?=
 =?us-ascii?Q?9VE9KPBzLw388dAx07KIdafsktSpWfSGc0a/XgmcPIjF9fLEH079aQOPA4nb?=
 =?us-ascii?Q?n6LWPIPnQCNAW5jzW92kD6MFvg6fTsXLmNtrfPbBxTRqvsBdViZzeWqcB14D?=
 =?us-ascii?Q?XMoBRNBCKg9tPaHRBc9d0VFtpT5Chwymw3SOWQCIaAG6fa5m6wJdIIx9wBqi?=
 =?us-ascii?Q?/qJ1D92HuzyLic2BUuKAlasBgmwdjqp389ifHejBdYcStfqOwnU81g+Du4cI?=
 =?us-ascii?Q?93f98mBjk0miHlvgDrX7QJEXsOyvnw8bkqqRtVGMb3ihSyBfBq4cN8YhlYEe?=
 =?us-ascii?Q?qrUZcF+8JodsFJoRnUEjc+nTGwO+0H+6OPXFKI+8HLURxQ8dBiF+BikhiBMI?=
 =?us-ascii?Q?F1jkR6MaSp6QFK2q0Uy13Q3EGLVa0sZscqwM1GJ2FNWLm2yDE34A8u3Izzrw?=
 =?us-ascii?Q?rjxiFJZExbC2WUh7FFoTssLYl2IJ06c/HTa+0aX7rmzeeUKYLwvjx5KXSdJc?=
 =?us-ascii?Q?NqgVlvRwVszm6COqIkIwytaYwq9wESVu1r6fPDxCvt0zhxcnRpZqUbmK3ibC?=
 =?us-ascii?Q?GLkdxjXLpvae632I2m7lyrUhiXJDsuml5DlSY74L7FBNW0SQIgtzDy/y2xy2?=
 =?us-ascii?Q?U5eU2B8wYH8UJAPGiIxP8Jua9tbXCUU4zxII6tuf950KeACVZAl5QiJhFV+d?=
 =?us-ascii?Q?xr9f1lXxTEVZ8gsRsCDaiefsXkkOFw0YkPvSc2u7Sh+Ju4C5nSdbRoeaxGmG?=
 =?us-ascii?Q?z5X+fplJBdnEH+j6lm65m7+Q+6rsKEjzGE3VwYJfSqO1hvD/BDCCeOLwwXzb?=
 =?us-ascii?Q?sf88WCzkwgiFyXNuZDI1IkDmeXCpkK5+dimX4s561TtYFanIaKk7JJWTd62V?=
 =?us-ascii?Q?+Dg8aB2vXgkJfJAM9dolX3icsd+490vs9UqcOCAWI5ykVRhr90Los5bEv77c?=
 =?us-ascii?Q?+rUQJUxtHdn4QHkmG/GfU7l9NXmLR2Vqoa/Kb0EAgl8B8aITNHdqYo5T+Cnp?=
 =?us-ascii?Q?/Z2lFr/Ga39mfouH/KoLs73hqg3lide7fmudiiPAkkHUZ9e22lL7T8v1zTG3?=
 =?us-ascii?Q?g+zIP5bKNBIxy/vKGOmA+wYHnJ+P6iFB6oR/Xq7ZiqcsBq8whzr+V8mXRsKB?=
 =?us-ascii?Q?6/MvGI9nryru5RuLdtL1GCv2Uhv4p9OZcww1DPlcnlU7O7vPNlgw1S8BNnEZ?=
 =?us-ascii?Q?dUymTeNIf4aZaqY1qfDlnsk=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706668b9-8745-4e59-1eb8-08d9bbd52c72
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 12:04:10.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX4uAkWAk4QYag0vf5MgWSNjeNVCFlsKmOXwSpNQNaGkgJNUwIQpNjB3kzvN6Ysot0hHAHCWbr03ZVf3n9AfXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4326
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch try to fix potential memleak in error branch.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Changes since V1:
*make it to be simpler to do the "(!s)" check before the "(!opts)" check.

Changes since v2:
*add *mnt_opts = NULL after kfree(opt) to avoid double free risk.
---
 security/selinux/hooks.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62d30c0a30c2..0d018f054dfb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -983,18 +983,22 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
 	struct selinux_mnt_opts *opts = *mnt_opts;
+	bool is_alloc_opts = false;
 
 	if (token == Opt_seclabel)	/* eaten and completely ignored */
 		return 0;
 
+	if (!s)
+		return -ENOMEM;
+
 	if (!opts) {
 		opts = kzalloc(sizeof(struct selinux_mnt_opts), GFP_KERNEL);
 		if (!opts)
 			return -ENOMEM;
 		*mnt_opts = opts;
+		is_alloc_opts = true;
 	}
-	if (!s)
-		return -ENOMEM;
+
 	switch (token) {
 	case Opt_context:
 		if (opts->context || opts->defcontext)
@@ -1019,6 +1023,10 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	}
 	return 0;
 Einval:
+	if (is_alloc_opts) {
+		kfree(opts);
+		*mnt_opts = NULL;
+	}
 	pr_warn(SEL_MOUNT_FAIL_MSG);
 	return -EINVAL;
 }
-- 
2.33.1

