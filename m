Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059A350F89E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346339AbiDZJHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346409AbiDZIpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:45:00 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510971632D4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi/WpSF9edGwzy7ITctYbivChfQ6sMgFM3GyVo1sKz1vXYZHXFhylEz8EayZVSjK4uZwgAqOULle5VGGrai1J4/3qHOwwJInZhzlYptJazsAMtMO9Mc/yp5lncDaDxW1FVN2ypp8W8GWA5ksH0t6nD0I/pHLphyw0YuEjbk8D6DGoxoc/rfIo0mzZ9O1oCZURGkTaVLw9fN1ZKvbAk75VVolCqigk9+/habJ5I9o0ZhR3/1ElMrKBbXqKTrRIZJ38QRvlUcHgDBTR9PqDr3MhmqhPxxLtpDT1E4u5IXs0vT/DFEcIQ0lnJphmyfTIVjsTBsYjturtUrJQmGREflU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMMuXU2HHHcrjHUqwsfAiJ5UDXbOqZQS4ZuRm9ptB3E=;
 b=QKgUWsbQuEpdXU3dBCl8odrpZhjkIF1qNA8Lo8Sl7fP+7cCsPmtxO4at6FyLyUq7QGNV6s/AIFvRAWm7VHTVvi059Y3gLlI1k/hJXJ0dQ20CbULPj7Jy1xZbFba6q4NzID/Us/8vVpPsJAFcphEL8gfv/SIAVccefufza2cNiUajGld6d1Rp5ZtqR/YsT3pwV2wxzWR8R6FD5ukLmcmgsIUmSu82LV8PHOGXuryRI33AvzoMVD57myo3oA83+BPzOtBP+vrF2k1F9/E8O1RFMDUDOVuSLQsln1uF1yZPoDmuPOuCKyxtMVxh8zH6xmARJvLeAudt5bEpAFWU9MCakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMMuXU2HHHcrjHUqwsfAiJ5UDXbOqZQS4ZuRm9ptB3E=;
 b=mQHMwQmLDYfwLvtPY1NX4hP3TAgKebIwJml0fF2Z6XMdiG9HxSl3ZnTeWl6XvMyJxtg/ILP3hPWofv//i8CK6NFNvlKUpWQRIsekKR/zcRlHnqNrRfcqaMnNUnfARfF1j5x+15D1T4CRUQrvioldzwqVf0Nx3H9PEJbyTZx83kI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by KL1PR0601MB4516.apcprd06.prod.outlook.com (2603:1096:820:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 08:34:42 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 08:34:41 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Haowen Bai <baihaowen@meizu.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH] drivers/virt/fsl_hypervisor: remove unneeded `ret` variable in `fsl_hv_open()`
Date:   Tue, 26 Apr 2022 16:33:13 +0800
Message-Id: <20220426083315.9551-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:3:17::30) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f512449a-5e5f-4de7-7712-08da275f9bd1
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4516:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB45167DAF21E7B123289128D1C7FB9@KL1PR0601MB4516.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKHh54rCupCnof/lXjLAqit3vtCnSLF/wv5S9uN4lNLOw1xIDNW/xGlhbE5ysGF0FLkPhAI6NTeBjLQWyI1hmJ/SnT1Whx6+0Dvxr6fCi1OgpEySwwsLTFd1OOGGwYnwSieykn2s5G9rlhegvep4CvG5pR75OctQtGWZcoQ41nJGOE7/DybTDptu/LCz1N9SJQaSfYkWxNZpgmwls482oXevRt4aRmOQ6gEfwNqr728y9nRBwr1p/u8fRzUeC9vq6U5NhcK8gbI9Q2dHPxURVCAUCgEdPslfigUCoOL/y2+GGwVzNNL9A4wCvlq/KXM1mQ3SR6aCWf+0s8/eCJKYVcjHoIzLWKTumUsPVEPztfwDXukXRpcmY9qvX1ntQxRJiY8XGA9TehBBY0fTQqhbo8bDYscWtvTllS3TWaFpvpogl91/NOw7hwUiJ/MJM2O7n6I1amE7/tEZu//qTtqShiZ0C9Pv8j3SXpn2EoRVK6ap9FKJTM1Ym/9u60L1fqqc4Phefzcn2urVXgZfFs7ImQ088ha5MiYRWO7vAJ1TtPRwDsktaYpWlVc+0UnDDoiwlwbIuPpwgLpsitOXcWWLGSBFldNhmlENXfj2t4LLfb3/ovq9FmqVoOpch86MqCs7Lwpaiirc58+RWeWtZcQH9cEPo/8EyMkE98VbCN/b+Tc3pw7ZNATCxMBbObqj71Hlpu+daMIA2wvENac25AZ1C+xxlJ6s6q5ua+B1noC4Aqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6512007)(6666004)(38100700002)(4326008)(5660300002)(316002)(36756003)(4744005)(83380400001)(2906002)(6506007)(1076003)(26005)(38350700002)(86362001)(186003)(508600001)(2616005)(8936002)(110136005)(6486002)(66946007)(8676002)(66476007)(66556008)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UNgn78VvH6EGYiIepItuyhUYB2HJqz30esqEqFK0KQLfQv0rNZL10YySWtxy?=
 =?us-ascii?Q?b9WS7x8sbTSztP3IGysliTSdhzjU2H4x6TKXPC2JQXys4Sjbm25SzQ5azy+o?=
 =?us-ascii?Q?uOuYOR3Pv5njI+vt+mxpXOkd6oMD5iENKPBqlxtzOsPu50OwMcE3zKXbTR6a?=
 =?us-ascii?Q?ocxbozk2iGj0A0rTi71zzks4H3CTy8uwcbi5Pcq2uiIqi7Fqr2aRl+Qsb0TF?=
 =?us-ascii?Q?Bbc2wEQKkqLe6T2rVMi2MhxIjzv0iRAsPjQUBnvHTwsgmzhbFfcHcDXf/Fee?=
 =?us-ascii?Q?YbuMwdfQWqGytGBENQDUbQEx+ApAegvAKtr3pu1RwqvyiKfROtVT43qdhS/E?=
 =?us-ascii?Q?0lsL0po4aVYXCAj4dZqWL+fSzS+BqVO96/2hpbewSPA1saj7zTvmH77GtvE6?=
 =?us-ascii?Q?HeiYnn7g5UALasufcDLmoD1XLyzU+x9Fv23GH0Ca8rFwMREZwFsrUUKNPPhI?=
 =?us-ascii?Q?y4ru/jx/0HdQ38D5+6q1ftHBNt0uEOhD1RR19PcxUgXVEKxq0fL0q/ju5Enf?=
 =?us-ascii?Q?wADOLSTmmE/pGIIZBIqbGnVe6cY/bORaKwXpaGqQGJPH4vPhUOwl3+RPsGkA?=
 =?us-ascii?Q?BEYmn/DueYtQxfHQEYDCYUmQ4ykhd6sc3OjZdtNKkL4syqzs0UYPpyGdhdKQ?=
 =?us-ascii?Q?TCvlcFy16b1IO7/6ycw9JBzSCVwP7zP3slxFwc+Ia6dxf9PUhmE7znoCsyVO?=
 =?us-ascii?Q?qpZTcBwo7JR6Js0sTB28PVfZDxHJdqHjnrxtryRgzIyjMVc6dcbgw+4374cI?=
 =?us-ascii?Q?9WvBQMOTY914Fmw7oQ85hUIcfd/hRKHdaSob+rpyn6HSmzO+0WYTGYlIbIGm?=
 =?us-ascii?Q?UGh9k5VQ7sqzz5fqK1agXlHKvnVnUwa4jk/SrDTpxUwruj+7vhyostsxbjZw?=
 =?us-ascii?Q?e4rRZffDBKZEopjqcox1MoEI8Mqj6bW1zlosoaAV2agDcCDKYg1YbVMO+DcH?=
 =?us-ascii?Q?Dk0gPU+Ah90ySR3PgJ0qNWKbE2dW8vB8oYmDx1qkGcKe6lCk8z7UMYxHpEM4?=
 =?us-ascii?Q?E1lNmpKAWGOUC7nSXdm3Q+7N2hDo/LURSuU5bdbwKFptjbYvhKBDJmRYG/7j?=
 =?us-ascii?Q?rWoW4rcX5DFtnY5e+2+Ro0AMsbrE9QshHg5yMRPGZEBweSW51f8EynLSy+v0?=
 =?us-ascii?Q?OnZn33O6hU+/UO8LRz5oftpDrJVZ+gvyaJwwsOj0Zscw+3oBynnbocpS6FLK?=
 =?us-ascii?Q?JA/1C63OzMeggsog4EcVHf33Ad+Ksayk1z+2PSgqE7Xo60Sno3hykumzsQcf?=
 =?us-ascii?Q?DYbGOL9u40nnc0sPV2qQ/TU6x4c0LU+DnyOegUE4mhBgwsZBck2hvGIH9Tmz?=
 =?us-ascii?Q?wq7bzsZG8ocbOdglwOpyh1nFLQ0VFCo2+pItPc8E278c21l43YyIAiWXkLh2?=
 =?us-ascii?Q?ocmNL0GruTsohuEjugeen798VvuMW3jImppKN0IdW4JgLN2cfPT30H1xYhDX?=
 =?us-ascii?Q?5fuIbfz14Fyp6D3x+2fGg4yo81cZKRSkeyXoAewBJIuuSd2rWyvHGR3gf7yH?=
 =?us-ascii?Q?+Cr2OMKai98XCyU/s2GgslFlZ8Ko1xj9847BMEoY43VHFrLmTYlh5o7OPHqq?=
 =?us-ascii?Q?Cp7pUSy9AoJRvAUYMuRNmL+3gQMHfXJr2OJbtv/YdC6ZLQmH0SCwJpQQA6dx?=
 =?us-ascii?Q?+0474E7SQhwOpxQt76VwPvsNeyfyscuX/qPRga6VEagK2StJMqGJUPWnT63n?=
 =?us-ascii?Q?rkZdJVg057nTaUGcZt71Fot6PNt7OWwAyXwoc6uogLhUNXGmJL1bSR7h1hwu?=
 =?us-ascii?Q?d9XWgPCRsQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f512449a-5e5f-4de7-7712-08da275f9bd1
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 08:34:41.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5XQnHA5t13IKxXf7S2kIfxfMlNeak+bH0WF9Yx/+D/zuGY9fBzT5Jv4yrFxfI/K4QtOWvaOlGy3BtP3X+zYPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4516
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/virt/fsl_hypervisor.c:662:5-8: Unneeded variable: "ret".
Return "0" on line 679.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/virt/fsl_hypervisor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index e49bec8bc8a4..07035249a5e1 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -659,7 +659,6 @@ static int fsl_hv_open(struct inode *inode, struct file *filp)
 {
 	struct doorbell_queue *dbq;
 	unsigned long flags;
-	int ret = 0;
 
 	dbq = kzalloc(sizeof(struct doorbell_queue), GFP_KERNEL);
 	if (!dbq) {
@@ -676,7 +675,7 @@ static int fsl_hv_open(struct inode *inode, struct file *filp)
 
 	filp->private_data = dbq;
 
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.20.1

