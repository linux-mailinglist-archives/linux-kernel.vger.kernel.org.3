Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD65468FB7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhLFDfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:35:09 -0500
Received: from mail-sgaapc01on2121.outbound.protection.outlook.com ([40.107.215.121]:44896
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236194AbhLFDfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:35:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0INA2n2i/YMktoEBkB1vgyJtPbV9xLwfM+Bvv2tcxsQY5yy5V5RpXnWTvEKcixglADhPgaQYh7VP1GaBaHaivD8YP+bT19ln7eN2cpgZVHvZZelditME4HCB8hsn3bZmIaaH38V8JMNp5/K9cSMcPuerHHliBjnX51T+UbOICCDg4pUm4n5Lf+5n5jAvrCO/3Y0BRemyzcAEvY+Z04DeWGsofg2lCvOELCD69igO790jXbvhh81vfKpJKDL40FkDOcWS2Y7pzKRUFNFmq3gHfxBe7yMPJPhCwiTzapjHYQb2MGiZgCTRg2q6nrSxGOTYGhk1i1Mu4Eeu6MMTcS5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLpEQlsEj0kLNxMjcIU9JOXZ1TRMeyhn9/b+/O5y5vc=;
 b=B1jRHrIcx4eKtu9PQfZMUreSa3tlZ9AtxQo93XOCHHG2SHYTxcN7rcDiILXvmu+WNpNjOXu4bAEv4peGBokNe+tOmOuYBxOKRVm2M8V/M9flAETGTIUpN+y3oQPal+YHXiwrYRasamEjSPgs32tGKYBhowU9nsdHuNECjl+d3hpRh+7Y0AONw1IaiXO03br0l5iHYiIHm+bmguncX2lllGi6Asujqb+1rWdYI/avMzQjOvRXgKnTx+iKLOblo1iQ9UogYuOsquTVM2C8UnWmxjyGDs5cdt6ZKFEQfJJOpscg5PGB0XQV6v8PlpRkG70xycaCcQsCDfn1TEWhD6XUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLpEQlsEj0kLNxMjcIU9JOXZ1TRMeyhn9/b+/O5y5vc=;
 b=epi0U7wkED0zaD6WKY5oXAzjJuX3d+KotBmhtTC5MEg21UeR9Kk63mM5+UlUFFJ8mAhQKsALtzbkSMvUXtc3JK9xwdgTHlJRbqqutuK9EthCuO0GzgW8sfLHenH2u+giwyCs9op13EiCfFhnSOptw5bqTJhQgR8NMU2e/4mLnIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB3646.apcprd06.prod.outlook.com (2603:1096:404:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 03:31:38 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 03:31:38 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Yihao Han <hanyihao@vivo.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] XArray: fix comparing pointer to 0
Date:   Sun,  5 Dec 2021 19:31:14 -0800
Message-Id: <20211206033121.28100-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.vivo.xyz (103.220.76.181) by HK2PR02CA0148.apcprd02.prod.outlook.com (2603:1096:202:16::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Mon, 6 Dec 2021 03:31:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a063fffa-2212-4bd4-437d-08d9b868e943
X-MS-TrafficTypeDiagnostic: TY2PR06MB3646:
X-Microsoft-Antispam-PRVS: <TY2PR06MB36468B288FA52BC5E20D3FBCA26D9@TY2PR06MB3646.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WBwRbkyP6KEboI2Y/kFlRCT03sg4uORykdCZ/mcEOlnIlrlLxVI4DUsVRgzQpK30CdtKLSchBDyPlfjkGaMEg74rauWy/GJoNS7FZMMCKOQkbh6QwnTosTO6O7zgwuTe7aP5r+Pd06whgxYSK6WnOY9Q0Aigpeo/eRUPE/gKnE4IjTb8dbpZQoTAW7gEu3/sbFQ7yCZQSg7cVGURP+WwrXPR5FcV/XMJfCf7z4ZjW2p60Miq/bBQdOPlCycvzJNAk5LzEsShKB4Xmqs03axqDfPqOMWuAX0GCXE/tlYzniGPvYwIwDPwNKESzfkd1pmKOnqy8nVwZslW9gmp34aJTbcNJv4j0d730RO6A/heYUyM4pABVd7gCyzXOkE2FmJ33TssZFnyZXUrKO+IZNGETa13VrNXOd0kdNmBL0kk6mlbKSAnSVsY5I9vMPwJ4/Og3/7Y/hgImeptEH80bJDUrzS2Qdq+0RnQenwODaUJzjPGrWr+hUB5k/bj5KDWlvWrfeCRT2R7K6daWBsf8Kvn99/d2+uKo2TqSzSdPGz5D3hL+nEtPjH5GrvzYM5vzBJecB+Y2pCIibQXZa6ba2Ym9xdXt1M5B3vFT5iFww695wpigucBf0KWSalSpncUKCV6zrIlkYRR37qstD+7hQNNlgbOMzlzJBfYiECliw7QeEkLzLUki64VJgddR8/EZ2BRIH0WLF/XCsccX1Aq4d8qF1kSzQnjLFKLNPa0MbnsBVfJx9sQxRFU0kD0vMnyzku
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(316002)(6666004)(66946007)(66476007)(66556008)(36756003)(508600001)(6486002)(107886003)(4326008)(1076003)(2616005)(956004)(6506007)(186003)(38100700002)(38350700002)(86362001)(5660300002)(6512007)(83380400001)(52116002)(2906002)(26005)(8936002)(4744005)(8676002)(182500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KLPtRSUZr/8UgfVewXV+S3LuKRYl2ocHvLtJBfOnvSroRS8nC/EM0BbZV9gG?=
 =?us-ascii?Q?kQ9/bAO4v+N2KhmwjkUsvR8H+ebU+LhibVAe/N3JXzxfLQBFdBpdywh4Ea8p?=
 =?us-ascii?Q?AC35lBjjL+mnOsKlFERJAQ9OjW+ULRqPBj13WgvsUEvL1h7pMtsKJcJkt6DB?=
 =?us-ascii?Q?UtmD4jurgb0fE+NPAqDVYLlaryEXFJEmCuahBu1yhh/bqDZ6sKX+ciqu2xeZ?=
 =?us-ascii?Q?0feFMUTLyAuCenRpecWZN5tBU7UuFEQYA2Dw9d9DsCUmIl20pLFXT291m2u8?=
 =?us-ascii?Q?/dAtzD4PYaCtSJZmHAL1j/0GWuY+shZ9MXnd3mjsgZNbqlm4KtBuuLGzDquP?=
 =?us-ascii?Q?9Ub5ftKE3bzh7XY8BM4FftQHxWYfsf8dwx5WJFCLd4h83xCNM8EqgdQKl41Y?=
 =?us-ascii?Q?7rfKLHu93hKVGjPmPfd19vQg9MzjSYnvxKTQzOKyg/g1SlZjju+LERAOoaHn?=
 =?us-ascii?Q?WLYWx/x9wXIX4jmRuS4ICmBX7vuKOiADCPU0mOhlFRCvnI00OInu2V8mUyPI?=
 =?us-ascii?Q?nPQUlNekKkmk/EIo9BXUcWlktb8VQDUOd2ntlVl8OEnNkOIgtlM1m/6Sl/OK?=
 =?us-ascii?Q?flglblCvva20qUfGOT23D/f/krlgQdljRX4bwTa4oFy+4x02JKeIdBBWwcoY?=
 =?us-ascii?Q?BU2u2OOkwWzhm3UiNMz8rMq8QZgDgY3aBa6rQXJbnEYB/fZ2ztK9geURESQ6?=
 =?us-ascii?Q?I3IC5z8wdgVVqh0hRHsKqQAkweHPiIUdU1kaeaBNSBOcO59Pz8aj6gpaM62b?=
 =?us-ascii?Q?t15c7JoTb4UqjBRw/5SJChD8EjqbhOzfy85MJ2qBt8zebEc5So3b30e/gYHt?=
 =?us-ascii?Q?CFmfrvDeJbNEL78M8AkBliqRnRRR4GBaGiXMMa6V7EHDWpl7fPvyuwEuzl0c?=
 =?us-ascii?Q?Evc06d9+mNFKGo3upli4Y3vdX2/B6MqQqr7JcoVh7wiIVw+1ybJEjRBCBoeA?=
 =?us-ascii?Q?jNgbkz3bVOBxl21lhVrybSHZf8ef8wukC4N31hu1xiNEbBDcy2hhdPlqAy1Y?=
 =?us-ascii?Q?eyHU7f23Tl/Rzwo7Sad+SIZb4y7s5iX7iloxs9f6MC1GIL05hJIsTpyvrkvP?=
 =?us-ascii?Q?7HI+NAQK13Fqeuo3C3i1E2N5yKKC1v0GN3imQWZN/Wajtwv2Vh1qqWt+zDJK?=
 =?us-ascii?Q?Q3xdwYFoCx1tD2pSmwHc4WrICYGzuYR+S5cYoZFV3YgdmDqZPP5uNOayOmu/?=
 =?us-ascii?Q?/nRJR5Ne55nCOqRuiiPs8YjRBSHQkOPpKfoQTVMwFHUtnttpdMjklJqBf+Cy?=
 =?us-ascii?Q?xMa/UeEJntLWJ7hFbYOUSFqunsI9KeL+98HEyBvTeROzwyWov+c04oc9Nb6L?=
 =?us-ascii?Q?ZKqxlVz41DBQxKmXV21rPwl6ve+VAQM35Pyqag7rlvA1/DwPaCOsW2dhB6SZ?=
 =?us-ascii?Q?mEbq3b5KlnsDU86Q3JdFgOppzWuoGlQ8fXyFZrQx1qY41bqFTMmJxKdI/Equ?=
 =?us-ascii?Q?iFQ2LvYkUab/GuWr6erfsNUz3bPHliFOtEpditcY2A+OX6JAUcqIQlATf/iG?=
 =?us-ascii?Q?vTFBLznghHY3nfP7b4p0FyVAvXZftPTxzpLrEQdkTfmJVu2gdosx8yNC3YlS?=
 =?us-ascii?Q?Danv+pZJqub4AAscQ8v6TWQuHEU32vKbPjAlQ/0uPM11NBQ5uMolzqCWnizN?=
 =?us-ascii?Q?SxyE746qb2dThVMIqnc0lwU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a063fffa-2212-4bd4-437d-08d9b868e943
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 03:31:38.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybT/+/d3I6GTzmgGR15RrbKXe7iM3PqfNleegqwiiikg4tH+HTmSu8WKtfWB3hjNxlZ8fDfdqe6oKMU0Lja4dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3646
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compare pointer-typed values to NULL rather than 0.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 lib/test_xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index d10cb0182654..0c366e88d884 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -742,7 +742,7 @@ static noinline void check_xa_alloc_1(struct xarray *xa, unsigned int base)
 
 	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
 				GFP_KERNEL) != -EBUSY);
-	XA_BUG_ON(xa, xa_store_index(xa, 3, GFP_KERNEL) != 0);
+	XA_BUG_ON(xa, xa_store_index(xa, 3, GFP_KERNEL) != NULL);
 	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
 				GFP_KERNEL) != -EBUSY);
 	xa_erase_index(xa, 3);
-- 
2.17.1

