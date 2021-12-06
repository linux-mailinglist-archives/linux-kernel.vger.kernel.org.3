Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662E24690BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbhLFHWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:22:45 -0500
Received: from mail-sgaapc01on2137.outbound.protection.outlook.com ([40.107.215.137]:3570
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238367AbhLFHWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:22:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5SYyA0ebluZOoijF/WHpb9WSsLGlkHWdOR48qL6uLkjtfcz/6MPBZfDy7czM9vB0vBDNmM0kgwXZLRWVIzrg/yiNdR8Ev+o4aeTOkP7tZWobcyKI6QIsE67RJPP64NbD6MwMyDwPLmpM+kIUslPQUTFt8CFEJSJWHq41HbCcRhtA/n2ECafaYsjBrs73A/ebsgUxEp6RY6hkgFFWLY7zFUDQZQVtT9OCE3a+gMGwlz9+v7Y7gViE/JZeZ1405r9KsQIi4UWpl8mXxmUa79MewwR2Wd0PuVY8OrrSnzyNzY5G9loo7SWX4ju5cBZl5rmddtkk6rUFv34+r796KJ0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0tWvRzWrJdPk/XrcjY3IW4yY3RIDAJeeXJzITa1Yxk=;
 b=dC8isNPC60ipvXkSLd7eLPUARZFEpE3rMb9ys73ThIFxPlLZnkMuuXVxbnY1jQHvJZD/5q2RXqtVNfckCvennIGYDQbjNXd+DNuuVhjhuTHQ0aJPldiq9g8MHD8HFIiad2T9/GYf7DNuvRaVEeOQiU7sFyWYq/Jsp0W4aBaF9gm1gr7sAjcgVsxQidBjs5CsQeMhH9ZOybkljWsVG3pvIQvFkgDzdofrbPkyqxMnI4ANVi7ZC48fIbyRwzf4Lm4Dio2igXyMc3goWUtoAIyHaSuZRcRKZSvHWHJN8f9ScV9xAxMvpnXO/eC5TWjNyAyE2n8VBe931PFlpfB/3dIGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0tWvRzWrJdPk/XrcjY3IW4yY3RIDAJeeXJzITa1Yxk=;
 b=JB7dim3wMxwDG+1F6+RVUiK7ZkNZvPJk8/H5UYYj0Ns8cAXdCx6aM3ef+K7nDi8Gf3fsScNE/K26VrOK3bPEl4yWkNlqZXPhBfN24CE0DR2sE3xKaqnIbl88JxboAPf+mT2EFsa/fBBSLfiOUSg1EPHcDCTJ0ZTveWqrrqSvICQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by PS2PR06MB3303.apcprd06.prod.outlook.com (2603:1096:300:60::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 07:19:10 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 07:19:10 +0000
From:   Bernard Zhao <bernard@vivo.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH v2] security/selinux: fix potential memleak in error branch
Date:   Sun,  5 Dec 2021 23:18:59 -0800
Message-Id: <20211206071859.324729-1-bernard@vivo.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To PSAPR06MB4021.apcprd06.prod.outlook.com
 (2603:1096:301:37::11)
MIME-Version: 1.0
Received: from ubuntu.localdomain (203.90.234.87) by HK2PR06CA0003.apcprd06.prod.outlook.com (2603:1096:202:2e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Mon, 6 Dec 2021 07:19:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae4228b-aa81-42c8-f0e3-08d9b888b24a
X-MS-TrafficTypeDiagnostic: PS2PR06MB3303:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB3303A108D601FE3E25D23756DF6D9@PS2PR06MB3303.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNe0Ams61yPZYPB1n5cQW34kyYTN6WS9n0SeFOts3q/KRtQ+edEOIN0H/szh33chhSlIqFPrW6CR0XIy3xkgLWJ01owzcVxEzZ5YRdVjCqm4AehEaLd67S1Zc0PSLf61XzXLbEP5ltMOtcIFU2+MHXdHWeju5TYd4JM0GpjbSEA/oMgADlLWw1Rqw8mv/GGVir/3ZJTD/vroT0ONSeOQry50AxCykxgtRTmXJezJ2BUmznuJWJ+oGIdKQbWaU73wdbpLwPm5R0goGvHrBPuuWHqgUly/n8XhIeR/U4l4MGjUa+bWAIIeJ0AR/Z9J5gpIAix6zTjBuOLxSuHaD8/riiDBa38/u4QZDOffUhp5+Kjam+jbaCMOIHSCPncEMeI0YQaCQ6ssi/1loB+TuVveSWrxN1tk30mAB+QsGOvr1QuttcdB5DMRPJVAcq5ypGWmL02Yj7O1/UItTPHZvEm7r/0k/XGdX74HJU3fyGDahHr5HXtcorw0XjP9WBqiS9aD3ZaJCUnG4Tv8zK6CvSfLu1iUhSvE0OL5lwY/HRKSRcHCcpXkkwQDj/5kpTkHMKHXKexCWTt6/gYW+GLed58W3ej1ra/E5JcdY1dOCgG+9vsdBw4pIyS6rRkdmLO9uNdFEE5Wp0C4dHk2QurN7ZU+m6kXRWggTGgCJS3jBWiIQY7HxkJyyWUIcykbpZsou+NnHSybmanlfOLCDd00vHuQrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(107886003)(6506007)(83380400001)(15650500001)(186003)(110136005)(66946007)(508600001)(66556008)(4326008)(6666004)(26005)(52116002)(66476007)(86362001)(6486002)(5660300002)(2616005)(36756003)(956004)(38350700002)(8676002)(2906002)(38100700002)(8936002)(1076003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?956iDOQ+CzxyE2jt078wHwCq9RpdG5iWzN93krxO2xVZrB2Sn1ysl7OZu3gQ?=
 =?us-ascii?Q?kKSwuRemZ8DvfQg/gZnmrsjRMdKA1rDiviKJsRVywqWovL3yMGgJtdpqEcT8?=
 =?us-ascii?Q?jPxal3d3yqdd8p50Lpf98Ld2N3UW5FulU/W21Ryg+SCMv1RCbKv4W8dFsrPP?=
 =?us-ascii?Q?AOm2DZnAO8IDBk64b7NrRpoAhLLy2mwuT6ASjg1UN0y3bmMsCJN20QyfhDR5?=
 =?us-ascii?Q?WFb8W3YMKYTcfnClUgCoC5MEGef9Iyu1wxB1KjKoCx+TOtR82uDlyUIr+DuB?=
 =?us-ascii?Q?ojRrveIjR9UMhfgE4AVVumLWfJ3u6zc+tUY2e2CpKbxZl3lAdGb0J+DZeYwh?=
 =?us-ascii?Q?ILGAb52UyUjarCAxh224tFvNnCUqObEj0wfaXjsnuG+4zWImql5Jp0KnT+Fe?=
 =?us-ascii?Q?9x7zCVpKrLxOBJaq1IG+csWjiRQhx6k86ztC7DWvK+6xr3skJnNUPTDRnZwc?=
 =?us-ascii?Q?fyggVvZPV5T4joM9WXL6wYYLAUzcWBMH2yHijQJJSV45cgjQ/flllM5NBUlA?=
 =?us-ascii?Q?bM0kuoJHyTS1WmZaQ/KEnxzNZ5dlIiPFrqgYG6EdejNT8bujp6b1S88SLvN/?=
 =?us-ascii?Q?KxCyNYv1Oef6GZshMUkGAs3CVJ9t9PcHIzOiCyQ1KFedsuUTwBTSfxHNTYwH?=
 =?us-ascii?Q?x+mQoBhoSmVUd2TR0o8ZsFQwXbDIVCWolZ/IDR15CjY63Ny7/BS5/S70vj0r?=
 =?us-ascii?Q?9+iUCK8IHs/TzmYecYB8qHBiQL0TN+7peNGzwVbwlDttB+NJGNSShOcuGZZx?=
 =?us-ascii?Q?1W9ebCuY/Fj1q39w9eAGPwR63SobQMajCto5qH5+1uIqUucVPfXOIxhorm4K?=
 =?us-ascii?Q?Hz734QxaPsdZMN6qZpD0J/KiGgspTOUx4Zza0WkYM3tsRy4G1ziyidnOUPuC?=
 =?us-ascii?Q?cWqFK3aCFd8RRnfFzJUo7V54eeZvQlKrrywZwuXhGntUJt0b3VSJG3cticIE?=
 =?us-ascii?Q?j39iXRxPaPn6V5nFdhxuyUx5+IWikMelO4e6EY1OpFf76NpIWsmiYKeCa09L?=
 =?us-ascii?Q?H2y+b62Kk58k+2JkPHpa+has3F27p+DUI+zVyuhUI0UQODdTUhA5+pQ219Hv?=
 =?us-ascii?Q?qcimcQzlF1+O3W2dH88Xma3TMa4/hjqhKCtv4r3GGiLfGuOeyYBWUNuJAtCc?=
 =?us-ascii?Q?zUUx/Ul0lcUp92hsJgLxKAQsM1vTZgQB9DEKW/SOFRu52dIOLTnhMm8ua6s/?=
 =?us-ascii?Q?mSqiqsefcHCF+pY+OFZGTdCmMjiXeRXdalzypV5GORrjFRCJ8jl4CtlG56pn?=
 =?us-ascii?Q?LSBtQDRAUOqVuPAoNEzn1j5Jj01pHjBO48pk+XTMdaDJ3f0h+FRygldBmYPc?=
 =?us-ascii?Q?oaUW+bcYDrhnKPo7IMbbA7TI7gUcaNijdNtRwhF7TpKJLsZoboqf3yBrvzM2?=
 =?us-ascii?Q?+zDv7VkkwVd8m1HolS+5JPOT+r6jNiNB06LHeILHBrw95ihwgkh5SpwBR7S0?=
 =?us-ascii?Q?ot3qJ4h+TY0QH7U9GdYpC/76c4/KMyHeCv1h1ZCAhpZrR0RlJn9bmzJ+8QhW?=
 =?us-ascii?Q?KiCZiOlbZxwnNFKUvwIUvasTWIPW6I4C7+iSN87m8sLRrS+PvGdUhgzDXq45?=
 =?us-ascii?Q?kKY7S7H54wxVZBIDG6oPCexaR6PjbXU+vItuXNkYhuec0R3cdwdJWWO1qRig?=
 =?us-ascii?Q?O2HKMF/kW306Ck+ec+AHBa0=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae4228b-aa81-42c8-f0e3-08d9b888b24a
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 07:19:09.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwnkPKSh79mXb+D9VaWfHWNwpNrGvbNkkjfAZp3FstwDJ2/UFgqTf3TaClqhAK/xZAVkfH+fnndqxNehWvwtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3303
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch try to fix potential memleak in error branch.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 security/selinux/hooks.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62d30c0a30c2..8dc140399a23 100644
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
@@ -1019,6 +1023,8 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	}
 	return 0;
 Einval:
+	if (is_alloc_opts)
+		kfree(opts);
 	pr_warn(SEL_MOUNT_FAIL_MSG);
 	return -EINVAL;
 }
-- 
2.33.1

