Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BEE50ADD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443431AbiDVCko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245153AbiDVCkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:40:43 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DC34B43C;
        Thu, 21 Apr 2022 19:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEPJQyGmeoCI8rPkBqvFfyB2id0b2H3xTPyuCRQfqA5HmIiM0R6lagnvarfNVGbz0DOKB7hNF+2BOR0fDPmmsVRBuAqs43PjUYKkAO6xOZQdj6MIYg/YcYle5p+KQHRj9fKfD8wkASoa41l001OcBB3jdwVcM5yqxzu2Khb98U99irmw+0uaDXajH7xOOL6wtZwHAZ9H/ii2IT5UCjlq3FmUg1sYoVkmCshQOJT3neVICRkJgMFglKso9L/eHKKCA34RD+/WnKoag9tD6otfhY17agdqg1kse5rjyUGxro7+2cgvj5kkKE6cd7Rpcdo2A5uOqCj+ENsmBUCpYPzabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch2oW9CXStX2NYswOXomEzSEMwJKWVqWtZ5mRZfXcoA=;
 b=Mn+8ze5DQquerwJj9sDYtsnlNQ4O3EigtOeg/AJc0jhftnFiLoKe33v/obbVA3xQ3DL8xnb/9dnhmXWHJBsav2DPJ2LAzXTlVEIBfOQRypU05RJvIh6/o9KxDOgwC4uQNObkC6PC0zDIX3qw3Rkm3H+POowtyU8Fe/WgZJna3GVQmb0SRx9n8ALjRk4HrSFOSToZxzBy+k0gfckH1pRq6SIEUaU98rhHcBIzAni2vrgjH7DMeLAE/xa2+FL0tuXugO2H2wwipV/2t8sQAPuKmQmfaE4Nn3DvIFI8YS6SRiKTLCT6OXn/ndZnaACDGX/0OQpuB+/R75MzboDHEdd5gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ch2oW9CXStX2NYswOXomEzSEMwJKWVqWtZ5mRZfXcoA=;
 b=SF3sbkiYAvabPnOefqaOHE8mQUF8g9HjbsqyT6tJiuh2w3V1vCjvTqZk8Or49Und17H68+/g5csOqZwhsmW1szGIWKZxe+has1/U2MpwoeNrEyHJyLI8g6pwUHwj6wVapy8aXw11xwWuoechOefgBn5Kf8UcmfjrGL0xyda7eiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TY2PR06MB3375.apcprd06.prod.outlook.com (2603:1096:404:96::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.25; Fri, 22 Apr 2022 02:37:45 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 02:37:45 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] perf/x86/amd: Replace snprintf() with sysfs_emit()
Date:   Fri, 22 Apr 2022 10:37:34 +0800
Message-Id: <20220422023734.129114-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92935aa9-b484-47f1-838d-08da240914b3
X-MS-TrafficTypeDiagnostic: TY2PR06MB3375:EE_
X-Microsoft-Antispam-PRVS: <TY2PR06MB337522DFBAF843C71D780274ABF79@TY2PR06MB3375.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIsgSkS7Ci7bqmhoRKy+Yp4rNRoIT946ZkQ1V8D4M7DWjZDO49XvKRx1NjGqUkRUs97YZ6eZBCdZ2mrA+ipQDxbsXnIaYtZ5xuDswEWguPKBfLx4vIdtNdJ8HVsSyVZOT/hKVavwvdYknu1TUCzkQFXtFh9v6AFA8W1WJlyBe+o/V7eIdgxQJPOVsLiPd42oyxMU1p6cwMo+aGmYGjQjOIL+7/HoQOzj4RnVrRxTISzMvzrd6zTwyN9/WkCLks4TqAf8uFCdPXMraL0g+MQ/UXAacoIYmwasvgHPjXH+nas/rYdHz7sf6KE2YVSJPat9mrIubhuNaPiTXDsAxOx0dIRWqxAq2v6VWoNm6BlVmF3kobD54aXbGlRLIlJH7iRZOlCCthfHGVwquRhPlVsIX5tbmnWUdR+57J42uPeR+X9bykRrwEu7hdoON7ylAApMcq4VkQuet6DCA+Bfn1YSW6BwJoW47V7rCZB7RBRgNl0oMRycTvPuR0f4ANE6PXorJn8WmpISjIg0JAiDORp9/P1tIa87myFvz61FhD8XNLHmLXXyXFystEHiasHIaIciC/T4j5RbHL4vxebN4TfEWVQaso6PSHubZhN89P/+0Owm40MOCv8jk5crUQiRNM0MXLwwQqJiitgTy+AEOGt8v1K4HW6zGhH7wdBq4BdTUoAORqM8nl+jsHp0ljAjQkRX4x9MzJoVLfY+3144/2hocxVrvboz9800j/Uw4U0vE04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(52116002)(186003)(5660300002)(8936002)(1076003)(110136005)(316002)(6506007)(7416002)(2906002)(508600001)(6486002)(4326008)(8676002)(38100700002)(38350700002)(107886003)(66556008)(66476007)(66946007)(921005)(6666004)(2616005)(83380400001)(86362001)(4744005)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKpmWHsIx3XBpNn0ZzjlwZpTf9RScAhLvFrAKt6alN9X3NqTWUsVe+okhFKq?=
 =?us-ascii?Q?2HJlestU+3ycvsaPrErNRtUbpm9hN5SJnG5vCDWy1ZC+ZrtBcbRCk43ACZrz?=
 =?us-ascii?Q?HYI35d2ozJrGQ113VdjrkabWrcmCARa+s6m09KX71Au6neAoQFRIM10qg8xP?=
 =?us-ascii?Q?l8Erp+uo34Wy8XvB/Q2XmlQFF7220Nn1AAt4WC+1STDiqgSEHImPEYhMjGSK?=
 =?us-ascii?Q?gKbQvsfZX30i31WOFS8KFsb/lPY7GfcipQx477KKjDbSIrDWWX9yrkDBvJst?=
 =?us-ascii?Q?G0u+tlNufq2BLLPTqdOCqX3j0FbdejPzezd5tRGT6Z/dq9iXJjVqGWcW8UkP?=
 =?us-ascii?Q?b0mTQ6/zTDN1vJcMkbfTgtSMPiFWTmK2IsHPtmspOkNZhReqNb8aFdYaWrgA?=
 =?us-ascii?Q?WlvhKsmdbCNQH5oYGoyotLbmuxLI9INaBBA00Q2uWNAEb5InJlqutb7dLFdO?=
 =?us-ascii?Q?Vm9L3mZeQSb0b+yPsgJXn/JUFCVR/FdctBHhVu5kG1Vukdlp6RlnmX+6u1kv?=
 =?us-ascii?Q?tS23LnPnmNyzF00Ih4BuPZGNFbbI8XIh/dSHKevcNXtWqQR2QWRcFxe44Obc?=
 =?us-ascii?Q?0Q64q86/+nuENwD/ed8VKBYtyJLfKXkqM684p/cPfUOXCYbXa/uO9OGNbi8p?=
 =?us-ascii?Q?c+fSzDYJVgxcBPXCVw2GYlS5499Fue4Mi1fmhi6oEMAPogRkAKSNXLWNOijh?=
 =?us-ascii?Q?epMHDpM9Fz4OlpYJplpRLtSr1xaNA/coUDVIXi0rKH/OgGcs7XjkGD59qr4j?=
 =?us-ascii?Q?TnB8H5x63T5ReT+TgLyrnjMDYk4MB0C/SJIAfMDJ73dCAed8TgdwPwyRa5Nj?=
 =?us-ascii?Q?SUiRGsmaoUIBfubNYpOICbvmp+wCM6U9CLUFdTwwsHQ9c6OzleQkrYyqpgxV?=
 =?us-ascii?Q?N1n+MHeJCXGcYtZSPCCGZ4sWLtYtdnX+MwxgFsSeF7v8x+sE/TncJEcNfM2I?=
 =?us-ascii?Q?n7FVCMH1Pg6L2FkKSWa/tGtDgxrm5iFwFfilExzX8Na83oWxvLUd0O8Y0YGf?=
 =?us-ascii?Q?ufUujUPUjuq7Mf9Hu/ocOKwCnwfKf9q3a5UvuOq18+n+d/496u8lB+NEYHH6?=
 =?us-ascii?Q?N6Oc8UGiMP71LJENiqaSsMvD3nkvyPumwddAhE/ba1CAE18kEFqbveCh8y3h?=
 =?us-ascii?Q?FcEg1hQBjE/pEgDVyj5w688R4hCOKbLUdOrLN08uWcY0JTEfZRYRNKHems4v?=
 =?us-ascii?Q?PvYIImili2DN5BP5Uwpd3gPAlQYKjzEMMiiwrXI/mLjo7SjaLgDfreT++7aO?=
 =?us-ascii?Q?lz5EGYqjOhoBUTeOv+yXRptLxWVcA7sqAf7GMFyYoz58lOQAkYB7gN+pz5p3?=
 =?us-ascii?Q?1gB8B3yLrpgokdEMvR6Vt2dq34NDwhiMULlBCIlDG6tdmpHw0pJ3iukvD1Yt?=
 =?us-ascii?Q?+mE3gwPqbTvqQWnD4TEtBYLlxcd7Wuj9dD9EcSXT0NQvOC01A7/QwMymldxH?=
 =?us-ascii?Q?Cx9JIvQGqYAujCatb8AWzqB8NdaOTrUy/096749OVBt9BBkUjaMa8CqU3GML?=
 =?us-ascii?Q?SvOJ8MBPVtV5yg8kW6q3x5h6W2XItUPq9Zmz8iu1tRjRNQwpdDMA9SHfXV5D?=
 =?us-ascii?Q?SLZSYxZcgyj9o0+5mH3rs9kOAvX2N/2H+giBNakpt7RGtmezWaMiJmHLOp3B?=
 =?us-ascii?Q?bzXvYd7/uklX3jZVoa5041WFV3IjtZv7Q3c8SrT2lm1BhIYT2YpRDb0zA/Em?=
 =?us-ascii?Q?CW1EQc/toYEqHjSZv2vJoDvx81YHD7hOgXhrveb0XdQ8tetHsADlSlhgEA/x?=
 =?us-ascii?Q?kM+QYsg1NQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92935aa9-b484-47f1-838d-08da240914b3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 02:37:44.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sU7as4HSJHjq25Uhk7lGUEZHdOg0+3yq/SE0gWHxQ/74DZjGjV1BISypeJ7fjvVyrpcR5abm7AOBiJRsTgihJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB3375
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
arch/x86/events/amd/core.c:1127:8-16: WARNING: use scnprintf or sprintf.

Use sysfs_emit() instead of snprintf().

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8e1e818f8195..c1ced265c824 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1124,7 +1124,7 @@ static ssize_t branches_show(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
-- 
2.35.1

