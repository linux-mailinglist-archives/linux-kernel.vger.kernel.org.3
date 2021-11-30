Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21A462E27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbhK3IGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:06:36 -0500
Received: from mail-eopbgr1300092.outbound.protection.outlook.com ([40.107.130.92]:22705
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239390AbhK3IGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:06:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQVYLxBlpXVKefVbDsKKLg51yVgxb5hTojgsS1z8Q8ygkG/TtXCQrki7M2jrxUsTRm5DMmBNITFfUDf1UFC0YscnRzWpEtTAT04viUJUJx154h6tRAxDT4qxbLfDhpSzmqiZG6lfwDaPjrvyMcOSqUcko2nUYRP6ncbfG0QxKsTpUN23cpKfY9Yy9OLGG8KivEBZvuAIdW+ukbRsJfkBWftuzqm8CHamsgKpEgUN/9n9y5NxjcBStvVbJzEGrRHSTXQqw6F3XjqHp5gUUNjK8DR3oHB7ecQEWs8g4k32ILI4RvmuqFGn3RxtU1mtuhnUhTOk6cy6p3ua/l0OFg7+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IO0PEo08oPN0s2yuwSJSS+VrDllcxZTjezYGe+I+mq0=;
 b=jaJyqT5nuHreC7JsbAb0gpVa0N6dx5wHSAUZTNRVDZIqw+3nPrO1tTCnilCMCN95tDrbnGCk0FjwjeprZS8l2KytNNZxDtd0M+CDpp/szil777vI71p49iJLInuiUhsdu7C2vxY1QJLRrIMAysGQh/2+M7HgXqArevYjIGRqJNviH96JT/ymcMEaOAqQdgqj63MiBbR3/J///hfNAdvI4u35Mlh98IFmQSaiZCACyDeXjd0dGzx1BfIiVDxCItJ2XS6VoWKK70jOvD7TGbRDtZQJzvHLJa852cbpWV+QZulFK9qlWEZftOlx/eLr/6NgUr2pPCvYwYerxE/LdHD91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IO0PEo08oPN0s2yuwSJSS+VrDllcxZTjezYGe+I+mq0=;
 b=SFoK6ln25L6eZ18WaJ6+HpfZmFCvWUPXMAdXJboJRHTu+aRgGIHOVTjXbMx4ZLsV+VR5urPTMj1KUbzy7RwofvaYpJIrd0CRQOsJvgXKUiuLMGadixCCoxGaUHye8hGO5bR8dqu1kwV0yBgv/9GmVHNsw+AkXFip2rK3VNYHbAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2097.apcprd06.prod.outlook.com (2603:1096:203:44::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 08:03:09 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768%7]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 08:03:08 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     David Howells <dhowells@redhat.com>,
        linux-cachefs@redhat.com (moderated list:FS-CACHE: LOCAL CACHING FOR
        NETWORK FILESYSTEMS), linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] fscache: some cleanups
Date:   Tue, 30 Nov 2021 16:02:51 +0800
Message-Id: <20211130080251.6068-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from guozhengkui.debian (218.213.202.190) by HK2PR02CA0142.apcprd02.prod.outlook.com (2603:1096:202:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 08:03:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0f5cc8d-b7ca-4e6f-78b4-08d9b3d7d88a
X-MS-TrafficTypeDiagnostic: HK0PR06MB2097:
X-Microsoft-Antispam-PRVS: <HK0PR06MB2097355E9917C33830BDA91AC7679@HK0PR06MB2097.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdWXCpHWWFa2PZo0SG1Tno0lH51kUNfKaPg35Q1GwdCGresyKRdu1rZnTkL5oPSmN2IUSbUJZOX1ddq4sul/CG/YayMUhK91UjsgzYCf60GPbFQe+Ug8ibcLd5afKP/AMQ02v7ngsy2eMQTxezyHr75jwxnGF9sOkvMyaPAhMesWn5OH+tG6SkqTefEWPL/GWqlu0RSWDBRCoRdGFbEZrq+pTj0SEOHbERGPRziJmzR9JIR2E4cRguf1TDia7NKLjuWdXviCBaRbLJzf7MGvNqWHcRLRZDR3mpuy2UI/yo9AkkY+ReBWCuBDoPQJV/pj/32WNUmOt30jPqRflR6POCyFZQccL3KqoLk+1xichVtp1cXYpOIAlqoomlNtsk3feq281nRmkvuSQEb7UeYsLeDO+hFAuHIbucWbfjfjGVmI76mWoK03Jupde55L4ELM6wxw3cSHWxda6IGG+LJfQHcrKi8fIbeMRiB+aSige0J2ehbHVmFbHcluvW/rmi3KHWUWWHfGY8Q0jm+Vw62X/CAwdN+GPghdTJ94MKrImr03Hwt7KIx2QlV3Xs44UPoPjXv0AETRV6ZaJYWPOO/bxHBtvp81o9voIZeDqgJpNK+D9tqpSH1WlY/ukZsyOmsDWOzNaxuN0qYIGrcS3LBHNzstCJr4kE/Pj8JPOZD++wVdEYZRPanWBLK0UnRzpcZSHq1L1V9FShH87A5e+GUI/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(36756003)(86362001)(6486002)(52116002)(2906002)(66946007)(4326008)(26005)(1076003)(8936002)(83380400001)(2616005)(5660300002)(8676002)(66556008)(66476007)(4744005)(107886003)(6512007)(186003)(316002)(6666004)(508600001)(956004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Too31c0FYMiyu4OjhDJwHb/GorjEOVaSmOPYouDQ0rSH/IOqoJzWN2hZ8VlE?=
 =?us-ascii?Q?q317ZrlFTqSqwRrq3apZmt2mGWf6Onm0kkhXsgfbiYXDtzLK9MuAu/JagWwU?=
 =?us-ascii?Q?wwVEPqDUvJ0aexdU5vdXmkhS+uVT4FYsA765iLs8cVaTo4IRDZuc7QYhaqBe?=
 =?us-ascii?Q?MWNb/sZmvkAojJkmCTs1PW0VQBcBpu9Yl748tsfHDkeCmVE6NGZVaaOpGo9w?=
 =?us-ascii?Q?kdC05NKYyIpMbeEHBcTEoc+WOieqTDAvVMs6tbvE0pwH+wBkySA5LnGTX/EZ?=
 =?us-ascii?Q?WWlSR8r7C2dFKZgcJHlKoXs3u9xXJDfroujroAV1Ki7DXuDSOO7b/RhEyI/x?=
 =?us-ascii?Q?b23nfokgX1wz7cTVYedeILW+gJUmOsS1rFbD/pxmMnPfHEMIdkwthOnwdeXH?=
 =?us-ascii?Q?azw80t2BhDZesxoqi77oZRrj6vXr/SEwCNBg3uX9BIa2EI8VoB//p1z0pwH2?=
 =?us-ascii?Q?ppUtP9mMc5jVs6dVG69twRZAMy9BMRm9YXmPml6911phuWxP3jI5UDPObJTP?=
 =?us-ascii?Q?rmu6i89hNQkTSLWAFiO2Fp/NDB0EORq4f57uIPbeINNkyslxABcPsSInX3xK?=
 =?us-ascii?Q?JDKkl5CIbRs/G0e7zjCMRhQQ+s81Y0BIdF5O8NRn3QFjrg5VbGam3CW+LtwK?=
 =?us-ascii?Q?zHD5YfF3TNWHgCBqEYw5Xjaec/RkSUTnJDzB+YcDQ8fw0m7PT+QiWSBJjOwU?=
 =?us-ascii?Q?AjVeZRleUzgABZPOPYq2bb2uWTvnrGLfQC8w7U4TDoq6IZWyEuScryzUeT0p?=
 =?us-ascii?Q?vrNydz1tnMaqSmWayEvv/r9jHhrY9A/LzJLF2gZyXFfQfOIEG88Xr1DLisC8?=
 =?us-ascii?Q?+4bZE0+e6/kZeWdpnY2sZb9kBbTajFO1SkayFGblR0ETl1wfaTL+xX0hxHte?=
 =?us-ascii?Q?gMYXr6L9ugCpL/XDmE6qkpkL+0H9c6Nqv/QquGXkE3EjCK6pAWAz/gBBbKWj?=
 =?us-ascii?Q?tQiEX9i37rYwrou3bxfJmGvY5KHoxTjR8Q7bLbHjJa4rRRxXw2HlA7IMCwcw?=
 =?us-ascii?Q?3usKLzi5XTAKc78a2jzzV2aG4W02i1PAZkUpU73U6uU0g+h5qgKPAVuMSZDI?=
 =?us-ascii?Q?zr3qZ98Fjs6UUOSoHatiSYoF4om2HcHhHWc6Ur43xO18SkmY6TR7+Aks2FX6?=
 =?us-ascii?Q?R75/zxJ66slk256q9E08qtl5lUViM6YIXWape8aLgmWDOyvV4Ha1fxy6+9fJ?=
 =?us-ascii?Q?vEBHP+cEMceNKd0+NURd/1dw+dwvq/VdZrCZNLdxoRpdqMnLcTHoaOK6SQDE?=
 =?us-ascii?Q?aOPJ4bOQafKKpEIdDSZkV+j+Aj4lRlpMgrfouzTRv6FQA1EYIbMPs3vGrD65?=
 =?us-ascii?Q?5pKBAHwED0lLcIwjFA0gaBuoIVI8RaLGp6HqUy2mthCD2qOnnaUv6ZJRf/+c?=
 =?us-ascii?Q?cMpHqf5K2EIcqOBxaPXAl6T52KoiiaNx3Ec30QOzajDSarTFH+HSUgFSukHf?=
 =?us-ascii?Q?IvCSI8dD0b2rCA+iAswNdVmVFIvSI/yc286I8WDhnGZIzBTUh/Y68mYzXxhQ?=
 =?us-ascii?Q?i12G4aFBds9xnzYsVPnWL06lOV77SgDV5/XCYPg4qWuyzBLbucjcKD13x3fQ?=
 =?us-ascii?Q?RtK15QcRxGmHS0ulpi2NoO612ZHl/M+mnsef20ziFCIqC2l1t/1H2MiTdocQ?=
 =?us-ascii?Q?nvg29bqA+A9iMdVFTH35MkU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f5cc8d-b7ca-4e6f-78b4-08d9b3d7d88a
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:03:08.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hq2iD0wlv2UChv+ZHYNDCHntk1pWMvR4nEo6ZngLWaSkR8v7yvDK2LtMEVjpnzezXbBJWOiS4p0SMSa/AP/Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a duplicate "#include <linux/uio.h>".

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 fs/fscache/io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index bed7628a5a9d..d6ae3145a698 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"
 
 /**
-- 
2.20.1

