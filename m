Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594BF4974DD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiAWTBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:01:50 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:33152
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234863AbiAWTBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:01:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcQAUI43CeN5MKUTdwA6Qaa77rm+4fkZ5IM6le4K1T5RJhIS8rSLySeqmASy6eDSw/B7EjIvTeTfDB10gff03iSxKHLZ/XiWT0LvvQ/8DwV8kGCJ+9jGNPfydTJCNrbWn9XZ03iE/3E59Cg1ldIfv1P97KXm/2e/wjeYmTeuHWHNCLSYWvG+hxI1W3mGL10TeEE3l035WxwalaVIqYTWNQan5U16ofIoE4GpgbGcWkniX+uEZShMShDk3reW5vBPQ4SH/BK6Ui3hRiLIDqGc+f3kWRx5SKmTUp+/4+k7QJyknbJFonUdRvY1lJA9O8c8/V4ZPTz7asILnkkCzeoaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFQpbrP7ACT0+u3PZFyi9v+3R9NztBvcPaYwDUZ8Tc0=;
 b=hHBCY95HmoqrbjxEqqVYaAfff/4P2Btw0tj3RWabs80WhCv4BzOCVMcMhweH5FpeWLeSdnmR7oXjTeUOJMUf85UfqwoLY5xW6MHzjvUQioWTpyBbz9+igTU5cxdbTzy6dUQQSTmDyi5Nincn+xZ9q8xKpMofSkc4zz1yURyhO/Ka5ZxTZOwAQ8zarx5ICIX19od7NEY7qNr2EXecI6Re0zVhiYyR2ftH167sUPE3XAZWXV5VMJfUnoOpz/0vz3iScQMpLMZ4HGwjCZeg65zZQr7SIo5jVg4ABD6LKUs+bYgWd+I8ZWmYM2Yho8paFVLRAMwQ5v+eguAMkPZeb8T/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFQpbrP7ACT0+u3PZFyi9v+3R9NztBvcPaYwDUZ8Tc0=;
 b=pJb19aSXwoKVHkwxCB+CLREhydQ4IDrYvfRfQQ98RvQeLUMznBMW0AqTj74Mi0GLwZDQY6vGVMWd7NgFmIO+bn6o5/7XX1xVTlKxQuUFomh1PW4u91+Je9jwDYCUI+85Tbu3uW14ci/91PIvLR1mv14RHOCgzbDjXLur/SYO2n0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com (2603:10b6:a03:2d3::16)
 by BN7PR08MB3892.namprd08.prod.outlook.com (2603:10b6:406:84::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 19:01:35 +0000
Received: from SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::e8be:49c5:397e:d3ba]) by SJ0PR08MB6544.namprd08.prod.outlook.com
 ([fe80::e8be:49c5:397e:d3ba%5]) with mapi id 15.20.4909.017; Sun, 23 Jan 2022
 19:01:35 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 1/2] mfd: iqs62x: Provide device revision to sub-devices
Date:   Sun, 23 Jan 2022 13:01:05 -0600
Message-Id: <20220123190106.80591-2-jeff@labundy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123190106.80591-1-jeff@labundy.com>
References: <20220123190106.80591-1-jeff@labundy.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:806:6e::9) To SJ0PR08MB6544.namprd08.prod.outlook.com
 (2603:10b6:a03:2d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a705ce3d-47de-4ccf-f6ec-08d9dea2c703
X-MS-TrafficTypeDiagnostic: BN7PR08MB3892:EE_
X-Microsoft-Antispam-PRVS: <BN7PR08MB389298AF1760169F8D4BCC0ED35D9@BN7PR08MB3892.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ye+HwHJ54Y+6yjXg8vQgGmQ3mrQCZbQndyFKXUd7IhlOjrTIsfrp4FaMRMkq1jgqpcgErOqCJsiFNxAray1V4JUuj9VAbsYzGYsUtrRqEGIZL1ckTfQT0jXBoHqCjamiqyrrwat6+4hEPyW1EnsRy18z16wDKkuAlg01mLpmax0BTWXWlNv0VrY7teFF/FuV2LCcdEkqSuYKm5pXwBLx4zfc0MvClVMJ2yGDAA52CrfV8P6GEa6X8sDBYWUL515fDVYwakxubCKdsHn/p4sJxPuDwpKnD036S1D9MkujMPTY4YyC/6DYktgMKewkhOgR1Ee6cZ/Ga41IQjwx/xLoWugINdlflojK1j55vw7FtPfbGgyfkdLAovm4vZvbyugfdTUBKMhbukpILjg+fq/C7OSbYgLiyeBQ/CBfqyrGm9S2/puB3trUS8RrDwDAJNjlGfHO9wWYqXtZIM61D4e3xdZc3mXXycRHE5A+RQlBxV1PSX03/8orPquxWpUY1/nKNxK7mz122tmrWBT+LjJXn5bCAyDECgBUjWZ/+kA//AdgJf3yN3pJeagG96CzVI+cr4nT2ZymuajJFQT1UwM0My7hoyBHaV53FPggENIeLf1oDwssLY/eTH1JGrnZIgNGop3Nv+6Fmw+X8p2kHwAU7zYzKj6z/Wgaeqc+rO/X4PHpgmWrdLkPKrOCdRBkt5YZP5LGr0BvzUZiul3c7pzDNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR08MB6544.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39830400003)(376002)(396003)(66476007)(8676002)(66556008)(186003)(1076003)(508600001)(107886003)(6486002)(38100700002)(66946007)(52116002)(5660300002)(38350700002)(6506007)(2906002)(36756003)(83380400001)(6666004)(6512007)(2616005)(86362001)(4326008)(26005)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcDJ2KZKlzU0RdluXhe/+TlyultbkmG0J7dgGr6cXKrK8k3CNtVDEByaSpOy?=
 =?us-ascii?Q?7LnRJCvfgSk4W+H8IfLWra2MEHgSQ6CUJwk0pfa6e138ewrDj33Oc58938D4?=
 =?us-ascii?Q?OfpWiOKql7f/2B/koQmLmXr8AUYRxKA2zKje2KFTEnjDXBiDdOrVD4lLsadU?=
 =?us-ascii?Q?TpuS4wE729cJIsFLH7ksqYpju5BQQv+xhZk6eoQuoG1XXdNtwPAdP7qVwIAd?=
 =?us-ascii?Q?VXc0kRtQB/n3GIr4q0oq0dq4dKWMrwgv09ysRBxKAXWhNZ6lDBVe2dsElzmC?=
 =?us-ascii?Q?Zf4gMicEqO/nvR8mhKZPqRAhiKg866GFG2o1by/D3TvPA4YNivoVoUNiqIzl?=
 =?us-ascii?Q?QWSLSKPdubGt/whvKpuHPUIYwAOJbCEsQiwgrsDdfuDrLVdWg98ljk7w+xTw?=
 =?us-ascii?Q?Qm8RegSWAfnYH6Prvlt2EUjgPeJe7X1U6cIWI3+wWxjMYcsZ0oq91XymOHu7?=
 =?us-ascii?Q?Zr6LRbiuw5CqVD1oGj2psKMhv91joSDLMTnav2eDlNrgjPzKToMcTEomGFm3?=
 =?us-ascii?Q?8ZusMvMacMFUzlXBl6xep8r+8sihd9KBSTTUyxwuPkMVm7vheMErnZYLh69B?=
 =?us-ascii?Q?kVv6CdZXefk2jxRoa3oq49W53f7Tjk4+Irrg51lkwcWQ//3+VDgCBMDq3wva?=
 =?us-ascii?Q?ih37sjHpEOTG40ihjDf7fRHqlnFehH6xE1YD9wJM2IaUvhFMzNnND8thkcr7?=
 =?us-ascii?Q?uUaRluTwY0xJItaJ5/T+hRzrl0BcOd6aF7wwAJbj6GQWAMpB716mbDH1531J?=
 =?us-ascii?Q?peeFnHmW7mHBQTp8Vy6x83Vigdi4FytkifWr8J9BWYk2cCDS5kX/IRjC6UF/?=
 =?us-ascii?Q?w8294c6JkYCNxVXybUdwweLLxu21Bu+3I4X1Bu3OKOLaDNWmDxYUcMOhp9ur?=
 =?us-ascii?Q?uqzWiivUHqF+SBrJ6QHwg3fBWVtFX+QRm62QvVpJCzNwAnolLtpFAyhY9LcJ?=
 =?us-ascii?Q?22qpK9Ck3R/OLAhcygEHvwc/ICemtPwPiyzLvfK9cfkjeieOnh0GZLmPYM2R?=
 =?us-ascii?Q?X8idCikEq5K4jZDEwSs3jwqTxvHKwbgzvpo1Ncr1Dd6ClZp9RbpRH+MXCXQp?=
 =?us-ascii?Q?Q7iA5EgHicVu9WZUT83FxurAaUP2Tla5RgiB3qE+Ka5pdRePsXhplYt24O4a?=
 =?us-ascii?Q?8yScQ4h39GgiHBQmnsTqL/z/qi1jq2OXrSGCDnSal2hgGGhhHidqlwyhyN4a?=
 =?us-ascii?Q?gdiE7Ac4Xjlhn5ml38grVQNyn12+W2KTjq4cpDkyvws/01B+tAKN5Wv99s04?=
 =?us-ascii?Q?lLPDUViJTcOFh+YNZduclrruvpUY/ostXaKO7VkxKnkK/199mJRSlNI/3yjH?=
 =?us-ascii?Q?F6mHPX9diEP4jRo+SfNtL0nzkmMQZLk/7GDKGXiC2hz45xqFaYmOq2Yxjl2N?=
 =?us-ascii?Q?1IgzIc0AFoc9YQOzFNsortHX3pIOGfiLrcrzxVH8YqRtYPoQfD4Yw/xm7YDh?=
 =?us-ascii?Q?co7Bo1k3GYKTtayu4iCf0qVjxOGN+6qpvcLnyNXrLQj4O1UX5RZmHED3nRZi?=
 =?us-ascii?Q?/q634oUIX+2xActA4bZUdrvNIW8znYiffFMJjw0TKOamxBillARwNceRzVpX?=
 =?us-ascii?Q?ezTX9tbR8GZsI9BUFL5tzoDytdnImAgY3AM+Eki1aaiHqSO5CT0qYa6+niXy?=
 =?us-ascii?Q?R2U2h09IgwjNQPVAh+i1t2Y=3D?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a705ce3d-47de-4ccf-f6ec-08d9dea2c703
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR08MB6544.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 19:01:35.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHDkBZ2qNcyFl1sNC8aY3KJuCNDKFN3xSnKBOyBA2sMLWQMFTMBwa8YivR5GJp+YLHlA1I238ynCiYYghUF0IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB3892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Individual sub-devices may elect to make decisions based on the
specific revision of silicon encountered at probe. This data is
already read from the device, but is not retained.

Pass this data on to the sub-devices by adding the software and
hardware numbers (registers 0x01 and 0x02, respectively) to the
iqs62x_core struct.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/mfd/iqs62x.c       | 6 +++---
 include/linux/mfd/iqs62x.h | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index 9805cf191245..575ab67e243d 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -898,7 +898,6 @@ static int iqs62x_probe(struct i2c_client *client)
 	struct iqs62x_info info;
 	unsigned int val;
 	int ret, i, j;
-	u8 sw_num = 0;
 	const char *fw_name = NULL;
 
 	iqs62x = devm_kzalloc(&client->dev, sizeof(*iqs62x), GFP_KERNEL);
@@ -949,7 +948,8 @@ static int iqs62x_probe(struct i2c_client *client)
 		if (info.sw_num < iqs62x->dev_desc->sw_num)
 			continue;
 
-		sw_num = info.sw_num;
+		iqs62x->sw_num = info.sw_num;
+		iqs62x->hw_num = info.hw_num;
 
 		/*
 		 * Read each of the device's designated calibration registers,
@@ -985,7 +985,7 @@ static int iqs62x_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	if (!sw_num) {
+	if (!iqs62x->sw_num) {
 		dev_err(&client->dev, "Unrecognized software number: 0x%02X\n",
 			info.sw_num);
 		return -EINVAL;
diff --git a/include/linux/mfd/iqs62x.h b/include/linux/mfd/iqs62x.h
index 5ced55eae11b..ffc86010af74 100644
--- a/include/linux/mfd/iqs62x.h
+++ b/include/linux/mfd/iqs62x.h
@@ -14,6 +14,11 @@
 #define IQS624_PROD_NUM				0x43
 #define IQS625_PROD_NUM				0x4E
 
+#define IQS620_HW_NUM_V0			0x82
+#define IQS620_HW_NUM_V1			IQS620_HW_NUM_V0
+#define IQS620_HW_NUM_V2			IQS620_HW_NUM_V0
+#define IQS620_HW_NUM_V3			0x92
+
 #define IQS621_ALS_FLAGS			0x16
 #define IQS622_ALS_FLAGS			0x14
 
@@ -129,6 +134,8 @@ struct iqs62x_core {
 	struct completion fw_done;
 	enum iqs62x_ui_sel ui_sel;
 	unsigned long event_cache;
+	u8 sw_num;
+	u8 hw_num;
 };
 
 extern const struct iqs62x_event_desc iqs62x_events[IQS62X_NUM_EVENTS];
-- 
2.25.1

